#!/usr/bin/env python3
"""Build the approved release in isolated output directories."""
import concurrent.futures
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time

ROOT = Path(__file__).resolve().parents[3]
AUDIT = Path(__file__).resolve().parent
BASELINE = ROOT / "docs/audits/background-run-records-2026-11-02"
VERSION = "2.2-6"
PACKAGES = ROOT / "packages/2.2-6-background-run-native-priority"
ANSI = re.compile(r"\x1b\[[0-?]*[ -/]*[@-~]")


def sha(path):
    with path.open("rb") as source:
        return hashlib.file_digest(source, "sha256").hexdigest()


def save(name, value):
    (AUDIT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def input_hashes():
    paths = [p for folder in ("Controllers", "Hooks", "Headers", "HeadersFile", "layout")
             for p in (ROOT / folder).rglob("*") if p.is_file() and p.name != ".DS_Store"]
    paths += [ROOT / name for name in ("Makefile", "control", "WeChatImprove.plist")]
    return {str(p.relative_to(ROOT)): sha(p) for p in sorted(paths) if p.is_file()}


def normalize_warning(line):
    line = ANSI.sub("", line).strip()
    line = re.sub(r":\d+:\d+:", ":<line>:<column>:", line)
    return " ".join(line.split())


def preserved_artifacts():
    old = json.loads((AUDIT / "historical-artifacts-before.json").read_text())
    missing = [p for p in old if not (ROOT / p).is_file()]
    changed = [p for p, h in old.items() if (ROOT / p).is_file() and sha(ROOT / p) != h]
    existing_dirs = set(json.loads((AUDIT / "historical-directories-before.json").read_text()))
    current_dirs = {str(path.relative_to(ROOT)) for base in (ROOT / ".theos", ROOT / "packages")
                    for path in [base, *base.rglob("*")] if path.is_dir()}
    missing_dirs = sorted(existing_dirs - current_dirs)
    allowed = str(PACKAGES.relative_to(ROOT))
    unexpected_dirs = sorted(path for path in current_dirs - existing_dirs
                             if path != allowed and not path.startswith(allowed + "/"))
    return {"existing_file_count": len(old), "missing": missing, "changed": changed,
            "existing_directory_count": len(existing_dirs), "missing_directories": missing_dirs,
            "unexpected_directories": unexpected_dirs,
            "all_preserved": not (missing or changed or missing_dirs or unexpected_dirs)}


def main():
    assert re.search(r"^Version: " + re.escape(VERSION) + r"$", (ROOT / "control").read_text(), re.M)
    assert '#define kPluginVersionString @"' + VERSION + '"' in (ROOT / "Headers/CSUserInfoHelper.h").read_text()
    assert '@"' + VERSION + '": @[' in (ROOT / "Controllers/CSReleaseNotesViewController.m").read_text()
    assert VERSION in (ROOT / "README.md").read_text()
    if PACKAGES.exists():
        raise SystemExit("Delivery directory exists; preserve it without overwriting.")
    assert preserved_artifacts()["all_preserved"], "Historical artifacts changed before build."
    before = input_hashes()
    save("build-input-sha256.json", before)
    build_root = Path(tempfile.mkdtemp(prefix="wechat-2.2-6-native-priority-isolated-build-"))
    (AUDIT / "build-directory.txt").write_text(str(build_root) + "\n")

    def build(scheme):
        output = build_root / scheme
        output.mkdir()
        package_output = output / "packages"
        package_output.mkdir()
        command = ["make", "package", "-j4", "SCHEME=" + scheme, "PACKAGE_VERSION=" + VERSION,
                   "_THEOS_LOCAL_DATA_DIR=" + str(output / ".theos"),
                   "THEOS_BUILD_DIR=" + str(output), "THEOS_PACKAGE_DIR=" + str(package_output)]
        started = time.monotonic()
        result = subprocess.run(command, cwd=ROOT, stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT, text=True)
        (AUDIT / ("build-" + scheme + ".log")).write_text(result.stdout)
        warnings = [line for line in result.stdout.splitlines() if "warning:" in line]
        baseline = json.loads((BASELINE / ("build-" + scheme + "-result.json")).read_text())
        expected = Counter(normalize_warning(line) for line in baseline["warnings"])
        actual = Counter(normalize_warning(line) for line in warnings)
        row = {"scheme": scheme, "command": command, "exit_code": result.returncode,
               "duration_seconds": round(time.monotonic() - started, 3),
               "warning_count": len(warnings), "warnings": warnings,
               "warning_baseline_version": "2.2-5", "warning_baseline_count": len(baseline["warnings"]),
               "warning_normalization": "Strip ANSI, whitespace, source line/column only; retain full message and multiplicity.",
               "baseline_warning_multiset": dict(expected), "actual_warning_multiset": dict(actual),
               "warning_multiset_equal": actual == expected}
        save("build-" + scheme + "-result.json", row)
        return row

    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
        rows = list(pool.map(build, ("rootless", "rootful")))
    after = input_hashes()
    save("build-input-sha256-after.json", after)
    preservation = preserved_artifacts()
    save("historical-artifacts-after-build.json", preservation)
    result = {"input_hashes_unchanged": before == after,
              "existing_artifacts_preserved": preservation["all_preserved"],
              "warning_baseline_version": "2.2-5",
              "warning_multisets_equal": all(row["warning_multiset_equal"] for row in rows),
              "builds": rows}
    save("build-result.json", result)
    assert result["input_hashes_unchanged"], "Production inputs changed during build."
    assert result["existing_artifacts_preserved"], "Historical artifacts changed during build."
    assert result["warning_multisets_equal"], "Warning multiset differs from 2.2-5."
    assert all(row["exit_code"] == 0 for row in rows), "Build failed."
    draft_packages = []
    for scheme, arch in (("rootful", "iphoneos-arm"), ("rootless", "iphoneos-arm64")):
        path = build_root / scheme / "packages" / f"com.wechat.improve_{VERSION}_{arch}.deb"
        assert path.is_file(), str(path)
        draft_packages.append(path)
    PACKAGES.mkdir(exist_ok=False)
    for path in draft_packages:
        with path.open("rb") as source, (PACKAGES / path.name).open("xb") as destination:
            shutil.copyfileobj(source, destination)
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
