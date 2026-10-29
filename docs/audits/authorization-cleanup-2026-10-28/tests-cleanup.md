# 授权清理的测试调整

基线为本目录 `baseline/Tests/` 保存的当前工作区 2.1-5 原生授权弹窗修复版。本次仅清理失效断言、未消费的测试观测字段，以及已合并授权读取入口的旧调用，不删除仍然可达的导航或读取场景。

## 删除清单及依据

下表中的行号均指本目录保存的 2.1-5 基线，便于与本轮修改前的文件逐条对照。

| 文件与位置 | 删除内容 | 确认无用的依据 |
| --- | --- | --- |
| `Tests/verify-authorization-prompt.sh:23` | 检查 `authorizationOverlay`、`showAuthorizationOverlay`、`hideAuthorizationOverlay`、`followOfficialAccount`、`recheckAuthorization` 缺席的循环 | 这五个旧遮罩/按钮名称在 `Controllers/`、`Headers/`、`Hooks/`、`Tests/` 中仅剩该脚本引用；被测的旧实现、入口已在基线中删除。共删除五条 Python 名称缺席断言。当前原生 UI 由实际生产方法提取执行和原生 alert 类型/样式断言验证。 |
| `Tests/AuthorizationPromptTests.m:17`、`:19`、`:25` | `subviewAdds` 字段及 `addSubview:` 测试桩 | 现有提取执行的授权代码不调用 `addSubview:`；字段仅用于下列两处旧遮罩缺席条件。 |
| `Tests/AuthorizationPromptTests.m:234` | `content.view.subviewAdds==0` 子表达式 | 只观察已经删除的自定义遮罩。保留同一 CHECK 的 `!content.authorizationPromptInFlight`，继续验证取消后的状态复位。 |
| `Tests/AuthorizationPromptTests.m:289` | `content.view.subviewAdds==0` 子表达式 | 同上。保留同一 CHECK 的 `presentedViewController==nil`，继续验证关注动作完成后原生授权 alert 已关闭。 |
| `Tests/AuthorizationPromptTests.m:29`、`:33` | `reloads` 字段与递增 | 只有写入，没有读取或断言；保留生产方法调用所需的 `reloadData` 空实现。 |
| `Tests/AuthorizationPromptTests.m:121`、`:154`、`:195` | `reads` 字段、递增、reset | 只有写入，没有读取或断言。保留 `nextReads` 序列，它仍用于真实的 NO→YES 读取竞争场景。 |
| `Tests/AuthorizationPromptTests.m:141`、`:162` | `setupCount` 字段与递增 | 只有写入，没有读取或断言；保留生产方法调用所需的 `setupData` 空实现。 |
| `Tests/AuthorizationReadTests.m:6` | `<stdarg.h>` | 没有 `va_list`、`va_start`、`va_arg` 等使用；可变参数日志桩不处理参数。 |
| `Tests/verify-authorization-read.sh:13` | 删除 `WCHeaders.h` import 的字符串替换兼容语句 | 生产授权实现已删除该无用 import，脚本不再需要替换不存在的文本。 |

将关注动作场景的注释改为“公众号跳转后设置保持锁定、原生 alert 已关闭”，去掉已删除 custom UI 的描述；断言继续验证原有行为。

## 合并读取入口后的调用迁移

`checkAuthorization` 的独立 selector 已并入 `isAuthorized` getter。原测试的三处调用改用 `manager.isAuthorized`，每条行为 CHECK 原样保留：

| 基线位置 | 保留的场景 |
| --- | --- |
| `Tests/AuthorizationReadTests.m:118` | 服务对象不提供 `getContactByName:` 时返回未授权。 |
| `Tests/AuthorizationReadTests.m:133` | fallback 订阅位为 `UINT_MAX` 时仍按既有 `>0` 语义返回授权。 |
| `Tests/AuthorizationReadTests.m:161` | primary 明确返回 NO 时不能使用 fallback 的旧 YES 状态。 |

没有单独删除这三个读取场景；删除的是已不存在的 selector 调用方式。全部查询与异常/fallback 断言仍直接执行生产 getter。

## 剩余覆盖映射

以下行号指清理后的测试文件。

| 行为要求 | 保留的验证 |
| --- | --- |
| 三入口统一原生弹窗 | `verify-authorization-prompt.sh:23` 提取“我”和设置两个 hook，验证使用共同的 manager request、不各建弹窗；`AuthorizationPromptTests.m:165` 的 `AlertFrom` 验证 `UIAlertController` 类型、alert 样式、标题及两个 action；`:215` 通过第三方宿主的实际 `viewDidAppear:` 进入共同 request。 |
| “我”/设置未开插件时取消保留原页 | `AuthorizationPromptTests.m:196` 验证取消后原入口未被 dismiss、alert 关闭；`PluginEntryTests.m:73` 执行两个真实 hook，验证未授权时请求授权且不展示插件。 |
| push 只 pop 一层 | `AuthorizationPromptTests.m:215`，保留栈深、pop 次数和禁止 dismiss 底页的检查。 |
| 模态导航根页只 dismiss 插件导航 | `AuthorizationPromptTests.m:236`。 |
| 现有宿主导航根页无自有模态时不误关底页 | `AuthorizationPromptTests.m:245`。 |
| 直接模态只 dismiss 自身宿主 | `AuthorizationPromptTests.m:259`。 |
| 异步取消时不误 pop 后来顶上的无关页面 | `AuthorizationPromptTests.m:265`。 |
| in-flight/returning 防重复、宿主有 modal 时不叠弹窗、消失后可复用 | `AuthorizationPromptTests.m:222`、`:229`、`:272`。 |
| alert 关闭完成后才路由 | `AuthorizationPromptTests.m:204`，保留延迟 dismissal completion 的观察。 |
| 关注后重新读取恢复交互及用户协议；两次读取间授权变更的 success 分支 | `AuthorizationPromptTests.m:286`、`:291`、`:298`，保留 `nextReads` 与 success 回调覆盖。 |
| 每次实时查询、无授权缓存 | `AuthorizationReadTests.m` 保留 fallback 0→1→UINT_MAX→0、primary NO→YES→NO、异常/fallback、原生服务失效再恢复，以及 defaults/log 零访问检查。 |
| 取关后 AI 与定时发送停止 | `ScheduledTaskManagerTests.m:90`、`:99` 保留执行前及准备阶段授权撤销；`AIReplyManagerTests.m:334`、`:460`、`:470` 保留执行门槛、后台同步和 native 边界后授权撤销。相关测试及生产管理器本轮不改。 |
| 未授权不能长按发现密友入口 | `CloseFriendEntryGestureTests.m:118` 的授权拒绝检查保留。 |

`AuthorizationPromptTests.m:253` 的“无 MMUIViewController 宿主时直接使用 CSCustomViewController”场景保留。`CSNativeSettingsControllerClass()` 在原生类不可用、动态类分配或方法注册失败时仍会返回该控制器，这是现有可达入口。

## 断言数量与执行责任

删除五条 Python 旧名称缺席断言；缩减两条运行 CHECK 中的旧遮罩子条件，未删除运行 CHECK；三个读取 CHECK 仅迁移调用入口。主线程实际回归确认原生弹窗/导航为 92 checks，实时读取为 67 checks。三入口与取消导航、每次实时读取、取关后的运行期拦截覆盖保留；不再覆盖已删除旧 UI 的名称及其视图增加计数。

测试清理子任务没有另跑回归或编译；主线程已按用户指定顺序执行完整回归，六脚本共 813 条运行断言全部通过。实际日志及双方案编译结果见本目录主报告。
