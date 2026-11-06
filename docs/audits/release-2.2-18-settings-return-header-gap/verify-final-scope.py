#!/usr/bin/env python3
"""Verify 2.2-18 source scope and preservation independently of release/build status.

Uses the frozen, uncommitted 2.2-17 worktree. Only this audit's evidence is
written. Git calls are limited to read-only diff, rev-parse and status.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
BASELINE = AUDIT / "baseline-2.2-17"
SOURCE_DIRS = ("Controllers", "Hooks", "Headers")
SOURCE_FILES = ("Makefile", "control", "README.md", "WeChatImprove.plist")
OLD_AUDITS = ("docs/audits/release-2.2-17-quick-entry-closefriend-reset",)
DELIVERY = "packages/2.2-18-settings-return-header-gap"
EXPECTED_HEAD = "a227b1677255fe0e2dc727dcc2e6f62386fc3afd"
ALLOWED_CHANGES = {
    "Controllers/CSCustomViewController.m", "Controllers/CSReleaseNotesViewController.m",
    "Headers/CSUserInfoHelper.h", "README.md", "control",
}

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
    return {str(p.relative_to(relative_to)): sha(p) for p in sorted(directory.rglob("*"))
            if p.is_file()} if directory.is_dir() else {}


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
    base = AUDIT / "release-core-revalidation"
    return {"copied_unmodified_test_inputs_and_runners": {
        "base": str(base), "files": read_json(base / "fixture-before.json"),
        "origin": "2.2-17 release-authorized-revalidation, plus unchanged quick-reset/new-password suites"}}


def prepare():
    target = AUDIT / "scope-preparation.json"
    if target.exists():
        raise SystemExit("Preserve the original preparation snapshot; it already exists.")
    old = {}
    for name in OLD_AUDITS:
        old.update(inventory(ROOT / name, ROOT))
    value = {"prepared_at": stamp(), "old_audit_preservation_window":
        "Preparation time through final verification. This manifest is additional protection, not a task-start hash claim.",
        "old_audits": old, "original_fixtures": original_fixtures(),
        "baseline_manifest_sha256": sha(AUDIT / "baseline-source-before.json"),
        "historical_packages_manifest_sha256": sha(AUDIT / "historical-packages-before.json"),
        "main_theos_manifest_sha256": sha(AUDIT / "main-theos-before.json")}
    write_json(target, value)
    print(f"Prepared: {len(old)} existing audit files; no old-audit edit/deletion exceptions.")


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
    unexpected = sorted(r["file"] for r in rows if r["file"] not in ALLOWED_CHANGES)
    return {"baseline": str(BASELINE), "basis": "Frozen 2.2-17 worktree including all uncommitted 2.2-13 through 2.2-17 work; never Git HEAD.",
            "line_count_method": "git diff --no-index --no-ext-diff --numstat per changed file; .DS_Store excluded only from source line counts.",
            "directories": SOURCE_DIRS, "root_files": SOURCE_FILES,
            "baseline_file_count": len(before), "current_file_count": len(after), "changed_file_count": len(rows),
            "added": sum(r["added"] for r in rows), "removed": sum(r["removed"] for r in rows), "files": rows,
            "explicit_change_allowlist": sorted(ALLOWED_CHANGES), "unexpected_changed_files": unexpected,
            "passed": not unexpected}


def final():
    preparation = read_json(AUDIT / "scope-preparation.json")
    baseline_manifest = read_json(AUDIT / "baseline-source-before.json")
    frozen = verify_manifest(baseline_manifest, BASELINE, inventory(BASELINE, BASELINE))
    old_actual = {}
    for directory in OLD_AUDITS:
        old_actual.update(inventory(ROOT / directory, ROOT))
    old_audits = verify_manifest(preparation["old_audits"], ROOT, old_actual)
    old_audits.update({"preservation_window": preparation["old_audit_preservation_window"],
                       "prepared_at": preparation["prepared_at"], "edit_or_deletion_exceptions": []})
    fixtures = {}
    for name, value in preparation["original_fixtures"].items():
        base = Path(value["base"])
        actual = inventory(base / "Tests", base) if name == "legacy" else None
        fixtures[name] = verify_manifest(value["files"], base, actual)
    unchanged_source_expected = {p:h for p,h in baseline_manifest.items() if p not in ALLOWED_CHANGES}
    unchanged_sources = verify_manifest(unchanged_source_expected, ROOT)
    # Complete HeadersFile set and bytes, rather than merely a matching subset.
    header_expected = {p: h for p, h in baseline_manifest.items() if p.startswith("HeadersFile/")}
    headers = verify_manifest(header_expected, ROOT, inventory(ROOT / "HeadersFile", ROOT))
    packages_expected = read_json(AUDIT / "historical-packages-before.json")
    packages_actual = {p:h for p,h in inventory(ROOT / "packages", ROOT).items()
                       if not (ROOT / p).is_relative_to(ROOT / DELIVERY)}
    packages = verify_manifest(packages_expected, ROOT, packages_actual)
    packages["permitted_new_directory"] = DELIVERY
    theos_expected = read_json(AUDIT / "main-theos-before.json")
    theos = verify_manifest(theos_expected, ROOT, inventory(ROOT / ".theos", ROOT))
    scope = source_diff()
    head_result = execute(["git", "rev-parse", "HEAD"])
    checkout_result = execute(["git", "rev-parse", "--show-toplevel"])
    status = execute(["git", "status", "--porcelain=v1", "-z", "--untracked-files=all"])
    if head_result.returncode or checkout_result.returncode or status.returncode:
        raise RuntimeError("Read-only Git identity/status check failed.")
    head = head_result.stdout.decode().strip()
    checkout = checkout_result.stdout.decode().strip()
    (AUDIT / "final-git-status.z").write_bytes(status.stdout)
    manifest_inputs = {
        "baseline_manifest_unchanged": sha(AUDIT / "baseline-source-before.json") == preparation["baseline_manifest_sha256"],
        "historical_packages_manifest_unchanged": sha(AUDIT / "historical-packages-before.json") == preparation["historical_packages_manifest_sha256"],
        "main_theos_manifest_unchanged": sha(AUDIT / "main-theos-before.json") == preparation["main_theos_manifest_sha256"]}
    checks = {"frozen_baseline": frozen, "historical_packages": packages, "main_theos": theos,
              "HeadersFile": headers, "old_audits": old_audits, "original_fixtures": fixtures,
              "all_other_frozen_source_files_unchanged": unchanged_sources,
              "manifest_inputs": manifest_inputs, "git_head_matches_task_baseline": head == EXPECTED_HEAD,
              "checkout_matches_established_project": checkout == str(ROOT), "root_Tests_remains_absent": not (ROOT / "Tests").exists()}
    passed = (all(v["passed"] for v in [frozen, packages, theos, headers, old_audits, unchanged_sources, *fixtures.values()])
              and all(manifest_inputs.values()) and scope["passed"] and head == EXPECTED_HEAD
              and checkout == str(ROOT) and checks["root_Tests_remains_absent"])
    delivery_files = inventory(ROOT / DELIVERY, ROOT)
    result = {"verified_at": stamp(), "passed": passed, "scope": scope, "protection": checks,
        "git": {"head": head, "expected_head": EXPECTED_HEAD, "checkout": checkout,
                "uncommitted_work_present": bool(status.stdout), "status_sha256": sha(AUDIT / "final-git-status.z"),
                "status_file": "final-git-status.z"},
        "task_constraints": ["No reset, checkout, stash, clean, commit, or overwrite of historical packages is authorized.",
                             "Only read-only Git diff --no-index, rev-parse and status are executed; Git state cannot prove complete shell history."],
        "verifier_commands": COMMANDS,
        "delivery_status": {"directory_exists": (ROOT / DELIVERY).is_dir(), "files": delivery_files,
                            "scope_pass_is_not_a_build_or_release_pass": True}}
    write_json(AUDIT / "final-scope-result.json", result)
    lines = ["# 2.2-18 最终范围与环境保护核验", "",
        "基准是本次开始时冻结的 2.2-17 工作树，保留未提交的 2.2-13 至 2.2-17 改动；没有按 Git HEAD 重建。", "",
        f"生产与版本说明 **{scope['changed_file_count']} 个文件，+{scope['added']} / −{scope['removed']} 行**。", "",
        "| 文件 | 状态 | 增加 | 删除 | 2.2-17 SHA256 | 当前 SHA256 |", "| --- | --- | ---: | ---: | --- | --- |"]
    lines += [f"| `{r['file']}` | {r['status']} | +{r['added']} | −{r['removed']} | `{r['baseline_sha256']}` | `{r['current_sha256']}` |" for r in scope["files"]]
    lines += ["", "显式改动范围逐文件核验；未授权的新增、删除或修改都会失败，不以排除目录掩盖范围。", "",
              "| 保护对象 | 核验项数 | 结果 |", "| --- | ---: | --- |"]
    for title, check in [("冻结 2.2-17 基线（完整 set + hash）", frozen), ("历史 packages（完整 set + hash，含 .DS_Store）", packages),
                         ("主树 .theos（完整 set + hash）", theos), ("HeadersFile（完整 set + hash）", headers),
                         ("2.2-17 旧审计（零编辑或删除例外）", old_audits),
                         ("除 5 文件显式改动名单外全部冻结输入", unchanged_sources),
                         *[("原 fixture / " + k, v) for k, v in fixtures.items()]]:
        lines.append(f"| {title} | {check['expected_count']} | {'PASS' if check['passed'] else 'FAIL'} |")
    lines += ["", "旧审计保护窗口从 scope-preparation.json 准备时间起算；packages/.theos/冻结源码使用本任务起始 manifest。", "",
        f"HEAD `{head}`；checkout `{checkout}`；根 Tests {'不存在' if checks['root_Tests_remains_absent'] else '意外存在'}。", "",
        f"范围与保护结果：**{'PASS' if passed else 'FAIL'}**。此结果与测试、构建和出包门槛分开。", "",
        f"2.2-18 产物目录：{'存在' if (ROOT / DELIVERY).is_dir() else '不存在（尚未出包）'}；存在目录也不由本脚本视为构建验证通过。"]
    (AUDIT / "final-scope.md").write_text("\n".join(lines) + "\n")
    print(f"Scope vs frozen 2.2-17: {scope['changed_file_count']} files, +{scope['added']} / -{scope['removed']} lines.")
    print(f"Historical packages: {packages['verified_count']}/{packages['expected_count']}; main .theos: {theos['verified_count']}/{theos['expected_count']}.")
    print("Original fixtures: " + ", ".join(f"{k} {v['verified_count']}/{v['expected_count']}" for k, v in fixtures.items()))
    print("Scope/protection: " + ("PASS" if passed else "FAIL"))
    print("Build/release status is separate; delivery present=" + str((ROOT / DELIVERY).is_dir()))
    if not passed:
        raise SystemExit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--prepare", action="store_true")
    mode.add_argument("--final", action="store_true")
    args = parser.parse_args()
    prepare() if args.prepare else final()
