# 1.7-22 通讯录好友数量背景修复

基于 `01722105 / 1.7-21`，分支 `codex/list-corners-refactor-1.7-17`。用户 IMG_7399.PNG 中“2 个朋友”底部区域仍为白底；本版补齐其背景，包含前版全部修复。

## 根因和原生依据

之前只处理通讯录 Cell 和 section 标题/尾部；好友数量属于独立 tableFooterView，未进入这些路径。

复用已确认身份的微信 8.0.78 二进制及离线 Mach-O/Capstone 脚本，针对三个方法生成 native-contacts-count.json。目标 SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`；本轮仅静态读取，不启动微信或新建深度分析会话。

- initCountLabel:（0x1010e5e7c）创建独立容器并设 BG_2，创建透明 UILabel 保存到 m_countLabel，设置字体/颜色/居中与弹性宽度，执行 updateCount 后通过 setTableFooterView: 安装。
- updateCount（0x1010e5d4c）取得正常好友数量并生成本地化文字，写入 m_countLabel。
- viewDidLayoutSubviews（0x1010e6b48）保留原父类布局调用。

selector 注释只代表静态加载引用；结合实例变量和调用附近寄存器追踪推断创建流程，未取得实时设备视图树。

## 实现边界

新增 Contacts 专用 CSListCornerContactsDecorateCountFooter：仅在开启圆角、控制器拥有通讯录主表、m_countLabel 是当前 tableFooterView 内 UILabel 时，将底部容器设为通讯录 canvas 背景并保持标签透明。只更新这两个对象的背景；保留人数文字、颜色字体、frame/高度、hidden/alpha、触摸和 footer 身份。不扫描任意底部子视图、不替换 footer、不触发 reload/layout 或行数查询。

ContactsViewController 的 initCountLabel: 与 viewDidLayoutSubviews 在单次原调用后修复背景；原有 viewDidLoad/viewWillAppear 准备后同样补齐。私有成员缺失、统计标签脱离当前 footer、非目标表和关闭圆角均直接退出。原生人数更新继续由 updateCount 管理。

## 验证

主机生产源码/提取 Hook 回归：797 项、0 失败，其中新增底部统计区 11 项。覆盖原调用先安装 footer、背景复位/人数更新、重复布局无查询或刷新、保留文字/高度/坐标及可见性、替换 footer/旧标签、零人数、宽度变化、关闭态、非目标页/表及缺失标签。使用内存设置与 UIKit 替身，不写用户微信数据。

八个高度回调与 1.7-21 逐段一致；发现/我/会话适配及上下文/高度策略逐文件一致。174 个受保护文件与 1.7-17 基线哈希一致。既有分组专项结果见 1.7-21 记录，本轮未重复运行未改动的独立分组套件。

全新临时 Theos 目录构建 Release Rootless arm64 + arm64e，包内容、源码哈希、符号和架构校验见 build-validation.json。新包独占写入原项目 packages，不覆盖旧包；delivery-validation.json 保存交付核对结果。本轮没有安装到手机。

实机待验收：通讯录滑到底部，“N 个朋友”区域应与页面灰底连续；返回页面、人数变化、重新打开微信后保持；字体、数量、空列表和滚动行为正常。此前发现页提示、通讯录标题/索引/分割线和我页资料卡修复均保留。主机通过不能替代实机显示、启动或性能测量。
