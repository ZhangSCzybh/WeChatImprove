# 返回聊天列表的可选现场观察

**本轮未在设备执行，未附加、启动、安装微信或诊断插件。** `runtime-availability.json` 保存父任务已有的设备通道检查；本文件没有重复检查。`runtime-top-chrome-probe.js` 只做离线源码审阅及 Node 语法检查；语法通过不代表 Frida Objective-C bridge、编码解析、ABI、具体微信/插件版本或注入环境已经验证。当前所有真机次数、实际 banner 迁移顺序和空白帧数均为 **unknown**。

脚本是临时、可选的 `Interceptor.attach` 观察器，不加入生产包或正式测试。不替换 IMP，不写参数/返回值，不主动调用 `getBanner:`、过滤/策略 getter、刷新、布局、角标 setter 或其它业务方法；不写设置/数据，不发送消息，也不调用现有诊断 reset 方法。`start()` 和手动 `snapshot()` 各做一次主线程 adapter 堆扫描，并读取既有 adapter/view 属性；不是定时轮询。方法观察、堆遍历和 getter/日志仍会扰动时序，不能用采样判断性能。

## 启动与范围

先核对实际设备、已运行微信的 PID、微信版本、已加载插件版本及原有分组/搜索/密友状态。保留用户账号、数据库、开关、未读和保护名单，不为观察重置或切换它们。不要把工作区版本自动当成手机版本。本轮没有执行安装、附加及设备操作。

在现成且兼容的 Frida/Objective-C bridge 环境中，可选地附加到已经运行的准确 PID；占位符须换成核对过的值和输出位置，不要使用 spawn 模式：

```text
frida -U -p <实际微信PID> -l /Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/release-2.1-29-top-chrome-return-flicker/runtime-top-chrome-probe.js -o <本次本地日志绝对路径>
```

加载后先检查 `observer-ready` 中的 `coverage`。出现 bridge 不可用、签名不符或安装失败时，保留错误类别，不能把相应计数当 0；这里不要求安装/升级工具或绕过环境问题。每次新进程须重新核对并附加；对象别名仅在同一次进程采样中可比较。

**采样必须覆盖进入聊天前的列表基准、进入聊天及返回，不能只在返回后开始。** 在能自然经过一次正常列表展示之前执行：

```javascript
topChrome29.start("chat-return")
```

然后按平时 UI 路径进入列表建立基准，进入一个原本就要查看的聊天，再自然返回列表。不要为采样发送消息、清空未读、主动触发刷新/布局或改变密友设置。在进入聊天前和返回稳定后可分别执行：

```javascript
topChrome29.snapshot()
```

完成一次往返后执行：

```javascript
topChrome29.stop()
topChrome29.coverage()
```

需要时分别采一次 `start("tab-return")`、`start("cold-control")`、`start("real-banner-update")` 对照；只沿已有复现动作，不凭这些标签声称捕获了启动前历史或真实业务更新。任意自定义标签会被脱敏。`start()` 排到主线程后生效，以 `capture-start` 为实际起点。脚本最多收集 60 秒或 10,000 个日志事件，边界在下一次回调检查，没有计时器；`capture-limit` 后未采集的范围是 unknown。

若附加时列表已经显示，未变 banner 可能不再自然经过 `getBanner:`。因此单次主线程 seed 也会只读 adapter.controller 的真实 `m_headerLogic` ivar，再读该 logic 已持有的 `m_MFFavDetailBtn` / `m_webMMBtn` 两个 UIView ivar，用 `discoveryKind=existing-ivar` 记录当前视图身份与几何；自然 getter 返回的首次发现标为 `natural-return`。这不调用 `getBanner:` 或业务 setter，也不补算 seed 之前的 getter/cell 交付历史。缺 ivar/读取失败仍是 unknown。不要为了得到 0 主动制造回调。`sharedBannerTracking.baselineCovered` 只有在 chat-return 边界之前已经发现 favorite/login 两个 banner，且 chat 出现入口已被观察时才为 true；进入聊天前的实际画面/几何仍需保留基准采样。

## 事件与判读

所有 JSON 以 `[top-chrome-29]` 开头，记录序号、时间、线程、`callId`、`currentCall`、`parentCall` 和列表 appearance 窗口。`afterObservedChat` 只表示捕获到指定聊天控制器的 appearance；不能识别的宿主聊天类将导致窗口分类不全，须查看 selector coverage。日志不输出账号、用户名、头像、昵称、消息、保护名单或真实指针，只用 `O1` 等对象别名、计数、索引路径、几何和静态类/selector 名。

| 边界 | 观察内容和用途 |
| --- | --- |
| `list-lifecycle-*`、`chat-did-appear`、自然会话 selector | 确定列表离开、聊天出现、列表返回；关联 active-name、会话更新、全局 reload、未读回调，不能假设每次返回都会调用某 selector。 |
| `event-attribution` | `changes`、names 是否 nil/数量、adapter dirty/depth/unattributed；不输出 names。注意多名字集合只能说明归属数量，不能识别实际会话。 |
| `publication-enter`、`plan-enter/result` | 本次发布的 known 标记、投影对象、变化位、局部 reload paths、fullReload/geometryChanged；区分发布次数和真正 table 操作。 |
| `table-operation-*`、`table-reload-rows` | 实际走到所挂方法边界的整表/局部刷新；按 selector、调用 ID、父调用解释，不能把计划当实际操作。 |
| `business-cell-delivered` | 从不可变 projection.sections 读取 row.kind=2 后的 cell 返回；没有调用模型/策略计算。分类不可读时记录 `cell-classification-unknown`，不能把遗漏算 0。`cellDeliveryEntries` 包含所有 adapter cell 调用，业务行数另见 `classifiedBusinessCellDeliveries`。 |
| `native-get-banner` | 自然返回的共享 view、当前 superview、索引；仅对返回对象与 header logic 的两项 ivar 做指针比对命名为 favorite/login，不假定固定索引。发现时点写在 discovery 中。 |
| `view-attachment/removal-*`、`banner-container-clear-*` | 已发现 banner/header 的 add/remove 及前后父视图；只有共享 banner 的事件 `sharedBanner=true`。addSubview 内部迁移未必单独调用可挂的 removeFromSuperview，要结合前后 superview。 |
| 三个 controller header 入口、adapter `layout`/`publishHeader:`、`header-setter-*` | 分开统计 `viewDidLayoutSubviews`、`initTableHeaderView`、`setSearchBarToTableHeaderView` 的进入/完成，adapter layout/publishHeader 及真正走到 UITableView setter 的次数。入口完成不是 UIKit 渲染完成。 |
| `tracked-view-operation-*` | 对已识别 wrapper/native-header/banner 的具体运行时类观察 `layoutSubviews` 和 `setFrame:`，记录前后几何；不能因 publishHeader=0 推断没有重复 frame 赋值、layout 或重绘。未知结构体调用参数不强解码。 |
| `restoreAnchor`、`restoreViewportFromTab:scrollHeight:`、`restoreScrollHeight:`、`offset-setter-*` | 还原 viewport 的入口/出口及 table offset/contentSize/inset 轨迹；浮点结构体参数经过寄存器 ABI，探针只读方法前后 getter，不从 args 猜 CGPoint/CGRect。 |

`manual-snapshot` / `capture-stop` 的 metrics 同时保留 selector 进入/完成计数、按角色的具体类边界计数、adapter layout、publishHeader 及 tableHeader setter 次数。banner add/remove 只有基准和所需 hooks 完整时才给当前 chat-return 窗口的观测次数，否则明确 unknown；即使是 0，也只排除覆盖的方法入口，不能排除 UIKit 内部迁移或未覆盖 override。其它数字都是所列边界的观测次数，不自动等于真实屏幕提交/绘制次数。

## 必须保留的限制

- unknown、缺 selector、签名不符、未发现对象和没有事件均不等于 0。`UIView.removeAllSubViews` 可能不存在或由子类 override；无日志不能证明没有清理容器。banner 身份发现之前的 add/remove 已漏采，不补算。对象可被释放并复用地址；别名不是跨进程、跨生命周期的身份保证。
- probe 只挂加载/发现时的当前 IMP。后续其它插件 swizzle、子类不调用 superclass、直接 UIKit 内部工作、进入窗口前的历史可能遗漏；子类/父类或继承的共享 IMP 可能产生重叠 hook。按 class/selector、callId 和父调用去重/解释，不直接相加 `MainFrameTableView` 与 `UITableView`、具体 header 类与 `UIView` 的计数。原生异常可能缺失 onLeave，未配对调用不能当成已经完成。
- adapter `layout` 可以重复设置同值 frame，即使没有调用 publishHeader/setTableHeaderView。探针补充 frame setter 和具体 header layout 边界，但这些仍不是 Core Animation 提交/像素采样。不能据此声称“无 UIKit 重绘”或“0 个空白帧”。
- 插件会在 native/header scope 转换 `tableHeaderView` getter。`effectiveScopedHeader` 明确是该作用域下读到的值；实际 attachment 需结合 wrapper/native-header 的 superview 和 add/remove 事件，不把 getter 单独当作真实已安装 header。读取不是原子事务，跨线程需按事件关联。
- 探针自身 getter 触发的回调通过 thread sampling guard 排除，不计为自然业务回调。一次主线程 snapshot 会再发现当前 headers，可能动态安装具体类的观察点；新覆盖之前的调用仍未知。脚本没有显式 retain 视图，全局仅保存地址字符串/匿名标签，仍应短时采样。
- 录屏需另行对齐时间。方法日志只能帮助建立 selector → attribution → publication → reload/cell/view/header/offset 的链条；不能独立证明画面闪烁根因、真实业务更新已完整覆盖或隐私首帧安全。

离线检查结果保存在 `runtime-probe-syntax-check.txt`；该结果只证明 JavaScript 能被指定 Node 版本解析，设备兼容性与实际计数继续 pending。
