# 新增首帧边界测试口径

- 脚本：`Tests/verify-miniapp-first-frame.sh`；用例：`Tests/MiniappFirstFrameTests.m`。
- 红色输入：逐文件 `git show faa294ff:path` 导出到工作树外，仅编译宿主测试。adapter SHA256 为 `82e96b805c63593b036804ca46159de95e44b15c3dfb59f6377ebc0b423c8ec8`；Hooks 为 `7e3ed572e1937a93cc6e82638972c45509fcd894dba6731dccf663a74411e806`。
- 最终同批断言：旧代码 **56 checks / 23 failures**，修复后 **56 checks / 0 failures**。红色项不计入成功数。具体失败项及每个场景原始记录见 `miniapp-first-frame-results.json`，完整输出见 red/green 日志。
- 测试执行完整生产 `performSessionListLayout:`、投影/隐私策略/index scope/cell 交付、visibility gate 与三个 WA dismissal hook 方法。fixture 先在 native index scope 准备真实交付路径产生的旧 cell，然后在两阶段之间 **不调用表格内容 layout**，在 `%orig` 替身进入时记录可见 cell 身份。
- 三个入口均为：红色首帧 3 条隐私行 / 7 条可见行；绿色首帧 0 条隐私行 / 0 条可见行（中性态）。绿色 gate 后一次内容 layout 继续 hold，随后 refresh 的真实 finished 收尾清 gate hold，过滤后仅一次内容 layout 恢复 4 条安全行。
- 安全行恢复时 section、row、y、卡片首末行标志及滚动 offset 与初始过滤后稳定态逐项相等。预检不写 offset、不新增整表 reload；中性化保留 contentSize/inset/scrollEnabled/userInteraction/手势/chrome 状态替身。
- 同步策略变化通过工作树外临时 fixture 的 snapshot provider 在第二次读取时注入，验证 expiry 等价锁定变化/账号及 epoch 变化在原始 dismiss 回调前整批中性化。生产 `CSCloseFriendCurrentSnapshot` 未改动。
- 未知 `hideSessions` 类型覆盖 gate → publishing layout → finished 收尾 → 后续 layout，持续保持中性，直到已知策略 + refresh 后仅恢复安全行。
- **主机未验证**：真实 UIKit cell/view 身份、自然小程序回调顺序、屏幕中间帧、实际触摸命中链路。程序修改 contentOffset 仅证明替身的中性态没有写坏几何/标志，不能宣称真机拖动已通过。
