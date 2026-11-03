#!/usr/bin/env python3
"""Export existing local .trace tables and hash the XML evidence.

This script never records, attaches, connects to a device, symbolicates, or
changes the source trace. Existing output files are not overwritten.
"""

import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
import xml.etree.ElementTree as ET
from datetime import datetime, timezone
from pathlib import Path


TABLES = [
    ("cpu", "activity-monitor-process-live"),
    ("sysmon-process", "sysmon-process"),
    ("frames", "hitches-frame-lifetimes"),
    ("hitches", "hitches"),
    ("lifetime", "coreanimation-lifetime-interval"),
    ("legacy-lifetime", "hitches-lifetime-interval"),
    ("legacy-hitches", "hitches-summary"),
    ("commits", "coreanimation-commit-interval"),
    ("samples", "time-profile"),
    ("fps", "core-animation-fps-estimate"),
    ("thermal", "device-thermal-state-intervals"),
    ("libraries", "dyld-library-load"),
]


def sha256(path):
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def export(command, output):
    started = time.monotonic()
    result = subprocess.run(command, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    item = {"command": command, "exit_code": result.returncode,
            "elapsed_seconds": time.monotonic() - started, "tool_output": result.stdout.strip(),
            "output": str(output)}
    if output.exists():
        item.update({"bytes": output.stat().st_size, "sha256": sha256(output)})
        try:
            root = ET.parse(output).getroot()
            item["row_count"] = sum(1 for node in root.iter() if node.tag.rsplit("}", 1)[-1] == "row")
        except ET.ParseError as error:
            item["xml_error"] = str(error)
    return item


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--trace", type=Path, required=True)
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument("--prefix", help="Defaults to the trace filename without .trace")
    parser.add_argument("--run", type=int, default=1)
    parser.add_argument("--recording-status", choices=("complete", "failed", "unknown"), default="unknown",
                        help="Recorder exit status verified externally; not inferred from readable XML")
    args = parser.parse_args()
    trace = args.trace.resolve()
    if not trace.is_dir() or trace.suffix != ".trace" or args.run < 1:
        parser.error("--trace must be an existing local .trace bundle, and --run must be positive")
    prefix = args.prefix or trace.stem
    if not re.fullmatch(r"[A-Za-z0-9_.-]+", prefix):
        parser.error("--prefix may contain only ASCII letters, digits, dots, underscores and hyphens")
    args.output_dir.mkdir(parents=True, exist_ok=True)
    destination = args.output_dir.resolve()
    if destination == trace or trace in destination.parents:
        parser.error("Exports must be outside the source trace bundle")
    paths = {label: destination / f"{prefix}-{label}.xml" for label, _ in TABLES}
    toc_path = destination / f"{prefix}-toc.xml"
    manifest_path = destination / f"{prefix}-export-manifest.json"
    collisions = [p for p in [toc_path, manifest_path, *paths.values()] if p.exists()]
    if collisions:
        parser.error("Refusing to overwrite existing evidence: " + ", ".join(str(p) for p in collisions))
    version = subprocess.run(["xcrun", "xctrace", "version"], text=True,
                             stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    manifest = {"created_at_utc": datetime.now(timezone.utc).isoformat(), "source_trace": str(trace),
                "source_trace_mtime_ns": trace.stat().st_mtime_ns, "run_number": args.run,
                "recording_status_verified_externally": args.recording_status,
                "recording_integrity_note": "Successful XML export does not prove that the original recording completed or that a scenario was performed.",
                "xctrace_version": version.stdout.strip(), "exports": [], "absent_schemas": []}
    toc = export(["xcrun", "xctrace", "export", "--input", str(trace), "--toc", "--output", str(toc_path)], toc_path)
    manifest["exports"].append(toc)
    failures = bool(toc["exit_code"] or toc.get("xml_error"))
    if not failures:
        root = ET.parse(toc_path).getroot()
        run = next((node for node in root.iter() if node.tag.rsplit("}", 1)[-1] == "run" and node.get("number") == str(args.run)), None)
        if run is None:
            manifest["error"] = "Requested run is absent from the table of contents"
            failures = True
        else:
            schemas = {node.get("schema") for node in run.iter() if node.get("schema")}
            for label, schema in TABLES:
                if schema not in schemas:
                    manifest["absent_schemas"].append(schema)
                    continue
                xpath = f'/trace-toc/run[@number="{args.run}"]/data/table[@schema="{schema}"]'
                item = export(["xcrun", "xctrace", "export", "--input", str(trace), "--xpath", xpath,
                               "--output", str(paths[label])], paths[label])
                item["schema"] = schema
                manifest["exports"].append(item)
                failures |= bool(item["exit_code"] or item.get("xml_error"))
                print(f"{label}: exit={item['exit_code']} rows={item.get('row_count', 'unknown')}", flush=True)
    manifest["export_status"] = "failed" if failures else "complete"
    manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
    print(str(manifest_path), flush=True)
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
