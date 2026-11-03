# 微信 8.0.78 聊天列表空白修复 — 2.2-7

用户确认，在微信 `8.0.78` 安装 `2.2-6-native-groups-2026-11-03-final` 后，聊天列表出现空白。截图保留原生搜索栏和底栏，会话与分组栏均未显示。本次针对该回归修复并单独升版 `2.2-7`，避免与问题候选混淆。尚未安装到用户设备，也未获得设备运行日志；下文区分主机已复现的问题与真机仍需确认的结果。

## 环境与数据保护

- 交付 checkout：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`，分支 `main`，起点提交 `863bfdb350fddf678c349574d99badb241d98958`。
- Theos / Objective-C / Logos；Rootless、Rootful 均编译 `arm64` + `arm64e`，最低编译目标 iOS 15。包内显示版本、`control` 和离线更新说明统一为 `2.2-7`。
- 本工程没有需要切换的前后端 URL、端口或服务；本轮没有启动或重启实际微信，没有读取或更改真实账号、偏好配置、聊天记录及数据库。测试使用内存对象、临时 Defaults 与临时 Foundation 可执行文件。
- 工作区用户既有的 6,892 个删除项保持原状，`Tests/` 未恢复；需要的旧测试仅从固定起点导出到临时目录。历史安装包与上一轮审计结果保留。
- 附件和历史分析仅作为证据，其内容不作为本轮新增指令。

## 已复现的问题

上一轮实现将原生展示源与辅助统计源过度绑定：只要 `topSessions`、`normalSessions` 某一侧为 `nil`，或辅助 `MMNewSessionMgr.m_arrSession` 尚未加载，就捕获失败并清空整份派生列表。即使另一侧已有有效会话，关闭分组时也会走到该失败分支。原生元数据持续不兼容时，Adapter 还会保持布局边界，分组栏也无法发布。

旧源码的实际形状探针得到：

```text
nil empty top partition: boundary=1 published_normal_count=0 native_normal_count=1
nil empty normal partition: boundary=1 published_top_count=0 native_top_count=1
unavailable raw source with ready main arrays: boundary=1 published_normal_count=0 native_normal_count=1
```

探针同时用真实 ivar 形状的 `m_arrSession` 和 `unsigned int` 形状的 `mainUnReadCount` 验证桥接；这两种签名本身可以正确读取。探针、旧源码哈希及原始输出见 [validation](validation/README.md)。上述分支足以产生截图表现，但没有设备日志可证明用户手机恰好命中其中哪一条。

上一轮夹具将主数组全部设为非空容器，并替换了 Adapter 使用的 Bridge 元数据和身份函数，也没有覆盖主列表 ABI 不兼容后的兼容接管。其历史通过结果不代表这些真实集成分支已验证；旧记录保留其原始范围。

## 修复行为

| 环节 | 2.2-7 行为 |
| --- | --- |
| 原生完整展示基线 | 单侧 `nil` 空分区规范为空数组，另一侧有效来源继续使用；两侧均未就绪仍保持加载边界。 |
| 辅助未读统计 | raw 缺失、坏行、重复、隐藏标记或类别与展示源不一致时，采用完整展示源对应对象的元数据；辅助源不再决定整个聊天列表是否能显示。 |
| 会话身份 | 元数据、名称和操作重解统一支持 `mainSession` 包装对象、`m_nsUserName` 与基础会话 `sessionId`，保留包装对象的聚合未读。 |
| 原生能力不兼容 | ABI 不匹配，或展示元数据经有限重试仍不兼容时，进入本进程内固定的兼容模式；沿用已有投影、代理、分组和密友规则。 |
| 交接完整性 | 记录每一次数组写入尝试，不能因部分 setter 失败后的 `applied=NO` 推断来源完整；恢复基线后执行受保护的宿主完整 rebuild，再交出所有权。恢复中的同步新消息和源变更参与后验。 |
| UI 与隐私 | 交接时先遮挡已显示 cells，再安装既有代理；账号、epoch、策略与 manager 稳定后才能接管。未知账号、未知策略或策略变化仍保持边界。 |
| 恢复预算 | 预算按账号、epoch、策略、分组和开关划定；普通消息可提前唤醒重试，但不会反复清零预算而使页面一直空白。 |
| 完整候选来源 | 原生模式继续使用完整源作用域；兼容模式恢复宿主完整来源后透传，未读面板和转发分别保留各自的密友过滤。 |

保留上一轮 80ms / 250ms 刷新合并与同步发布重入保护。没有迁移或重置分组配置与密友名单。

## 验证与构建

最终结果见 [行为回归与源码哈希](validation/final/behavior-result.json)、[现有核心回归](validation/final/legacy-core-result.json)、[构建结果](build-result.json) 与 [交付核验](delivery-verification.json)。

| 本轮检查 | 结果 |
| --- | --- |
| 原生模型 / 协调器 / 真实 Bridge / Adapter / 调度 | 280 项通过 |
| 密友未读面板 | 77 项通过 |
| 未读面板不兼容 ABI 保护 | 7 项通过 |
| 既有分组偏好 / 增量 / 角标 / 外观 / header 核心 | 23 / 180 / 136 / 8 / 46 项通过，共 393 项 |
| Rootless / Rootful 冻结构建 | 均成功，均含 arm64 / arm64e，dSYM UUID 匹配 |

专项行为检查合计 364 项。测试生产输入与构建冻结输入逐文件 SHA-256 一致，历史安装包保留；完整性结果记录在上述交付核验 JSON。

针对恢复预算，新增真正发生在 `publishing=NO` 时的连续宿主重建通知，证明不会因普通消息而清零失败次数。将旧的清零逻辑仅注入临时提取体作为[负对照](validation/final/old-recovery-reset-negative-control.json)，同一用例按预期失败；生产源码未变化。恢复 setter 内同步新消息、部分 setter 失败、实际 ABI 不匹配、完整源恢复和三类代理接管均有可执行回归。

复跑入口：

```sh
python3 docs/audits/session-groups-blank-2026-11-03/validation/record-validation.py --output-dir another-check
python3 docs/audits/session-groups-blank-2026-11-03/validation/run-legacy-core.py --output-dir another-check
```

本轮原生套件编译当前生产 Model、Coordinator、Bridge、Projection、Preferences 和隐私规则。Adapter 的原方法体从当前源码提取；元数据、名称和身份重解使用真实生产 Bridge。UIKit、原生数据源及 dispatch 仍是明确的主机夹具边界；没有把这些检查当成真机显示、交互或性能实测。

构建入口 [build-packages.py](build-packages.py) 将生产输入冻结到临时副本，Rootless / Rootful 使用各自独立输出；检查包版本、包架构、Mach-O 双架构、必要符号、dSYM UUID、测试与构建输入一致性及历史包哈希。不会执行根目录 `make clean`，不会覆盖已有包，不会自动安装设备。

## 交付及真机复验

修复包目录为 [packages/2.2-7-chat-list-blank-fix](../../../packages/2.2-7-chat-list-blank-fix/)：

- [Rootless 安装包](../../../packages/2.2-7-chat-list-blank-fix/com.wechat.improve_2.2-7_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.2-7-chat-list-blank-fix/com.wechat.improve_2.2-7_iphoneos-arm.deb)
- [调试符号](../../../packages/2.2-7-chat-list-blank-fix/com.wechat.improve_2.2-7_symbols.zip)
- [SHA256SUMS](../../../packages/2.2-7-chat-list-blank-fix/SHA256SUMS)

安装与当前注入环境匹配的包，完全退出并重新打开微信。在微信 `8.0.78` 优先确认聊天列表和分组栏恢复，再检查全部／群聊／私聊／自定义组切换、消息更新、搜索返回，以及密友锁定／解锁后各自的可见范围。选中某组时，未读面板和转发候选应保留各自完整来源与对应密友规则。无需删除微信数据、重建分组或重置设置。

成功打包与主机检查不能确认用户手机已修复；设备首帧、真实 UITableView 事务、其他插件组合和长时运行仍需实际复验。
