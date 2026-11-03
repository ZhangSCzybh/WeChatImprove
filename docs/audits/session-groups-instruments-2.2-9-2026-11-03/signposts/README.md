# 2.2-9 观测构建 signpost 分析

本目录由离线分析任务维护，不负责设备连接、安装、启动或录制。`xcode-signpost-schemas.xml`、`schema-source.json` 与 `xctrace-*.txt` 只是当前 Xcode 的 host 能力参考，不是设备实测结果。实际 trace 完成后才统计生产事件；空 schema 或没有目标 PID 事件不能解释为零计算。

原生固定 subsystem 为 `com.wechatimprove.performance`，category 为 `SessionGroups`。需同时导出 `os-signpost` 与可用的 `os-signpost-arg`。解析时必须还原 XML `id/ref`，只接受确认的 PID、subsystem/category，按 `(PID, identifier, name)` 配对 begin/end；同步嵌套归属另要求同一线程。截断、缺尾、重复或不配对区间单列，不进入完整区间分位数。

计时是观测构建的同步墙钟耗时，包含探针开销，不是 CPU 时间，也不等于输入到呈现的延迟。同一调用树的模型、协调器、Adapter、reload 区间相互包含，不能相加。完整模型 API 的窗口外或协调器外调用单列，不自动算作主表重算。

输出需分别列出：

- `ModelFull`、`ModelDelta`、`ModelSelection` 的完整调用数、outcome、P50/P95/最大同步耗时，及属于 `CoordinatorApply` 的模型调用。
- `CoordinatorApply` 是候选应用尝试，Ready 不代表原生数组写入。
- `AdapterRefreshAttempt` 是刷新入口尝试，包括交互中等早退；`AdapterPublication` 是发布入口。
- `PublicationCompleted` 是已验证主表发布正常返回，可能只更新角标，没有 reload。
- `MainTableReloadData` / `MainTableReloadRows` 仅计同步原生发布作用域内、已验证目标与对应派发位的调用；入口、正常返回事件、请求行数分别统计。
- `TabRecordsUpdateAttempt`、`TabRecordsRebuilt`、`TabLayout` 分开，不能把布局等同按钮重建。
- `KnownChangeHint` / `UnknownChangeHint` 仅为来源提示与 changeKind 位掩码，不等于消息条数或确定的回退原因。

`MainTableTargetVerified` 的 `units` 为方法覆盖位：1=reloadData，2=reloadRows，3=两者；缺位或 `MainTableTargetUnavailable` 导致相应统计未取得，不能填零。若静置没有发布，必须有同进程及采集连续性的独立验证，才可描述为“覆盖作用域内未观察到调用”，不能扩大为全部宿主刷新 API 零次。

## 首次烟测

`smoke-summary-v2.json` 是首轮实际 XML 的当前汇总，`smoke-summary.json` 是同一输入的早期格式汇总，均非正式四场景性能结果。原始 XPath 在同一导出返回三张同名表，其中两张 SINGLE 表重复包含自有探针；解析器按精确事件身份跨表合并重复，保留原始 XML。当前独有 215 个自有事件：16 对 `TabRecordsUpdateAttempt`（均 `Unchanged`）和 183 个 `UnknownChangeHint(kind=8)`。首次出现 25.186632333 秒，最后 31.876369166 秒。没有模型、发布或主表目标事件，不能据此称为零模型计算、零主表刷新或有效切组场景。

`parser-validation-v2.json` 的 13 项离线检查（早期 `parser-validation.json` 保留）使用实际烟测输入及明确标注的丢尾/错 PID 等派生负对照，以及明确标为 parser-only 的嵌套/目标位掩码序列，只验证解析器，派生数据不进入设备实测汇总。脚本从不连接设备或修改源 trace/XML。

```sh
python3 signposts/analyze-signposts.py \
  --xml <scenario>-signposts.xml \
  --args-xml <scenario>-signpost-args.xml \
  --pid <confirmed-pid> --begin <seconds> --end <seconds> \
  --recording-status complete --output signposts/<scenario>-summary.json
```

`--recording-status` 来自外部 recorder 结果，不由可读 XML 推断。输出自动带输入 SHA256 及明细 JSON，拒绝覆盖已有分析文件。

`smoke-system-summary.json` 是第二份完成的 system 范围烟测，确认目标仍仅按 PID 40208 过滤。全 trace 有 260 个独有自有事件（19 对 Tab 更新，222 个 Unknown 提示），仍没有模型、发布或目标验证。预设 5–50 秒窗口仅覆盖其中 4 对 Tab 更新和 46 个 Unknown 提示；自有事件实际首次 48.634099833 秒，最后 56.328172708 秒。该分布须结合用户动作标注核对，不得假设整段预设窗口都在切组；也不能仅凭这个时间分布确定缺探针原因。

## 正式四景最终结果

- `four-scenes-observation.md` / `.json` 为四景最终汇总，依次读取 `idle-confirmed-summary.json`、`messages-summary.json`、`scroll-summary.json`、`switch-summary.json`。
- 正式主窗分别为 [25,65)、[25,70)、[25,65)、[25,70) 秒，录制结果均 exit 0，用户操作有效性另由各场景 `scenario-validity.json` 确认并在汇总保存哈希。
- 原生 ModelFull/Delta/Selection、CoordinatorApply、AdapterRefreshAttempt、AdapterPublication 和主表目标验证均未取得；这不代表 0 次计算/刷新。Tab 方法是进程类范围观测，不能当作当前可见主表的模型或实际刷新指标。
- `native-probe-coverage-diagnosis.md` 是有源码引用的候选解释，兼容路径状态未在真机确认。本轮没有修改生产或设备。
- `messages-active-sensitivity-summary.json` 仅是保留主窗之外的事后敏感性分析，不能替换正式消息主窗。
- 时间细节以 root 的 `scenario-timelines.json` 为最终主窗依据；`messages-timeline-exact.json` 和 `scroll-timeline-exact.json` 读取 operator-cues 全精度时间，未带 exact 的旧时间文件保留了初次转述的毫秒舍入（差异小于 0.4ms，未改变窗口）。
