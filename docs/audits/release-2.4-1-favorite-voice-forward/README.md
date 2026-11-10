# 2.4-1 收藏语音转发发布记录

发布日期：2026-11-10。项目目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。本次根据用户“现在可以了。打包2.4-1版本。更新版本说明”的确认，将已验证可用的语音修复正式发布为 **2.4-1**。

## 版本说明

- 新增“语音转发 → 收藏语音转发”独立开关，默认关闭。开启后，打开单条语音收藏，通过右上角“发送给朋友”选择联系人并确认发送。
- 修复微信 8.0.80 收藏语音提示“无法读取原语音时长”。
- 修复普通聊天、收藏语音转发选人后点击“下一步”无响应。
- 仅支持独立的语音收藏；聊天记录收藏中的嵌套语音、笔记录音等不接入。收藏语音开关独立于聊天语音转发，并支持配置备份、恢复与恢复默认。

插件内 **关于 → 版本信息** 已加入上述说明；`control`、`kPluginVersionString` 和当前说明条目统一为 `2.4-1`。README 的当前版本、安装链接、使用说明和包核验示例，以及文档索引的当前发布入口同步更新。全部旧版本说明及发布前已有的本地修改保留。

## 功能来源与验证

用户此前反馈的两个故障已在 [fix1 修复记录](../favorite-voice-forward-fix1-2026-11-10/README.md) 中定位并修复。用户本次确认这些语音流程可用，确认范围和原话记录在 [device-confirmation.json](device-confirmation.json)。本发布任务未再次安装手机或发送真实微信消息。

402 个生产输入与已确认的 fix1 构建清单逐文件核对，仅修改 `control`、`Headers/CSUserInfoHelper.h` 和 `Controllers/CSReleaseNotesViewController.m` 三个版本相关文件，其余 399 个输入完全相同，见 [source-provenance.json](source-provenance.json) 和 [frozen-production-inputs.json](frozen-production-inputs.json)。本轮发布改动见 [release-only.patch](release-only.patch)；发布前五个文档/版本文件保存在 `before/`。

收藏媒体、收藏转发、选人完成边界、现有消息操作、密友核心及联系人保护的 7 组回归此前均已通过，详见 [fix1 validation.json](../favorite-voice-forward-fix1-2026-11-10/validation.json)。本轮功能源码没有改变，验证集中于版本一致性、旧说明保留、README 链接、两种打包方案、包内双架构与符号。

## 安装产物

本次正式产物位于 [packages/2.4-1-favorite-voice-forward](../../../packages/2.4-1-favorite-voice-forward/)。

- [Rootless 安装包](../../../packages/2.4-1-favorite-voice-forward/com.wechat.improve_2.4-1_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.4-1-favorite-voice-forward/com.wechat.improve_2.4-1_iphoneos-arm.deb)
- [重签用 WeChatImprove.dylib](../../../packages/2.4-1-favorite-voice-forward/WeChatImprove.dylib)
- [调试符号](../../../packages/2.4-1-favorite-voice-forward/com.wechat.improve_2.4-1_symbols.zip)
- [SHA256SUMS](../../../packages/2.4-1-favorite-voice-forward/SHA256SUMS)

`build.py` 从冻结源码复制到临时目录，为 Rootless、Rootful 分别使用独立 Theos 对象、staging 和 package 目录；不运行主目录 `make clean`，不覆盖旧包或主 `.theos`。构建结果见 [build-result.json](build-result.json)，文档审查见 [documentation-review.json](documentation-review.json)，独立交付核验见 [final-verification.json](final-verification.json)。

两套正式构建均通过，Rootless 用时 23.71 秒，Rootful 用时 23.70 秒。独立解包确认 `Version: 2.4-1`、正确安装路径及原注入过滤器，两包均包含 arm64／arm64e；四个切片均含新版版本号和三条更新说明标题。四组 dSYM UUID、ZIP CRC、四份 DWARF 哈希及 SHA256SUMS 均核对通过，重签用 dylib 与 Rootful 包内动态库一致。版本及旧说明保留核验见 [version-verification.json](version-verification.json)。每套构建沿用 8 条既有弃用 API／链接器警告，本次语音功能代码没有新增警告。

最终确认构建快照与当前 402 个生产输入一致，主 `.theos` 的 2,114 个文件和此前 packages 的 270 个文件逐项保持原哈希，包括初版、fix1 及更早安装包。所有本次发布链接可解析，`git diff --check` 通过。
