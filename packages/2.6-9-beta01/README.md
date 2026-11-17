# 2.6-9-beta01 广告净化

发布日期：2026-11-17。在“界面定制”中紧接“后台模糊”新增“广告净化”，沿用项目分组设置页面、图标与开关单元格。用户当前为 **Rootless** 环境，主安装包对应 Rootless。

| 产物 | 内容 |
| --- | --- |
| [Rootless 主安装包](com.wechat.improve_2.6-9-beta01_iphoneos-arm64.deb) | `iphoneos-arm64`；安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-9-beta01_iphoneos-arm.deb) | `iphoneos-arm`；安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| [独立动态库](WeChatImprove.dylib) | 与本版 Rootful 包内动态库一致，可用于重签 |
| [调试符号](symbols.zip) | Rootless／Rootful 的 arm64、arm64e 四份 dSYM |
| [SHA-256 清单](SHA256SUMS) | 两个安装包、独立动态库及符号附件校验值 |

两种方案均包含 arm64／arm64e，最低编译目标 iOS 15.0。Debian 版本、插件内显示版本、离线更新说明及当前下载入口均为 `2.6-9-beta01`。

## 设置与处理范围

页面分为总开关、广告范围、可选推荐内容三组。**总开关和全部子项默认关闭**，关闭总开关保留子项选择。六个广告范围分别为公众号文章、订阅号、朋友圈、视频号、小程序、搜一搜；订阅号推荐内容另有独立开关。八个布尔偏好已精确登记到备份模块，支持现有恢复与重置流程。

原生处理覆盖广告开关、有效性、专用处理入口、视频号模型和广告路由；网页处理覆盖明确广告 URL、文章事件、小程序 JS 及搜索结果。搜一搜只过滤具有明确广告标记的记录，保留正常前三项、正文、顺序和回调。网页参数按需复制，超深、过大、循环或无法解析的输入保留原值。

共享网页桥接定义缺少所属产品信息，只有六个广告范围同时开启才使用通用过滤，避免影响关闭的范围；业务专用入口及可识别的小程序调用分别受自己的开关控制。更改设置后重新进入相关页面；关闭影响后续加载，当前页面和缓存可能需要退出重进。

Hook 通过现有备份启动门禁接入，按需安装并完整检查方法类型和 ABI，保留已有前驱，关闭后恢复透传。同步关闭和配置修订检查防止异步旧快照重新启用已关闭范围。初始化器保留 ARC 的 receiver／返回值所有权约定。

## 微信 8.0.80.34 适配

使用用户提供的微信 `8.0.80`／构建 `8.0.80.34` IPA 核对接口。实际实现展开 **95 个唯一 Hook 候选**：83 个与本类或 category 显式方法的完整 ABI 匹配，11 个是有 property 契约的 protobuf dynamic getter，1 个为系统 `NSURL` 接口；没有普通未声明目标或 ABI 不匹配。dynamic getter 是否已生成可用 IMP 取决于微信运行时，缺失时安全跳过。

已适配当前三个视频号 VM 初始化器、包含 `commentScene:` 的十参数广告路由，以及 JS 桥接 uint32／int64／uint64／SEL 参数和对象返回值。未照搬旧样本中没有 getter 的实例变量，也未接入样本的远程授权、远程退出、反检测或调试开关。微信的数据库创建、服务构造和宿主标识继续由原流程管理。

详见 [功能说明](../../docs/features/ad-purification.md)、[IPA 审计](../../docs/audits/ad-purification-8.0.80/README.md) 和 [实际 Hook 逐项核对](../../docs/audits/ad-purification-8.0.80/actual-hook-compatibility.md)。元数据匹配证明接口契约，广告实际调用与可见效果仍须设备验证。

## 聚焦回归与构建

本轮聚焦去广告及其配置集成，共 **2,639 项检查通过**，没有运行与此次变更无关的全量矩阵。

| 脚本／检查 | 结果 |
| --- | --- |
| `verify-ad-purification-preferences.sh` | **232**：默认关闭、范围组合、同步关闭、真实线程重入及陈旧配置保护、非法偏好、ABI 门禁、安装幂等和前驱链 |
| `verify-ad-purification-filters.sh` | **265**：URL 范围隔离、库脚本豁免、递归改写与原输入保持、遍历预算、搜索广告标记及畸形输入回退 |
| `verify-ad-purification-native.sh` | **124**：原生真实适配器、Finder 分类与初始化器释放、范围隔离、标量参数和关闭透传 |
| `verify-ad-purification-web.sh` | **89**：真实网页适配器、四类初始化器释放、桥接宽参数／返回值、全选门禁、搜索结果与 URL 转发 |
| `verify-backup-registry.sh` | **1,853**：现有注册表与配置登记回归 |
| `verify-backup-reset.sh` | **42**：现有通用重置事务；八个新增键另逐项静态核对登记范围 |
| `verify-backup-bootstrap.sh` | **34**：备份启动门禁；生成并编译 43 个受门禁功能文件、9 个独立适配器和 2 个恢复基础文件 |
| 新增五个实现文件严格 iOS 编译 | arm64／arm64e 均以 `-Wall -Wextra -Werror` 通过，包含设置页面 |

新增测试直接链接生产偏好、过滤器和适配器，使用独立临时 NSUserDefaults suite 与 Objective-C 接口替身。Bootstrap 另检查生成的 Logos、iOS arm64 语法和 Objective-C++ C 符号链接；测试未使用用户微信数据库。

冻结 **42,605 个构建输入文件**后，以全新的独立缓存构建，Rootless／Rootful 分别约 **18.7 秒／19.2 秒**完成。构建后当前源码与冻结输入逐文件一致。两方案各有 **8 条既有编译警告**，去除终端颜色后与 `2.6-8` 消息集合一致，**无新增警告**。

已核验包名、版本、包架构、准确安装路径、仅含 dylib 与注入 plist 的载荷、双架构最低 iOS、Rootless RPATH、逐架构 CodeDirectory 哈希、四份 dSYM UUID、符号 ZIP 内容和 CRC、独立 dylib 与 Rootful 载荷一致性及 SHA-256。双架构均含新模块生产符号与设置键，没有测试接口或 fixture。交付目录中的附件与已验证构建产物逐文件匹配。

构建未执行 `make clean`，31 个已有发布文件的 SHA-256、大小和修改时间均保持。会话开始前已有的历史 beta 产物及旧审计删除保持原状。构建证据保存于本地 `.theos/release-2.6-9-beta01/`：源码摘要、严格编译、回归结果、构建日志、警告对比及产物验证；这些缓存不进入安装包。

## 真机验收边界

本版未自动安装到手机，未修改微信账号、数据库或实际用户偏好。主机回归和成功打包不能代替 iPhone 注入、设置页显示、广告实际消失、缓存刷新及其他插件共存验收。建议在原 Rootless 环境安装本版，按需要开启总开关与范围，重新进入对应页面确认；其他微信版本及新增广告形式仍需单独核实。
