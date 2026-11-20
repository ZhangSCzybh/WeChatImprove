# WeChatImprove 2.7-3

发布日期：2026-11-20。本版优化设置首页顶部的卡片尺寸与文字可读性，提供 Rootless、Rootful 两种安装包，最低 iOS 目标为 15.0。

## 更新内容

- **三卡统一尺寸**：已开启功能数、插件版本、微信版本三张状态卡片统一为等宽等高，左右留白一致，间距均为 8pt，顶部与底部对齐。
- **文字适度放大**：昵称、微信号、随机文案及 SVIP 标识的基础字号各增加 1pt。三张卡片的数值统一字号，说明文字同步放大。
- **排布适配**：文案与卡片随文字高度调整，长昵称继续省略并预留标识空间。版本号优先按统一字号显示，空间不足时自动缩放以保留完整内容。

包版本、插件内版本和当前更新说明统一为 `2.7-3`。本版继续采用账号信息、随机文案、状态卡片的展示顺序。历史说明与安装包保持原样。

## 交付文件

| 文件 | 用途 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.7-3_iphoneos-arm64.deb) | 安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.7-3_iphoneos-arm.deb) | 安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| [WeChatImprove.dylib](WeChatImprove.dylib) | 与 Rootful 包内动态库字节一致，供已有重签流程使用 |
| [symbols.zip](symbols.zip) | 对应两种构建方案、两个架构的 dSYM 调试符号 |
| [SHA256SUMS](SHA256SUMS) | 本目录交付文件与记录的 SHA-256 校验值 |
| [build-validation.json](build-validation.json) | 包版本、安装路径、架构、签名代码页与符号核验记录 |
| [source-sha256.json](source-sha256.json) | 生产源码、头文件和构建配置摘要 |
| [build-commands.json](build-commands.json) | 实际构建命令、目录、时间和退出码 |
| [核心回归记录](regressions/summary.json) | 布局、当前更新说明与版本同步的验证结果 |
| [Rootless 日志](build-rootless.log)／[Rootful 日志](build-rootful.log) | 对应方案的编译输出 |

两种包均包含 arm64、arm64e，按设备现有注入环境选择。包名中的 `iphoneos-arm64`／`iphoneos-arm` 是打包方案标识。本版不提供 Roothide 包或可直接安装的 IPA。

## 验证范围

聚焦真实顶部视图中的三卡尺寸、间距、对齐、文字大小与完整显示，覆盖短长昵称、当前与较长版本号、320／375／430pt 屏宽、20／32pt 边距及普通／放大字号。同时核对当前更新说明、版本号、下载链接和历史说明保留情况。

从当前完整源码使用独立临时目录构建，保留原 `.theos` 和历史发布目录。测试使用临时文件与内存界面替身，不操作真实账号、聊天数据库或设置。实际结果见本目录核心回归与构建核验记录。

本轮未安装或重启原设备微信；最终视觉与原生触摸交互仍需在原设备、原注入环境验收。
