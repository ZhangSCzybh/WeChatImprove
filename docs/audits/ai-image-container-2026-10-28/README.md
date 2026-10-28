# JPEG/PNG 结束标记后附加数据兼容修复

用户安装一次下载恢复候选后，报告两张新图片仍提示「图片不完整、格式不支持或无法解码，未请求 AI」。本次在原 `main` 工作区继续定位，复现了实际 JPEG 附件被完整性判断误拒绝的问题，修复版本保持 `2.1-4`。

## 实际附件复现

照片附件为 391,469 字节的 1920×1080 JPEG。实际 EOI 位于偏移 391,443，其后还有 24 字节附加数据。ImageIO 源与索引均报告 Complete，缩略图解码成功；旧逻辑要求 EOI 必须处于整个文件最后，返回错误码 7。

修复后，生产 reader/encoder 在串行工作队列中处理两张附件的结果如下。原图只在本机读取，未保存到仓库或上传，也没有请求真实模型。

| 样本 | 修复前 | 修复后 | 编码后字节 | 修复后编码时间 |
| --- | --- | --- | ---: | ---: |
| 游戏截图 PNG，1223×649 | 成功 | 成功 | 221,030 | 0.0174 秒 |
| 照片 JPEG，1920×1080 | 错误码 7 | 成功 | 711,285 | 0.0184 秒 |

具体数据见 [attachment-reproduction.json](attachment-reproduction.json)。该 PNG 附件本身在修复前也通过，手机微信中对应的缓存字节仍未知；不能把附件副本的本地成功当作两张图片的真机回复已验收。

## 修改范围与性能

生产代码仅修改 `CSAIImagePreparer.m` 的 PNG/JPEG 完整性校验。JPEG 按段长度跳过元数据，在扫描区处理填充、字节转义、重启标记及渐进扫描，找到真实 EOI 后允许尾随数据；PNG 按 chunk 长度查找真实的零长度 IEND 并验证其固定 CRC。元数据负载中的伪结束标记不会被接受。仍保留 ImageIO 源/索引完成状态、实际解码、32 MiB 输入、1 亿像素、2048 最长边和 2 MiB 输出限制。

解析不复制文件、不扫描真实结束标记后的附加数据，不增加解码次数。JPEG 扫描区每最多 64 KiB 检查取消，PNG 每个 chunk 检查取消。保留现有串行后台工作队列、一次按需下载恢复、60/120 秒期限和原生消息身份校验；不新增后台定时器或轮询。

同时静态核对微信 8.0.78 的原生图片路径：现有 getter 已包含 Wxam/Vcodec2 转换，另加原生数据 getter 会共享同一转换缓存并增加同步读取，没有证据支持这样扩大修改。原生接口保持原样；目标哈希、调用关系、工具限制和有边界的汇编见 [native/README.md](native/README.md)。

## 核心验证与交付

图片专项 **326** 项通过，包括 14 个完整图片场景（普通/渐进 JPEG、填充、转义、重启、元数据伪结束标记、PNG，含/不含 24 字节附加数据），均不启动下载；9 个截断、伪结束、越界长度或非法 IEND 输入仍被拒绝。ASan/UBSan 编译运行同套 326 项无错误。manager **333** 项、coordinator 和 foundation 的 Store/Client 核心脚本也全部通过。没有更改其他生产模块，独立复审无阻塞问题。见 [tests.json](tests.json)。

Rootless/Rootful 完整隔离打包、包元数据、`arm64 arm64e`、dSYM UUID、符号归档校验全部通过。改动生产文件无编译告警；工程各方案仍有 12 条原有告警。1,238 个已存在的构建和安装包文件逐字节保持，构建期间 368 个源码输入未变化。证据：[构建脚本](build-candidate.py)、[构建环境](build-environment.json)、[输入哈希](source-sha256.json)、[Rootless 日志](build-rootless.log)、[Rootful 日志](build-rootful.log)、[产物核验](delivery-verification.json)、[包哈希](packages.json)。

独立修复包位于 `packages/2.1-4-image-format-fix/`：[Rootless](../../../packages/2.1-4-image-format-fix/com.wechat.improve_2.1-4_iphoneos-arm64.deb)、[Rootful](../../../packages/2.1-4-image-format-fix/com.wechat.improve_2.1-4_iphoneos-arm.deb)、[SHA-256](../../../packages/2.1-4-image-format-fix/SHA256SUMS.txt)。此前的发布包和 `image-recovery` 候选都保留；本次应使用 `image-format-fix` 目录中的包。

未安装设备或实测温度。真机请在安装并重开微信后，让对方把这两张图片作为新消息重发，先不点大图，再回归一张此前成功的截图、普通文字和现有群 @/免 @ 规则。旧消息不会因重新安装自动补回复。若仍失败，点击新失败记录查看固定阶段提示；附件副本不能替代对手机实际缓存的验证。
