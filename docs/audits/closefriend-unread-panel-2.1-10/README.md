# 2.1-10：未读聊天面板的密友／密群隐藏

## 请求、授权与环境

用户确认 2.1-9 的微信底栏角标问题已修复，随后指出长按底栏“微信”的原生未读聊天列表仍显示密友／密群。截图来源为 `/Users/zhangshichao/Downloads/IMG_7523.PNG`。本次已明确批准：面板专用过滤、数量同步、解锁恢复、打开期间重新锁定和消息刷新、点击前再校验，沿用“会话隐藏”开关。

使用既有检出 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`。这是 Theos iOS 注入插件，无本地前后端服务、URL 或端口。本次没有连接设备、安装插件、启动或重启微信，也没有访问或改动用户数据库、账号、密码或密友配置。原 `.theos/` 和 `packages/` 在开始时登记了 1268 个既有文件的 SHA-256，后续使用隔离构建目录与新的交付子目录。

## 原因与已批准设计

此入口使用独立的 `MainFrameAggregationViewController` / `MainFrameAggregationLogic`，没有复用主列表的投影。旧隐藏逻辑因此没有处理该面板；面板标题又直接读取 `MMNewSessionMgr.GetUnreadNotifySessionCount` 的全局值，单纯隐藏行仍会泄露隐藏会话的数量。

原生证据来自微信 8.0.78.34 的解密 arm64 Mach-O：

- 文件：`/private/tmp/wechat-8.0.78-inset-analysis/WeChat`。
- SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`；cryptid=0。
- REA 架构证据：`ev_38accd4708888368927c2e01c07f374f8e487ab25251bce421b6b0c19202b93a`。已关闭分析会话。
- 方法与 ivar 从只读 Mach-O 元数据提取，方法界限使用 LC_FUNCTION_STARTS，LLVM 仅反汇编选定范围。下面都是静态证据，不表示设备运行观察。

关键调用链及依据（原始记录均在 [native/](native/)）：

| 原生接点 | 观察与修复含义 |
| --- | --- |
| `NewMainFrameViewController.showAggregationWithShock:` | 调用独立面板的 `showSessionAggregationFrom:visibleCells:headerHeight:delegate:` |
| `MainFrameAggregationLogic.canShowSession:`，0x104a6ff6c | 已在 `_sessionSet` 的会话直接保留；新行才检查非 redDot、未读非零。必须在原生判断之前拒绝隐藏身份 |
| `rebuildSessionList`，0x104a6f304 | 新建面板局部 `_sessionList`，重新读取 `MainSessionMgr.visibleSessionEnumerator`，后者连接 topSessions 与 normalSessions。解锁可以从完整来源恢复 |
| `sessionAtIndex:` / `currentSessionList` / `sessionCount` | 都来自同一 `_sessionList`；原生维护顺序、模型和索引，无需另一套索引投影 |
| `notifySessionCount`，0x104a6edd8 | 调用全局 `GetUnreadNotifySessionCount`，并非过滤后的面板数量 |
| `MMNewSessionMgr.recountUnReadCount` / `GetUnreadNotifySessionCount` | 通知未读会话数在 0x10452e8c8 写入、0x104521c4c 读取同一个 offsetref 0x12021d73c；须排除 hidden/chatBox/brandBox/chatroom_session_box/folding/redDot，且未读非零 |
| `onSessionListChange`，0x104a74484 | 转场时只标记延后刷新；隐私策略变化必须同步调用 `updateContent` |
| `MainFrameAggregationTransition.animateTransition:` | 0x104a70d54 截屏，0x104a70db0 创建 UIImageView，写入 offset40的 `_fromSnapshtoView`；锁定时还须清理旧画面 |
| `onAggregation:openSession:`，0x1051289b4 | 直接转给 `onLogicOpenSession:`，可在最终跳转之前复核真实 session 身份 |

实现边界为“原生准入筛选 + 面板完整重建 + 面板数量修正 + 操作前校验”。可见性使用 `CSCloseFriendSurfaceSession`。锁定且会话隐藏启用时排除密友／密群；解锁后恢复，包括消息静默仍开启的情况。账号或 epoch 失效、策略 blocked 时拒绝旧面板项。不会通过清空全局未读、修改全局会话数组或消息静默策略完成隐藏。

## 验证记录

既有行为回归日志：

- [regression-alerts.log](regression-alerts.log)：216 项 alerts + 897 项底栏角标通过。
- [regression-session.log](regression-session.log)：148 项主列表 + 44 项呈现通过，arm64 / arm64e 对象编译通过。
- [regression-lifecycle.log](regression-lifecycle.log)：140 项，0 失败。
- [regression-runtime.log](regression-runtime.log)：94 项 runtime、9 项 scheduling、99 项 biometric 通过。

新面板验证：

- [unread-panel-tests.log](unread-panel-tests.log)：**71 项行为 + 7 项 ABI 检查，0 失败**。夹具执行实际生产适配器及全部 hook 注册，UIKit 和微信 manager 为 Foundation 边界替身。覆盖名单和顺序、解锁后静默仍开启、未读与保留已读行的区分、消息增量更新、完整源事务内改策略、旧行与同步重排、过期 cell 立即遮挡和随后恢复、账号／epoch／blocked、错误方法签名。
- [unread-panel-native-control.log](unread-panel-native-control.log)：相同原生夹具未安装新 hook 时编译成功，4 项隐私／数量／身份／点击断言全部失败，退出码1；安装新 hook 后通过。这是未安装修复的原生对照，不是旧源码快照测试。
- [unread-panel-ios.log](unread-panel-ios.log)：新增 adapter、hook 在 arm64 / arm64e 上通过 `-Wall -Wextra -Werror`。
- 独立只读代码复核完成，没有阻断问题。生产三个新文件冻结后进行完整构建，构建前后输入哈希一致。

## 构建、产物与保留核验

[build-result.json](build-result.json) 记录两种 scheme 的独立完整构建，均退出0。每种约24秒，已有的6条警告来自 UILocalNotification、statusBarFrame 和旧链接参数；新增 adapter / hook 严格编译没有警告。构建目录由 [build-directory.txt](build-directory.txt) 记录；未使用 `make clean`，未写既有 `.theos/`。

[package-verification.json](package-verification.json) 确认：

- 两包 Version 都是 2.1-10，控制文件、插件内版本与更新说明同步。
- 两个 dylib 都有 arm64 / arm64e，两个架构的最低目标均为 iOS15.0。
- Rootless 路径为 `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib`；Rootful 路径为 `/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib`。
- 新面板 helper 已导出，注入过滤 plist 与源码语义一致。
- 4个 dylib UUID 均匹配各自 dSYM；调试符号 ZIP 的12个文件 CRC 完整。
- [preserved-artifacts-after.json](preserved-artifacts-after.json)：开始时的 **1268 个既有构建／安装包文件全部保留且 SHA-256 未变**。
- [source-preservation.json](source-preservation.json)：无关既有源文件未改动，2.1-9 的通知／底栏角标及主列表实现逐文件哈希不变。

交付产物：

| 环境／用途 | 文件 |
| --- | --- |
| Rootless | [com.wechat.improve_2.1-10_iphoneos-arm64.deb](../../../packages/2.1-10-unread-panel/com.wechat.improve_2.1-10_iphoneos-arm64.deb) |
| Rootful | [com.wechat.improve_2.1-10_iphoneos-arm.deb](../../../packages/2.1-10-unread-panel/com.wechat.improve_2.1-10_iphoneos-arm.deb) |
| 调试符号 | [com.wechat.improve_2.1-10_symbols.zip](../../../packages/2.1-10-unread-panel/com.wechat.improve_2.1-10_symbols.zip) |
| 校验值 | [SHA256SUMS](../../../packages/2.1-10-unread-panel/SHA256SUMS) |

没有进行真机安装或运行，以下步骤仍需使用这些新包验收。

## 真机验收步骤

安装与设备注入环境匹配的 2.1-10 包，重新打开微信后核对插件版本。准备普通私聊、普通群聊、密友和密群各一条未读：

1. 锁定并启用会话隐藏，长按底栏“微信”：只看到普通会话，密友／密群的头像、名称、摘要和时间整行消失；底部数量不包含受保护会话。
2. 解锁后再次打开：原生允许显示的密友／密群恢复，即使消息静默仍开启。
3. 面板保持打开再锁定（含超时、进入后台再返回）：受保护行和旧转场画面立即清除，数量同步；再解锁后恢复。
4. 面板打开期间分别给普通会话、密友和密群发消息：普通会话正常更新，受保护会话在锁定时仍不出现。
5. 点击和标为已读操作应作用于当前看到的会话；锁定前的旧行、重排前的旧索引或旧账号回调不能跳转或改变其他会话的已读状态。
6. 仅密友／密群有未读时使用原生空态；切换账号后旧面板不显示旧账号内容。
7. 关闭“会话隐藏”或关闭密友功能后恢复微信原生面板；重新确认 2.1-9 已修复的底栏角标仍随普通消息和已读变化更新。

宿主测试与构建验证不替代以上真机显示、手势和动画验收。
