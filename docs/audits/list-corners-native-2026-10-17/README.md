# 列表圆角：原生页面核对与重构方案复审

日期：2026-10-17。代码基线：`2aa7bcb8 / 1.7-17`。

结论：上一轮方案方向可保留，但尚不能按“完美方案”直接实施。必须撤回首阶段统一建立行数缓存的安排，补充实际内容容器、原生表头、分组索引域、动态入口及状态卡片边界。只重构圆角职责，不建立第二套列表数据源或刷新机制。

## 证据与范围

- `manifest.json`：目标身份、源码哈希、分析方法和限制。
- `native-elements.json`：13 个相关原生类的实例变量、内部继承链、实例方法地址。
- `native-layout.json`：6 个关键原生方法的有界反汇编及 selector 引用加载位置。注释仅证明静态引用，不证明动态接收者或某分支实际执行。
- `crash-summary.json`：用户提供的闪退日志中的终止原因、递归和关键栈帧。
- 项目 `HeadersFile`、当前圆角实现、聊天分组实现、隐藏发现入口、隐藏我的页面入口、自定义入口及收藏验证实现。

REA 确认本地解密 Mach-O SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。直接读取 LC_UUID 为 `9cd58b8e-b7ab-3487-adbd-2ac0aa16a5de`，与用户闪退日志的微信 app slice UUID 一致。该文件来自此前本地第三方 IPA 提取，UUID 对应不等于验证了设备当前完整文件哈希或当前运行配置。

本次没有取得手机实时视图树、截图或交互轨迹；静态方法和成员核对不能宣称完成真实像素布局、动态分支或启动验收。

## 四个页面的原生结构与圆角边界

### 会话

- `NewMainFrameViewController` 属于 `MMTabBarBaseViewController`；主表 `m_tableView` 是 `MainFrameTableView`。搜索栏、原生顶部任务区域、置顶折叠视图、原生会话编辑逻辑分别存在。
- `NewMainFrameCell → MMMultiMenuTableViewCell → MMBaseMultiMenuTableViewCell → MMTableViewCell`。Cell 包含 `m_itemView`、原生背景、拖拽状态以及当前头文件未列出的 `_rightMaskView`。
- `MainFrameItemView` 包含头像、未读、昵称、时间、消息、昵称/消息后缀、状态、免打扰、直播/通话等元素。实际二进制的部分类型与头文件不同，例如消息播放视图为 `VoicePlayingView`。
- `MainFrameItemView.layoutSubviews`（`0x104a8f280`）包含更新头像、未读、时间、昵称、状态、消息、群组和直播状态的 selector 引用。不能用一套固定图标/文字 frame 替代这些原生内部布局职责。
- `MMBaseMultiMenuTableViewCell.contentView`（`0x116756a10`）在 `contextMenuEnabled` 分支读取 `_actualContentView`；另一分支使用父类 contentView。不是永远使用 UIKit 默认内容容器。
- 圆角只装饰已确认的背景和内容边界；不裁剪整个 Cell、菜单容器、拖拽视图，不接管手势，不写索引和会话身份。
- Fake Cell 与真实 Cell 必须分开识别。搜索结果即使复用相同 Cell 类，也不能仅凭类名误识别为主会话列表。

### 通讯录

- `ContactsViewController` 拥有 `MMMainTableView`、搜索、联系人数据逻辑、人数标签、字母索引接口和 section 类型转换接口。
- `NewContactsItemCell` 同样继承多菜单 Cell，内部有 `contactsItemView`。
- `ContactsItemView` 包含头像、昵称、描述、企业/OpenIM 后缀、右侧文字/按钮/箭头、状态与展开描述；原生 layout 有字体、动态尺寸、最大文字宽度、多行描述和搜索提示相关逻辑。
- 现有“前四个 section 合并成卡片”是插件的兼容规则，不能由此断言微信所有版本前四节的业务含义固定。当前版本先保留；跨版本语义识别须有额外证据。
- 优先调整已确认的联系人内容容器，让原生内部布局继续工作；不把所有 UILabel/UIImageView 一律搬到固定坐标。不修改字母索引、原生人数统计或 section 数据。

### 发现

- `FindFriendEntryViewController` 使用 `MMMainTableView`，维护 section 类型与多个业务 row 映射，还有朋友圈头像/红点、视频号红点及全部入口关闭提示。
- `MMTableViewCell` 还有 `m_subContentView`、`cellInfo`、选中背景内边距、accessory 等；类名本身不能证明某个 UIImageView 就是左侧图标或右侧箭头。
- 原生存在 `makeEntryCell:rowType:`、`getCellAvailableRect:rowType:`、多种红点配置方法。它们是进一步定位布局的线索，尚不作为可以无条件新增 Hook 的批准依据。
- `HideDiscoverHooks.xm` 改变 shouldShow 入口结果。圆角必须服从最终有效行结构，不能记录固定“朋友圈第几行、视频号第几行”。
- 保留图标、标题、角标、富文本及动态提示，不操作业务可见性，不因装饰触发入口数据重建。

### 我

- `MoreViewController` 拥有 `m_tableViewMgr`、`_frontTableView`、背景视图、头像昵称、状态按钮、状态详情卡片及状态拖拽动画辅助对象。
- `WCTableViewManager` 管理 sections 和 cells，负责构造、绘制、分割线及显示回调；其 `cellForRow`（`0x109fcc1c4`）包含 `drawCell:` 和 `afterCellForRowAtIndexPath:TableView:Cell:CellInfo:` 等引用。
- `makeHeaderView`（`0x104cd565c`）包含昵称和账号文本测量、头像和二维码点击、状态详情高度、展开动画、tableHeaderView 安装等逻辑。不能把头部视为固定尺寸的普通按钮。
- `HideMomentsHooks.xm` 会删除/重建入口；`CustomEntryHooks.xm` 会追加入口并刷新；收藏点击还受到验证功能保护。圆角仅消费最终呈现，不改 section 管理、target/action 或导航。
- 个人资料头部单独适配，实际容器宽度、触摸扩展区域、状态展开高度及转场均须保留。不能扩大到所有 MMUIButton。

## 对上一轮方案的必要修正

1. **首阶段不新增通用行数监听/缓存系统。** 主会话列表已被分组代理和索引作用域接管。先保留既有接入点，把配置、几何、渲染抽纯；普通列表行元数据优化另设阶段，证明更新入口完整后才实施。
2. **会话分组是显示投影和行身份的唯一所有者。** 使用 `CSGroupCardPosition`。该函数的 NO 可能是未启用，也可能是路径无效；需要通过分组活动状态区分，不将活动分组无效路径按原生行数猜测。若未来需要更丰富只读结果，必须保持现有 API 兼容并单独验证。
3. **严格区分 tableHeaderView 和 section header。** 搜索栏/分组栏包装、原生搜索头识别、contentInset/contentOffset 已由分组管理；圆角仅保留现有 section 间距职责。不能把卡片顶部间距迁到主表头或 inset。
4. **以当前真实内容容器计算几何。** 背景绑定当前 contentView，容器变化后重新验证；记录坐标系并正确换算。只给插件背景安装遮罩，禁止给菜单/拖拽/整个 Cell 统一裁剪。背景不截获点击。
5. **优先原生元素身份与原生内部布局。** 白名单只作用于目标页面实际拥有的表格和子视图。class 名包含 UIView/Line/UILabel 不能单独作为改色、隐藏或移动依据。现有特殊效果逐项迁移，不能直接删除通用扫描后就宣称等价。
6. **个人资料头部与列表单独验证。** 不在全局 MMUIButton 上扩大行为，不使用屏幕宽度代替容器，不用全局 dispatch_once 或直接 layoutSubviews 建立新补丁链。替代现有处理前须验证状态卡片、长昵称、大字体和二维码按钮。
7. **延后行为修正。** 配置透明色、关闭时原生恢复、移除发现页 reloadData 等与结构抽取分开。当前合法设置、六套颜色值、间距、页面特例和重启提示全部保留。

## 聊天分组协作合同

证据：`Hooks/SessionGroupHooks.xm:214`、`:219`、`:224`、`:233`、`:356`；`Controllers/CSGroupListAdapter.m:793`、`:810`、`:1064`；`Controllers/CSGroupIndexScope.m`。

| 状态/资源 | 所有者 | 圆角许可 |
|---|---|---|
| 会话数据、账号、选中分组、未读 | 微信和聊天分组 | 仅消费只读显示角色，不修改 |
| native/display 索引转换 | 聊天分组 | 在当前回调作用域解析，不跨异步保存裸 indexPath |
| delegate/dataSource/prefetch 代理 | 聊天分组 | 不替换、不再包装、不为绘制主动调用 |
| 搜索表头、分组栏、原生 header scope | 微信和聊天分组 | 不替换，不用圆角设置改其高度 |
| contentInset、contentOffset、锚点 | 微信和聊天分组 | 不纠偏、不做二次滚动恢复 |
| 右侧菜单与切组手势 | 微信和聊天分组 | 不改变 recognizer、hitTest 或 target/action |
| Cell 卡片背景、已确认的内容边距 | 圆角 | 幂等装饰，检查实际状态，随容器释放 |
| section 的圆角间距和背景 | 圆角现有适配 | 保留兼容语义，不查询数据源或触发刷新 |

分组已在 cell 创建及生命周期回调进行映射。原生回调返回后的圆角 Hook 仍可能运行在 native 索引作用域；不能将收到的 path 默认当作 display path。异步任务如确有必要，只能使用身份与发布代次验证后的信息，不能持有过期行号修改复用 Cell。

`viewDidLoad`/`viewDidAppear` 等 Hook 与其他模块重叠，`%orig` 是 Hook 链上的前一实现，不保证只执行微信本体。迁移不得依赖源码文件名字或加载先后解决正确性；相关入口保持顺序和返回值，新增可选接口前核对运行时方法签名。

## 闪退结论与防回归要求

用户日志：微信 8.0.78.34，iOS 27.0.1。主线程记录如下递归链：

`CSListHeaderHeight → UITableViewRowData.numberOfRowsInSection → UISectionRowData.refresh → UITableView._delegateWantsHeaderForSection → CSListHeaderHeight`。

原始栈长 8778，递归深度 1248；异常记录含栈保护区域访问，最终 FRONTBOARD `0x8BADF00D`，scene-create 超过 10 秒。证据支持上一版圆角高度计算与行数查询形成同步递归，并触发启动 watchdog；不能把它当作普通绘制慢或归因于圆角路径分配。

当前 1.7-17 生产源码中没有 `CSListHeaderHeight` 或已撤回的两个新模块；当前高度逻辑不查询行数。这证明该新增调用链已从源码撤回，不证明用户手机已安装该构建，也不证明当前版本绝无其他闪退。

设计要求：

- 高度回调只使用原始返回值、配置、页面和 section，新增逻辑不调用 UITableView 行数/section 数、数据源、分组重建、layoutIfNeeded 或 reloadData。
- layout/setFrame/渲染不发起同步刷新或排队无限补偿，不在构造阶段主动生成页面、拉取会话数据。
- 重入保护按对象/操作设置并可靠释放，不能取代消除循环依赖；异常未知场景回退原生，不吞掉全部异常冒充修复。
- 处理零尺寸、非法浮点、越界 section/path、视图复用与销毁、运行时私有成员缺失。通讯录不能在未验证 section 存在时固定查询 0…3。
- 保留原生回调链；不能为防递归随意移除 `%orig`。

## 验收与尚未证明的部分

当前检查已完成：四页原生类/元素核对、6 个关键方法静态检查、分组回调合同核对、其他入口功能交叉检查、给定闪退日志复核。

尚未完成：手机实时层级、四页全部动态分支、实际像素对照、Hook 运行顺序、组合功能启动/交互、帧率/内存测量。没有实机证据前不称“完美”或“不会闪退”。

后续实施顺序：先锁定 1.7-17 截图/行为基线与冲突合同；再抽取配置和纯渲染；四页逐个迁移适配；最后独立优化行信息获取、视图查找和刷新。每一步独立回退。

验收矩阵：圆角/分组开关四组合；分组过滤 A/B/C/D 到 B/D 后点击与删除 D 仍操作 D；空组/单行/Fake 转真实；未读变化/置顶/账号切换；侧滑菜单开启时切组；普通与快捷搜索往返、标题/分组条/滚动位置；通讯录索引与企业描述；发现入口隐藏和红点；我页隐藏入口、自定义入口、收藏验证、状态展开与二维码；浅深色、透明度、长文字、大字体和宽度变化；重复冷启动、前后台与长时间复用。

需要新增联合回归：同一个调用链同时执行圆角高度/布局和分组代理，模拟 UIKit 行数查询触发 header 计算；验证无递归、无额外刷新、索引身份不变。现有分组单模块替身测试不能替代它。

当前仓库存在 `Tests/verify-group-header.sh`、`verify-group-search.sh`、`verify-group-interactions.sh`、`verify-group-business.sh`、`verify-group-selection.sh`、`verify-my-page-clean.sh` 等。历史文档提到的 `Tests/verify-session-groups.sh` 本次未在当前 Tests 文件树找到，因此不能照搬旧文档的测试总数或命令作为验收证据。本轮未运行测试、未构建、未安装。

本次只新增此审查记录和证据文件；没有改生产源码、版本、已有安装包、服务或微信数据。
