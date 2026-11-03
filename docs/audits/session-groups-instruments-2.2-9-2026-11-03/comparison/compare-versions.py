#!/usr/bin/env python3
"""Offline, scope-aware comparison of 2.2-8 and 2.2-9 Instruments summaries.

Reads only exported summaries/capture metadata. It never connects to a device,
records a trace, changes a package, or writes into the frozen 2.2-8 audit.
"""

import argparse
import hashlib
import json
import math
from pathlib import Path


SCENARIOS = ("idle", "messages", "scroll", "switch")
LABELS = {"idle": "静置", "messages": "连续收消息", "scroll": "滚动", "switch": "切组"}
ALIASES = {"scrolling": "scroll", "switch-system": "switch", "switching": "switch"}
BASELINE_DEFAULT = Path(__file__).resolve().parent / "baseline.json"
CAUTION = [
    "CPU 是目标微信整个进程；100% 表示一个核心满负荷。差异是本次采集的描述性变化，不能归因于插件。",
    "2.2-9+observe 含额外 signpost 探针，2.2-8 没有；未取得同负载探针开销对照，不能当成正式版净收益。",
    "人工消息节奏、滚动与切组速度、会话数据和缓存状态并非严格相同。单次顺序采集不支持因果或显著性结论。",
    "2.2-8 切组窗口含 65.87% Fair 热状态；其余三景为 Nominal。Fair 不等同于已证明降频。",
    "CA 提交是渲染事务，不能代替模型轮数、分组刷新、reloadData 或 reloadRows 次数。",
    "hitch 是错过呈现截止时间的帧生命周期；占比按已分类记录计算，不能反推精确掉帧数或真实应用 FPS。",
    "2.2-8 静置和切组为设备显示范围 ALL，收消息和滚动为已核对目标微信范围 SINGLE；归属不同的两次帧数据不计算差异。",
    "2.2-8 没有分组轮次和刷新 signpost，相关指标只能报告 2.2-9 实测，旧值未取得，不能填零或计算改善比例。",
]


def read(path):
    return json.loads(Path(path).read_text())


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def canonical(name):
    return ALIASES.get(name, name)


def finite(value):
    return isinstance(value, (int, float)) and not isinstance(value, bool) and math.isfinite(value)


def source_record(path):
    path = Path(path).resolve()
    return {"path": str(path), "sha256": digest(path)}


def explicit_invalidity(*records):
    """Reject explicit action contamination; do not equate an absent flag with proof."""
    rejected = {"invalid", "excluded", "contaminated", "rejected"}
    keys = ("validity", "validity_status", "scenario_validity", "measurement_validity",
            "operator_scenario_validity", "analysis_validity")
    for record in records:
        if record.get("eligible_for_final_comparison") is False:
            return "eligible_for_final_comparison=false: " + str(record.get("reason", ""))
        for key in ("invalidated", "contaminated", "exclude_from_analysis"):
            if record.get(key) is True:
                return key
        for key in keys:
            value = record.get(key)
            if isinstance(value, dict):
                if str(value.get("status", "")).lower() in rejected:
                    return f"{key}: {value}"
            elif isinstance(value, str) and value.lower() in rejected:
                return f"{key}: {value}"
    return None


def normalize(entry, path, capture=None):
    """Accept the original analyzer schema or its published scenario wrapper."""
    name = canonical(entry.get("scenario", Path(path).parent.name))
    window = entry.get("window_seconds", entry.get("analysis_window_seconds", {}))
    duration = entry.get("analyzed_seconds")
    if duration is None and finite(window.get("start")) and finite(window.get("end")):
        duration = window["end"] - window["start"]
    context = entry.get("capture_context", {})
    capture = capture or {}
    exit_code = context.get("recorder_exit_code", capture.get("exit_code"))
    target_frames = entry.get("frames", entry.get("frame_lifetime_metrics", {}))
    display_frames = entry.get("display_frame_observations", {})
    uses_display_observations = target_frames.get("status") != "available" and display_frames.get("status") == "available"
    frames = display_frames if uses_display_observations else target_frames
    text = " ".join(str(s) for s in (
        entry.get("frame_scope", ""), frames.get("scope", ""),
        context.get("frame_scope_proof", ""), frames.get("attribution", "")))
    # Explicit display scope wins; never infer app ownership from --attach alone.
    if uses_display_observations or any(s in text for s in ("target-pid=ALL", "Device/display", "device/display", "device/display frames", "display scope")):
        scope = "device_display"
    elif any(s in text for s in ("target-pid=SINGLE", "WeChat target scope", "Verified externally with --frames-target-scoped")):
        scope = "target_wechat"
    else:
        scope = "unknown"
    return {
        "scenario": name,
        "label_zh": LABELS.get(name, name),
        "target_pid": entry.get("target_pid", capture.get("target_pid")),
        "bundle_id": capture.get("bundle_id"),
        "window_seconds": window,
        "analyzed_seconds": duration,
        "recorder_exit_code": exit_code,
        "capture_trace_present": capture.get("trace_present"),
        "cpu": entry.get("cpu", entry.get("cpu_process", {})),
        "render_commits": entry.get("render_commits", entry.get("core_animation_commits", {})),
        "frames": frames,
        "target_frames": target_frames,
        "display_frame_observations": display_frames,
        "frame_metric_source": "display_frame_observations" if uses_display_observations else "frames",
        "frame_scope_class": scope,
        "frame_scope_evidence": text,
        "thermal_state_observations": entry.get("thermal_state_observations", {}),
        "per_round_duration": entry.get("per_round_duration", {"status": "unavailable", "reason": "No per-round duration summary supplied"}),
        "group_refresh_call_counts": entry.get("group_refresh_call_counts", {"status": "unavailable", "reason": "No exact refresh count summary supplied"}),
        "signpost_summary": entry.get("signpost_summary"),
        "capture_context": context,
        "explicit_invalidity": explicit_invalidity(entry, capture, context),
        "source": source_record(path),
    }


def baseline(old_root, target):
    """Extract immutable baseline plus hashes; leave every old file unchanged."""
    old_root = Path(old_root).resolve()
    table_path = old_root / "scenario-comparison.json"
    table = read(table_path)
    scenarios = []
    sources = [source_record(table_path)]
    for entry in table["scenarios"]:
        folder = old_root / entry["scenario"]
        summary_path = folder / "summary.json"
        capture_path = folder / "capture-result.json"
        capture = read(capture_path)
        # Published table carries independently checked thermal/scope metadata.
        enriched = {**read(summary_path), **entry}
        # Older ALL summaries kept target frames unavailable and published the
        # separately checked display metrics only in the scenario wrapper.
        # Preserve that distinction while retaining those display observations.
        if (enriched.get("frames", {}).get("status") != "available" and
                entry.get("frame_lifetime_metrics", {}).get("status") == "available" and
                "Device/display" in entry.get("frame_scope", "")):
            enriched["display_frame_observations"] = entry["frame_lifetime_metrics"]
        enriched["target_pid"] = table["target_pid"]
        normalized = normalize(enriched, summary_path, capture)
        normalized["capture_source"] = source_record(capture_path)
        scenarios.append(normalized)
        sources += [source_record(summary_path), source_record(capture_path)]
    result = {
        "version": "2.2-8",
        "version_evidence": "User confirmed installed version; plugin UUID was not independently exported",
        "wechat_version": table["wechat_version_reported_by_user"],
        "ios_version": table["ios_version"],
        "device": table["device"],
        "target_pid": table["target_pid"],
        "bundle_id": "com.tencent.xin",
        "scenarios": scenarios,
        "source_files": sources,
        "interpretation_notes": table["interpretation_notes"],
        "unavailable_metrics": table["unavailable_metrics"],
    }
    Path(target).write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    return result


def load_current(root, explicit):
    root = Path(root).resolve()
    paths = {}
    for name in SCENARIOS:
        # The first idle capture was explicitly contaminated by user actions.
        # Never silently promote it when the confirmed rerun is absent.
        candidates = ("idle-confirmed",) if name == "idle" else (("switch", "switch-system") if name == "switch" else (name,))
        for candidate in candidates:
            file = root / candidate / "summary.json"
            if file.exists():
                paths[name] = file
                break
    for item in explicit:
        key, path = item.split("=", 1)
        paths[canonical(key)] = Path(path).resolve()
    result = []
    for name in SCENARIOS:
        if name not in paths:
            result.append({"scenario": name, "status": "unavailable", "reason": "Current scenario summary not yet produced"})
            continue
        file = paths[name]
        entry = read(file)
        entry["scenario"] = name
        capture_path = file.parent / "capture-result.json"
        capture = read(capture_path) if capture_path.exists() else {}
        normalized = normalize(entry, file, capture)
        if capture_path.exists():
            normalized["capture_source"] = source_record(capture_path)
        validity_path = file.parent / "scenario-validity.json"
        if validity_path.exists():
            validity = read(validity_path)
            normalized["scenario_validity"] = validity
            normalized["scenario_validity_source"] = source_record(validity_path)
            normalized["explicit_invalidity"] = normalized["explicit_invalidity"] or explicit_invalidity(validity)
        # Optional sidecar created by a separate native-signpost analyzer.
        for sidecar_name in ("signpost-summary.json", "signposts-summary.json"):
            sidecar = file.parent / sidecar_name
            if sidecar.exists():
                normalized["signpost_summary"] = read(sidecar)
                normalized["signpost_source"] = source_record(sidecar)
                break
        result.append(normalized)
    return result


def metric_delta(old, new):
    if not finite(old) or not finite(new):
        return {"status": "unavailable", "reason": "One or both values are unavailable"}
    return {"status": "available", "baseline": old, "current": new,
            "absolute_change": new - old,
            "relative_change_percent": (new / old - 1) * 100 if old else None}


def make_comparison(old, new):
    if new.get("status") == "unavailable":
        return {"scenario": old["scenario"], "label_zh": old["label_zh"], "status": "pending", "reason": new["reason"], "baseline": old}
    oc, nc = old["cpu"], new["cpu"]
    target_verified = (old["bundle_id"] == new["bundle_id"] == "com.tencent.xin" and
                       old["target_pid"] is not None and new["target_pid"] is not None)
    capture_ready = (old["recorder_exit_code"] == new["recorder_exit_code"] == 0 and target_verified and
                     not old.get("explicit_invalidity") and not new.get("explicit_invalidity") and
                     old.get("capture_trace_present") is not False and new.get("capture_trace_present") is not False)
    cpu_ready = (capture_ready and
                 oc.get("status") == nc.get("status") == "available" and
                 all(finite(c.get("window_coverage_fraction")) and c["window_coverage_fraction"] >= 0.999999 for c in (oc, nc)))
    cpu = {"status": "available" if cpu_ready else "unavailable",
           "interpretation": "Descriptive whole-WeChat process comparison; not plugin attribution or a causal improvement estimate"}
    if cpu_ready:
        cpu.update({key: metric_delta(oc.get(key), nc.get(key)) for key in
                    ("mean_percent", "time_weighted_p95_percent", "peak_sample_percent")})
    else:
        cpu["reason"] = "Require same verified com.tencent.xin bundle, known target PIDs, recorder exit 0, no explicit contamination/exclusion, trace present, usable CPU summaries, and complete window coverage for both versions"
    orc, nrc = old["render_commits"], new["render_commits"]
    commits_ready = (capture_ready and orc.get("status") == nrc.get("status") == "available")
    commits = {"status": "available" if commits_ready else "unavailable",
               "counts": {"baseline": orc.get("commit_interval_count"), "current": nrc.get("commit_interval_count")},
               "per_second": metric_delta(orc.get("commits_per_second"), nrc.get("commits_per_second")) if commits_ready else {"status": "unavailable", "reason": "Require successful target-verified captures and usable render summaries"},
               "interpretation": "Counts depend on window duration; compare rates. These are CA transactions, not group refresh counts."}
    of, nf = old["frames"], new["frames"]
    frame_ready = (old["frame_scope_class"] == new["frame_scope_class"] != "unknown" and
                   of.get("status") == nf.get("status") == "available" and
                   capture_ready)
    frames = {"status": "available" if frame_ready else "not_comparable",
              "baseline_scope": old["frame_scope_class"], "current_scope": new["frame_scope_class"],
              "interpretation": "Same-scope descriptive comparison only; device_display does not attribute hitches to WeChat."}
    if frame_ready:
        frames.update({key: metric_delta(of.get(key), nf.get(key)) for key in
                       ("known_frame_hitch_fraction", "maximum_hitch_ms", "positive_hitch_p95_ms")})
        for key in ("hitch_count", "frame_count"):
            frames[key] = {"baseline": of.get(key), "current": nf.get(key)}
    else:
        frames["reason"] = "Require identical, verified frame ownership scope, usable metrics, and successful capture; do not compare ALL with SINGLE"
    return {"scenario": old["scenario"], "label_zh": old["label_zh"], "status": "analyzed",
            "baseline": old, "current": new, "cpu_comparison": cpu,
            "render_commit_comparison": commits, "hitch_comparison": frames,
            "per_round_and_refresh_comparison": {"status": "baseline_unavailable", "baseline": "未取得；禁止填零",
                "current_duration": new["per_round_duration"], "current_refresh_counts": new["group_refresh_call_counts"],
                "current_signpost_summary": new.get("signpost_summary"),
                "interpretation": "Only current-version measurements are possible; 2.2-8 has no matching event boundaries/counters"}}


def number(value, digits=2):
    return f"{value:.{digits}f}" if finite(value) else "未取得"


def md(result):
    rows = ["# 2.2-8 与 2.2-9+observe 真机结果对比", "",
            "这是两次人工操作采样的描述性对照。表中 CPU 为整微信进程；2.2-9 含观测探针。", "",
            "| 场景 | 有效时长 旧 / 新 | CPU 均值 旧 → 新 | 变化（百分点） | CPU P95 旧 → 新 | 约 1 秒 CPU 峰值 旧 → 新 | CA 提交/秒 旧 → 新 |", 
            "| --- | ---: | ---: | ---: | ---: | ---: | ---: |"]
    for s in result["scenarios"]:
        old, new = s["baseline"], s.get("current")
        if not new:
            rows.append(f"| {s['label_zh']} | {number(old['analyzed_seconds'])} / 待采集 | 待采集 | — | — | — | — |")
            continue
        oc, nc = old["cpu"], new["cpu"]
        comp = s["cpu_comparison"]
        change = comp.get("mean_percent", {}).get("absolute_change")
        cpu_cells = [f"{number(oc.get(k))}% → {number(nc.get(k))}%" for k in
                     ("mean_percent", "time_weighted_p95_percent", "peak_sample_percent")]
        if comp["status"] != "available":
            cpu_cells = ["证据待核验"] * 3
        ca = f"{number(old['render_commits'].get('commits_per_second'))} → {number(new['render_commits'].get('commits_per_second'))}"
        if s["render_commit_comparison"]["status"] != "available":
            ca = "证据待核验"
        rows.append(f"| {s['label_zh']} | {number(old['analyzed_seconds'])} / {number(new['analyzed_seconds'])} 秒 | {cpu_cells[0]} | {number(change)} | {cpu_cells[1]} | {cpu_cells[2]} | {ca} |")
    rows += ["", "| 场景 | 帧范围 旧 / 新 | Hitch/已分类记录 旧 → 新 | Hitch 占比 旧 → 新 | 最长 Hitch 旧 → 新 | 差异解释 |", "| --- | --- | ---: | ---: | ---: | --- |"]
    for s in result["scenarios"]:
        if "current" not in s:
            continue
        old, new, comp = s["baseline"], s["current"], s["hitch_comparison"]
        of, nf = old["frames"], new["frames"]
        counts = f"{of.get('hitch_count', '未知')}/{of.get('frame_count', '未知')} → {nf.get('hitch_count', '未知')}/{nf.get('frame_count', '未知')}"
        frac = lambda f: number(f.get("known_frame_hitch_fraction") * 100 if finite(f.get("known_frame_hitch_fraction")) else None, 3) + "%"
        explanation = "同范围描述性对照" if comp["status"] == "available" else "归属或有效性不同，不计算差异"
        rows.append(f"| {s['label_zh']} | {old['frame_scope_class']} / {new['frame_scope_class']} | {counts} | {frac(of)} → {frac(nf)} | {number(of.get('maximum_hitch_ms'))} → {number(nf.get('maximum_hitch_ms'))} ms | {explanation} |")
    rows += ["", "分组每轮计算耗时、精确刷新与 reload 次数：2.2-8 **未取得**。2.2-9 仅对实际捕获且作用域验证有效的探针报告，详情见对应场景报告；缺失的模型/发布探针不能写成零次或零耗时。不能为缺失的旧值填零，也不能据此计算相对耗时或刷新次数降幅。", "", "解释边界：", ""]
    rows += [f"- {note}" for note in result["interpretation_notes"]]
    rows += ["", "热状态（分析窗口秒数）：", ""]
    for s in result["scenarios"]:
        if "current" in s:
            states = lambda which: json.dumps(s[which].get("thermal_state_observations", {}).get("window_state_seconds", {}), ensure_ascii=False)
            rows.append(f"- {s['label_zh']}：2.2-8 {states('baseline')}；2.2-9 {states('current')}。空对象表示当前摘要没有提供热状态，不代表 Nominal。")
    return "\n".join(rows) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline", type=Path, default=BASELINE_DEFAULT)
    parser.add_argument("--extract-baseline", type=Path, help="Frozen old audit to read; only writes --baseline")
    parser.add_argument("--current-root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--scenario-summary", action="append", default=[], help="Optional explicit canonical_name=/path/summary.json; repeat as needed")
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parent / "version-comparison.json")
    args = parser.parse_args()
    if args.extract_baseline:
        baseline(args.extract_baseline, args.baseline)
    old = read(args.baseline)
    current = {s["scenario"]: s for s in load_current(args.current_root, args.scenario_summary)}
    result = {"baseline_version": "2.2-8", "current_version": "2.2-9+observe",
              "comparison_kind": "Descriptive, not controlled; no causal/plugin-only CPU attribution",
              "baseline_source": source_record(args.baseline),
              "scenarios": [make_comparison(s, current[s["scenario"]]) for s in old["scenarios"]],
              "interpretation_notes": CAUTION}
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    args.output.with_suffix(".md").write_text(md(result))
    print(json.dumps({"json": str(args.output), "markdown": str(args.output.with_suffix('.md')),
                      "scenario_status": {s['scenario']: s['status'] for s in result['scenarios']}}, ensure_ascii=False))


if __name__ == "__main__":
    main()
