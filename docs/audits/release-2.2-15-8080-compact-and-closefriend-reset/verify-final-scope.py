#!/usr/bin/env python3
"""Verify release scope against the frozen, uncommitted 2.2-14 worktree.

Only this audit's verification result files are written. No Git mutation, build,
package installation, service operation, or fixture assertion change is made.
Use --prepare before finalization, then --final only after sources/builds settle.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
BASELINE = AUDIT / "baseline-2.2-14"
SOURCE_DIRS = ("Controllers", "Hooks", "Headers")
SOURCE_FILES = ("Makefile", "control", "README.md", "WeChatImprove.plist")
OLD_AUDITS = ("docs/audits/account-signature-2026-11-05",
              "docs/audits/wechat-8.0.80-2026-11-05")
DELIVERY = "packages/2.2-15-8080-compact-and-closefriend-reset"
EXPECTED_HEAD = "a227b1677255fe0e2dc727dcc2e6f62386fc3afd"
COMMANDS = []


def sha(path):
    with path.open("rb") as handle:
        return hashlib.file_digest(handle, "sha256").hexdigest()


def execute(command):
    COMMANDS.append(command)
    return subprocess.run(command, cwd=ROOT, capture_output=True)


def stamp():
    return datetime.now(timezone.utc).isoformat()


def read_json(path):
    return json.loads(path.read_text())


def write_json(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def inventory(directory, relative_to):
    if not directory.is_dir():
        return {}
    return {str(p.relative_to(relative_to)): sha(p) for p in sorted(directory.rglob("*"))
            if p.is_file() and p.name != ".DS_Store"}


def verify_manifest(expected, base, actual=None):
    missing, changed = [], []
    for relative, digest in expected.items():
        path = base / relative
        if not path.is_file():
            missing.append(relative)
        elif sha(path) != digest:
            changed.append(relative)
    unexpected = sorted(set(actual) - set(expected)) if actual is not None else []
    return {"expected_count": len(expected), "verified_count": len(expected) - len(missing) - len(changed),
            "missing": missing, "changed": changed, "unexpected": unexpected,
            "passed": not missing and not changed and not unexpected}


def original_fixtures():
    historic = read_json(AUDIT / "regression/fixture-provenance.json")
    compact = read_json(AUDIT / "compact-validation/fixture-origin.json")
    return {
        "legacy": {"base": str(AUDIT / "regression/fixture-project"), "files": historic["files"],
                   "origin": historic["origin_commit"]},
        "compact": {"base": str(AUDIT / "compact-validation/fixtures"),
                    "files": {p.removeprefix("Tests/"): h for p, h in compact["sha256"].items()},
                    "origin": compact["origin"]}}


def prepare():
    target = AUDIT / "scope-preparation.json"
    if target.exists():
        raise SystemExit("Preserve the original preparation snapshot; it already exists.")
    old = {}
    for name in OLD_AUDITS:
        old.update(inventory(ROOT / name, ROOT))
    value = {"prepared_at": stamp(), "old_audit_preservation_window":
        "The preparation time through final verification; no earlier initial-task hash manifest for these audit directories was available.",
        "old_audits": old, "original_fixtures": original_fixtures(),
        "baseline_manifest_sha256": sha(AUDIT / "baseline-source-hashes.json"),
        "historical_packages_manifest_sha256": sha(AUDIT / "historical-packages-before.json"),
        "main_theos_manifest_sha256": sha(AUDIT / "main-theos-before.json")}
    write_json(target, value)
    print(f"Prepared only: {len(old)} existing audit files and original fixture manifests recorded.")
    print("No final source/build conclusion was produced; run --final after sources and packaging settle.")


def source_paths(tree):
    paths = {str(p.relative_to(tree)) for name in SOURCE_DIRS for p in (tree / name).rglob("*")
             if p.is_file() and p.name != ".DS_Store"}
    paths.update(name for name in SOURCE_FILES if (tree / name).is_file())
    return paths


def source_diff():
    before, after = source_paths(BASELINE), source_paths(ROOT)
    rows = []
    for relative in sorted(before | after):
        old, new = BASELINE / relative, ROOT / relative
        old_hash = sha(old) if old.is_file() else None
        new_hash = sha(new) if new.is_file() else None
        if old_hash == new_hash:
            continue
        command = ["git", "diff", "--no-index", "--no-ext-diff", "--numstat", "--",
                   str(old) if old.is_file() else "/dev/null", str(new) if new.is_file() else "/dev/null"]
        result = execute(command)
        if result.returncode not in (0, 1):
            raise RuntimeError(result.stderr.decode(errors="replace"))
        fields = result.stdout.decode(errors="replace").split("\t", 2)
        if len(fields) != 3 or not fields[0].isdigit() or not fields[1].isdigit():
            raise RuntimeError("Unexpected binary/non-numstat production source: " + relative)
        rows.append({"file": relative, "status": "added" if relative not in before else ("deleted" if relative not in after else "modified"),
                     "added": int(fields[0]), "removed": int(fields[1]),
                     "baseline_sha256": old_hash, "current_sha256": new_hash})
    return {"baseline": str(BASELINE), "basis": "Frozen 2.2-14 worktree, including the user's uncommitted 2.2-13/2.2-14 work; never Git HEAD.",
            "line_count_method": "git diff --no-index --no-ext-diff --numstat for each changed source; .DS_Store excluded; new source files compared to /dev/null.",
            "directories": SOURCE_DIRS, "root_files": SOURCE_FILES,
            "baseline_file_count": len(before), "current_file_count": len(after), "changed_file_count": len(rows),
            "added": sum(r["added"] for r in rows), "removed": sum(r["removed"] for r in rows), "files": rows}


def final():
    preparation = read_json(AUDIT / "scope-preparation.json")
    baseline_manifest = read_json(AUDIT / "baseline-source-hashes.json")
    frozen = verify_manifest(baseline_manifest, BASELINE)
    old_audits_actual = {}
    for directory in OLD_AUDITS:
        old_audits_actual.update(inventory(ROOT / directory, ROOT))
    old_audits = verify_manifest(preparation["old_audits"], ROOT, old_audits_actual)
    old_audits["preservation_window"] = preparation["old_audit_preservation_window"]
    old_audits["prepared_at"] = preparation["prepared_at"]
    fixtures = {name: verify_manifest(value["files"], Path(value["base"]))
                for name, value in preparation["original_fixtures"].items()}
    header_expected = {p: h for p, h in baseline_manifest.items()
                       if p.startswith("HeadersFile/") and Path(p).name != ".DS_Store"}
    headers = verify_manifest(header_expected, ROOT, inventory(ROOT / "HeadersFile", ROOT))
    packages_expected = read_json(AUDIT / "historical-packages-before.json")
    packages_actual = {str(p.relative_to(ROOT)): sha(p) for p in sorted((ROOT / "packages").rglob("*"))
                       if p.is_file() and not p.is_relative_to(ROOT / DELIVERY)}
    packages = verify_manifest(packages_expected, ROOT, packages_actual)
    packages["permitted_new_directory"] = DELIVERY
    theos_expected = read_json(AUDIT / "main-theos-before.json")
    # Unlike source scope, both protection manifests intentionally include .DS_Store.
    theos_actual = {str(p.relative_to(ROOT)): sha(p) for p in sorted((ROOT / ".theos").rglob("*")) if p.is_file()}
    theos = verify_manifest(theos_expected, ROOT, theos_actual)
    scope = source_diff()
    head = execute(["git", "rev-parse", "HEAD"]).stdout.decode().strip()
    status = execute(["git", "status", "--porcelain=v1", "-z", "--untracked-files=all"])
    if status.returncode:
        raise RuntimeError(status.stderr.decode(errors="replace"))
    (AUDIT / "final-git-status.z").write_bytes(status.stdout)
    manifest_inputs = {
        "baseline_manifest_unchanged": sha(AUDIT / "baseline-source-hashes.json") == preparation["baseline_manifest_sha256"],
        "historical_packages_manifest_unchanged": sha(AUDIT / "historical-packages-before.json") == preparation["historical_packages_manifest_sha256"],
        "main_theos_manifest_unchanged": sha(AUDIT / "main-theos-before.json") == preparation["main_theos_manifest_sha256"]}
    checks = {"frozen_baseline": frozen, "historical_packages": packages, "main_theos": theos,
              "HeadersFile": headers, "old_audits": old_audits, "original_fixtures": fixtures,
              "manifest_inputs": manifest_inputs, "git_head_matches_task_baseline": head == EXPECTED_HEAD}
    passed = (all(v["passed"] for v in [frozen, packages, theos, headers, old_audits, *fixtures.values()])
              and all(manifest_inputs.values()) and head == EXPECTED_HEAD)
    result = {"verified_at": stamp(), "passed": passed, "scope": scope, "protection": checks,
        "git": {"head": head, "expected_head": EXPECTED_HEAD, "uncommitted_work_present": bool(status.stdout),
                "status_sha256": sha(AUDIT / "final-git-status.z"), "status_file": "final-git-status.z"},
        "task_constraints": ["No reset, checkout, stash, clean, commit, or overwrite of historical packages is authorized.",
                             "This verifier executes only Git diff --no-index, rev-parse and status; it does not infer a complete shell-command history from Git state."],
        "verifier_commands": COMMANDS, "new_delivery_files": inventory(ROOT / DELIVERY, ROOT)}
    write_json(AUDIT / "final-scope-result.json", result)
    lines = ["# 2.2-15 最终范围与环境保护核验", "",
        "比较基准是本任务开始时冻结的、含未提交 2.2-13 / 2.2-14 改动的工作树；没有按 Git HEAD 重建基线。", "",
        f"生产与版本说明共 **{scope['changed_file_count']} 个文件，+{scope['added']} / −{scope['removed']} 行**。包含新文件，排除 .DS_Store。", "",
        "| 文件 | 状态 | 增加 | 删除 |", "| --- | --- | ---: | ---: |"]
    lines += [f"| `{r['file']}` | {r['status']} | +{r['added']} | −{r['removed']} |" for r in scope["files"]]
    lines += ["", "| 保护对象 | 核验项数 | 结果 |", "| --- | ---: | --- |"]
    for title, check in [("冻结基线", frozen), ("历史 packages（包含 .DS_Store）", packages),
                         ("主树 .theos（完整路径集合与 hash）", theos), ("HeadersFile", headers),
                         ("既有 2.2-13 / 2.2-14 审计", old_audits), *[("原 fixture / " + k, v) for k, v in fixtures.items()]]:
        lines.append(f"| {title} | {check['expected_count']} | {'PASS' if check['passed'] else 'FAIL'} |")
    lines += ["", "旧审计的前后保护窗口是 scope-preparation.json 的准备时间至本次最终核验；其余 packages/.theos/冻结源码使用任务开始时已有 manifest。", "",
        f"Git HEAD 保持 `{head}`，工作树仍有未提交改动。核验脚本仅运行只读 diff/status/rev-parse，未执行 reset、checkout、stash、clean 或提交。", "",
        f"整体结果：**{'PASS' if passed else 'FAIL'}**。逐项缺失、改变、额外文件、完整 hash 与逐文件计数见 final-scope-result.json。"]
    (AUDIT / "final-scope.md").write_text("\n".join(lines) + "\n")
    print(f"Scope vs frozen 2.2-14: {scope['changed_file_count']} files, +{scope['added']} / -{scope['removed']} lines.")
    print(f"Historical packages: {packages['verified_count']}/{packages['expected_count']}; main .theos: {theos['verified_count']}/{theos['expected_count']}.")
    print(f"Original fixtures: " + ", ".join(f"{k} {v['verified_count']}/{v['expected_count']}" for k, v in fixtures.items()))
    print("Final scope/protection: " + ("PASS" if passed else "FAIL"))
    if not passed:
        raise SystemExit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--prepare", action="store_true")
    mode.add_argument("--final", action="store_true")
    args = parser.parse_args()
    prepare() if args.prepare else final()
