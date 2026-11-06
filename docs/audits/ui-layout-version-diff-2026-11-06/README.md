# 插件根设置列表：两张截图的行高与圆角差异分析

本轮只分析，未修改生产代码、测试、断言、夹具或版本号，未构建、出包或写入 packages。分析对象是当前工作树：`control` 仍为 **2.2-19**，HEAD 为 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`；这不代表两张截图安装的也是同一份插件。工作目录为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`。

## 结论与可确定的边界

**当前插件没有按微信 8.0.78 / 8.0.80 切换这张根设置列表的 table 类、cell 类、卡片圆角或行高。卡片使用 UIKit 的 insetGrouped 样式，行高使用 UIKit 的默认自动测量政策。** 所以，不能把图中的变化解释为“插件为了适配 8.0.80，主动把卡片改圆、把行高改大”。

**已确定的是谁决定这些外观；尚未确定的是两图为什么得到不同的系统测量/绘制结果。** “系统负责这些默认值”成立，**“这两张图一定是一张旧 iOS、一张 iOS 26，因此发生变化”无法判定**。两图没有系统、微信、插件版本标识，也没有同机同配置对照。不能只因插件没有微信版本分支，就把系统版本写成已经证实的唯一原因。

如果要直接回答用户：

> 这张设置页采用系统列表样式，插件没有给 8.0.80 单独换一套更圆、更高的布局。图1的行内部确实比图2高约 27%，卡片拐角也不同；这些尺寸由 UIKit 的默认样式与自动测量控制。但现有截图无法确认各自的微信、iOS 和插件版本，因此还不能证明差异是由微信升级还是系统环境变化触发。具体版本归因目前无法判定。

上述结论限于本次检查的当前源码。两图若来自不同历史插件构建或不同注入环境，不能以当前源码反向证明它们当时执行的实现相同。

## 1. 输入身份与像素事实

图1、图2始终按文件名区分，**不将图1预先标作 8.0.80，也不将图2标作 8.0.78**。

| 输入 | SHA256 | 尺寸 / 可见信息 |
| --- | --- | --- |
| `img1-title-zaibuhui-0715.jpg` | `fe4854a6f85d633dc3e34cf844f140254a777da4e7ec4b24ac96456d19307f25` | 1280×2774；07:32；标题“再也不会”；微信号后缀 _0715 |
| `img2-title-mofa-0618.jpg` | `f2dd8108a19d1f03ecf1f3bfbcfade12ebfbcf6a8bec19748158b5a6ad42495f` | 1280×2774；07:33；标题“魔法”；微信号后缀 _0618 |

输入 SHA 与用户提供值一致。JPEG 只有 JFIF 1.1 信息，没有 EXIF / XMP，也没有可读的系统、微信或插件版本标识。标题、账号后缀、状态栏时间不能建立版本对应关系。完整元数据、ffmpeg RGB 哈希、像素方法和 CSV 见 [独立像素报告](pixel-analysis/README.md) / [metadata-and-metrics.json](pixel-analysis/metadata-and-metrics.json)。

独立解 RGB 后复核如下，坐标均为原图像素：

| 指标 | 图1 | 图2 | 能支持的结论 |
| --- | ---: | ---: | --- |
| 两条账号行正文起点 y | 950、1096 | 1004、1119 | 相邻行节距 146 / 115px，图1增加31px，即26.96% |
| 两条账号行的白色连续带 | 142、143px | 111、114px | 支持行内部更高；白带会受分隔线影响，不等同精确 rowHeight |
| “账号信息”正文墨迹高度 | 37px | 37px | 未出现同比例的文字放大 |
| 正文左边界 | x222 | x222 | 水平文字定位相同 |
| 账号卡片左右边界 | x61…1218 | x61…1219 | 宽度基本相同 |
| 正文相对卡片左边界 | 161px | 161px | 水平几何未按约27%缩放 |
| 账号卡片到底下界面定制卡片的空档 | 145px | 148px | 分组间留白基本不变 |
| 页面底色采样 | (243,242,248) | (243,242,248) | 背景色相同 |
| 顶行白跨度法圆角轮廓代理（阈值252） | 约91px | 约35.5px | 卡片轮廓不同；不能据此认定 layer 半径 |

“间距更大”应具体理解为**分组内部的行节距更大**，不是分组间空档增大。界面定制可见行也具有约146 / 115px的行节距，不局限于账号卡片。

圆角公式 `(卡片全宽 − 顶行白色跨度) / 2` 在这两张图上能复现用户数值，但受 JPEG、抗锯齿、取样行与曲线形状影响：白阈值250–254时，图1代理范围63.5–94.5px，图2为19.5–36px。因此**91 / 35.5 是轮廓估计，不能写成运行时实测 CALayer.cornerRadius**；也不能从中证明“系统默认就是28pt / 11pt”。两图拐角有差异这一事实不受影响。

### pt 换算不是已知设备参数

用户给出的 `1pt≈3.257px` 依赖“截图由393pt宽、1179px原图等比放大到1280px”的前提。JPEG 没有证明这个前提。报告以像素与比值为主，不将约44pt / 35pt写成已证实的实际行高。

另有两个条件校准：两图头像非背景包围框约238×239px；**如果截图使用当前80pt头像实现**，约2.975–2.988px/pt。正文相对卡片左边界161px；**如果对应当前 cell 的54pt文字起点**，约2.9815px/pt。两项均与3.257不同。因为截图插件构建仍未知，这也不能用来反推确切机型或断言实际就是3×；它只说明绝对pt换算尚未确定。见 [conditional-scale-check.json](pixel-analysis/conditional-scale-check.json)。

![按卡片顶边对齐的两图比较，未标微信版本](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/ui-layout-version-diff-2026-11-06/pixel-analysis/aligned-card-comparison.png)

## 2. 这张表到底怎样创建

| 层级 | 当前代码证据 | 对分析的意义 |
| --- | --- | --- |
| 根控制器 | [CSCustomViewController.h:6](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCustomViewController.h:6)：继承 UIViewController | 根列表不是 CSSettingsTableViewController；不能把子页基类的布局规则直接套到本页 |
| 原生宿主 | [CSNativeSettingsHost.m:14](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNativeSettingsHost.m:14)、:30–47：动态继承 MMUIViewController，把 CSCustomViewController 加为内容 child | 保留宿主原生加载；本页 table 仍由自己的 setupUI 创建 |
| 表格创建 | [CSCustomViewController.m:918](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCustomViewController.m:918)：`[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped]` | 实际类为系统 UITableView；style 恒为 insetGrouped |
| 数据与代理 | 同文件:932–936 | delegate/dataSource 为根 VC，注册同一个 CSSettingTableViewCell |
| 行创建 | 同文件:951–961 | dequeue CSSettingTableViewCell，按 item 配置；账号信息/收藏验证都是普通 item（:682–697） |
| cell 父类构造 | [CSSettingTableViewCell.m:177](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSSettingTableViewCell.m:177)：固定 super initWithStyle:UITableViewCellStyleValue1 | 本页没有在78/80之间替换 cell 实现 |
| 分组标题 | CSCustomViewController.m:964–965 | 只返回标题字符串；不创建自定义 header、不设置其字号 |

`CSSettingsTableViewController.m:11` 在2.2-19新增的 hidesBottomBarWhenPushed getter属于**子页导航底栏政策**，不改根表 style、rowHeight 或卡片圆角。2.2-18在根表:921增加的 `estimatedSectionHeaderHeight=0`只关闭分组标题高度估算，不是将实际标题高度设为0，更不是修改行高或圆角。

## 3. 圆角由谁绘制

**当前代码中，设置卡片的分组圆角由 UIKit 的 insetGrouped 列表背景/裁剪实现提供。插件没有给这些卡片指定半径。**

证据链：

- 创建时明确选择 insetGrouped（CSCustomViewController.m:918）。本机 Apple SDK `UITableView.h:27` 对该 style 的注释是 `grouped sections are inset with rounded corners`，明确“内缩且带圆角”的系统样式语义。
- [CSSettingTableViewCell.m:184](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSSettingTableViewCell.m:184)至:222只配置选中背景颜色、普通背景颜色、图标与拖动手柄。选中背景是普通UIView，没有显式圆角。
- [CSCustomViewController.m:1167](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCustomViewController.m:1167)至:1174的 willDisplayCell 也仅设背景色与选中背景，不指定形状。
- 根 VC 与 cell 没有对卡片设置 layer.cornerRadius、mask、UIShape、UIBackgroundConfiguration.cornerRadius 或自绘圆角路径。根 VC 的 cornerRadius 赋值（:443、:493、:521）全部用于 `avatarImageView`，属于头像，不是设置卡片。
- 列表圆角 renderer 在插件的其他功能中确实存在，但其页面/表格 guard 不接受这个根列表，详见配置范围。

“由UIKit负责”是当前源码与公开style契约可证的归属；**实际设备采用哪个私有背景view、哪条曲线、运行时半径是多少，本轮没有设备层级或UIKit实现对比，无法判定。** 本机SDK版本为27.2，只用来核对公开API契约，不能拿来代表截图设备系统，也不能代替iOS18/26的运行时差异证据。完整SDK路径、SHA与原文行号见 [SOURCE-EVIDENCE.json](SOURCE-EVIDENCE.json)。

## 4. 行高由谁决定

**本页采用 UIKit 默认的自动测量政策，不是插件常量44pt，也不是插件自定义 intrinsicContentSize 返回某个高度。**

- 根表 setupUI（CSCustomViewController.m:913–939）没有设置 rowHeight / estimatedRowHeight；代理部分没有 heightForRowAtIndexPath。
- 本机 Apple SDK `UITableView.h:363` 明确 `rowHeight` 的默认值为 `UITableViewAutomaticDimension`，:366中estimatedRowHeight默认也为AutomaticDimension。公开头文件不承诺本页某个固定最终pt值。
- `CSSettingTableViewCell` 没有覆写 intrinsicContentSize、sizeThatFits: 或 systemLayoutSizeFitting…高度方法，没有给contentView规定上下padding或高度约束。:198–203提供中心Y与29×29图标约束，它是测量内容的一部分，不能单独推出最终行高。
- [CSSettingTableViewCell.m:376](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSSettingTableViewCell.m:376)先调用super layoutSubviews，再在:379–408调整文字x和可用width；文字y/height保留父类结果。这里没有把34/35pt改成44pt的分支。
- :389的sizeThatFits用于计算详情**宽度**；它既不是cell高度override，也没有修改rowHeight。
- 普通行配置:343–347只设详情与accessory/selection，不设字体或垂直布局。

最终高度由系统table/cell根据系统默认内容、字体与布局政策测量。默认系统标签仍有自己的字体和内容尺寸；不能将“插件没显式设置preferredFont”理解成“完全不可能受系统字体环境影响”。本轮没有执行UIKit运行时，无法从源码推出这两张图各自确切的rowHeight、字体pointSize或系统最小行高。

## 5. A：微信版本适配分支逐项核查

判定：**作为当前插件根列表行高/圆角差异的直接原因，不成立。** 下面列明与提问相关的版本/类能力分支及本页命中关系；没有把项目其他业务的版本判断一概说成不存在。

| 分支或适配点 | 文件与行号 | 实际作用 | 是否改这张根表的行高/圆角 |
| --- | --- | --- | --- |
| 根表/cell构造 | CSCustomViewController.m:918、:951–961；CSSettingTableViewCell.m:177–179 | 固定UITableView + insetGrouped + Value1 cell | 没有微信或系统版本分支 |
| 原生宿主类存在性/fallback | CSNativeSettingsHost.m:30–47 | 检查MMUIViewController、动态注册宿主；失败回退内容VC | 可能改变承载方式；不替换本页table/cell或尺寸规则 |
| 入口显示模式/插件注册能力 | CustomEntryHooks.xm:223–234、:248–271 | 自建formSheet导航或注册到WCPluginsMgr | 改呈现上下文，不写根表行高/圆角 |
| CSModelTemplates白名单 | CSBubbleStyleAdapter.m:275–281 | 允许8.0.78/8.0.80聊天气泡模板读取 | 不命中设置cell |
| CSNativeProfile白名单 | CSMessageMergeAdapter.m:412–423 | 聊天消息合并、测量与特殊消息回退 | 不命中设置table |
| 新旧底栏层级/转场副本适配 | CSTabBarNativeAdapter.m:552–571；CSTabBarNativeAdapter.h:23 | WCTabBarView / 旧MMTabBar转场内容 | 只处理底栏，不决定设置卡片形状或行高 |
| 搜索回调BOOL/unsigned int签名分支 | CloseFriendSearchHooks.xm:94–108 | FTSHomeViewController密码搜索输入 | 不参与根设置布局 |
| 版本控制/伪装 | CUtility.xm:9–26、:35 | 按选项改CUtility.GetVersion返回值 | 根表/cell不调用它来选择布局；微信外部实现是否间接受影响未取证 |
| .18分组估算/.19底栏导航修复 | CSCustomViewController.m:919–921；CSSettingsTableViewController.m:11 | 分组标题测量时机 / 子页隐藏底栏声明 | 均无78/80选择，均不写卡片半径或行高 |

根VC、设置cell、原生宿主的全文检索未发现8.0.78、8.0.80、CFBundleShortVersionString或操作系统版本条件来改变这些指标；搜索命令、负结果、相关源码SHA在SOURCE-EVIDENCE.json。

这个结论不等于“升级微信绝不可能间接影响UIKit外观”。不同宿主构建的系统兼容行为、链接SDK及宿主全局调整没有在本轮两个应用的运行时对比；不能把“插件无分支”扩大成“宿主版本完全无关”的证明。

## 6. B：系统版本差异

判定分两层：

- **系统负责本页的圆角绘制和默认高度测量：成立**，由第2–4节的创建路径与SDK契约证明。
- **两图就是因不同iOS版本（尤其iOS26）产生差异：无法判定。** 缺少两端系统版本、实际插件build、host构建/链接SDK信息，以及同系统/同配置的交叉对照。

系统默认样式不是插件承诺不变的圆角常量，自动行高也不是插件锁定的44pt，因此系统环境改变可以在同一份源码下产生不同结果。这说明系统差异具有一条真实的作用路径；**不证明截图实际走过某个iOS版本变化路径**。本轮没有比对两个iOS运行时实现，也没有证据证明iOS26在这两台环境中取91px或任何固定pt半径。

图2额外的顶部层叠条、两图首卡绝对y896/965、分组标题字形差异，不能当系统版本指纹。当前源码本来就支持不同入口/模态承载；这些差异还混有呈现上下文与系统标题绘制因素。报告不将它们用作系统版本判据。

## 7. C：插件自身配置差异与全局hook范围

判定：**已检查的插件开关直接改变本页卡片圆角/行高，不成立。** 两张图是否使用不同历史插件构建或其他注入环境，**无法判定**；没有读取两端真实偏好。

| 配置或hook | 偏好/证据 | 作用域与本页关系 |
| --- | --- | --- |
| 列表圆角 | CSListCornerConfiguration.m:3–8：`com.wechat.enhance.list_corner_radius.enabled`、`.radius`、`.left_margin`、`.right_margin`、`.top_session_top_margin`、`.normal_session_top_margin` | CSListCornerPageContext.m:69–89只允许NewMainFrameViewController、ContactsViewController、FindFriendEntryViewController、MoreViewController，且table须等于owner实际主表；:215–218再次校验。本页不满足 |
| 字体/布局 | 域`com.wechat.enhance`；CSLayoutPreferences.m:23–26的`font.chat_size`、`global.scale`；LayoutHooks.xm:116–198 | 微信UIFont category的dynamicCellHeight/dynamicLength等路径。本页没有调用这些category；没有直接映射根表rowHeight。详见D |
| 界面简化 | WCCustomTextHooks.xm:136–150、:180–208，`com.wechat.tweak.simple_ui_enabled`、`com.wechat.tweak.custom_menu_names` | 改微信config / MMTableViewInfo / MMUILabel文本，不写本页card/rowHeight |
| 界面净化 | HideSettingHooks.xm:385、HideDiscoverHooks.xm:57、HideMomentsHooks.xm:179等 | 目标为微信NewSetting/Discover/More或聊天类，不是CSCustomViewController的根表 |
| 全局UITableView hook | SessionGroupHooks.xm:314–344；CSGroupListAdapter.m:202、:204–228 | 只在有关联的分组adapter时接管；adapter绑定微信实际m_tableView等。本页无attach call，不具有关联，原值交给orig |
| 全局UITableViewCell hook | SessionGroupHooks.xm:550–552；CSCloseFriendSessionPresentation.m:168–175、:259–261 | 只有已关联会话cover才刷新；设置cell无此关联，不改其几何 |
| UIAppearance/全局行高 | Controllers/Hooks源码检索 | 本次Controllers/Hooks检索未发现会改写本页创建或高度规则的UIAppearance或全局setRowHeight hook |
| 入口名称 | CustomEntryHooks.xm:15、:40–43、:224–225：`com.wechat.tweak.entry.custom.title` | 可将宿主标题改成“魔法”，不改变表格几何 |

“魔法”符合已有入口标题偏好的能力，但无法从截图确认其实际配置来源；**标题不同既不是微信版本标识，也不证明两端设置了不同的行高/圆角选项**。账号差异本身不提供尺寸分支；CSCustomViewController.m:692–697的账号状态只可能增加密友入口行，不修改每行高度。

## 8. D：显示缩放与字体大小

判定：**以统一显示缩放或仅增大正文作为这组差异的解释，不成立于现有像素事实；真实系统字体/缩放参数仍无法判定。**

若整张页面统一放大约27%，正文高度、卡片宽度和水平偏移也应同比分别扩大。实测它们基本相同，只有行节距明显变化，不符合这个单一解释。正文37px墨迹高度相同支持排除明显的正文同比放大，但墨迹bbox不能证明UIFont.pointSize、font metrics或preferredContentSizeCategory逐项相同。

不能笼统说插件“没有字体hook”：LayoutHooks.xm:116确实hook UIFont，但覆写的是微信提供的category方法，如getNormalFontSizeByLevelForChatOrTimeline:、dynamicScale、dynamicFontSize、dynamicCellHeight、dynamicLength（:118–195）。非默认global.scale会改变这些category返回值。**它没有hook UIKit的systemFontOfSize:、preferredFontForTextStyle:、fontWithDescriptor:常规工厂；当前根表/cell也没调用上述微信category。** 未发现从这些键到根表行高或卡片半径的直接路径。微信外部实现是否在其他位置间接影响系统默认值没有运行时证据，不冒充已排除。

设置cell未显式指定正文UIFont、UIFontMetrics或adjustsFontForContentSizeCategory，让系统Value1 cell提供默认标签与默认测量。头像区昵称20pt、微信号14pt是另一组显式设置（CSCustomViewController.m:56–57、:540、:549），不代表行内字体策略。分组标题只返回字符串，交给系统header绘制；图1分组标题墨迹稍大不能解释成插件主动改字号。

## 9. 四种原因的判定汇总

| 原因 | 判定 | 依据和限制 |
| --- | --- | --- |
| A：插件按微信版本选择不同根表/cell/尺寸 | **不成立（当前源码范围）** | table/style/cell恒定，没有78/80分支；聊天/底栏适配不命中本页 |
| B：不同系统版本造成两图差异 | **无法判定**；系统拥有绘制/默认测量这一机制**成立** | 样式和测量归UIKit，但缺两端iOS版本与同条件对照，不可写死为iOS26 |
| C：已检查的插件圆角、布局、简化开关直接造成 | **不成立（当前直接路径）**；两图实际build/配置环境**无法判定** | 页面类型/table identity guard排除；标题配置独立于几何 |
| D：统一显示缩放或只放大正文造成 | **不成立于现有像素关系**；实际trait/字体参数**无法判定** | 文字、卡宽、横向几何不随行节距同比变化；没有真实设备参数 |

代码可证：创建方式、系统style归属、自动行高政策、无微信条件布局分支、已知配置作用域、字体hook实际目标。像素可证：行节距约+27%、文字与横向几何基本一致、卡片拐角不同、分组间留白基本不变。**无法仅靠现有材料证明：两图版本映射、iOS版本、精确pt尺度、实际CALayer半径、精确rowHeight，以及触发默认差异的唯一变量。**

## 10. 怎样才能确定唯一原因，以及统一建议

最小取证信息是两端真实iOS build、微信build、插件版本/注入dylib SHA、入口方式、屏幕bounds/scale/nativeScale、preferredContentSizeCategory及相关有效偏好。在已知这些信息后，先固定插件dylib和配置，在同一iOS/设备上只换微信；再固定微信/插件在不同iOS上比较。每次记录实际table/cell类、style、rowHeight属性、rectForRow实际height、label font/traits与系统背景/clip层级。这样才能区分微信宿主变化、系统变化、插件build和配置变量。**这些设备对比本轮均未执行。**

未发现导致这组差异的插件行高/卡片半径常量，因而没有“把某个44改回35”的定点修复可建议。若后续目标是跨系统统一视觉，可只对本页明确行高策略，并在本页为每个section首尾背景提供明确圆角策略；行高仍须容纳可访问性字体和内容。不能给整个table.layer设一个圆角来冒充每组卡片的圆角，也不应修改微信全局UITableView/UIFont。本轮仅记录方向，没有实施或生成实现代码。

## 11. 取证与环境保护

[SOURCE-EVIDENCE.json](SOURCE-EVIDENCE.json)保存22个源/SDK文件的SHA、行号摘录、正负检索命令与输出。像素目录保存原图SHA、rawRGB SHA、元数据、测量CSV、阈值敏感性和条件尺度检查，没有给截图添加推定版本标签。

生产目录、HeadersFile、版本文件、历史packages和主树.theos在分析开始时建立哈希清单，结束核对见 [environment-after.json](environment-after.json)。本轮只新增本审计目录的分析文档、数据和派生图片；未运行测试/构建，未修改版本、原测试或安装包，未执行git reset/checkout/stash/commit或make clean。
