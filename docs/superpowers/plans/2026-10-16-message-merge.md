# Message Merge Implementation Plan

**Goal:** 修复连续消息归组、群聊/私聊间距和防撤回原文定位，降低滚动热路径开销。

**Architecture:** 保留原生节点与 Cell。纯策略判断相邻关系；每个聊天控制器拥有上下文，真实 indexPath 绑定消息而非搜索时间。原生测量作为高度来源，缺少已验证几何时不缩短行高。防撤回按实际会话和消息 ID 定位。

**Tech Stack:** Objective-C / Logos / Theos，iOS 15+，arm64 / arm64e；macOS Foundation 策略测试。

**Spec:** `docs/message-merge-refactor-proposal.md`，用户于 2026-10-16 确认实施。

## Global Constraints

- 使用现有 checkout，独立分支 codex/message-merge-refactor，不启动其他服务、不触碰微信数据库。
- 不改变现有配置键或已保存值；零间距有效；关闭后恢复原生。
- 未知消息类型、后台测量缺少上下文、私有接口不可用时原生回退。
- 不新增轮询、DisplayLink 或滚动时全表遍历，不根据头文件宣称实机验证完成。
- 组件强依赖同一绑定/测量协议，本轮直接顺序执行并进行整体审查。

## Task 1: 可测试的相邻策略、配置和导航数学

- [x] 新建 Controllers/CSMessageMergePolicy.h/.m，导出配置、消息描述、合并决策、安全间距与导航 ID/坐标纯函数。
- [x] Tests/MessageMergePolicyTests.m 覆盖不同会话/方向/发送者、系统边界、首末头像、同秒大量消息、缺失身份、负间距/NaN、严格链接解析和滚动夹取。
- [x] 使用 `Tests/verify-message-merge.sh` 以 macOS Foundation 编译并运行真实策略代码。

核心约束：`canJoin = sameAccount && sameSession && sameSender && sameDirection && supported`；`delta = max(requested, -verifiedSlack)`；没有几何时 verifiedSlack=0。

## Task 2: 会话上下文、原生测量与渲染

- [x] 新建 Controllers/CSMessageMergeAdapter.h/.m 与 Hooks/MessageMergeHooks.xm。
- [x] 真实表格的 section/row 绑定逻辑节点，长文本使用 parentModel，模型/视图关联弱 owner 与版本。
- [x] 原生 measure 统一应用安全间距，移除旧 table height 人工减值；未验证的多行压缩保持原生。
- [x] 原生布局前恢复自有隐藏覆盖，布局后差量应用，复用及开关变化闭环恢复。
- [x] 消息增删替换与布局失效合并刷新；原生事务中不嵌套 reload；浏览历史以身份和行内偏移保持锚点。

## Task 3: 头像、消息时间与气泡缓存

- [x] BubbleStyleHooks.xm 删除旧合并实现，加入有界图片缓存、正确通知回调，移除热路径日志。
- [x] AvatarHooks.xm 按模型会话组合原生返回值和用户设置，去掉全局当前聊天。
- [x] MessageTimeHooks.xm 在主线程绑定时间，避免后台捕获 Cell；头像隐藏时采用气泡侧边锚点。
- [x] 设置页共用配置默认值，读取不再写默认值；明确负间距按安全留白限制。

## Task 4: 防撤回定位

- [x] 新建 Controllers/CSMessageNavigation.h/.m 统一原文导航。
- [x] RevokeHooks.xm 两个入口复用导航，严格解析 ID，修复命中 session 和富文本转义。
- [x] 删除固定屏幕高度和 offset 回灌 margin；原文加载使用原生导航，完成时验证身份与可见范围，最多一次纠偏。
- [x] 合并刷新尊重用户导航与拖动，旧账号/旧会话请求自动失效。

## Task 5: 构建、审查与交付记录

- [x] 执行策略测试、Logos 转换与 arm64/arm64e 编译，处理本轮引入的警告和错误。
- [x] 审查数据更新、复用、测量递归、强引用环和关闭恢复，补充发现的回归用例。
- [x] 写 docs/message-merge.md，记录实际实现、保守回退和未完成实机验收。
- [x] 汇报最终源码及验证结果，不把本机构建当作设备已安装，也不覆盖已有安装包。

## 交付边界

2026-10-16：源码、本地测试、Rootless 1.6-1 构建与交付说明完成。上述勾选不代表设备安装或实机性能验收；实机检查仍按 docs/message-merge.md 执行。

兼容性追查：发现并修正点击显示时间时隐藏标签跳过定位的回归，补充点击开关/无有效时间保护；新增 9 项检查，合计 7,008 + 44 项通过。生成独立 Rootless 1.6-2 包，原 1.6-1 包保留。
