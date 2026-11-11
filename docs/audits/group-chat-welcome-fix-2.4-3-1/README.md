# 2.4-3-1 入群欢迎漏发修复

用户反馈 2.4-3 的入群欢迎没有发送到群内，并确认微信持续位于前台。本次继续使用既有 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，修复版为 `2.4-3-1`。没有启动服务、切换数据库、连接微信账号、安装到手机或向真实群发送消息。

## 故障与修复

| 场景 | 原行为 | 修复行为 |
| --- | --- | --- |
| 启用欢迎或上次查询后 5 秒内新人加入 | 查询冷却期直接返回，没有尾随查询，唯一一次变化信号丢失 | 同一群合并保留一次延后查询；到期后读取完整名单 |
| 微信连续前台，群静置超过两分钟，缺少原生入群时间 | 旧基线超过 120 秒便拒绝欢迎，即使本次完整名单刚取得 | 仅要求本次变化快照新鲜；同一前台 session 的旧基线不因静置失效；已知过期的入群时间仍拒绝 |
| 通知中心、Face ID 等短暂失活 | 每次 DidBecomeActive 都重建基线；定时欢迎若恰在 Inactive 到期也会删除 | 仅真正进入后台才重建 session；短暂 Inactive 保留尚未过期的欢迎上下文，恢复活跃后最多执行一次 |
| 收到系统消息，本机名单缓存仍为旧值 | 仅依赖联系人变化入口，不能保证触发一次完整查询 | 新增原生群系统消息辅助入口，强制复查完整名单，不解析系统消息文案 |
| 系统提示触发的查询被微信拒绝，例如同群已有查询在途 | 丢弃本次刷新意图 | 延后补查一次，仍受账号、配置、session 与五秒闸约束；再次拒绝则停止并显示状态 |
| 原生欢迎提交失败或结果未知 | 没有可见状态 | 设置页显示名单就绪、新人检测、原生提交或失败状态；不自动重发欢迎 |

原生 void 发送调用返回只能表示已交给微信处理，设置页使用“已交给微信发送，请在群聊查看发送状态”，不等同于服务器确认送达。

真实后台切换、账号或配置变化继续清除旧任务。首次完整名单只建立基线，不欢迎已有成员。待欢迎成员提前离开时会从任务中剔除；保留其他成员的完整任务上下文。迟到回调不能跨 account epoch、配置代次或前台 session 发布。过期欢迎不会在恢复活跃后补发。

## 原生证据与入口

使用用户指定的微信 IPA `/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`，实际版本 `8.0.80.34`。IPA SHA-256 为 `5cacb443b743793ccfe6026bc81c1f2678cb5cfdcd38584ad73ac7f19ecf4a5f`，主程序 SHA-256 为 `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。

[本轮原生入口报告](native/NATIVE-INGRESS-FINDINGS.md) 记录同步接收的 BatchAddMsg block → onNewSyncAddMessage → AsyncOnAddMsg:MsgWrap: 链及真实 ABI。新增 hook 仅接纳普通 @chatroom、类型 10000/10002、非零服务器消息 ID，且 room 参数与消息 from/to 归属一致的消息。它只发出复查信号；新人身份仍由成功的完整成员响应、原生最终版本与完整身份集合校验及前后差分决定。联系人更新与完整名单响应入口继续保留。

完整名单响应处理期间通过线程局部深度抑制原方法内部的联系人刷新信号，避免每次查询结果又触发查询；深度在 finally 中恢复。所有 hook 保留原生方法且只调用一次。排队信号在入队前和执行时都检查运行令牌及账号 epoch。

原生 isNotify=NO 可绕过一条联系人扩展通知的结构性结论，不能单独证明它就是这次设备漏欢迎的根因；报告明确标注已匹配调用点与静态覆盖范围。protobuf 动态 getter 无法被 class_getInstanceMethod 解析的猜测已通过独立 fixture 排除，没有改写全局原生 ABI 适配器。

## 验证

```sh
python3 docs/audits/group-chat-welcome-fix-2.4-3-1/verify.py
```

[test-results.json](test-results.json) 保存 37 组核验结果、实际命令和源码散列，[test-logs](test-logs/) 保存输出。源码与测试输入在核验前后必须保持一致。所有服务、发送、成员查询与存储均为隔离替身，数据写入内存或独立临时目录。

| 核验 | 结果规模 |
| --- | ---: |
| Manager 默认及 25 个专门模式 | 276 项 |
| 实际 Runtime hook、完整响应及系统消息过滤 | 165 项 |
| 模板与成员策略 | 110 项 |
| 配置存储 | 27 项 |
| 原生 @ 名单与发送前授权 | 45 项 |
| 退群本地提示引用 | 35 项 |
| 群聊配置备份 | 57 项 |
| 批量退群协调器 | 12 个场景 |
| 消息动作执行回归 | 2574 项 |
| 原生选人回归 | 196 项 |
| 防撤回引用回归 | 84 项 |
| iOS 15 arm64e 群聊源码严格语法检查 | Wall / Wextra / Werror |

Manager 模式覆盖五秒内变化、连续前台静置、原生提交失败、短暂失活、尾随合并、系统提示时缓存未变化、完整旧快照不能吞提示、账号/配置/后台取消、到期失活后恢复与过期丢弃、原生请求拒绝及一次补查耗尽。多次系统提示合并，成功场景只欢迎一次。Runtime 测试通过实际替换假原生类方法安装生产 hook，系统消息正文 getter 被设为抛异常且读取次数保持零。

静态 IPA 证据和主机 fixture 不能证明本次 iPhone 场景已收到远端系统消息、完整查询已获得真实服务器回包或欢迎已经送达。邀请、扫码、审批入群与插件组合的实际字段及回调仍需安装修复包后验证。进入群聊设置，等待“群成员名单已就绪”，再使用新入群事件验收；旧事件不重放。若仍未发送，设置页的状态能区分名单、检测和发送提交阶段。

## 编译与保留

```sh
python3 docs/audits/group-chat-welcome-fix-2.4-3-1/build.py --build
```

构建冻结当前生产源码，在独立临时目录分别编译 rootless/rootful，两者均含 arm64/arm64e。没有执行 make clean，没有向既有 .theos 和历史安装包写入构建输出。保留门禁使用本次开始时的 protected-before.json，除 Finder 的 .DS_Store 独立记录外逐项比较所有历史文件。

[build-result.json](build-result.json) 保存实际构建路径、源码散列、命令、warning、包版本、载荷路径、注入过滤器、架构、关键功能/新入口符号及四份 dSYM UUID。只有这些校验及保留门禁全部通过，才发布到独立目录 `packages/2.4-3-1-group-chat-welcome-fix/`。原 `packages/2.4-3-group-chat-tools/` 保留。

交付包括 rootless .deb、rootful .deb、rootful 重签用 WeChatImprove.dylib、四架构/方案 dSYM 的 zip 和 SHA256SUMS。最终独立复核结果见 final-verification.json。

最终 37 组核验全部通过，核验前后的源码与测试散列一致。Rootless 与 Rootful 均编译成功，耗时分别为 22.97 秒和 22.98 秒；每套 8 条 warning 来自既有设置页、密友通知、红包的弃用接口及链接器旧选项，群聊源码严格语法检查没有诊断。交付文件的 SHA-256、deb 版本、归档 CRC、冻结生产源码及测试输入均再次独立核对通过。排除单独记录的 Finder 元数据后，既有 .theos 2113 个文件及历史 packages 274 个文件内容保持一致。

| 交付 | 文件 |
| --- | --- |
| Rootless，arm64/arm64e | [com.wechat.improve_2.4-3-1_iphoneos-arm64.deb](../../../packages/2.4-3-1-group-chat-welcome-fix/com.wechat.improve_2.4-3-1_iphoneos-arm64.deb) |
| Rootful，arm64/arm64e | [com.wechat.improve_2.4-3-1_iphoneos-arm.deb](../../../packages/2.4-3-1-group-chat-welcome-fix/com.wechat.improve_2.4-3-1_iphoneos-arm.deb) |
| Rootful 重签 dylib | [WeChatImprove.dylib](../../../packages/2.4-3-1-group-chat-welcome-fix/WeChatImprove.dylib) |
| dSYM | [com.wechat.improve_2.4-3-1_symbols.zip](../../../packages/2.4-3-1-group-chat-welcome-fix/com.wechat.improve_2.4-3-1_symbols.zip) |
| SHA-256 | [SHA256SUMS](../../../packages/2.4-3-1-group-chat-welcome-fix/SHA256SUMS) |
