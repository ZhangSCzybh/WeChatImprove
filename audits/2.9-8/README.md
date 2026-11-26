# WeChatImprove 2.9-8 修复与交付报告

日期：2026-11-25。工作目录为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，基线是本轮开始时干净的 2.9-7 正式版源码，HEAD `b7cefb03`。按任务书完成三块功能梳理，由主 agent 连续实施；没有派发子任务。先完成 Rootful、Rootless 完整构建和本版产物核验，再编写本报告。

本轮结论：转场修复针对“返回后的来源准备过晚”这一源码时序缺口，将复用的来源刷新/真实布局/高度恢复提前至返回后的安全布局入口，并在水平识别前复核；语音转文字修复针对两种专用文字模型被合并白名单排除的确定性缺口。六项核心门禁与当前 2.9-7 正式版均为 PASS，`new_failures=0`。两处设备运行效果均为 **真机未验证**。

## 三块功能的实现与调用关系

| 功能 | 实际调用链与本轮理解 |
| --- | --- |
| 聊天分组 | `Hooks/SessionGroupHooks.xm:201` 的首页生命周期负责 adapter 绑定与可见性；列表原生数据变化由 `NativeSessionGroupHooks.xm` 和 `CSGroupNativeSessionCoordinator.m` 汇入模型。`CSGroupPreferences.m` 管理按账号的分组、选择及开关，`CSGroupProjection.m` 生成带账号/隐私版本的投影。`CSGroupListAdapter.m:2814 groupPan:` 负责横滑准入、来源准备与邻页预览，`:2603 beginSwipePageTransitionToIndex:direction:` 通过真实原生邻页发布获得目标内容；`:2693 selectSwipeIndex:direction:` 才确认选择。`CSGroupPageAnimator.m:63/103` 负责两页快照、跟手位移和收尾，`WESessionTabContainerView.m:731` 负责指示器跟随进度。`GroupChatHooks.xm` 的群聊后台管理启动不承担分组横滑。 |
| 气泡样式 | `Hooks/BubbleStyleHooks.xm:7` 在 cell 初始化、换模型、布局、原生背景更新与外观变化时调用 adapter，并在复用时恢复。`CSBubbleStyleAdapter.m:254 CSDescribe` 校验原生模型/消息类型/气泡位置，`:433 CSGroupPosition` 从合并状态取 single/first/middle/last，`:470 CSBubbleStyleApply` 生成并应用样式。`CSBubbleStylePolicy.m` 管配置、图像与圆角模板，`CSBubbleTextColors.m` 管文字颜色及恢复。分组位置属于样式缓存键的一部分，合并决策变化可使既有套用流程重新生成外观。 |
| 连续消息合并 | `Hooks/MessageMergeHooks.xm:17` 的高度、cell 与 willDisplay 入口均进行 Prepare/Bind；`:55` 起的 add/replace/remove/reload 钩子将原生变更包在 WillMutate/DidMutate 中。`CSMessageMergeAdapter.m:215 CSItem` 建 descriptor，`:254 CSPrepareModel` 计算前/后邻接，`:792 schedule` / `:800 flush` 合并主队列更新并避开交互、菜单与未完成原生更新；`:326 Bind`、`:340 ReadAppearance` 连接气泡样式。`CSMessageMergePolicy.m:67` 要求同账号/会话/发送者/方向、有效且不同身份、双方 eligible。`CSMessageSendAdapter.m:176` 等为插件重发/转发/定时发送调用原生 SendTextMessage 的适配，不是原生长按输入框转文字的唯一入口。 |

## 问题 1：返回首页第一次横滑无页面转场

**确定的源码事实与归因边界。** 2.9-7 离开首页时使 adapter dirty、失效模型快照，并保存可用的 departure viewport；返回时重新绑定/刷新，`finishPresentationReturnForController:` 记录账号/epoch/viewportGeneration 的 `pageSourceReturnKey`。然而该方法在没有 pending viewport 时直接返回；有 pending viewport 时，也只是对干净列表调用 `layoutIfNeeded`，不强制重新请求先前被拦截的实际布局。2.9-7 的来源准备只在 `groupPan:` 已处于 Began/Changed 时执行，手势 delegate 当时只判方向。因而“返回完成”与“在开始跟踪触摸之前完成可验证的来源布局”没有主动衔接。

`preparePageSourceForPan` 本身已有完整恢复逻辑，但会拒绝 `table.dragging`、发布/原生变更中、隐私等待、快照重试、菜单等状态；`beginSwipePageTransition...` 还拒绝 dirty、sessionLayoutHeld、presentationViewport/switchViewport 等状态。来源准备若发生得太晚，就可能被这些前提挡回普通选页。源码能确认这个窗口及回退路径；用户设备首次滑动究竟命中哪个 guard、几何是否发生变化、snapshot 是否返回 nil，本机没有运行证据，均为 **真机未验证**。本报告不把候选设备行为写成已测根因。

任务书的五个候选逐条核对如下。下述行号为交付源码；2.9-7 对照见本轮差异文件及 HEAD。

| 候选 | 判定与代码依据 | 真机区分方法 |
| --- | --- | --- |
| 1. 返回几何/宽度/内容未初始化或仍旧 | **存在未验证布局窗口；零宽是否发生未确认。** `CSGroupListAdapter.m:300` 返回完成只记录 key/按条件 layout，`:801 performSessionListLayout:` 可能因模型/隐私版本不匹配扣住真实布局；普通 `layout` 只布置 header/chrome，不能替代验证后的表格布局。`CSGroupPageAnimator.m:37` 会拒绝空/非法可见区域，`:96` 要求前后 frame/window/host 精确一致。不是发现了写死宽度或新启动坐标常量。 | 记录 didAppear、真实 table layout、首个水平 shouldBegin/Began 时 table.bounds、contentSize、header/chrome frame、window/host、inset、contentOffset 及 held 标志；原设备取数，**真机未验证**。 |
| 2. 首滑转场前置条件 early-return | **代码路径成立；具体挡住首滑的条件需设备确认。** `CSGroupListAdapter.m:2537` 来源准备及 `:2603` 启动严格检查 dirty/publishing/held/pending viewport/native boundary 等；`:2512` 上下文还验证 modelRevision、policy、epoch 与来源选择。`groupPan:` 无 animator 时可走直接选择，符合“切了组但无转场”的现象。没有证据说明开关首次读取错误。 | 在设备调试器分别停在来源准备和启动 guard，记录返回原因；比对“不先竖滑”与“先竖滑”两次状态。保持隐私和账户检查，**真机未验证**。 |
| 3. 竖滑补齐了什么 | **清理动作有直接代码依据。** `SessionGroupHooks.xm:185` 和 table pan began 路径进入 `CSGroupListAdapter.m:2227 beginUserDragging`，排除水平分组手势后调用 `:2216 beginUserScrolling`，增加 viewportGeneration、清 pending initial/return/switch viewport 和 anchor；真实滚动还可触发 UITableView layout，交互结束唤醒待刷新。这里没有“竖滑专用的页面快照缓存重建”。 | 比对前后 viewport/key/held/dirty，以及实际 layout 是否进入原生主体；不假设所有竖滑必然清掉全部 guard，**真机未验证**。 |
| 4. 转场视图/快照首次懒创建 | **每次有效预览都按需创建，不能据此归为首滑缺缓存。** `CSGroupListAdapter.m:2622` 附近创建新的 animator；`CSGroupPageAnimator.m:63` 捕获 outgoing（afterUpdates:NO），`:103` 捕获 incoming（afterUpdates:YES）。没有等待用户竖滑才初始化的全局转场缓存。source capture 失败后 attemptedTarget 会抑制同次手势昂贵重试，这个后果存在，但失败是否发生未测。 | 确认 begin 是否执行、两次 snapshot 返回值及 capture 前后可见区域；若来源状态已就绪仍失败，应调查 UIKit snapshot 路径，**真机未验证**。 |
| 5. 冷启动与返回首页分支不同 | **成立，且是需要保留的设计。** `CSGroupListAdapter.m:2167 prepareInitialViewport`、`:2188 restoreInitialViewport` 管账号/epoch 的初次定位；离开页面会取消旧 startup request；`:300` 返回由独立 returnKey 和 departure viewport 管理。本次被动预备明确跳过 initialViewportPending，避免以修返回为由提前消费真正的冷启动定位。 | 分别测冷启动、聊天返回、其他 tab 返回、搜索返回及 table 替换后的首滑；检查初次首项可见性和共同滚动高度，**真机未验证**。 |

本次最小修复为三处时序调整，来源恢复算法和安全 guard 原样复用：

1. `Hooks/SessionGroupHooks.xm:208 viewDidAppear:` 在原生出现、绑定与 `finishPresentationReturn...` 之后，再进入一次现有的 `layoutForController:`。这样 return key 建立之后立即有布局入口，不依赖用户先竖滑。
2. `Controllers/CSGroupListAdapter.m:325 layoutForController:` 在布局后，仅对有 returnKey、没有 startup pending、没有 table tracking/分组 pan、已开启页面转场且系统未减弱动态效果的情况，同步调用既有来源准备。该 helper 再校验账号/epoch/policy/model，必要时刷新，通过 `setNeedsLayout + layoutIfNeeded` 让真实布局验证解除 hold，再恢复 pending viewport。成功才消费 key；保护条件不满足就保留等待，不手动清除 held/privacy/boundary。
3. `Controllers/CSGroupListAdapter.m:2802 gestureRecognizerShouldBegin:` 在原有触点归属和水平 1.5 方向条件通过后，再执行一次来源准备；Began/Changed 的既有复核保留。竖向或未准入触摸不做这项工作，转场关闭/系统减弱动态效果时不做准备。

没有改转场曲线、指示器、距离/速度阈值、选择持久化、快照失败断言，也没有新增轮询或异步等待。设备上是否完全消除用户复现场景为 **真机未验证**。

## 问题 2：语音转文字新消息气泡未实时合并

**确定性缺口。** 原生产气泡样式的 `CSBubbleStyleAdapter.m:273` 已明确把 `VoiceTransTextMessageViewModel` 与 `VoiceTransTextMessageViewModelV2` 且 `m_uiMessageType==1` 作为普通文字支持；2.9-7 合并适配器 `CSSupported` 却只允许五个 exact class（Text/Image/Voice/Video/Emoticon），遗漏这两个模型。于是新消息即使经过已有插入钩子，`CSItem.eligible` 仍为 NO，策略不会 join，气泡取得 single。重进聊天后若原生重新构造为普通 TextMessageViewModel，就又具备资格。这一解释与用户症状一致；用户设备实际类名及重进时转换为普通模型的行为仍为 **真机未验证**。

| 排查方向 | 判定 |
| --- | --- |
| 新消息插入/发送完成是否没钩住 | 生产代码已有两版 addMessageNode、addChatViewModel、replace、reload 等触发，以及 height/cell/willDisplay 的 Prepare/Bind。不能凭用户现象断言原生语音发送绕过全部 hook。白名单遗漏即便在 hook 正常时也足以阻断合并，所以本轮修 eligibility，不盲目新增 native send hook。设备 hook 命中顺序为 **真机未验证**。 |
| 是否只在首次加载/reload 合并 | `CSPrepareModel` 没有“只历史”的准入条件；`CSMessageMergeDidMutate:873` 会 schedule，flush 处理实时可见邻居。历史加载有独立的滚动锚点协调，不是 merge 仅历史生效开关。 |
| 类型/来源/时间戳排除 | 专用 exact class 被排除是直接代码事实。`CSMessageMergePolicy.m:67` 不以来源标签或时间戳分组，使用账号、会话、发送者、方向与不同消息身份。不能把本问题归于未发现的时间阈值。 |
| 缓存只在重进重建 | `CSItem:215` 每次读取都重新验证 eligible、identity、sender/outgoing/account/session；`CSPrepareModel:254` 重新算前后邻接。不是仅以节点指针或数组数量判断。更新 type/身份时 descriptor 可以重建；实际现场的通知和模型变更时序为 **真机未验证**。 |

修复仅在 `Controllers/CSMessageMergeAdapter.m`：`:196` 新增 exact 两类 + 普通文字类型 1 判定，`:202 CSSupported` 接纳该判定，`:500 CSNativeProfile` 将这两类纳入原生气泡模板 inset 验证。single-row、parent、发送者、身份、账号与会话限制保留；模板不可验证时保持原生间距回退。没有改气泡渲染器、文字颜色、发送内容、发送路由、普通语音 type34 或未知文本子类策略。

补充证据：在临时目录中提取生产 `CSItem/CSSupported/CSUInt/CSParent/CSMessageNativeObject`，直接链接原生产 `CSMessageMergePolicy.m`，以 Foundation 模型边界运行 31 项资格/缓存/相邻策略检查；2.9-7 与 2.9-8 各跑一遍。两种专用类在基线 `eligible=0`，修复后 `eligible=1`；同对象 type49→1 后资格重新计算，私聊/同群同发送者可加入，异发送者、未知子类、卡片、拆分行、parentModel、非文字类型仍拒绝。源码与日志保存为本目录 `voice-merge-*.m` / `logs/voice-merge-*.log`。这是临时补充检查，不是修改既有 gate，也不等于原设备实时画面验收。

## 改动文件

| 文件 | 改动 |
| --- | --- |
| `Controllers/CSGroupListAdapter.m` | 返回后安全布局预备、水平识别前复核、两处注释与新调用时机一致 |
| `Hooks/SessionGroupHooks.xm` | didAppear 在 return key 建立后进入现有布局入口 |
| `Controllers/CSMessageMergeAdapter.m` | 两类普通文字资格与原生模板 inset 保护 |
| `control` | Version 2.9-8 |
| `Headers/CSUserInfoHelper.h` | 插件显示版本 2.9-8 |
| `Controllers/CSReleaseNotesViewController.m` | 新增 2.9-8 两项修复说明及真机验证边界，保留历史说明 |
| 根 `README.md` | 当前版本、说明与本版下载链接 |
| `packages/2.9-8/` | 仅新增本版两个 deb、fat dylib、symbols.zip、校验清单、README、核心比对 JSON |
| `audits/2.9-8/` | 本报告、逐项门禁/构建/产物核验记录及必要日志和临时补充模型检查来源 |

工作树起点干净，没有回滚任何未提交更改。`git diff -- Tests` 为空，跟踪的 Tests 文件保持 466 个；文件系统另有两份本轮前就存在的 `.DS_Store`，未删除或改动，不计入测试源文件。没有 make clean，没有改任何历史 packages 文件，也没有读取其他 local-archive 内容或做全量哈希。

## 六项核心门禁对比

本轮在动手前对当前 2.9-7 正式版重新执行基线，没有沿用旧会话中的“两项红灯”说法。实际结果为六项全绿。

| 门禁 | 2.9-7 基线 | 2.9-8 | 差异 |
| --- | --- | --- | --- |
| Tests/verify-tabbar.sh | PASS | PASS | 无新增失败 |
| Tests/verify-settings-tab-bar.sh | PASS | PASS | 无新增失败 |
| Tests/verify-settings-home.sh | PASS | PASS | 无新增失败 |
| Tests/verify-moments-card.sh | PASS | PASS | 无新增失败 |
| Tests/verify-moments-share.sh | PASS | PASS | 无新增失败 |
| Tests/verify-plugin-header-entry.sh | PASS | PASS | 无新增失败 |

`core-gates-results.json` 与随包同名记录逐项保留 exit code，`new_failures=0`。原始日志在 `logs/baseline-*.log`、`logs/final-*.log`。

聚焦两项修复又执行了以下既有检查，结果与基线逐项比对，无 PASS→FAIL；见 `focused-gates-results.json`。

| 检查 | 基线 | 2.9-8 | 说明 |
| --- | --- | --- | --- |
| group-interactions | PASS | PASS | 191 checks |
| group-page-lifecycle | PASS | PASS | 182 checks，覆盖 return key、pending viewport、真实布局与 preview/commit 校验 |
| group-page-animator | PASS | PASS | 84 checks |
| group-initial-viewport | PASS | PASS | 105 checks |
| group-native-preview | PASS | PASS | 209 checks |
| group-search | PASS | PASS | 163 checks |
| group-indicator | PASS | PASS | 183 checks |
| bubble-style | PASS | PASS | policy/renderer 36979，真实 adapter 生命周期 2681 checks |
| message-merge | FAIL（编译阻断） | FAIL（同一阻断） | policy/navigation 235148 checks 均先通过；接着既有 MessageUIKit 桩不声明 UIColor，`CSBubbleStyleAdapter.h:28` 编译报 2 处 unknown type name。未改桩，不标完整脚本通过 |
| group-lifecycle | FAIL（编译阻断） | FAIL（仍阻断） | 通用生命周期 fixture 原已缺 pageSourceReturnKey、preparingPagePreview、cancelPageTransition 等声明，基线 17 个编译诊断；本次新增的真实准备调用也暴露该 fixture 缺少 preparePageSourceForPan/CSGroupPageTransitionEnabled 等声明，达到 clang 20 个错误上限。保留真实日志，不能声称诊断条数原样或该脚本已跑到断言 |
| group-selection | FAIL（宿主异常） | FAIL（同类异常） | 宿主注入的 Python sitecustomize 对 `mkdir(exist_ok=True)` 抛 EEXIST，两次都未进入断言；没有改脚本或规避后冒充 PASS |

一次实现中把主动预备放到通用 `layout` 末尾，group-search 的旧 fixture 因不包含转场状态声明而编译失败；交付前将工作移到真正拥有返回时机的 `layoutForController`，随后原脚本 163 checks 全通过。该中间日志不作为最终门禁结果。没有为通过测试修改既有断言或恢复/删减测试。

## 构建、包与符号

两种方案各使用独立临时 Theos 数据目录构建，命令的关键参数为 `make -j6 package SCHEME=<rootful|rootless> _THEOS_LOCAL_DATA_DIR=<本轮临时目录>/build-<scheme> THEOS_PACKAGE_DIR=<项目>/packages/2.9-8 PACKAGE_VERSION=2.9-8 PACKAGE_BUILDNAME=`。没有复用共享 `.theos` 里的对象，也没有触发 clean。

逐项核对编译日志：两种方案每种架构均编入当前全部 297 个源码单元（240 Controllers + 57 Hooks）。Rootful 用时 41.9s，Rootless 用时 42.2s；各 8 条警告、0 条错误。警告位于未改动的 CSSettingsTableViewController、CloseFriendNotificationHooks、RedEnvelopHooks 的弃用 API，及链接器 multiply_defined 选项；未将这些警告表述为本轮零警告。

| 方案 | 包路径 | arm64e UUID |
| --- | --- | --- |
| Rootless | `packages/2.9-8/com.wechat.improve_2.9-8_iphoneos-arm64.deb` | `E099C444-2C34-3E9C-A502-272A7B9E7DA8` |
| Rootful | `packages/2.9-8/com.wechat.improve_2.9-8_iphoneos-arm.deb` | `B4F57255-5A08-3D01-9A33-B06EC7E26D8C` |

独立 `packages/2.9-8/WeChatImprove.dylib` 与 Rootful 包内动态库逐字节一致；Rootless 安装前缀 `/var/jb/Library`，Rootful 为 `/Library`。均包含 arm64/arm64e，包 ID `com.wechat.improve`、精确版本 `2.9-8`、最低 iOS 15.0。注入 plist 经 Theos 格式转换后语义与源文件一致。4 份 dSYM UUID 与对应架构完全匹配，symbols.zip 完整性通过。`SHA256SUMS` 覆盖其余 6 个交付文件，`shasum -a 256 -c SHA256SUMS` 全部 OK。具体两种架构 UUID 见 `artifact-validation.json`。

## 原设备需要确认的范围

以下所有运行期结论均为 **真机未验证**，没有宣称现场复现已经消失，也未捏造帧耗时：

1. 开转场，分别从聊天页、其他底栏 tab、设置/小程序或搜索返回首页，不先竖滑直接在左侧区域横滑；确认第一次即有实际页面转场、滚动高度保持、取消回弹正常。应分别覆盖保存了 departure viewport、已恢复高度、没捕获到高度、table 被替换、native revision 有迟到更新。
2. 先竖滑后横滑、连续快滑、反向取消、原生右滑菜单、右侧原生触摸区、转场开关关闭与系统减弱动态效果，以及账号/隐私边界；不能为了出现动画而绕过 guard。
3. 私聊和群聊各以普通文本→长按输入框转文字发送→再普通文本的顺序，检查不重进即可形成 first/middle/last，头像/昵称策略及正常/紧密间距正确；同时覆盖转文字取消、很长文字拆行、翻译/辅助内容、深浅色、复用滚动和重进会话。
4. 若首滑仍无页面转场，先使用上面列出的源码断点区分是 source preparation 未准入、实际布局未完成、context 失效还是 snapshot nil。若实时合并仍失败，记录实际模型 exact class、wrap type、row count、identity、插入钩子及 flush 是否命中；不要记录消息正文。必要时再据实际信息决定补 hook 或扩展明确模型。本版没有新增生产诊断埋点。
