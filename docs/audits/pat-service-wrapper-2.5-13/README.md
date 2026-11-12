# 2.5-13：修复后台拍动的同步服务代理识别

用户在 2.5-12 反馈：群聊后台／锁屏要回到前台后才回复，私聊后台仍立即回复。本版修复 2.5-12 引入的确定性服务身份错误。上版仅验证类 Hook 和原生时序，没有在跨模块测试中模拟微信真实的服务代理，遗漏了有效通知在 Manager 处被拒绝的问题。

## 原因

微信的服务查询返回 `MMServiceWrapper`，同步方法 Hook 的 `self` 是它内部的 `NewSyncService`。2.5-12 把两者直接作指针比较；有效服务也被当作不匹配而拒绝。配置／生命周期唤醒还把代理传给只接受具体服务类的检查，同样失败。与此同时，拍动计时器已经因为“Hook 安装成功”被停用，所以依赖这条同步路径的群拍动只能等待其他原生同步机会，例如回到前台。

这与用户“私聊正常、群聊后台退化”的反馈吻合；不能因此推断所有群拍动、所有微信版本都走同一种通知分支。

## 原生依据

使用既有微信 8.0.80.34 arm64 解密二进制，SHA-256 `e484889f7e32adce054e6b19bef373e2d1c3eb6984bc01176bbd40906373f317`。REA 绑定同一目标，并以 Objective-C 元数据及有界反汇编核对，未执行微信或手机注入。

| 位置 | 静态证据 |
| --- | --- |
| `NewSyncService` 继承链 | 它属于 `MMUserService`，不是根服务 |
| `MMContext.getService:` `0x116135bbc` | 用户服务路由到用户上下文的服务中心 |
| `MMServiceCenter.getService:` `0x1160ca3a8` | 用户服务返回缓存的 `MMServiceWrapper`；只有 rootContext 的服务才检查 raw opt-in |
| `MMServiceWrapper.unsafeUnwrap` `0x116127fdc` | 仅返回 `m_service`；允许只读核对目标身份 |
| `MMServiceWrapper.forwardInvocation:` `0x116127e5c` | push 服务账号上下文 → invokeWithTarget → pop；直接向 raw service 发请求会绕过上下文 |

原始 12 个函数及校验记录存放在本机 `WeChatImprove-local-archive/audits/2.5-13/native-evidence/`，仓库不包含微信二进制或用户聊天日志。

## 修复

新增 `CSMessageNativeServiceIdentity`，只接受具体服务或已经由 `serviceNamed:` 登记过请求类的原生代理。读取代理的 `m_service` 前核验对象类型、偏移和实例边界，再确认目标类；返回值仅用于身份比较和同步状态读取，不用作代理服务的请求接收者。

Manager 两次查询当前账号的服务接收者，核对其实际目标与 Hook 的服务一致，并保留账号 epoch、授权、配置、前后台及重入检查。通过后把当前接收者传给同步协调器；`NotifyToSync` 通过原代理调用，保留微信的账号上下文。

配置／生命周期唤醒同样先解析受信代理。停止兼容计时器还要确认当前服务能够参与新路径，不能仅凭 Hook 安装成功。服务能力暂不可用时保留既有兼容恢复机会；恢复后停止该计时器，并立即处理已有需求。当前服务可用时仍采用事件驱动，不等待 10 秒补拉。

## 验证

新增跨模块集成测试连接生产 `CSAutomationNativeSync`、`CSAutomationManager`、`CSMessageNativeEnvironment`、ABI 调用、拍动事件解析与磁盘去重。使用真实 `NSProxy` 录制服务，其 `NotifyToSync` 必须在代理安装的账号上下文中执行，否则测试失败。发送仅为录制适配器，不访问微信服务器。

同一后台／protected-data-unavailable 群拍动用例：2.5-12 的原 core／Manager／Environment 编译成功但运行断言失败，结果为 setter=1、notify=0、文字=0、回拍=0；修复版得到 notify=1、代理调用=1、文字=1、回拍=1，磁盘有两项独立认领，重复事件没有重复发送。这个对照直接覆盖上版漏测的真实代理边界。

另覆盖代理替换、错误目标、未登记或登记到其他服务的代理、生命周期恢复、账号 epoch、配置与原生 getter 重入、前台阻止、私聊、原生异常后的上下文恢复和能力暂失后的切回。既有同步调度、拍动入站、消息动作及 AI 回归继续通过。最终测试与包核验见 [发布记录](../../../packages/2.5-13-pat-service-wrapper/README.md)。

本版没有改动保活策略、账号、数据库或用户配置，也没有增加运行时诊断采集。主机测试证明修复了这个具体阻断点，不能代替用户手机后台／锁屏的实际送达验收。
