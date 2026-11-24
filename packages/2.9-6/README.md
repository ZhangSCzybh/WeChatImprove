# WeChatImprove 2.9-6 完整正式版

2026-11-24。用户已确认 beta03 在原设备的输入框滑动正常。本版保留已验证的接入和动作实现，清理临时诊断，按项目完整源文件列表编译全部功能，版本统一为 `2.9-6`。

## 安装文件

| 环境 | 产物 |
| --- | --- |
| Rootless | [com.wechat.improve_2.9-6_iphoneos-arm64.deb](com.wechat.improve_2.9-6_iphoneos-arm64.deb) |
| Rootful | [com.wechat.improve_2.9-6_iphoneos-arm.deb](com.wechat.improve_2.9-6_iphoneos-arm.deb) |
| 现有重签流程 | [WeChatImprove.dylib](WeChatImprove.dylib)，与 Rootful 包内动态库一致 |
| 符号文件 | [symbols.zip](symbols.zip)，含两种方案、两个架构的四份匹配 dSYM |

继续使用设备原有注入方式安装。两个安装包均包含 `arm64` 和 `arm64e`，最低编译目标 iOS 15.0。包名中的 `iphoneos-arm64`／`iphoneos-arm` 表示打包方案，应按原注入环境选择。本目录提供插件安装包和动态库，不含重签微信 IPA。

## 清理内容与保留行为

- 移除“滑动检测”、检测弹窗、复制检测结果入口，以及相关 API、计数、时间、最近状态、组件记录、诊断字符串、仅供诊断使用的字段和关联标记。
- 删除测试中的诊断解析、纯诊断断言、历史源码切换及旧版链接专用 fallback；保留真实功能、生命周期和对象释放检查。
- 已验证的占位 Hook 接入、Grow/tool 桥接、弱候选登记、前台恢复、离开取消、当前编辑器身份检查、组词／听写保护、单次派发和原生手势仲裁范围继续保留。上述 Hook、原生编辑、偏好和方向策略文件与 beta03 源码哈希一致。
- 同期聊天分组动画参数调整（`damping=1`、`initialSpringVelocity=0`）已纳入。项目其余现有功能随完整源文件列表编译。

入口为“界面定制 → 文本占位 → 输入框滑动”。启用后仅保留总开关、左滑动作、右滑动作三行，可选禁用、清空、复制、剪切、粘贴、发送。已有配置沿用；清空、复制、剪切操作全部输入内容，粘贴和发送使用原生入口。

## 验证结果

| 核心回归 | 结果 |
| --- | ---: |
| 输入框绑定、功能、生命周期、身份与恢复 | 74 项，0 失败 |
| 设置与原生编辑 | 91 项，0 失败 |
| 方向、时长边界与面板共存 | 34 项通过 |
| 现有头像与输入框样式 | 139 项通过 |

共 338 项全部通过；样式回归包含 20,000 次头像更新、30,000 次输入回调热路径检查。运行模块、设置与发布说明三个源文件通过 arm64／arm64e 六组严格 iOS 语法检查，零诊断。完整结果、测试输入和逐次日志见 [regression-results.json](regression-results.json)、[test-manifest.json](test-manifest.json) 及 [syntax-checks-final.json](syntax-checks-final.json)。

两种方案于 2026-11-24 14:26:00—14:26:29 +08:00 编译成功，14:26:32 完成包核验。版本、双架构、iOS 15.0 目标、安装路径、注入 plist、四份 dSYM UUID 和独立动态库一致性均通过。每份构建日志为 0 error、8 条已有 deprecated API／链接器选项 warning，无本模块 warning。

另以 beta03 实物做正对照，确认 11 个旧诊断 API／字段名在两包动态库和四份 dSYM 中均已消失，3 条专用诊断文案在两包二进制中均已消失；历史发布说明继续保留。详见 [build-validation.json](build-validation.json) 与 build-evidence/diagnostic-removal-check-spec.json。

使用原项目 checkout 和隔离构建目录，541 个生产源码文件在构建前后完全一致；2670 个保留文件未变，历史 beta 包及用户原有 `.theos` 保留，未运行 `make clean`。构建命令、源码快照与保留报告见 [build-commands.json](build-commands.json)、[source-manifest.json](source-manifest.json)、[environment-preservation.json](environment-preservation.json) 和 build-evidence/。

用户的真机可用确认对应 beta03。本正式包完成清理审查、主机核心回归、完整编译和产物核验，尚未重新安装到设备；主机 UIKit 替身测试不模拟全部真实 UIKit 手势竞争。安装后完全退出并重新打开微信，在插件设置确认版本为 `2.9-6`，沿用原来的左右动作即可。

完整文件 SHA-256 清单见 [SHA256SUMS](SHA256SUMS)。
