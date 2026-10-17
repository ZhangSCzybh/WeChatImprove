# 当前版本更新说明 · 1.7-1

在 **插件设置 → 关于 → 版本信息** 点击进入 **版本更新内容** 页面。入口保留当前版本号并新增右侧箭头。详情页包含插件名称、当前版本和本次更新条目，采用原生分组列表，自适应行高、系统字号及浅色/深色模式，可滚动阅读。

## 本次更新内容

1. 新增更新内容查看入口：点击“版本信息”查看当前安装版本的更新内容。
2. 支持离线查看：更新说明随安装包提供，与当前安装版本对应。
3. 适配阅读体验：支持滚动阅读、系统字号和深色模式。

## 实现与维护

- `Controllers/CSCustomViewController.m` 为“版本信息”显示进入箭头，并接入原生导航跳转。
- `Controllers/CSReleaseNotesViewController.h/.m` 实现更新说明页，按 `kPluginVersionString` 读取对应说明，无网络请求、配置写入或数据库操作。
- 未配置说明的版本显示“暂无更新说明”，不显示其他版本的内容。
- 后续发布需同步维护 `control` 的版本号、`Headers/CSUserInfoHelper.h` 的 `kPluginVersionString` 和 `CSReleaseNotesViewController.m` 中的版本说明。
- Makefile 已自动收集 `Controllers/*.m`，新控制器直接参与编译。

## 验证与交付

- `make package SCHEME=rootless PACKAGE_VERSION=1.7-1` 成功，包含 `arm64` / `arm64e`。
- 已检查入口分支、版本对应关系、自动行高、多行文本及系统字体/颜色配置，变更通过 `git diff --check`。
- 解包核对版本为 `1.7-1`，架构标识为 `iphoneos-arm64`，安装目录为 `/var/jb/Library/MobileSubstrate/DynamicLibraries/`。
- 已确认包内动态库与构建产物一致，包含新控制器、页面标题和三项更新内容。
- 未安装到手机，也未进行模拟器视觉验收；实机点击跳转、返回导航及大字号/深色模式显示仍待验证。本轮未构建 Rootful 或 Roothide 包。

产物：`packages/com.wechat.improve_1.7-1_iphoneos-arm64.deb`

SHA-256：`455af197324402c671d6814c4b874f7945b887e0b4d8fa60f5fdcf8cc210a777`

安装并重新打开微信后，进入“版本信息”确认当前版本为 `1.7-1`，检查三项更新说明可完整阅读，返回设置页正常；再切换深色模式和较大系统字号检查文字及滚动。
