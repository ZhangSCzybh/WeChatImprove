# 滚动位置回归的源码历史证据

用户确认的目标是：**跨组沿用当前滚动高度，从聊天返回时恢复离开列表前的高度**。用户观察到至少 2.2-8 已存在问题，2.2-6 之前的使用正常。本次读取源码历史用于查明待修逻辑，不能据此推定用户当时实际加载的每个候选安装包；用户观察与源码谱系分别记录。

`3810d7350ff27ce6290eb04f53c9e52da4c98da7`（2026-10-30，`control` 为 2.1-25）曾实现同一行为。提交正文明确写着：

> Share the current scroll height across groups and restore the departure height after returning from chats.

该提交在第一次离页时保存 `contentOffset.y + adjustedContentInset.top`、账号与 epoch；刷新时读取旧组的当前高度，在新组发布后恢复并夹在有效滚动范围内；`viewDidAppear:` 改为宿主实现与 attach 之后调用 `finishPresentationReturnForController:`。切组时取消了 `pendingScrollToTop=YES` 和删除目标 anchor 的代码。后续 2.1-31 提交 `0b53ff51` 仍保留这些行为。

`8467df87bebb2998f021238b7d88eaea65266214`（同日，2.2-1）的标题为 “Release 2.2-1 from verified 2.1-20 with manual backups and miniapp privacy fix”。其差异删除了上述离页高度和跨组恢复方法，把 `viewDidAppear:` 改回无条件 `returnToGroupTop`，并恢复切组时置 `pendingScrollToTop=YES` 与删除目标 anchor。当前 Git HEAD `863bfdb3`（原 2.2-6 起点）已经带有这些逻辑。

本次还只读核对了三次构建记录指向的冻结源码，并逐文件确认 SHA-256 与各自 `production-inputs.json` 相符：

| 冻结构建 | Hook 中自动回顶 | 切组时 pending top / 删除 anchor |
| --- | --- | --- |
| 原生分组 2.2-6 final | 第 138 行 | Adapter 第 1810 / 1811 行 |
| 空列表修复 2.2-7 | 第 138 行 | Adapter 第 1844 / 1845 行 |
| CPU 优化 2.2-8 | 第 155 行 | Adapter 第 1946 / 1947 行 |

因此，当前待修的两条强制回顶路径并非 2.2-8 的性能优化新增；它们已存在于这些旧冻结输入。**这些证据只确定源码引入与回退边界，不确定用户设备首次出现现象的具体版本或触发组合。** 本轮修复直接落实用户已确认的使用行为，保留当前隐私与性能实现，不整体回退旧版本。

可复跑的只读取证脚本为 [history-evidence.py](history-evidence.py)，具体提交、代码原文行号、三版冻结构建路径与哈希见 [history-evidence.json](history-evidence.json)。本次未改历史 audit、历史源码、安装包或设备状态。
