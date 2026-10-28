# 2.1-3：返回前台的会话间隔画布恢复

以用户已安装的 `packages/2.1-2-muted-background/` 为基线；开始前 364 个构建输入 SHA256 全部匹配，见 [baseline-check.json](baseline-check.json)。在用户现有 checkout 实施；没有启动另一套服务、切数据库、改账号数据或安装到手机。源码起始副本为 [source-before.zip](source-before.zip)，独立构建目录见 [build-environment.json](build-environment.json)。

## 截图结论与根因

已直接查看 [真机原图](../../feedbacks/2026-10-27-foreground-gap-background-lost.jpg)：分组栏下、顶部信息卡下、文件传输助手下均有整宽黑带，末张卡片下方/悬浮底栏后也是黑色。卡片左右仍为浅灰；信息卡、单会话卡和服务 section 可见的首末圆角仍在；服务 section 内部多行及折叠入口仍连续。间隔高度没有消失，异常在 section 间隔及列表底部露出的画布，不能据此给每行额外添加 gap。

已证实的代码缺口有三层：

1. **画布与卡片是不同绘制层。** `CSListCornerPageContext.m` 的 `CSListCornerPrepareTable` 设置 table / backgroundView；启用圆角时浅色沿用 0.929 灰，深色沿用黑。`CSListCornerPrepareCellPaint` 单独设置每个 contentView 的侧边画布，`renderFirst:last:` 画内部卡片；因此 cell 正确不等于透明间隔下方的底色正确。
2. **section 间隔默认透明。** `ListCornerRadiusHooks.xm` 的 `CSListCornerSectionView` 采用 pinned/normal 配色；配置全零哨兵是 clearColor。它们及列表底部依赖 table 画布。旧 gap 只在创建时赋色，缺少已有视图恢复。
3. **旧恢复入口不完整。** 原先仅在控制器 viewDidAppear / viewDidLayoutSubviews 准备 table；cell 的 layout 只恢复内部卡片，不补 table。UIApplication/UIScene 返回 active 不保证这些控制器回调发生，table 自身稍后布局或背景替换也无 post-native 收口。分组 activityChanged 虽然调度投影刷新，却不负责画布。颜色值相同但图层需要重新显示时，旧链路也没有显式显示失效。

因此本次修复的是**前台恢复缺少外观重应用/显示失效，以及原生后续布局覆盖的收口**。现场将背景变黑的具体写入者尚无真机调用栈，不将这一点冒称已证实。原生类、方法编码、地址及局限见 [native-findings.md](native-findings.md)。

## 版本因果对照

[version-comparison.json](version-comparison.json) 同时对照仓库中两份 2.1-1 清单和初次 2.1-2 清单。两份 2.1-1 到已安装的 muted-background 版本，CSListCorner 系列、ListCornerRadiusHooks、SessionGroupHooks、CSGroupListAdapter、CSBackgroundBlurManager 均未变化。变化集中于 AI、后台同步、设置/发布信息。初次 2.1-2 → muted-background 变更为 CSAIReplyManager、CSBackgroundRunManager、ReleaseNotes，以及新增 CSAIBackgroundSync。

据此不能认定是 2.1-1/2.1-2 新引入的列表颜色回归。后台同步可能增加返回时数据变化的机会，但没有证据证明它直接改了画布；本轮不修改同步模块。用户是否以前也能复现、是否只在新未读时出现仍待真机分路径记录。

2.0-19 曾把列表画布与白色 cell 对齐，那是当时对卡片背景要求的判断；后续 2.0-20 已恢复卡片外浅灰/深色画布，2.0-21 恢复同 section 连续卡片。本次是这些既定颜色没有及时恢复，**不是再次把画布改白**，也不恢复折叠入口独立卡片。

## 收敛的修改

- 新增 `CSListCornerSessionRestore.h/.m`，只追踪经 owner 实际 m_tableView 复核的主会话表。table 持有观察者，观察者弱引用 table；gap 用弱集合，无全局 table/VC 强引用。
- 应用与 scene 的 foreground/active 同步恢复已有画布、gap 和卡片，并对现有表/背景/间隔/contentView/卡片调用 setNeedsDisplay；用 setNeedsLayout 请求正常布局。inactive-only 的切换器、通知中心和控制中心同样经过 active 入口。其他 scene、离窗表不误处理。
- 新增 `MainFrameTableView` 的 layoutSubviews、setBackgroundColor:、setBackgroundView: post-original Hook。叶类的完整原生调用返回后再修正；setter 只补 paint，有重入保护，不在 setter 中读取行角色。布局阶段复用现有 CSListCornerRefreshSessionGeometry。
- gap 改为插件自有轻量 UIView 子类，保留原 section/footer 颜色与 frame 算法，在自己的 layout 和恢复时重新应用已有配色。没有改 gap 数值或任何 header/footer 高度规则。
- 尺寸为零时保留既有几何，等原生有效 layout 再补，不轮询。没有固定延时、dispatch_async 重试、整表 reload、row/path 查询、contentOffset/contentInset 写入或投影重算。
- 未改分组增删/顺序、CSGroupCardPosition、未读/红点、标题摘要、密友/快照策略、卡片颜色或圆角语义。只在原生显示回调已建立的角色上恢复外观；新行与角色变化仍由原有分组/显示链交付。

UIKit 的下一次布局/显示提交是收口依据，不是猜测毫秒数：通知中同步补色，再标记布局；post-original 主表 layout 在完整原生布局返回后执行，之后的 table 背景 setter 也有同步收口。不能把这解释为已经观测了设备系统快照的提交时刻。

## 先红后绿与构建

只运行 `Tests/verify-list-corners.sh`，没有运行全量或 AI/备份等无关脚本。该脚本使用生产配置、渲染器、恢复类、真实分组角色/索引代码及提取的实际 Hook，UIKit 为 host 替身。

| 阶段 | 检查 | 失败 | 证据 |
|---|---:|---:|---|
| 旧 2.1-2 + 第一批新增用例 | 1,349 | 167 | [red-list-corners.log](red-list-corners.log) |
| 已补恢复，再验证属性未变但需重绘 | 1,357 | 3 | [red-display-invalidation.log](red-display-invalidation.log) |
| 最终代码 | **1,357** | **0** | [green-list-corners.log](green-list-corners.log) |

最终包含既有 1,016 项和新增 341 项。新增覆盖五条路径对应的生命周期序列、浅深色、未读不变/变化、section 数变化、单行/置顶/折叠角色、连续两轮、零尺寸、scene 匹配、后台返回时圆角关闭与再开、空表、自定义间隔色、setter 重入和颜色值相同的显示失效。断言不查询/重载数据、不移动滚动位置；没有声称 host 能验证 iOS 合成器像素或通知的真机发生概率。

首次完整独立构建及最终增量构建均保留日志；rootful/rootless 均编译 arm64 + arm64e。警告比较、包架构/路径、dSYM UUID、初始化顺序、源码冻结及历史文件保存结果见 [build-verification.json](build-verification.json)、[packages.json](packages.json)、[preservation.json](preservation.json)。

## 诊断

默认关闭。在当前微信 standardUserDefaults 中设置 Boolean `com.wechat.improve.listRestoreDiagnostics = YES` 后启用；不新增 UI，不写入会话或账号信息。若从偏好文件编辑，请完全退出微信后操作当前应用 CFBundleIdentifier 对应的偏好文件，完成采集后删除该键或设 NO。通过已连接设备的 macOS Console / Xcode 控制台筛选 `[WeChatImprove][ListRestore]`。

输出形如 `stage=active reason=restore_trigger_missing`。stage 包含 foreground / active / scene_foreground / scene_active / table_layout / table_color / background_view。reason 含义：

- `restore_trigger_missing`：经历 inactive 后还没有成功恢复，当前画布不匹配；本次事件负责补齐。
- `native_overwrite`：上次已成功应用相同目标配色，后来观察到背景不匹配；stage 可区分 table 布局、颜色 setter 或 backgroundView 替换。它证明状态被覆盖，不提供写入者的运行时调用栈。
- `geometry_not_ready`：table 或可见 cell 尺寸无效，保留原卡片，等待正常布局。
- `offscreen`：不在窗口，等待实际出现/布局；`ok`：完成校正或无属性差异时的重绘。

同一 stage/reason 去重，整个进程最多 48 条；没有定时采样、正文、会话名、账号标识。主机回归启用的是内存 volatile defaults，并验证去重后的日志，未修改微信偏好。

## 真机验收与待采集结果

当前没有连接运行微信的 iPhone；仅收到一张 2.1-2 截图和“滑动恢复”的反馈。下表的真机触发率和未读相关性均未知，不能把 host 的通知模拟写成真机必现。已向用户请求这些可选补充，出包不依赖其回复。

| 路径 | 已覆盖的 host 序列 | 2.1-2 真机频率 / 未读关联 | 2.1-3 真机结果 |
|---|---|---|---|
| 冷启动后后台返回 | resign → background → foreground → active | 待采集 | 待验收 |
| 锁屏解锁回微信 | 同上，另含 scene 恢复 | 待采集；实际 iOS 序列可能不同 | 待验收 |
| 切换器上滑后返回 | resign → active，无 background 必要条件 | 待采集 | 待验收 |
| 通知/控制中心收回 | resign → active，无 foreground 必要条件 | 待采集 | 待验收 |
| 别的 app 超过 1 分钟 | 完整 background/foreground；无时间依赖 | 待采集；host 不模拟真实挂起 | 待验收 |

安装匹配注入环境的 2.1-3，重开微信后：

1. 每条路径分别在“没有新未读”和“停留期间有新消息”两种条件下做至少两轮。返回第一眼不触摸列表，顶部/置顶/普通 section 间隔与底部应沿用配置底色；记录必现/偶发/未出现。
2. 保持滚动在中间返回，确认同一会话仍在原屏幕位置，无闪白或跳位。然后上下滚动回原位，检查没有新色块。
3. 浅色/深色分别检查短列表、长列表、空分组、单会话 section 和置顶区域。深色默认黑画布是既有配色，不应误报为浅色截图中的黑带问题。
4. 折叠入口与相邻会话同 section 连续、无额外间隙，只有整组首行上圆角/末行下圆角。摘要、未读与头像维持原行为。
5. 关闭圆角，按原设置生效方式检查平面外观无残卡；再打开并重复一次返回。若仍异常，提供触发路径、是否有新未读，以及上述 ListRestore 日志；不要发送账号或消息正文。

## 交付文件

- [com.wechat.improve_2.1-3_iphoneos-arm.deb](../../../packages/com.wechat.improve_2.1-3_iphoneos-arm.deb)；SHA256 `ca32bad136af1a45f2416cd10c3c89440df7bc9dbd4bb3a0e7bf7d2c55775551`。
- [com.wechat.improve_2.1-3_iphoneos-arm64.deb](../../../packages/com.wechat.improve_2.1-3_iphoneos-arm64.deb)；SHA256 `21cf9775940fe3cbd61925dfc0627a21b1d0d817d62970dc3dfa0f1bf7aae076`。
- [com.wechat.improve_2.1-3_symbols.zip](../../../packages/com.wechat.improve_2.1-3_symbols.zip)；SHA256 `ce23e6233ca4331077af7095a9cb88774de255af2cb8998b84830ec1220512a7`。

历史保护清单共 4576 个文件全部保持原始 SHA256：packages 18、历史审计 3345、工作区 .theos 1213。新增交付仅上述三个文件。控制文件、内置版本与发布说明均为 2.1-3。
