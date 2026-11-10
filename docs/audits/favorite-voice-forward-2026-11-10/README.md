# 收藏语音转发实现与验证

实现日期：2026-11-10。工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`。

## 使用与范围

在插件 **语音转发** 设置中新增 **收藏语音转发**，默认关闭，与现有聊天语音转发独立，并纳入配置备份、恢复和恢复默认。开启后，在收藏中打开一条语音，选择 **右上角菜单 → 发送给朋友**，使用微信原生联系人选择、确认和取消界面。未确认目标之前不插入消息，不启动上传。

仅接管 `FavoritesItem.type == 3`、唯一数据项 `FavoritesItemDataField.dataType == 3` 且未在录制中的独立语音收藏。聊天记录收藏中的嵌套语音、笔记录音、其他收藏类型和多条收藏不由此功能处理。未修改微信通用 `canBeForward` 或 `toMsgWrap` 判断。

## 适配证据

- 用户提供的 IPA：`/Users/zhangshichao/Downloads/Telegram Desktop/com.tencent.xin_8.0.80.ipa`。
- CFBundleShortVersionString：`8.0.80`；CFBundleVersion：`8.0.80.34`。
- IPA SHA-256：`5cacb443b743793ccfe6026bc81c1f2678cb5cfdcd38584ad73ac7f19ecf4a5f`。
- 主二进制 SHA-256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。
- 分析报告和原生证据保存在 `/Users/zhangshichao/.codex/visualizations/2026/11/10/01a1c4c1-7e80-7aa0-9f5e-dcf3e93648fb/favorite-voice-8.0.80/`。本次依据该 IPA，未沿用其他二进制的地址作为证明。

`FavVoiceDetaiViewController` 继承的 `m_favItem` 提供当前收藏。仅在此详情页构造 `FavActionSheet` 时增加“发送给朋友”位，新增原生回调 `onFavActionSheetSelectedForwardToUser:`。收藏列表 `MyFavoritesViewController.forwardData:` 仅对单条独立语音接入相同流程，其他输入保留原流程。

收藏语音时长按原生毫秒字段传递，格式按 `amr/speex/mp3/wav/silk → 0/1/2/3/4` 映射，未知格式失败并提示。未把收藏类型 3 当作聊天消息类型 34，也未伪造聊天消息上下文。

## 准备与发送

独立 Context 捕获账号、账号世代、收藏 ID、数据 ID/MD5 和音频元数据。媒体提供器通过 `FavoritesMgr` 重新获取当前收藏；所有原生模型访问在主线程完成。文件读取在串行 IO 队列执行，使用有界读取、`O_NOFOLLOW`、文件身份及时间检查，最大 16 MiB，并核对声明大小、MD5、原生音频校验结果和格式。原文件不会被改写或删除。

本地文件缺失时，调用高层 `startDownloadFavoritesItem:IsPriority:`；原生完成回调先执行，随后重新读取并验证文件。相同资源合并等待，支持取消和超时。成功回调之后文件仍缺失、下载错误、元数据或账号变化均不会发送。

媒体准备完成后才打开 `ForwardMessageMgr` 的原生选择界面。预览语音只用于选人，不插入、不上传。到原生最终分发边界时固定并去重收件人，再为每个收件人创建全新的语音消息，复用现有 `AddLocalMsg` 和具体 voice uploader 路线。没有调用会删除原消息的 `AudioSender.ResendVoiceMsg`。

操作账本阻止相同操作/收件人重复提交。取消、开关关闭、账号切换（含同账号重新登录）、进入后台或隐私保护变化使待处理操作失效。每个目标发送前重新核对收藏身份和音频元数据，插入后、上传前再次核对账号和操作有效性。已交给微信的消息由聊天中的原生状态呈现；插件不会把界面完成回调当作送达成功。

原生控制器清理后保留与本次 source 绑定的迟到回调保护；该控制器随后被普通消息复用时，普通 source 会继续执行微信原流程，不受收藏绑定影响。

## 主机验证

测试使用 macOS SDK、隔离的偏好域、临时音频文件和原生接口替身，不访问微信实际账号数据，不发送真实消息。测试命令、检查数及结果记录在 `validation.json` 中。

最终 7 组全部通过，共 6,172 次检查：消息核心 1,372、现有动作执行 2,578、收藏媒体 514、收藏转发 173、备份登记 1,436、重置 33、备份兼容 66。`git diff --check` 通过。

- `verify-message-actions-core.sh`：消息策略、偏好快照及独立开关。
- `verify-message-actions-execution.sh`：现有聊天转发、动作、媒体和原生清理回归。
- `verify-favorite-voice-media.sh`：独立语音类型、音频读取/完整性、原生下载、取消、身份及账号边界。
- `verify-favorite-voice-forward.sh`：真实发送适配器及从当前 Hook 源码提取的绑定、确认、发送、取消、清理和成功提示方法；覆盖重复目标、迟到回调、同账号重新登录、源变化及普通消息复用。
- `verify-backup-registry.sh`、`verify-backup-reset.sh`、`verify-backup-compatibility.sh`：新配置登记及已有备份/重置兼容性。

## 构建与设备边界

`build.py` 将当前生产源码复制到临时目录，用独立 Theos 输出构建 Rootless 和 Rootful 包。仓库版本保留 `2.3-9`，本目录对应新增功能的候选构建；不代表新的正式发布。构建与包内双架构、符号、调试 UUID 及历史产物保护结果见 `build-result.json`。

两套候选构建最终验证通过，每套均包含 `arm64`、`arm64e`。已核对包路径、收藏语音与原有聊天转发符号、全部 dSYM UUID，以及当前源码与构建快照的逐文件 SHA-256。主 `.theos` 的 2,114 个文件、旧安装包目录的 260 个文件、原有 ReleaseNotes 改动、版本头和 control 均与构建前一致。每套构建的 8 条警告均来自已有代码的弃用 API 或已有链接选项，本次新增代码无编译警告。

首次核验曾因 Theos 把 OpenStep plist 转为二进制 plist 而触发字节哈希断言；已改为核对解析后语义，并复用同一次成功构建完成验证，未重复编译或修改生产源码。原失败记录保留在对应 `build-attempt-*` 目录。

初版候选产物仅在本地 `packages/favorite-voice-forward-8.0.80-candidate-2026-11-10/` 保留，用于历史回归对照。GitHub 提供包含后续修复的 [2.4-1 正式产物](../../../packages/2.4-1-favorite-voice-forward/)及当前 [2.4-2 正式产物](../../../packages/2.4-2-voice-progress/)。

未安装到手机，也未发送真实微信消息。仍需在微信 8.0.80 真机验证：本地与云端语音收藏、选人确认及取消、单人/多人目标、接收端播放、原收藏再次播放，以及与现有聊天语音转发的组合使用。主机测试和编译通过不等于这些真机流程已经验收。

## 后续真机反馈

用户随后报告详情菜单“无法读取原语音时长”，以及普通聊天、收藏长按转发选人后“下一步”无反应。初版主机替身未覆盖 8.0.80 的实际音频数据时长接口，也未执行联系人选择页面全局安装的完成 Hook。这两处问题的二进制证据和旧实现失败回归见 [fix1 修复记录](../favorite-voice-forward-fix1-2026-11-10/README.md)。用户之后已确认修复可用，见 [2.4-1 正式发布记录](../release-2.4-1-favorite-voice-forward/README.md)；当前安装包使用上方 2.4-2 正式产物。
