# 2.1-6 保护名单、快照状态与底栏角标补充探针

日期：2026-10-29。基线：当前工作区授权清理后的 2.1-6；本目录是新增的隔离 host 探针，不修改生产代码、正式 Tests、原探针或历史报告。

本探针验证了一个明确的内容处理机制：在未 blocked 的受控输入下，空保护名单使 getter 返回 `nil`，原生角标输入透传；选中好友或群聊后，有效会话快照保留普通未读，无可靠快照则返回 `@0`，数字与字符串 Hook 把原生正数改为零值或空字符串输入。快照恢复有效本身不会通过 getter 重发角标；后续 setter 才能使用恢复后的结果。这是源码在受控边界上的执行结果，不能单独证明设备上实际处于哪一种快照状态，也不能证明底栏样式功能导致了快照失效。

## 编译与隔离范围

探针运行在 macOS Foundation host，未加载微信、UIKit 或底栏样式实现。真实参与编译的生产实现是：

- `CSCloseFriendPolicy.m`：策略快照、保护名单及默认选项语义。
- `CSGroupProjection.m`：会话行、过滤投影及普通未读计算。
- `WESessionTabItem.m`：分组标签模型。

下列五段直接从当前源码逐字提取后包含到 harness 中，未重新实现其条件与算法：

| 精确摘录 | 生产来源 | 本地文件 |
| --- | --- | --- |
| `closeFriendAlertBadgeCount` 完整方法 | `Controllers/CSGroupListAdapter.m:183` | [extracted/closeFriendAlertBadgeCount.inc](extracted/closeFriendAlertBadgeCount.inc) |
| `ChatTab` 完整函数 | `Hooks/CloseFriendNotificationHooks.xm:27` | [extracted/ChatTab.inc](extracted/ChatTab.inc) |
| 数字 setter block | `Hooks/CloseFriendNotificationHooks.xm:105` | [extracted/numeric-block.inc](extracted/numeric-block.inc) |
| 字符串 setter block | `Hooks/CloseFriendNotificationHooks.xm:108` | [extracted/string-block.inc](extracted/string-block.inc) |
| 纯红点 show block | `Hooks/CloseFriendNotificationHooks.xm:111` | [extracted/dot-block.inc](extracted/dot-block.inc) |

八份生产输入完整副本保存在 [sources/](sources/)，来源、行号和哈希保存在 [source-manifest.json](source-manifest.json)。运行器先确认八份输入与 `docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json` 的交付哈希一致，运行后再次逐字比较生产输入未变。

以下边界由探针明确提供：合成账号和 policy owner、主列表 adapter 属性、不可变 unread 行、控制器层级、原生 IMP 的可观察效果，以及 folded-controller 固定为否的环境。原生数字 IMP 替身仅在 `count==0` 时设置 host badge 的 `hidden`；字符串 IMP 按字符串是否为空设置 `hidden`；纯红点 IMP 设置可见纯红点。这些是可审阅的边界契约，不等于执行了微信原生实现。harness 见 [selection-content-probe.m](selection-content-probe.m)。

## 保护名单与快照矩阵

矩阵为 `3 × 2 × 2 × 5 = 60` 个组合；每个组合分别从独立种子状态执行数字、字符串、显式 show-dot 事件，共 180 条记录。

| 维度 | 取值 |
| --- | --- |
| 保护名单 | 空名单 / 选中一个好友 / 选中一个群聊 |
| 候选会话数字未读 | 0 / 5 |
| 普通会话数字未读 | 0 / 7 |
| 主会话快照 | 有效缓存 / 无缓存 / dirty / changeDepth 非零 / revision 不一致 |

矩阵所有行均为 `redDot=NO` 的数字未读输入，以隔离名单和计数过滤。策略为 enabled、未 reveal、未 blocked，`hideSessions` 与 `silenceMessages` 均开启。`nativeTotalInput` 是受控两行的数字未读之和，即“普通 + 候选”，不模拟微信全部未读汇总、免打扰或数据就绪规则。

“候选未读”在空名单下仍是一条普通、未受保护的输入，不能把这时的 5 称作“已被保护的 5”。选中好友或群聊后，只有候选行受保护，普通行始终不在名单内。

五种快照分别通过以下属性设置；除所列断点外，其余账号、epoch、revision 等前置条件保持有效：

| 状态 | 受控设置 |
| --- | --- |
| `valid-cache` | 有 `cachedNativeSections`，dirty 为否，changeDepth 为 0，snapshotRevision 等于 modelRevision |
| `no-cache` | `cachedNativeSections=nil` |
| `dirty` | `dirty=YES` |
| `change-depth` | `changeDepth=1` |
| `revision-mismatch` | snapshotRevision 比 modelRevision 小 1 |

有效缓存指真实输入行可用，并非预填最终 `alertBadge`。首次结果由真实 getter 调用真实 projection 计算；另外断言同一有效 key 的后续调用使用已算出的缓存结果。

核心结果如下，其中“有效”只指上述 `valid-cache`，“失效”覆盖其余四种状态：

| 名单 | 普通未读 | 候选未读 | 原生数字输入 | 有效 getter → 原 IMP 输入 | 失效 getter → 原 IMP 输入 |
| --- | ---: | ---: | ---: | --- | --- |
| 空 | 7 | 0 | 7 | `nil → 7` | `nil → 7` |
| 空 | 7 | 5 | 12 | `nil → 12` | `nil → 12` |
| 好友 / 群聊 | 7 | 0 | 7 | `@7 → 7` | `@0 → 0` |
| 好友 / 群聊 | 7 | 5 | 12 | `@7 → 7` | `@0 → 0` |
| 好友 / 群聊 | 0 | 5 | 5 | `@0 → 0` | `@0 → 0` |

因此，“名单里的人没有未读”不会令过滤自动失效：选中候选、候选未读为 0、普通未读为 7 时，有效快照仍给 7，但四种失效快照均给 0。相反，有效快照中只有受保护未读 5、普通未读 0，返回零值符合过滤目标，不能据此判为缺陷。

上述普通 7 的 20 个关键数字用例单独保存在 [required-cases.json](required-cases.json)。全部 12 种“名单 × 候选未读 × 普通未读”数字汇总见 [matrix-summary.json](matrix-summary.json)，每行附五种快照状态。

## 数字、字符串与纯红点的区别

数字事件初始 host badge 为可见数字 12。Hook 对非 `nil` getter 结果替换 setter 的数字参数，最终 `@0` 会令原生数字 IMP 替身把同一个 badge 设为隐藏；`nil` 则保留 supplied native total。

字符串事件同样单独从可见数字 12 开始，传入 native total 的十进制字符串；total 为 0 时传入 `nil`。有效过滤 12 → 7 对应字符串 `"12" → "7"`；非 `nil` 的 `@0` 对应 `"12" → nil`。原始参数、原 IMP 参数和可见状态均逐条记录。

纯红点事件是显式调用真实 show-dot block 的独立合成请求，也从可见数字 12 开始，并不宣称该请求由前述数字合计产生。getter 为非 `nil` 的 `@0` 时，block 不调用原 dot IMP，但它本身没有隐藏既存数字 12：日志保留 `count=12, hidden=NO, dot=NO`。getter 为 `nil` 或正数时原 dot IMP 调用一次。因而不能把“抑制 show-dot 调用”表述成“这个 block 自己将已存在的 badge 隐藏”。

所有事件均断言 badge 指针未变，固定 host frame `{32, 4, 24, 16}` 未变。该 frame 是测试哨兵，证明本内容链没有在 host 中改对象或位置；它不证明真机 badge 的父子层级、裁剪范围、窗口可见性或几何正确。

## 受控生命周期：有效 → 失效 → 恢复

12 条路径覆盖 `3 种名单 × 2 种候选未读 × 2 种普通未读`，每条 7 阶段，共 84 条事件。每条从冷态已能识别 ChatTab、且有有效输入行的状态开始，避免把“冷启动没识别出微信 tab”当作后续消失的唯一解释。

以下为选中好友、候选未读 0、普通未读 7 的实际记录，见 [lifecycle-example.json](lifecycle-example.json)：

| 阶段 | getter | 原数字 IMP 累计调用 | 同一 badge 数字 | hidden |
| --- | ---: | ---: | ---: | --- |
| 有效冷态，执行 setter | 7 | 1 | 7 | NO |
| 手动 begin 失效，不执行 setter | 0 | 1 | 7 | NO |
| begin 窗口执行 setter | 0 | 2 | 0 | YES |
| 手动 end 留下 dirty，不执行 setter | 0 | 2 | 0 | YES |
| dirty 窗口执行 setter | 0 | 3 | 0 | YES |
| 手动恢复有效来源，不执行 setter | 7 | 3 | 0 | YES |
| 后续新 setter | 7 | 4 | 7 | NO |

手动 begin 只做 `modelRevision++` 与 `changeDepth=1`；手动 end 做 `changeDepth=0, dirty=YES`；有效刷新重新赋 fixture sections，使 snapshotRevision 与 modelRevision 一致，并清 dirty。本探针没有编译执行真实 `CSGroupListAdapter` 的 begin/end/refresh，没有模拟其事件调度或真机回调先后次序。

该路径说明：已命中 ChatTab 的有效冷态，也能在后续失效时接收一个零值 setter；来源恢复后若没有 setter，单读 getter 不改变既有隐藏状态。它不证明真实设备一定缺失后续 setter，也不证明现实中失效窗口持续多久。普通未读为 0 的组合在恢复后仍应为 0，不能把 12 条路径全部描述成“最后重新可见”。空名单路径始终透传合成原生总数。

## ChatTab 构造阶段与未加载策略

另有四个构造阶段。owner 的 host badge 独立存在，待测 tab 索引为 2；借此执行真实 `ChatTab` 的控制器识别逻辑，而非固定认为微信在索引 0。这里显式提供 blocked 的未加载策略：账号为空、enabled 为否、名单为空、默认选项、`blocked=YES`。真实 getter 在该受控策略下返回 `@0`，不是 `nil`。

每阶段都显式采样 getter，随后调用数字 Hook 输入 12；前三个阶段 Hook 实际不咨询 getter：

| 构造阶段 | ChatTab(index 2) | 显式 getter 采样 | Hook 咨询 getter | 原 IMP 数字参数 | hidden |
| --- | --- | ---: | --- | ---: | --- |
| 空 `viewControllers` | NO | 0 | NO | 12 | NO |
| index 2 为普通 placeholder | NO | 0 | NO | 12 | NO |
| index 2 为导航，root 为 placeholder | NO | 0 | NO | 12 | NO |
| index 2 为导航，root 为 `NewMainFrameViewController` | YES | 0 | YES | 0 | YES |

日志中的 `getterDecision` 是显式采样，`hookConsultsGetter` 和 `appliedReplacementDecision` 区分 Hook 实际采用的决定。前三个阶段即使显式采样为 0，原生输入仍完整保留。它验证了构造阶段的条件行为，不宣称真机在任一时刻具有这些构造状态。

## 执行结果与证据文件

本次严格 host 编译与执行通过：

| 项目 | 结果 |
| --- | --- |
| 编译选项 | `-fobjc-arc -fblocks -Wall -Wextra -Werror`，仅 Foundation，无警告屏蔽 |
| 编译退出码 | 0 |
| compile.log / stderr.log | 均为空，0 bytes |
| 检查数 | 2507 |
| 矩阵组合 / 事件 | 60 / 180 |
| 受控生命周期 / 事件 | 12 / 84 |
| 构造阶段 / 事件 | 4 / 4 |
| 总事件 / 失败 | 268 / 0 |
| 八份生产输入 | 运行前匹配历史 2.1-6；运行前后未变 |
| 原探针 | harness、runner 未变；八份 source 和五段摘录哈希一致 |

构建命令与结果见 [build-result.json](build-result.json)，原始逐事件输出见 [events.jsonl](events.jsonl)，汇总与边界声明见 [results.json](results.json)，原探针对照见 [original-probe-parity.json](original-probe-parity.json)。

从仓库根目录复现：

```sh
python3 docs/audits/tabbar-wechat-badge-2.1-6-2026-10-29/selection-followup/probe/run-selection-content-probe.py
```

运行器会刷新本目录的冻结输入、精确摘录、host 二进制、manifest、原始事件及 required-cases/results；不会执行 iOS 编译、正式回归、打包、安装或读取设备/账号数据。`matrix-summary.json`、`lifecycle-example.json` 与 `original-probe-parity.json` 是本次执行后的附加归纳，事件来源哈希附在文件内（parity 文件保存两份 manifest 哈希），不属于运行器自动生成项。

## 结论边界

本探针能够证明当前 2.1-6 精确 getter 与 Hook 在所列输入下的内容决定，以及普通未读 7 被失效来源回退为 0 后、恢复来源但无 setter 时仍保持 host 隐藏状态的可达序列。它没有采集现场 policy、普通/保护未读分布、主列表快照或实时调用栈；也没有执行 Hook installer、policy observer、微信原生消息回调、真实 adapter 生命周期或样式 apply/restore。

本次没有生产修复、没有改正式 Tests、没有跑正式回归、没有 iOS 构建、没有打包和设备安装。结果不能替代全部样式、深浅色、数字/红点、99+、多 tab、前后台等真机矩阵，也不能作为 badge 坐标或遮挡的验证。真实原生同步链的静态证据、历史设计意图与现场验收要求由上级审计记录分别说明。
