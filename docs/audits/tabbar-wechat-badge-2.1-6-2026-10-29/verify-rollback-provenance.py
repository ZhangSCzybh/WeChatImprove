#!/usr/bin/env python3
"""Read source only; write evidence here and content snapshots in a temporary tree."""

import datetime
import hashlib
import json
import pathlib
import re
import subprocess
import tempfile


AUDIT = pathlib.Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
AUTH = ROOT / "docs/audits/authorization-cleanup-2026-10-28"
TAB = ROOT / "docs/audits/tabbar-badge-fix-2.1-7"


def digest(data):
    return hashlib.sha256(data).hexdigest()


def load(path):
    return json.loads(path.read_text())


def write_json(name, data):
    (AUDIT / name).write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def reconstruct_delivery(patch_bytes):
    """Apply the stored unified diff in memory, verifying every context/removal."""
    lines = patch_bytes.decode("utf-8").splitlines(keepends=True)
    cursor = 0
    rebuilt = {}
    while cursor < len(lines):
        assert lines[cursor].startswith("--- baseline/"), lines[cursor]
        rel = lines[cursor][len("--- baseline/"):].rstrip("\n")
        cursor += 1
        assert lines[cursor].rstrip("\n") == "+++ " + rel
        cursor += 1
        original = (AUTH / "baseline" / rel).read_bytes().decode("utf-8").splitlines(keepends=True)
        output = []
        position = 0
        while cursor < len(lines) and not lines[cursor].startswith("--- baseline/"):
            match = re.match(r"@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@", lines[cursor])
            assert match, lines[cursor]
            start = int(match.group(1)) - 1
            assert start >= position, (rel, start, position)
            output.extend(original[position:start])
            position = start
            cursor += 1
            while cursor < len(lines) and not lines[cursor].startswith(("@@ ", "--- baseline/")):
                operation, body = lines[cursor][0], lines[cursor][1:]
                assert operation in " +-", (rel, lines[cursor])
                if operation in " -":
                    assert original[position] == body, (rel, position)
                    position += 1
                if operation in " +":
                    output.append(body)
                cursor += 1
        output.extend(original[position:])
        rebuilt[rel] = "".join(output).encode("utf-8")
    return rebuilt


before = load(AUTH / "source-sha256-before.json")
after = load(AUTH / "source-sha256-after.json")
build = load(AUTH / "build-inputs-before.json")
tab_baseline = load(TAB / "baseline-sha256.json")["files"]
patch_bytes = (AUTH / "cleanup.diff").read_bytes()
rebuilt = reconstruct_delivery(patch_bytes)
changed = sorted(path for path in set(before) | set(after) if before.get(path) != after.get(path))
assert set(changed) == set(rebuilt), "cleanup.diff must cover every before/after change"

reconstruction = []
for rel, data in sorted(rebuilt.items()):
    baseline_sha = digest((AUTH / "baseline" / rel).read_bytes())
    reconstruction.append({
        "path": rel,
        "baseline_sha256": baseline_sha,
        "baseline_matches_before": baseline_sha == before[rel],
        "reconstructed_sha256": digest(data),
        "reconstructed_matches_after": digest(data) == after[rel],
    })

current_bytes = {rel: (ROOT / rel).read_bytes() for rel in after}
current_sha = {rel: digest(data) for rel, data in current_bytes.items()}
current_mismatches = [rel for rel in sorted(after) if current_sha[rel] != after[rel]]
scope_files = set()
for top in ("Controllers", "Headers", "Hooks", "Tests"):
    scope_files.update(str(path.relative_to(ROOT)) for path in (ROOT / top).rglob("*") if path.is_file())
scope_files.update(("Makefile", "control", "WeChatImprove.plist"))
added = sorted(scope_files - set(after))
missing = sorted(set(after) - scope_files)
build_mismatches = sorted(rel for rel, sha in build.items() if after.get(rel) != sha)
tab_differences = sorted(rel for rel, sha in after.items() if tab_baseline.get(rel) != sha)
finder_exclusions = [rel for rel in tab_differences if pathlib.PurePosixPath(rel).name == ".DS_Store" and rel not in tab_baseline]

assert not current_mismatches, current_mismatches
assert not added and not missing, (added, missing)
assert not build_mismatches, build_mismatches
assert all(row["baseline_matches_before"] and row["reconstructed_matches_after"] for row in reconstruction)

with tempfile.TemporaryDirectory(prefix="wechat-2.1-6-rollback-proof-") as temp_name:
    temp = pathlib.Path(temp_name)
    for rel, data in sorted(current_bytes.items()):
        # Ten changed authorization files are independently reconstructed. Every
        # other byte sequence is admitted only after checking the historical SHA.
        expected_data = rebuilt.get(rel, data)
        assert digest(expected_data) == after[rel]
        for tree, content in (("expected-2.1-6", expected_data), ("current", data)):
            target = temp / tree / rel
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(content)
            target.chmod(0o644)
    command = ["git", "-c", "color.ui=false", "diff", "--no-index", "--exit-code", "--no-ext-diff", "--no-textconv", "--", "expected-2.1-6", "current"]
    result = subprocess.run(command, cwd=temp, capture_output=True, check=False)
    (AUDIT / "rollback-diff.patch").write_bytes(result.stdout)
    diff_result = {
        "command": command,
        "working_directory": temp_name,
        "temporary_trees_removed_after_comparison": True,
        "compared_files_per_tree": len(after),
        "exit_code": result.returncode,
        "stdout_bytes": len(result.stdout),
        "stderr": result.stderr.decode("utf-8", errors="replace"),
        "diff_file": "rollback-diff.patch",
        "diff_sha256": digest(result.stdout),
        "reference": "historical 2.1-6 authorization-cleanup after manifest, not Git HEAD",
        "file_mode_policy": "Both temporary content trees use mode 0644; this comparison attests bytes and paths, not historical modes or Git metadata.",
    }
    write_json("rollback-diff-result.json", diff_result)

final_current_sha = {rel: digest((ROOT / rel).read_bytes()) for rel in after}
inputs_stable = final_current_sha == current_sha
passed = result.returncode == 0 and not result.stdout and not result.stderr and inputs_stable
provenance = {
    "verified_at": datetime.datetime.now(datetime.timezone.utc).isoformat(),
    "status": "passed" if passed else "failed",
    "checkout": str(ROOT),
    "delivery_version": "2.1-6",
    "source_authority": "docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json",
    "before_semantics": "source-sha256-before and baseline/ are pre-cleanup 2.1-5; they are not the 2.1-6 delivery",
    "after_semantics": "baseline/ plus cleanup.diff reconstructs the 2.1-6 delivery and matches source-sha256-after",
    "build_before_semantics": "build-inputs-before means before building, after authorization cleanup",
    "evidence_file_sha256": {
        str(path.relative_to(ROOT)): digest(path.read_bytes())
        for path in (
            AUTH / "source-sha256-before.json", AUTH / "source-sha256-after.json",
            AUTH / "cleanup.diff", AUTH / "build-inputs-before.json",
            TAB / "baseline-sha256.json", pathlib.Path(__file__).resolve(),
        )
    },
    "reconstructed_delivery_files": reconstruction,
    "reconstructed_count": len(reconstruction),
    "before_after_path_counts": {"before": len(before), "after": len(after)},
    "build_inputs": {"checked": len(build), "matching_after": len(build) - len(build_mismatches), "mismatches": build_mismatches},
    "tabbar_start_baseline": {
        "matching_after": len(after) - len(tab_differences),
        "finder_metadata_excluded_from_later_manifest": finder_exclusions,
        "other_differences": sorted(set(tab_differences) - set(finder_exclusions)),
    },
    "current_source": {
        "checked": len(after), "matching_after": len(after) - len(current_mismatches),
        "mismatches": current_mismatches, "extra_paths_in_original_scope": added,
        "missing_paths_in_original_scope": missing,
        "stable_during_verification": inputs_stable,
        "sha256": dict(sorted(current_sha.items())),
    },
    "git_content_comparison": diff_result,
    "writes": ["new audit evidence files", "temporary expected/current content trees, removed after comparison"],
    "production_or_tests_modified": False,
    "build_or_package_run": False,
    "limitations": [
        "Comparison covers the original source manifest's Controllers/Headers/Hooks/Tests and Makefile/control/WeChatImprove.plist paths, including its three Finder metadata files.",
        "Audit documents and preserved historical build/package artifacts are outside this source rollback comparison.",
        "SHA-256 and normalized temporary Git comparison attest content/path equivalence, not historical file modes, symlink identity, index contents, refs or all repository metadata.",
        "The 592 unchanged expected byte sequences are read from current files only after matching each historical after SHA; ten changed delivery files are independently reconstructed from the historical baseline plus cleanup.diff.",
    ],
}
write_json("rollback-provenance.json", provenance)
assert passed, "comparison failed or inputs changed during verification"
print(json.dumps({"status": provenance["status"], "reconstructed": len(reconstruction), "build_matching": len(build), "current_matching": len(after), "git_exit_code": result.returncode, "diff_bytes": len(result.stdout)}, ensure_ascii=False))
