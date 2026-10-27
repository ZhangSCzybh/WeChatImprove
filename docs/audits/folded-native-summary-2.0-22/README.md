# 2.0-22 折叠入口原生标题与分组内摘要

已基于 2.0-21 完成收敛修复、失败用例、核心回归及 Rootful / Rootless 打包。版本同步到 control、CSUserInfoHelper 和发布说明。验证为宿主替身和实际 iOS 编译/产物核验，尚未宣称真机验收通过。

## 根因与改动

2.0-21 的 `CSCloseFriendSessionPresentation.m` 隐藏原生名称 label，另画“折叠的聊天（N）”，并对覆盖层的标题/摘要启用缩字；摘要固定拼接“N 个会话”。`CSGroupRow` 没有原生摘要与时间字段，因此也没有按本组可见折叠会话选最新摘要的链路。

- 标题：确认原生 `m_nameLabel` 是 UILabel 且内容为“折叠的聊天”后，保留该 label 及祖先可见，不改文本、字体或 frame；隐藏备用标题。未知结构/标题才使用同字号备用标题，关闭缩字。复用与原生布局重置时恢复/维护自身持有的 hidden 状态。
- 来源：只读 `ChatBoxMgr.chatBoxSessions`，通过现有分组、排重与隐私投影取得当前分组可见会话。摘要与原生有效时间作为不可变值存于 `CSGroupRow`，不保留原生模型或另建摘要缓存。
- 取值：只读 `MainFrameCellDataManager.getCellDataByUsrName:` 的现成 CellData，校验 `m_sessionInfo` 与源会话相同、`m_n64MesSvrID` 与当前消息精确相等且非零。复制 `m_textForMessageLabel`（NSString 或 NSAttributedString.string），直接保留微信的群名/发送人前缀及图片、链接、引用等可见摘要文本；不自行解析消息 XML。
- 排序：使用 `MMSessionInfo.compare:` 的有效时间：非零 sortTimeOverride，否则 m_uLastTime；置顶与 m_uTopTime 取最大，非置顶与 m_uUnTopTime、sortTime 取最大。取过滤后最大时间，不能盲取列表第一条或按用户名排序。最大时间并列时保留一个同时间候选。
- 新鲜度：摘要参与行/投影相等性检查，计数、未读不变但摘要变化也会重发。使用前检查子投影的账号、分组定义/选择、排重、隐藏集合和隐私 revision；发布继续通过既有账号 epoch 门禁；展示时再次检查账号、revision、blocked 及会话可见性。
- 保护与布局：没有可见折叠会话时沿用原规则隐藏入口；保留 2.0-21 的连续卡片首末/间距、图标、行高和两行结构，摘要左对齐。全局消息 label、时间与头像内未读仍被遮蔽；不修改成员/未读计算、选择器、存储或密友隐藏策略。

生产变更限于 `CSCloseFriendSessionPresentation.m`、`CSGroupNativeBridge.m`、`CSGroupProjection.h/.m`；另外更新版本/说明和相关用例。完整 [差异](changes-from-2.0-21.diff) 与 [文件 SHA256](changes-from-2.0-21.json) 可复核。

## 只读来源的实际边界

原生 `getCellData:` 会创建、保存 cell 缓存并处理 red tips；本次不调用它，也不执行可能修改 native message 的 digest formatter。已有摘要缓存尚未生成、消息 ID 为零/不匹配、接口不支持、时间不可确认或最新会话摘要不可用时，显示中性“折叠的聊天”。不以较旧摘要冒充最新，不使用全局聚合入口兜底。缓存就绪后随既有会话/页面刷新重新读取。

已静态核对微信 8.0.78，具体 selector、地址、反汇编和来源限制见 [原生证据](native/findings.md) 及 [哈希清单](native/manifest.json)。不同微信版本和缓存生成时机仍需真机确认。

## 先失败，再通过

补用例后先用未改的 2.0-21 生产源码执行两份指定脚本；341 份 Controllers/Hooks/Headers 与任务开始快照字节一致，见 [修改生产代码前的核验](red-production-preserved.json)。

| 验证部分 | 检查数 | 2.0-21 失败数 | 2.0-22 失败数 |
| --- | ---: | ---: | ---: |
| verify-list-corners.sh | 1020 | 24 | 0 |
| verify-close-friend-session.sh：会话/摘要 | 116 | 19 | 0 |
| verify-close-friend-session.sh：展示/复用 | 38 | 16 | 0 |
| 合计 | 1174 | 59 | 0 |

[红阶段圆角日志](logs/red-corners.log)、[红阶段会话日志](logs/red-session.log)、[绿阶段圆角日志](logs/green-corners-1.log)、[绿阶段会话日志](logs/green-session-1.log)、[机器可读结果](regressions.json)。只跑这两份脚本；相对前版净增加 32 项断言，并将旧数量/缩字断言更新为新要求。

新增覆盖：无数量原生标题、原生字号及 label 身份；最新密友跳过、全隐藏无入口；本组与其他组隔离、乱序/置顶不冒充最新；原生各时间字段；摘要文本独立变化；NSString 不可变复制/富文本取可见文字；64 位消息 ID 防饱和混淆；错缓存/未就绪/接口类型错误；账号 epoch/隐私 revision 变化；深色配色、圆角关闭再开、连续卡片、原生布局反复更新和 cell 复用。

## 编译、成品与保留

两种安装方案均编译 arm64 / arm64e；包内版本、布局路径、切片与 4 份 dSYM UUID 已核对，首个初始化器仍为 CSPluginStorageLoad，测试替身没有进入产物。每种方案与 2.0-21 同为 12 条既有警告，新增 0 条；无编译错误。详见 [编译核对](build-verification.json) 和 [成品哈希/UUID](packages.json)。

新增文件：

- `packages/com.wechat.improve_2.0-22_iphoneos-arm.deb`，SHA256 `b2504cd23dba6fda206f6ae3eb000fbd386762d8990a0401fb62b810bb488a9b`
- `packages/com.wechat.improve_2.0-22_iphoneos-arm64.deb`，SHA256 `731a260e13eb0d04ec5c5fe697e3e87b2cc7773858426b4e39a38783b938b0d4`
- `packages/com.wechat.improve_2.0-22_symbols.zip`，SHA256 `300e0ad187fd11550c9c8af9453159b5511ec081bf1f5c379e706a17b002124c`

构建放在独立临时目录；未运行 make clean。原有 45 个 packages 文件、2952 个历史审计文件、1173 个工作区 .theos 文件全部 SHA256 一致；没有删除既有文件。14 个授权文件修改、2 个测试文件新增；其他既有文件不变。详见 [保留证据](preservation.json)、[源码清单](source-sha256.json)。

## 真机验收

1. 在一个自定义组放入两个有折叠会话的群聊，另一组放入第三个群。让第三群最新，确认当前组入口仍只显示本组最新群的原生摘要；标题固定“折叠的聊天”，与原生字号一致且不含数量。
2. 在当前组内交替发文字、图片、链接、引用，确认摘要与折叠列表内相应会话的原生摘要一致，左对齐；置顶较旧会话后不能仅因列表排第一就错误选中。私聊组同样验证。
3. 将最新会话设为隐藏密友并锁定，确认顺延到下一个可见最新会话；本组全部隐藏时入口消失。解锁/重新锁定、切换账号后不得闪回上一个账号或策略的摘要。
4. 开启深色模式、改圆角半径和左右边距、关闭圆角再开启；确认字体未缩小，摘要配色跟随原生，连续卡片与原生两行高度保持，时间/全局未读没有被放开。
5. 反复切组并上下滚动让折叠 cell 被普通会话复用，再滚回；确认标题不重复、摘要不串组、普通 cell 恢复自身显示。更新本组消息但不改变会话数/未读数时，摘要也应更新。
6. 冷启动若原生摘要缓存未生成，应显示中性文案；进入折叠列表让微信生成对应会话的原生 cell 后返回，确认随页面刷新显示本组摘要。若仍持续中性，请反馈微信版本及这一步的前后表现，便于核对该版本原生缓存字段；保护性回退不能展示其他组旧摘要。
