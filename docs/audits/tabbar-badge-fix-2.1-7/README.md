# 2.1-7 底栏原生角标正式补丁

日期：2026-10-29。基线：本轮开始时的当前工作区，2.1-6 授权清理后。目标：微信 8.0.78 / build 8.0.78.34。用户已确认按[上一轮报告第 4 节](../tabbar-badge-2026-10-28/README.md#4-最小修改方案供后续确认实施)实施。

**正式补丁、冻结测试先红后绿、四项既有回归、rootful/rootless 构建和包校验均已完成，版本为 2.1-7。** 生产逻辑仅修改底栏 adapter 和必要 Hook，另更新两个版本声明。未连接手机执行微信；本报告中的通过结论针对源码、host 几何契约和构建产物，真实裁剪链、视觉呈现及滚动性能留待第 8 节真机验收。

## 1. 根因回顾与原生依据

原生 `imageView` 和 `badgeView` 是 item 的兄弟视图。`imageView.autoresizingMask=FlexibleLeftMargin`，item 缩窄时 image.x 自动平移，而 badge 不同步平移。旧 `CSApplyItem` 在 item 改宽后才采样两者，将不同几何阶段的 frame 相减，额外算入 `原生 item 宽度 − 样式 item 宽度`，可将角标整枚移出所属 item。原生 `layoutBadgeView` 及其 `%orig` 一直可达，缺陷不在漏调 Hook。

微信原生的两种规则也不同：纯红点 `y=image.y`、右边贴 `image.right`；数字/非空字符串 `y=4`、`x=item.width/2+3`。`MMBadgeView.setFrame:` 再对 origin 作像素取整，对 size 作向上像素对齐。因此必须同步调用原生方法得到当前 item 几何下的一对真实 frame，并用最终 getter 记录实际偏移。

沿用上一轮留存的[原生静态证据索引](../tabbar-badge-2026-10-28/native/README.md)，目标可执行文件 SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。关键证据为 `setupUI`、`layoutIcon`、`layoutBadgeView`、`getBadgeViewRightMarginPortrait`、`relayoutIconAndBadge`、`MMBadgeView.setFrame:`。本轮没有把替身层级当作新的真机观测，也没有重新推定用户手机的实际裁剪开关。

## 2. 正式补丁点与边界

完整生产改动见 [production.patch](production.patch)，它相对本轮工作区基线生成，包含原有未提交改动之上的本次增量。

| 文件 / 方法 / 当前行 | 修改及原因 |
| --- | --- |
| [CSTabBarNativeAdapter.m:169](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarNativeAdapter.m:169)，`CSLayoutNativeItem` | 沿用 item depth，在 `@try/@finally` 中配对；`performWithoutAnimation` 同步执行原生 `layoutIcon`、`layoutBadgeView`。嵌套 Hook 保持 depth 非零，不再次 apply。 |
| [CSTabBarNativeAdapter.m:210](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarNativeAdapter.m:210)，`CSApplyItem` | `CSRestoreItem` 之后、采样 image/text/badge frame 之前调用上述 helper；随后执行原有图标尺寸和布局公式。没有将采样简单挪到 item 改宽之前。 |
| [CSTabBarNativeAdapter.m:243](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarNativeAdapter.m:243)，badge 写回 | 请求位置先交给原生 setter；读取实际 getter，必要时只约束插件新增越界；最后再次读 getter，以实际 origin 相对原生基线记录 `badgeOffset`，供 restore 使用。 |
| [CSTabBarNativeAdapter.m:179](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarNativeAdapter.m:179)，`CSConstrainBadgePosition` | 按实际原生 frame、实际 badge size 和当前 bounds 限制新增的四侧越界。仅修必要的 x/y，保留原生已有越界；推导见第 3 节。 |
| [CSTabBarNativeAdapter.m:294](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarNativeAdapter.m:294)，`CSRestoreGeometry` | 恢复 button/item 原始 frame 后，对已有 item state 的对象同步重建原生 icon/badge 几何，覆盖立即关闭样式时的坐标恢复。 |
| [TabBarStyleHooks.xm:67](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/TabBarStyleHooks.xm:67)，`relayoutIconAndBadge` | 新增已有形式的 `Begin → %orig → End` 外层包装，使 reload/icon/badge 三个子调用统一收尾；选择依据是第 6 节的双模式调用量实测。 |
| [control:3](/Users/zhangshichao/Documents/Workspace/WeChatImprove/control:3)、[CSUserInfoHelper.h:17](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Headers/CSUserInfoHelper.h:17) | 版本统一升为 `2.1-7`。 |

角标始终是微信提供的同一个对象；插件没有创建、复制或替换 badge，没有写入其数值、字符串、字号、形状、hidden/alpha 或父视图。badge 的 frame 写入保留当前 size；微信自行更新的 size 不回退为历史值。自定义图标从读取到最终 image/text frame 的原布局块与基线逐字节一致，共 1,413 字节。

正常路径只需一次 badge frame 实际赋值；第二个 `CSSetFrame` 在 frame 相同时为 no-op，只有新增越界时最多再赋值一次。没有累加偏移、定时器、轮询、固定延时、整栏重载或隐藏背景的补偿。新增原生方法同步调用处于现有 depth 事务内；已有点击动画没有被清空。授权、列表圆角/画布、AI、定时发送、备份及密友源码未改。

原生 `layoutIcon` 会管理 native customIcon 的挂载、送后、显隐与 mask；这属于选定方案的真实副作用面。独立静态审查未发现需要报停的业务值改写或不可接受副作用证据，但没有以此替代设备验收。详情和数值前提见 [source-review.md](source-review.md)。

## 3. 最窄档 99+：保留原生越界，只约束插件增量

**上一轮实验的 2,080 次部分越出 item，全部集中在 `.6` 档宽数字/99+；在该实验默认原生图标宽 28、文字行高 12、代表 badge 宽 30 的输入下，同样窄的 item 中原生数字位置已经会产生右越界。修复基线后的图标平移没有新增这部分右越界。正式补丁保留这一观感，不缩角标、不改内容，也不修改裁剪开关。**

例如四项均分 390pt bar，`.6` 档 item 宽 58.5pt，@3x、badge 宽 30pt：同宽原生数字的实际 x 为 32⅓，右边 62⅓，原生右越界 3⅚pt；样式图标宽 28 时维持同样越界，宽 20 时左移 4pt 后已在 item 内。这里的 30pt 是 host 代表尺寸，不能当作设备实际 99+ 测字结果。

另有确实属于插件增量的边界：实际原生 `customSize` 比最终样式图标更窄时，图标平移可能新增右越界；44pt 高度配较高文字时，平移可能新增顶部越界。因此正式实现按用户允许的“只调整位置”作最小约束，依据同步 getter，不假定原生图标永远是 28pt，也不读取或猜测 `clipsToBounds`。

设当前 item.bounds 为 `B`，同步原生 badge.frame 为 `N`，实际 badge size 为 `W/H`。允许的 origin 区间为：

```text
x ∈ [min(B.minX, N.minX), max(B.maxX, N.maxX) − W]
y ∈ [min(B.minY, N.minY), max(B.maxY, N.maxY) − H]
```

它等价于逐侧要求 `样式越界 ≤ 同宽原生越界`，原生 origin 本身在区间内；badge 比 item 宽也有解。先把候选交给原生 setter，读取实际 frame。只有越出上述区间的轴，才向内取屏幕像素格点上下界并夹取；正常轴保持原生 setter 的实际结果。浮点容差仅为 `1e−6` 像素，异常区间回退该轴原生 origin。最终 getter 再用于 offset 配对。没有硬编码数字 badge 的宽度或原生定位公式作为产品布局。

完整计数、静态地址、推导及限制见 [native-overflow-analysis.md](native-overflow-analysis.md)。正式测试每模式有 782,720 次同宽原生 getter 对照，其中 36,784 次原生本就部分越界；均按“不新增四侧越界”检查，没有用强制包含于 item 的断言掩盖原生边界。

## 4. 先红后绿与样式矩阵

正式新增 [TabBarBadgeTests.m](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Tests/TabBarBadgeTests.m)，直接编译真实 adapter/preference。替身补入经静态确认的 FlexibleLeftMargin 宽度变化、红点/数字两套定位和 `MMBadgeView` 的像素对齐。使用独立的、同宽且不带样式的原生对象产生 getter 对照，不逐行复制生产位置约束公式。

新增 Hook 源码提取校验器，校验真实 `Begin/%orig/End` 顺序；`source` 模式按实际源 Hook 嵌套，`without-relayout` 模式只禁用外层复合包装，用相同 adapter 和断言比较调用量。原有 `TabBarNativeTests.m` 未修改；共享 UIKit 替身仅新增 `UIScreen.scale` 接口，没有把 badge 层级或全局 autoresizing 强塞进旧 fixture。

| 阶段 | 生产输入 / 模式 | 组合数 | 断言数 | 失败数 | 退出码 / 原始日志 |
| --- | --- | ---: | ---: | ---: | --- |
| 红 | 旧 2.1-6 adapter + 旧 Hook，source | 560 | 16,000,960 | **302,796** | 1，[冻结红日志](logs/red-final-source.log) |
| 绿 | 修复 adapter + 复合 Hook，source | 560 | 16,000,960 | **0** | 0，[正式绿日志](logs/green-badge-source.log) |
| 绿，对照 | 同一修复 adapter，禁用复合包装 | 560 | 16,000,960 | **0** | 0，[对照日志](logs/green-badge-without-relayout.log) |

红测为成功编译后断言失败，包含首次开启时角标整枚与 item 无交集，以及新增越界。冻结的六个 Tests 输入在红、绿和最终工作区 SHA 完全相同；每阶段 12 个输入运行前后也完全相同。基线副本保存在 [red-source-snapshot/](red-source-snapshot/)，前后 SHA 见 [red-stage.json](red-stage.json)、[green-stage.json](green-stage.json)。预冻结初期日志的 302,800 不作为本次正式红绿对照值。

默认矩阵为五档宽度 × 四种内容 × 保留/隐藏文字 × 系统/导入图标 × @2x/@3x × 高 44/52/80，共 **480 组合**。每个宽度×内容格有 24 个组合；下表数量由冻结循环基数及完整成功退出得出，没有伪称每格有独立日志。

| 宽度 | 纯红点 | 1 | 12 | 99+ |
| --- | ---: | ---: | ---: | ---: |
| .6 | 24/24 PASS | 24/24 PASS | 24/24 PASS | 24/24 PASS |
| .7 | 24/24 PASS | 24/24 PASS | 24/24 PASS | 24/24 PASS |
| .8 | 24/24 PASS | 24/24 PASS | 24/24 PASS | 24/24 PASS |
| .9 | 24/24 PASS | 24/24 PASS | 24/24 PASS | 24/24 PASS |
| 1.0 | 24/24 PASS | 24/24 PASS | 24/24 PASS | 24/24 PASS |

另有 **80 组合**验证文字行高 20/高度 44、原生 customSize 20×20/高度 52 两类边界，全部通过。每个组合检查四个 item，执行首次开启、100 次普通 Update、100 次 item 原生布局、100 次完整 bar 原生布局、20 次开关配对和最终关闭还原；包含动态内容更新及微信自行隐藏角标的路径。两组外观/选择属性和 detach/attach 也纳入，但不等同于全部真实状态切换。

断言验证同一 badge 对象及 superview、size/hidden/alpha、有限非空 frame、与 item 有交集、相对同宽原生不新增任何侧越界、结构 z 序、稳态不漂移，以及关闭后的当前原生位置。没有删除既有用例，也没有在转绿时改断言或放宽容差。详见 [badge-regression.md](badge-regression.md)、[badge-coverage-matrix.json](badge-coverage-matrix.json)。

## 5. 既有回归

| 脚本 | 结果 | 日志 / 说明 |
| --- | --- | --- |
| `bash Tests/verify-tabbar.sh` | PASS | [verify-tabbar.log](logs/verify-tabbar.log)：geometry、click effect 39 checks、preferences/native lifecycle；新增 badge 两模式各 560 组合、16,000,960 checks、0 failures。 |
| `bash Tests/verify-list-corners.sh` | PASS | [verify-list-corners.log](logs/verify-list-corners.log)：1,623 checks，0 failures。 |
| `bash Tests/verify-managed-image-files.sh` | PASS | [verify-managed-image-files.log](logs/verify-managed-image-files.log)：125 + 29 checks；包含预期的目录被同名文件占用失败路径日志，脚本正常通过。 |
| `bash Tests/verify-backup-bootstrap.sh` | PASS | [verify-backup-bootstrap.log](logs/verify-backup-bootstrap.log)：36 checks；35 gated feature files、8 independent native adapters、2 recovery files；Logos 生成、iOS arm64 语法和 Objective-C++ C linkage 均通过。 |

Tests 使用隔离的 NSUserDefaults suite、临时图片和编译目录，没有读写用户真实微信账号或数据。

## 6. 原生调用量比较与正式选择

同一冻结测试在固定配置下分别重复每种事件 100 次，统计真实 adapter 调用到替身原生方法体的次数；独立原生对照对象不计入。下表均为**每次事件的 `layoutIcon + layoutBadgeView` 合计**，并明确区分单 item 与四项总量。

| 事件 / 统计单位 | 样式关闭 | 修复，无复合包装 | 正式修复，有复合包装 | 正式相对关闭的额外调用 |
| --- | ---: | ---: | ---: | ---: |
| 直接 `relayoutIconAndBadge`，单 item | 2 | 8 | **4** | +2 |
| `layoutSubviews`，单 item | 2 | 4 | 4 | +2 |
| 独立 `layoutIcon`，单 item | 1 | 3 | 3 | +2 |
| 独立 `layoutBadgeView`，单 item | 1 | 3 | 3 | +2 |
| 普通 Update，每 item | 0 | 4 | 4 | +4 |
| 普通 Update，四项总计 | 0 | 16 | 16 | +16 |
| 完整 bar.layout，每 item | 2 | 6 | 6 | +4 |
| 完整 bar.layout，四项总计 | 8 | 24 | 24 | +16 |

**正式保留复合方法的 Begin/End 包装。** 100 次直接复合布局，无包装时 icon/badge 各 400 次；有包装时各 200 次，几何方法总数减少 50%，额外量由每事件 +6 降到 +2。两种模式原生 `reloadIconImage` 均为 100 次，没有新增图片 reload。已有 item 外层包装的路径、普通 Update 和完整 bar.layout 不因此减少。

普通 Update 需要先在恢复宽度下同步一对、再在样式宽度下同步一对，因此每 item 仍有 4 次原生几何调用。该固定开销是本方案维持配对正确性的代价；当前证据支持采用调用更少的包装实现，没有发现递归或无界叠加。**可以接受为本次补丁的有界结构开销，不能据此认定真机滚动无掉帧。** 设备耗时、CPU/GPU 与 FPS 尚未测量，必须按第 8 节验收。

上一轮的 2,726,400 → 7,259,520（约 2.66 倍）是旧隔离探针完整循环的累计 badge 调用数；本轮正式矩阵与计数口径不同，不能直接拿上述每事件总几何次数声称已消除该倍率。完整分项数据含旧 adapter 对照，见 [native-event-comparison.json](native-event-comparison.json)、[source 原始计数](green-native-event-counts-source.json)、[无包装原始计数](green-native-event-counts-without-relayout.json)。

## 7. 构建、包校验与历史保留

两个方案均在独立的临时 Theos build/local-data 目录构建，产物只写入新目录 [packages/2.1-7-tabbar-badge/](../../../packages/2.1-7-tabbar-badge/)。没有执行 `make clean`、`make install` 或设备安装，没有切换用户注入环境、服务、账号或数据库。构建命令及退出码见 [rootless 记录](build-rootless-result.json)、[rootful 记录](build-rootful-result.json)，脚本见 [build-release.py](build-release.py)。

| 方案 | 构建 | 警告 | DEB 架构 | dylib 切片 / 最低 iOS | 安装路径 |
| --- | --- | --- | --- | --- | --- |
| rootless | PASS，exit 0 | 6 条历史警告；改动文件 0 | `iphoneos-arm64` | arm64 + arm64e；两者 15.0 | `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |
| rootful | PASS，exit 0 | 6 条历史警告；改动文件 0 | `iphoneos-arm` | arm64 + arm64e；两者 15.0 | `/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib` |

历史警告为两架构各一次 `UILocalNotification` 废弃、`statusBarFrame` 废弃及 `-multiply_defined` 过时，共 6 条/方案。详见 [warnings.json](warnings.json)、[rootless 构建日志](logs/build-rootless.log)、[rootful 构建日志](logs/build-rootful.log)。

DEB 元数据版本 2.1-7、安装前缀、两架构和最低系统均通过；注入 filter 与工作区原文件一致。符号包包含两个方案各两架构的 dSYM，共 12 个文件，ZIP CRC 通过。以下四个 UUID 均逐一确认 dylib 与对应 dSYM 相等：

| 方案 | 架构 | UUID |
| --- | --- | --- |
| rootless | arm64 | `E6466C5E-07C1-319E-80F8-CD1FDE640010` |
| rootless | arm64e | `530123F5-6B0A-353E-88B5-52975039DD44` |
| rootful | arm64 | `A8FB04CC-CD0C-3F71-9158-A110F10D3ECD` |
| rootful | arm64e | `1D476E06-8208-30D8-8F23-6222F84ADE76` |

| 文件 | 字节数 | SHA-256 |
| --- | ---: | --- |
| [rootless DEB](../../../packages/2.1-7-tabbar-badge/com.wechat.improve_2.1-7_iphoneos-arm64.deb) | 1,409,342 | `0ca52f0761c23b9e6cefbeaa618d8ed6c94cef810947cb8d7c882460a9443364` |
| [rootful DEB](../../../packages/2.1-7-tabbar-badge/com.wechat.improve_2.1-7_iphoneos-arm.deb) | 1,409,992 | `08758c013e428596aa324743bfad8deabaf070fba2d216c7b286f63171cbc151` |
| [symbols ZIP](../../../packages/2.1-7-tabbar-badge/com.wechat.improve_2.1-7_symbols.zip) | 10,420,510 | `9be6780137f652783e64ce4ef27a8a76dffa1b1e224ce4d82cf1184d67e066ca` |

[SHA256SUMS](../../../packages/2.1-7-tabbar-badge/SHA256SUMS) 的三项 `shasum -a 256 -c` 全部通过。机器校验见 [package-verification.json](package-verification.json)、[校验日志](logs/package-verification.log)、[checksums.log](logs/checksums.log)，可复用 [verify-packages.py](verify-packages.py)。保留 selector 的存在检查只确认产物包含原有符号，不把字符串存在当作其它业务回归证明。

交付前对本轮基线清单的 **1,854 个已有文件**逐个比对，1,847 个不变，只有 7 个允许的已有源码/测试/版本文件改变；新增 Tests 三个文件和新包目录，均在范围内。**1,255 个历史产物路径（`.theos` 1,225 个、packages 30 个）全部存在且 SHA 不变。** 详见 [environment-preservation.json](environment-preservation.json)。此基线清单不包含历史审计文档或 Finder `.DS_Store` 元数据，不将它们虚报为已作起止 SHA 核验。本轮没有编辑历史审计。

最终 adapter/Hook 和六个正式测试输入 SHA 均与绿测记录相同，独立复核也确认红测副本和绿测输入一致。工作区开始时已有其它未提交修改/删除，均按本轮基线保留，见 [baseline-git-status.txt](baseline-git-status.txt)。

## 8. 真机验收步骤与尚未覆盖部分

在用户既有微信 8.0.78、账号和配置中验收，记录实际安装的 2.1-7 方案、四项图标、宽度、高度和文字配置；不使用新账号或空数据替代现场。只按设备原有越狱方案选择对应 DEB，本轮没有代为安装。

1. **五档逐项检查。** `.6/.7/.8/.9/1.0` 分别验证自然产生的纯红点、1、12、99+；在微信/通讯录/发现/我中检查实际出现的角标，未自然出现的类型记为未验。交叉保留/隐藏文字、系统/导入普通及选中图标、浅色/深色、高 44/52/80。确认角标可见、沿图标右上方合理定位；最窄宽数字允许保留原生同宽的贴边/轻微越界，不接受插件新增的整枚移出或裁掉。
2. **对象与原生规则。** 如使用现场几何日志，只记录对象标识、frame/bounds、实际 size、hidden/alpha、superview 和祖先裁剪/z 序，不记录聊天或联系人内容，也不从插件改角标值。确认指针同一，badge 不被重新创建，字体/形状/尺寸及微信自行隐藏的条件保持。原生正常角落重叠不等于错误遮挡。
3. **关闭与反复开关。** 各宽度关闭样式后，立即比较当前原生位置；消息内容变化后应回到新内容的原生位置和 size。连续开关至少 20 轮，并持续触发自然布局，观察没有分数像素积累、左右互换偏移或切换闪动。
4. **切 tab 与前后台。** 覆盖四个 tab 的选中/未选中、消息/提醒更新、推入返回页面、进入后台再恢复及反复完整 bar 布局，检查角标不漂移，点击、命中、点击动画和转场快照正常。独立验证浅色选中、浅色未选中、深色选中、深色未选中四组真实状态。
5. **背景及裁剪链。** 各角形、模糊/背景色、描边及动画保持显示，检查 badge 到 window 的真实父链与像素；发现遮挡时同时记录 frame 转换和裁剪链，不能仅凭 item.clipsToBounds 或 host z 序判断。插件导入图标与微信自己的 native customIconView 分支分别核验。
6. **滚动性能。** 在原顶部会话列表连续上下滚动、回顶部，配合自然消息更新与切 tab，观察底栏无新增掉帧、卡顿或动画抖动。对比关闭/开启样式的帧时间或录屏；可用系统性能工具记录主线程布局耗时。host 方法次数不替代这一步。
7. **额外 tab。** 若用户现有模式自然有第五个或临时 tab，验 4→5→4 时继续整体回退原生且无旧坐标残留；没有该模式则明确未验。补丁没有扩大四 tab 样式支持范围。

尚未覆盖的部分明确如下：没有真机运行时层级、实际裁剪/合成像素、真实字宽、FPS/CPU/GPU 数据；代表 badge 宽 16/24/30pt 不是实际测字；host 为四 tab。正式 badge 测试的外观/选择属性为 light+unselected、dark+selected 两组，未穷举四组交叉；detach/attach 不替代真实前后台。`item.customSize` 边界已测，但它不等于微信 native `customIconView` 存在分支，后者的显隐、挂载及隐藏 imageView 几何未在本轮 host 全量模拟。静态审查未发现阻断前提的问题，对这些设备场景保留验收要求，不将它们写成已通过。
