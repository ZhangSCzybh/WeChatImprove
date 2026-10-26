# 2.0-7 后台模糊关闭后的整屏遮罩

本轮对 2.0-6 真机反馈进行局部排查，先验证原实现，再修复一条确定的整屏遮罩冲突。没有连接真机；已复现的是插件密友模块的纯色隐私遮罩，不能据此断言用户看到的所有毛玻璃效果都来自这条路径。

## 根因与证据边界

- `CSBackgroundBlurManager` 原实现每次通知都会读有效 defaults，关闭后同步移除已登记的模糊层、取消动画并清理返回快照。设置页和运行时使用相同 suite/key；`BackgroundBlurHooks` 只启动单例，`CSCustomViewController` 只负责页面入口。没有发现这四处存在“关闭后仍主动创建毛玻璃”的可复现问题。
- 新增“显式关闭 + App/Scene 失焦和后台通知”用例，覆盖设置页与运行时使用不同 NSUserDefaults 实例、各窗口无额外视图；原生产实现就通过了 229 项检查，记录在 `before-blur-only.log`。没有为了得到失败而伪造缓存或系统行为。
- **组合运行存在冲突：** 密友管理器独立监听 UIApplicationWillResignActive / DidEnterBackground，`resign:` → `suspend:` → `lockAndReturnToSafePage` → `cover`。启用密友、持有临时授权或正在验证时，直接往 UIWindow 添加纯色 UIView；它既不读取后台模糊开关，也不响应关闭通知。生物识别挑战期间的短暂失焦同样会直接 cover。
- 模糊管理器只能移除自己登记的 `CSBackgroundBlurOverlay`，不能清除密友管理器持有的普通 UIView，因此两套管理器同时运行时，UI 显示关闭仍可能整屏被遮挡。密友产生的是 `UIColor.systemBackgroundColor` 的纯色遮罩，不是 UIVisualEffectView 毛玻璃。
- 对真实生产密友窗口、遮罩与生命周期方法构建组合用例。修复前，后台模糊关闭、密友开启时，先证实授权已撤销，再断言窗口只剩原始内容，失败为：`FAIL: blur OFF + switcher must not leave any full-window blur or privacy cover`。日志 `before-privacy.log` 保留 exit=1；原代码在 `before/Controllers/CSCloseFriendManager.m`。

可复现修改前的失败：

```sh
bash Tests/verify-background-privacy.sh \
  docs/audits/background-blur-disable-2.0-7/before/Controllers/CSCloseFriendManager.m
```

该脚本的可选参数仅替换被测密友管理器方法来源；模糊控制和 UIKit 宿主替身不伪造失效。旧代码不存在的新增设置观察方法会跳过提取，旧版仍通过自身生命周期挂上遮罩并触发失败断言。

## 本次修改

按本轮“关闭后不得存在模糊/遮罩”的要求，后台视觉遮挡统一遵循后台模糊开关。这调整了以前密友独立强制遮挡的行为；授权控制与视觉遮挡分开处理。

- `CSBackgroundBlurManager` 提供只读 `isEnabled`，直接返回原 suite/key 的当前值；内部刷新复用相同读取方法，不改变原模糊动画或场景处理。
- 密友 `cover` 在后台/失焦时检查这一值，关闭则清掉自己已有遮罩并返回。判断兼顾 `backgroundCoverRequired` 和 UIApplication 的实际状态，覆盖后台晚启动或通知标记滞后的情况。
- 密友监听后台模糊专用设置通知，以及原有恢复/重置的 settings_changed、local_settings_changed；关闭后在主线程同步移除已有后台遮罩，非主线程通知切回主线程处理。
- 保留监听器，以便后续设置与账号/生命周期事件继续工作；每次添加前检查开关，关闭时无需注销整个生命周期监听。没有跨模块扫描或删除任意窗口子视图。
- 密友仍会在后台撤销授权、取消挑战、使 token 失效并退出敏感聊天。前台手动锁定使用的短暂遮罩保留，随后按原流程移除。关闭全屏遮挡并不保证系统切换器隐藏所有当前页面内容，这是本轮关闭视觉遮挡的明确语义。
- 设置页说明更新；版本常量、control、发布说明和 README 更新为 2.0-7。

生产差异见 `production.diff`。Hooks 与自定义设置主入口没有修改；未改密友 Runtime、密码、生物识别验证或存储逻辑。

## 核心回归

只执行后台模糊与组合隐私遮罩脚本，没有运行全量脚本、备份回归或整个密友运行时套件。

| 脚本 | 检查数 | 结果 |
| --- | ---: | --- |
| `Tests/verify-background-blur.sh` | 229 | 通过，`blur.log` |
| `Tests/verify-background-privacy.sh` | 33 | 通过，`privacy.log` |
| 合计 | 262 | 通过 |

组合用例直接提取生产密友 cover、uncover、start、设置通知及生命周期方法，并与生产 CSBackgroundBlurManager 在同一个窗口运行。UIKit 为宿主替身；密友 Runtime 授权状态、账号服务、系统验证 context、敏感导航为边界替身。测试只验证调用/状态与视图挂载关系，不模拟 UIKit 像素或 SpringBoard 快照。

覆盖范围：关闭后的切换器/后台/App/Scene/窗口事件；不同 defaults 实例；已存在的两类视图立即清理；关闭通知三种来源；非主线程通知；后续事件不复活；开启时仍有保护；前台手动锁定过渡保留；生物识别短暂 inactive 保留挑战、真正后台取消；锁屏不重复完成；后台晚启动和标记滞后。

原生物识别测试 fixture 补充新设置通知常量和空 UI 边界处理，以适配生产 start 新增的观察者；本轮未重复执行该套件。新增组合用例专门覆盖本次触及的验证生命周期边界。

## 构建与产物

复用独立 Theos 构建目录进行增量编译；未执行 make clean，未修改用户设备或签名 IPA。历史 deb 和 dSYM 压缩归档保留，配置域、账号数据和存储路径不变。

- `packages/com.wechat.improve_2.0-7_iphoneos-arm.deb`：Rootful。
- `packages/com.wechat.improve_2.0-7_iphoneos-arm64.deb`：Rootless。
- `packages/com.wechat.improve_2.0-7_symbols.zip`：两个 scheme 的 arm64 / arm64e dSYM。

两个 deb 的 payload 均含 arm64 / arm64e。`verify-packages.py` 核验版本、deb 架构、修复方法与配置键、测试替身未入包、dSYM UUID、现有存储初始化顺序后才复制最终包。大小、SHA-256 和 UUID 见 `packages.json`；实际构建目录见 `build-environment.json`，完整日志见 `build-rootful.log` / `build-rootless.log`。构建成功，已有弃用警告保留，没有顺手修复无关代码。

## 真机验收

1. 注入并安装 2.0-7 后进入微信一次，再关闭后台模糊。分别拉起切换器后取消手势、彻底退后台再返回，普通页面应无插件额外整屏模糊或遮罩。先回前台再重新进入切换器，避免把系统尚未刷新的旧任务卡片当作新结果。
2. 密友开启且临时解锁后，保持后台模糊关闭，重复上述步骤。后台不得重新出现密友整屏遮罩；回前台密友应已锁定，敏感聊天应退出。
3. 开启后台模糊，确认保护正常；再关闭，重复拉起切换器，确认关闭立即生效且不残留返回动画快照。
4. 生物识别验证期间切后台或锁屏，返回后旧验证不得解锁；关闭后台模糊时也不应新增整屏遮罩。前台手动锁定仍允许原有短暂过渡。

如果实际仍是能隐约看见页面内容的毛玻璃，而不是纯色整屏遮挡，需要补充：效果截图或简短录屏、密友是否开启、插件显示版本及 iOS/微信版本。当前源码和宿主测试无法确定其他注入插件、微信原生保护或系统任务快照的贡献，不把这些可能性写成已证实根因。
