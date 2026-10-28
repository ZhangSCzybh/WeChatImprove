# AI 百炼联网与图片接入记录（2026-10-28）

已在原工作目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` 完成接入和两套隔离发布构建，版本保持当前 `2.1-3`。基线 HEAD 为 `a445c24adee5653ce64f20fdbec3052b894a2067`；开始时已有源码与构建修改，本次未清理或覆盖这些工作，`before/` 保存了补充快照。

## 交付与使用

- [Rootless 包](../../../packages/2.1-3-ai-multimodal-web/com.wechat.improve_2.1-3_iphoneos-arm64.deb)：`iphoneos-arm64`，安装路径 `var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib`。
- [Rootful 包](../../../packages/2.1-3-ai-multimodal-web/com.wechat.improve_2.1-3_iphoneos-arm.deb)：`iphoneos-arm`，安装路径 `Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib`。
- [匹配符号](../../../packages/2.1-3-ai-multimodal-web/com.wechat.improve_2.1-3_symbols.zip)；[SHA256SUMS](../../../packages/2.1-3-ai-multimodal-web/SHA256SUMS)。

两包均含 `arm64 arm64e`；每个架构的动态库与 dSYM UUID 均匹配。包内已检查百炼参数、SSE、图片组件与原有后台同步特征；`delivery-verification.json` 与 `packages.json` 保存结果和哈希。请选择与现有设备注入环境匹配的包。本次没有安装或切换用户设备环境。

在「AI 自动回复 → 模型连接」选择「阿里云百炼」，保留相同地域/业务空间的完整 Chat Completions 地址，模型填写 `qwen3.8-flash`；开启图片，联网选「按需联网」，思考保持关闭，再测试连接。开启图片后的测试发送固定蓝色 PNG 与短问题，不访问微信图片或发微信消息；成功只说明接口接受当前样例且返回文本，不能证明模型识别准确或该次实际执行搜索。

私聊和免 @ 群可直接发图；其他群先发图，再由同一人于 30 秒内真实 @ 当前账号并提问。不解析引用消息或图集。更换百炼模型需按其文档调整能力并重新测试；换其他兼容服务选择「通用兼容接口」，不发送百炼专有字段。完整说明见 [功能文档](../../features/ai-auto-reply.md)。

## 实现与性能边界

1. **兼容和隔离。** optional `provider/imageEnabled/searchMode/thinkingEnabled`，默认 generic/NO/off/NO。缺字段及显式默认保留旧连接指纹；14 组有效能力组合指纹互异。改变连接/能力会先撤销测试归属再取消，清验证并取消原批次。备份只新增非敏感配置，旧格式可恢复，原账号及回滚保护保留。
2. **传输。** 完整 endpoint 保持不变。百炼 CC `stream:true`，`enable_search` 对应 off/auto/always，搜索策略 `turbo`，always 增加 `forced_search:true`；`enable_thinking` 默认 false。通用接口保留 `stream:false`。SSE 线性扫描，支持 UTF-8/CRLF 任意分片，只拼接最终 content，不向微信输出 reasoning/tool 数据，也不推测来源链接；成功 EOF 且合法终止后仅完成一次。请求最多 4 MiB、响应最多 1 MiB、行 128 KiB、事件 256 KiB、正文 4000 UTF-16 单元。没有新增工具执行循环、重试或定时任务。
3. **按需图像。** 持久去重领取后才进入准备，与网络共用最多两个活动会话、60 秒活动时限及 120 秒总时限。群暂存最多 10 个最新图引用，每条身份历史最多 100 个字符串，30 秒过期；同秒旧图 alias 回调不能覆盖新图，重复回调不续期。未触发前不读盘、不下载、不编码。
4. **有界工作。** 图像读盘、缩图、编码在单串行队列；原图最多 32 MiB/1 亿像素，输出最长边 2048/文件 2 MiB。缺图只启动一次现有原生静默下载，默认 20 秒、上限 30 秒，无媒体扫描或下载轮询；仅解绑自己的 delegate，不停止共享下载器。文件 nonblocking open 后验证 regular file，拒绝 FIFO/符号链接/目录。JSON 编码和 Base64 验证在 utility 队列，SSE 不逐片刷新 UI 或发微信消息。
5. **退出与数据。** 账号/会话/发送者/时间/type/本地及服务端身份在源和回调处复核。native getter、注册、下载、解绑可重入，返回后复查取消和归属。源错误但批次仍有效立即报告失败释放 slot；取消及账号/配置失效抑制回调。图片不进入文本上下文、配置、记录、备份或后续请求；原有实时授权、最终发送复查、未知结果不重试和手动回复并行保留。
6. **默认路径开销。** 新能力默认关闭；普通文本仅读取一次原生消息类型。未启用的已知会话仍提前过滤。保留之前授权、存储、群解析的性能清理，以及原有约 30 秒后台同步和音频机制，没有提高后台频率。联网及图片本身增加网络/处理工作，无法仅凭主机测试承诺真机温降。

原生签名沿用现有媒体模块；`docs/evidence/message-actions-native-2026-10-17/methods-filtered.txt:238` 记录 `StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:` 为 `v40@0:8@16B24B28B32B36`，回调声明来自 `HeadersFile/IDownloadImageExt-Protocol.h`。

## 核心验证

| 命令 | 结果 | 本目录日志 |
| --- | --- | --- |
| `Tests/verify-ai-foundation.sh` | 专项通过 | verify-ai-foundation.log |
| `Tests/verify-ai-coordinator.sh` | 专项通过 | verify-ai-coordinator.log |
| `Tests/verify-ai-manager.sh` | 333 项 | verify-ai-manager.log |
| `Tests/verify-ai-native.sh` | 86 项 | verify-ai-native.log |
| `Tests/verify-ai-images.sh` | 145 项 | verify-ai-images.log |
| `Tests/verify-ai-backup.sh` | 78 项 | verify-ai-backup.log |
| `Tests/verify-ai-background-sync.sh` | 41 项 | verify-ai-background-sync.log |
| `Tests/verify-authorization-read.sh` | 67 项 | verify-authorization-read.log |
| `Tests/verify-background-run.sh` | 186 项 | verify-background-run.log |

使用 URLProtocol、原生服务替身、临时配置及合成图片，不读真实 Keychain，不调用真实模型，不访问微信真实消息或媒体。测试覆盖旧配置与备份、联网参数、图文形状、SSE 分片/错误/限额/终止、持续取消、任务阶段归属、两会话并发、异步凭据失败、群同秒图像顺序、身份串号、native 重入、FIFO、备份回滚和原有文本/@/免@/隐藏会话/后台链路。

两套完整 Theos 构建成功，修改的 AI 文件无编译警告；日志仍含仓库已有的其他模块及链接器警告。限定源码/测试/文档 `git diff --check` 通过。构建命令与临时目录见 `build-environment.json`，最终编译输入的 368 个文件哈希见 `source-sha256.json`。使用独立 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`、`THEOS_PACKAGE_DIR`，未运行 `make clean`；原有 **1,237** 个 `.theos`/安装包文件哈希全部不变。构建期间源码未发生变化。

## 官方依据与剩余验收

官方链接：[Qwen3.8-Flash](https://help.aliyun.com/zh/model-studio/qwen3-8-flash)、[联网搜索](https://help.aliyun.com/zh/model-studio/web-search)、[Chat Completions](https://help.aliyun.com/zh/model-studio/qwen-api-via-openai-chat-completions)、[视觉理解](https://help.aliyun.com/zh/model-studio/vision)、[思考模式](https://help.aliyun.com/zh/model-studio/deep-thinking)、[地域](https://help.aliyun.com/zh/model-studio/regions)。地域、Key、模型支持范围按用户现有百炼业务空间确认，插件不迁移接入地址。Responses、Native DashScope 和其他厂商联网适配不在本轮范围。

待真机验收：实际服务商参数与搜索结果、真实图片路径/下载回调、群 @ 与免 @ 图文、免打扰后台到达/锁屏发送、持续前台/后台温度和耗电。主机测试和成功打包不能代替这些实测；本次没有设备安装、付费调用或温度测量。

包 SHA-256：

```text
031831b772981c0e651cf937badefa9bc0c5d057e887e13befff56a80d555926  com.wechat.improve_2.1-3_iphoneos-arm64.deb
6fed2b56fe9033b05b45e0dcce463deec974d233efb17bef5c80141f0f7073aa  com.wechat.improve_2.1-3_iphoneos-arm.deb
0b4b58a46c8e7e10739ed0aaeb9be9a3cca87f156d376fa862b5dd567ce97898  com.wechat.improve_2.1-3_symbols.zip
```
