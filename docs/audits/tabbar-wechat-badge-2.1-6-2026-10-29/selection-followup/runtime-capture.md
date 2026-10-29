# 针对“选择名单就消失”的最小采样

本轮没有连接手机。`selection-runtime-probe.js` 只在本审计目录，是上级只读观察脚本的隔离副本；增加保存 profile、策略发布、主列表离屏和 setViewControllers 的自然调用标记，且不记录 profile 参数、联系人、消息或账号原文。只做过 `node --check`，未在设备执行，不生成诊断插件包。语法结果见 `runtime-probe-syntax.json`。

有现成 Frida/Objective-C bridge 环境时，按上级 [采样文档](../runtime-capture.md) 确认实际进程、已加载插件版本后附加，脚本换为本目录副本。保留同一账号与现有开关，不重置数据。没有现成工具时，只回传下面的手工观察即可，不为本轮安装或升级环境。

## 最有区分力的一组复现

1. 找一条已有数字未读的普通会话 A，并确认候选密友/密群 B 当前无未读。不要打开 A 将它标记已读；只记录普通数字是否大于 0，不记录联系人或正文。
2. 当前名单为空时，记录微信数字，并执行 `badgeAudit.capture("selection-empty")`。
3. 在现有设置中选择 B 并保存；执行 `badgeAudit.capture("selection-friend")`（选群用 `selection-group`）。保留自然的 updateProfile → flushPolicyRefresh → filter → controller/item 输入输出日志。最好在返回首页后再执行 `badgeAudit.capture("after-return-main")`，避免只观察到设置覆盖期间的中性零。
4. 回到主列表收到一条普通消息，执行 `badgeAudit.capture("after-message")`，保留 begin/end/refresh 前后自然事件。没有新 setter 的刷新与写入 0 后的刷新要区分。
5. 清空名单保存，再执行 `badgeAudit.capture("selection-cleared")`，记录恢复数字前最后一个真正写 tab 的事件。清空名单的 getter nil 不会自己改 badge；要查是哪个原生/间接事件重写了数字。
6. 保持同一名单与其它配置，只关闭底栏样式，重复一次；目前“样式关 + 名单非空”的现场结果仍待验证。

另可在同一份非空名单下冷启动，附加后先执行 `badgeAudit.capture("cold-before-message")`，再收普通消息并标记 after-message。对照冷态的真实 root/ChatTab、过滤 nil/0/正数、adapter 是否有效和最终 badge 状态。

## 能证明和不能证明什么

原生输入>0、对应的 filter=0、实际 item 收到0、同一 badge 随后 hidden=YES，才能证明这次是内容覆盖；同时普通会话 A 确有数字未读，才可排除“过滤后本来就该为零”。关联需要已配对的同线程 enter/leave、controller/item 对象和实际 index，不能只用日志中相邻数值拼接。`setPresentationSuspended:`、dirty/cache/depth/revision 可进一步提供失效线索。“可靠刷新后缺重发”只能描述为覆盖明确的有限观察窗口；现有脚本没有独立验证可靠发布的全部前提。

脚本按每次 setter 读取实际 root class；同一次冷启动若最早已捕获的写入 ChatTab=true，就不能把那次写入归因于识别失败。正常 attach 在初始化之后，**无法还原更早的首次写入、Hook 尚未安装阶段或占位 controller 阶段**；即便增加 setViewControllers 观察，也不能补回 attach 之前的事件。需要原本就能覆盖启动的诊断环境才能证明这个早期窗口，脚本本身不保证早期注入或后续 Hook 替换链覆盖。

账号比较仍显式 unavailable，epoch 只来自自然 snapshot 入参与保存字段；不主动重算投影/未读。UI 属性只在主线程读取，后台事件会保留“不可采 UI”的状态。native 异常可能漏掉 onLeave，未配对调用不能当完整时序。脚本不验证像素裁剪或性能，日志缺失不能证明“从来没有恢复事件”。

## 第一轮脚本尚未覆盖的关联

- `updateProfile:error:` 的 enter/leave 不含 BOOL 返回值、store 读回或 changed，不能当成保存成功；`flushPolicyRefresh` 也没有标出两个观察者各自的全部边界和固定先后。
- 自然 snapshot 的 policy flags 已按同线程嵌套 filter 采样，但手动 capture 使用的是此前样本，不是当前策略。具体拒绝分支、被 getter 采用的 adapter 与实际投影 count/redDot 未采。
- App 图标写入也会重入 getter，脚本没有观察该 setter，未输出 controller/app/observer → filter 的 parentCallId。只能利用完整区间作有限关联；无归属的 filter、自然 getTotalUnreadCount 返回值不能随意配给另一请求。
- cache/dirty/revision 等属性不足以证明当前账号和全局 epoch 匹配；refresh leave 未说明 finished 或缓存成功发布，且若干 refresh guard 未采。因此不能自动把 leave 解释为来源已经可靠。
- 新增 lifecycle 标记没有接收者指针，begin/end 未记录 kind/coalesced，多个 adapter/事务时分类有限。chatTabMatch 是根据当时 root 推算，未采原 C 判断或弱 TabOwners 登记；setViewControllers 后的新增字段只读 index 0。

这些限制不影响源码条件链和隔离数值矩阵的结论，但意味着首轮日志主要用于缩小分支。若仍不能确定对象、事件与来源的对应关系，应先在隔离诊断补该边界，再认定设备根因；不能让缺失字段被推断值代替。
