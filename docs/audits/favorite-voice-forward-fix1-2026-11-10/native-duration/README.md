# 收藏语音时长修复的原生接口证据

证据来自用户指定的 `com.tencent.xin_8.0.80.ipa`，Info.plist 确认版本为 **8.0.80 / 8.0.80.34**。本目录保存离线 Objective-C 元数据与有界反汇编；没有运行 iOS 原生解码器或执行原生发送。

- IPA SHA-256：`5cacb443b743793ccfe6026bc81c1f2678cb5cfdcd38584ad73ac7f19ecf4a5f`
- arm64 WeChat binary SHA-256：`1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`
- 镜像基址：`0x100000000`。下列 IMP、指令与 classref 地址均为该镜像的静态地址。
- 完整来源路径、方法编码、classref 解析及 category 扫描见 [metadata.json](metadata.json)。主程序共扫描 581 个 category，无解析失败，没有针对 AudioUtil/SilkAudioPlayer/OpusAudioPlayer 的 category。

## 根因与正确接口

该二进制的 AudioUtil 类方法中没有 `calcSilkVoiceTime:`。旧头文件与旧测试替身仍提供此方法，因而掩盖了 8.0.80 上的缺失。

`+[AudioUtil calcVoiceTime:VoiceFormat:]` 的编码是 `I24@0:8I16I20`，IMP 为 `0x1001834b4`。只有 format 0/1 采用长度公式。其他格式走 `0x1001834f4` 分支：通过 MMContext 取得 AudioSender 服务，然后在 `0x1001835a4` / `0x1001835a8` 调用 `currentAudioDuration`，返回全局录音器时长。它无法验证传入的收藏语音数据，即使偶然返回非零也不能采用。

8.0.80 提供的接口是 `+[AudioUtil calcVoiceTimeWithData:VoiceFormat:]`，编码 **`I28@0:8@16I24`**，IMP **`0x1001835d8`**。第一个显式参数为 NSData，第二个为 unsigned int 格式，返回 unsigned int 毫秒。

| 格式 | 该 NSData 接口的静态行为 | 修复后的处理 |
| --- | --- | --- |
| 0 / AMR | 对 NSData.length 执行长度公式 | 允许，但不视为字节解码，保留严格时长一致性要求 |
| 1 / SPEEX | 对 NSData.length 执行长度公式 | 同上 |
| 2 / MP3、3 / WAV | 返回预置的 0；不调用其他计算器 | 拒绝；不扩展编解码能力 |
| 4 / SILK | 调用 SilkAudioPlayer.calculateVoiceTime:，传入 NSData | 优先采用真实字节接口；0 或异常均失败 |
| 7 / OPUS | 调用 OpusAudioPlayer.calculateVoiceTime:，传入 NSData | 同上 |
| 其他值 | 返回 0 | 拒绝，既不调用现代方法也不调用全局录音器 |

格式分支在 `0x1001835fc`–`0x100183640`；format 4 的 classref `0x11ed140b0` 解析为 SilkAudioPlayer，format 7 的 classref `0x11ed140b8` 解析为 OpusAudioPlayer。两条路线在 `0x10018368c` 使用 `calculateVoiceTime:`，`0x100183690` 将保存的 NSData 置于 x2。

## 毫秒单位

- `+[SilkAudioPlayer calculateVoiceTime:]`：编码 **`I24@0:8@16`**，IMP **`0x105cf5e6c`**。在 `0x105cf5ea8` / `0x105cf5ee8` 读取 NSData.bytes / length。原生帧处理循环于 `0x105cf5f64` 每轮累加 `0x14`（20），最后 `0x105cf5fdc` 返回累计值，符合 SILK 每帧 20 毫秒。初始解析得不到有效 sample rate 时返回 0，并记录 `invalid sampleRate`。
- `+[OpusAudioPlayer calculateVoiceTime:]`：编码 **`I24@0:8@16`**，IMP **`0x105593c34`**。按 PCM 字节、sample rate、channels 计算秒数；`0x105593e64` 装入浮点 1000（`0x447a0000`），`0x105593e6c` 相乘，`0x105593e70` 转为 unsigned int。`0x105593e8c` 引用的日志明确写有 `voiceTime=%u ms`。

四份 `.asm` 均完整保留单个方法的指令范围，附原有 selector/常数注释，去除了一条无法正确解码的日志字符串注释。方法范围如下，可使用 `xcrun llvm-objdump --disassemble --start-address=START --stop-address=STOP BINARY` 重现；STOP 为末尾 ret 后的地址。

| 文件 | START | STOP |
| --- | --- | --- |
| AudioUtil-calcVoiceTime_VoiceFormat_.asm | 0x1001834b4 | 0x1001835d8 |
| AudioUtil-calcVoiceTimeWithData_VoiceFormat_.asm | 0x1001835d8 | 0x1001836b8 |
| SilkAudioPlayer-calculateVoiceTime_.asm | 0x105cf5e6c | 0x105cf5ff8 |
| OpusAudioPlayer-calculateVoiceTime_.asm | 0x105593c34 | 0x105593f30 |

## 修复与回归范围

`Controllers/CSMessageMediaProvider.m` 优先调用经过 ABI 验证的现代 NSData 接口，仅对 0/1/4/7 开放。现代接口返回 0 或抛异常时直接失败。缺失现代接口时，仅兼容 ABI 正确的旧版 calcSilkVoiceTime:/OpusAudioPlayer 字节接口；长度公式严格限制为 0/1。时长归一仍要求声明长度与实际数据一致且存在真实字节解码，只创建新的发送资源，不改收藏元数据或源文件。

`Tests/FavoriteVoiceMediaTests.m` 的默认替身改为实际 8.0.80 形状，明确不存在旧 calcSilkVoiceTime:。测试覆盖现代 NSData 参数路由、毫秒、0/异常不回退、错误返回/参数 ABI 不调用、缺失解码器时不能使用非零录音器、2/3/未知格式拒绝、匹配 size/MD5 的损坏或截断仍由解码失败拒绝、归一不修改源数据、下载去重与取消。

测试结果及执行范围见 [verification.json](verification.json)。主机上的合成解码器替身验证路由和校验策略，不构成真实音频编解码器的执行验证。
