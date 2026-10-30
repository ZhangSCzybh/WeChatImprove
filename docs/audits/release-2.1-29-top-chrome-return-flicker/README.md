# 2.1-29 聊天返回顶部刷新候选

本轮已修正并打包一个由生产 Hook 受控执行确认的缺陷：`onActiveUsrNameChange:curUsrName:` 收到合法旧／新会话身份，却把它们丢弃并按未知内容变化发布，导致未变化的两个匿名业务行重新交付、搬移原生共享 banner。**这条机制尚未确认为用户手机轻微闪烁的现场根因；本轮没有真机运行次数或修复后复录。**

2.1-28 双包及布局候选已存在，因此按用户规则单独使用 **2.1-29**，当前只推荐这一版候选的匹配方案。旧包保持原样。基线提交为 `11a3d078f7f0c6a7751f5ca8a1d7e3a0c5213b41`。

## 计数、判断与边界

[运行通道检查](runtime-availability.json) 的实际结果：USB 设备数 0；Xcode 已配对 iPhone 状态 unavailable；Frida Python 枚举只有 host / local socket / GDB 的常规端点，没有可用手机。没有安装、启动、重启微信或更换账号、数据、设置。真机字段以 null / unknown 表示，不能当 0。

[主机原始记录与方法](host-probe/README.md)、[逐项前后矩阵](host-probe/active-user-hook-before-after-v2.json) 实际执行完整生产 Hook、事件事务、refresh、publication plan、布局、header、cell 及 viewport 方法；UIKit、原生快照、cell 工厂、attach 接纳及调度边界由明确输入的替身承担。不是另写发布算法，也不是手机自然事件序列。录屏没有被用于反推出以下调用次数。

以下是 `active-user-hook/valid-pair`、业务值未变、viewport 稳定的一次受控返回，数字为返回增量；此前每个顶部行已交付一次：

| 计数 | 冻结 2.1-28 | 2.1-29 候选 |
| --- | --- | --- |
| publication / 实际局部提交 | 1 / 1 | 1 / 1 |
| 归属 known / namesCount | false / 0 | true / 2 |
| 实际 row reload paths | [0,0]、[0,1]、[0,2] | 仅 [0,2] 普通会话 |
| 顶部每行 adapter 额外交付 | 1（累计 2） | 0（累计 1） |
| 顶部每行 host 原生构造／配置 getter | 1 | 0 |
| 每个共享 banner remove / add | 1 / 1 | 0 / 0 |
| banner 父容器身份 | 516→522、518→524 | 516→516、518→518 |
| 全表 reloadData | 0 | 0 |
| table layoutIfNeeded | 1 | 0 |
| adapter layout 入口 | 3 | 3 |
| publishHeader / 实际 table header setter | 0 / 0 | 0 / 0 |
| restoreAnchor offset | 20→20，写入 0 | 20→20，写入 0 |

原生构造／配置在替身中是同一次 getter，不能把这列冒充真机两个独立计数。对象数字仅是各主机进程中稳定的匿名 ID。

[微信 8.0.78 原生定点核查](native-active-handler.md) 另确认该回调本体是取消／切换选中会话，没有直接发送 banner/header 更新 selector；它支持此事件的会话归属。该静态结果没有覆盖取消／选择的完整派生调用图，也不能替代自然手机计数。

逐项核查三个候选方向：

1. **重复交付机制已在受控真实 Hook 执行中确认。** 合法 active-user 参数旧代码一律生成未知内容归属，匿名顶部业务行被保守重载，共享 UIView 转移到第二个容器。独立、已归属的 unread 清零只更新对应会话，不重挂顶部；无事件返回也不重挂。因此没有改普通 unread 规则或通用未知通知。
2. **稳定 viewport 下未观测到 restoreAnchor 回弹。** 显式模拟原生 inset 100→140、offset 20→-25 时，轨迹为 [-25,-20]，其中第一笔来自测试输入、第二笔为原有同步高度恢复，finish 的 restoreAnchor 是 -20→-20。它不证明手机自然路径没有位移。本轮未改 offset 方法。
3. **入口次数不能等同于真实重排。** 主机明确输入 viewDidLayoutSubviews、initTableHeaderView、setSearchBarToTableHeaderView 各 1 次时，adapter layout 共 8 次，实际 header 写入 0；没有这三项输入时 layout 共 3 次。宽度 320→321 的独立输入触发 header setter 同步重入 1 次，顶部额外交付、重挂和 offset 写入均 0。相同 frame 赋值在 UIKit 中的实际 layout／绘制仍需设备；没有因猜测而删 lifecycle 收口。

## 最小修改与保护

生产逻辑只改 [SessionGroupHooks.xm](../../../Hooks/SessionGroupHooks.xm)：

- 新增合法 old/new 会话身份的联合收集；一侧 nil 允许归属，任何非 nil 但不能可靠解析的参数整次回退未知；相同身份去重。
- 仅 active-user hook 将上述集合交给原有 native transaction，保留 Content|Structure、native index scope、同步结束与异常 finally。
- 真实未知通知继续将 pendingContentUnattributed 置真；合法外层内嵌真实未知通知后依然按未知刷新，测试中实际变更的 favorite/login 内容正常显示。

不改变投影算法、密友规则、圆角、搜索、底栏、AI 或备份逻辑。没有新增生产诊断计数、延时、隐藏、渐变、cover 或整表刷新。计数只在 Tests 与本审计中的可选观察器内。

[四个完整方法的最终逐字节检查](source-guard-final-check.json) 全部通过：2.1-26 setPresentationSuspended、2.1-27 refresh 与 publishProjection、2.1-28 performVisibleLayout。旧首发顺序、返回隐私前置和同步布局／位置保护保持原字节。[保护说明](source-guards.md) 与 [原始快照哈希](source-guard-sha256.json) 可复查。

control、版本头、应用内发布说明、README 统一为 2.1-29；说明明确待真机验收。[输入差异](input-differences.json) 在 42,513 份生产输入中只有 4 个文件变化：1 个逻辑文件及 3 个版本／说明文件。README、Tests 与审计单独列出。构建前后输入完全一致，绿色测试的 hook 快照与打包源码一致。

## 回归、构建和历史保护

- 最初 v1 在生产修改前跑出 **24 红**；扩展 v2 边界断言后，先执行冻结未修改的 2.1-28，再执行候选。v2 旧码结果为 **626 项中 40 红 / 586 通过**；[原始红日志](host-probe/red-v2-11a3d078-events.jsonl) 与 [退出码](host-probe/red-v2-11a3d078-run.json) 均保留，红跑通过项未计入成功总数。
- 候选同一套断言：**626 / 626 通过**；[绿日志](host-probe/green-v2-working-events.jsonl)。覆盖合法、单侧 nil、双侧 nil、空串、NSNull、身份冲突、同一身份、真实未知嵌套通知、实际业务内容更新、header 同步重入、viewport 输入。
- 限定既有回归：**1,606 / 1,606 通过**；[各组结果](focused-regressions.json)。范围为生命周期、顶部业务行、隐私边界、分组／聊天返回 viewport、搜索进入返回。本轮最终需求与既有回归合计 **2,232 项成功**，不重复累计纯测量或红跑通过项。
- [双方案构建](build-result.json) 成功，每方案包含 arm64 / arm64e。每方案 **6 条警告**，去 ANSI 后的完整多重集合与 2.1-28 布局候选逐条相同；没有新增警告。既有项为 UILocalNotification×2、statusBarFrame×2、ld multiply_defined×2。
- 构建使用独立临时目录，没有 make clean，没有写现有 .theos。**1,321 个既有 .theos／packages 文件**全部原哈希保留（其中历史 packages 84 个文件）；[保护结果](preserved-artifacts-after.json)。新目录不覆盖已有包。
- [包验证结果](package-verification.json) 校验双包元数据、安装前缀、payload、arm64/arm64e、4 份 dSYM UUID 和符号归档。正式校验值见 [SHA256SUMS](../../../packages/2.1-29-top-chrome-return-flicker/SHA256SUMS)。

## 当前候选产物

| 方案 | 文件 | SHA-256 |
| --- | --- | --- |
| Rootless | [com.wechat.improve_2.1-29_iphoneos-arm64.deb](../../../packages/2.1-29-top-chrome-return-flicker/com.wechat.improve_2.1-29_iphoneos-arm64.deb) | c3869e3a9cda8b8cea8f9059a50fe25c5e5cf9c2e6da83668af3054e0a5d8a4b |
| Rootful | [com.wechat.improve_2.1-29_iphoneos-arm.deb](../../../packages/2.1-29-top-chrome-return-flicker/com.wechat.improve_2.1-29_iphoneos-arm.deb) | 5f08c353efa40d7fb5d84d0894c6580b688e4f228d0e542499fb76f31947a77d |
| 调试符号 | [com.wechat.improve_2.1-29_symbols.zip](../../../packages/2.1-29-top-chrome-return-flicker/com.wechat.improve_2.1-29_symbols.zip) | 30e2c82016c79091a6ba9ec1b0645f5524523a92279aa8678948f00b05130d22 |

## 真机尚待闭环

[可选临时观察器与步骤](runtime-capture.md) 已离线审阅／语法检查，未在手机执行，也不随包加载。采样需保持同一微信、账号、设置和数据，覆盖列表基准→聊天→返回，并将自然 selector、归属、publication、实际 reload、cell、banner、header 和 offset 链条对齐录屏。

尚不能由主机证明：自然返回是否触发本次修正的 active-user 事件、其前后是否另有未知事件、真实 native cell 独立构造／配置次数、UIKit 内部父视图迁移和 layout／Core Animation 重绘、是否存在短于 30fps 一帧的闪烁、安装候选后是否肉眼无闪、手机真实返回首帧隐私／卡片／位置。**不能将这些写成已验证或零空白／错位帧。**
