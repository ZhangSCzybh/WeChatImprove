# WeChatImprove 2.1-5 本地打包记录

2026-10-28，按用户“编译打包2.1-5”的要求，在既定 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 完成 Rootless、Rootful 完整编译及本地交付。构建基于 `main` 的 `7ff8a17d8e2ff1af6077b4246d36eb870e5e6620` 和当前工作区的代码清理改动；不以基线提交号代替实际输入，364 个源码/构建输入的准确内容见 [SHA-256 清单](source-sha256.json)。

## 版本内容

- 整合已完成的[日志、无入口页面、旧系统分支与历史测试清理](../code-cleanup-2026-10-28/README.md)，保留现用原生选择器、备份、朋友圈后缀与消息处理能力。
- 整合近期 AI 图片的[一次原生下载恢复](../ai-image-recovery-2026-10-28/README.md)及[JPEG/PNG 真实结束标记后的附加数据兼容修复](../ai-image-container-2026-10-28/README.md)。
- `control`、`kPluginVersionString`、当前版本更新说明与 README 同步为 `2.1-5`。公众号关注验证继续沿用当前实现，本次打包没有引入授权方案重设计。

## 交付文件

| 产物 | 包架构 | 文件大小 |
| --- | --- | ---: |
| [Rootless 安装包](../../../packages/2.1-5/com.wechat.improve_2.1-5_iphoneos-arm64.deb) | `iphoneos-arm64` | 1,419,236 字节 |
| [Rootful 安装包](../../../packages/2.1-5/com.wechat.improve_2.1-5_iphoneos-arm.deb) | `iphoneos-arm` | 1,416,380 字节 |
| [调试符号 ZIP](../../../packages/2.1-5/com.wechat.improve_2.1-5_symbols.zip) | 两种方案各含 `arm64`、`arm64e` dSYM | 10,421,689 字节 |
| [SHA256SUMS](../../../packages/2.1-5/SHA256SUMS) | 两个安装包及符号 ZIP 的 SHA-256 | 321 字节 |

两包版本均为 `2.1-5`，包内 dylib 都包含 `arm64`、`arm64e`，两个切片的最低系统均为 iOS `15.0`。Rootless 安装到 `/var/jb/Library/MobileSubstrate/DynamicLibraries/`，Rootful 安装到 `/Library/MobileSubstrate/DynamicLibraries/`。

## 构建与验证

使用 `/Users/zhangshichao/theos`、iPhoneOS 27.1 SDK、Apple clang 21.0.0，沿用 `DEBUG=0`、`FINALPACKAGE=1`。Rootless 和 Rootful 依次构建，三个目录变量 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`、`THEOS_PACKAGE_DIR` 均指向本次新建的外部临时目录。没有运行 `make clean` 或安装命令。准确目录与完整命令见 [build-environment.json](build-environment.json)，流程见 [build-release.py](build-release.py)。

- [Rootless 构建日志](build-rootless.log)、[Rootful 构建日志](build-rootful.log)：均退出 0，无编译或链接错误。每种方案保留 6 条既有弃用提示，涉及 `UILocalNotification`、`statusBarFrame` 及链接器 `-multiply_defined`。
- 从两份实际 `.deb` 解包后验证包名、版本、包架构、安装路径、dylib 两个架构及各自最低 iOS 版本。对四个架构切片分别检查当前版本和保留功能标识，同时确认已删除旧页面/方法名不再存在；标识检查仅证明代码存在/移除，不代替设备功能验收。
- 从本次构建目录提取四组原始 dSYM，逐一验证其非空 UUID 与对应 `.deb` 中 dylib 的架构 UUID 完全一致。最终 ZIP 包含 12 个文件，CRC 校验通过，另行解压后再次核对四组 UUID。完整结果见 [delivery-verification.json](delivery-verification.json)。
- 本轮额外运行备份兼容性隔离回归，**66 checks passed**，见 [verify-backup-compatibility.log](verify-backup-compatibility.log)。清理阶段已通过的 19 个相关回归及近期图片专项结果见各自记录；本次版本打包未重复运行完整测试集合。
- 两包和符号包的最终 `shasum -a 256 -c SHA256SUMS` 均为 `OK`。文件大小和哈希见 [packages.json](packages.json)。
- 独立复核直接读取最终交付目录，再次解开两包与符号 ZIP，确认版本、安装路径、四组架构 UUID、iOS 平台及最低系统均正确；ZIP 的 12 个条目无重名。注入 plist 与原文件语义一致，保留 `Bundles=[com.tencent.xin]`、`Executables=[ZYBH]` 及原依赖。未发现交付阻塞问题。
- 构建与核验期间，364 个源码/构建输入保持一致；原 `.theos/` 与 `packages/` 中 1,242 个已有文件的路径集合和 SHA-256 全部保持不变。交付仅新增 `packages/2.1-5/`，已有版本保留。保护基线见 [protected-artifacts-before.json](protected-artifacts-before.json)。

版本一致性、最终文件哈希、交付链接及 `git diff --check` 的收尾结果见 [final-checks.json](final-checks.json)。

## 环境与验收边界

本项目是 iOS 注入插件，本次在原 checkout 完成本地打包，没有切换前后端服务、端口或真实数据库。源码改动仍保留在当前工作区；没有提交、推送或发布到外部，也没有安装到手机或重启微信。

实际设备应按当前注入环境选择对应安装包。真机显示、页面交互及图片回复尚待验收；图片兼容修复的真机检查需让对方发送新图片消息，旧消息不会因安装自动补回复。
