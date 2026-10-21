# 1.8-60：统一密友设置页布局

2026-10-21，在 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` 分支调整，基线提交 `12f8897eeef3adb446526118f49911575af3974c`。已完成源码修改、主机回归及 Rootless 双架构打包，未安装到手机，真机视觉验收待完成。

## 框架与差异

项目使用 Theos 构建 Objective-C / Logos 微信插件。`Hooks/` 接入微信生命周期与私有接口，`Controllers/` 承载设置界面、业务策略和原生适配。自动收款、语音转发等设置页使用 UIKit 分组列表、`CSSettingItem` 和公共 `CSSettingTableViewCell`。

密友入口已使用相同的 Inset Grouped 列表，但原页面直接创建没有图标的 `UITableViewCell`，开关使用 `accessoryView`，没有采用公共单元格的文字起点和分隔线设置。这是此次对齐的实现差异。

## 页面调整与功能边界

运行代码仅修改 `Controllers/CSCloseFriendSettingsViewController.m`，另同步包版本、插件显示版本、更新说明与 README。

- 使用继承公共设置单元格的局部子类，沿用原生字体、分组背景、选中背景和默认行高；补齐设置项图标，文字与分隔线使用公共页面的 54pt 起点。
- 开关采用公共页面的居中与右侧 15pt 间距，仍由原 `UISwitch`、原 tag 和原 `toggle:` 处理，不引入新的配置回调或保存路径。
- 标题、右侧详情与开关之间预留空间。较长内容以尾部省略号显示，完整挂断回复继续由原编辑弹窗读取、验证和保存。每次布局重算宽度，复用后可以恢复较宽的显示区域。
- 复用时由公共单元格清理开关和旧内容，局部弱引用同步清空；不可操作的当前状态与开关行不显示点击高亮。

原两组 26 个条目、标题、配置键及顺序保持不变。逐字节对比确认：认证生命周期、策略通知处理、分组/行数、说明文案，以及 `showError:` 开始的错误处理、保存、开关、名单选择、修改密码、立即锁定、回复编辑和解锁时长回调保持一致。联系人选择器的账号 token 校验继续保留。

所有 Hook、密友管理器、运行状态、过滤策略、加密存储、原生联系人选择器以及公共设置单元格均保持原文件哈希。密码、密友/密群名单、临时解锁、通知静默、来电拒接和挂断回复的业务实现没有修改。

## 验证

| 检查 | 结果 |
| --- | --- |
| `verify-close-friend-core.sh` | 211 项通过 |
| `verify-close-friend-runtime.sh` | 运行状态 90 项、到期调度 9 项通过 |
| `verify-native-contact-picker.sh` | 72 项通过 |
| 密友设置页和公共单元格 arm64 / arm64e 严格编译 | 通过，`-Wall -Wextra -Werror`，无诊断 |
| Rootless 完整构建 | 通过，arm64 / arm64e，最低 iOS 15.0 |
| 包版本、内置版本、更新说明、注入过滤、包内二进制及 dSYM UUID | 匹配 |
| 基线源码与历史产物保留检查 | 341 个既有文件中 336 个哈希不变，5 个为上述页面及版本/说明文件 |

共 382 项既有功能回归，测试使用临时目录和模拟凭据，没有访问真实微信账号、容器或钥匙串。这些测试验证核心功能保护边界，不模拟 UIKit 的最终屏幕布局。未为样式调整新增模拟字体或布局的测试。

完整构建保留既有 `openURL:`、`UILocalNotification`、`statusBarFrame` 弃用警告及 `multiply_defined` 链接警告。此次页面和公共单元格的独立严格编译没有警告。完整证据见 [validation.json](validation.json)、[build.log](build.log) 及本目录三个回归日志。

## 交付与运行环境

- [Rootless 1.8-60 安装包](../../../packages/com.wechat.improve_1.8-60_iphoneos-arm64.deb)
- [arm64 / arm64e 调试符号](../../../packages/WeChatImprove-1.8-60-dSYMs.zip)

安装包 SHA-256：`d86849e5752202ac1a1e67cc554eb6590511c2f6944c9d009f0d9a914ccc41d9`。

使用当前 checkout 的源码，在独立临时目录保存构建缓存、暂存文件和打包输出，再将新产物复制到当前项目 `packages/`。没有切换 checkout、执行 `make clean`、覆盖历史安装包、提交或推送。

本项目是 iPhone 内运行的微信插件，没有本地前后端 URL 或端口。密友配置由运行中的微信容器解析到 `Library/Application Support/WeChatImprove/CloseFriends/`，凭据保存在对应钥匙串中；本轮没有访问或修改设备上的这些数据。交付位置为安装包，不能将其视为手机已加载新版本。

本机没有可用 iOS Simulator runtime。安装后需对照“自动收款”等页面检查浅色/深色外观、较长标题与回复、滚动复用、开关与名单入口，以及锁定后设置内容清空的表现。
