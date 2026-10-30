# 2.1-15：第三轮性能优化与交付记录

日期：2026-10-29。基线 `fc1bcad8`（2.1-14），在既有工作目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 实施已确认的 7 项优化。

## 范围与保护边界

1. 朋友圈详情：互动隐藏未生效时跳过互动数组投影，隐藏生效时继续核对可变原生来源；保留旧账号空数据、临时替换恢复和点击身份校验。
2. 折叠分组：复用一次完整成员、隐私、去重和统计结果，以不可变展示值附加最终摘要；保留稳定排序和摘要来源校验。
3. 悬浮底栏：同一同步布局过程合并主表发现，下一次布局重新发现；继续实时计算几何、原生 inset、角标和最大可见表选择。
4. AI 凭据：后台异步读取 Keychain，合并同账号和凭据版本的同时请求；结果不作长期明文缓存。凭据准备计入既有执行期限，返回后重验账号、配置、取消和批次所有权。
5. 自定义气泡：缓存实际运行时类与 selector 对应的 ABI 信息；动态业务值继续调用当前消息派发，保留原生图片、消息复用和主题检查。
6. 通讯录：仅在原生分区索引回调 `mmsectionIndexTitlesForTableView:` 内复用已校验投影，将两次完整来源核验合为一次；回调外及下一次回调仍核对原生数据，保留账号、隐私状态以及最终选择校验。
7. 导航头像标题：同步合并多项设置引起的布局，配置完成后统一测量；保留联系人覆盖全局的顺序、图片优先级和独立 setter 的即时效果。

本轮不改变真实联系人、群成员或聊天记录，不安装到设备，不运行用户服务，也不操作真实消息数据库。测试使用临时文件、隔离偏好和原生接口替身。耗电、温度和帧率效果需要真机对比测量。

## 核心回归

仅运行受影响的核心脚本与新增边界测试。以下均通过，具体命令及断言见对应日志、测试源码与子项说明。

| 检查 | 结果 | 日志 |
| --- | --- | --- |
| 朋友圈详情 | 143 项 | [详情](framework-detail.log) |
| 折叠分组与会话展示 | 155 + 44 项 | [会话](framework-session.log) |
| 分组角标 | 136 项 | [角标](framework-group-badges.log) |
| 通讯录索引同步读取 | 16 项 | [读取范围](framework-contacts-read.log) |
| 原通讯录、搜索、转发与标签保护 | 通过 | [通讯录回归](framework-contacts-regression.log) |
| AI 生产凭据队列 | 30 项；7 次替身底层读取，主线程 0 次 | [凭据](ai-credentials.log) |
| AI 批次调度 | 4,496 项 | [Coordinator](ai-coordinator.log) |
| AI Manager | 490 项 | [Manager](ai-manager.log) |
| AI Store、Client | 通过 | [基础回归](ai-foundation.log) |
| 悬浮底栏几何、生命周期与快照 | 通过 | [底栏](ui-tabbar.log) |
| 气泡策略、渲染与适配器 | 36,979 + 2,555 项 | [气泡](ui-bubble-style.log) |
| 气泡与连续消息合并 | 通过 | [合并](ui-merge-bubble-integration.log) |
| 导航标题批量布局 | 15 项 | [标题布局](ui-navigation-title-batch.log) |
| 导航图片加载与失效 | 131 项 | [导航图片](ui-navigation-images.log) |
| 插件入口、升级备份启动 | 21 + 25 项 | [入口与升级](plugin-framework.log) |

新增行为证据包括：未启用互动隐藏时 100 次行数查询零数组遍历与投影；一次折叠发布仅一次完整子投影和一次父投影，附加摘要不修改旧值或计数；同一底栏布局的多次同步更新只在结束时发现一次主表，转场快照保持同步；索引回调从两次完整来源核验减为一次，下一次仍检测同指针、同长度的原地变化；导航批量配置只测量最终文本一次；凭据等待中取消、切号、修改 Key 或超时均拦截迟到结果。

- [AI 凭据实现与测试说明](ai-credential-report.md)。
- 关键生产代码还经过独立交叉审阅，复核摘要投影的不变性及异步任务的所有权和失效边界。

- [朋友圈、折叠投影与通讯录索引说明](framework-review.md)，含原生同步读取证据和复用范围。

## 完整构建与产物核验

`control`、插件显示版本 `kPluginVersionString`、内置版本说明和仓库 README 均为 **2.1-15**。两个方案分别使用全新临时目录完整构建 arm64 和 arm64e，未执行 `make clean`。Rootless、Rootful 均退出码 0，耗时分别为 19.545 秒、19.600 秒。

每个方案各有 6 条既有警告：两条 `UILocalNotification` 弃用、两条 `statusBarFrame` 弃用、两条 `-multiply_defined` 链接选项过时，与 2.1-14 相同，未出现新增警告类别。构建前后 42,511 个生产输入文件的 SHA-256 一致。构建前的 1,259 个现有构建或安装包文件全部保留，内容未变。

安装包均确认为 2.1-15，动态库均包含 arm64／arm64e，最低编译目标 iOS 15.0。包内过滤 plist、版本字串、staging 与包内二进制一致性通过检查；AI 异步凭据和底栏布局入口已导出，支付摘要、来电保护、未读面板及既有性能接口保留。四份 dSYM UUID 与对应二进制匹配，符号 ZIP 的 12 个文件 CRC 通过。独立 `shasum -a 256 -c SHA256SUMS` 三项全部通过。

- [构建命令和结果](build-result.json)、[Rootless 日志](build-rootless.log)、[Rootful 日志](build-rootful.log)。
- [包内容、架构与符号验证](package-verification.json)、[独立 SHA-256 复核](independent-shasum.json)。
- [最终源码和历史产物一致性检查](final-source-and-artifact-check.json)。

## 安装包

| 环境 | 安装包 |
| --- | --- |
| Rootless | [com.wechat.improve_2.1-15_iphoneos-arm64.deb](../../../packages/2.1-15-performance/com.wechat.improve_2.1-15_iphoneos-arm64.deb) |
| Rootful | [com.wechat.improve_2.1-15_iphoneos-arm.deb](../../../packages/2.1-15-performance/com.wechat.improve_2.1-15_iphoneos-arm.deb) |
| 调试符号 | [com.wechat.improve_2.1-15_symbols.zip](../../../packages/2.1-15-performance/com.wechat.improve_2.1-15_symbols.zip) |
| SHA-256 | [SHA256SUMS](../../../packages/2.1-15-performance/SHA256SUMS) |

按设备当前注入环境选择对应安装包；两种包的动态库都包含 arm64 和 arm64e。此次完成本地打包，真机显示、交互及实际耗电、温度仍需设备验收。
