# 微信原生图片转换静态核对

目标为微信 8.0.78 的 arm64 解密主程序 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。只读取程序文件，没有运行微信、读取用户消息、调用转换接口或联网。`manifest.json` 保存了目标身份、函数范围和各汇编文件的摘要。可用 `extract-disassembly.py` 对同一目标重新生成有边界的汇编证据。

本轮先由 REA `open_binary` 核对目标身份。Ghidra 12.1.4 在导入该约 567 MB 程序时持续消耗资源并产生 Objective-C 类型冲突日志，尚未返回函数 dossier；因此停止本次创建的独立 Ghidra 子进程并成功 `close_binary`。以下证据来自 `xcrun llvm-objdump` 和只读 Mach-O 元数据解码，不应标成 REA 函数 Evidence 或反编译源代码。

已观察的调用关系：

| 方法及入口 | 观察到的行为 |
| --- | --- |
| `CMessageWrap +getJpgPathOfMsgHdOrMiddleImg:`，`0x104ba84f4` | 按消息状态优先取得 HD 路径，否则调用 `getJpgPathOfMsgMiddleImg:`。 |
| `CMessageWrap +getJpgPathOfMsgMiddleImg:`，`0x104ba9c70` | 先经 `MMContext` 获取 `WxamImageManager`，调用 `getJpgPathByWxam:`；其后还有 Vcodec2 路径、`VCODEC2ImageCom decodeVCODEC2ImageFile:toUIImage:toJPGQuality:`、JPEG 编码并写入缓存的分支。当前 AI 的路径 getter 已包含这些原生转换步骤。 |
| `CMessageWrap +getMsgHdOrMiddleImgJpgData:`，`0x104baaab0` | 只是将 `canUseHeif` 设为 NO 后转调 `getMsgHdOrMiddleImgData:canUseHeif:`。 |
| `CMessageWrap +getMsgHdOrMiddleImgData:canUseHeif:`，`0x104baaad0` | 优先 HD 数据；不允许 HEIF 时检查图像类型并尝试 `convertHeifDataToJpg:`，否则进入中图数据路径。 |
| `CMessageWrap +getMsgMiddleImgData:canUseHeif:`，`0x104bab064` | 经 `WxamImageManager parseWxamData:` 取得数据，随后有直接读文件、Vcodec2 解码，以及 `m_dtImg` 兜底分支。 |
| `WxamImageManager -getJpgPathByWxam:`，`0x10a99cc88` | 原始 Wxam 文件存在时，若转换缓存 `FileExist:` 成功，直接返回缓存路径；否则同步调用 `WxamImageConvert decodeWxAmToPic:wxamPath:scene:`。此方法不验证已存在缓存能否解码。 |
| `WxamImageManager -parseWxamData:`，`0x10a99c6e4` | 使用相同的 `tempPathForWxamDecode:` 缓存；若已存在文件能读出非 nil `NSData`，直接返回。否则读原始 Wxam、调用 `decodeWxAMToJpg:scene:`，并写回缓存。 |

这些已观察的方法体没有将转换自动派发到工作队列的步骤。静态代码不能证明可在任意线程调用；`CMessageWrap` 和上下文服务还涉及可变原生对象。直接新增 `getMsgHdOrMiddleImgJpgData:` 调用既会引入同步读图／转换开销，也仍使用同一个转换缓存，不能作为已损坏缓存的可靠绕过路径。

因此本轮保留原生取图接口，不据此扩大转换逻辑。有效 JPEG 尾部携带额外数据被严格尾标校验拒绝，是附件实际字节已能复现的独立问题；本目录的静态检查不能证明手机上另一张图片的存储格式，也不能证明其失败必然由 Wxam、Vcodec2 或 HEIF 引起。
