# 原生主列表分组优化 — 2026-11-03

当前 checkout 的聊天主列表已接入原生会话数组分组。现有分组配置、密友规则、原生选人器、标签和折叠摘要继续复用。版本保持 `2.2-6`，本目录对应本轮本地候选；尚未安装或验证实际设备微信。

## 环境与参考来源

- 交付 checkout：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`，起点 `863bfdb350fddf678c349574d99badb241d98958`。
- 工程为 Theos / Objective-C / Logos，目标 `arm64` + `arm64e`，最低编译目标 iOS 15。本轮没有本地前后端服务或交付 URL，没有启动/重启任何微信进程，没有访问实际账号、偏好配置或聊天数据库。
- 本轮以 [昨日插件对比](../../themebox-chat-groups-comparison-2026-11-02.md)、[昨日原生分组资料](../../themebox-native-session-groups-2026-11-02/) 为证据参考。附件中的历史授权、版本与测试数量不作为本轮指令或验证结论。
- 昨日冻结源码仍在临时构建目录中；四个新模型/协调器文件移植前核对其历史 manifest。移植后重新审查、修复和执行本轮测试。本次构建不使用昨日二进制。

## 最终实现

| 组件 | 本轮行为 |
| --- | --- |
| `CSGroupNativeModel` | 复用共享归属、筛重、隐私、折叠与统计规则；输出输入中的原生对象，保留顺序和置顶分区。内部合成坐标只用于统计元数据。 |
| `CSGroupNativeSessionCoordinator` | 保存当前账号完整的原生展示基线；原生变更前恢复，原实现后捕获并应用当前分组；校验账号、epoch、对象身份、ABI、setter 和读回结果。 |
| 主列表 Adapter / Hooks | 使用原生 dataSource/delegate/prefetch 与原生行坐标。Adapter 保留标签、外观、搜索、手势、身份重解、首帧遮罩与有限恢复。 |
| 折叠子页 | 继续使用现有 `CSGroupProjection` / `CSGroupTableProxy`；入口与摘要继续按当前组和密友规则筛选。 |
| 完整源统计 | 以完整、未分组的展示基线确认资格，同名 raw 会话提供未读值；原生隐藏或未被主列表表示的容器子项不直接增加数字。`m_arrSession` 只读。 |
| 转发候选 | 在 Forward 完整候选作用域内消费并复制原生枚举；作用域恢复当前组后返回独立枚举。单独选择器 manager 保持其自身原生来源。 |
| 未读面板 | 在 Session 完整候选作用域内原生重建，只有完整源被接受且重建成功才能发布、撤罩和打开会话；拒绝读取后到达的排队回调仍被阻断。 |

Session 和 Forward 各自使用对应的密友开关。完整候选作用域中，主列表处于安全边界；同 surface 的嵌套读取只在数组全部准备完成后允许，跨 surface 拒绝。`finally` 同步恢复当前分组，恢复与同步通知结束后再次校验策略、账号、epoch、baseline 和 dirty。未知 ABI、setter 失败或不稳定快照保持安全空态/遮罩，不用全量会话兜底。

普通消息刷新使用持久 pending：最后事件后 80ms，同一批最多 250ms。隐私、账号与显式操作优先。调度不凭空置 dirty，只有真实事务深度 1→0 才结束并唤醒；发布前消费本次请求，后续同步事件保留到下一轮。

## 本轮确认并修复的边界

1. 元数据读取或折叠摘要格式化能同步替换模型。现在固定并后验检查 coordinator model/revision/epoch、adapter revision 与策略；原生 cell 绑定必须重解到同一真实路径。
2. 只确认 `rebuildSessionList` selector 存在不足以证明完整未读来源。现在以完整源 scope 的 BOOL 和实际重建结果决定发布；未被接受的面板也拒绝排队打开回调。
3. 临时完整源恢复后的同步通知能改变转发隐私。现在在 API 返回之前再次检查，旧候选不会因为早先已 accepted 而放行。
4. 原生数组 setter 在捕获后同步触发新消息时，旧实现会丢掉 dirty 并发布旧未读数。现在捕获/发布阶段有独立变更版本；发生重入则关闭当轮结果、保留 dirty、最多自动重建 3 次。持续冲突后保持关闭，下一真实事件或账号/epoch/manager 边界允许重新恢复。原生 original 阶段的正常嵌套单独处理。
5. UI 的 chrome/layout/reload 回调可以产生新隐私请求。现在在 UI 动作之前消费本轮请求，在撤罩前复核发布条件；finally 不再清掉新 pending。新事件继续保持遮罩与隐私优先。

## 可复跑验证

实际结果见 [行为测试及生产源码 SHA-256](validation/behavior-result.json)、[五套现有核心测试](validation/legacy-core-result.json) 和 [最终构建结果](builds/final/build-result.json)。各 runner 的 `.log` 与 JSON 保留在本目录中。

| 本轮最终检查 | 结果 |
| --- | --- |
| 当前生产 native 模型 / 协调器 / Adapter / 调度 | 179 项通过 |
| 密友未读面板 | 77 项通过 |
| 不支持 ABI 的面板保护 | 7 项通过 |
| 现有偏好 / 增量 / 角标 / 外观 / header 核心 | 23 / 180 / 136 / 8 / 46 项通过，共 393 项 |
| 最终 Rootless / Rootful 构建 | 均成功，均含 arm64 / arm64e，dSYM UUID 匹配 |

本轮三套行为检查合计 263 项。测试期间生产源码未变，20 份行为测试生产输入与最终构建输入逐文件 SHA-256 一致；交付核验见 [delivery-verification.json](delivery-verification.json)。独立审查专用临时夹具的数量不再叠加到正式检查数量。

```sh
python3 docs/audits/session-groups-native-2026-11-03/validation/record-validation.py
python3 docs/audits/session-groups-native-2026-11-03/validation/run-legacy-core.py
```

模型、协调器、桥接、Projection、偏好和隐私规则使用当前生产 translation unit。Adapter、调度与转发 replacement block 从当前源码提取原方法体编译，UIKit、宿主 dataSource、时钟和 dispatch 为明确的夹具边界。未读面板套件运行当前生产桥接/接触适配/面板与 Hook 注册，完整源 wrapper 在该套件中为可控替身，其真实实现由 native 套件验证。

测试仅使用临时 Foundation 可执行文件、内存 Defaults 和会话替身。历史 `Tests/` 从固定起点提交只导出到临时目录，不恢复工作区中用户已删除的文件。旧资料的历史通过数量不并入本轮结果。

## 最终安装包

最终候选保存在 [packages/2.2-6-native-groups-2026-11-03-final](../../../packages/2.2-6-native-groups-2026-11-03-final/)：

- [Rootless `.deb`](../../../packages/2.2-6-native-groups-2026-11-03-final/com.wechat.improve_2.2-6_iphoneos-arm64.deb)
- [Rootful `.deb`](../../../packages/2.2-6-native-groups-2026-11-03-final/com.wechat.improve_2.2-6_iphoneos-arm.deb)
- [匹配的调试符号](../../../packages/2.2-6-native-groups-2026-11-03-final/com.wechat.improve_2.2-6_symbols.zip)
- [SHA256SUMS](../../../packages/2.2-6-native-groups-2026-11-03-final/SHA256SUMS)

[build-packages.py](build-packages.py) 将当前生产输入复制到独立冻结目录，rootless/rootful 各用独立构建与打包输出。构建后检查输入未变化、包元数据、两种 Mach-O 架构、模型/协调器/API 符号及逐架构 dSYM UUID。最终输入清单见 [production-inputs.json](builds/final/production-inputs.json)。复跑须指定未存在的输出名，脚本拒绝覆盖已有包与构建证据：

```sh
python3 docs/audits/session-groups-native-2026-11-03/build-packages.py \
  --delivery-name 2.2-6-native-groups-another-check \
  --evidence-subdir builds/another-check
```

早一轮已成功构建的 [初轮候选](../../../packages/2.2-6-native-groups-2026-11-03/) 及 [初轮构建记录](build-result.json) 保留用于追溯；它早于最终重入修复，不作为本轮最终安装包。原有历史 `.deb` / `.zip` 用 SHA-256 核实保留；工作区既有 6,892 个删除项继续保留。没有改版本号、切分支、提交或安装设备。

## 真机验收边界

主机夹具和双架构构建不证明真实微信私有接口、UIKit 事务、首帧或运行性能。还需在用户实际微信版本与注入环境验收：

1. 全部/群聊/私聊/服务/自定义组连续切换，置顶及折叠摘要、搜索返回、手势与圆角组合。
2. 选中某组时收到组外消息、删除或置顶，核实没有 `invalid update`、越界或短暂显示完整列表；检查组内和完整源未读数。仓库没有微信 `updateMainSessionList*` 原实现，主机不能证明其同步表事务实际调用时序。
3. 当前组选项不影响未读面板与转发的完整候选；分别切换隐藏聊天/隐藏转发，确认各自结果及返回后分组恢复。
4. 密友锁定、解锁、后台/切换器、小程序返回和账号切换，检查首帧及延迟菜单/打开回调；账号分组和历史聊天记录保持一致。
5. 长消息突发、原生菜单及滚动中的刷新行为，并观察启动、稳定性、帧率与耗电。本轮没有宣称实测性能提升。

设计见 [spec](../../superpowers/specs/2026-11-03-native-session-groups-design.md)，执行跟踪见 [plan](../../superpowers/plans/2026-11-03-native-session-groups.md) 与 [progress](progress.md)。
