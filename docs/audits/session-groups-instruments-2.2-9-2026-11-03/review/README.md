# Independent CPU, frame, and thermal review

This subtree belongs to a read-only reviewer. It does not record, attach to, install on, restart, or modify the device. The original 2.2-8 audit remains unchanged.

`independent-review.py` parses exported XML independently of the primary analyzer. It uses integer nanoseconds for timing/counter arithmetic and Decimal for raw CPU percentages. XML IDs/references are resolved with cycle and missing-reference rejection. It hashes its XML inputs in each result.

The four `baseline-2.2-8-*-independent.json` results were recomputed from the frozen old exports. All four reproduce the stored CPU mean, weighted P95, peak, classified lifetime count, positive hitch count, and attributed CA commit count. Every positive hitch with an exported acceptable latency satisfies `hitch-duration = duration - acceptable-latency` to within 1 ns. These old input files were read without modification.

The new capture can be reviewed using:

```sh
python3 independent-review.py \
  --toc ../SCENARIO/export/SCENARIO-toc.xml \
  --cpu ../SCENARIO/export/SCENARIO-cpu.xml \
  --sysmon ../SCENARIO/export/SCENARIO-sysmon-process.xml \
  --lifetime ../SCENARIO/export/SCENARIO-lifetime.xml \
  --commits ../SCENARIO/export/SCENARIO-commits.xml \
  --thermal ../SCENARIO/export/SCENARIO-thermal.xml \
  --pid TARGET_PID --begin WINDOW_BEGIN --end WINDOW_END \
  --output SCENARIO-independent.json
```

The result file must not already exist. Omit `--output` for a read-only rerun to standard output.

## Scenario selection

The first `idle/` capture contained user operations and was explicitly invalidated. `idle-independent.json` is an arithmetic check of that excluded sample only; it must not be used for the version comparison. The eligible replacement is `idle-confirmed-independent.json`, using the root-selected `[25,65)` 40 s window. The user confirmed that they did not touch the screen throughout this replacement capture.

`messages-independent.json` uses the cue-defined primary `[25,70)` 45 s window. The user confirmed about 60 s of sending, with no sends during the final few seconds; precise arrival counts and rates were not measured. `messages-active-sensitivity-independent.json` uses `[25,55)` 30 s as an auxiliary observation only. `messages-time-segments.json` shows the CPU change over three successive 15 s slices; a drop or probe silence does not establish message count or authorize replacing the primary window with a selected active segment.

The next scenario was started only after the previous device recording completed. Some Mac trace saving/postprocessing stages overlapped the next scenario's launch. Those host stages are outside the previous device recording and action window; this context is preserved rather than silently treating the recordings as fully sequential end-to-end jobs.

## Eligible primary results

`final-independent-review.json` contains 80 passing checks across the four eligible primary windows, including capture/export completion, operator eligibility, PID/window selection, CPU coverage/counter alignment, frame classification, thermal coverage, and source hashes. `baseline-crosscheck.json` contains 48 passing checks against the frozen old baseline. No production or historical-audit files were modified by this reviewer.

| Scenario | Window | Whole-WeChat CPU mean / P95 / interval peak | Device ALL classified lifetimes / positive hitches | Target CA commits | Thermal |
| --- | --- | --- | --- | --- | --- |
| idle-confirmed | 25–65 s | 5.433959% / 15.917499% / 16.883183% | 2399 / 0 | 2393 | Nominal 40 s |
| messages | 25–70 s | 17.452545% / 35.076505% / 37.799031% | 2768 / 24 | 2542 | Nominal 45 s |
| scroll | 25–65 s | 32.036320% / 55.607701% / 56.220775% | 3559 / 66 | 3559 | Nominal 40 s |
| switch | 25–70 s | 24.100481% / 32.632698% / 33.572407% | 3364 / 115 | 2347 | Nominal 45 s |

All four CPU windows have 100% union coverage, no overlapping CPU intervals, and no raw-counter resets. The largest absolute discrepancy between live percentages and raw counters over exactly the same timestamp span is 0.001329 percentage points. All 205 positive primary-window hitches agree with `duration - acceptableLatency`; unknown frame values were not converted to zero. All new lifetime tables have ALL scope, so their ratios describe recorded device/display lifetimes.

The messages sensitivity window `[25,55)` has 24.300047% CPU mean. Successive 15 s primary-window slices average 29.207858%, 19.392236%, and 3.757542%, confirming a marked workload change in the final slice. This is reported without inferring arrival count or replacing the primary cue-defined window. Idle continues to have approximately 59.825 target CA commits per second, which is a rendering observation, not evidence of group model recomputation.

## Required evidence outside XML arithmetic

- Confirm the bundle-to-PID mapping from the connected device and ensure that it did not restart during recording. A process name is insufficient because two WeChat applications exist on this device.
- Preserve the recorder exit, end reason, capture configuration, actual action labels, and any loss warnings. A readable XML file does not establish a complete capture, an actual performed action, or an enabled signpost collector.
- Confirm the expected plugin package through the user's installation report and loaded-library evidence where available. The whole-process CPU metric cannot isolate plugin CPU.
- Target frame ownership requires the TOC target process to be attached to the selected PID and the frame-lifetime table to have `target-pid=SINGLE`, unless a stronger per-frame ownership mapping exists. `ALL` rows with no PID remain device/display scope.

## Interpretation rules

- CPU means and P95 use clipped interval-duration weights. Coverage is the union of intervals; overlapping samples and gaps are reported. Raw cumulative user+system counters use last minus first over their own explicitly reported timestamp span, never a sum of cumulative values. Counter resets invalidate the cross-check.
- CPU peaks refer to the approximately one-second interval peak, rather than an instantaneous peak. A raw CPU percentage is used only when its scaling agrees with the exported formatted percentage. 100% denotes one occupied CPU core.
- Frame identities use start, display ID, lifetime ID, swap ID, and frame seed. An absent hitch is zero only if it is a sentinel and the recorded narrative explicitly says on-time. Unknown and invalid values are rejected. Positive hitches are clipped to the analysis window and checked against acceptable latency when available.
- Classified lifetime density is not animation FPS. Positive hitch record counts are not exact dropped display-refresh counts. The device-wide legacy FPS estimate is not a target-app FPS metric.
- CA commits are rendering transactions, rather than group refresh/reload call counts. Native signposts must provide the latter with their published scope and validation limits.
- Thermal states use the overlap of each interval with the same analysis window. Device thermal state does not establish a causal process or actual CPU throttling. Report both state seconds and fractions; do not silently compare Fair-heavy and Nominal windows as thermally controlled experiments.
- The 2.2-8 static and switching traces used ALL frame scope. Their frame statistics cannot be relabeled as app-specific in the comparison. Its switching window was 15.358 s Nominal and 29.642 s Fair. Its old build has no native interval/call probes, so exact per-round or refresh-count before/after columns must remain unavailable for that version.
- The new installed package is an observation build. Its timings are synchronous wall-clock durations including observation overhead, not CPU time or click-to-first-frame latency. Until the same-device release / observation-disabled / observation-enabled comparison is performed, process CPU deltas are descriptive observations, not a causal estimate of the production optimization or zero-overhead model time.
