# 首轮布局与返回位置的补充调查

本次沿用 2.1-27 `e9d4601c63fbfdeb11b208777ae9dc99f5f1c3c9` 为旧代码红测基线，同时检查首批 2.1-28 `af84d15d85cb056e3b9f5ea409f1c161590bb011` 的剩余布局边界。原包与原审计作为首批交付保留，本目录只记录补充修复。

## 录屏事实

直接从本地反馈视频读取第 78、96 帧，分别对应返回动画期间与稳定结果。第 78 帧还显示选中 Group 集合之外的普通私聊、服务号／公众号和受保护会话；第 96 帧的置顶卡片成员及普通区位置已改变。可见现象包含行集合、卡片角色与几何变化，不能仅以最终没有私密行作为通过条件。检查用截图保留在临时目录，不作为源码发布内容。

## 已关闭的原生集合通道

首批 2.1-28 已把完整主表原生 layout 置于 display scope。真实 `forwardInvocation:` 交付投影 section 和各 section 的过滤行数，并把高度查询按身份映射回原生路径。`CSGroupCardPosition` 在原生回调内把 path 映射为 display path，只依据投影 section 的实际行数确定 first/last。分组 active 时映射失败不会回退到原生首末行判断。

两条叶类 hook 顺序均兼容：`corner → group → native` 时圆角 post-repair 虽处于外层 native scope，但只复用已经记录的 first/last，不查询行数；`group → corner → native` 时整个圆角链均在 display scope。相关入口为 `CSListCornerPerformSessionTableLayout`、`CSListCornerRestoreSessionTable`、`CSListCornerRefreshSessionGeometry` 与 `CSListCornerSessionDecorate`。不需要修改圆角策略或整表结构。

## 首批 2.1-28 剩余的两个准备窗口

1. **返回数据尚未消费。** 既有 `setPresentationSuspended:forController:` 离页时设置 dirty 并使原生快照失效。原生 appearance 在 attach 之前可同步调用 table layout；首批 guard 只核对隐私版本和账户，无法证明 dirty 的当前行集合已经重建。因此离页期间结构变化时，第一轮仍可能使用旧投影的 section／数量／几何，再在 attach 刷新后归位。身份映射对失效身份的拒绝能够防止错误 cell 交付，但旧数量与占位并非稳定态几何。
2. **返回位置恢复晚于同步布局。** `viewWillAppear:` / `viewDidAppear:` 先调用原生 appearance，后 attach / finish；既有 refresh 内也是先 `publishProjection` / `layoutIfNeeded`，再 `restoreViewportFromTab:`。原生修改 inset／offset 后若同步布局，首批 guard 会保留这个临时位置。原有 viewport 测试模拟 top 从 100 改成 140、y 改成 -25，最终恢复为 y=360／有效高度 500，但只在 appearance 回调结束后断言。因此原有 151 项通过证明最终位置，不能证明首轮完整布局的结果。

补充方案只收紧 `performVisibleLayout:`：有效返回位置记录存在且 dirty 时先同步消费既有 refresh；若原有事务或交互条件使准备未完成，本轮不重新交付旧几何。真正布局前复用既有返回高度计算恢复位置，完整原生布局之后再用最终 contentSize/inset 同步收口。两步均在同一次调用内完成；后一步是对原生布局自身修正的最终校验，不等待后续 run loop 或动画结束。

保留既有 `presentationScrollHeight` 的账户、epoch、搜索及显式原生导航限制，以及 `restoreScrollHeight` 的交互保护与顶底夹取规则。没有引入新滚动规则；数据与布局仍使用原有 publication plan，不增加 reload 指令。2.1-26 suspension、2.1-27 refresh / publishProjection 的方法体保持原样。

## 验证边界

新增受控测试应把每次原始布局的行集合计算、圆角角色与几何记录下来，再在完整叶类布局返回时采集最终 offset／屏幕 y。这样可以观察真正的未过滤集合计算和首轮错误结果，同时不把一次同步布局内部的临时 setter 值等同于设备呈现帧。策略 blocked 时允许安全空内容，ready 后必须使用过滤后的稳定结果。

UIKit 的行高累加与 contentSize 可以使用明确的替身；section、身份、高度路径映射、圆角角色、索引域及返回高度／夹取逻辑应执行生产方法。两种 hook 顺序均需覆盖。host 结果不能测量 iOS 合成器帧，本次仍不以真机实测零错位帧作为交付结论。
