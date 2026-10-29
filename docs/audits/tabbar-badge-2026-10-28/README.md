# 微信 8.0.78 底栏原生角标消失：分析记录

日期：2026-10-28。基线：当前工作区 **2.1-6 授权清理后**。本轮按用户要求先定位，**未修改 Controllers、Headers、Hooks、Tests 或版本配置，未发布 2.1-7**。新增内容仅为本审计目录中的证据、隔离探针和报告。

## 1. 结论及其适用边界

**已证实的直接缺陷是：item 改宽时，原生图标先发生 autoresizing，角标没有同步移动；插件随后才采样这两个 frame，把不同几何阶段的原生锚点拿来算偏移。** 这会多算一个向右的 `原生 item 宽度 − 样式 item 宽度`，可将纯红点和数字角标整枚移出所属 item。

该缺陷已用微信 8.0.78 静态实现与执行真实 `CSTabBarNativeAdapter.m` 的隔离 host 探针相互印证。它不是“badge 是 imageView 子视图”的坐标系错误，也不是“没有执行原生 layoutBadgeView”。单独原生 item 布局可以纠正位置，完整 bar 原生布局后再 apply 又可以重现错误，因此布局事件顺序会影响表现。

**尚未证明的部分是：用户现场中，越界角标最终由哪个真实父视图裁剪，或被哪个视图完全覆盖，以及现场具体用了哪种样式。** 本轮没有连接手机执行微信、没有真实层级/像素/事件日志。item 越界与整枚屏幕不可见不能画等号；当前插件还把 bar.clipsToBounds 设为 NO，不能凭 host 模型补造 item 的裁剪开关。用户尚未细分受影响 tab、开关/更新时机及样式配置。

因此，本轮交付的是**确定的布局缺陷、可复现实验及最小修复方向**，不声称已经完成用户现场所有组合的修复验收。先保留 2.1-6 正式实现；正式补丁仍需补失败回归、真机对照及独立 2.1-7 构建交付。

## 2. 证据链

### 2.1 目标及原生事实

目标是项目已有的微信 **8.0.78 / build 8.0.78.34** arm64 可执行文件，SHA-256：

```text
0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e
```

本轮重新校验了目标哈希，和上一轮静态核对的目标一致；这不等于核验了用户手机正在加载的可执行文件。[native/README.md](native/README.md) 给出 47 个有界函数的地址、元数据、反汇编和提取方式。

| 核对点 | 8.0.78 静态证据 | 对归因的意义 |
| --- | --- | --- |
| badge 父视图 | `setupUI`：`0x104727c8c–ca0` 将 image 加到 self；`0x104728154–160` 将 badge 加到同一个 self，且 badge 后添加 | badge 和 image 是 item 的兄弟视图；不能按 image 子坐标系修复 |
| 图标 autoresizing | `setupUI:0x104727c64–c74`、`layoutIcon:0x104728b64–b74` 设置 imageView.autoresizingMask=1 | 即 FlexibleLeftMargin；item 宽度变化会直接改变 image.x |
| badge autoresizing | 已检查的 item setup/layout 中未给 badge 设置同样 mask | 使用 UIView 默认 None 的原生路径，badge 不随宽差平移；外部插件运行时改写仍需日志排除 |
| 数字/字符串定位 | `layoutBadgeView:0x104728b94`，非空字符串或 unread>0 时 y=4，x=item.width/2+3 | 是原生位置规则，不是同一个“红点右对齐”公式 |
| 纯红点定位 | 同一方法中 y=image.y，right=image.right | 要保留图标与 badge 同一时点的锚点关系 |
| 更新链 | `relayoutIconAndBadge:0x104728808`：reload→icon→badge；数字 setter 最后 layoutBadge；字符串最后复合链；showSmallRedDot 最后只有 layoutIcon | 不能把所有内容更新都等同于完整 item layout |
| badge frame setter | `MMBadgeView.setFrame:0x11671553c` 对 origin 像素取整，size 像素向上对齐；updateWithSize 保持 center | 请求的偏移和实际 getter 的偏移有分数像素差；原生换尺寸也会改变 origin |

### 2.2 插件中的具体断点

基线位置：

1. `Controllers/CSTabBarNativeAdapter.m:461`：先设置缩小后的 item.frame。
2. 微信 imageView 的 FlexibleLeftMargin 生效，image.x 自动增加 `w−W`；badge.x 不发生同样变化。
3. `CSApplyItem:181`：这时才采集 s.imageFrame 和 s.badgeFrame。
4. `CSApplyItem:209`：按新旧 image.right 的差值平移 badge。

设原生 item 宽 W、样式宽 w、原生图标右边 r、原生 badge.x=b、新图标右边 r'，当前计算变成：

```text
采到的 image.right = r + (w − W)
styledBadge.x = b + r' − [r + (w − W)]
              = [b + r' − r] + (W − w)
```

多出的 `W−w` 就是错误右移。两者虽然同属 item 坐标，但没有保持同一原生几何基线。[source-analysis.md](source-analysis.md) 包含调用深度、恢复顺序、样式参数及数值推导。

原生布局确实保留：`Hooks/TabBarStyleHooks.xm:66` 起的 item hook 都是 Begin→`%orig`→End；已有 state 时最外层 Begin restore，最外层 End 才 apply。bar/controller 外层 depth 还阻止原生布局未完成时提前 apply。**不是简单漏了 `%orig`，也不应靠再次追加一个无条件偏移来修复。**

### 2.3 排除和保留的假说

| 假说 | 本轮结论 |
| --- | --- |
| badge 是 image 子视图，误用了父坐标系 | 目标 setup 路径已排除 |
| 自定义图标隐藏 native customIcon 时连带隐藏 badge | badge 是 item 直接子视图，已排除这一继承隐藏解释 |
| 插件直接把 badge.hidden/alpha/size 改坏 | adapter 没有写 badge.hidden/alpha/内容/形状；探针非零尺寸、identity、hidden 均保持。不能据此排除外部运行时写入 |
| surface、模糊、描边压在 item 上面 | 正常路径 surface 插入 bar index0，其子层无正 zPosition；原生 create 只追加 item，layout 只将原背景送底。未发现该覆盖路径，不做“隐藏背景”的补丁 |
| snapshot 的视图排序说明活视图被覆盖 | snapshot 是独立副本路径，不用作活视图证据 |
| `index>=4` 导致第五 tab 残留样式 | Update 首先要求两个数组均为4，否则整体 stop/restore；正常5-tab是回退原生。4→5→4 的瞬时顺序尚未运行覆盖 |
| restore 不恢复 size 导致角标为零 | 当前逻辑有意保留微信实时更新的 size；未发现插件把非零 size 归零，不能改成恢复历史 size |
| 每 layout 一次都累计向右移 W−w | 不成立。普通 restore/apply 自动位移往返抵消；完整原生 bar layout 会重新提供另一基线并重现位置错误 |
| 像素取整造成无限漂移，最终移出屏幕 | 本轮模型只复现了有界分数像素差，未复现无限累计，不作该结论 |

## 3. 隔离探针与样式矩阵

探针在 [probe/](probe/)；不是修改后的产品，也不替代正式 Tests。它直接编译当前生产 adapter/preference，按上述静态证据补出原生 item 布局、badge 像素对齐和 image 的 FlexibleLeftMargin。对照模式只去掉此 autoresizing 行为，其余输入相同。NSUserDefaults 使用随机测试 suite，临时编译目录自动清理，没有读写真实微信配置。

重现的关键序列是：

```text
原生角标已存在 → 开启样式 → 普通 Update×100
→ 在样式宽度下原生 item.layoutSubviews
→ 完整原生 bar 布局（恢复原生 item 宽度后再 apply）
```

例如 390pt bar、原生 item 宽97.5、迷你样式宽58.5、@3x、高44、保留文字、系统图标：纯红点首次 x=70，100次普通 Update 后仍为70；单独 item 原生布局后 x≈31.333；完整 bar 布局后又为70。数字/99+同一序列 x≈67→28.333→67。badge 对象、hidden 与非零 size 均未被改坏。

完整各阶段计数、五档宽度矩阵、对照结果和隔离方案实验见 [probe/README.md](probe/README.md) 及其 JSON。这里的“整枚越界”仅指 badge.frame 与所属 item.bounds 无交集，不表示已经证明屏幕像素全不可见。

最终每模式 **480组合、44,160次逐item观察**。以下仅列首次开启阶段，四种初始badge各96次、每档合计384次；“部分越界”排除了整枚越界：

| 宽度档位 | 整枚越界 | 部分越界 | 全部包含在item内 | 本模型中的结论 |
| --- | ---: | ---: | ---: | --- |
| 迷你 .6 | 384 | 0 | 0 | 纯点、1、12、宽30的超过99输入全部整枚越界 |
| 紧凑 .7 | 80 | 304 | 0 | 整枚越界来自纯点的80/96；数字未整枚越界，但部分越出 |
| 中等 .8 | 0 | 192 | 192 | 没有整枚越界，部分较宽badge超出 |
| 标准 .9 | 0 | 0 | 384 | 未复现整枚或部分越界；不等于验证现场此档无问题 |
| 最大1.0 | 0 | 0 | 384 | 没有缩窄，缺少W−w这项误差；仍有原生setter像素对齐边界 |

全部阶段中带autoresizing的基线共3,872次整枚无交集（.6为3,072次、.7为800次）；不模拟autoresizing的对照组为0次。两者的空frame、identity/hidden改变、隐藏祖先异常均为0。重复100轮时最大单轴origin差为1/3pt，恢复后相对原生最大差为2/3pt；观测到的误差没有在该有限循环中持续增长。

| 样式/状态维度 | 本轮证据覆盖 | 可以/不可以据此下的结论 |
| --- | --- | --- |
| 迷你 .6、紧凑 .7、中等 .8、标准 .9、存储兼容1.0 | 五档 host 几何矩阵；原生 item 宽97.5 | 可分辨整枚/部分越界，具体计数见探针；不能外推所有屏宽的视觉必现率 |
| 保留/隐藏文字 × 系统/导入图标 | 两两交叉；高44/52/80；@2x/@3x | 都经过同一断点；图标尺寸语义未改。导入图像替身只表达有无，未做真实透明度/像素合成 |
| 红点/1/12/超过99/字符串99+ | 由原生语义替身更新；代表性size由probe输入 | 数字和点都能复现错误定位；真实字宽、动态字体和最终形状仍属设备验收 |
| 四个 tab | probe四项使用同一语义输入均检查 | 模型中不是特定tab专属错误；用户手机到底哪些tab受影响仍未知 |
| 胶囊/圆角、边框/模糊、升高/lift | 源码共享角标定位路径；非完整交叉渲染测试 | 无证据表明更换背景能根治；具体外观不标为已通过 |
| 深浅色、选中/未选中、点击/切 tab | 原有host回归覆盖部分状态，probe含原生复合链 | 不能当作深浅色真实颜色、选中图透明度和遮挡的视觉验收 |
| 前后台、detach/attach、反复开关 | 原有动画/生命周期host回归，probe含restore/重复更新 | 仍需设备检验实际事件顺序；不是所有组合已验收 |
| 5个或更多tab、4→5→4 | 静态整体回退路径已核对 | 尚未完成该组合的动态probe，不扩展四项样式支持范围 |

## 4. 最小修改方案，供后续确认实施

修复目标是**让图标和同一个原生 badge 在同一 item 几何下取得原生布局基线**，再做现有图标尺寸布局和纯位置平移；保留原生 badge 的对象、内容、形状、size、hidden/alpha 规则。

建议局限在现有 adapter 的 apply/restore 边界：

1. `CSApplyItem` restore 后、记录 image/badge frame 前，利用现有 item depth 保护，同步执行微信已确认存在的 `layoutIcon` 与 `layoutBadgeView`，让两者都基于当前 item.bounds。不要固定延时，不重新创建/复制 badge，也不硬编码系统图标宽度、红点或数字位置。
2. 继续按原来的图标尺寸语义计算最终 imageFrame，再以这对同一时点的原生 frame 平移 badge。写入后从 badge getter 读取实际 origin，记录**实际偏移**，使 restore 对应微信的像素对齐结果。
3. `CSRestoreGeometry` 将 item.frame 还原为原生宽度后，同样在 depth 保护下重建原生 icon/badge 位置；仅修 apply 会留下立即关闭样式时的坐标不一致。保持微信实时更新的 badge size。
4. 先将静态已确认的 autoresizing 和原生调用链补到正式 host 回归，验证旧代码失败；再实现补丁验证通过。根据实测评估是否仅给 `relayoutIconAndBadge` 加已有 Begin/End 包围，以避免其三个子调用各 apply 一次；这不是修复 badge 内容的理由，不泛加业务 setter hook。

**不能只把 s.imageFrame 的采样挪到改 item.frame 之前。** item 也会在已经缩小的宽度下执行原生 layout，state 基线因此可能来自样式宽度；随后 restore 扩宽 item 又触发 autoresizing。单一“提前读frame”不能同时处理这两种来源，可能把右偏换成左偏。

此方案会额外同步调用原生几何方法。静态 `layoutIcon` 还会管理原生 customIcon 挂载、送后、图标显隐和mask，`layoutBadgeView`只调整位置；正式补丁须以原生嵌套/点击动画和布局次数验证这个代价，不能声称完全没有副作用。临时原生几何读写应沿用现有不产生动画的设置方式，不能移除宿主/点击动画。是否仍须对最窄项中99+的可见范围进行纯位置约束，要依据真实size及裁剪链决定，不修改badge形状/值/图标尺寸来凑测试。

已在**临时adapter副本**中只试验上述三处配对修改；生成器和明确标为实验的diff保留在 [probe/](probe/)。同样480组合、44,160次观察中，整枚越界、重复偏差和restore偏差均降至0，原生对象/hidden/size也保持。这验证方案能修复模型中的已证实断点，**不是正式生产补丁或完整绿色验收**：仍有2,080次部分越出item，集中在.6档较宽数字/99+输入。实验原生badge布局调用量从2,726,400增到7,259,520，尚未测量真实设备的性能；正式实施需检查额外调用及临时动画的副作用。正式生产和Tests的哈希均保持原样。

## 5. 本轮回归与发布决定

| 验证 | 结果 | 日志/范围 |
| --- | --- | --- |
| `bash Tests/verify-tabbar.sh` | PASS | [baseline-tabbar.log](baseline-tabbar.log)：geometry、preferences/native lifecycle、click effect39 checks；现有替身不模拟原生 autoresizing，不能否定探针失败 |
| `bash Tests/verify-list-corners.sh` | PASS，1623 checks，0 failures | [baseline-list-corners.log](baseline-list-corners.log)。源码/脚本未发现底栏adapter集成；发现页cell内部MMBadgeView不是底栏badge |
| `bash Tests/verify-managed-image-files.sh` | PASS，125 + 29 checks | [baseline-managed-image-files.log](baseline-managed-image-files.log)，包含底栏图标托管清理输入；预期的失败路径日志不代表脚本失败 |
| `bash Tests/verify-backup-bootstrap.sh` | PASS | [baseline-backup-bootstrap.log](baseline-backup-bootstrap.log)：36 checks，35 gated feature files +8 independent adapters，含当前底栏Logos生成及iOS arm64语法检查，C链接通过 |
| 原生行为隔离探针 | **发现2.1-6几何失败** | [probe/README.md](probe/README.md)，如实保留红色结果，不伪装为修复后通过 |

本轮没有向正式 Tests 添加或删除用例；隔离探针用于定位，不声称完成用户要求的正式“先红后绿”。后续补丁需将可证实的失败路径纳入 Tests，再跑完整回归及真机矩阵。

本轮正式源码/版本未改，因此**不执行新的 rootful/rootless 打包，不生成2.1-7，也不将上一轮构建结果冒充本轮构建**。2.1-6双包仍为原产物；历史packages的保留结果和生产/测试输入前后哈希见 [environment-preservation.json](environment-preservation.json)。没有运行make clean/install，没有改服务、注入环境、账号或数据库。

## 6. 真机定位与验收步骤

先在用户原微信8.0.78、原账号、原设置中复现，记录具体tab及当前宽/高/lift、文字、四项普通/选中图标配置。不要切换到新账号或测试数据来替代现场。首次开关、收到数字/点更新、切tab、item布局、完整bar布局分别区分。

调试记录应限制为UI几何，不输出聊天内容、联系人或消息内容。每条需包含事件selector、bar/item depth、item对象及frame/bounds；image对象及frame/autoresizingMask；同一个badge对象、类型、frame/bounds、hidden/alpha；badge.superview和到window的父链、clipsToBounds/layer.masksToBounds/mask、frame转换到bar/window后的范围；所属item及后续兄弟视图的实际z序。对比Begin前、原生返回后、Apply后的状态，确认原生图标mask仍为1，并辨别越界后是谁裁剪/覆盖。原生数字值和字符串留给微信，不从调试代码改值。

后续正式补丁验收：

1. 先按现场配置验证红点、1、12、99+分别可见；开关前后badge指针一致，原生hidden/尺寸/内容没有被插件修改。正常角落重叠符合原生样式；不能把任何frame相交都判为被覆盖。
2. 五档允许宽度、保留/隐藏文字、系统/导入普通及选中图标、高44/52/80，验证最窄可见范围。背景两种角形、透明/自定义色/模糊及各描边动画不改变badge可见性；深浅色分别核验真实像素。
3. 在四tab中检查微信数字、通讯录/发现/我的自然原生提醒；切tab、收到新消息/提醒、推入/返回页面、进入后台再恢复，记录位置是否随完整bar布局再次偏移。
4. 连续开关和原生重布局至少100轮，compare实际像素对齐origin，确认restore返回当前原生位置并保留原生更新后的size，不能只验证“不再继续漂移”。
5. 若有自然出现的额外tab模式，验证样式整体回退原生，4→5→4无旧偏移残留；不为验收在用户账号中制造业务变化。缺少该模式时明确标为未验。
6. 保持点击、命中区域、切换、选中图标、点击动画、底栏转场快照及列表底部inset行为，完成后才将2.1-7标为可交付；rootful/rootless及symbols放独立目录并校验历史产物哈希。

## 7. 证据索引

- [源码逐项核对](source-analysis.md)
- [原生47个函数静态证据](native/README.md)
- [现有测试覆盖与缺口](test-analysis.md)
- [可重复执行的隔离探针](probe/README.md)
- [当前工作区基线哈希](baseline-workspace-sha256.json) / [开始时已有Git改动](baseline-git-status.txt)
- [交付前环境保留核验](environment-preservation.json)
