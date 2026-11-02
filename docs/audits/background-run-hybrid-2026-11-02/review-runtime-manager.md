# Runtime 与 Manager 独立审查

审查日期：2026-11-02（Asia/Shanghai）。审查对象为本轮 2.2-3 基线之上的混合后台运行改造，重点读取 `CSBackgroundRunManager`、`CSBackgroundRunRuntime`、`CSBackgroundRunAudio`，交叉核对 AI 的执行能力门槛和后台测试。审查期间没有修改生产实现、操作真实微信、连接设备、访问真实账号数据或切换服务。后续按明确分工给 Runtime 增加 `currentDate` getter 的修改另列于下文。

本次发现一处可复现的音频激活与任务到期重入问题；Manager 已改用 pending-expiry 处理，正式回归由后台状态机测试负责人补充。对最新修复的静态复核未发现同一问题残留，也未发现第二处需要修复的问题。该结论限于所检查的代码与主机替身，不能证明 iOS 设备的后台时间、温度、续航或长期调度结果。

审查范围包括以下交界：

- 每个 UIKit task identifier 的归属、失败申请、同步到期、重复结束、旧任务迟到回调和先申请新任务再结束旧任务。
- 系统到期与音频启动之间的重入、前后台切换、开关切换、取消、资源释放和通知内同步重入。
- 预算不足时的音频接替、有限正预算的恢复回差、最短音频持续时间、无穷／NaN／负数预算和失败后停止重试。
- 单次检查的代次、取消后迟到交付、Timer target 的引用关系和回调中的检查重排。
- `canAttemptBackgroundWork` 与实际音频活跃状态的发布，以及 AI 在有限任务阶段的准入。

已发现问题的精确触发顺序如下。旧 `-[CSBackgroundRunManager taskExpired:generation:]` 在任务到期时直接调用 `finishCycle:`，后者立即进入 `releaseResources` 并调用 `audio.stop`。若到期重入发生在 `-[CSBackgroundRunAudio startWithError:]` 的 `setActive:YES` 原生调用内，原生会话已成功激活，但 Audio 要在原生方法返回后才会将 `activated` 设为 YES。此时重入的 `stop` 看到 `activated=NO`，跳过 deactivate，随后恢复旧 category 并清除租约。启动返回后由于租约已失效而失败，第二次 `stop` 也无法结束已丢失归属的激活状态。

复现使用 [BackgroundRunHybridTests.m](../../../Tests/BackgroundRunHybridTests.m) 的 `Create`、`Background`、`NoResources` helper，以及实际生产 Manager / Audio / Runtime 和可控 FakeRuntime。核心 fixture：

```objc
Create(YES, 9);
AVAudioSession.sharedInstance.activationAction = ^{
    [runtime.tasks.firstObject expire];
};
Background();
NoResources();
CHECK(!AVAudioSession.sharedInstance.active);
```

原生会话替身在 `setActive:YES` 中先写入 `active=YES`，再执行 `activationAction`；这准确落在生产 Audio 将 `activated` 设为 YES 之前。旧 Manager 下 `NoResources()` 通过，但最后一个断言失败，进一步打印得到：

```text
Expiry during activation: active=1 category=AVAudioSessionCategoryAmbient
```

该 fixture 证明生产 Manager / Audio 在指定重入顺序下可泄漏已激活的原生音频会话。它不证明未修改的 UIKit 会在普通非重入调用栈中按此顺序交付到期：真实 Runtime 始终异步向主线程交付 owner handler，普通同步到期已被隔开；嵌套事件循环或注入边界重入仍应由 Manager 的串行协调处理。临时程序及编译产物位于主机临时目录并已清理，本次没有保存单独的红测二进制或原始日志文件；上面的 fixture 和工具输出是这次临时复现的记录，不冒充完整留存的正式红绿测试证据。

Manager 的修复将到期先记录为 `taskExpirationPending` 并请求 `reconcile`。若当前正在协调，`reconcileAgain` 只安排下一轮，音频原生启动先完成；下一轮再根据当前任务和音频有效性决定结束还是继续。这样避免在音频激活栈内部停止／恢复会话，也不会用旧任务的到期事件误结束新任务。正式测试应允许“已成功的音频继续且状态一致”，或“结束且原生会话已释放”两种符合对应场景的结果，不能只检查 Player、Task 和 Timer 数量为零。

另外三个临时重入场景使用相同生产编译输入，共 11 项检查通过：

- `activationAction = ^{ Foreground(); }`：最终没有任务、检查或播放器，原生音频会话未激活。
- 首次 `canAttemptBackgroundWork=YES` 的状态通知内立即 `Enable(NO)`：最终释放全部资源。
- 相同通知内同步 `Enable(NO); Enable(YES);`：最后只有一个有效 task 和一个待执行检查，返回前台后全部释放。

Runtime 的原生到期 block 弱引用 handle 是安全的：Manager 的 `task` 强引用保持当前 handle；弱加载在发送 `expire` 消息期间临时保持对象；所有者释放 handle 时，handle 的 dealloc 会结束自己的 identifier。Runtime 不持有 task/check 列表，Timer target 也弱引用 check，未发现内部强引用循环。

已经排队的 expiration handler 在手动 `end` 后仍可能交付。这里将其视为“此前已发生到期”的事实通知；Runtime 不因 `end` 撤销该事实。Manager 同时验证 generation 与 task 对象身份，前台清理先将 task 清空，轮换先将 task 替换为 candidate，因此旧回调不会结束新任务，也不会复活旧轮次。调用者仍须遵守这一身份检查契约。

对恢复路径的复核确认：只有有限且为正的预算参与恢复；音频至少运行 10 秒，并取得三个相隔至少 1 秒的预算恢复样本后才停止音频。无限、NaN、负预算不构成恢复证据。执行能力和音频活跃位均参与状态发布，因此纯有限后台任务运行也能通知 AI 消费者，状态不再只靠文案是否变化。

独立 Runtime 专项最初执行 `bash Tests/verify-background-run-runtime.sh --ios`，结果为 **46 checks passed**，并通过实际 iPhoneOS SDK、iOS 15.0 target 的 arm64 / arm64e `-Wall -Wextra -Werror` 对象编译。覆盖申请失败、立即失效并先结束任务后通知、重复结束／到期、旧任务与新任务隔离、同步到期、结束时重入到期、非主线程到期、丢弃 handle 的释放、Timer 取消／迟到／重复交付／回调重排／无内部引用循环，以及真实 Foundation RunLoop 的单次触发。

之后用户批准增加运行记录，按分工仅给 `CSBackgroundRunRuntime` 协议和实现增加只读 `NSDate *currentDate`，实现返回 `NSDate.date`。RuntimeTests 新增一项断言，检查 getter 返回值处于调用前后读取的系统日期之间。再次执行同一脚本，结果为 **47 checks passed**，arm64 / arm64e 对象编译继续通过。该 getter 不新增 Timer 或磁盘写入；记录逻辑对墙钟和单调时钟的使用另待 Manager 记录实现完成后独立复核。

以上检查未安装或运行设备端插件，没有测量系统实际保留进程的时长，也没有将主机断言数换算为续航、温降或后台消息到达率。
