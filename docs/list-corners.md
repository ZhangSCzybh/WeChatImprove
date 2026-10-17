# 列表圆角完整重构（1.7-19）

本版以 `2aa7bcb8 / 1.7-17` 为功能基线，在独立分支 `codex/list-corners-refactor-1.7-17` 重构会话、通讯录、发现和我四页列表圆角。配置、页面适配和背景绘制各有明确归属；保留各页已有布局与配置语义。历史版本的文档与构建记录保留在 Git 历史和原审计目录中，本页描述本版实际实现。

## 模块归属

- `Hooks/ListCornerRadiusHooks.xm` 保留原生入口及回调链，将四页布局交给各自适配器；全部 35 个既有 Hook 方法保持对应。八个高度回调各执行一次原调用，然后按纯值策略计算。
- `CSListCornerConfiguration.h/.m` 集中原有 30 个持久化键、五项数值默认值及六套 RGBA。缓存不可变配置快照，每次装饰使用一个快照并按目标视图的 trait 选择深浅色；显式保存及 defaults 通知使缓存失效。通知处理仅失效，不写入 defaults。
- `CSListCornerSectionPolicy.h/.m` 仅依赖 Foundation 和输入值，不接触表格、视图或数据源。它保留会话置顶/普通间距、通讯录前四段合并及各页原有 header/footer 高度规则。
- `CSListCornerPageContext.h/.m` 识别控制器实际主表及有界 responder 归属，管理一次操作的背景、容器和重入边界。每次读取实际 contentView；不保存全局 Cell/table 强引用，不建立行数缓存。
- `CSListCornerSessionAdapter`、`ContactsAdapter`、`DiscoverAdapter`、`MoreAdapter` 分别维护四页专有布局。会话保留 MainFrame/Fake 宽度及横幅处理；通讯录按实际 section 数约束顶部四段查询；发现保留嵌套图文、富文本及角标，记录原始/已应用 frame 防止累计偏移；我页面独立处理列表与实际个人资料表头。
- `CSListCornerRenderer.h/.m` 继续提供 `CSListApplyCardBackground`。关联对象持有插件专属背景及遮罩，不接管碰巧使用相同 tag 的原生视图。只遮罩插件背景，背景不响应触摸；更换 contentView 时移除旧插件背景。

`SessionGroupHooks.xm` 和 `CSGroup*` 保持原样，继续唯一拥有分组投影、索引作用域、搜索表头、代理与手势。会话装饰通过原有 `CSGroupCardPosition` 查询显示首末行，启用分组但角色无效时退出，不猜测原生行数。不替换 delegate/dataSource/prefetch，不写主会话 tableHeaderView、contentInset 或 contentOffset，不请求分组刷新。

## 兼容行为

配置数值范围保持圆角 5–30、左右边距各 1–30、置顶及普通间距各 0–50。全零 RGBA 继续使用原有哨兵语义；保存和重启提示不变。恢复默认继续保留总开关及原重置流程未处理的距离背景色，设置项以身份而非显示标题识别。

装饰限制在实际所属列表及已识别的原生内容角色，使用当前容器的本地坐标，保留侧滑平移。尺寸无效时跳过装饰；原生重置 frame、颜色、mask 或路径后检查实际属性并修复。同样的尺寸、半径与首末角色复用遮罩和路径；位置及颜色变化只更新对应属性。没有离屏位图缓存或跳过整个 Cell 检查。

个人资料头部仅作用于“我”的实际主表表头，保留头像、昵称、微信号、二维码、状态按钮、展开高度及触摸区域。使用插件背景，不对原生业务容器加 mask；零高度状态容器的 hidden/alpha 由原生管理。以有界的正常布局失效替代直接调用 layoutSubviews 和全局 dispatch_once。

会话 viewDidAppear 在关闭圆角时仍保持 1.7-17 已有的背景及滚动条处理；关闭态 Cell/global layout 装饰不查询表格数据。发现页 viewWillAppear 原有异步单次 reload 暂时保留，尚无实机证据支持删除这项兼容刷新。未知私有容器保持原生布局，需重点实机检查新容器背景及分割线。

## 主机验证与安装包边界

实际生产逻辑验证：`bash Tests/verify-list-corners.sh`，756 项，0 失败。测试编译生产配置、策略、上下文、渲染器和四页适配器，提取当前八个高度回调及两个全局布局回调，使用实际分组角色函数和索引作用域。UIKit 为独立主机替身，配置存储为内存注入，不写用户真实 defaults。

覆盖配置键、颜色哨兵、缓存失效、保存/重置、285 个整数范围用例、原调用次数、高度期间禁止查询/reload、四种卡片角色、分组无效路径、非目标主表、复用和原生重置、容器替换、宽度变化、侧滑坐标、四页特殊布局、状态卡片展开与原生隐藏状态及重入边界。

受保护功能的 11 个分组主机回归命令共 647 项，0 失败；`bash Tests/verify-my-page-clean.sh` 另行通过（该命令不输出数字计数）。实际命令和输出见 [existing-feature-regressions.json](audits/list-corners-refactor-1.7-19/existing-feature-regressions.json)。审查发现的两项兼容问题已在 `de6e8273` 修复并复审，见 [review.md](audits/list-corners-refactor-1.7-19/review.md)。

1.7-19 验收包使用全新临时 Theos 输出目录构建完整 Release Rootless arm64 + arm64e 包；具体构建提交、命令、日志路径、包 SHA-256、control、安装位置、架构与符号检查以同目录 `build-validation.json` 为准。受保护源码与既有测试输入在打包前后按记录的哈希核对。原有包及工作区 `.theos` 不覆盖，不运行 clean/install。

主机断言和编译不能证明微信私有视图层级、真实 Hook 顺序、系统光栅化、目标设备启动或像素显示已通过。本版没有实机帧率、内存、耗电或性能提升的量化结论。用户安装后按 [ACCEPTANCE.md](audits/list-corners-refactor-1.7-19/ACCEPTANCE.md) 验证冷启动、四种圆角/分组开关组合、四页布局、搜索侧滑、隐藏/自定义入口、收藏验证、主题字号、宽度变化及状态卡片；所有实机项目当前均待验收。
