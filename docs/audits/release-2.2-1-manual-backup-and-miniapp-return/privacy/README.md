# 2.2-1 小程序返回隐私修复核验

基线相关文件全部由权威 2.1-20 manifest 对账；新测试先针对冻结目录 `/tmp/wechat-221-exact-2120-baseline` 的未修改源码执行。最终相同断言集：**基线 72 checks / 26 failures，修复后 72 / 0**。首次较小红集 48 / 10 单独保留，不计入成功数。

真实生产源码重放确认一个可产生该现象的路径：原生容器在 native index scope 内触发 UITableView 内容 layout，2.1-20 的 cell/data-source 代理因此按原生行集合交付。锁定案例稳定态是 4 个过滤行，返回首次 layout 却交付 7 行，其中 3 个应隐藏行；ordinary-B 的 y 从稳定态 64 变成 128，ordinary-C 从 128 变成 320，ordinary-D 从 192 变成 384。修复后首次交付 4 行、隐藏会话原生 cell 调用 0，section/行 y/卡片首末标记/offset 与过滤后稳定记录逐项一致。解锁案例保持 7 行。

## 改动范围

- Adapter 新增 UITableView 内容 layout 边界；重用 2.1-20 已有 IndexScope，将真正 UIKit 内容 layout 限定在 display 坐标域。没有改原生控制器的坐标语义或生命周期。
- 就绪检查核验 policy、账号、原生 snapshot epoch、projection 的真实 privacyRevision getter，以及非 snapshot retry 占位。还检查已发布行集合不包含当前应隐藏的身份，防止先采用过期解锁投影或 blocked 期间的空投影几何。
- 未就绪时不执行本次内容 layout；重用基线 ListShield 对已有内容整组中性化，保留原行数、内容范围和 offset。通过已有事件与刷新队列恢复，不新增 timer、延时、rowcount 归零、layer mask、快照或整表 reload。
- 刷新结束时只增加一个 held 状态释放条件，避免同步重入把仍不安全的旧 cells 解屏蔽。原始 layout 内发生策略变更时，旧任务不能释放新边界；非 blocked 的策略变更通过一次事件驱动刷新收口。
- MainFrameTableView 只新增 layoutSubviews hook，委托上述边界。
- 原有 lifecycle/search fixture 各仅新增 `sessionLayoutHeld` BOOL 声明以承接新增生产状态，未改任何既有断言。

## 测试与证据边界

新用例实际执行提取的完整生产 layout 方法、UITableView hook、proxy cell 与 forwarding 方法、refresh finally 释放分支，以及真实 IndexScope、Projection、NativeBridge、Policy、InvocationMapper、ListShield。仅 UITableView 本体 layout、64px 行高和触摸/offset 行为是明确的主机替身，不是 iOS 模拟器或真机运行日志。`red-layout-records.json`、`green-layout-records.json` 保存原始代理交付/几何记录。

断言覆盖：不依赖 appear 回调的容器返回、策略晚到、锁定/解锁、过期聚合摘要策略修订、blocked 空投影变 ready、同账号旧 epoch、retry 占位、发布中及 native transaction 中重入、异常时 scope finally 恢复、native-off 后释放、原始 layout 内同步策略发布及后续恢复。没有改变保护身份、解锁规则或圆角算法。

原有重点回归：close-friend-session **174 / 0**、session-presentation **55 / 0**、group-lifecycle **191 / 0**、group-viewport **72 / 0**、group-search **54 / 0**，合计 **546 / 0**。加新增 **72 / 0**，本隐私范围成功数 **618 / 0**，红测不计入。没有运行 2.1-21 至 2.1-31 已删除的回归套件。

真机仍需确认：自然小程序返回是否命中这条 scope 路径、真实 UIView/UIPan 身份与触摸链路、真实布局/滚动量及屏幕最初露出帧。主机证明的是生产方法的可复现漏洞与修复后的交付契约，未把它写成真实手机生命周期计数或“已消除所有屏幕泄露帧”。

新增替身计数器已通过控制项：直接 setter 和 animated setter 的两次 offset 写入均被记录，轨迹为 20→60；一次 reloadData 被记录。初始化后清空计数再测返回，因此 0 次 offset 写入/0 次整表刷新来自已验证的拦截计数，非恒零字段。iOS 定向编译亦通过 arm64 + arm64e（生产 Adapter/Projection/NativeBridge/SessionPresentation 与 Logos hooks）；该重复主机运行不重复计入成功数。
