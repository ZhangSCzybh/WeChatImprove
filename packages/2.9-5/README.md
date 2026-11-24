# WeChatImprove 2.9-5 完整版

2026-11-24 发布。基于当前完整源码构建，包含 2.9-4 的全部模块与本轮修复，正式配置为 `DEBUG=0`、`FINALPACKAGE=1`。

## 安装文件

| 环境／产物 | 文件 | 安装位置或用途 |
| --- | --- | --- |
| Rootless | [com.wechat.improve_2.9-5_iphoneos-arm64.deb](com.wechat.improve_2.9-5_iphoneos-arm64.deb) | `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| Rootful | [com.wechat.improve_2.9-5_iphoneos-arm.deb](com.wechat.improve_2.9-5_iphoneos-arm.deb) | `/Library/MobileSubstrate/DynamicLibraries/` |
| 重签动态库 | [WeChatImprove.dylib](WeChatImprove.dylib) | 与 Rootful 安装包内动态库逐字节一致 |
| 调试符号 | [symbols.zip](symbols.zip) | 保留两种方案、两种架构的 dSYM |
| SHA-256 | [SHA256SUMS](SHA256SUMS) | 发布文件校验清单 |

两个安装包和独立动态库均包含 `arm64`／`arm64e`，最低编译目标为 iOS 15.0。包名中的 `iphoneos-arm64`／`iphoneos-arm` 表示打包方案，按设备现有注入环境选择。

## 本轮更新

- **聊天列表冷启动与顶部提示**：修正仅有电脑登录提示时顶部区域和分组栏的初始位置；记录顶部提示独立的增删及刷新，处理首次列表发布期间晚到的电脑登录等提示。保留笔记置顶和微信原生在线状态流程。修复针对提示已经就绪后的列表发布遗漏，不提前生成在线状态，也不承诺笔记与电脑提示同帧出现。
- **分组初始横向位置**：修正五个及以上分组时重启后的横向偏移和首项左裁；等待有效布局后定位选中项。保留用户手动滚动、原生未读定位及分组切换。
- **分组颜色与列表深色外观**：选中文本颜色设置适配深色模式；通讯录、发现和“我”页面的列表圆角外围、分区标题、页脚及页面头部随主题更新。
- **底栏选中图标颜色**：支持自定义及恢复微信原生默认，恢复后沿用原生深浅色更新。上传的普通及选中图标优先保留图片原色，选中色用于实际使用原生图标的项目。
- **快捷面板**：新增深色模式切换和全局搜索，可选入口由 19 项增至 21 项，新增入口可手动添加。插件主页统一为原有入口使用的独立导航容器，调整入场顶部布局，保留详情返回的滚动恢复。深色切换使用微信原生服务；恢复“跟随系统”仍可通过原生设置操作。
- **语音转文字气泡**：按住输入框时的转写预览接入发送方浅深色配色与圆角；发送后的两种语音转文字专用消息接入自定义气泡、复用与恢复逻辑。保留原生录音状态、圆点、展开与发送收拢动画。
- **朋友圈与备份**：位置图标替换为地图图钉，保留位置文字、颜色和布局；底栏及面板新增配置纳入现有备份、恢复与重置。
- **完整功能与版本**：聊天分组、界面定制、底栏、朋友圈布局、消息增强、自动功能、群聊工具、人工智能和备份恢复等既有模块全部包含。安装包、插件内部版本、当前更新说明与主 README 统一为 `2.9-5`，保留历史版本说明。

## 构建与回归

从 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 当前源码，在两个独立临时目录中分别全量编译 Rootless 与 Rootful。每方案每架构编译全部 **292 个单元（236 个控制器实现、56 个 Logos Hook）**，共四组架构／方案、1168 条编译记录，无源文件遗漏。命令与时间见 [build-commands.json](build-commands.json)，日志见 [Rootless](build-rootless.log)／[Rootful](build-rootful.log)，覆盖核验见 [compilation-coverage.json](compilation-coverage.json)。

本次重新执行的功能回归共 16 组，均通过：

| 范围 | 结果 |
| --- | --- |
| 聊天分组顶部提示、初始视口、指示器、颜色设置、顶部语义与偏好 | 6 组，406 项检查，0 失败 |
| 列表圆角 | 1711 项检查，0 失败 |
| 底栏 | 几何、选中图标色、原生恢复、生命周期及 121 项触摸检查通过；脚本未提供整体计数 |
| 朋友圈卡片 | 73580 项检查通过 |
| 快捷路由 | 396 项检查通过 |
| 快捷面板偏好 | 通过；脚本未提供检查数 |
| 气泡及与消息合并的兼容 | 39660 项检查通过 |
| 插件主页生命周期 | 1030 项检查通过 |
| 备份注册表、兼容性与重置 | 2212 条断言、66 项兼容检查及 45 项重置检查通过 |

详细日志与独立结果在 [regressions](regressions/)。这些是本机隔离回归，未运行整套仓库测试。

版本及更新说明完成 18 项检查：执行实际生产函数后选中 `2.9-5` 的九条说明，`2.9-4` 的六条历史说明与归档逐条相同。更新说明控制器在 arm64、arm64e 的 iOS 15 目标下通过 `-Wall -Wextra -Werror` 严格语法检查。

两包的版本、安装前缀、实际双架构和最低 iOS 15.0 均核验通过；四个架构切片的 ldid CodeDirectory 页哈希与 special-slot 哈希匹配。四份 dSYM 的 UUID 分别与对应包内二进制匹配，符号 ZIP 完整性通过；独立动态库与 Rootful 包内库逐字节一致。静态产物核验见 [build-validation.json](build-validation.json)，最终交付核验见 [release-validation.json](release-validation.json)。

构建前后 **533 个源码输入及 450 个测试文件**的哈希一致；已记录的 **1347 个历史发布文件及 Git 跟踪构建文件**未变化。未运行 `make clean`。源码清单见 [source-manifest.json](source-manifest.json)，测试清单见 [test-manifest.json](test-manifest.json)，与 2.9-4 的 29 项构建输入差异见 [change-scope.json](change-scope.json)，环境核验见 [environment-preservation.json](environment-preservation.json)。

编译日志中仍有既有 API 弃用和链接选项警告；两个方案均无编译错误并成功打包。

## 实际设备范围

本次完成源码更新、主机回归、全量编译和打包，没有安装到手机或切换微信运行环境。实际冷启动顶部显示、五个以上分组的首屏、深浅色切换、面板进入插件主页的转场，以及连续语音输入到发送的显示效果，仍需在原设备、原账号和原注入环境验收。
