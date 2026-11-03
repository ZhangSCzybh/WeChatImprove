# 2.2-8 与 2.2-9+observe 对比方法

此目录只进行离线分析。不会连接手机、启动或停止录制、安装插件、修改分组设置或改写旧版证据。`baseline.json` 从已冻结的旧 audit 提取；其中每个来源摘要、采集记录和总表均保留 SHA256。旧版本为用户确认实际安装的 **2.2-8**，并非最初口述的 2.2-7。

## 新版场景汇总入口

`summarize-current.py` 只调用本地 Python 主分析器。先确认场景 `capture-result.json` 为 exit 0 且 trace 存在、导出 manifest 为完整、必要 XML 的 SHA256/字节数一致、TOC 结束原因为 time limit 且覆盖主窗口、独立 review 与主分析同 PID/窗口/源文件且数值一致，然后才生成该景 `primary-summary.json` 和 `summary.json`。

```sh
python3 docs/audits/session-groups-instruments-2.2-9-2026-11-03/comparison/summarize-current.py \
  --scene-folder docs/audits/session-groups-instruments-2.2-9-2026-11-03/idle-confirmed \
  --prefix idle-confirmed --begin 25 --end 65 \
  --review docs/audits/session-groups-instruments-2.2-9-2026-11-03/review/idle-confirmed-independent.json
```

`--review` 默认使用 `review/{场景目录名}-independent.json`，`--output-dir` 可将本地烟测汇总放到 comparison 子目录。默认拒绝覆盖已生成摘要；确需重算生成文件时使用 `--overwrite`，不会改写任何原始证据。首轮污染静置的 `scenario-validity.json` 会在生成前直接拒绝。

该入口只接受本轮实际采用的 ALL 帧表：`frames` 始终保留目标归属不可用，完整的设备显示数据放在 `display_frame_observations`，热状态从同窗口独立 review 转入。对比器在目标 `frames` 不可用且设备显示数据可用时，显式选择后者并标为 `device_display`，同时保留 `target_frames`；不会把 ALL 数据改写为微信帧。

若 `signposts/{场景目录名}-summary.json` 已存在，会核对同 PID/窗口后完整嵌入。主模型与发布探针未捕获时仍保持未取得；分组栏更新耗时不能冒充每轮分组模型计算耗时。

入口已对真实 `smoke-system` 的完整导出及独立复算 [5,50) 秒进行本地验证，结果在 `summarizer-smoke/`；没有触发设备操作。`summarizer-validation.json` 记录归属保留、跨范围禁比和污染拒绝检查。

## 输入与运行

`compare-versions.py` 默认读取新 audit 下 `idle-confirmed/summary.json`、`messages/summary.json`、`scroll/summary.json`、`switch/summary.json`；也兼容 `switch-system` 目录。首轮 `idle/` 录制已被用户明确确认混入操作，**不会作为默认静置结果**。若重采摘要尚未产出，静置保持 pending。摘要沿用旧 `analyze-trace.py` 的实际字段：

- `target_pid`、`window_seconds.start/end`。
- `cpu.status/schema/mean_percent/time_weighted_p95_percent/peak_sample_percent/window_coverage_fraction`。
- `render_commits.status/commit_interval_count/commits_per_second`。
- `frames.status/hitch_count/frame_count/known_frame_hitch_fraction/maximum_hitch_ms/positive_hitch_p95_ms`。
- `capture_context.recorder_exit_code/frame_scope_proof`，同目录 `capture-result.json` 提供 `bundle_id/target_pid/exit_code/trace_present`。
- `thermal_state_observations.window_state_seconds`（应由实际 thermal 导出得到，不能默认 Nominal）。
- 若摘要或 capture 中 `scenario_validity/validity/measurement_validity` 等状态明确为 `invalid/excluded/contaminated/rejected`，或 `invalidated/contaminated/exclude_from_analysis=true`，不产生可用 CPU、CA 或 hitch 差异。重采不能靠清除已知污染标记复用首轮数据。
- 同目录 `scenario-validity.json` 会被读取并记录哈希；`eligible_for_final_comparison:false` 明确拒绝最终对比。
- 可选 `per_round_duration/group_refresh_call_counts/signpost_summary`。同目录若存在 `signpost-summary.json` 或 `signposts-summary.json`，会完整嵌入并记录哈希。

也接受总表格式中的 `analysis_window_seconds/cpu_process/core_animation_commits/frame_lifetime_metrics` 字段，但默认按各景摘要读取，避免误用未验证的总表。

在项目根目录运行：

```sh
python3 docs/audits/session-groups-instruments-2.2-9-2026-11-03/comparison/compare-versions.py
```

如最终主窗口摘要采用其他文件名，可覆盖一个或多个默认路径（其余场景继续按默认位置发现）：

```sh
python3 docs/audits/session-groups-instruments-2.2-9-2026-11-03/comparison/compare-versions.py \
  --scenario-summary idle=/absolute/path/idle/summary.json \
  --scenario-summary messages=/absolute/path/messages/summary.json \
  --scenario-summary scroll=/absolute/path/scroll/summary.json \
  --scenario-summary switch=/absolute/path/switch/summary.json
```

产物为 `version-comparison.json`（完整精度、来源哈希、各项可比较状态）及 `version-comparison.md`（人工可读表）。没有新景摘要时输出 pending，禁止拿旧版数字冒充新版。缺失的旧版分组耗时/精确刷新值永远标为未取得。

## 比较规则

CPU 必须来自用户确认的 `com.tencent.xin`，有明确目标 PID，采集退出 0，摘要状态可用，主窗口覆盖率至少 99.9999%。报告均值、按时长加权 P95 和约 1 秒最高样本。绝对变化单位为百分点，例如 20% → 15% 为 **-5 个百分点**；相对变化为 -25%，两者不能混写。这是整微信进程的采样差异，不是插件独占 CPU，也不能单次归因于优化。

CA 提交按目标 PID 筛选。原始次数随窗口长度变化，对照优先用次数/秒；它不能替代分组刷新、模型计算或表格 reload 次数。采集或归属未核验时不产生可用差异。

帧比较要求两版均采集成功且归属明确相同。旧版静置和切组为设备显示范围 `ALL`，消息和滚动为目标微信 `SINGLE`。若新版四景都能取得目标归属，那么旧静置/切组只能并排列出原始值，不能与新版微信 hitch 比例计算降幅。两版都为设备范围时也只能描述设备显示，不能归因于微信。Hitch 比例的分母是已分类生命周期记录，不能用固定 60/120 Hz 换算精确掉帧数。

旧版切组主窗口 [25,70) 秒包含 Nominal 15.358 秒、Fair 29.642 秒（65.87%）；其余旧景为 Nominal。若新版全为 Nominal，切组尤其不能称为同温度受控优化收益。Fair 本身不能证明降频。

人工消息节奏、滚动/切组速度、数据量、缓存、录制顺序和设备热状态均可能影响结果。新版为独立观测构建，旧版没有这些额外探针；本轮若没有相同负载下带/不带探针的对照，就不能扣除或臆测探针开销。可报告“本次观测值变化”，不能宣称“正式版纯插件 CPU 降低了 X%”。

## 基线冻结检查

初次提取：

```sh
python3 docs/audits/session-groups-instruments-2.2-9-2026-11-03/comparison/compare-versions.py \
  --extract-baseline docs/audits/session-groups-instruments-2026-11-03
```

只有新目录下的 `baseline.json` 被写入。重跑对比不需要重新提取。提取读取旧总表中的独立热状态、归属核对和最终主窗口；不会采用旧采集记录里早期计划窗口覆盖最终人工选定窗口。
