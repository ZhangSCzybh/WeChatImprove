#!/usr/bin/env python3
"""Summarize xctrace XML exports without treating samples as call counts.

Only exported files are read. No device connection or recording is performed.
Use --frames-target-scoped only after independently verifying that the frame
table is restricted to the requested process; a single-process recording alone
does not prove that a display-wide frame table has that restriction.
"""

import argparse
import json
import math
import re
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


def tag(element):
    return element.tag.rsplit("}", 1)[-1]


def direct(element, name):
    return next((child for child in element if tag(child) == name), None)


def raw_text(element):
    return (element.text or "").strip() if element is not None else ""


def numeric(text):
    try:
        value = float(text.replace(",", ""))
        return value if math.isfinite(value) else None
    except (ValueError, AttributeError):
        return None


def unavailable(reason, **extra):
    return {"status": "unavailable", "reason": reason, **extra}


class Export:
    def __init__(self, path):
        self.path = str(path)
        self.root = ET.parse(path).getroot()
        self.ids = {e.get("id"): e for e in self.root.iter() if e.get("id")}
        self.percent_scale = self.verified_percent_scale()
        self.tables = []
        for parent in self.root.iter():
            schema = direct(parent, "schema")
            rows = [c for c in parent if tag(c) == "row"]
            if schema is not None:
                self.tables.append((schema, rows))
        if not self.tables:
            schema = next((e for e in self.root.iter() if tag(e) == "schema"), None)
            if schema is not None:
                self.tables.append((schema, [e for e in self.root.iter() if tag(e) == "row"]))

    def resolve(self, element):
        seen = set()
        while element is not None and element.get("ref"):
            ref = element.get("ref")
            if ref in seen:
                return None
            seen.add(ref)
            element = self.ids.get(ref)
        return element

    def number(self, element):
        element = self.resolve(element)
        return numeric(raw_text(element))

    def walk(self, element, seen=None):
        """Visit children of referenced backtraces as well as inline children."""
        element = self.resolve(element)
        seen = set() if seen is None else seen
        if element is None or id(element) in seen:
            return
        seen.add(id(element))
        yield element
        for child in element:
            yield from self.walk(child, seen)

    @staticmethod
    def formatted_percent(element):
        match = re.fullmatch(r"\s*([+-]?[\d.,]+)\s*%\s*", element.get("fmt", ""))
        if not match:
            return None, None
        value = numeric(match.group(1))
        decimals = len(match.group(1).split(".", 1)[1]) if "." in match.group(1) else 0
        return value, 0.5 * 10 ** -decimals + 1e-8

    def verified_percent_scale(self):
        scales = set()
        for element in self.root.iter():
            if tag(element) not in ("system-cpu-percent", "cpu-percent"):
                continue
            raw = numeric(raw_text(element))
            formatted, tolerance = self.formatted_percent(element)
            if raw is None or formatted is None:
                continue
            matches = [scale for scale in (1, 100) if abs(raw * scale - formatted) <= tolerance]
            if len(matches) == 1:
                scales.add(matches[0])
        return next(iter(scales)) if len(scales) == 1 else None

    def pid(self, element):
        element = self.resolve(element)
        if element is None:
            return None
        if tag(element) == "pid":
            value = self.number(element)
            return int(value) if value is not None and value.is_integer() else None
        # Follow process/thread references, but never infer a PID from a name.
        process = element if tag(element) == "process" else direct(element, "process")
        process = self.resolve(process)
        if process is not None:
            pid = self.resolve(direct(process, "pid"))
            value = self.number(pid)
            if value is None:
                value = numeric(process.get("pid", ""))
            if value is not None and value.is_integer():
                return int(value)
        return None

    def rows(self, names):
        for schema, rows in self.tables:
            name = schema.get("name", "")
            if name not in names:
                continue
            columns = []
            for col in schema:
                if tag(col) not in ("col", "column"):
                    continue
                mnemonic = col.get("mnemonic") or raw_text(direct(col, "mnemonic"))
                kind = (col.get("engineeringType") or raw_text(direct(col, "engineering-type"))
                        or raw_text(direct(col, "type")))
                columns.append((mnemonic, kind))
            for row in rows:
                cells = list(row)
                if len(cells) != len(columns):
                    yield name, {}, {}, "row/column count differs"
                    continue
                yield name, dict(zip((c[0] for c in columns), cells)), dict(columns), None

    def seconds(self, cell, kind):
        cell = self.resolve(cell)
        if cell is None:
            return None
        value = self.number(cell)
        # xctrace's time engineering types export integer nanoseconds. Their
        # formatted display values may use ms/us or mm:ss.xxx.xxx instead.
        ns_types = {"start-time", "event-time", "sample-time", "duration", "duration-on-core", "weight"}
        if value is not None and (kind in ns_types or tag(cell) in ns_types):
            return value / 1e9
        fmt = cell.get("fmt", "").strip()
        match = re.fullmatch(r"([+-]?[\d.,]+)\s*(ns|µs|μs|us|ms|s|sec)", fmt)
        if match:
            number = numeric(match.group(1))
            return number * {"ns": 1e-9, "µs": 1e-6, "μs": 1e-6, "us": 1e-6,
                             "ms": 1e-3, "s": 1, "sec": 1}[match.group(2)] if number is not None else None
        return None

    def percent(self, cell):
        cell = self.resolve(cell)
        if cell is None:
            return None
        raw = self.number(cell)
        formatted, tolerance = self.formatted_percent(cell)
        if formatted is None:
            return None  # No unverified assumption about fraction vs percent.
        if raw is not None:
            if self.percent_scale is not None and abs(raw * self.percent_scale - formatted) <= tolerance:
                return raw * self.percent_scale
            matches = [scale for scale in (1, 100) if abs(raw * scale - formatted) <= tolerance]
            if len(matches) == 1:
                return raw * matches[0]
        # A rounded zero can fit both scales. Keep the displayed value instead
        # of inventing sub-display precision until another row proves a scale.
        return formatted

    def row_pid(self, cells):
        for key in ("pid", "process", "thread"):
            value = self.pid(cells.get(key))
            if value is not None:
                return value
        return None


def interval_overlap(start, duration, begin, end):
    if start is None or duration is None or duration <= 0:
        return 0.0
    return max(0.0, min(start + duration, end) - max(start, begin))


def weighted_percentile(values, quantile):
    ordered = sorted((v, w) for v, w in values if w > 0)
    if not ordered:
        return None
    limit = sum(w for _, w in ordered) * quantile
    accumulated = 0.0
    for value, weight in ordered:
        accumulated += weight
        if accumulated >= limit:
            return value
    return ordered[-1][0]


def percentile(values, quantile):
    if not values:
        return None
    ordered = sorted(values)
    return ordered[max(0, math.ceil(quantile * len(ordered)) - 1)]


def cpu_summary(exports, args, begin, end):
    schemas = {name for export in exports for name, _, _, _ in
               export.rows({"activity-monitor-process-live", "sysmon-process"})}
    preferred = "activity-monitor-process-live" if "activity-monitor-process-live" in schemas else "sysmon-process"
    intervals, counters = [], []
    issues = Counter()
    for export in exports:
        points = []
        export_counters = []
        for name, cells, types, error in export.rows({preferred}):
            if error:
                issues[error] += 1
                continue
            if export.row_pid(cells) != args.pid:
                continue
            key = "start" if name == "activity-monitor-process-live" else "time"
            start = export.seconds(cells.get(key), types.get(key))
            duration = export.seconds(cells.get("duration"), types.get("duration"))
            percent = export.percent(cells.get("cpu-percent"))
            total = export.seconds(cells.get("cpu-total"), types.get("cpu-total"))
            if total is None and "cpu-total-user" in cells and "cpu-total-system" in cells:
                user = export.seconds(cells["cpu-total-user"], types.get("cpu-total-user"))
                system = export.seconds(cells["cpu-total-system"], types.get("cpu-total-system"))
                total = user + system if user is not None and system is not None else None
            if start is not None and total is not None:
                counter_time = start + duration if name == "activity-monitor-process-live" and duration is not None else start
                export_counters.append((counter_time, total))
            if start is None or percent is None or percent < 0:
                issues["CPU row missing a verified time or formatted percentage"] += 1
                continue
            if name == "activity-monitor-process-live":
                weight = interval_overlap(start, duration, begin, end)
                if weight:
                    intervals.append((start, duration, percent, weight))
            else:
                points.append((start, percent))
        # The final live interval may be extrapolated to the recording horizon;
        # its cumulative counter has no exported true sample timestamp. Earlier
        # closed intervals place that counter at start+duration. Raw sysmon rows
        # already carry the actual sample timestamp and need no such exclusion.
        export_counters = sorted(set(export_counters))
        if preferred == "activity-monitor-process-live":
            export_counters = export_counters[:-1]
        counters.extend((time, total) for time, total in export_counters if begin <= time <= end)
        for previous, current in zip(sorted(set(points)), sorted(set(points))[1:]):
            weight = interval_overlap(previous[0], current[0] - previous[0], begin, end)
            if weight:
                intervals.append((previous[0], current[0] - previous[0], current[1], weight))
    intervals = sorted(set(intervals))
    weighted = [(v, w) for _, _, v, w in intervals]
    result = unavailable("No usable CPU intervals for the requested PID", schema=preferred)
    if weighted:
        coverage = sum(w for _, w in weighted)
        ranges = sorted((max(start, begin), min(start + duration, end)) for start, duration, _, _ in intervals)
        merged = []
        for left, right in ranges:
            if merged and left <= merged[-1][1] + 1e-9:
                merged[-1][1] = max(merged[-1][1], right)
            else:
                merged.append([left, right])
        union_coverage = sum(right - left for left, right in merged)
        missing = []
        cursor = begin
        for left, right in merged:
            if left > cursor + 1e-6:
                missing.append([cursor, left])
            cursor = max(cursor, right)
        if math.isfinite(end) and cursor < end - 1e-6:
            missing.append([cursor, end])
        result = {"status": "available", "schema": preferred, "sample_count": len(weighted),
                  "covered_seconds": union_coverage,
                  "window_coverage_fraction": union_coverage / (end - begin) if math.isfinite(end) else None,
                  "overlapping_interval_seconds": max(0, coverage - union_coverage),
                  "uncovered_intervals_seconds": missing[:20],
                  "observed_interval_start_seconds": merged[0][0],
                  "observed_interval_end_seconds": merged[-1][1],
                  "mean_percent": sum(v * w for v, w in weighted) / coverage,
                  "time_weighted_p95_percent": weighted_percentile(weighted, .95),
                  "peak_sample_percent": max(v for v, _ in weighted),
                  "sample_interval_seconds_min": min(d for _, d, _, _ in intervals),
                  "sample_interval_seconds_max": max(d for _, d, _, _ in intervals)}
        if coverage - union_coverage > 1e-6:
            result.update(status="unavailable", reason="Overlapping CPU intervals would bias the aggregate; inspect source exports")
    counter_schema = preferred
    if preferred == "activity-monitor-process-live":
        raw_counters = []
        for export in exports:
            for _, cells, types, error in export.rows({"sysmon-process"}):
                if error or export.row_pid(cells) != args.pid:
                    continue
                time = export.seconds(cells.get("time"), types.get("time"))
                user = export.seconds(cells.get("cpu-total-user"), types.get("cpu-total-user"))
                system = export.seconds(cells.get("cpu-total-system"), types.get("cpu-total-system"))
                if time is not None and user is not None and system is not None and begin <= time <= end:
                    raw_counters.append((time, user + system))
        if len(set(raw_counters)) >= 2:
            counters, counter_schema = raw_counters, "sysmon-process"
    counters = sorted(set(counters))
    if len(counters) >= 2 and counters[-1][0] > counters[0][0] and counters[-1][1] >= counters[0][1]:
        elapsed = counters[-1][0] - counters[0][0]
        delta = counters[-1][1] - counters[0][1]
        result["cumulative_counter_cross_check"] = {"schema": counter_schema, "observed_seconds": elapsed, "cpu_seconds_delta": delta,
                                                     "mean_percent": delta / elapsed * 100,
                                                     "method": "Last minus first cumulative CPU time; counters are never summed. Live counters use closed interval ends and exclude the final potentially extrapolated interval."}
    if issues:
        result["excluded_rows"] = dict(issues)
    result["interpretation"] = "100% is one fully occupied CPU core; this is process CPU, not plugin-only CPU."
    return result


def frame_summary(exports, args, begin, end, device_scope=False):
    supported = {"coreanimation-lifetime-interval", "hitches-lifetime-interval", "hitches-summary", "hitches"}
    schemas = {name for export in exports for name, _, _, _ in export.rows(supported)}
    preferred = next((name for name in ("coreanimation-lifetime-interval", "hitches-lifetime-interval", "hitches", "hitches-summary") if name in schemas), None)
    if not preferred:
        raw_frames = sum(1 for export in exports for _ in export.rows({"hitches-frame-lifetimes"}))
        if raw_frames:
            return unavailable("hitches-frame-lifetimes has frame lifetime durations but no explicit hitch duration or process attribution; lifetime duration and frame color are not substituted for missed deadlines",
                               schema="hitches-frame-lifetimes", unattributed_frame_row_count=raw_frames)
        return unavailable("No supported frame or hitch rows were exported; an empty event table alone does not prove an intact zero-hitch recording")
    frames, issues, unattributed = {}, Counter(), 0
    for export in exports:
        for _, cells, types, error in export.rows({preferred}):
            if error:
                issues[error] += 1
                continue
            start = export.seconds(cells.get("start"), types.get("start"))
            duration = export.seconds(cells.get("duration"), types.get("duration"))
            if start is not None and duration is not None and (start + duration <= begin or start >= end):
                continue
            row_pid = export.row_pid(cells)
            if not device_scope and row_pid is not None and row_pid != args.pid:
                continue
            if not device_scope and row_pid is None and not args.frames_target_scoped:
                unattributed += 1
                continue
            hitch_key = "duration" if preferred in ("hitches-summary", "hitches") else "hitch-duration"
            hitch = export.seconds(cells.get(hitch_key), types.get(hitch_key))
            if hitch is None and hitch_key == "hitch-duration":
                narrative = export.resolve(cells.get("narrative"))
                # Current Core Animation exports use a sentinel for on-time
                # frames. Require the explicit recorded classification instead
                # of turning every absent value into zero.
                on_time = narrative is not None and any(
                    ": on-time" in raw_text(node).lower() for node in export.walk(narrative))
                if on_time:
                    hitch = 0.0
            if start is None or duration is None or hitch is None or min(duration, hitch) < 0:
                issues["Frame row missing supported time units or hitch duration"] += 1
                continue
            identity = tuple(export.number(cells.get(key)) for key in ("display-id", "lifetime-id", "hitch-id", "swap-id", "frame-seed"))
            key = (start, identity)
            # A hitch occupies the end of a frame lifetime. Clip to the window.
            clipped = interval_overlap(start + duration - hitch, hitch, begin, end) if hitch else 0
            frames[key] = max(frames.get(key, 0), clipped)
    if not frames:
        return unavailable("Frame attribution is unverified" if unattributed else "No usable target frame rows in the requested window",
                           schema=preferred, unattributed_row_count=unattributed, excluded_rows=dict(issues))
    positive = [value * 1000 for value in frames.values() if value > 0]
    result = {"status": "available", "schema": preferred, "observed_frame_or_hitch_rows": len(frames),
              "hitch_count": len(positive), "summed_hitch_ms": sum(positive),
              "positive_hitch_p95_ms": percentile(positive, .95),
              "positive_hitch_p99_ms": percentile(positive, .99),
              "maximum_hitch_ms": max(positive) if positive else 0,
              "attribution": ("Exported device/display scope; cannot attribute these frames to the target process" if device_scope else
                              "Verified externally with --frames-target-scoped" if args.frames_target_scoped else "PID present on each accepted row"),
              "unattributed_row_count": unattributed, "excluded_rows": dict(issues),
              "interpretation": "Hitches use recorded presentation deadlines. No fixed-refresh-rate dropped-frame estimate is made."}
    if preferred in ("hitches-summary", "hitches"):
        result["frame_count"] = unavailable("This schema contains only hitches, not every presented frame")
    else:
        result["frame_count"] = len(frames)
        result["known_frame_hitch_fraction"] = len(positive) / len(frames)
    if device_scope:
        result["scope"] = "Exported device/display frames, not WeChat-only frames"
        result["target_process_attribution"] = unavailable("No frame-to-process ownership mapping was exported")
    return result


def display_fps_summary(exports, begin, end):
    values = []
    for export in exports:
        for _, cells, types, error in export.rows({"core-animation-fps-estimate"}):
            if error:
                continue
            start = export.seconds(cells.get("interval"), types.get("interval"))
            duration = export.seconds(cells.get("period"), types.get("period"))
            fps = export.number(cells.get("fps"))
            weight = interval_overlap(start, duration, begin, end)
            if fps is not None and fps >= 0 and weight:
                values.append((fps, weight))
    if not values:
        return unavailable("No usable Core Animation FPS estimate intervals")
    coverage = sum(weight for _, weight in values)
    return {"status": "available", "scope": "Device display estimate; no PID attribution",
            "sample_count": len(values), "covered_seconds": coverage,
            "time_weighted_mean_fps": sum(fps * weight for fps, weight in values) / coverage,
            "minimum_sample_fps": min(fps for fps, _ in values), "maximum_sample_fps": max(fps for fps, _ in values),
            "target_process_fps": unavailable("This schema has no process or surface-owner attribution"),
            "interpretation": "An estimate of display activity, not target-app animation FPS or a dropped-frame count. Static screens and variable refresh rates must not be judged against a fixed 60/120 FPS target."}


def commit_summary(exports, args, begin, end):
    commits, unknown = set(), 0
    for export in exports:
        for _, cells, types, error in export.rows({"coreanimation-commit-interval", "hitches-ca-commit-interval"}):
            if error:
                continue
            pid = export.row_pid(cells)
            if pid is None:
                unknown += 1
                continue
            if pid != args.pid:
                continue
            start = export.seconds(cells.get("start"), types.get("start"))
            duration = export.seconds(cells.get("duration"), types.get("duration"))
            if start is not None and begin <= start < end:
                commits.add((start, duration, export.number(cells.get("transaction"))))
    if not commits:
        return unavailable("No attributed Core Animation commit intervals for the requested PID", unattributed_row_count=unknown)
    finite_window = math.isfinite(end) and end > begin
    return {"status": "available", "commit_interval_count": len(commits),
            "commits_per_second": len(commits) / (end - begin) if finite_window else None,
            "unattributed_row_count": unknown,
            "interpretation": "Render commits are not model computations, reloadData calls or reloadRows calls."}


def sample_summary(exports, args, begin, end):
    count, total, group_count, group_weight, no_weight = 0, 0.0, 0, 0.0, 0
    functions = Counter()
    schemas = {name for export in exports for name, _, _, _ in export.rows({"time-profile", "userspace-time-samples"})}
    preferred = "time-profile" if "time-profile" in schemas else "userspace-time-samples"
    for export in exports:
        for _, cells, types, error in export.rows({preferred}):
            if error or export.row_pid(cells) != args.pid:
                continue
            time = export.seconds(cells.get("time"), types.get("time"))
            if time is None or not begin <= time < end:
                continue
            count += 1
            weight = export.seconds(cells.get("weight"), types.get("weight"))
            if weight is None or weight < 0:
                no_weight += 1
                continue
            total += weight
            stack = export.resolve(cells.get("stack"))
            names = set()
            if stack is not None:
                for frame in export.walk(stack):
                    if tag(frame) == "frame":
                        name = frame.get("name") or raw_text(direct(frame, "name"))
                        if name and args.group_regex.search(name):
                            names.add(name)
            if names:
                group_count += 1
                group_weight += weight  # Each sample counts once across all group frames.
                for name in names:
                    functions[name] += weight
    if not count or total <= 0:
        return unavailable("No attributed samples with usable weight units", schema=preferred,
                           sample_count=count, samples_missing_weight=no_weight)
    return {"status": "available", "schema": preferred, "sample_count": count,
            "samples_missing_weight": no_weight, "sampled_weight_ms": total * 1000,
            "group_sample_count": group_count, "group_sampled_weight_ms": group_weight * 1000,
            "group_sampled_weight_fraction": group_weight / total,
            "group_function_inclusive_weight_ms": {name: value * 1000 for name, value in functions.most_common(30)},
            "interpretation": "Sampling weight estimates CPU time. Inclusive function weights overlap; none of these values are invocation counts or per-round durations.",
            "symbolication_limit": "Unresolved function symbols cannot be matched. Zero matching group samples does not prove zero group work."}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--toc", type=Path, required=True)
    input_kinds = ("cpu", "frames", "commits", "samples", "fps")
    for name in input_kinds:
        parser.add_argument("--" + name, type=Path, action="append", default=[])
    parser.add_argument("--pid", type=int, required=True)
    parser.add_argument("--start-s", type=float, default=0)
    parser.add_argument("--end-s", type=float)
    parser.add_argument("--frames-target-scoped", action="store_true")
    parser.add_argument("--include-device-frame-observations", action="store_true",
                        help="Also summarize exported display frames, separately from target-attributed frames")
    parser.add_argument("--group-regex", type=re.compile, default=re.compile(r"CSGroup|CSNativeGroup|WESessionTab"))
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    if args.pid <= 0 or args.start_s < 0 or (args.end_s is not None and args.end_s <= args.start_s):
        parser.error("PID must be positive and the time window must have positive length")
    paths = list(dict.fromkeys(path for name in input_kinds for path in getattr(args, name)))
    try:
        toc = ET.parse(args.toc).getroot()
        exports = [Export(path) for path in paths]
    except (OSError, ET.ParseError) as error:
        parser.error(str(error))
    begin, end = args.start_s, args.end_s if args.end_s is not None else math.inf
    result = {"target_pid": args.pid, "window_seconds": {"start": begin, "end": args.end_s},
              "source_files": [str(args.toc)] + [str(p) for p in paths],
              "toc_schemas": sorted({e.get("schema") for e in toc.iter() if e.get("schema")}),
              "capture_integrity": "Not inferred from XML. Confirm recorder success separately; partial and failed recordings can still contain readable rows.",
              "cpu": cpu_summary(exports, args, begin, end),
              "frames": frame_summary(exports, args, begin, end),
              "display_fps_estimate": display_fps_summary(exports, begin, end),
              "render_commits": commit_summary(exports, args, begin, end),
              "group_sampling": sample_summary(exports, args, begin, end),
              "per_round_duration": unavailable("The unmodified 2.2-8 build has no per-round event boundaries"),
              "group_refresh_call_counts": unavailable("Sampling and render commits do not count group refresh/reload invocations")}
    if args.include_device_frame_observations:
        result["display_frame_observations"] = frame_summary(exports, args, begin, end, device_scope=True)
    output = json.dumps(result, ensure_ascii=False, indent=2, allow_nan=False) + "\n"
    if args.output:
        args.output.write_text(output)
    else:
        print(output, end="")


if __name__ == "__main__":
    main()
