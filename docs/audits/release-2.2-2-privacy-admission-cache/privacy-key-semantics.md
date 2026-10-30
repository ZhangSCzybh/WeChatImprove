# 方案 C：隐私准入证明键语义核验

核验基线：`8467df87bebb2998f021238b7d88eaea65266214`（2.2-1）。本子任务只读审查 Policy / Runtime / 账号边界及 Adapter 生命周期；未改生产代码、Tests、脚本，未编译、打包或提交。8 个语义输入文件的工作树字节均与 HEAD 一致，逐文件哈希见 `privacy-key-semantics.json`。

结论：在当前生产 Runtime 的 revision 规则和不可变投影语义下，拟议键覆盖相关隐私变化。缓存只能省略原本的逐行 `hidesUserName` 扫描，不能省略任何现有准入检查、实际原生布局或原有布局后失配处理。写入成功证明时必须绑定**实际被扫描的那个投影**，防止同步重入把证明贴给另一个对象。

## 隐私变化如何令旧证明失效

| 事件 | 生产代码位置与语义 | 证明失效依据 |
| --- | --- | --- |
| 临时解锁到期 | Runtime:84 根据单调 `elapsedClock` 重算 revealed；:85 发现与已发布快照不同就调用 `changed`；:42 增 revision、清两个快照。 | 每次布局必须先调用当前 snapshot。revision / revealed 改变立即 miss，不能等待 timer 或异步通知。 |
| 密友 / 密群名单增删 | Runtime:215–220 的 `updateProfile` 归一化并走 `saveState`；保存并读回成功后 :213 调 `changed`。Policy:16–21 复制名称数组和名称，:48–55 创建不可变集合和选项。 | revision 改变；不需每次布局重算名单 fingerprint 或扫描名单内容。 |
| enabled 修改 | 与名单相同的 `updateProfile` / `saveState` 路径；Policy:53 读取 enabled。 | revision 改变；键再显式带 enabled，避免只依赖通知。 |
| hideSessions 修改 | 同一 profile 保存路径。Policy:62 的 surface 0 对应 hideSessions，:63 读取其布尔值。 | revision / hideSessions 改变。其它 surface 选项也保守增 revision，但本证明只服务 Session，无需逐个加入其它 surface 位。 |
| 手动锁定 | Runtime:92–99 将 revealUntil 清零并失效认证；仅之前显示状态确有变化时 `changed`。 | revealed / revision 变化；已经锁定且策略未变时不增 revision 是正确语义，可继续复用同一准入证明。generation / searchRequest 不影响 Session 隐藏集合。 |
| 解锁成功 | 密码设置 :120、密码成功 :139、快捷解锁 :147、生物识别成功 :204 均 `changed`。 | revision / revealed 变化。 |
| 账号开始切换 / 切换完成 | Bootstrap:135–140 原子递增 epoch 并更新 suspension；will :142、did :143–145 都调用。did 的账号通知异步发布。Bridge:8–11 将当前 epoch/suspended 交给 Runtime。Runtime:80–82 在 epoch 失配 / suspended 时立即返回 blocked、空账号边界快照，revision 可能与之前相同。 | **live epoch + blocked + account precheck 必须每次检查**。仅监听异步账号 / policy 通知不足以保证即时边界。 |
| Runtime 同步新账号 | Runtime:57 只在同账号、同 epoch、同 suspended 且非 blocked 时短路；其它情况 :59–74 重载并 `changed`。 | 账号、epoch、revision / blocked 改变。 |
| 前后台变化 | Runtime:105 的 setActive:NO 调 lock；Manager:222–225 在同步 flush 前锁定；:227–232 返回前台时同步账号。 | 策略键 + activity 显式 clear。已锁定时 active 改变不一定增 revision，但可见性规则未变。 |
| 保存失败 / 重置 | Runtime:209/:212 失败设 blocked 并 lock；reset :242–246 无论成败最终 changed。 | blocked 必须直接拒绝缓存，不能把“每个失败都必增 revision”当作前提。 |

`changed` → Manager:103、:106–114 合并发布 policy notification。这条通知用作主动 clear，但成功证明的安全性不能依赖通知已经送达。所有 profile 修改由主线程拥有（Runtime:216；Bridge:44–53），快照读取仍可能观察到账号原子边界或到期变化。

## 必须保留的准入与缓存键

现有 Adapter:659–662 在缓存查询之前继续要求：非 blocked、策略账号等于当前账号、projection valid、retry 为 false、snapshotEpoch 等于当前 epoch、投影账号匹配、投影 privacyRevision 与 policy revision 匹配。不可把缓存命中当作跳过这些检查的许可。

成功证明绑定下列数据：

- 不可变 projection 的对象身份，缓存端用弱引用；比较期间用局部强引用。不要仅保存裸地址 / 数字，避免对象释放后的地址复用。
- 复制后的账号字符串、live account epoch、policy revision。
- enabled / revealed / blocked / hideSessions 位。
- 投影 privacyRevision 已知且匹配；合法已知的 revision 0 与未知 / 不可读必须区分。
- 每次仍检查 projection valid、snapshotEpoch、retry 状态；存储成功证明时 retry 必须为 false。
- table / adapter 的生命周期：detach 清旧证明，新表实例不继承旧表证明。

投影持有只读 sections（Projection.h:76）；构造时复制 section 数组（Projection.m:335/:344），普通行复制必要字段，新的摘要变体返回新投影（:365–382）。`discardComputationCache`（:398–400）只清计算缓存，不修改已发布行集合。因此不需要为本证明增加 modelRevision、section 数量、滚动偏移或几何；这些都不能替代投影对象身份。实际 layout 仍必须每次执行，缓存不证明屏幕几何已经完成。

## 写入证明的同步重入边界

入口捕获实际扫描目标 projection 和 table。扫描成功后仍执行原来的 `CSGroupWithDisplayIndices(self.table,layout)`，并让 Adapter:680–691 的布局后 mismatch 分支原样执行。

只有原 postcheck 通过，并且下列条件仍成立，才可写缓存：

1. self.projection 仍等于入口扫描的 projection，self.table 仍等于入口 table。
2. projection 仍 valid，snapshotEpoch 仍匹配捕获 epoch，retry 仍 false。
3. 投影 privacyRevision 仍已知、匹配；当前策略签名及账号 / epoch 仍匹配入口签名。

这些附加条件只决定“是否保存本次成功证明”，不改原有本次 layout 的行为。**不能在 postcheck 后直接给当时的 self.projection 标记已验证**：layout 中同步 refresh 可能替换投影，而逐行扫描验证的是旧对象。缓存命中后也同样执行真实 layout 和原 postcheck，布局中发生策略 / 账号变化依然走原来的屏蔽 / 刷新分支。

## 最小显式 clear 点

- Adapter `closeFriendPolicyChanged:`（原 :459，遍历 :464）在 shield / refresh 前 clear。
- `applicationActivityChanged:`（原 :492，遍历 :497）在失效和刷新前 clear。
- `detach`（原 :524）在旧表 UI / proxy 交接前 clear。
- `refresh` 检测账号改变的分支（原 :820）在清 projection 前 clear。
- 新表 attach 原 :173–180 已先 detach 旧 adapter 再创建新 adapter。新实例的空缓存即可，无需增加新生命周期 hook。
- 未就绪或布局后失配时清旧证明，是最直接的状态管理；即使保留其数据也绝不能绕过每次前置条件。

不需要为方案 C 修改 `setPresentationSuspended:`：它的 `discardComputationCache` 不会更改不可变已发布成员；新投影身份、现有 snapshotEpoch / retry precheck 仍负责失效。也不需要在每次普通 modelRevision 递增时粗暴清证明，否则会抹去“同一不可变投影被安全复用”的优化收益。

本结论是源码语义与键设计审查，未声称已验证真机 UIView 身份、自然 UIKit 回调时序、屏幕首帧或实际 CPU 降幅。

## 已实现代码复审

复审源文件：`Controllers/CSGroupListAdapter.m`，SHA256 **`82e96b805c63593b036804ca46159de95e44b15c3dfb59f6377ebc0b423c8ec8`**。对照基线仍为 `8467df87`，原布局后 mismatch 分支已提取逐字节比对，结果完全相同；对应片段哈希存于 JSON。此处行号指上述已实现文件。

复审结论：已实现代码没有发现新增的隐私准入、解锁到期或同步重入正确性缺口。最终差异追加了 table 非 nil 的 cacheable 条件，无表时不保存证明。缓存命中只跳过逐行扫描，布局入口新 snapshot、原 readiness、真实 display-scope layout 及布局后 mismatch 仍每次执行。缓存写入位于原 mismatch 分支通过之后，并确认实际扫描的 projection、table、epoch、snapshotEpoch、modelRevision、retry、policy 对象/版本/四个策略位及投影版本均未改变。到期发生在入口前会 miss；到期发生在 layout 内会由第二次 snapshot 读取触发旧 mismatch 屏蔽分支。

实际实现比初始提议更保守：

- proof 字典**强持有 projection 和 policy**，不是弱持有投影；table 使用仅含一项的弱 NSHashTable 保存身份。强持有避免投影地址复用，只保留每 adapter 单份成功证明；projection / policy 无回指 adapter，不构成循环。table 必须保持弱身份，避免 table → adapter → proof → table 的保活环。
- 增加 modelRevision 到键，并在 `invalidateNativeSnapshot` clear。普通模型事件后即使仍复用相同不可变 projection，也会重新扫描；这减少部分缓存命中机会，不会放宽隐私。
- refresh 检测账号变化时调用 `invalidateNativeSnapshot`，同时 clear 并推进 model token；policy / activity 事件原来已调用此方法，因此无需新通知路径。

初版复审发现并已由主任务修正的一点：`invalidateNativeSnapshot` 可由后台 native notification 进入（Hooks:46–51 → Adapter 的 beginNativeChangeOfKind），因此 proof 的关联对象读与 clear 可能跨线程交错。初版使用 RETAIN_NONATOMIC 不提供返回值跨线程保活保证。现版本 **6 处 proof set / clear 全部改为 `OBJC_ASSOCIATION_RETAIN`**；本机 Objective-C runtime.h 的 :1632–1637 明确区分非原子/原子保留策略。主线程取出的 proof 在并发 clear 时仍可安全持有。clear 与 modelRevision++ 之间即使重入写入旧 token，后续 admission 的 model token 比较仍会 miss。

已复审源码与静态哈希，不代表本子任务运行过并发压力 / TSAN、真实 UIKit 重入、真实 UIView 寿命测试或真机性能采样。相关功能计数和构建由主任务记录，本文不冒充运行结果。
