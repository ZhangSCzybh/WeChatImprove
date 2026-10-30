# 2.1-31：服务聚合行误遮罩与返回滚动范围保护

本轮从未修改的 2.1-30（`58e0b0dfc611e14aa2d2f8e07c0f2ffb80a7ec6a`）开始，在原 checkout 完成修复、红绿回归与双架构打包。未连接或安装真机。本报告把源码机制、主机受控计数、既有录屏像素事实分开；它们不能替代真实微信生命周期或触摸日志。

## 1. 两行为什么被判敏感

`shieldVisiblePrivateRows` 原来把所有 `Aggregate && protectedUserNames.count>0` 行直接判敏感。主机按真实 projection/policy/adapter/shield 提取源码运行时，公众号 `brandsessionholder`、服务号 `brandservicesessionholder` 均为 `unknown=0`、直接 hidesUserName 命中=0、kind Aggregate=1、protectedNames=2、泛化聚合条件=1，最终 hidden=1。这个条件独立足以复现误伤，无须 delivery 缺失或账号错误。它不是手机那次回调所读取变量的实测值。

在两组 controlled miniapp/chat 入口中，锁定态 Whole、Service 每组误藏两条无关聚合行；Group/Friend 测试集合不包含这两条，误藏0。解锁态误藏0。修复后已就绪的四个 tab 普通行与无关聚合行均不被 individually hidden；旧交付里的真实密友/密群仍被隐藏。ChatBox 沿用原有摘要/隐私 cover；无法确定的旧摘要走完整中性化，不再把服务聚合容器泛化成敏感内容。

策略缺失、blocked、delivery 缺失、delivery/account 错配等20组未知输入统一使用空内容 layer mask，individual hidden 状态变化0。该 mask 不包含截图，没有动画、透明度过渡或固定等待；只由就绪与发布核验控制解除，保留 table、cell、手势和命中测试对象。accessibility 内容同时中性化。准备复用 cell 时保持整个 mask，避免提前暴露旧内容。

判据与原始计数见 [service-probe/README.md](service-probe/README.md)、[stage-comparison.json](service-probe/stage-comparison.json)。

## 2. 哪一环丢了滚动能力

2.1-30 UI proxy 在未就绪时把所有返回值初始化为0后直接返回，其中包括 section/row 数量和行/section 高度。主机真实 proxy 的受控重放证明，它会把可滚动盒压缩；同一路径没有把 scrollEnabled 或手势 enabled 改为 false。不能仅凭录屏反推手机那次 contentSize 或触摸接收状态。

| controlled blocked miniapp 阶段 | 原 2.1-30 | 2.1-31 |
| --- | ---: | ---: |
| 原 contentSize | 320×1244 | 320×1244 |
| 未就绪 contentSize | 320×80 | 320×1244 |
| 未就绪 cell 数 | 0 | 18个无内容槽位 |
| inset top / bottom | 100 / 0 | 100 / 0 |
| 原 offset.y | 400 | 400 |
| 人造 +40px 拖动后 | -100，被压缩范围 clamp | 440 |
| 就绪恢复真实内容后 | -100 | 400 |
| 未就绪 protected native cell getter | 0 | 0 |
| 未就绪 native-scope 行选择交付 | 1 | 0 |
| 未就绪 scroll callback 交付 | 1 | 1 |
| 未就绪查询新增整表刷新 | 0 | 0 |

最终实现保存已发布的数值 section/row 数量和总包围盒，不缓存消息或依赖每条 offscreen 行高都被查询过。中性槽位的高度只用于保持总滚动范围，最后一槽补余数；没有既有拓扑时使用单个无内容占位。真实内容发布前，在 mask 内使用无动画的 begin/endUpdates 重新测量真实行高，不重建数据；仅对 identity 不匹配的当前可见 cell 使用局部 reloadRows。稳定普通行和 banner 的交付正确时不进入这组局部修复。

中性化期间禁止原生内容 getter、标题/视图及行选择/编辑等回调，scroll callbacks 继续转发。拖动期间不反复钉死 offset；策略就绪后若手势还在进行，保持中性态，结束时恢复保存的安全位置，再复核 account/epoch/policy 和可见 delivery 后显示。代理显式实现滚动结束回调，原生 delegate 没有该 optional 方法也能收口。原生回调、局部布局和 offset 写入都可能重入，所以解除 mask 前再次检查准入。

详见 [scroll-probe/README.md](scroll-probe/README.md)。交互和 gesture enabled 值是可访问的主机替身控制量，真实 UIView/CALayer/触摸链路未经设备验证。

## 3. 改动范围与历史修复

- `CSGroupListAdapter.m`：收窄个别行遮罩判据；中性查询保留数值拓扑与范围；拦截不可见行操作；在独立的完成方法中测量、局部修复和恢复安全位置。
- `CSCloseFriendListShield.h/.m`：保存原 layer mask/accessibility 状态和中性几何，支持完整内容中性化及经过核验的统一恢复。
- `CSGroupListAdapter.h` 与 `SessionGroupHooks.xm`：只增加表格完成布局后的中性发布收口入口，不改变圆角绘制。`ListCornerRadiusHooks`、隐私 policy、底栏角标、AI、备份代码均未修改。
- `control`、`Headers/CSUserInfoHelper.h`、应用内说明、README 同步2.1-31。测试替身与提取器适配新增API；修正两条旧的中性表现断言，隐私断言保留。

用户指定六处定义在修改前、构建前、最终核验时均逐字节一致。完整 SHA256 在 [source-guards.md](source-guards.md)，最终核验为 [source-guard-final-check.json](source-guard-final-check.json)。首次 reload/layout 的顺序、返回过滤的 performVisibleLayout、active-user 归属算法均保持；新增逻辑只在外层准入和中性发布完成阶段起作用。

## 4. 红绿结果与过程记录

| 新测试（同一最终断言集） | 未修改2.1-30 | 修复后 |
| --- | --- | --- |
| Service/普通行/unknown边界 | 706项，76失败 | 706项，0失败 |
| 返回滚动/隐私/占位 | 148项，73失败 | 148项，0失败 |
| 中性完成/局部修复/策略重入 | 36项，15失败 | 36项，0失败 |

新成功断言890项；加上既有重点回归4966项，最终合计 **5856项，0失败**。红测通过项、重复运行和控制运行不计入成功总数。逐组日志在 [final-regression-summary.json](final-regression-summary.json) 指向的16组文件，覆盖生命周期、顶部首次发布/聊天返回、隐私与解锁、分组/滚动、搜索及既有圆角兼容性。

初次回归的提取器编译失败和两条旧占位行高表现断言失败均保留在 regression/、regression-final/，最终适配后通过。还有一条既有250ms墙钟断言在并行运行时失败（`continuous notifications flush at the maximum window instead of waiting for silence`），原失败日志保留。未修改调度/角标代码；串行当前版239项全过，原版未修改测试/源码控制同样239项全过，相关源码字节不变证据见 lifecycle-timing-controls.json。测试替身的运行时间不等于手机动画耗时。

## 5. 录屏复核与真机边界

原始文件解码为HEVC、592×1280、120样本、4秒。按presentation-order从0编号，64–66帧列表完整露出但聚合行ROI蓝像素0、底板ROI RGB234；67帧（PTS2.233333333）恢复，蓝像素4463，白底占比0.92164。审计保留0/1基编号和原PTS，避免与用户给出的“第70帧”混淆。下方图标质心只变化约0.0262px，因此不把这段视频写成“下方真实行整体上移177px”。详见 [frame-evidence/README.md](frame-evidence/README.md)。仅提交匿名数值，不提交用户录屏或带昵称/头像的派生图。

设备可用性：USB0，配对Xcode设备unavailable。因此以下仍须真机同路径复录，不能写成已验证：自然 miniapp/chat 返回的具体 lifecycle/策略到达事件与各回调真实次数；真实 contentSize/inset/offset 和手势开关；真实触摸命中、上下左右拖动；真实 UIView/banner/CALayer 身份；Core Animation 的中间帧、隐私内容零可见窗口、mask解除时机和实际滚动恢复时长。主机通过的是提取的真实源码在受控替身序列上的契约。

## 6. 构建与产物

两方案在新建临时目录构建，无 make clean；每方案6条警告，规范化多重集合与2.1-30完全相同（UILocalNotification×2、statusBarFrame×2、multiply_defined×2），新增警告0。42513个生产输入构建前后相同，和基线的8项生产差异见 [input-differences.json](input-differences.json)。1329个任务开始已有packages/.theos文件、其中92个历史包目录文件全部原字节保持，没有任何豁免或覆盖。

独立验证通过：2包元数据/payload/rootful与rootless前缀/arm64与arm64e/部署目标/依赖、4份dSYM UUID、12个符号归档文件、ZIP CRC和SHA256SUMS。报告见 [release-verification-summary.json](release-verification-summary.json)。

交付目录：`packages/2.1-31-service-tab-and-scroll/`。

```text
dcf32aba0df39eef113954e1f73d88a321adfb6b3b9f8ac44232ffcc00a53d5f  com.wechat.improve_2.1-31_iphoneos-arm.deb
e5c6a8884d0ece2afed04d39df33448bc656f372ac8141ce810dde1f7fead344  com.wechat.improve_2.1-31_iphoneos-arm64.deb
3b3f60c233c851ee2406f9981ea74c55485147b844a3e56302b50cf21f5960fc  com.wechat.improve_2.1-31_symbols.zip
```
