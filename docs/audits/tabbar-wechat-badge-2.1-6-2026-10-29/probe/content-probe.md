# 2.1-6 内容写入隔离探针

本探针只验证一条可达的**内容改写机制**：密友通知 Hook 可能把传入微信 tab 的非零数字改为 `0`，把非空字符串改为 `nil`。在受控 native setter 替身中，这使同一个 badge 的 hidden 变为 YES，frame 保持不变。它没有证明用户现场命中了这条分支，也没有替代真机几何、裁剪或回调顺序观测。

日期：2026-10-29。来源为严格恢复后的 2.1-6 工作区。所有输出均在本目录；未改生产或正式 Tests，未安装、接设备、读取账号数据或构建插件包。

## 实际编译的源码与边界

`run-content-write-probe.py` 首先核对 8 个输入与授权清理交付的 `source-sha256-after.json` 一致，再保存到 `sources/`。输入 SHA、提取的精确行号和内容 SHA 见 `content-source-manifest.json`。以下代码按原文提取，未为探针改写其方法体或 block：

| 原生产来源 | 本目录提取文件 | 覆盖职责 |
| --- | --- | --- |
| `CSGroupListAdapter.m:183–210`，`+closeFriendAlertBadgeCount` | `extracted/closeFriendAlertBadgeCount.inc` | 过滤条件、nil/0/非零决策、cache 与版本/线程校验、projection 结果读取 |
| `CloseFriendNotificationHooks.xm:27–32`，`ChatTab` | `extracted/ChatTab.inc` | 识别实际主会话 controller，包含导航根 controller；不固定假设 index 0 |
| 同文件 `:105`，tab 数字 block | `extracted/numeric-block.inc` | 对 ChatTab 的数值替换及原 IMP 透传 |
| 同文件 `:108`，tab 字符串 block | `extracted/string-block.inc` | 非零转十进制字符串、0 转 nil、nil 决策透传 |
| 同文件 `:111`，红点 block | `extracted/dot-block.inc` | 决策为非 nil 且数值 0 时不调用原 IMP |

另直接编译保存的真实 `CSCloseFriendPolicy.m`、`CSGroupProjection.m`、`WESessionTabItem.m`，所以 `count=0/redDot=YES` 由真实 projection 从受控不可变行计算，不是桩强行返回的结果。受控数据中普通行 unread=7、redDot=YES；受保护行 unread=50，由真实隐私过滤排除。该普通行的数字 count 为 0，dot 为 YES，projection 有效。

替身边界是：snapshot/账号服务出口、Adapters 弱集合与其状态、controller、导航、原始三个 native IMP 和固定 frame。实际读取的 snapshot 类型及 projection 算法为真实生产实现。没有编译完整 GroupListAdapter 生命周期、通知 Hook 安装器或底栏样式 adapter；不能从本探针推断现场 Hook 安装成功、会话列表缓存何时失效/重建，或这些边界的实际值。

## 四象限的准确含义

| 输出 | 受控输入 | checks | 事件记录 | failures / exit |
| --- | --- | ---: | ---: | --- |
| `content-style-0-cold.jsonl` | 样式关闭标签，无通知 setter | 123 | 15 | 0 / 0 |
| `content-style-1-cold.jsonl` | 样式开启标签，无通知 setter | 123 | 15 | 0 / 0 |
| `content-style-0-message.jsonl` | 样式关闭标签，合成消息更新调用 | 408 | 75 | 0 / 0 |
| `content-style-1-message.jsonl` | 样式开启标签，合成消息更新调用 | 408 | 75 | 0 / 0 |

合计 **1,062 条断言、180 条事件记录**，15 个场景分别在四象限执行。结果和四份日志 SHA 见 `content-results.json`，编译命令及退出码见 `content-build-result.json`；`-Wall -Wextra -Werror` 通过，最终 `content-compile.log` 为空。

**样式开/关是明确标记的受控标签。** 内容决策源码没有读取这个标签，探针未加载样式实现。规范化去掉标签与对象地址后，开/关的 cold 日志完全相同，message 日志也完全相同。这支持“这条已提取的内容路径不以底栏样式开关为条件”，不能写成“现场关闭样式也必现”或“样式对所有路径无影响”。

**cold 是无通知 setter 的受控状态。** 初始给同一替身 badge 放置数字 12、hidden=NO；即使 getter 决策为 0，只读 getter 也不会改该对象。没有声称微信真正冷启动期间不会调用这些 setter。

**message 是主动调用真实提取 block 的受控状态。** 每场景分别执行三个互相隔离的事件：数字输入 13、字符串输入 `99+`、可见数字上请求红点；另外执行一次明确标为 synthetic 的 number→string→dot 序列，及一次非主会话 tab 对照。这一序列只是机制演示，不是现场消息回调时序。

所有事件日志均带 `siteStateObserved=false`、实际主线程标记、受控 snapshot 与 adapter 状态、替换决策、原始 IMP 调用次数、前后 count/string/hidden/dot、badge 地址和 frame 来源。

## 场景与断言映射

| 场景名 | 受控条件 | getter 预期 | message 中数字 / 字符串 / dot |
| --- | --- | --- | --- |
| `no-filter` | enabled=YES，但 hideSessions=NO、silenceMessages=NO | nil | 13 / `99+` 原样透传，dot 透传 |
| `no-protected-names` | 无受保护用户名 | nil | 同上 |
| `valid-cache-nonzero` | 有效 sections、账号/epoch/revision 均匹配，命中 alertBadge cache | 7 | 7 / `7`，dot 仍透传，不变为数字 |
| `valid-projection-nonzero` | 同样有效，但无 alertBadge cache，实际 projection 计算 | 7 | 同上 |
| `change-depth` | 其余有效，changeDepth=1 | 0 | 0 / nil，dot 原 IMP 被抑制 |
| `dirty` | 其余有效，dirty=YES | 0 | 同上 |
| `no-cache` | adapter 存在，cachedNativeSections=nil | 0 | 同上 |
| `no-adapter` | adapter 集合为空 | 0 | 同上 |
| `blocked` | snapshot.blocked=YES | 0 | 同上 |
| `off-main` | 用实际 NSThread 在非主线程执行，过滤有效 | 0 | 同上；日志 actualMainThread=false |
| `valid-zero-count-with-red-dot` | 真实 projection 有效，count=0、redDot=YES | 0 | 同上；getter 仅取 count，不传递 redDot |
| `silence-only-no-cache` | hideSessions=NO、silenceMessages=YES，有保护名单，无 adapter/cache | 0 | 同上；不能从 hideSessions 关闭推断 getter 不参与 |
| `revision-mismatch` | snapshotRevision 与 modelRevision 不同 | 0 | 同上 |
| `epoch-mismatch` | snapshotEpoch 与当前 epoch 不同 | 0 | 同上 |
| `account-mismatch` | snapshotAccount 与当前 policy 账号不同 | 0 | 同上 |

每场景断言 getter 决策；ChatTab 在实际放在 index 2 的导航根主会话页为 YES，在其它 controller 和越界 index 为 NO。message 阶段检查原 IMP 接到的数值/字符串、原 IMP 是否调用、同一对象、固定 frame 未变。非 ChatTab 即使 getter 的决策为 0 也透传数值、字符串和红点。

数字 0、nil 字符串的 hidden 变化由本探针的 native IMP 替身显式实现。它们是为了把传入内容与受控可见状态对应起来；真实 native 的内容→hidden 实现需由主任务独立静态核对。本探针没有以替身规则替代该证据。

## 不应误读红点 block

零决策的 dot block 只 `return`，**没有主动隐藏或清空** badge。在独立 dot 实验里，初始数字 12、hidden=NO 会保持，原 dot IMP 调用为 0。不能写成“dot block 总是把当前角标 hidden=YES”。

在另一个明确标记的合成序列中，数字 0 和字符串 nil 已先让替身 hidden=YES，随后 dot 被抑制，hidden 才继续为 YES。这个条件链在日志中被分开记录，以免把“抑制重新显示”误写为“直接隐藏”。

真实 projection 的 `count=0/redDot=YES` 说明当前 getter 与 Hook 接口确实会丢失 dot 状态；是否应改变该隐私策略属于修复设计，本轮没有实施，也不据此断言它就是用户数字消失的唯一现场根因。

## 与几何证据分离

内容探针的固定 frame 是 `{{32,4},{24,16}}`，每条日志均注明 `fixed native host fixture; not device geometry`。该 frame 只用于证明提取的内容路径不需要修改 frame 就能在受控 native setter 中把内容隐藏，不能用于证明 item 层级、角标是否出界、被裁剪、被盖住或真机视觉表现。几何另由主任务独立探针/静态链/运行时采样验证。

复核命令为 `python3 docs/audits/tabbar-wechat-badge-2.1-6-2026-10-29/probe/run-content-write-probe.py`，输出仅本目录。它会核对历史输入、冻结来源、编译隔离 macOS host 可执行文件并重新生成四份受控日志，不生成 iOS 包，不修改原项目输入。正式现场结论仍需将样式开/关、冷态/消息后的实际 snapshot/cache/输入输出值与原生 badge 状态对照采样。
