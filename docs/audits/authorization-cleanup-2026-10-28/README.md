# 授权功能无用代码清理 · 2026-10-28

本次基线是既定 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的**当前工作区 2.1-5 原生授权弹窗修复版**，不是 Git HEAD，也不是修复前的旧快照。按上一轮清理口径，只删除可证明无用的代码；未合并三入口实现，未改变文案、原生弹窗样式或导航时序。

本轮生产、测试及版本文件共改 10 个，新增 15 行、删除 36 行，净减少 21 行；授权管理实现由 177 行减至 171 行。没有删除整个生产或测试文件。完整相对本轮工作区基线的差异见 [cleanup.diff](cleanup.diff)，[基线副本](baseline/)、[清理前哈希](source-sha256-before.json)、[差异统计](diff-stats.json)用于区分此前已存在的未提交修改。

## 删除清单与逐项依据

下表均用**清理前基线行号**，可在 `baseline/` 直接核对。项目引用搜索覆盖 `Controllers/`、`Headers/`、`Hooks/`、`Tests/`，不把 `HeadersFile/` 微信原生声明当成项目调用。完整命令、生产/测试引用和各保留路径见 [source-review.md](source-review.md)；清理后实际搜索输出见 [reference-search-after.json](reference-search-after.json)。

| 基线文件:方法/行 | 删除/清理内容 | 为什么确定无用 |
| --- | --- | --- |
| `Controllers/CSAuthorizationManager.h:15`、`.m:isAuthorized:27 / checkAuthorization:32` | 删除 `checkAuthorization` 声明与纯转发层，原查询体直接放入 `isAuthorized` getter | 生产唯一调用是 getter 的 `return [self checkAuthorization]`；其余 3 处仅为读取测试。未发现额外调用、Hook、selector 字符串或反射引用。查询体除注释外一致，仍每次取原生服务并查关注状态，没有引入缓存。 |
| `Controllers/CSAuthorizationManager.m:3` | `<objc/runtime.h>` import | 没有使用 runtime API；动态消息调用所需的 `<objc/message.h>` 继续保留。 |
| `Controllers/CSAuthorizationManager.m:5` | `WCHeaders.h` 聚合 import | 微信类与 selector 均通过字符串取得，不需要聚合头中的原生类声明。Foundation/UIKit 来自自身头，服务函数来自 `CSServiceCenter.h`。主机测试及双架构 iOS 构建均通过。 |
| `Controllers/CSAuthorizationManager.m:7` | “替换为你的公众号原始ID”模板注释 | 当前已有固定公众号 ID；仅清除失效说明，常量及使用点不变。 |
| `Controllers/CSCustomViewController.m:42` | `<objc/runtime.h>` import | 全文件没有 runtime API 使用；宿主解析所需函数由保留的 `CSNativeSettingsHost.h` 声明。 |
| `Hooks/CustomEntryHooks.xm:8` | `CSCustomViewController.h` import | 类名在本文件仅此一处；现行创建/注册均通过 `CSNativeSettingsControllerClass()`，声明来自保留的宿主头。被删头没有注册或宏副作用。 |
| `Hooks/CustomEntryHooks.xm:18` | `static kEntrySettingsChangedNotification` | 本翻译单元只有定义，没有读取；实际通知监听使用同值 `CFSTR`。设置控制器内同名常量是另一个翻译单元自己的 `static`，其通知发送保留。 |
| `Tests/verify-authorization-prompt.sh:23` | 五个旧 UI 名称的缺席检查循环 | 五个名称只剩该脚本引用，旧实现及入口在基线中已删除。删除的是搜索旧名称的 5 条 Python 断言，现行原生弹窗实际执行测试保留。 |
| `Tests/AuthorizationPromptTests.m:17 / 19 / 25` | `subviewAdds` 字段及 `addSubview:` 测试桩 | 只为已删遮罩计数；当前被提取的授权方法不调用它。 |
| 同文件 `:234 / 289` | 两个 `subviewAdds == 0` 子条件 | 不再观察不存在的旧遮罩；保留同一 CHECK 中的 in-flight 复位和原生 alert 关闭验证。 |
| 同文件 `:29 / 33` | `reloads` 计数器及递增 | 只写不读；保留生产方法仍调用的 `reloadData` 空实现。 |
| 同文件 `:121 / 154 / 195` | `reads` 计数器、递增及 reset | 从未断言或读取该次数；保留 `nextReads`，继续模拟两次实时读取之间的状态变化。 |
| 同文件 `:141 / 162` | `setupCount` 计数器及递增 | 只写不读；保留 `setupData` 空实现。 |
| `Tests/AuthorizationReadTests.m:6` | `<stdarg.h>` | 没有使用 `va_*`；可变参数日志桩不处理参数。 |
| `Tests/verify-authorization-read.sh:13` | 为 `WCHeaders.h` import 做字符串替换的兼容语句 | 生产文件已不导入该头，替换目标不再存在。 |

配套调整：原“方式1 / 方式2”注释改为实际回退触发条件；测试中关注动作注释移除旧 custom UI 的描述。三个原 `checkAuthorization` 测试调用改用 `isAuthorized`，不删真实行为断言。`control` 与 `Headers/CSUserInfoHelper.h` 同步为 `2.1-6`，没有改版本展示以外的产品文案。

## 微信 8.0.78 静态核对与存疑未删

使用 `reverse-engineer-anything` 技能核对既有 8.0.78 工件 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。本轮重新计算摘要并检查实际 Mach-O 元数据/IMP，不以头文件声明代替实现。证据、命令、目标版本来源和限制见 [native/README.md](native/README.md) 与 [native/manifest.json](native/manifest.json)。全程没有执行微信，REA 分析会话已经关闭。

| 核对项 | 静态结论 | 本轮决定与限制 |
| --- | --- | --- |
| `CContact +isBrandFollowedWithUsername:` | 真实存在，IMP `0x100bb11cc`，类型 `B24@0:8@16`。实现实时读取 currentContext 的 `CContactMgr`、`getContactByName:`，检查 `isBrandContact`、`!isWeAppContact` 后返回 `isMMContact`。 | 确认该工件含此可调用类方法；没有从“存在”推断在所有运行状态下均不抛异常。保留原生优先查询。 |
| `getContactByName:` + `m_uiBrandSubscriptionSettings` | 原生方法存在；属性回退与主查询采用不同的状态判据。 | **存疑未删**。只在本地已取得服务，且 `CContact` 类缺失、主 selector 缺失或主查询抛异常时进入。主查询明确返回 NO 会直接拒绝，绝不回退成属性 YES。正常 8.0.78 路径优先命中主 API，但静态证据不能证明全部异常路径永远不可达，也没有证据将两套判据等同。源码已写明条件；未声称某个机型必然需要它。 |
| `TingRouter +openBrandProfileWithUsername:` | 真实存在，IMP `0x105e3071c`，类型 `v24@0:8@16`。取得 brand contact，创建联系人详情页、设置 scene 60，推入当前主窗口导航；返回 void，无失败结果/回调。 | **存疑未删** URL 兜底。当前只有 TingRouter 类/selector 缺失或调用抛异常才进入 URL；正常返回不触发下一级。不能把 void 返回视为“页面必定打开”，也没有添加新回调或调整导航。 |
| `weixin://profile/` | `MMWebViewController` 的 `shouldHandleJumpProfileUrl:` / `handleJumpProfileUrl:` 实际处理该前缀并提取路径 username；另有 `weixin://profile/%@` 生成引用。 | **存疑未删**。确认内部 WebView 有处理能力，但不能等同于 `UIApplication` 外部重入时必定进入同一处理器。权限与导航状态仍影响页面结果，不能证明该分支失效。 |
| `weixin://findfriend/verifycontact` | `UrlController -handleUrl:withExtraInfo:` 实际使用 `weixin://findfriend/verifycontact/([^/]*)` 提取路径 username 并调用 `verifyContactByUsrName:`。 | **存疑未删**。已核对的分支没有读取 queryItems；插件现有 `?username=` 与该正则不一致。这是明确疑点，但没有证明不存在其他处理器，不能宣称全部外部路由必然不支持；本轮不改参数。 |

本地回退链的可达条件逐级为：

1. `openOfficialAccountFromViewController:` 由原生 alert 关闭完成回调调用。
2. TingRouter 类不存在、selector 不存在或调用异常 → `openBrandProfileDirectly`；TingRouter 静默未打开页面不会自动回退。
3. profile URL 的 `UIApplication openURL` completion 返回 NO → `tryAlternativeURLScheme`；返回 YES 不进入下一层。
4. 备用 URL completion 返回 NO 仅保留原失败日志，没有后续分支。

`UIApplication openURL` 的接受结果不能代替微信内部页面到达结果。由于证据不能证明上述某一级不可达或必然无效，本轮没有冒险删 URL 层、替换 URL 参数或修复回退语义；这些属于另行行为修复范围。

其他保留项：

- `openOfficialAccountFromViewController:` 的 `viewController` 参数在方法体未读取，但 selector 是现用接口及测试观察点。删除参数需要重命名 API 和调用，超出本轮清理范围。
- 页面 `isAuthorized`、`authorizationPromptInFlight`、`returningFromAuthorization` 均有读取与现行用途。页面状态不构成 manager 的授权缓存。
- 请求内二次读取可能将初次 NO 变为 YES，`success` 回调分支可达；点击关注与点击取消也同为 NO 回调，仍须区分取消后返回。
- tag `871042` cover 是密友隐私遮罩；头像加载指示器及用户协议状态也有真实用途，均非旧授权 UI 残留。
- 其他被扫描的 import、UI 常量、静态函数、私有方法均有调用；没有发现可再删的旧授权渐变卡片、遮罩、重检按钮声明、iVar 或 completion 分支。详见源码审计。

## 保持原样的行为与测试删除口径

[scope-verification.json](scope-verification.json) 确认：查询体除注释和入口归属外一致；manager 的 request 及整个路由尾部逐字节一致；`CSCustomViewController`、`CustomEntryHooks` 除上述 import/未读常量外的正文一致；`CSAIReplyManager.m`、`CSScheduledTaskManager.m` 与本轮基线逐字节一致。

因此三入口各自调用、原生 alert 的 dismiss completion 时序、push 只 pop 一页、插件模态导航根页只 dismiss 导航、直接模态只 dismiss 宿主、“我”/设置未开插件时取消保留原页，均保持现状。非栈顶时不误 pop、底层微信导航不误 dismiss 的保护同样保留。未授权不能通过长按发现密友入口；取关后 AI 和定时发送继续按原运行期校验停用。

测试删除和剩余覆盖的逐场景映射见 [tests-cleanup.md](tests-cleanup.md) 与 [tests-cleanup.diff](tests-cleanup.diff)：

- 删除 5 条“旧名称不存在”的 Python 检查；从两条 CHECK 中删去旧遮罩计数子条件；没有删除任何运行期 CHECK 或当前仍可达的入口用例。
- 三个 `checkAuthorization` 调用分别覆盖不支持 lookup、`UINT_MAX` 订阅值、主 API 的 NO 不回退；改为 getter 后全部保留。
- 直接使用 `CSCustomViewController` 的 fallback 入口仍会在原生宿主注册失败等情况下出现，因此该回归用例保留。
- 对当前有效行为的覆盖保持等价；已删除 UI 的名称/视图增加计数不再验证，不以运行断言数量不变冒充旧 UI 仍有覆盖。

## 回归结果

按下表顺序串行执行，六个脚本全部通过，共 **813 条运行断言**，主机编译采用各脚本的原有严格警告选项。完整命令、退出码及耗时见 [test-results.json](test-results.json)。测试使用替身、内存或临时隔离存储，没有读写用户微信账号数据或向真实会话发消息。

| 顺序 | 验证脚本 | 结果 | 日志 |
| --- | --- | --- | --- |
| 1 | `verify-authorization-prompt.sh` | 92 checks | [日志](logs/verify-authorization-prompt.log) |
| 2 | `verify-authorization-read.sh` | 67 checks；defaults/log 零访问 | [日志](logs/verify-authorization-read.log) |
| 3 | `verify-plugin-framework.sh` | 21 entry + 25 startup checks | [日志](logs/verify-plugin-framework.log) |
| 4 | `verify-close-friend-entry.sh` | 45 state + 26 gesture checks | [日志](logs/verify-close-friend-entry.log) |
| 5 | `verify-scheduled-task-manager.sh` | 204 checks | [日志](logs/verify-scheduled-task-manager.log) |
| 6 | `verify-ai-manager.sh` | 333 checks | [日志](logs/verify-ai-manager.log) |

## 完整编译、版本与包核验

此次删除一个方法 selector 并调整正式编译输入，属于源码有实质变化，因此交付 **2.1-6 双包与 symbols**。版本仅在 `control` 与 `kPluginVersionString` 同步，不修改发布说明或产品文案。

两方案分别使用全新的 `_THEOS_LOCAL_DATA_DIR` 和 `THEOS_BUILD_DIR`，输出到独立的 `packages/2.1-6-auth-cleanup/`。没有运行 `make clean`、install 或修改注入环境。完整命令见 [rootless](build-rootless-result.json)、[rootful](build-rootful-result.json)，目录见 [build-state.json](build-state.json)。

| 方案 | 构建/打包 | 警告 | 包架构标记 | dylib 架构/最低系统 | 日志 |
| --- | --- | --- | --- | --- | --- |
| rootless | 通过，exit 0 | 6，与原生弹窗修复基线逐条相同 | `iphoneos-arm64` | `arm64` + `arm64e` / iOS 15.0 | [日志](logs/build-rootless.log) |
| rootful | 通过，exit 0 | 6，与原生弹窗修复基线逐条相同 | `iphoneos-arm` | `arm64` + `arm64e` / iOS 15.0 | [日志](logs/build-rootful.log) |

每方案 6 条历史警告为 `UILocalNotification` 两条、`statusBarFrame` 两条、链接器 `-multiply_defined` 两条；本次改动文件零新增。详见 [warnings.json](warnings.json)。

[package-verification.json](package-verification.json) 与 [可复核脚本](verify-packages.py) 记录以下校验：包版本和架构元数据、rootless `/var/jb/Library/...` / rootful `/Library/...` 安装路径、双 Mach-O 架构及最低系统、注入 filter 与工作区语义一致、四组 dSYM UUID 与各自包内 slice 匹配、symbols ZIP 的 12 个文件 CRC、三份产物 SHA-256 校验全部通过。包内已无 `checkAuthorization` selector，实时 getter、共同原生弹窗、取消返回、路由方法、密友门控及两个运行期 manager 保留。

交付目录：[packages/2.1-6-auth-cleanup](../../../packages/2.1-6-auth-cleanup/)。

- [Rootless DEB](../../../packages/2.1-6-auth-cleanup/com.wechat.improve_2.1-6_iphoneos-arm64.deb)
- [Rootful DEB](../../../packages/2.1-6-auth-cleanup/com.wechat.improve_2.1-6_iphoneos-arm.deb)
- [双方案 symbols](../../../packages/2.1-6-auth-cleanup/com.wechat.improve_2.1-6_symbols.zip)
- [SHA256SUMS](../../../packages/2.1-6-auth-cleanup/SHA256SUMS)；[实际校验日志](logs/checksums.log)

## 环境与验证边界

[environment-preservation.json](environment-preservation.json) 确认本轮开始时已有的 `.theos/` 与 `packages/` **1251 个文件路径均保留且 SHA-256 不变**；仅向新目录添加 2.1-6 产物。构建前后的 365 个生产输入哈希一致，包含用户此前的工作区修改；本轮未回退这些既有改动。新旧源码清单逐项比对，范围外文件没有新增、删除或修改。

项目是原生 iOS 注入插件，不涉及本地前后端 URL、端口、代理或数据库服务切换；未启动、重启或安装微信，也未切换 checkout、账号或数据源。交付已在既定工作区落地并完成主机回归及双方案完整构建。静态 URL 支持与测试替身不能证明真机实际页面到达，当前结果不宣称已完成设备安装或真机验收。
