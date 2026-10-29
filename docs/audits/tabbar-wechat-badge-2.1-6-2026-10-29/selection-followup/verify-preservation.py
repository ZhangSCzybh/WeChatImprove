#!/usr/bin/env python3
"""Read the original checkout; write comparison evidence only beside this script."""
import datetime
import hashlib
import json
import pathlib
import re

AUDIT = pathlib.Path(__file__).resolve().parent
ROOT = AUDIT.parents[3]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load(path):
    return json.loads(path.read_text())


def write_json(name, value):
    (AUDIT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def compare(expected, current):
    rows = []
    for rel in sorted(set(expected) | set(current)):
        old, new = expected.get(rel), current.get(rel)
        status = "MATCH" if old == new else "ADDED" if old is None else "MISSING" if new is None else "CHANGED"
        rows.append({"path": rel, "expected_sha256": old, "actual_sha256": new, "status": status})
    return rows


expected_source = load(ROOT / "docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json")
source_paths = set(("Makefile", "control", "WeChatImprove.plist"))
for top in ("Controllers", "Headers", "Hooks", "Tests"):
    source_paths.update(str(p.relative_to(ROOT)) for p in (ROOT / top).rglob("*") if p.is_file())
current_source = {rel: sha(ROOT / rel) for rel in sorted(source_paths) if (ROOT / rel).is_file()}
source_rows = compare(expected_source, current_source)
post_rollback = load(AUDIT.parent / "source-sha256-2.1-6.json")

expected_artifacts = load(AUDIT.parent / "historical-artifacts-before.json")
current_artifacts = {
    str(p.relative_to(ROOT)): sha(p)
    for top in (".theos", "packages")
    for p in (ROOT / top).rglob("*")
    if p.is_file()
}
artifact_rows = compare(expected_artifacts, current_artifacts)

for filename, rows in (("source-hash-comparison.tsv", source_rows), ("historical-artifacts-comparison.tsv", artifact_rows)):
    lines = ["path\texpected_sha256\tactual_sha256\tstatus"]
    lines.extend("\t".join((r["path"], r["expected_sha256"] or "", r["actual_sha256"] or "", r["status"])) for r in rows)
    (AUDIT / filename).write_text("\n".join(lines) + "\n")

control = (ROOT / "control").read_text()
header = (ROOT / "Headers/CSUserInfoHelper.h").read_text()
control_version = re.search(r"^Version:\s*(\S+)", control, re.M).group(1)
header_version = re.search(r'CS_VERSION\s+@"([^"]+)"', header)
if not header_version:
    # The declaration name is intentionally read rather than rewritten.
    header_version = re.search(r'@"(2\.1-\d+)"', header)
header_version = header_version.group(1) if header_version else "unavailable"

result = {
    "verified_at": datetime.datetime.now(datetime.timezone.utc).isoformat(),
    "checkout": str(ROOT),
    "source_authority": "docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json",
    "source": {
        "expected_count": len(expected_source), "actual_count": len(current_source),
        "matching": sum(r["status"] == "MATCH" for r in source_rows),
        "differences": [r for r in source_rows if r["status"] != "MATCH"],
        "unchanged_since_completed_rollback": current_source == post_rollback,
        "comparison": "source-hash-comparison.tsv",
    },
    "versions": {"control": control_version, "Headers/CSUserInfoHelper.h": header_version},
    "historical_artifacts": {
        "scope": [".theos", "packages"],
        "expected_count": len(expected_artifacts), "actual_count": len(current_artifacts),
        "matching": sum(r["status"] == "MATCH" for r in artifact_rows),
        "differences": [r for r in artifact_rows if r["status"] != "MATCH"],
        "package_files": sum(rel.startswith("packages/") for rel in current_artifacts),
        "deb_files": sum(rel.startswith("packages/") and rel.endswith(".deb") for rel in current_artifacts),
        "comparison": "historical-artifacts-comparison.tsv",
    },
    "notes": [
        "Comparison attests file bytes and paths against the historical source manifest and the inventory captured at the start of this task.",
        "No reset/checkout/package/install/clean command is run by this verifier.",
        "Writes are confined to this audit directory; existing Git HEAD differences are not reset.",
    ],
}
result["passed"] = (
    not result["source"]["differences"]
    and result["source"]["unchanged_since_completed_rollback"]
    and set(result["versions"].values()) == {"2.1-6"}
    and not result["historical_artifacts"]["differences"]
)
write_json("source-sha256-final.json", current_source)
write_json("historical-artifacts-after.json", current_artifacts)
write_json("final-preservation.json", result)
print(json.dumps(result, ensure_ascii=False, indent=2))
assert result["passed"], "source, version, or historical artifact mismatch"
