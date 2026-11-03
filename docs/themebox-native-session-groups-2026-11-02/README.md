# 2.2-6-beta01：聊天分组原生会话数组重构

分支：`codex/themebox-native-session-groups`。用户授权按 ThemeBox 的原生会话数组方式重构，并指定最终包版本 `2.2-6-beta01`。

## 最终行为

主聊天列表从完整微信会话源计算分组，再改写 `MainSessionMgr` 的 `topSessions`、`normalSessions`、`allTopSessions` 和置顶总数。主列表使用微信原生 dataSource、delegate、prefetch、索引及增删事务；不安装 `CSGroupTableProxy`，不通过显示/原生双坐标映射驱动行数。现有 adapter 负责顶部标签、样式、标题、经过身份校验的 UI 元数据及隐私遮罩。

完整 baseline 保留当前账号的完整原生展示源。原生变更前恢复 baseline，调用原实现后重新捕获、过滤，切组不重复过滤上一次的输出。原始 `MMNewSessionMgr.m_arrSession` 只读，完整组角标与应用角标由完整源计算，当前选中分组不能截断全局统计。

保留原有全部/私聊/群聊/服务/自定义分组、成员重叠与重复过滤、账号配置和密友规则。全部、关闭分组、临时 All 导航同样执行隐私过滤。原生会话选择/转发场景通过当前主 owner 的 `curViewController` 检查；返回主列表恢复已保存的分组。匿名业务行保留原生身份语义，不用于按用户名编辑。编辑操作继续验证用户名、账号和 epoch。

折叠聊天子页使用独立数据源，继续沿用原 projection/proxy；当前分组的子项和安全摘要规则保留。原生 All 主列表沿用原生入口，必要时对混合私密聚合内容遮盖。没有新增企业微信预设分组。

## 关键文件

| 文件 | 职责 |
|---|---|
| `Controllers/CSGroupNativeModel.{h,m}` | 复用已有 Foundation 分组规则，输出原对象及完整统计源；内部模型坐标不进入 UITableView |
| `Controllers/CSGroupNativeSessionCoordinator.{h,m}` | 完整 baseline、原实现前后恢复/捕获、账号/隐私/身份边界、私有 ABI 与写后验证 |
| `Hooks/NativeSessionGroupHooks.xm` | 原生重建、消息源变更、删除、生命周期及置顶折叠计数的接入 |
| `Controllers/CSGroupNativeBridge.{h,m}` | `MMSessionInfo`、`MainSessionInfoItem`、`MMBaseSessionInfo` 的只读元数据兼容 |
| `Controllers/CSGroupListAdapter.{h,m}` | 主列表原生路径、完整源角标、UI 元数据、有限恢复与隐私保护；折叠子页旧路径 |
| `Hooks/SessionGroupHooks.xm` | 主列表退出旧坐标转换与更新拦截；保留头部索引域、菜单与首帧保护 |

设计与计划：`docs/superpowers/specs/2026-11-02-native-session-groups-design.md`、`docs/superpowers/plans/2026-11-02-native-session-groups.md`。ThemeBox 的静态证据及对比见 `docs/audits/themebox-chat-groups-comparison-2026-11-02.md`；实现为本项目的原生数组接入，没有复制二进制代码。

## 核心验证

按用户要求聚焦核心，最终核心结果为 **296 checks / 0 failures**，明细在 `core-regression.json`：

| 验证 | 结果 | 证据边界 |
|---|---:|---|
| `Tests/verify-native-group-model.sh` | 64 / 0 | 实际生产 model、projection 和完整 bridge，原始/包装/基础会话对象替身 |
| `Tests/verify-native-session-coordinator.sh` | 96 / 0 + 97 / 0 | 实际生产 coordinator，两种 owner：UIViewController 与真实 NSObject + curViewController |
| `Tests/verify-native-group-adapter.sh` | 39 / 0 | 生产方法体、完整统计源、无代理、身份/隐私/事务保护和三次有限重试 |

核心覆盖：置顶及顺序、全源角标、跨来源同名不同实例、切组/All/关闭恢复、组外新增删除、重建完整 baseline、选择页豁免、账号和 epoch、隐私锁定和未知选项、setter 失败及同步观察者、首批 cell 保护、身份过期、有限恢复。

更早的相关旧套件结果继续复用，记录在 `regression.json` / `regression.log`：25 条命令全部通过，4858 checks / 0 failures，另有 5 个代理生命周期场景。最终生命周期修改后仅重跑受影响套件，195 checks / 0 failures；该报告分别保留早先通过的源码快照与最终补验，未把已有结果冒称为每次都全量重跑。初轮 fixture 编译失败与修正记录保留。

## 构建与包校验

`build-packages.py` 把当前授权工作区的生产源码复制到临时冻结目录，再为 rootless/rootful 分别使用隔离输出。不会执行根目录 `make clean`，不会清理或覆盖历史包。产物同时包含工作区已有的 2.2-6 后台运行改动；它们没有被本次重构回退。

交付目录：`packages/2.2-6-beta01-native-session-groups/`。最终构建记录、每套包的版本与架构、双架构 UUID/dSYM 对应、生产输入哈希和历史包保留校验由 `final-build-result.json`、`final-build-*-result.json` 和 `build-input-sha256.json` 保存。调试符号打包为 `com.wechat.improve_2.2-6-beta01_symbols.zip`，安装包和符号 SHA-256 见交付目录 `SHA256SUMS`。

## 尚需真实微信验收

本次未连接、安装或重启设备微信，没有修改实际账号、聊天记录、数据库或配置。主机 Foundation/方法 fixture 及双架构编译不证明真机帧率、耗电或每个微信版本的私有接口行为。

应在用户原有微信与账号环境验收：切组和组外新消息、置顶及取消置顶、滑动删除与延迟确认、进入/退出搜索及下一未读跳转、选择/转发候选完整性、折叠入口及子页、小程序返回首帧、密友锁定/揭示和账号切换。私有接口或输入无法证明安全时保留关闭边界，主列表元数据不稳定时最多自动重试三次，等待下一真实数据或生命周期事件恢复。
