#!/usr/bin/env python3
"""Combine successful local exports and an independent review into one summary.

Only invokes the local Python analyzer. No xctrace/device/install commands.
The primary target-frame summary is preserved, even for ALL display exports.
"""

import argparse
from datetime import datetime, timedelta
import hashlib
import json
import math
from pathlib import Path
import subprocess
import sys
import tempfile
import xml.etree.ElementTree as ET


AUDIT = Path(__file__).resolve().parents[1]
REQUIRED = ("toc", "cpu", "sysmon-process", "lifetime", "commits", "fps", "thermal")


def read(path):
    return json.loads(Path(path).read_text())


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def source(path):
    return {"path": str(Path(path).resolve()), "sha256": sha(path)}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def close(left, right, label, tolerance=1e-7):
    require(isinstance(left, (int, float)) and isinstance(right, (int, float)) and
            math.isfinite(left) and math.isfinite(right) and abs(left - right) <= tolerance,
            f"Independent review differs for {label}: {left!r} vs {right!r}")


def local(node):
    return node.tag.rsplit("}", 1)[-1]


def exact_sources(review, files):
    known = {Path(item["path"]).resolve(): item["sha256"] for item in review.get("sources", [])}
    for key in ("toc", "cpu", "sysmon-process", "lifetime", "commits", "thermal"):
        file = files[key]
        require(known.get(file.resolve()) == sha(file), f"Independent review input missing/hash differs: {file}")


def verify_exports(folder, prefix):
    manifest_path = folder / "export" / f"{prefix}-export-manifest.json"
    manifest = read(manifest_path)
    require(manifest.get("export_status") == "complete", "Export manifest is not complete")
    require(manifest.get("recording_status_verified_externally") == "complete", "Export manifest has no complete recording verification")
    require(Path(manifest.get("source_trace", "")).resolve() == (folder / "raw.trace").resolve(), "Export manifest points to another trace")
    rows = {Path(item.get("output", "")).resolve(): item for item in manifest.get("exports", [])}
    files = {name: folder / "export" / f"{prefix}-{name}.xml" for name in REQUIRED}
    for name, file in files.items():
        require(file.is_file() and file.stat().st_size > 0, f"Required export missing/empty: {file}")
        record = rows.get(file.resolve(), {})
        require(record.get("exit_code") == 0, f"Required export not recorded as successful: {name}")
        require(record.get("sha256") == sha(file), f"Export hash differs from manifest: {name}")
        require(record.get("bytes") == file.stat().st_size, f"Export byte count differs from manifest: {name}")
    return manifest_path, manifest, files


def verify_toc(path, pid, end):
    toc = ET.parse(path).getroot()
    runs = [e for e in toc if local(e) == "run"]
    require(len(runs) == 1, "Expected exactly one trace run")
    fields = {local(e): (e.text or "").strip() for e in runs[0].iter() if local(e) in
              {"duration", "start-date", "end-date", "end-reason"}}
    duration = float(fields["duration"])
    require(duration >= end, "TOC duration does not cover analysis window")
    require(fields.get("end-reason") == "Time limit reached", "TOC does not report expected time-limit completion")
    scopes = [e.get("target-pid") for e in runs[0].iter()
              if local(e) == "table" and e.get("schema") == "coreanimation-lifetime-interval"]
    require(scopes == ["ALL"], f"This summarizer intentionally handles ALL display scope only, got {scopes!r}")
    return fields, duration


def verify_review(review, pid, begin, end, files):
    require(review.get("pid") == pid, "Independent review PID differs")
    require(review.get("window_seconds") == [begin, end], "Independent review uses another window")
    require(review.get("frame_table_scopes") == ["ALL"], "Independent review does not confirm ALL frame table")
    require(not review.get("attached_target_pid_matches"), "Independent review has unexpected attached target")
    require(not review.get("table_errors"), "Independent review has table errors")
    require(not review.get("frames", {}).get("hitch_latency_equation_mismatches"), "Independent hitch/latency equation mismatch")
    for category in ("cpu", "frames", "thermal"):
        require(review.get(category, {}).get("status") == "available", f"Independent {category} unavailable")
    require(review["cpu"].get("overlap_ns") == 0, "Overlapping independent CPU intervals")
    require(review["thermal"].get("overlap_nanoseconds") == 0, "Overlapping independent thermal intervals")
    close(review["cpu"]["coverage"]["fraction"], 1, "independent CPU coverage")
    close(review["thermal"]["coverage"]["fraction"], 1, "independent thermal coverage")
    require(review["cpu"].get("raw_counter_crosscheck", {}).get("reset_count") == 0, "Independent cumulative CPU counters reset/missing")
    exact_sources(review, files)


def compare_primary(primary, review):
    require(primary["cpu"].get("status") == "available", "Primary CPU summary unavailable")
    close(primary["cpu"].get("window_coverage_fraction"), 1, "primary CPU coverage")
    for pk, rk in (("mean_percent", "mean_percent"), ("time_weighted_p95_percent", "p95_percent"), ("peak_sample_percent", "peak_percent")):
        close(primary["cpu"][pk], review["cpu"][rk], "CPU " + pk)
    require(primary["frames"].get("status") == "unavailable", "Unexpected target-attributed frame rows in ALL trace; review manually")
    display = primary["display_frame_observations"]
    require(display.get("status") == "available", "Primary device/display observations unavailable")
    for pk, rk in (("frame_count", "classified_lifetimes"), ("hitch_count", "positive_hitch_count")):
        require(display[pk] == review["frames"][rk], f"Independent display {pk} differs")
    for pk, rk in (("known_frame_hitch_fraction", "hitch_record_fraction"), ("summed_hitch_ms", "summed_hitch_ms"), ("maximum_hitch_ms", "max_hitch_ms")):
        close(display[pk], review["frames"][rk], "display " + pk, 1e-5)
    if primary["render_commits"].get("status") == "available":
        require(primary["render_commits"]["commit_interval_count"] == review["commits"]["attributed_count"], "Independent CA commit count differs")
    else:
        require(review["commits"]["attributed_count"] == 0, "Primary CA commits unavailable despite independent positive count")


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--scene-folder", type=Path, required=True)
    p.add_argument("--prefix", required=True)
    p.add_argument("--begin", type=float, required=True)
    p.add_argument("--end", type=float, required=True)
    p.add_argument("--review", type=Path)
    p.add_argument("--output-dir", type=Path, help="Optional separate directory for offline smoke validation")
    p.add_argument("--signpost-summary", type=Path)
    p.add_argument("--overwrite", action="store_true", help="Replace only generated summaries, never evidence inputs")
    a = p.parse_args()
    try:
        require(math.isfinite(a.begin) and math.isfinite(a.end) and 0 <= a.begin < a.end, "Invalid analysis window")
        require(Path(a.prefix).name == a.prefix and a.prefix not in (".", ".."), "Prefix must be a filename component")
        folder = a.scene_folder.resolve()
        require(folder.is_relative_to(AUDIT), "Scene folder must be inside the new audit")
        capture_path = folder / "capture-result.json"
        capture = read(capture_path)
        pid = capture.get("target_pid")
        require(isinstance(pid, int) and pid > 0, "Capture has no valid target PID")
        require(capture.get("bundle_id") == "com.tencent.xin", "Capture target is not original WeChat")
        require(capture.get("exit_code") == 0 and capture.get("trace_present") is True, "Capture incomplete/failed; no summary written")
        require((folder / "raw.trace").is_dir(), "Saved raw.trace missing")
        validity_path = folder / "scenario-validity.json"
        validity = read(validity_path) if validity_path.exists() else None
        require(not validity or validity.get("eligible_for_final_comparison") is not False, "Scenario explicitly excluded/contaminated")
        manifest_path, manifest, files = verify_exports(folder, a.prefix)
        fields, duration = verify_toc(files["toc"], pid, a.end)
        review_path = (a.review or AUDIT / "review" / f"{folder.name}-independent.json").resolve()
        review = read(review_path)
        verify_review(review, pid, a.begin, a.end, files)
        output_dir = (a.output_dir or folder).resolve()
        require(output_dir.is_relative_to(AUDIT), "Summary output must remain inside the new audit")
        outputs = [output_dir / "primary-summary.json", output_dir / "summary.json"]
        require(a.overwrite or not any(f.exists() for f in outputs), "Generated summary exists; use --overwrite deliberately")
        analyzer = AUDIT / "analyze-trace.py"
        with tempfile.TemporaryDirectory(prefix="wechat-groups-local-summary-") as temp:
            temporary = Path(temp) / "primary.json"
            command = [sys.executable, str(analyzer), "--toc", str(files["toc"]),
                       "--cpu", str(files["cpu"]), "--cpu", str(files["sysmon-process"]),
                       "--frames", str(files["lifetime"]), "--commits", str(files["commits"]),
                       "--fps", str(files["fps"]), "--pid", str(pid),
                       "--start-s", str(a.begin), "--end-s", str(a.end),
                       "--include-device-frame-observations", "--output", str(temporary)]
            completed = subprocess.run(command, capture_output=True, text=True, check=False)
            require(completed.returncode == 0, "Local analyzer failed: " + completed.stderr)
            primary = read(temporary)
        compare_primary(primary, review)
        result = dict(primary)
        result["scenario"] = "idle" if folder.name == "idle-confirmed" else folder.name
        result["plugin_version"] = capture.get("plugin_version")
        result["bundle_id"] = capture["bundle_id"]
        result["analyzed_seconds"] = a.end - a.begin
        result["frame_scope"] = "Device/display scope; target-pid=ALL; not WeChat-only"
        result["capture_context"] = {"recorder_exit_code": capture["exit_code"],
            "trace_present": True, "toc_duration_seconds": duration,
            "toc_end_reason": fields["end-reason"],
            "frame_scope_proof": "CoreAnimationLifetime TOC target-pid=ALL; no target frame ownership mapping. CPU and CA commits are filtered strictly to the confirmed WeChat PID.",
            "capture_source": source(capture_path), "export_manifest_source": source(manifest_path),
            "recording_wall_start": fields.get("start-date"), "recording_wall_end": fields.get("end-date"),
            "manual_recorder_intervention": capture.get("postprocessing_intervention")}
        if fields.get("start-date"):
            start = datetime.fromisoformat(fields["start-date"])
            result["capture_context"].update(analysis_wall_start=(start + timedelta(seconds=a.begin)).isoformat(),
                                              analysis_wall_end=(start + timedelta(seconds=a.end)).isoformat())
        thermal = review["thermal"]
        result["thermal_state_observations"] = {"status": thermal["status"],
            "scope": "Device thermal state; does not identify a causal process or prove throttling",
            "source": str(files["thermal"]), "source_sha256": sha(files["thermal"]),
            "window_state_seconds": thermal["state_seconds"],
            "window_state_fraction": thermal["state_fraction_of_window"],
            "coverage": thermal["coverage"], "intervals": thermal["intervals"]}
        result["independent_review"] = {"status": "matched", "source": source(review_path),
            "checks": ["same PID/window/source hashes", "CPU mean/P95/peak/coverage", "device frame count/hitch count/fraction/sum/max", "target CA count", "thermal full coverage/no overlap"]}
        result["summary_provenance"] = {"primary_analyzer": source(analyzer),
            "local_summarizer": source(__file__), "command": command,
            "export_status": manifest["export_status"],
            "scope_rule": "Target frames stay unavailable; ALL observations stay in display_frame_observations"}
        if validity is not None:
            result["scenario_validity"] = validity
            result["scenario_validity_source"] = source(validity_path)
        signpost_path = a.signpost_summary or AUDIT / "signposts" / f"{folder.name}-summary.json"
        if signpost_path.exists():
            signposts = read(signpost_path)
            require(signposts.get("target_pid") == pid, "Signpost PID differs")
            w = signposts.get("window_seconds", {})
            require(w.get("begin", w.get("start")) == a.begin and w.get("end") == a.end, "Signpost window differs")
            result["signpost_summary"] = signposts
            result["signpost_summary_source"] = source(signpost_path)
        output_dir.mkdir(parents=True, exist_ok=True)
        outputs[0].write_text(json.dumps(primary, ensure_ascii=False, indent=2, allow_nan=False) + "\n")
        outputs[1].write_text(json.dumps(result, ensure_ascii=False, indent=2, allow_nan=False) + "\n")
        print(json.dumps({"status": "written", "primary_summary": str(outputs[0]), "summary": str(outputs[1]),
                          "target_frames": result["frames"]["status"],
                          "display_frame_observations": result["display_frame_observations"]["status"],
                          "cpu_mean_percent": result["cpu"]["mean_percent"]}, ensure_ascii=False))
    except (ValueError, OSError, KeyError, ET.ParseError, json.JSONDecodeError) as error:
        p.error(str(error))


if __name__ == "__main__":
    main()
