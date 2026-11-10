# 8.0.80 语音时长与转发“下一步”修复

日期：2026-11-10。工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。本次延续已授权的收藏语音转发实现，只处理独立语音收藏；聊天记录收藏中的嵌套语音、笔记录音不接入。

用户真机反馈：收藏详情右上角 **发送给朋友** 提示“无法读取原语音时长”；收藏和普通聊天长按语音转发，选人后点击 **下一步** 没有反应。本次分别复现旧代码的两个兼容性错误，再针对实际二进制接口和回调时序修复。

## 时长校验

初版使用旧 `AudioUtil.calcSilkVoiceTime:`，本次 IPA 中没有此方法。随后退回的 `calcVoiceTime:VoiceFormat:` 对 SILK 等非 0/1 格式读取 `AudioSender.currentAudioDuration`，这是录音器的当前状态，不能代表传入的收藏音频；返回零时便出现用户报告的提示。

8.0.80 的实际数据接口是 `+[AudioUtil calcVoiceTimeWithData:VoiceFormat:]`，ABI `I28@0:8@16I24`，返回毫秒。格式 4/7 分别调用 `SilkAudioPlayer`、`OpusAudioPlayer` 的字节解析器；SILK 每帧累加 20 毫秒，OPUS 按 1000 倍转换并明确记录 `ms`。格式 0/1 使用原生长度公式，2/3 及其他不支持格式返回零。

共享 validator 现在优先调用实际数据接口并严格检查 ABI。零结果和异常直接失败；旧版本兼容路线也只接受原来有据可查的字节解码器。长度接口仅用于 0/1，禁止用录音器状态代替 SILK/OPUS 时长。文件大小、MD5、格式、完整性、账号和源身份检查继续执行。解析时长的归一化仅作用于新的发送资源，不改写原收藏或原聊天消息。

证据和版本哈希见 [native-duration/README.md](native-duration/README.md)。

## 选人后的“下一步”

既有联系人保护 Hook 同时拦截 `SessionSelectController.onMultiDone` 和 `onMultiDoneInPageSheetMode`。旧 Hook 先读取 `m_selectedContacts`，必须是数组才调用微信原方法。但 8.0.80 默认创建的选择器在此时该字段仍为 nil；微信需要先进入原生 `endMultiSelect`，才会把当前选择复制进去。因此普通合法选择也会被旧 Hook 静默吞掉，这会影响收藏和普通聊天共用的选人页面。

当前勾选列表的真实来源是 `m_selectView.m_dicMultiSelect.allValuesInOrder`。新增 `CSCFCurrentForwardRecipients` 读取并复制该有序快照，交给既有联系人保护与账号票据校验；允许后只调用一次微信原方法，由微信更新结果数组并继续确认界面。读取辅助函数不改写选择，也不提前发送消息。

`OrderedDictionary` 实际继承 `NSMutableDictionary`，因此 `allValuesInOrder` 按准确对象 getter ABI 调用，避免把方法名当成字典键读取。隐藏联系人、重新锁定、配置/账号/世代改变仍会阻止过期操作。

证据见 [native-next/README.md](native-next/README.md)。`getToContacts` 仍是 NSArray，缺少 getter 也不是此次阻断原因；生产读取桥已有对象 ivar 回退。

## 收藏列表入参

补齐原生列表支持的已知 `FavDataItemWrap` 形式：只接受父项为独立语音、唯一 voice field，且 wrapper 的 `dataItem` 为 nil（整项 wrapper）或指向该唯一字段。拒绝任意同形对象、字段不匹配、聊天记录和笔记。普通语音列表经本次检查使用原始 FavoritesItem；尚无证据证明用户本次恰好走了 wrapper 分支，因此此补充不作为“下一步”故障的根因。

## 回归与构建

新时长测试使用与 8.0.80 一致的现代接口形状；将上轮候选的旧 validator 放进该测试，会失败。新的选人测试提取实际全局 Hook、读取桥和票据逻辑，模拟原生在 `endMultiSelect` 之后才填充 `m_selectedContacts`；旧 Hook 在合法选择、nil 结果数组的场景失败，修复后通过。两个负向对照结果分别保存在 `duration-baseline.json` 和 `forward-selection-baseline.log`。

最终主机验证结果见 `validation.json`，覆盖收藏媒体、收藏转发与列表 Hook、选人完成边界、现有消息动作和密友保护回归。测试使用隔离偏好、临时文件和原生服务替身，不发送真实消息。

7 组最终回归全部通过：消息核心 1,372 次检查、现有动作执行 2,573、收藏媒体 687、收藏转发与列表入口 220、选人完成边界 82、密友核心 455；密友联系人与搜索/资料操作回归也通过。新增字典子类用例验证 `allValuesInOrder` 方法与同名字典键冲突时仍读取真实有序选择。`git diff --check` 通过。

`build.py` 使用当前源码的临时快照和独立 Theos 输出构建 Rootless、Rootful 候选包。包版本继续保持 `2.3-9`，fix1 在本地 `packages/favorite-voice-forward-8.0.80-fix1-2026-11-10/` 独立保留，不覆盖初版或更早的安装包。构建、arm64/arm64e、符号、dSYM UUID、输入哈希及原有文件保护结果见 `build-result.json`。

两套构建及包内 `arm64`、`arm64e` 核验通过，当前 402 个生产输入与构建快照逐文件一致。已验证现代时长接口、两种 Next、实时有序选择来源和列表归一化标记进入四个切片；四组 dSYM UUID、符号归档 CRC、独立 dylib 与 Rootful 包内文件均核对通过。主 `.theos` 的 2,114 个文件、既有 packages 的 265 个文件（含初版候选）、版本与原有发布说明保持原哈希。独立最终核验见 `acceptance.json`，额外包/符号细节见 `final-verification.json`。

GitHub 提供包含本次修复的 [2.4-1 正式产物](../../../packages/2.4-1-favorite-voice-forward/)及当前 [2.4-2 正式产物](../../../packages/2.4-2-voice-progress/)。fix1 候选包、dylib 和符号仅在本地保留，用于历史回归对照。

本次未安装到手机，也未执行真实微信发送。仍需使用 fix1 产物在 8.0.80 真机复测详情菜单、本地/云端收藏、普通聊天和收藏的选人下一步、取消、接收端播放以及原收藏再次播放。

上述设备边界描述本轮修复完成时的状态。用户随后已真机确认“现在可以了”，修复正式发布为 2.4-1，见 [发布记录](../release-2.4-1-favorite-voice-forward/README.md)；后续版本继续包含这些修复。
