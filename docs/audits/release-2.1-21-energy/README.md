# 2.1-21 会话列表两阶段优化

本次在既有 WeChatImprove checkout 上完成两阶段实现，并沿用 2.1-20 的定时任务时间段规则与左滑启用／停止改动。版本统一更新为 `2.1-21`。未修改用户手机设置、账号、聊天数据或后台运行策略；本轮交付范围为源码与安装包。

## 已实施

第一阶段修正分组和密友共用的发布调度：

- 区分数据失效与调度唤醒。菜单、手势及回顶结束只处理已有 dirty 状态，不再重新制造刷新。
- 普通通知保留首个事件起约 80ms 的合并截止时间，包含发布过程中的重入；明确操作可提升优先级。同步发布取消旧 generation，旧 timer 无法提前消费后到的事件。
- native 事务只在深度 1→0 时调度，未配对结束不启动任务；嵌套及批量 completion 保持原有完成约定。
- 恢复仍按账号／模型 revision 共用最多三次预算，实际新模型事件可重新唤醒，普通 UI 回调不能重置预算。恢复请求包含内容失效，确保暂时失败的原生 cell 能替换占位。
- 密友策略变化先同步遮挡；旧发布不能清除重入期间的新隐私请求。账号、隐私或 epoch 过期时，下一轮强制完整同步表格坐标。普通后台与离页 UI 继续延后，密友安全发布例外继续保留。
- 相同 dataSource、delegate、prefetch proxy 不重复赋值。

第二阶段减少普通消息造成的重载和同步布局：

- 从原有消息／session／item 回调提取会话身份，只复制字符串，不保留原生模型。真实 session 无法解析时保持未知，禁止回退到过期的外层行身份。
- 派生表格操作继承外层事件身份；真实未知事件保持未知。嵌套身份按栈恢复，跨后台线程事件保守按未知内容处理。
- 普通内容与草稿按会话更新可见行，真实 Content 不会因为结构、未读相同而被跳过；无法归因的内容更新可见普通行及特殊行。
- 未读或结构验证反馈的不可变值未变化时，可跳过表格操作。业务／聚合／匿名行的存在不再让每条无关消息退回整表 reload。
- 排序、增删、隐私版本、账号或坐标变化继续完整发布。折叠摘要保留当前和旧来源会话的内容依赖；特殊几何变化更新高度缓存。
- 普通文本与未读更新避免强制 layoutIfNeeded；结构或特殊几何变化仍同步布局以配合定位。

## 诊断与实测边界

之前真机 A/B 与调用栈定位到共享投影发布链路；实际反复发通知的原生 selector 尚未在旧版本中记录。新版本增加有界内存诊断：最多 60 秒或 2048 条样本、最近 32 条事件、有限原因计数，记录实际 selector、发布阶段、dirty／revision、pendingTop 与调度延迟。不记录用户名、聊天正文，不逐帧写文件。调试时可通过 adapter 的 `resetRefreshDiagnostics` 开始新窗口，随后调用 `refreshDiagnosticsSnapshot` 一次导出。

主机回归验证事件语义、失效范围、有限调度与隐私边界。它们不等于真机能耗测试。本轮未把新包安装到手机，不能声明 2.1-21 的 CPU 降幅、温度或续航增益；也没有把旧版关闭功能后的低负载当作本版结果。安装后应在原账号、分组开启、密友锁定隐藏、原样式开启的同一场景复测静置／收消息／滚动／进出聊天，并单独采样后台。之前锁屏约 89 秒采样没有复现后台持续高 CPU，不能据此归罪于 AI 或后台保活。

后续已在原账号和原功能组合下完成安装后的前台复测，结果与边界见 [2.1-21 安装后 CPU 复测](device-validation.md)；上述未安装说明保留为构建交付当时的历史记录。

## 验证与交付

- [分组、搜索、列表回归](group-regressions.json)及 `regressions/` 中的原始输出。
- [后台、AI、定时任务保留回归](preservation-regressions.json)。
- [构建脚本](build-packages.py)为 Rootful／Rootless 分别创建临时对象、staging 与 session 目录，保留既有 `.theos` 与 `packages`，不运行会删除这些目录的 `make clean`。
- [包校验脚本](verify-packages.py)核对版本、安装路径、arm64／arm64e、最低系统、filter、payload／staging 一致性、dSYM UUID、优化方法及 ZIP／SHA-256。
- 本轮开始前发布文件已有的改动保存在 [pre-existing-release-changes.diff](pre-existing-release-changes.diff)，2.1-20 历史说明和安装包继续保留。

最终构建、回归与产物校验结果随本目录 JSON／日志记录提供。交付目录为 [packages/2.1-21-energy](../../../packages/2.1-21-energy/)。

### 最终结果

两种方案均构建成功，冻结的生产输入哈希完全一致；构建前已有的 1,283 个 `.theos`／`packages` 文件均未缺失或改变。每种方案各 6 条既有弃用／链接警告，与构建基线相同，本次优化没有新增编译警告。

| 验证范围 | 结果 |
| --- | --- |
| 生命周期（发布重入、80ms、有限恢复、后台、切号、隐私、nil 账号） | 223 项通过 |
| 行发布计划与实际 hook 身份 helper | 62 项通过 |
| 从生产 adapter 提取的实际 publisher | 187 项通过 |
| 分组选择／搜索／header／appearance／业务行／角标 | 30／54／46／8／633／136 项通过 |
| 手势交互／viewport | 124／72 项通过 |
| 列表圆角集成 | 1,631 项通过 |
| 密友会话／会话展示／隐私／恢复 | 174／55／38／24 项通过 |
| 后台运行、AI 同步与回复、定时任务与备份 | 4,844 项通过 |

包校验确认两包均为 2.1-21、含 arm64／arm64e、最低 iOS 15.0；包内 dylib 与 staging 一致，filter 与源码一致，四份 dSYM UUID 全部匹配。12 个符号 ZIP 文件通过 CRC；新优化方法与保留关键符号存在；两个 deb 和符号 ZIP 的 SHA-256 独立复核 3/3 OK。

交付：[Rootful](../../../packages/2.1-21-energy/com.wechat.improve_2.1-21_iphoneos-arm.deb)、[Rootless](../../../packages/2.1-21-energy/com.wechat.improve_2.1-21_iphoneos-arm64.deb)、[符号](../../../packages/2.1-21-energy/com.wechat.improve_2.1-21_symbols.zip)、[SHA256SUMS](../../../packages/2.1-21-energy/SHA256SUMS)。对应记录：[构建](build-result.json)、[包校验](package-verification.json)、[既有产物保全](preserved-artifacts-after.json)、[综合回归](validation-summary.json)。
