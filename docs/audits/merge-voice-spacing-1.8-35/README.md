# 1.8-35 普通语音合并间距修复

用户反馈合并消息中的语音上下间距与其他消息不一致，随后明确为**普通语音、未展开转文字**。本轮延续标准组内 **2pt 逻辑点**、首次发布行高/位移后不因停止滚动二次收紧的要求。

## 原因与原生证据

微信 8.0.78.34 的发送方声波图标在普通未播放状态也使用水平镜像。`VoiceMessageCellView initPlayingImageView` 在发送分支执行 `CGAffineTransformMakeScale(-1, 1)`，随后给 `m_playingImageView` 设置 transform；是否启动播放动画是之后的独立分支。

1.8-34 的合并适配器在验证可见子视图时遇到任何非单位变换就拒绝紧密布局。该正常镜像因此触发 `geometryRejected`，恢复较大的原生行高和位移。这同时影响语音上方、下方的接缝；按照已有稳定回退机制，后续布局不会自动再收紧。

证据沿用此前已选定的 WeChat 8.0.78 build 8.0.78.34，重新核对二进制 SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`，UUID `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE`。复用已有 Objective-C 元数据，新增范围受限的反汇编，没有运行微信或重新等待此前超时的分析请求。

- [initPlayingImageView](native/VoiceMessageCellView--initPlayingImageView.asm)：`0x106277de8` 查询发送方向；`0x106277ed0..0x106277ed8` 构造水平镜像；`0x106277fdc..0x106277fec` 给声波控件设置变换；`0x106278020` 后才查询 `isPlaying`。
- [调用链](native/voice-transform-call-chain.txt)：`0x107c272b4 → 0x10f85b5bc → 0x117475ee8 → 0x1183208a8` 对应导入符号 `CGAffineTransformMakeScale`，与参数 `-1, 1` 一致。
- [updateVoiceLength](native/VoiceMessageCellView--updateVoiceLength.asm)：声波按气泡高度垂直居中。水平镜像没有改变垂直占用。
- [身份与地址索引](native/evidence.json)；[类/成员元数据](native/metadata.json)。生产代码按 ivar 名称查询，不硬编码偏移。

这些是静态代码证据，不等同于观察了用户设备执行。本轮确定性复现证明该原生镜像足以触发旧代码回退；不能据此声称所有语音布局异常都只有这一原因。

## 修复范围与开销

生产逻辑仅修改 `Controllers/CSMessageMergeAdapter.m`：已知 `VoiceMessageViewModel` 的 `m_playingImageView`，当变换精确等于水平镜像 `{-1,0,0,1,0,0}` 时，允许继续进行实际占位检查。

没有跳过声波控件或其真实边界，没有改变图标方向、位置、播放、未读状态。图标越界仍扩展安全空间；其他控件的变换、缩放、旋转、平移以及转文字附加内容继续沿用安全处理。Cell、容器、背景与头像的变换检查不变。

新增判断只在已发现非单位变换的子视图上执行，普通文本和单位变换视图不进入新分支。没有新增遍历、定时器、异步任务、图片解码、模板生成或表格刷新。沿用 1.8-34 的图片生命周期保护、气泡样式/颜色与首次稳定布局；2pt 不按屏幕倍率折算。

## 复现与回归

先添加带声波镜像的夹具，生产代码尚未修改时，`verify-message-merge.sh` 失败于首次渲染后的行高不再等于首次计划，见 [voice-mirror-before-fix.log](voice-mirror-before-fix.log)。首次夹具编译因将新建 window 直接赋给 weak 属性而失败的记录另存为 `fixture-compile-first-attempt.log`，不作为问题复现证据。

修复后重点检查：

- 正常水平镜像、单位变换、隐藏图标均保持紧密行高；未知缩放、旋转、平移、错误控件身份、错误模型类型仍安全回退。
- 已知镜像图标真实超出气泡范围时仍扩展空间，并保持回退稳定。
- 转文字标志为真时仍保留内容占用。
- 联合回归添加声波、时长、未读控件，覆盖语音在首条/中间/末条、连续语音、文本和引用混排；包含群聊/私聊、收发双方、首末头像、37pt/38pt、明暗主题、样式开关与 1×/2×/3×。
- 重复拖动、减速、停止、未读变已读、图片完成和按压态切换后，标准接缝为 2pt；群昵称等实际附加内容保留原有占用。无二次收紧、无无效行事务、稳定期模板扫描不增长。

联合验证使用真实生产适配器和主机 UIKit/微信替身。夹具中的纯水平镜像转换完整 bounds 后占位矩形不变；替身不模拟原生播放帧或真实 UIKit 动画，不能宣称完成播放流畅度、真机像素、帧率或温升验证。

本轮先跑合并和联合两项核心入口；随后复用这两项同轮通过结果，执行其余 30 项入口。完整结果保存在 `regression-results.json` 和 `regression/`，不重复消耗已经通过的核心回归。

最终 **32/32** 个回归入口通过。合并策略/导航 235,148 项检查，合并适配器/导航生命周期 17,525 项；气泡策略/绘制/所有权 36,979 项，气泡适配器生命周期 2,547 项。联合回归通过 **2,688 组场景、695,918 项检查**。

## 工作区与交付校验

以本轮开始的 1.8-34 工作区为基线，保存 345 个源码/构建/测试输入副本和 44,000 个既有文件哈希。没有重置已有未提交工作，也不修改旧包和旧分析记录。本轮源码、测试、版本文档合计修改七个文件，具体见 `changes.patch`。

构建从用户原 checkout 执行，Theos 输出与临时 deb 使用独立目录，未执行 `make clean`。`run-build.py` 保存命令、源清单和日志；`verify-delivery.py` 核对版本、Rootless、arm64/arm64e、最低编译目标 iOS 15.0、包内/构建/暂存 dylib、dSYM UUID、注入过滤器、测试符号排除、改动范围及旧产物哈希。气泡适配器、气泡钩子与合并策略文件均要求与 1.8-34 基线完全相同。

最终结果与产物哈希见 [verification.json](verification.json)。本轮未连接设备、未安装到设备；设备验收聚焦普通语音在合并首/中/末条、连续语音及与文本/引用混排的上下接缝，以及快速滑动后停止的稳定性。

Rootless arm64/arm64e 构建成功，本次改动无编译警告；日志仅包含既有弃用 API 和过时链接参数警告。包内、暂存、构建 dylib 一致，源码匹配构建清单，1,507 个既有 packages/docs 产物哈希全部保持。

- deb：`packages/com.wechat.improve_1.8-35_iphoneos-arm64.deb`，837,370 bytes，SHA256 `0f24cd9cafe11a8ec3f4e1b64506dd94407aef6d53e8b02e049078f76fc3f97c`。
- dSYM：`packages/WeChatImprove-1.8-35-dSYMs.zip`，3,521,167 bytes，SHA256 `5ef39ac9c4276c4fa32fd5271d262c364b6b65d5e87fdab64c299ae63011a346`。
- arm64 UUID `3E2CCF3E-D7B8-31D9-9535-B9F78D07D736`；arm64e UUID `4CC2B5A3-DDF4-3667-B29E-937233A250EE`。
