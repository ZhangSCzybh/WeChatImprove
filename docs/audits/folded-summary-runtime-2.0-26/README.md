# 2.0-26：折叠聊天摘要运行时签名修复（真机确认）

2026-10-27。用户确认安装2.0-25后，群聊分组的折叠入口第二行仍显示“折叠的聊天”。本轮通过已配对的同机型 iPhone15,3 的系统控制台取得真实失败原因，修改桥接层签名读取，并交付2.0-26。**用户安装2.0-26、重新打开微信并按提示进入/退出折叠页后，明确回复“已显示会话名称 + 消息”。**

## 真机证据与确定原因

[device-before.log](device-before.log) 保留2026-10-27 10:45的5条 FoldedDigest 状态行。仅记录诊断，不含会话名称或消息内容；tab值由系统显示为 `<private>`。用户关闭重开微信并切到群聊，启动时 `source reason=message_missing`，进入折叠页后 `source reason=chat_mismatch`。这将失败定位到消息读取和身份验证阶段；不是字号、圆角或双标签排版的问题。

微信8.0.78.34所用本地原生二进制 SHA256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。

- `CMessageWrap.methodSignatureForSelector:`，地址 `0x104b9f07c`，无条件读取兜底对象，并将请求selector改为 `catchUnImplementMethod` 后查询签名。它不向super查询已实现的方法。
- selector引用 `0x11ff87bf8` 解码为 `catchUnImplementMethod`，`0x120104840` 解码为 `methodSignatureForSelector:`。
- `CCatchUnImplementMethod.catchUnImplementMethod`，地址 `0x1165446c4`，签名 `q16@0:8`，返回0。
- `CMessageWrap.GetChatName` 真实签名为 `@16@0:8`；`copyWithZone:` 是 `@24@0:8^{_NSZone=}16`；`getSessionTime` 是 `I16@0:8`。这些都与统一兜底签名不同。

完整限定范围反汇编、方法元数据和提取脚本见 [native/manifest.json](native/manifest.json)、[native/selector-refs.json](native/selector-refs.json)、[native/extract.py](native/extract.py)。这些是离线静态证据；设备状态行是实际运行证据。

2.0-25桥接层直接信任对象的 methodSignatureForSelector:，于是将 GetChatName 误认为返回整数，读出nil。已有内存消息走到 `chat_mismatch`；补读最新消息也因相同校验被丢弃而记录 `message_missing`。即使略过此处，原来的copy签名门禁仍会被同一兜底签名拦截。此前测试替身没有重写该方法，未覆盖微信真实行为。

## 修复范围

`Controllers/CSGroupNativeBridge.m` 的集中式 Signature helper：优先从对象实际class/metaclass查找 Method，使用 method_getTypeEncoding 构造正确签名；仅无真实方法时沿用对象的消息转发签名。仍保留 respondsToSelector、参数数目、参数/返回类型校验，以及账号、隐私和消息身份验证。

`Controllers/CSCloseFriendSessionPresentation.m` 仅将“缺少摘要来源”的诊断分类改为 `summary_unavailable`，避免误报 `policy_stale`。真实渲染仍为微信的会话名称前缀和消息标签，保留标题、图标、时间隐藏和卡片样式。2.0-25的表格代理生命周期修复没有变化。

## 核心回归

测试 NativeMessage 现模拟微信的统一 `q16@0:8` 兜底签名。相同的真实生产桥接、投影和适配器用例，在修改生产代码前148项中47项失败；修复后148项全部通过。覆盖冷启动、稀疏消息补读、原生入口缓存、独立消息拷贝、名称与正文、64位消息身份、组内筛选、隐藏会话、账号变化及刷新。

| 检查 | 结果 |
| --- | --- |
| 会话、分组与摘要 | 148项，0失败 |
| 摘要渲染与隐私展示 | 44项，0失败 |
| 连续卡片、圆角与复用 | 1017项，0失败 |
| 分组选择与回调映射 | 30项，0失败 |
| 代理生命周期 | 5场景通过 |

共1239项核心检查，另有5个代理场景。没有执行全仓测试。原始结果见 red-session.log、green-session.log、green-corners.log、green-selection.log、green-proxy.json。

## 构建、数据保留与真机验收

- [2.0-26 Rootless](../../../packages/com.wechat.improve_2.0-26_iphoneos-arm64.deb)：用户已安装并确认摘要显示会话名称与消息。
- [2.0-26 Rootful](../../../packages/com.wechat.improve_2.0-26_iphoneos-arm.deb)：已构建，未在Rootful真机验证。
- [调试符号](../../../packages/com.wechat.improve_2.0-26_symbols.zip)。

两个方案均含arm64与arm64e，包内版本/安装路径/各架构dSYM UUID已验证；各方案12条既有构建警告，0错误。清单见 [packages.json](packages.json) 与 [delivery-verification.json](delivery-verification.json)。构建使用独立临时目录，未执行make clean；原有1233个 `.theos` 与历史包文件哈希全部不变。

代码仍在原工作区 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`。没有替换checkout、改动微信数据库或账号配置。包由用户按原有安装方式安装；本机没有直接部署或重签微信。设备只用于筛选诊断状态，未提取聊天正文。控制台诊断已停止流式读取。

本轮真机验收依据为用户明确反馈，不冒充屏幕像素自动化或长期稳定性压测。进出折叠页的代理保护通过专项回归，本次没有新的真机崩溃证据。

相对2.0-25的完整差异见 [changes-from-2.0-25.diff](changes-from-2.0-25.diff)，修改前源码见before目录。
