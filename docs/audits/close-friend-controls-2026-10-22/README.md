# 1.9-7：密友长按设置与朋友圈可见范围图标

2026-10-22，修改并构建于原 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，分支 `main`，基础提交 `f82de803`。保留工作区原有 1.9-6 备份功能改动，在该状态上交付本次功能。

## 行为与入口

进入 **插件设置 → 账号与安全 → 密友 → 保护选项**：

- 新增“首页长按解锁”，默认开启；关闭后导航栏长按不再解锁，首页搜索完整密码仍可解锁。
- 新增“长按触发时长”，接受 **0.5–2 秒**（含端点及小数），默认 **1 秒**。保存后更新现有手势；关闭开关仍保留时长。非法值不写入配置。
- 设置继续存入当前账号原有加密 profile。旧 profile 缺少新字段时使用默认值，不迁移或重建用户数据。
- 修复“隐藏全部朋友圈可见范围图标”对**我的朋友圈列表（含照片缩略图）**和**动态详情**的遗漏。与原有动态流隐藏共用同一开关，临时解锁期间仍生效；关闭图标隐藏或关闭密友功能后，按当前动态原生状态恢复。
- 图标隐藏独立于密友名单是否为空、是否开启隐藏动态/互动。动态的真实可见范围、联系人选择、发布权限及原始数据保持原样；发表/私密发表入口、删除、收藏等其他操作保持原生行为。

## 框架与根因

项目使用 Theos、Objective-C、Logos，Makefile 自动编译 `Controllers/*.m` 与 `Hooks/*.xm`。密友采用 Policy 校验配置、Store 按账号加密持久化、Runtime 管理认证/临时显示、Manager 接入生命周期、各 Adapter 处理微信展示的结构。

原 Manager 的 `minimumPressDuration` 固定为 1 秒且没有开关；新增选项在 Policy 中做严格布尔/有限数值校验，由 Manager 的既有策略刷新更新手势。账号或阈值变化会取消旧手势，回调再次校验最新账号、开关和阈值，避免旧触摸在新配置下解锁。

原朋友圈图标实现只覆盖 `WCTimeLineCellView.m_privacyButton`。这次新增独立 `CSCloseFriendPrivacyAdapter`：

1. 我的朋友圈使用 `WCListCellStatusInfo.showsGroupedStatus/showsPrivateStatus` 生成普通状态图标、缩略图覆盖层、宽度和无障碍说明。拦截展示状态，处理已创建图标，并在开关变化时调用原生 `initView` 重建当前动态的展示。
2. 详情使用 `WCCommentDetailViewControllerFB.canShowPirvacyButton`（微信原始拼写）控制 `_privacyBtn` 创建；策略改变时原生 `initTableHeaderView` 会清理并重建按钮，布局入口保留 `double` 返回签名。隐藏时拒绝旧按钮的 `onShowGroup` 回调。
3. 使用独立弱引用刷新表，不覆盖详情页已有点赞/评论刷新，也不保留已回收的列表对象。
4. 原生/Flutter 路由条件纳入 `hidePrivacyIcons`，不再依赖密友名单非空或其他隐藏开关。

对应微信 `8.0.78` 样本已静态确认：列表及详情的小人图标为 `person_2_filled`；缩略图 helper 明确通过上述两个展示状态调用 `showSharedStatus:` / `showLockStatus:`；真实 ACL 不在修改路径。完整边界与定位见 [原生证据](native/README.md)。

## 验证

[主机回归结果](test-results.json)：以下 8 个脚本全部退出 0，总计 464 个计数检查，另包含 social 语义回归。

| 脚本 | 检查范围 | 结果 |
| --- | --- | --- |
| verify-close-friend-core.sh | 新字段默认值、边界、非法值、加密保存/读取、原有策略与存储 | 246 |
| verify-close-friend-runtime.sh | 认证与账号隔离、关闭长按后搜索密码仍可解锁、超时调度 | 94 + 9 |
| verify-close-friend-recovery.sh | 实际 Manager 方法，手势复用、即时更新、取消旧触摸、导航/前后台/账号门控 | 22 |
| verify-close-friend-privacy.sh | 实际 PrivacyAdapter，列表缩略图/详情隐藏恢复、复用、公有动态、弱引用及原状态保留 | 17 |
| verify-close-friend-album.sh | 个人页隐藏、原生入口、仅图标开关且空名单 | 21 |
| verify-close-friend-detail.sh | 详情互动、原数组与动作身份、仅图标开关且空名单 | 37 |
| verify-close-friend-social.sh | 动态流、缓存、显示投影、发布候选、原 ACL、账号/锁定状态变化 | 通过 |
| verify-close-friend-shake.sh | 已有摇动锁定与生命周期 | 18 |

主机使用独立临时目录、测试账号和 UIKit 替身；不读取设备数据库或钥匙串。它们证明代码的策略/适配器行为，不代表真实 UIKit 视觉验收。

[双架构 iOS 编译](ios-compile.log)通过。完整 Rootless 构建成功，见 [构建日志](build.log)。保留项目已有弃用 API 与链接器警告，没有本次新增代码的编译错误。

## 产物与环境保留

- [1.9-7 Rootless 安装包](../../../packages/com.wechat.improve_1.9-7_iphoneos-arm64.deb)
- [arm64 / arm64e 调试符号](../../../packages/WeChatImprove-1.9-7-dSYMs.zip)
- [包版本、架构、UUID、源码哈希和原文件保留核对](package-verification.json)

包版本、插件内版本、更新说明同步为 1.9-7。包内动态库包含 arm64 / arm64e，两个 dSYM UUID 均与实际包内动态库一致。包 SHA-256：`b8dc7943a19c3b8ee26604f6fc80d06b7d682e47566fb03ec5faa60fbb09dcc6`。

使用原 checkout 编译，构建缓存和暂存输出位于隔离临时目录，最终产物复制回原 `packages/`。未运行 `make clean`、切换 checkout、安装设备或重启微信；历史安装包及既有备份源码共 31 个文件哈希保持一致。发布元数据修改前的副本位于 `previous-release-metadata/`。本任务没有 Web 服务、前后端端口或新数据库；运行时密友数据仍为微信原容器内 `Library/Application Support/WeChatImprove/CloseFriends/`。

## 真机验收边界

当前没有连接设备，因此未声明已在用户手机安装或完成视觉验收。安装适合设备注入环境的 1.9-7 后，应完全退出并重新打开微信：

1. 在密友设置中验证长按开关，分别设置 0.5、1、2 秒；关闭后导航栏长按无效，但搜索完整密码仍能解锁。
2. 开启图标隐藏，进入“我的朋友圈”，确认截图位置的小人图标消失；点击动态进入详情，确认时间旁的小人图标消失。
3. 关闭后重新核对相同动态，图标按真实权限恢复；滚动复用列表、切换动态和临时解锁后再次核对。公开动态不应新增图标，删除与发布入口应可用。

已经打开的 Flutter 页面不会被原地替换为原生页面，开关切换后应退出该页面再进入；新建页面按更新后的路由选择。不同微信版本、实际布局以及其他插件组合仍需真机核对。
