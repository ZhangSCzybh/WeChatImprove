# 1.8-16 转账成功链路修复

## 范围与现象

基线是工作目录中已交付的 1.8-15，用户反馈私聊、群聊均能自动收款，但回复、记录、通知都没有生效。此次只修改转账成功处理及其共享任务状态；红包 Hook、设置、领取分支、账本存储格式和既有语音、分组保持原有行为。

## 已确认的代码缺口

1. 1.8-15 只在确认命令 85 的回包中直接读取 fee / fee_type / payer / receiver，要求字段完整且匹配，然后才执行共用的 CSSuccess。字段缺少或附带非空提示结构都会提前结束，三个效果同时缺失。
2. 微信 8.0.78.34 的原生流程在确认后调用 checkMoneyStatusAfterConfirm:，通过 CheckTransferMoneyStatus: 发出命令 84；最终回包使用 trans_status、payer_name、receiver_name、fee、fee_type。插件此前抑制了无交易 ID 的全局确认广播，也没有补齐这一笔交易的状态核验。
3. 旧测试用的理想确认回包始终带完整金额和双方用户名，没有验证确认后查询最终状态的流程。新增 regression-before.log 在原生产代码上复现：确认只有成功码时，没有状态查询。

以上是源代码和本地微信二进制的静态证据，不是用户设备真实网络回包。未获取设备回包，不能断言是哪一个字段或提示结构触发了这次漏记。

## 修复

- 确认请求成功后进入独立核验阶段，通过微信自己的状态查询方法读取一次本笔交易；不重发确认，不循环查询，不扫描历史。
- 命令 85 按 trans_id + op=confirm 关联；命令 84 按 transfer_id 关联，群聊都校验 group_username。只有任务作用域内发出的核验请求才绑定，任意查询或全局广播不能创建成功记录。
- 仅接受该任务的同一个查询请求对象；同时检查当前账号、登录代次、超时、网络及业务错误。必须返回 trans_status=2001、收款人是本人、付款人与原始卡片一致且金额为正，才执行 CSSuccess。
- 不用确认回包的金额、身份缺省值或附带提示决定到账。单次只读查询不会接受实名协议或跳过原生确认门槛；待领取及其他非成功状态不触发任何收款效果。
- CSSuccess 仍先持久化并去重，再按当前开关回复原会话、通知自己或文件传输助手。关闭自动化后已经提交的交易仍可完成记录，但不发送回复或通知。
- 核验阶段继续占用转账并发名额，30 秒超时，完成后释放；空闲时没有轮询计时器。记录格式、历史金额与已有产物不改动。

## 原生证据位置

目标：/private/tmp/wechat-8.0.78-inset-analysis/WeChat，arm64，SHA-256 0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e。

- 既有 1.8-14 证据：WCPayReveiverControlTransferControlLogic OnConfirmTransferMoney:Error: 的 0x109999744–0x109999770 调用 checkMoneyStatusAfterConfirm:。
- 本目录 native/checkMoneyStatusAfterConfirm:，0x10999a378；普通微信分支构造 WCPayCheckTransferStatusRequest 并调用 CheckTransferMoneyStatus:。
- native/WCPayLogicMgr--CheckTransferMoneyStatus_.asm，0x1097116c4：transfer_id、group_username、invalid_time，命令 84（0x54）。
- native/WCPayLogicMgr--insideCallBackOnCheckTransferMoneyStatusResponse_OnRequest_.asm，0x10970d004：解析 trans_status、fee、fee_type、payer_name、receiver_name、is_payer。
- native/WCPayTransferMoneyStatusViewController--getMainTitleWordingInLocal_receiverContact_.asm，0x109a93c78 起：2000=WaitingReceive、2001=Succeed、2002=Rejected、2003=TimeOut。2004/2005不作为本次成功条件。

## 核心验证与交付

验证只运行 Tests/verify-payment-core.sh。测试使用独立临时 NSUserDefaults suite、临时账本和替身消息服务，不触碰微信设备、真实交易或真实聊天。

覆盖：私聊/群聊；回复开/关；通知关闭/自己/文件传输助手；确认缺少收据字段；最终金额与累计记录；页面刷新事件；落盘结果；重复确认/状态回包；他人交易、错误请求、错误身份；待领取、退回等状态；异常金额；切换账号、关闭开关、超时及网络错误；手动领取观察；共享调度中的红包核心保护用例。

测试计数和双架构产物核验见 core-tests.log、verification.json。源码快照及基线见 before-source.zip / baseline.json；旧产物校验见 prior-artifacts.json。构建使用 build-paths.json 中的独立 Theos 目录，未执行 make clean，未覆盖原 .theos。

设备上尚未安装或实测。建议用新的一笔私聊和新的一笔群聊转账确认：自动收款后回复原会话、记录次数和金额同步增加、通知到所选目标；群内别人之间的转账不得触发。历史漏记的交易没有可靠成功事件，不自动推算补账。
