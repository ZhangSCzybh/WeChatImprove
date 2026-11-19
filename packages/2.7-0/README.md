# WeChatImprove 2.7-0

日期：2026-11-19。完整正式版，基于当前工作区全部生产源码构建，包含既有插件功能、朋友圈瀑布流及小丑新增能力。最低编译目标 iOS 15.0；Rootless 与 Rootful 均包含 arm64、arm64e。

## 本次清理

- 删除朋友圈原生分享异常、分享字段诊断、高清媒体读取三处调试日志。
- 一并删除日志专用去重集合、输出标记及原图尺寸记录；保留实际解码所需尺寸、缓存预算、画质选择、请求限频和原生媒体观察。
- 删除只有赋值、没有读取方的卡片 `shareItem` 字段。完整原生动态继续由 `item` 持有，原生分享点击和内容提取保持现状。
- 将朋友圈测试 defaults 替身限制在测试宏内，正式构建直接使用原有标准偏好。
- 合并小丑会话模块重复的私有声明，整理 include 位置，方法体与随机规则保持现状。

相较 2.7-0-beta05，489 项生产输入中仅 6 个清理文件及 3 个版本／更新说明文件改变。封面顶部坐标、渐隐衔接、卡片布局和返回定位均沿用 beta05；没有扩大到其他模块重构。

## 正式版包含

**朋友圈布局**：双列瀑布流、14pt 卡片圆角、原生标题表情、备注与时间、位置、互动数量和首张媒体封面；保留完整原生详情、原生媒体、静音播放策略、下拉刷新、分页及详情返回定位。沿用已确认的封面柔和衔接，并读取微信原生列表顶部布局进行头部坐标适配。

**你别冷漠好不好**：通过微信原生联系人／群聊选择器指定生效会话，名单按账号保存。仅匹配对方整条纯文本“嗯、奥、恩、嗷、嗷嗷、行、好、可以、可、成、ok、OK”，每项有三种热情表达。当前页面首次命中时随机、滚动复用保持一致；离开后清理，重新进入时再次随机。只影响本机显示，不修改服务器消息，也不处理自己的消息。

**假的引用好玩吗**：输入 `#假引用 被引用的内容；真正发送的内容`，支持英文分号。本机显示带昵称的引用灰条，对方只收到分号后的正文；格式错误或与真实引用／@ 冲突时保留草稿。保留原生异步发送绑定、页面和账号隔离，灰条随离开页面清理。

两项新增能力默认关闭，受小丑总开关控制；保留已有长按修改功能、配置备份及分段使用说明。入口为 **插件设置 → 功能增强 → 小丑功能**；朋友圈入口为 **插件设置 → 界面定制 → 朋友圈布局**。

## 交付文件

| 文件 | 用途 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.7-0_iphoneos-arm64.deb) | `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.7-0_iphoneos-arm.deb) | `/Library/MobileSubstrate/DynamicLibraries/` |
| [WeChatImprove.dylib](WeChatImprove.dylib) | 与 Rootful 包内动态库字节一致，供已有重签流程使用 |
| [symbols.zip](symbols.zip) | 两种方案、两种架构的调试符号 |
| [SHA256SUMS](SHA256SUMS) | 本目录交付文件及回归日志的 SHA-256 校验值 |
| [build-validation.json](build-validation.json) | 包元数据、路径、过滤配置、架构、代码页签名哈希、符号 UUID、日志清理和源码一致性记录 |
| [source-sha256.json](source-sha256.json) | 489 项生产源码／配置输入摘要 |
| [core-regressions.txt](core-regressions.txt)／[core-regressions.json](core-regressions.json) | 核心回归汇总，详细输出在 regressions/ |
| [build-rootless.log](build-rootless.log)／[build-rootful.log](build-rootful.log) | 完整构建日志 |

按设备原有注入环境选择安装包。包名中的 iphoneos-arm64／iphoneos-arm 是打包方案标识，两种包都包含双架构。安装后按现有流程重新加载微信；朋友圈布局开关变更后需退出朋友圈重进。Roothide 本轮未构建。历史产物不覆盖。

## 核心回归

| 回归 | 检查数 | 范围 |
| --- | ---: | --- |
| clown-preferences | 266 | 通过，原始输出见 [日志](regressions/clown-preferences.log) |
| clown-presentation | 399 | 通过，原始输出见 [日志](regressions/clown-presentation.log) |
| clown-session | 120 | 通过，原始输出见 [日志](regressions/clown-session.log) |
| clown-text-rules | 68 | 通过，原始输出见 [日志](regressions/clown-text-rules.log) |
| moments-card | 73580 | 通过，原始输出见 [日志](regressions/moments-card.log) |
| moments-entry | 252 | 通过，原始输出见 [日志](regressions/moments-entry.log) |
| moments-header-backdrop | 143 | 通过，原始输出见 [日志](regressions/moments-header-backdrop.log) |
| moments-header-runtime | 229 | 通过，原始输出见 [日志](regressions/moments-header-runtime.log) |
| moments-layout-preferences | 73 | 通过，原始输出见 [日志](regressions/moments-layout-preferences.log) |
| moments-model | 115 | 通过，原始输出见 [日志](regressions/moments-model.log) |
| moments-native-media | 24 | 通过，原始输出见 [日志](regressions/moments-native-media.log) |
| moments-native-video | 31 | 通过，原始输出见 [日志](regressions/moments-native-video.log) |
| moments-playback | 79 | 通过，原始输出见 [日志](regressions/moments-playback.log) |
| moments-position | 147 | 通过，原始输出见 [日志](regressions/moments-position.log) |
| moments-runtime | 148 | 通过，原始输出见 [日志](regressions/moments-runtime.log) |

15 套回归全部通过，共 75,674 项检查，其中 73,467 项是卡片几何参数组合。验证覆盖卡片复用与模型投影、媒体入口、封面真实 UIKit 像素与运行时、页面进入和返回、分页、播放生命周期、小丑文本匹配与解析、会话缓存、偏好备份及 UIKit 显示。

同步维护三处旧测试依赖：位置模型夹具改为现有 `isValidForShow/getDisplayCity` 契约（旧断言在未清理的 beta05 上同样失败）；媒体测试补齐 ImageIO 链接；播放测试补齐封面清理接口替身。没有为通过旧测试改变生产行为。

两种方案均使用独立全新构建目录 `/tmp/wechat-2.7-0-{rootless,rootful}`。交付核验包括版本、安装路径、仅微信 Bundle 过滤、arm64／arm64e、iOS 15.0 最低目标、无本机依赖路径、SHA-1／SHA-256 CodeDirectory 代码页哈希、四份 dSYM UUID 以及独立 dylib 与包内文件的一致性。正式动态库同时检查本次删除的日志标记及测试 defaults 入口不存在。

本轮验证在主机和 Mac Catalyst UIKit 环境执行，未安装或重启原设备微信，未操作真实账号、聊天数据库或配置。真实微信视觉、消息收发及插件共存效果仍需在原设备复验。
