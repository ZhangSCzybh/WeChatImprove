# WeChatImprove 2.9-4 完整版

2026-11-23 发布。本版从当前完整源码构建，包含 2.9-3 的全部模块以及四项新增快捷入口，使用正式构建配置 `DEBUG=0`、`FINALPACKAGE=1`。

## 安装文件

| 环境／产物 | 文件 | 安装位置或用途 |
| --- | --- | --- |
| Rootless | [com.wechat.improve_2.9-4_iphoneos-arm64.deb](com.wechat.improve_2.9-4_iphoneos-arm64.deb) | `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| Rootful | [com.wechat.improve_2.9-4_iphoneos-arm.deb](com.wechat.improve_2.9-4_iphoneos-arm.deb) | `/Library/MobileSubstrate/DynamicLibraries/` |
| 重签动态库 | [WeChatImprove.dylib](WeChatImprove.dylib) | 与 Rootful 安装包内动态库逐字节一致 |
| 调试符号 | [symbols.zip](symbols.zip) | 分别保留两种方案、两种架构的 dSYM |
| SHA-256 | [SHA256SUMS](SHA256SUMS) | 全部发布文件的校验清单 |

两个安装包和独立动态库均包含 `arm64`／`arm64e`，最低编译目标为 iOS 15.0。包名中的 `iphoneos-arm64`／`iphoneos-arm` 表示打包方案，请按设备现有注入环境选择。

## 本版内容

- 快捷面板新增 **收款码、我的朋友圈、新建笔记、切换账号**，共 19 项可选入口。默认仍为原有 8 项，新增入口可在设置中手动添加；已有选择、排序及空面板配置继续兼容。
- 修复“切换账号”只停留在设置页的问题。按用户提供的微信 **8.0.80 / build 8.0.80.34** IPA 与同版头文件核对原生设置行，使用其真实绑定的 `showLoginInfo` 入口。等待原生设置页进入当前窗口、转场结束后仅提交一次动作，保留首次使用提示及微信原生检查与后续账号选择。
- 切换账号的异步结果以真实可见账号页，或当前设置页持有的真实原生首次提示为依据；仅创建设置页或调用方法不会被判为已打开后续界面。首次提示出现即交回微信，由原生确认回调继续；插件不会再补调一次内部切换动作。重复点击不会重入，返回或切换页面、账号变化、后台和超时会释放插件请求。
- 新建笔记使用当前窗口的原生编辑入口，沿用收藏的生物识别保护。收款码与付款码分别提供入口；我的朋友圈与朋友动态分别提供入口。
- 保留面板上滑位置、预览、入口增删与排序、自定义背景颜色／图片／透明度、字体及图标配色、圆润顶部字体，以及九项配置和图片资源的备份恢复。
- 聊天分组、底栏、界面定制、朋友圈布局、消息增强、自动回复、群聊工具、人工智能、备份恢复及其他既有模块均包含。安装包、插件内部版本和更新说明统一为 **2.9-4**，历史更新说明继续保留。

## 构建与验证

Rootless 与 Rootful 从同一源码目录，分别使用独立的临时构建目录完成全量编译及打包；未执行 `make clean`。每种方案的每个架构均编译全部 **292 个单元：236 个控制器实现、56 个 Logos Hook**，四组架构／方案共 1168 条编译记录，无模块裁减。构建命令见 [build-commands.json](build-commands.json)，日志见 [Rootless](build-rootless.log)／[Rootful](build-rootful.log)，覆盖记录见 [compilation-coverage.json](compilation-coverage.json)。

本次重新执行并通过：

- 快捷面板路由 **361 项检查**，包括设置页延迟挂载、转场、真实异步目标、原生 no-op 超时、首次提示独立窗口、确认／取消、错误 ABI、重复点击与账号／窗口／scene／用户离开边界。
- 快捷面板偏好、745862 项手势检查、41 项背景检查、68 项显示配色与字体检查、63 项配色设置检查。
- 备份注册表 **2131 项断言**及资源备份 32 项检查。
- 生产路由和更新说明在 arm64／arm64e、iOS 15 目标下的四项严格语法检查，使用 `-Wall -Wextra -Werror`。
- 两种包的版本、安装路径、双架构与 iOS 最低版本检查；四份 dSYM UUID 与实际二进制匹配；独立动态库与 Rootful 包内动态库一致；符号压缩包完整性检查。
- 533 个构建输入及 440 个测试文件的哈希核验，构建期间无变化。历史安装文件和 Git 跟踪的原 `.theos` 文件核验见 [environment-preservation.json](environment-preservation.json)。

回归日志及结果位于 [regressions](regressions/)，最终包核验见 [build-validation.json](build-validation.json)，原生调用链的静态证据见 [native-route-evidence.md](native-route-evidence.md)。源码和测试清单分别见 [source-manifest.json](source-manifest.json)、[test-manifest.json](test-manifest.json)。

## 实际设备范围

本次完成静态分析、源码修复、主机回归、全量编译和打包，未安装到手机或启动微信，没有执行真实账号切换。实际提示、账号列表展示与返回、单账号／多账号状态、新建笔记编辑与保存，以及手势表现仍需在原设备、原账号和原注入环境验收。静态调用链与主机模拟不等于真机已经展示成功。
