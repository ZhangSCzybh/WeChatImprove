# 2.0-6 密友生物识别解锁

本轮针对 2.0-5 真机“开关保存但没有系统验证”的反馈。已复现首页长按绕过验证的问题，修复认证入口与验证期间的生命周期冲突，完成核心回归和两种 deb 打包。没有连接真机，系统 Face ID / Touch ID 实际弹窗尚待设备验收。

## 根因与证据

1. **系统调用已存在，首页长按未接入。** 修改前 `CSCloseFriendManager.m:219` 的 `authenticateFrom:completion:` 已新建 LAContext，调用 canEvaluatePolicy / evaluatePolicy，回主线程后检查 token、epoch 和 cooldown；Makefile 已链接 LocalAuthentication。修改前 `:273` 的 `recovery:` 却直接调用 `revealWithShortcutToken:`，完全不读取 biometric。长按直接授权后，设置入口又因 `isAuthorized` 提前成功，因而用户看不到系统验证。修改前代码保存在 `before/Controllers/CSCloseFriendManager.m`；针对真实旧 `recovery:` 的隔离测试在 `before-recovery.log` 中明确失败：`biometric-enabled long press must authenticate and cannot reveal on failure`。
2. **失焦处理会取消自己的系统验证。** 修改前 `resign:` 不区分短暂 inactive 与真正后台，立即 `lockAndReturnToSafePage`，invalidate LAContext 并递增 runtime token generation。若系统验证 UI 触发失焦，就会使正在进行的挑战无效。此处是代码确定存在的生命周期冲突；不能仅凭源码认定用户那次操作一定发生过对应通知。本轮模拟两种回调顺序验证修复，不宣称获得了真机通知日志。
3. **配置不是两套存储。** 设置页的 biometric 和管理器都读当前账号 profile.options；accountKeys 是页面分组。核心测试重新加载真实加密账号存储后开关仍为开启，没有发现本轮存储迁移导致的界面/运行时不一致。未修改 Runtime、Store、Crypto 或密码搜索路径。
4. **没有旧 context 复用的证据。** 原实现每次已创建新 LAContext。本轮显式将 `touchIDAuthenticationAllowableReuseDuration` 设置为 0，保持新挑战必须调用系统验证。
5. **线程和入口时机。** Bridge 已把认证派发到主线程，设置页在 viewDidAppear 认证，首页手势在可见页面及前台处理；constructor 只注册/启动管理器。为直接调用 Manager 的场景增加主线程转派与前台检查。收藏认证实现保持不变。
6. **原实现不检测录入状态变化。** 本轮记录 evaluatedPolicyDomainState，按设备和微信账号单独存入本机钥匙串 `biometric-domain` 项，不修改现有 auth 凭据 schema。首次成功系统验证建立基线；此后状态变化要求独立密友密码，正确密码后才更新基线。升级前没有基线，不能追溯升级前发生的录入变化。安全记录不可读、不可写或 domainState 缺失时均转密码，不放行。

## 局部修复

- biometric 开启时，首页长按进入现有 `authenticateFrom:completion:`；关闭时维持原快捷显示行为。搜索框输入完整密友密码仍属于独立的密码验证方式。
- 系统挑战进行中的 inactive 仅覆盖隐私界面，保留未授权的挑战。结果若在 inactive 返回，等待回前台后重新校验账号、token 和页面再处理。
- 注册真正 DidEnterBackground；后台、锁屏保护数据不可用、账号变化和手动锁定仍立即取消挑战并废弃 token。已排队的成功结果也会清除；旧挑战回调无法结束新挑战，completion 仅结束一次。
- canEvaluatePolicy 不可用、用户取消、验证失败和“使用密友密码”均显示具体原因，进入原有密友密码验证。明确区分未录入、设备不支持/未授权、无锁屏密码、系统锁定、取消、录入状态变化等；冷却期仍受 Runtime 限制。
- `control`、版本常量、发布说明、README 和设置页说明同步到 2.0-6。精确管理器改动见 `manager.diff`。

## 回归与构建

只执行两个直接相关脚本，没有运行全量或备份回归；没有修改密码/加密核心，未额外跑 core。

| 脚本 | 检查数 | 结果 |
| --- | ---: | --- |
| `Tests/verify-close-friend-runtime.sh` | Runtime 94 + Scheduling 9 + Biometric 99 = 202 | 通过，见 `runtime.log` |
| `Tests/verify-close-friend-recovery.sh` | 24 | 通过，见 `recovery.log` |
| 合计 | 226 | 通过 |

额外执行 recovery 的原因：本次直接改变首页长按这一入口，需要验证开启生物识别时接入认证、关闭时原行为保留，并覆盖禁用长按、过期手势、页面切换、账号变化等原有边界。

新增 `Tests/CloseFriendBiometricTests.m` 由 runtime 脚本执行，提取生产认证/生命周期方法，使用真实 Runtime、Policy、Store、Crypto；UIKit、系统 LocalAuthentication、钥匙串及宿主账号服务由替身提供。不会在 Mac 上调用真实生物识别或写用户钥匙串。测试数据使用独立临时目录并清理。

针对性用例包括：开启 + 可用必须 evaluate；不可用必须转密码且不放行；主线程调用和新 context；重复入口；结果先返回/前台先恢复；真实通知注册；后台、锁屏、账号 epoch 变化、手动锁定；排队成功结果作废；旧挑战不影响新挑战；失败、取消和密码 fallback；录入状态变化；安全记录读取失败；domainState 缺失；冷却期不能绕过；关闭 biometric 走密码。

构建复用上一轮独立 Theos 缓存，命令和目录记录在 `build-environment.json`，未执行 make clean，历史 deb 与符号归档保留。两个 scheme 的构建日志见 `build-rootless.log`、`build-rootful.log`。编译成功，仅有已有的 UILocalNotification、statusBarFrame 和链接器参数弃用警告。

`verify-packages.py` 核对 deb 版本/Architecture、dylib 的 arm64/arm64e、LocalAuthentication 链接、新认证方法和属性、测试替身未入包、dSYM UUID，以及现有存储迁移初始化顺序；校验完成后复制新包和符号归档。大小、SHA-256 和 UUID 见 `packages.json`。

## 交付与真机验收

- `packages/com.wechat.improve_2.0-6_iphoneos-arm.deb`：Rootful，延用原 IPA 注入流程提取动态库。
- `packages/com.wechat.improve_2.0-6_iphoneos-arm64.deb`：Rootless，保留供对应安装环境使用。
- `packages/com.wechat.improve_2.0-6_symbols.zip`：两个 scheme / 两种架构的符号文件。

未越狱签名 IPA 用户仍使用已有注入和签名流程。本轮没有检查用户实际签名 IPA 的 Info.plist / Face ID 权限，deb 构建成功不等于已验证宿主授权；用户提供的收藏验证可用是宿主已有支持的线索。

建议只验收下面三项：

1. 打开生物识别开关，微信退到后台再回首页使密友重新锁定，长按首页标题，应请求系统 Face ID / Touch ID，成功后显示密友。已有临时授权期间进入设置不会重复验证。
2. 重新锁定再长按，取消系统验证，应出现带原因的密友密码输入框；取消密码后仍隐藏，正确密码才显示。
3. 系统验证期间退后台或锁屏，再回微信，旧结果不应显示密友；重新长按能发起新验证。

若仍没有系统验证，请提供实际解锁入口（首页长按／设置入口／搜索密码）、是否先重新锁定，以及密码弹窗的完整提示。必要时补充 iOS / 微信版本和宿主 Face ID 授权状态；无需提供密友名单或密码。
