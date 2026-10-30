# 聊天返回顶部业务行：冻结 2.1-28 的主机探针

本目录只报告 **host-controlled 输入**。所有生命周期回调、事件注入、表头回调顺序、几何变化都由测试明确提供，没有真机事件顺序、真机次数、帧间隔或真实闪烁时长的证据。冻结基线时尚未修改生产代码；下方 v2 对照另外记录本轮最小候选修复。

基线为 `11a3d078f7f0c6a7751f5ca8a1d7e3a0c5213b41`。`baseline.json` 保存冻结 adapter、hooks、projection 源码哈希，也校验其余编译依赖与该提交一致。测试使用完整生产 `refresh`、`publishProjection`、`layout`、`publishHeader`、cell 交付、viewport、NativeEvent/NativeNotification 身份归属和 publication plan，未另写一个简化发布算法。

为观察入口/出口，五个提取方法只重命名定义，由同名 wrapper 计数：`layout`、`publishHeader:`、`cellForDisplayPath:target:`、`restoreAnchor`、`publishProjection:...`。方法体不改。精确抽取 `onActiveUsrNameChange:curUsrName:`、四个 appearance hook、三种 header 收口 hook、table header setter hook；`%orig` 替换成有日志的主机输入边界。原生桥 snapshot、UIKit/原生 cell 工厂与几何、attach 的接纳检查、调度器是 double，未模拟真实时间。原生 cell 工厂一次 getter 同时完成主机构造与配置，因此该项合并命名为 `hostNativeConstructConfigureCalls`，不能冒充真机的两个独立计数。

39 个情境包含：无事件、合法身份的会话 unread 9→0、真实 nil subject Content notification、业务文案确有变化、初始 setter 同步重入、返回 setter 实际同步重入、稳定 viewport、显式原生 viewport 变化输入、三种 header hook 各一次输入、active-user hook 的合法双身份/一侧 nil/两侧 nil/冲突身份。

## 冻结基线的主机计数

下表是稳定 viewport、deferred header setter、无额外 header callback 输入时的 **返回增量**。每个情境此前都已首次完整发布，顶部每行交付一次。`提交`只计算实际 table 操作，publication 方法接纳一次但 `publish.unchanged` 不算提交。

| 输入 | publication 归属 | full / row 操作 | 顶部每行额外交付 | 顶部每个共享 view remove / add | superview | offset 写入 |
|---|---|---|---:|---|---|---:|
| 无事件 | known=true，namesCount=0，Unknown | 0 / 0 | 0 | 0 / 0 | 不变 | 0 |
| `NativeEvent(friend, Content\|Unread)` | known=true，namesCount=1 | 0 / 1，仅 row 2 | 0 | 0 / 0 | 不变 | 0 |
| `NativeNotification(nil, Content)`，业务值不变 | known=false，namesCount=0 | 0 / 1，row 0/1/2 | 1 | 1 / 1 | 改变 | 0 |
| `NativeNotification(nil, Content)`，业务值确有变化 | known=false，namesCount=0 | 0 / 1，row 0/1/2 | 1 | 1 / 1 | 改变 | 0 |
| 精确 active-user hook，old/new 都合法 | known=false，namesCount=0 | 0 / 1，row 0/1/2 | 1 | 1 / 1 | 改变 | 0 |
| 精确 active-user hook，一侧合法另一侧 nil | known=false，namesCount=0 | 0 / 1，row 0/1/2 | 1 | 1 / 1 | 改变 | 0 |
| 精确 active-user hook，两侧 nil 或一侧冲突 | known=false，namesCount=0 | 0 / 1，row 0/1/2 | 1 | 1 / 1 | 改变 | 0 |

真实无归属 Content notification 的保守业务刷新被保留；主机将 favorite/login 源值改成新值后，返回能读取并渲染新值。不能直接禁止未知内容事件刷新顶部业务行。

无额外 header 输入时，返回调用 adapter `layout` 3 次，真实 table header 写入 0 次，`layoutIfNeeded` 对无事件/已归属事件为 0 次，对无归属内容事件为 1 次。主机显式请求三种 header 收口各一次时，adapter `layout` 合计 8 次，真实 table header 写入仍为 0 次。这说明入口次数不能直接视为重排次数。

另一个独立情境在返回时把主机 table width 320→321，触发 production header 发布并进入同步 setter 重入：真实 header 写入 1 次、顶部额外交付 0、共享 view remove/add 0、superview 不变、offset 写入 0。该几何变化是探针输入，不是从微信录屏推导的事实。

稳定 viewport 输入下，所有情境 `restoreAnchor` 轨迹 20→20，offset 写入 0。显式注入 inset 100→140、offset 20→-25 时，主机写入轨迹为 `[-25,-20]`：第一项由测试模拟原生 callback 写入，第二项按已保留的高度 120 恢复。最终 `finishPresentationReturn` 的 `restoreAnchor` 为 -20→-20，没有再次写入。该情境不能证明自然真机返回是否先移动过。

## 测量与需求断言分开

- `Tests/probe-group-return-banner.sh`：测量与已有行为保护，冻结源码 **539 检查 / 0 失败**，39 情境，2,153 条 JSONL。全绿只说明现有路径按当前定义运行，不能冒充本问题的红绿回归。
- `Tests/verify-group-return-banner.sh`：额外开启合法 active-user 身份事件的需求断言，冻结源码 **563 检查 / 24 失败 / 539 通过**，39 情境，2,177 条 JSONL，进程退出 1。红日志独立保留，未计为成功。

24 个失败来自三种合法身份情境，每种 8 项：known、old/new 身份集合，以及顶部每行的首次交付保留、superview 不变、无重新挂载。它证明 **如果主机明确调用该 selector**，旧 hook 丢弃合法参数会使匿名业务行进入保守重载；它不能证明一次自然微信返回实际调用过该 selector。两侧 nil/冲突身份必须继续未知 fallback，通用未知内容的真实业务值更新也必须保留。

`baseline-11a3d078-events.jsonl` 与 `red-11a3d078-events.jsonl` 是逐事件原始日志；对应 `*-counters.json` 汇总每情境计数，`*.stderr.log` 记录检查结果，`red-11a3d078-run.json` 记录红跑参数和退出码。

## 重跑

```sh
bash Tests/probe-group-return-banner.sh \
  docs/audits/release-2.1-29-top-chrome-return-flicker/host-probe/CSGroupListAdapter.m-2.1-28.txt \
  docs/audits/release-2.1-29-top-chrome-return-flicker/host-probe/SessionGroupHooks.xm-2.1-28.txt \
  docs/audits/release-2.1-29-top-chrome-return-flicker/host-probe/CSGroupProjection.m-2.1-28.txt \
  docs/audits/release-2.1-29-top-chrome-return-flicker/host-probe/CSGroupProjection.h-2.1-28.txt
```

需求断言将 runner 换成 `Tests/verify-group-return-banner.sh`，其余参数相同。省略参数会读取当前源码，应另存日志，不能覆盖冻结基线和红证据。

## 扩展 v2 的红绿与前后对照

根任务随后最小修改真实 active-user hook，将合法 old/new 身份联合传入原有 begin/end native transaction；生产变更快照为 `working-green-production.patch`，输入哈希和主机文件哈希在 `expanded-v2-inputs.json`，真实 hook 源码为 `SessionGroupHooks.xm-working-green.txt`。本次主机测试没有改生产代码。

v1 原始 JSONL、红日志、`baseline.json` 和源码冻结不改，另保留四个 v1 Tests 源文件快照与 `SHA256SUMS-v1`。在相同冻结 2.1-28 代码上，v2 独立重跑后再验证当前修改：

| 运行 | 情境 | 检查总数 | 失败 | 通过 | 原始日志 |
|---|---:|---:|---:|---:|---|
| 冻结 2.1-28，扩展需求断言 | 46 | 626 | 40 | 586 | `red-v2-11a3d078-events.jsonl` |
| 当前修改，完全相同需求断言 | 46 | 626 | 0 | 626 | `green-v2-working-events.jsonl` |
| 当前修改，纯测量/行为保护 | 46 | 586 | 0 | 586 | `measurement-v2-working-events.jsonl` |

40 个红项全部来自五个可归属身份情境，每种 8 项；它们分别是合法双身份、合法 old+nil new、nil old+合法 new、两侧同一身份去重、两侧匹配的合法身份对象。旧代码给这些输入一律 `known=false/namesCount=0`；修改后分别 `known=true/namesCount=2/1/1/1/1`。

| 受控执行真实 hook 的输入 | 修改前 | 修改后 |
|---|---|---|
| 合法身份情境，顶部值未变 | 一次 row reload 0/1/2；顶部每行新增交付 1、host native 构造配置 1、remove/add 各 1、superview 变化 | 一次 row reload 仅 row 2；顶部每行新增交付 0、host native 构造配置 0、remove/add 0、superview 与初次交付保持相同 |
| nil 两侧、任一侧空字符串、任一侧 NSNull、合法+冲突身份对象 | `known=false`，保守局部重载顶部 | `known=false`，相同行为 |
| 合法 active-user 外层内嵌真实无身份 Content notification | `known=false`，局部重载 0/1/2 | `known=false`，局部重载 0/1/2；内层明确修改的新 favorite/login 值正常渲染 |
| 全部新增 active-user 情境的 full reload / header 写入 / offset 写入 | 0 / 0 / 0 | 0 / 0 / 0 |

`active-user-hook-before-after-v2.json` 包含所有 13 个 active-user 情境的逐项前后计数及 superview 身份；各运行的 `*-counters.json` 保留全部 46 个情境。通用无归属 notification、真实顶部内容变化、header 实际重入、viewport 合成输入行为没有改变。

这些红绿证明的是受控输入执行真实 hook 后的行为变化。仍需真机采样证明自然聊天返回是否实际触发 active-user selector、各 native/UITableView 回调的真实次数，以及安装后肉眼轻微闪烁是否消失。主机不能提供自然手机根因已确认或零闪烁帧的结论。
