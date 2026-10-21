# 原生展示链路证据

静态目标为微信 8.0.78 arm64，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。沿用仓库已确认的 Objective-C 方法地址，使用 LLVM 进行限定方法范围的只读反汇编；`methods.json`、`manifest.json` 记录范围和文件摘要。REA 会话检查确认没有已有分析会话，因此复用已保存证据并仅补取三个缺失方法，没有启动整份微信二进制的 Ghidra 分析。

- `tableView:willDisplayCell:forRowAtIndexPath:`：入口 `0x10a0c4378`。`0x10a0c43d0` 请求单元格布局；`0x10a0c44f8` 读取 `calcDataItemIndex:`，`0x10a0c456c` 读取 `getTimelineDataItemOfIndex:`。该显示阶段必须与数据源使用相同列表。
- `tableView:heightForRowAtIndexPath:`：入口 `0x10a0bfc38`。`0x10a0c0314` 读取 `heightOfTimelineCellInCache:`，随后依据点赞/评论及原生模型计算高度。
- `genNormalCell:indexPath:`：入口 `0x10a0c0b48`。`0x10a0c0bcc` / `0x10a0c0c40` 同样将 section 转为时间线索引，`0x10a0c11a0` 使用 `actionAreaVMOfTimelineCellInCache:`。

复用的 [1.8-49 原生方法证据](../../close-friends-1.8-49/timeline-native/README.md)：`reloadDataWrap`（`0x10a0b9048`）设置刷新标志、清理行刷新记录并调用 table reload；`viewDidLayoutSubviews` 的手机路径在 `0x10a0bb2a4` 请求 `reloadTableView`。因此“每次 native reload 标记布局，再在布局回调强制 layout”不能作为首屏修复，可能形成反馈循环。

上述为静态控制流与调用边界证据。没有手机运行时图层或栈采样，不能将具体黑色矩形归因到某个 UIView/CALayer，也不据此声称已在设备验证。
