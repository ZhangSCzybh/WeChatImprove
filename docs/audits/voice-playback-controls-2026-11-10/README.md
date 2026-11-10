# 2.4-2 语音气泡进度与拖动播放

日期：2026-11-10。工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。

## 最终需求与交互

已查看用户提供的两段录屏（9.875 秒、5.153 秒），分别展示原生倍速按钮和语音进度定位。视频元数据及抽帧仅在本地 `video/` 保留。随后用户明确要求保留现有倍速、只做进度条，并进一步指定“以气泡长度当进度条，滑动气泡来拖动播放”。本次最终范围据此收敛为：

- 只新增 **语音转发 → 播放控制 → 语音进度拖动** 一个开关，默认关闭，独立于聊天及收藏语音转发。
- 正在播放的普通聊天语音，以气泡内部的半透明填充表示已播比例；填充沿气泡长度变化、裁剪在圆角内部，没有圆点或独立滑杆。
- 在当前气泡上左右滑动，填充和时间提示随手指预览；松手提交一次微信原生定位并继续播放，取消不跳转。其他气泡不接管拖动。
- 点击、长按、原生倍速、纵向滚动及导航边缘返回继续交给原有界面处理。当前播放气泡的横向滑动优先用于进度定位，原生按钮不被该手势接管。
- 结束、暂停、切换语音、后台、关闭开关、切号及 cell 复用都会让旧拖动失效。开关纳入配置备份、恢复和恢复默认。

此前设计文档中的双开关、1.5 倍及独立滑杆方案已被上述最终需求取代；当前生产源码未增加或修改倍速能力。

## 原生接口与实现

使用用户原先提供的微信 `8.0.80.34` IPA，复用相同 SHA-256 的主程序进行静态核验。完整证据见 [native-playback/README.md](native-playback/README.md)。`MsgPlayingFacade.currentPlayTime` 是有符号 32 位毫秒，`seekToTime:` 接受无符号 32 位毫秒；总时长读取 `CMessageWrap.m_uiVoiceTime`，不误用实际表示气泡宽度的 `voiceTimeLength`。

`CSVoicePlaybackController` 经现有带 ABI 校验的服务桥访问当前账号的播放门面，保留微信服务代理的转发上下文。快照及定位提交都核对当前播放消息、`IsSameMsg:`、账号、开关和 generation。拖动令牌在进入原生调用前消费，避免原生已产生定位副作用后抛异常导致同一拖动被重复提交。控制器不新建播放器、不停止或重启播放、不设置速率、不改写原消息或音频文件。

SILK/OPUS 原生定位粒度为 100 ms；AMR/SPX 按整秒定位。定位继续使用原播放器和微信已有音频队列，实际缓冲延迟与最终听感由原生实现决定。

UI 使用被动填充视图和气泡区域横向 pan：填充不拦截触摸，图标、时长与原生按钮保持在其上方。接入现有 `CSMessageCellLifecycle`，在最终气泡合并、时间及其他展示布局后刷新，不改变原生 frame、字幕尺寸、气泡行高或紧密消息间距。只有一个播放控制器定时刷新，cell 使用弱引用登记，不为每条消息创建 timer。布局与交互细节见 [cell-ui-review.md](cell-ui-review.md)。

独立偏好模块避免进度开关变更使既有消息动作快照失效，保留收藏转发和联系人选择流程。

## 核心回归

| 验证 | 结果与范围 |
| --- | --- |
| 播放控制器 | 217 checks；直接链接生产 Controller、Native Adapter、Context、Policy 和 Preferences，验证整型毫秒、异常、消息及账号身份、后台/开关失效、一次提交、原生异常后拒绝重复令牌、无停止/重启/倍速副作用 |
| 气泡进度 UI | 71 checks；整气泡填充、横向 admission、按钮/边缘排除、预览、取消、复用、旧令牌、状态通知及清理 |
| 独立进度偏好 | 28 checks；默认关闭、刷新通知、配置删除/替换、原消息动作及两个转发开关不变 |
| 备份与重置 | registry 1448 assertions、reset 42 checks |
| 共享消息手势 | 370 checks；包含当前语音进度优先、其他消息动作保留及生命周期顺序 |
| 消息时间布局 | 142 checks |
| 气泡合并联合布局 | 既有媒体、模板、主题和接缝组合回归通过 |
| 收藏语音转发 | 220 checks |
| 消息动作核心 | 1372 checks |
| iPhoneOS SDK | 进度 UI 的 arm64、arm64e ARC / `-Wall -Wextra -Werror` 语法检查通过 |

各模块结果见 [controller-validation.json](controller-validation.json)、[overlay-validation.json](overlay-validation.json)、[preferences-validation.json](preferences-validation.json)，本次集成结果见 [validation.json](validation.json)。独立代码审查见 [final-code-review.json](final-code-review.json)。主机测试使用隔离偏好、临时文件及原生服务替身，没有发送真实微信消息。

## 版本与安装产物

包版本、插件内版本和内置版本说明统一为 **2.4-2**，旧版本说明完整保留，见 [version-verification.json](version-verification.json)。README 当前安装链接及文档索引同步更新。

- [Rootless 安装包](../../../packages/2.4-2-voice-progress/com.wechat.improve_2.4-2_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.4-2-voice-progress/com.wechat.improve_2.4-2_iphoneos-arm.deb)
- [重签用 dylib](../../../packages/2.4-2-voice-progress/WeChatImprove.dylib)
- [调试符号](../../../packages/2.4-2-voice-progress/com.wechat.improve_2.4-2_symbols.zip)
- [SHA256SUMS](../../../packages/2.4-2-voice-progress/SHA256SUMS)

`build.py` 复制冻结源码到临时目录，Rootless、Rootful 分别使用独立的 Theos 对象、staging 和 package 目录，不运行主目录 `make clean`。构建、双架构、符号及旧产物保护见 [build-result.json](build-result.json)，最终独立核验见 [final-verification.json](final-verification.json)。既有 2.4-1、fix1 及更早安装包均保留。

两套正式构建和最终独立核验均通过：包元数据为 `2.4-2`，两包均含 arm64／arm64e，四个切片均含新版本说明、进度开关键、原生定位接口与暂停清理 Hook。符号归档 CRC、四组 dSYM UUID、DWARF 哈希、独立 dylib 与 Rootful 包内文件及 SHA256SUMS 全部匹配。当前 409 个生产输入与冻结清单、实际构建快照完全一致；主 `.theos` 的 2,114 个文件、此前 packages 的 275 个文件逐项保持原哈希。每套构建只有 8 条原有弃用 API／链接器警告，`git diff --check` 通过。

本次未安装 iPhone。微信内实际触摸竞争、浅深色及自定义气泡的配色观感、不同格式的定位听感和缓冲延迟需要使用新包真机验收；主机与静态证据不代表这些体验已经在手机上验证。
