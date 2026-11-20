# WeChatImprove 2.7-4

发布日期：2026-11-20。本版调整设置首页顶部的随机文案、SVIP 标识及插件版本显示，提供 Rootless、Rootful 两种安装包，最低 iOS 目标为 15.0。

## 更新内容

- **随机文案 16pt**：基础字号调整为 16pt，继续随系统字号适配，最多显示两行，状态卡片随文案实际高度排列。
- **SVIP 固定样式**：参照示例采用固定浅金色背景、黑色衬线文字和小圆角矩形，重新进入与刷新时保持一致，标识文字继续显示 SVIP。
- **精简插件版本**：插件版本状态卡片去除前缀“v”，直接显示版本号。

包版本、插件内版本和当前更新说明统一为 `2.7-4`。顶部继续采用账号信息、随机文案、三张等宽等高状态卡片的展示顺序。历史说明与安装包保持原样。

## 交付文件

| 文件 | 用途 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.7-4_iphoneos-arm64.deb) | 安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.7-4_iphoneos-arm.deb) | 安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| [WeChatImprove.dylib](WeChatImprove.dylib) | 与 Rootful 包内动态库字节一致，供已有重签流程使用 |
| [symbols.zip](symbols.zip) | 对应两种构建方案、两个架构的 dSYM 调试符号 |
| [SHA256SUMS](SHA256SUMS) | 本目录交付文件与记录的 SHA-256 校验值 |
| [build-validation.json](build-validation.json) | 包版本、安装路径、架构、签名代码页与符号核验记录 |
| [source-sha256.json](source-sha256.json) | 生产源码、头文件和构建配置摘要 |
| [build-commands.json](build-commands.json) | 实际构建命令、目录、时间和退出码 |
| [核心回归记录](regressions/summary.json) | 布局、页面刷新、头像交互、当前说明及版本同步的验证结果 |
| [Rootless 日志](build-rootless.log)／[Rootful 日志](build-rootful.log) | 对应方案的编译输出 |

两种包均包含 arm64、arm64e，按设备现有注入环境选择。包名中的 `iphoneos-arm64`／`iphoneos-arm` 是打包方案标识。本版不提供 Roothide 包或可直接安装的 IPA。

## 验证范围

聚焦真实顶部视图中的文案字号、固定标识颜色与衬线字体、小圆角和版本显示，覆盖短长昵称、当前与较长版本号、320／375／430pt 屏宽、20／32pt 边距及普通／放大字号；同时检查三卡尺寸与排布、页面文案刷新及头像对象和既有交互绑定，核对当前说明、版本号、下载链接和历史说明保留情况。

从当前完整源码使用独立临时目录构建，保留原 `.theos` 和历史发布目录。测试使用临时文件与内存界面替身，不操作真实账号、聊天数据库或设置。实际结果见本目录核心回归与构建核验记录。

本轮未安装或重启原设备微信；最终视觉与原生触摸交互仍需在原设备、原注入环境验收。
