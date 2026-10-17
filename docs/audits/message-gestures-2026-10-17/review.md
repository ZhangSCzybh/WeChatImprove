# 项目框架与消息手势审查

审查日期：2026-10-17。基于当前工作区，基线提交与关键文件 SHA-256 见 [sources.json](sources.json)。工作区已有其他功能及构建产物变更，本次只增加本目录的审查材料，没有修改业务代码、打包、安装或操作微信数据库。

## 结论与边界

项目的 Theos / Logos 接入方式适合此类插件，分组、气泡、消息合并等模块已经形成策略、适配器、原生桥接的分层。消息手势仍是较早的单文件实现，主要风险在识别准入、取消状态、跨模块代理冲突和复读发送边界；不宜仅调整滑动距离或动画时长。

已确认多项代码逻辑缺陷，并以提取生产方法的主机替身复现关键状态。存在主线程同步文件读取及高频重复配置读取，但本次没有微信真机 Instruments 数据，不能给出实际 FPS、卡顿时长、内存泄漏或耗电结论。未把其他模块历史测试数量作为消息手势的验证结果。

## 功能与开发框架

| 层次 | 当前实现 | 开发含义 |
| --- | --- | --- |
| 构建与注入 | Makefile、WeChatImprove.plist；ARC、UIKit/Foundation/QuartzCore/LocalAuthentication；arm64/arm64e，iOS 15 编译目标 | 自动编译 Hooks/*.xm 与 Controllers/*.m；设备实际兼容性另行验证 |
| 功能入口 | CustomEntryHooks、CSCustomViewController、CSNativeSettingsHost | 微信设置/我/插件管理入口，统一设置列表，原生容器承载 |
| 外观与布局 | 气泡、消息合并、消息时间、头像、顶栏、底栏、列表圆角、附件、输入文本、净化、后台模糊 | 多模块共同作用于微信视图，必须明确属性与生命周期所有权 |
| 会话功能 | SessionGroupHooks、CSGroupListAdapter、CSGroupProjection、CSGroupPreferences、CSGroupNativeBridge | 原生快照投影、双向索引映射、账号配置、交互期间延迟更新 |
| 消息与业务 | 手势、复读、语音转发、防撤回、红包、自动收款、收藏验证 | 既有 UI 交互，也有发送/入库副作用，需要独立能力判断 |
| 其他配置 | 备份/恢复、重置、入口、版本、更新、后台运行、游戏辅助 | 多数配置使用宿主进程 NSUserDefaults，分组另外按账号管理 |
| 原生桥接与辅助 | CSServiceCenter、CSChatNativeBridge、WCPLMessagePersistenceAdapter 等 | 已有可复用的服务获取与消息持久化入口，手势仍大量重复实现 |
| 测试 | Tests 下生产代码抽取、Foundation/CoreGraphics、UIKit 替身及构建脚本 | 可以验证策略和方法分支，不能替代真实 UIKit 仲裁或微信私有接口验收 |

统计时共有 34 个 Hook 文件、70 个 Controllers 实现文件、42,142 个 HeadersFile 头文件。这里对全项目做结构与功能梳理，深审范围为消息手势及其直接依赖，不代表逐行审完所有业务模块。

## 头文件的可信边界

- `Headers/WCHeaders.h` 是手工整理的最小原生接口声明；`WCPluginsHeader.h` 是外部插件管理入口；`CSUserInfoHelper.h` 记录版本等常量。Controllers 的头文件则定义本项目策略、桥接和适配器契约。
- `HeadersFile` 是私有接口资料库，不能视为当前微信的准确 SDK。例如 `VoiceMessageCellView.h:8`、`TextMessageCellView.h:8` 标注的父类是 NSObject，手势 Hook 本地却声明 VoiceMessageCellView 继承 CommonMessageCellView；这些声明不能证明实际运行时继承关系。
- `HeadersFile/CommonMessageCellView.h:138` 混入了插件分类；147–149 行声明带冒号的复读/删除/撤回方法，实际实现均无参数；144–145 行还保留未找到实现的旧方法声明。当前 Hook 顶部另补分类声明来覆盖部分缺口。这是明确的契约漂移，应将插件声明移到项目自己的头文件。
- `BaseMsgContentViewController.h:709` 明确声明 `isMsgCanRevoke:` 返回 `_Bool`，但手势在 `MessageGestureHooks.xm:814` 使用返回对象的 `performSelector:withObject:` 接收为 BOOL。应改为准确的 BOOL 函数签名；不能把当前某设备上非零值能用当作 ABI 正确。ARC 对对象返回值的处理也不适合标量返回值。
- `revokeMsgByNodeView:`、`deleteNode:withDB:animated:` 等 dump 参数类型只是 `id`，仅凭方法名和头文件无法证明应传 CMessageWrap 还是节点视图。本轮不把“传错对象已确认”作为结论，需要目标微信版本的实现或运行时证据。

## 消息手势调用链

设置入口在 CSCustomViewController，配置页是 CSMessageGestureSettingsViewController。主开关加四个动作配置，对应己方/对方、左滑/右滑；动作值为禁用、引用、删除、转发、收藏、撤回、复读。

`layoutSubviews → wchook_setupSwipeGestureIfNeeded → 为 Cell 安装 UIPanGestureRecognizer → wchook_handleSwipe → wchook_triggerActionForDirection → 各动作方法 → 复位动画`。

阈值为 `max(Cell 宽度 × 20%, 60pt)`；达到距离或水平速度绝对值达到 600pt/s 即可触发。Changed 阶段平移整个 CommonMessageCellView，达到约 2/3 距离时震动。删除和撤回有确认弹窗，复读直接发送。设置页发出 Darwin 通知，但仓库内未找到该消息手势通知的订阅方；刷新主要依赖后续布局，回调也直接读取 NSUserDefaults。

## 优先处理的发现

### P1：Cancelled 与 Ended 共用动作提交分支

证据：`Hooks/MessageGestureHooks.xm:480–492`。

手势被系统取消时，只要保留的位移或速度达标，仍调用动作分发。复现给出横向位移 -70pt、Cancelled 状态，动作分发次数为 1。该缺陷可能在中断时意外复读或收藏；删除/撤回会弹确认框，不应表述为无确认删除。

建议：只有 Ended 能提交，Cancelled/Failed 只恢复视觉与会话状态。Failed 在当前 handler 没有恢复分支；主机直接调用能复现位移残留，但真实 UIPan 通常不会从 Changed 转到 Failed，因此该项作为防御性完善，不单独声称真机必现。

### P1：消息时间与消息手势争抢同名代理方法

证据：`MessageGestureHooks.xm:2484–2520` 与 `MessageTimeHooks.xm:291–301`。

两个文件都 `%new` 同一类的 `gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:` 和 `gestureRecognizer:shouldRequireFailureOfGestureRecognizer:`，且语义不同。手势需要限制同时识别并等待边缘返回；时间模块直接返回 YES / NO。

本机 Logos 转换确认两边都生成 `class_addMethod`。同一类的同一 selector 只能添加一次，主机 Objective-C runtime 复现第二次添加返回 NO。因此至少一套逻辑不能按其源码独立生效；如果宿主已经直接实现该 selector，两次添加还可能都失败。安装不受对应功能开关限制，不能认为关闭“消息时间”就必然消除冲突。

建议：每种插件手势使用独立 delegate 对象，并明确保留宿主识别器行为；不要依赖链接/构造顺序决定代理实现。

### P1：视频复读的兼容兜底直接提交原历史消息

证据：`MessageGestureHooks.xm:1622–1624`、`1903–1907`。

ForwardMsgUtil 缺失或生成/发送路径不可用时，把从 Cell 取得的原始 `msgWrap` 传给 `AddMsgToSendTable:MsgWrap:`，没有创建新对象或重建发送身份。与一般消息分支的复制和清零 LocalID/SvrID 做法不一致。

确定的是“原历史消息被提交给发送队列”；是否已造成历史记录修改或重复发送，取决于宿主发送方法实现，本轮没有声称数据库损坏已发生。

建议：无法取得可信的新发送对象时终止并提示不可用。不能以更危险的发送路径弥补接口兼容失败；不应把“无异常返回”视为服务器发送成功。

### P2：识别准入与实际动作不一致，范围也大于气泡

证据：`MessageGestureHooks.xm:371–406`、`2470–2481`、`430–442`、`523–559`。

只要四个配置任意一个启用，所有此类 Cell 都安装并允许 pan 开始；ShouldBegin 不检查速度方向、当前发送者、该方向动作、触摸是否在气泡内、多选状态或动作能力。横纵向判定放在 handler，已经晚于 UIKit 识别准入；handler return 不会将已识别的 pan 改为 Failed。

主机复现：仅启用“左滑对方复读”，纵向拖动与右滑均通过 ShouldBegin。右滑 Changed 仍有位移和震动，结束到动作分发时才发现该方向禁用。纵向滚动是否明显受阻取决于真实 simultaneous/失败仲裁，但准入缺失已经确定。

建议：起手时锁定目标消息、发送方、动作、气泡命中和方向；无动作/不可执行应直接拒绝识别。确认消息身份和视图未被重绑定后再提交，避免仅在松手时重新读取 Cell 模型。

### P2：速度与距离的方向不一致仍提交，震动也不表示已达提交阈值

证据：`MessageGestureHooks.xm:467–486`。

主机复现：阈值 60pt，拖到 45pt 已震动但松手不执行；累计位移 -10pt、当前速度向右 +700pt/s，却按累计位移方向执行左滑动作。用户回拖时有触发相反动作的可能。

建议：触发条件、方向、可执行状态、震动使用同一状态判定；速度触发必须与动作方向一致，并有合理的最小位移。拖回阈值内后允许撤销 armed 状态。

### P2：复读链路承担过多副作用与兼容猜测

证据：`MessageGestureHooks.xm:861–2467`、`1422–1469`、`2392–2451`；`RepeatHooks.xm:137–156`、`186`、`1237–1244`。

约 1,607 行的复读方法混合服务查找、内容解析、语音构造、入库、上传和 fallback。它与长按复读是两套实现：长按入口有消息类型白名单，而手势对其他类型有通用 AddMsgToSendTable 兜底，能力边界不一致。

语音发送调用返回后立即检查 LocalID/Status，LocalID 为 0 即转本地入库，并设置 unique=NO。若目标微信版本的发送队列异步分配 LocalID，就存在首条发送仍在进行、第二条路径已经启动的窗口；这是需要宿主实现确认的风险，不是本轮已观察到重复发送。

建议：共享消息动作服务与类型能力表，区别“不支持”“已接收请求”“异步完成”“失败”。已接收发送请求后不要盲目走第二条写入路径。消息、账号、会话身份需贯穿整个请求。

## 性能评估

| 路径 | 已确认的开销 | 判断与处理顺序 |
| --- | --- | --- |
| 语音复读 | `1144` 同步 dataWithContentsOfFile；从 UI 手势回调直接进入，随后执行发送/可能入库；回弹在动作返回后才启动 | 优先于微优化；文件读取可能延迟回弹，耗时需设备测量。仅可把独立文件 IO 放后台，不能把未知线程契约的微信服务整体移走 |
| Changed 高频回调 | 主开关与任意动作检测每次读 NSUserDefaults，短路下每次 2–5 次读取 | 1,000 次 Changed 主机计数为 2,000 次配置查询（首项启用）；末项单独启用为每次 5 次。NSUserDefaults 有内存缓存，不能误称每帧磁盘 IO |
| Cell 布局 | 每次 layoutSubviews 再查配置、重新赋识别器属性；语音类另外 Hook 同一入口 | 常规开销可减少；语音双重执行取决于实际 super 调用链，未直接计为两次 |
| 对象分配 | 每个已启用的 Cell 各持有一个 pan 和反馈生成器 | 创建有存在检查，不是每次布局重新分配，也没有发现此模块自己的周期轮询；不能仅凭实例数量声称泄漏 |
| 运动反馈 | 平移整个 Cell、associated object 读写、每次复位 0.25s 动画 | transform 本身通常便宜，优先修语义和 ownership；没有证据要求先换动画技术 |

消息合并适配器 `CSMessageMergeAdapter.m:379–380` 已避让非单位 transform，这是合理保护；不过手势直接写 self.transform 并强制恢复 Identity，没有保存宿主 transform。复用也会无条件执行这一恢复。拍一拍/宿主动画、紧密布局期间的具体视觉效果需要组合实机检查，不能单凭源码推断一定发生跳动。

建议把配置读成小型快照，在设置改变/页面激活时更新。已安装识别器只在 enabled 值变化时赋值；手势过程中保持单次上下文，Changed 只做必要的位移与反馈。不需要为了四个配置键引入复杂缓存系统。

## 建议的改动顺序

1. 小范围修复 Cancelled 提交、独立代理、准入条件和视频原消息兜底；补关键行为回归。
2. 抽离手势上下文和动作能力策略，明确消息身份、方向、armed 状态和恢复所有权。
3. 统一手势/长按复读的动作服务与原生桥接，复用 CSServiceCenter，整理准确签名。避免复制整套 fallback。
4. 基于主线程采样优化配置读取和语音文件 IO，再测滚动/拖动/释放时延，不先凭文件行数重写所有模块。

这是审查建议，当前未实施。当前分组与消息合并已有的策略/适配器模式可复用，不必重新发明全项目功能框架。

## 验证记录与后续验收

执行：`python3 docs/audits/message-gestures-2026-10-17/reproduce.py`。

[复现脚本](reproduce.py) 从现有生产文件抽取 handleSwipe、reset、ShouldBegin 方法。手势、视图、反馈、配置和动作发送为主机替身，配置只在内存中，不访问真实偏好或消息数据库；动画同步执行，不测量动画时序。编译生成物在临时目录并自动清理。

[输出](reproduction.txt) 记录取消仍分发、纵向/禁用方向准入、Failed 直接调用后的位移、震动与提交阈值差异、反向速度、配置读取次数和 runtime 重复注册行为。这是缺陷复现，不是“所有功能测试通过”。此外对两个 Hook 做 Logos 转换并检查实际生成的 class_addMethod 调用；没有构建或部署新包。

建议真机验收组合：仅开左滑/右滑与己方/对方；纵向慢拖与快速滚动；边缘返回及返回取消；长按、语音播放、气泡外点时间；多选；系统中断；拖到阈值后反向拖回；消息更新/Cell 重绑定；紧密合并与头像动画；未下载语音、不同消息类型和账号切换。性能采样记录 Changes/结束提交/原生发送各阶段耗时、帧预算、内存趋势；60Hz 与 120Hz 分别评价，不能用主机执行耗时代替设备数据。
