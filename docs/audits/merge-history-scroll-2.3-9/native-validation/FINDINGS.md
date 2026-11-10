# 2.3-9 历史加载滚动回退：原生调用证据

仅离线读取所提供的 WeChat 8.0.80 arm64 映像，没有执行微信、安装插件或修改聊天数据。映像 SHA-256：`571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`。`metadata.json` 保存真实继承、方法编码和地址；相邻 `.asm` 是定点反汇编，`-annotated.asm` 附同映像解析的 selector/ivar 注释。

## 已确认的历史补位路径

`BaseMsgContentViewController.onLoadMoreMessage` 的真实编码为 `v16@0:8`，IMP `0x10032d7d0`：

1. `0x10032d844`–`0x10032d870`：调用 `getCurContentSizeHeight` 保存旧累计高度，并保存旧 `contentOffset.y`。
2. `0x10032d8fc`：调用 delegate 的 `onLoadMoreMessage`，同步取得/加入历史节点。`addChatViewModel:addMoreMsg:` 在 `0x10032a908`–`0x10032a92c` 使用 `m_moreMsgIndex` 从数组前部插入节点。
3. `0x10032da64`–`0x10032da78`：再次调用 `getCurContentSizeHeight`，计算 `targetY = oldOffsetY + newHeight - oldHeight`。
4. `0x10032da88`：`reloadTableData`；`0x10032db94`（或 `0x10032db7c`）：将补位结果写回 contentOffset。边界还会按可滚动范围限位，无更多消息时扣除 header 高度。

`getCurContentSizeHeight` 的真实编码为 `Q16@0:8`，IMP `0x100302dc8`。它读取 `tableHeaderView.frame.size.height`，然后遍历 `m_arrMessageNodeData`，向每个节点发送 `sectionHeight`（`0x100302e98`、`0x100302ec0`）。**它不调用 table delegate 的显示行高。**

`BaseChatViewModel.sectionHeight`（`0x1002abe10`）单行直接调用 `rowHeight`，多行遍历 `cellDataForRow:` 后累加 `rowHeight`。`BaseChatViewModel.rowHeight`（`0x1002abf8c`）按需调用 `measure:`，在 `0x1002abfe4` 对测量高度取 ceil 并保存原生缓存。table delegate 原生实现也取这一缓存，但插件在其返回端另做紧密高度投影。因此历史补位累计与 table 最终显示累计不一致。

## 可独立复现的数值关系

合成回归坐标：旧原生总高 1400、旧显示总高 1000、旧 offset 120；插入后原生总高 2000、显示总高 1400。原生补位得到 `120 + 600 = 720`，显示坐标所需值是 `120 + 400 = 520`，向新消息方向回退 200。误差为 `Δ(原生累计高度 − 显示累计高度)`。这是用于验证逻辑的独立数字，不是设备测量。

## 最小修复方案的审阅约束

在 `onLoadMoreMessage` 完整同步事务内，将两次 `getCurContentSizeHeight` 的返回值投影为实际 delegate 显示高度，能够让原生补位继续使用原有算法，同时保留原生模型缓存。仅限 active、启用且范围匹配的 compact 配置和已检查的微信版本；事务外维持原返回值。先保存所有 native section 基线和 row counts，再逐 row 调用现有 table delegate，可以覆盖新增历史行及旧首条新形成的 join/name 决策，并避免在 delegate 重新测量后误减已变化的 native 基线。不得将 compact 高度写入模型原生缓存。

原生累计器从整数 header 开始，每个 section 后执行 `fcvtzu`（`0x100302ec4`–`0x100302ecc`）。在非负且无溢出的正常范围内，原返回值等于 `floor(header) + Σ floor(nativeSection)`。普通原生行高已 ceil，通常无小数；为严格保留原贡献，投影应使用：

`projected = originalTotal + Σ(displayedSection − floor(nativeSectionBaseline))`

最后按 `Q` ABI 转为 unsigned long long。显示高度仍应先按 double 累加，避免逐 section 丢弃显示坐标的小数。异常值、未知签名、重入及列表变化应回退原值。

## 回调与估高排查

`mmTableViewDidFinishedLoading:`（`0x1003353cc`）原生只有日志。`MMTableView.reloadData` 在 `0x11593d254` 先置 `_isReloadingData=YES`，super reload 及附属视图更新后于 `0x11593d2c0` 清零，再于 `0x11593d350` 同步发 finished-loading 回调。因此 `isReloadingData` guard 可防 reload 内部 flush，但完整历史 mutation 事务还必须覆盖 finished 回调及随后原生 contentOffset 写入。

BaseMsg 及其所有原生子类的 metadata 均没有 `estimatedHeightForRowAtIndexPath` 实现。`MMTableView.initWithFrame:style:` 在 `0x11593e048`–`0x11593e07c` 明确将 estimated row/header/footer height 设为 0；聊天 table 初始化使用这个 style initializer。静态证据不支持把此次回退归因于 estimated-height 切换。

8.0.80 的实际 addMessageNode 选择子带 `addNewMsg:` 参数，旧少参 hook 不命中；现有 `addChatViewModel:addMoreMsg:` 仍覆盖数组插入。本次最小方案无需扩展其他导航/翻译求和接口。

本审阅未运行 iOS UI。静态调用链及合成数值可确认累计高度不一致；真实设备滚动动量、限位和连续加载的最终表现仍由设备验收确认。
