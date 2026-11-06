#!/usr/bin/env python3
"""Re-run failed, unchanged historic scripts against the frozen 2.2-16 source.

This does not turn failures into passes. It distinguishes identical pre-existing
fixture compile errors from a new regression and retains both complete logs.
"""
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
AUDIT = HERE.parent
ROOT = AUDIT.parents[2]
BASELINE = AUDIT / "baseline-2.2-16"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def diagnostics(text):
    # Preserve the exact diagnostic text and multiplicity, while omitting only
    # locations/paths that change when the same fixture is compiled in a temp tree.
    result = Counter()
    for line in text.splitlines():
        match = re.search(r"\berror: (.+)", line)
        if match:
            result[match.group(1)] += 1
    return result


def main():
    current = json.loads((HERE / "security-result.json").read_text())
    failed = [row for row in current["runs"] if row["exit_code"] != 0]
    expected = json.loads((HERE / "fixture-provenance.json").read_text())["files"]
    assert all(sha(HERE / "fixture-project" / p) == h for p, h in expected.items())
    with tempfile.TemporaryDirectory(prefix="wechat-2217-security-baseline-") as directory:
        project = Path(directory)
        shutil.copytree(HERE / "fixture-project/Tests", project / "Tests")
        for name in ("Controllers", "Hooks", "Headers", "HeadersFile"):
            (project / name).symlink_to(BASELINE / name, target_is_directory=True)

        def run(row):
            name = row["name"]
            script = project / "Tests" / ("verify-" + name + ".sh")
            completed = subprocess.run(["bash", str(script)], cwd=ROOT,
                                       text=True, capture_output=True)
            text = completed.stdout + completed.stderr
            log = HERE / ("baseline-2.2-16-" + name + ".log")
            log.write_text(text)
            old_diag, new_diag = diagnostics(text), diagnostics(row["output"])
            same = completed.returncode != 0 and bool(old_diag) and old_diag == new_diag
            return {"name": name, "current_exit_code": row["exit_code"],
                "baseline_exit_code": completed.returncode, "baseline_log": str(log),
                "unchanged_assertion_script_sha256": sha(script),
                "baseline_error_multiset": dict(old_diag), "current_error_multiset": dict(new_diag),
                "identical_compile_diagnostics": same,
                "classification": "pre_existing_fixture_compile_incompatibility" if same else "requires_review",
                "product_pass_claimed": False}

        with ThreadPoolExecutor(max_workers=3) as pool:
            rows = list(pool.map(run, failed))
    report = {"baseline": str(BASELINE), "failed_historic_scripts": len(failed),
        "runs": rows, "all_failures_identical_compile_errors": all(r["identical_compile_diagnostics"] for r in rows),
        "scope": "Only byte-identical historical test scripts and the frozen uncommitted 2.2-16 source. A baseline fixture compile incompatibility remains an unpassed test, not a product test pass."}
    (HERE / "security-baseline-diagnosis.json").write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    for row in rows:
        print(row["name"], row["classification"],
              "current=" + str(row["current_exit_code"]), "baseline=" + str(row["baseline_exit_code"]),
              "errors=" + str(sum(row["baseline_error_multiset"].values())))
    if not report["all_failures_identical_compile_errors"]:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
