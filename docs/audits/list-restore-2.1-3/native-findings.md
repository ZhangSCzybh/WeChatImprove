# 8.0.78 主表恢复：只读原生核对

目标为 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，arm64，SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。使用 reverse-engineer-anything 工作流：REA open_binary 确认目标身份后，以既有 Mach-O metadata 解码器和有界 llvm-objdump 核对；没有启动整包 Ghidra 分析，没有运行、注入或连接微信进程，REA 会话已关闭。下述是静态指令证据，不是现场调用栈。

## 绘制者与恢复入口

| 证据 | 地址 / 编码 | 可确认内容 |
|---|---|---|
| 主表构建 | `NewMainFrameViewController.initTableView` `0x105113a28`，`v16@0:8` | `0x105113b94` 取 MainFrameTableView 类，`0x105113bb8` 调 initWithFrame:style:。`0x105113d20` 给 table 设置 clearColor；`0x105113e1c` 取 WCColor.BG_2，`0x105113e3c` 给新背景视图设色，`0x105113e58` 调 setBackgroundView:。原生确实分别拥有 table 与 backgroundView 两层。 |
| 类继承 | [class-chain.json](native/class-chain.json) | MainFrameTableView → MMMainTableView → MMTableView。前两类 metadata 未声明 layoutSubviews/background setter；UIKit 的背景 setter 属于继承接口。本轮在最窄的 MainFrameTableView 挂 post-original Hook，避免只在中间父类返回时过早修复。 |
| 原生 foreground 上报 | `willEnterForeground:` `0x105127290`，`v24@0:8@16` | 检查 top VC，取 indexPathsForVisibleRows，调用 onPageAppearWithVisibleCellsIndexPath:reason:。完整函数中没有直接的背景 setter、reloadData 或 layout 请求。 |
| 原生 foreground 状态恢复 | `onEnterForeground` `0x10510fbe8`，`v16@0:8` | 更新状态及 LiveItem；部分路径调 mainTableViewOffsetDidChangeTo: / bringSubviewToFront:。完整函数没有直接重新设置 table/backgroundView 的颜色。不能以“已经执行原生 foreground”代替插件外观恢复。 |
| 原生 active | `appBecomeActive` `0x105110df8`，`v16@0:8` | 移除通知观察、加入 lazy init、尾调 delayToLoadMainTableViewData。不是插件画布的恢复入口；不依赖它每次都被调用。 |
| 控制器 layout | `viewDidLayoutSubviews` `0x10511320c`，`v16@0:8` | 原生独立的布局入口。插件此前只有这个 Hook 和 viewDidAppear / cell 回调，应用重新 active 不等同于控制器重新出现或重新布局。 |
| table layout | `MMTableView.layoutSubviews` `0x116729e84`，`v16@0:8` | 先 super layout，再 reloadIndexView 和原生选择状态恢复；本轮通过实际叶类的 %orig 返回后收口，保证完整继承布局链返回后再校正。没有调用或替换原生滚动动画。 |
| 原生表尾 | `MMTableView.reloadTailColor` `0x1167275b8`，`v16@0:8` | 确实会生成/重设 native 尾部视图和 separatorInset；未证明它是本次前台黑带的触发者，故本轮不碰 tailColor/tableFooterView 或原生几何。 |

完整方法 metadata、起止边界和反汇编在 [native/](native/)；各选择函数均未被 24 KB 边界截断。轻量 ADRP/load 标注不是完整数据流反编译，原始指令与边界一并保留。

## 能确定与不能确定的界线

能确定：现有插件存在生命周期外观恢复缺口；section 间隔默认透明，露出 table/backgroundView；cell 侧边画布另行绘制；host 重现“原生背景被改/替换后返回但未发生控制器布局”的失效，并验证修复。也核实了 native 8.0.78 的真实主表类，修复不依赖猜测私有参数。

不能确定：用户设备上究竟是哪个原生/主题 setter、图层缓存或其他注入代码造成首次黑底；每条实际通知的先后顺序；五条路径的必现率；与新消息的统计相关性。截图和静态代码都不能替代运行时抓栈。诊断 `native_overwrite` 的含义是：此前成功应用的画布与当前属性不同，且当前目标配色没有变化；它不单凭日志归因到某个第三方调用者。

快照：现有 CSBackgroundBlurManager 会在退出模糊时短暂持有整窗 returnSnapshot，动画完成删除；这是另一个模块，未改动。截图中只有透明横带/表底变黑而侧边与内容正确，以及“必须滑动才恢复”的反馈，更支持画布恢复缺口；仍不能仅凭单帧彻底排除系统合成或其他插件快照。新增 setNeedsDisplay 覆盖颜色值未变化但缓存需要重绘的情况，不操纵任何隐私遮罩或快照。
