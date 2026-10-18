# 1.8-14 自动收款与红包优化

实施日期：2026-10-18。用户已授权按上一轮审计方案顺序实施。基线为用户要求回退后的 **1.8-11 + 已完成的语音等价清理**，不是 Git HEAD 中的分组动画版本。本次没有修改分组动画和语音实现。

## 已实施的行为

### 自动收款

- 同时检查当前账号、实际收款人、付款人、明确的转账要约状态；结构化支付字段与 XML 冲突、缺少身份或状态时不自动领取。群消息投递给本人不再等于本人有收款资格。
- XML 采用有边界的解析，限制内容大小，拒绝重复关键字段、嵌套关键值及 DTD/实体声明。金额不再从展示文字和浮点数推算。
- 两个消息入口共用业务键（账号、类型、会话、交易 ID），避免重复提交。实际在途自动转账限制为一笔。
- 标记插件创建的 controlData、逻辑实例和准确的 TenPayRequest；原生广播式 OnConfirmTransferMoney 没有交易 ID，不能作为任务匹配依据。插件自己的逻辑忽略该广播；手动逻辑继续原生处理。
- 检查原生请求身份、传输层/平台层/业务返回码、付款人与收款人、整数金额及币种后，才一次性保存成功记录并提交回复、通知。异常、引导确认、无法证实的结果不会谎报成功。
- 原生实名许可确认入口保留；其接受回调即使延后执行，也携带原任务并重新核对代次、开关和截止时间。
- 微信已有支付逻辑时不启动新的自动收款，避免暂停或抢占用户正在使用的流程。插件任务结束时释放原生逻辑；不再遍历界面或构造空聊天控制器。

### 红包

- 查询和打开都绑定插件创建期间捕获的 HongBaoReq 对象。手动请求和未登记请求不会触发自动回复/统计。
- sendId、channelId、msgType、nativeUrl、已提供 sign、打开时的会话和 timingIdentifier 必须一致；不能通过另一个命中的字段掩盖冲突。
- 所有回调先复制有界数据快照，原生方法照常执行，再异步解析和更新任务。校验响应类型、返回码、查询状态及金额，NSNull/异常字段不会阻断原生处理。
- 零延迟、有延迟共用一套调度；串行最多 1 个在途查询/打开，普通最多 5 个。已提交请求等待到回包、失败或超时才释放名额。普通切换串行时，已有在途请求不会凭空消失，但不会再补发新任务，直到符合新上限。
- 已领、抢完、未知状态、缺 timingIdentifier、请求异常、服务缺失、取消和超时均结束任务。无请求重发循环。
- 排除私聊自己发出的红包；群内本人发送的红包遵守原开关，白名单/黑名单采用预建集合，专属收款人明确为其他人时跳过。
- 删除旧参数队列、双 OperationQueue、Operation 和仅服务于旧调度的参数类，共 8 个文件。删除同步等待主线程、sleep 重试以及 AddLocalMsg 伪装发送成功的回退。

### 公共资源与记录

- 任务状态由主队列统一管理，配置是不可变快照；原生账号边界由独立原子代次标记即时失效，不依赖语音内部状态。
- 单次最多 128 个转账任务、256 个红包任务；入口待处理快照也设 384 上限。排队期限 30 秒加设置延迟，在途超时 30 秒，延迟限制为设置页已有的 0–10 秒。
- 仅在存在任务时安排最近截止时间的一次性定时器；空闲时无轮询。恢复前台时先清理过期任务，不补发长后台前的过期请求。没有新增保活机制。
- 功能关闭、范围改变会撤销不再符合条件的未提交任务；已提交的同账号成功结果仍可记账，但关闭后的回复和通知不会发送。换号/同账号重新登录后，旧回包和许可回调均失效。
- 成功统计与最近成功 ID 一起由独立 IO 队列原子保存，再提交副作用。历史计数/金额迁移前另存备份；保留旧 defaults 键供现有界面读取，不执行每笔 synchronize。
- 新记录位于微信沙盒 `Library/Application Support/WeChatImprove/payment-ledger-v1.plist`；首次迁移的旧统计备份为同目录 `payment-statistics-before-v1.plist`。这次主机测试只使用随机临时目录和 defaults suite，未写手机或真实微信数据。
- 成功去重最多保留 2,048 项、7 天；进程内终结任务去重最多 2,048 项、24 小时。写入失败/文件损坏时停止自动提交，不清空或覆盖历史记录。
- 金额按整数分处理；转账通知使用回包币种，人民币总额仅累计 CNY。红包统计沿用普通人民币红包语义。
- 详情汇总随原生 `refreshViewWithData:` 和布局更新；文字/位置相同时跳过赋值，移除等待 0.25 秒猜测网络完成的回调和重复安装 Hook。

## 原生协议证据与边界

静态核对本地既有微信 **8.0.78.34 / arm64** 二进制，SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。源路径 `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`，不是从本次手机现场采集的二进制。

`native/` 保存提取脚本、方法类型和相关反汇编：

- WCPayControlMgr `startReceiverConfirmTransferMoneyLogic:Data:`：返回 unsigned int，创建/启动对应逻辑并设置委托。
- WCBaseControlMgr `startLogic:`：启动前设置逻辑 tag、入栈并暂停已有逻辑，因此新增已有流程保护。
- WCPayLogicMgr `ConfirmTransferMoney:`：生成 `trans_id`、`op=confirm`、`group_username` 等字段，再构造 TenPayRequest；原生回调 `insideCallBackOnConfirmTransferMoneyResponse:OnRequest:` 读取 retcode、wx_error_type、fee、fee_type、payer、receiver，并广播没有交易 ID 的确认响应。
- `checkAndShowRealnameLicense:acceptCallback:denyCallback:startLoadingCallback:stopLoadingCallback:` 的方法 ABI 为 `v52@0:8I16@?20@?28@?36@?44`。转账调用处接受回调的 block 描述符 `0x11d5fb158` 及加载回调描述符 `0x11d5f6540` 的签名均为 `v8@?0`，按无参 void block 包装。
- 红包 `GetHongbaoBusinessRequest:CMDID:OutputType:` 构造 HongBaoReq、设置 reqText 与命令，并调用 WCToHongbaoCommonRequest；查询命令为 3、打开命令为 4。
- UnionTransfer 的确认响应只有操作返回码，没有足够的金额/身份信息；本版不凭这个 OK 回调生成成功副作用。不能由普通私聊/@chatroom 的替身测试推断企业互通/特殊支付协议全部兼容。

没有用 `invalidtime` 推测绝对失效时刻或时长；按原字段传给微信，插件另设自己的排队/请求期限。字段和协议无法确认时保留手动处理。客户端本地记录不能保证跨崩溃端到端恰好发送一次：先落盘再提交回复，极端崩溃窗口可能少回复一次；AddMsg 返回只表示已交给原生发送队列，不代表对方收到。

## 核心验证

命令：`bash Tests/verify-payment-core.sh`。旧命令 `Tests/verify-transfer-admission.sh` 转到同一核心套件；删除已失效的旧入口测试文件。没有扩展到无关 UI/分组/头像回归，也没有重新重复已通过且本次未改动的语音测试。

- `PaymentCoreTests.m`：2,210 个断言，包含身份/状态解析、冲突/畸形字段、1,000 项容量压力、重复任务、真实在途限制、截止时间、旧统计备份/迁移、成功防重、重启恢复与损坏文件处理。
- `PaymentAutomationTests.m`：59 个断言，编译真实协调器和提取的生产 Hook，使用隔离原生替身。验证第三方群转账不动作、私聊/群聊本人成功、重复入口与回包、未登记手动响应、手动收款 startLogic、已有支付流程、关闭功能、换号/同账号重登、延后许可回调、长后台过期、零延迟串行、普通并发切换串行、失败回包、NSNull、白名单、私聊外发、本人群红包及无关消息。
- 原生服务回调在畸形/失败数据下仍被调用，测试不连接微信和网络，不提交真实交易和消息。
- Rootless `arm64`、`arm64e` 构建；包版本、两个 Mach-O 架构、打包/暂存/构建 dylib 哈希、dSYM UUID 和最终源码范围见 `verification.json`。

**仍需手机最小验收**：本人私聊转账一笔、本人群转账一笔、旁观者群转账及对方确认回执；红包两笔验证零延迟串行，并检查一次手动领取。建议同时确认“回复/通知/统计各一次”和关闭开关后的行为。本地测试不是实机支付成功证明，尚无 CPU/功耗/温度的实测降幅。

## 交付与保留

最终安装包为 `packages/com.wechat.improve_1.8-14_iphoneos-arm64.deb`，符号为 `packages/WeChatImprove-1.8-14-dSYMs.zip`。在独立临时 Theos 构建目录完成编译，再复制回原项目 packages；没有执行 make clean、覆盖旧版本包、切换 checkout 或安装到设备。

`before-source.zip` 与 `baseline.json` 保存本轮起点；`verification.json` 核对分组/语音及其他未改动文件。`build.log`、`build-final.log`、`core-tests.log` 保存验证结果。历史审计中的“29 个断言/12 组缺陷复现”仍只代表旧缺陷证据，不作为本版修复通过的依据。
