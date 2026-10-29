# 授权清理源码引用审计

本记录以本目录 `baseline/` 保存的当前工作区 2.1-5 原生授权弹窗修复版为基线。下文位置均为**清理前行号**，避免删除 import、方法后行号漂移。审计只读生产代码与测试；生产修改由主任务完成。`HeadersFile/` 的微信原生头文件不计入项目调用证据；8.0.78 原生二进制核对另见本轮原生审计材料。

## 查询口径与实际命令

在既定 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 执行以下搜索，生产与测试分开。没有用类名/selector 在原生头中的声明冒充项目实际调用，也没有把本审计目录的快照、历史报告算作当前调用。

```sh
rg -n 'CSAuthorizationManager|checkAuthorization|requestAuthorizationWithPresentingViewController|openOfficialAccountFromViewController|authorizationOverlay|showAuthorizationOverlay|hideAuthorizationOverlay|followOfficialAccount|recheckAuthorization|authorizationPromptInFlight|returningFromAuthorization|returnFromUnauthorizedSettings|canDiscoverCloseFriendEntry' Controllers Headers Hooks Tests

rg -n 'CSAuthorizationManager|checkAuthorization|requestAuthorizationWithPresentingViewController|openOfficialAccountFromViewController|authorizationOverlay|showAuthorizationOverlay|hideAuthorizationOverlay|followOfficialAccount|recheckAuthorization' Controllers Headers Hooks

rg -n 'CSAuthorizationManager|checkAuthorization|requestAuthorizationWithPresentingViewController|openOfficialAccountFromViewController|authorizationOverlay|showAuthorizationOverlay|hideAuthorizationOverlay|followOfficialAccount|recheckAuthorization' Tests

rg -n 'objc_|class_get|object_get|method_get|sel_register|NSClass|NSSelector|IMP|Ivar|runtime|kEntrySettingsChangedNotification|kPluginVersionString' Controllers/CSCustomViewController.m Hooks/CustomEntryHooks.xm

rg -n 'kEntrySettingsChangedNotification|CSCustomViewController|CSReleaseNotesViewController|CSUpdateControlViewController|kUserAgreementAcceptedKey|checkUserAgreement|openCustomViewControllerFromSetting|returnFromUnauthorizedSettings' Controllers Headers Hooks Tests

rg -n '^[-+] \(|^static|CS.*Reward|objc|CGGradient|CAGradient|授权|重新|重试|检查' Controllers/CSCustomViewController.m Hooks/CustomEntryHooks.xm
```

初次审计时源码尚未修改，故首轮结果就是下文的基线位置。修改后再次执行生产/测试分开搜索，确认项目生产代码和测试都不再调用 `checkAuthorization`；另用 `rg` 搜索 `baseline/Controllers`、`baseline/Hooks`、`baseline/Tests` 复核清理前 selector 的精确位置。

## 生产引用清单

| 文件（清理前） | 引用与用途 |
| --- | --- |
| `Controllers/CSAuthorizationManager.h:15` | 声明 `checkAuthorization`；没有额外契约或不同的参数。 |
| `Controllers/CSAuthorizationManager.m:27` | `isAuthorized` getter 的完整逻辑只有 `return [self checkAuthorization];`。 |
| `Controllers/CSAuthorizationManager.m:32` | `checkAuthorization` 的唯一实现；生产中唯一调用方就是上面的 getter。全仓搜索未发现其他静态调用、selector 字符串、Hook 或反射调用。 |
| `Controllers/CSAuthorizationManager.m:79` | 统一原生授权弹窗方法。81 行重新读取 `isAuthorized`，98 行在弹窗 dismiss completion 后打开公众号。 |
| `Controllers/CSAuthorizationManager.m:122` | `openOfficialAccountFromViewController:` 实现；生产唯一调用为 98 行。 |
| `Controllers/CSCustomViewController.m:41/171/172/179` | 导入 manager、获取单例、实时读取授权、通过宿主展示统一弹窗。第三方插件管理注册入口最终依赖此页面生命周期校验。 |
| `Hooks/CustomEntryHooks.xm:11/198/200/204` | “我”入口获取实时状态，未授权时使用 manager 统一弹窗；已授权或 success 回调后打开插件。 |
| `Hooks/CustomEntryHooks.xm:447/449/456` | 微信设置入口的同类校验；根据现有导航控制器选择呈现宿主。 |
| `Controllers/CSAIReplyManager.m:11/117/253/258` | 导入与三处运行期读取，分别参与触发资格、发送前校验、提交期间授权检查。本次保持原样。 |
| `Controllers/CSScheduledTaskManager.m:5/78/84` | 导入与两处运行期读取，包括延迟提交期间的 `submissionStillAuthorized`。本次保持原样。 |

`officialAccountUserName` 在 manager 初始化及实际查询/路由 URL 构造中使用，不能删除。`objc/message.h` 为三类动态调用提供 `objc_msgSend` 声明，也必须保留。

## 测试引用清单

| 文件（清理前） | 引用与含义 |
| --- | --- |
| `Tests/AuthorizationReadTests.m:3/106/108` | 使用真实 manager 头、构造对象并校验单例；测试提取真实查询实现。 |
| `Tests/AuthorizationReadTests.m:118/133/161` | 仅有的三个测试侧 `checkAuthorization` 调用，分别验证服务不支持查询拒绝、`UINT_MAX` 订阅值、原生 API 返回 NO 不走属性回退。它们不是生产调用。并入 getter 后改由 `isAuthorized` 进入，三种场景继续保留。 |
| `Tests/verify-authorization-read.sh:10/11` | 从真实源码提取 request 方法之前的查询部分，包含 getter；不模拟或复制查询算法。 |
| `Tests/AuthorizationPromptTests.m:118/126/127/151/152/156` | manager 替身声明、真实 request 方法的插入位置与路由观察函数。`openOfficialAccountFromViewController:` 的测试替身记录传入宿主，以确认现行路由调用关系。 |
| `Tests/AuthorizationPromptTests.m:204/212/306` | 分别直接验证取消、点击关注后的 dismiss 完成时序、已关注快速完成路径。 |
| `Tests/AuthorizationPromptTests.m:297` | 明确构造 `NO → YES` 连续读取，证明页面/入口回调中的 success 分支可达。 |
| `Tests/verify-authorization-prompt.sh:23` | 五个旧 UI 名称的缺席断言；不执行现行入口，仅搜索早已删掉的方法名。 |
| `Tests/verify-authorization-prompt.sh:26` | 提取两 Hook 点击方法，确认二者调用统一 request 方法且不另建 `UIAlertController`。 |
| `Tests/PluginEntryTests.m:34/41/44/68/73/75/77/85` | manager 替身及入口行为测试；验证拒绝授权时不打开插件，备份失败不能绕过授权。 |
| `Tests/CloseFriendEntryGestureTests.m:118/119` | 验证未授权及原生授权弹窗进行中不能开始发现密友入口。 |
| `Tests/ScheduledTaskManagerTests.m:7/62`、`Tests/AIReplyManagerTests.m:10/173` | manager 替身用于现行运行期行为回归；没有调用已清理的转发方法。 |

## 删除依据

| 基线文件:位置 | 删除/清理内容 | 为什么确定无用及保留边界 |
| --- | --- | --- |
| `Controllers/CSAuthorizationManager.h:15`、`.m:27/32` | 删除多余 `checkAuthorization` selector 声明与 getter 的纯转发层，将原有查询方法体放入 `isAuthorized`。 | 生产只有 getter 自调用；测试三个直接入口可以无损改为 getter。原查询体的服务获取、原生查询、缺失/异常回退、返回 NO 条件均继续执行，不引入缓存，也不减少每次读取的服务/关注状态查询。此次合并是用户明确允许的清理。 |
| `Controllers/CSAuthorizationManager.m:3` | `#import <objc/runtime.h>`。 | 文件只用 Foundation 的 `NSClassFromString`/`NSSelectorFromString` 与 `objc_msgSend`；没有 runtime API。保留 `objc/message.h`，不依赖该未用导入。 |
| `Controllers/CSAuthorizationManager.m:5` | `#import "../Headers/WCHeaders.h"`。 | `CContactMgr`、`CContact`、`TingRouter` 均通过字符串取得 `Class`，没有直接使用这些类的声明或该聚合头定义的其他类型/常量。UIKit/Foundation 已由自身头导入；服务函数由 `CSServiceCenter.h` 提供。该头无本文件需要的声明。 |
| `Controllers/CSAuthorizationManager.m:7` | `// 替换为你的公众号原始ID` 历史模板注释。 | 此处已经使用既定公众号 ID `gh_cac882c8f729`，没有待替换配置逻辑；只删失效模板说明，保留常量值、初始化与所有使用点。 |
| `Controllers/CSCustomViewController.m:42` | `#import <objc/runtime.h>`。 | 全文件没有任何 runtime API。`CSNativeSettingsHostForContent` 为项目函数，其声明来自 `CSNativeSettingsHost.h`，不需要调用处导入 runtime。 |
| `Hooks/CustomEntryHooks.xm:8` | `#import "../Controllers/CSCustomViewController.h"`。 | 类名在本文件唯一出现就是 import；227/264/479 行创建/注册均通过 `CSNativeSettingsControllerClass()`。该头仅 UIKit 和类声明，无执行或宏副作用；实际所需函数声明来自保留的 `CSNativeSettingsHost.h`。 |
| `Hooks/CustomEntryHooks.xm:18` | 未使用 `static kEntrySettingsChangedNotification`。 | 在本翻译单元只定义、不读取；513 行监听使用 `CFSTR` 字面量。`CSEntrySettingsViewController.m:7/133` 同名变量是另一翻译单元自己的 static 定义/使用，不会被此删除影响。通知名称与监听保持原样。 |

没有因为“只被自己调用”就删除可达的私有方法。ObjC action selector、生命周期、delegate、通知 selector 也算引用；上述检查同时查看这些路径。

## 必须保留的现行路径

| 基线位置 | 保留内容与路径证明 |
| --- | --- |
| `CSCustomViewController.m:74/172/173/174/183/568` | 本页 `isAuthorized` 保存当前 UI 的可交互状态；每次有效 `viewDidAppear` 从 manager 实时赋值，回调后更新，密友手势也读取。它不是 manager 的授权缓存，不能当成历史 iVar 删除。 |
| `CSCustomViewController.m:75/158/177/182/568` | `authorizationPromptInFlight` 防止原生弹窗带来的 appearance 回调重入，同时阻止弹窗进行中长按发现密友入口。 |
| `CSCustomViewController.m:76/158/198/208/211/215` | `returningFromAuthorization` 在取消返回前置 YES，防返回转场重弹；离开后复位，支持第三方缓存页面再次打开。 |
| `CSCustomViewController.m:179/185/187` | success 与取消 completion 分支都可达。两次实时读之间关注状态可能变为 YES；点击关注和取消也都会给 NO，但只有取消消息要求返回。不能将它们合并或视为恒 NO。 |
| `CSCustomViewController.m:201` | 保留取消返回辅助方法：206 行非栈顶不操作，207 行 push 仅 pop 一层，210 行插件导航根页模态仅 dismiss 导航，214 行直接模态仅 dismiss 宿主。无插件自有模态的宿主根页保持原样。 |
| `CSAuthorizationManager.m:96/108` | 点击关注或取消都在原生 alert 的 dismiss completion 内继续；这保证不在弹窗转场过程中打开另一原生页或 pop/dismiss 插件。属于本次硬约束。 |
| `CSCustomViewController.m:141/148/161/166` | tag `871042` 的 cover 由 `CSCloseFriendPluginEntryHidden()` 控制，是密友隐私遮罩，不能误作旧授权遮罩删除。 |
| `CSCustomViewController.m:566/573/580` | 密友发现分别在触摸开始和识别触发时检查授权、window、前台、栈顶、模态覆盖，防长按中途状态变化。保留 `self.isAuthorized` 和 `!self.authorizationPromptInFlight` 门槛。 |
| `CustomEntryHooks.xm:196/445` | “我”与微信设置保留各自原生弹窗调用；未打开插件时取消只关闭 alert。二者 success 进入插件后，页面生命周期再检查可覆盖第三方入口及返回后的状态变化。减少重复查询会改变时序/实时语义。 |
| `CustomEntryHooks.xm:219/471` | 密友隐藏策略会重新认证；递归回调先复核策略再进入。与公众号关注授权是两个独立条件，不能当成旧授权残留。 |
| `CSAIReplyManager.m:117/253/258`、`CSScheduledTaskManager.m:78/84` | 原有运行期授权检查完整保留；取关后 AI/定时发送停止，继续使用实时 getter。 |

## 存疑未删与非删除结论

- `CSAuthorizationManager.m:122` 的 `viewController` 参数在方法体中未读取。但生产调用 98 行、公开 selector 声明 `.h:18` 与测试路由替身均以 `openOfficialAccountFromViewController:` 为接口。去掉参数须重命名 selector、改调用和测试，属于 API/结构调整；本轮保留，避免把未使用参数扩展成重构。动态 ObjC 接口也不能仅凭项目内静态调用排除外部使用。
- `CSAuthorizationManager.m:43/54` 的主查询与属性查询有明确条件：只有 `CContact` 类缺失、主查询 selector 缺失或主查询抛异常，才进入属性回退；主查询成功返回 NO 会立刻返回，绝不会回退到可能陈旧的属性 YES。8.0.78 原生方法存在并不能单独证明异常永不发生，故不能仅靠头文件或方法存在删除回退。原生证据与最终保留结论见本轮二进制审计。
- `CSAuthorizationManager.m:122/146/163` 路由链分别由类缺失、selector 缺失、原生调用异常与 `UIApplication openURL` 的 completion 控制。TingRouter 调用是 void，无页面打开结果可用于回退；URL completion 成功也只代表系统接受打开，不等于微信内部页面成功。静态存在性不能替代真机路由结果，详见本轮原生审计的保留项。
- `CSCustomViewController.m` 的全部 UI 常量有实际读取；`kAvatarCacheKey` 和 `kUserAgreementAcceptedKey` 都读写使用。`loadingIndicator` 实际用于头像加载，不属于旧授权遮罩。
- `CSNativeRewardPresenter.h` 提供 `CSOpenNativeAuthorReward`，在 `CSCustomViewController.m:1099` 被调用；`CSEntrySettingsViewController.h` 提供 Hook 所用 `CSEntryDisplayMode` 枚举。不能只因为文件未出现对应类名就删除这些导入。
- Hook 中其余静态函数 `getCustomEntryIcon`、`getEntryDisplayMode`、`getCustomEntryTitle`、`loadEntrySettings`、`CSRemoveHiddenPluginEntryFromHost`、`entrySettingsChangedCallback` 与状态 `gCustomEntryTitle`、`isRegister` 均有现行调用/读取。
- 五个旧自定义授权名称在生产中均已不存在；基线只在 `verify-authorization-prompt.sh:23` 缺席检查中出现。未发现可继续删除的旧渐变卡片、授权遮罩、重检按钮方法、声明、常量或 iVar。测试删除的精确清单与覆盖对照由测试审计记录。

本记录只证明源码引用、当前路径与清理边界；回归是否通过、构建警告数量和安装包核验以本轮主报告及实际日志为准，不将源码推论写成真机运行结果。
