# 1.6-37：悬浮底栏转场与贴底修复

## 问题与依据

录屏 ScreenRecording_10-17-2026 08-08-50_1.MP4 的侧滑返回过程中显示带文字的原生整条底栏，返回完成后才显示悬浮底栏。IMG_7375.PNG 显示偏移为 0 时底栏与屏幕底边仍有明显间距。

1.6-36 在底栏 hidden、alpha 接近 0 或脱离窗口时调用 CSStop，恢复原生图标/文字/背景。这使隐藏中的底栏无法为下一次导航转场保留悬浮外观。

对此前同一份本地微信 8.0.78.34 二进制的静态检查还确认：MMTabBar 的 snapshotViewAfterScreenUpdates:（0x10471fc70）新建容器，调用 addBlurEffectWithColor: 添加整条模糊背景，将每个 item 生成 UIImageView 快照，最后添加 1 像素分隔线。它不会复制插件的悬浮背景。仅在列表出现后重新布局不足以修正这张转场快照。

二进制 SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。REA open_binary 核对身份，Xcode llvm-objdump 按已有 Objective-C 方法表地址读取，选择器按本地 Mach-O 引用解码。证据见 [snapshot.asm](evidence/tabbar-native-2026-10-17/snapshot.asm) 和 [visibility.asm](evidence/tabbar-native-2026-10-17/visibility.asm)。这是静态实现证据，不是手机运行追踪；录屏设备的二进制身份未验证。

底部间距来自旧计算：`宿主高度 - 安全区底部 - 8 - 向上偏移`。例如安全区为 34 pt 时，0 偏移仍保留 42 pt 间隔。

## 实现

- 隐藏、透明或脱离窗口时保留底栏外观，释放列表 inset 的临时调整。hidden/alpha 继续由微信控制，隐藏底栏仍不响应点击；禁用功能或不支持的结构仍完整恢复原生。
- 在原生 hidden/alpha 变化及原生快照调用前同步准备样式。设置内部 frame 时禁用 UIView 隐式动画，保留宿主自身的转场运动。
- 保留微信原有快照方法。返回后按 item 的 frame 匹配四个原生 UIImageView，复用其图标和角标像素，用与实栏相同的渲染方法生成悬浮背景、圆角和描边。真实 item、按钮、target/action 和角标对象不移动。
- 快照容器保持原生 frame 和 bounds，允许上移的悬浮内容超出自身 bounds。找不到四个一一对应的原生图片视图时原样返回微信快照，避免破坏未知版本结构。
- 整个底栏在转场中移出裁剪祖先时不撤销样式；宿主在祖先内部而悬浮区域单独越界时仍回退原生，避免不可点击的悬浮按钮。
- 改为 `底边 = 宿主高度 - 向上偏移`。0 表示对齐原生宿主底边，正常主页宿主位于屏幕底部；不再额外减去安全区和 8 pt。增加偏移仍向上移动。

保留 1.6-36 的宽度档位、44–80 pt 高度范围、图标设置、文字隐藏、原生红点/数字、触感及描边动画。原有偏移数值不迁移，因此同一个数值现在更靠下；需要更高位置时增加“向上偏移”。0 贴底时按系统原有规则保留 Home 手势区域。

## 验证与边界

- `bash Tests/verify-tabbar.sh`：几何和偏好/原生适配器主机测试通过，覆盖 44–80 pt 零偏移贴底、偏移增量、隐藏/alpha/脱离窗口、快照组合、未知快照回退、禁用恢复、原生角标身份和裁剪边界。
- `bash Tests/verify-group-lifecycle.sh`：46 项，0 失败。
- `bash Tests/verify-group-viewport.sh`：72 项，0 失败。
- Rootless 构建：`make package -j4 SCHEME=rootless PACKAGE_VERSION=1.6-37`，包含 arm64 / arm64e。
- 主机测试使用 UIKit 替身和独立临时偏好域，不读取或修改手机微信数据。

未连接目标手机，本轮不能证明 UIKit 的实际快照渲染、材质效果、侧滑中断或屏幕边缘触控已通过。安装后重点检查：点击返回、完成侧滑返回、侧滑后取消、多次进出会话、显示/隐藏文字、有未读数字/红点，以及偏移 0/20/60 时的位置和四个按钮响应。关闭底栏样式后应恢复原生底栏。

包及校验结果见 [validation.json](tabbar-transition-1.6-37-validation.json)。
