# Scroll boundary host probe

`red.jsonl` / `red.stderr`：冻结的 2.1-30 adapter、hooks、shield 上运行最终新断言，148 项、73 失败。`green.jsonl` / `green.stderr`：当前实现 148 项、0 失败。红日志不计入成功数。

这组运行执行提取出的真实 proxy、隐私筛选、完整 refresh、publication、shield、viewport 和 neutral completion 方法。输入中的“miniapp-container”和“chat-return”是两组受控入口名称，不能据此推断真机自然生命周期。表格测量、触摸/拖动、Core Animation 及手势对象为明确的主机替身。

最终中性态保留已发布的 section / row 数量与总包围盒，以不含文本的空 cell 提供几何槽位。中性态内部行高只服务于可滚动包围盒，内容全部由空 layer mask 遮蔽；测试不要求中性槽位的 y 坐标等于真实行。第一份重新可见的真实行集合、y 坐标与行高仍须等于经过隐私过滤的稳定态。旧测试中“未就绪返回 0 行/0 高度”的表现断言已对应更新，禁止原生私密内容调用、空白 required cell、空 header 文本、无额外刷新及锁定/解锁语义断言保留。

| 受控 blocked miniapp 阶段 | 2.1-30 | 2.1-31 |
| --- | --- | --- |
| 就绪 contentSize | 320 × 1244 | 320 × 1244 |
| 未就绪 contentSize | 320 × 80 | 320 × 1244 |
| 未就绪可见 cell 数量 | 0 | 18 个无文本槽位 |
| inset top / bottom | 100 / 0 | 100 / 0 |
| 起始 offset.y | 400 | 400 |
| 受控 +40 拖动后 offset.y | -100（内容塌缩后被 clamp） | 440 |
| 就绪后真正内容 offset.y | -100 | 400（恢复中性化前位置） |
| 未就绪 protected native cell 调用 | 0 | 0 |
| 未就绪 scroll callback 交付 | 1 | 1 |
| 未就绪 native-scope 行选择交付 | 1 | 0 |
| 未就绪查询/拖动整表刷新 | 0 | 0 |

每阶段 JSON 还记录 table 的交互/滚动开关、table pan、adapter pan/listPan、chrome 交互和 hidden 状态、可见/hidden cell 数量、contentSize、inset、offset 与刷新计数。此处开关属于实际执行方法可访问的替身属性，其初始值是测试控制量；它们并非从安装了微信的手机读取。

另有两类边界：就绪事件在正在拖动时到来，空 mask 与原始 viewport 保持到手势结束，再一次恢复原始 offset、mask 身份和 accessibility 状态；以及就绪目标为原生未分组且已解锁时，中性状态可正常退出，原有私密会话可见语义保持。冷几何入口重复查询也不得膨胀或塌缩 contentSize。真实政策 revision 变化会走原有 publication 的结构更新路径，该路径的刷新不计为中性查询/拖动新增的刷新。

重放命令：

```sh
bash Tests/verify-group-neutral-scroll.sh \
  docs/audits/release-2.1-31-service-tab-and-scroll/scroll-probe/CSGroupListAdapter.m-2.1-30.txt \
  docs/audits/release-2.1-31-service-tab-and-scroll/scroll-probe/SessionGroupHooks.xm-2.1-30.txt \
  docs/audits/release-2.1-31-service-tab-and-scroll/scroll-probe/CSCloseFriendListShield.m-2.1-30.txt
bash Tests/verify-group-neutral-scroll.sh
```

`red-initial112.*` 和 `red-per-row-cache148.*` 为修复设计收敛前保留的红测原始记录，最终汇总仅采用 `red.*` 和 `green.*`。前者的断言表现包含已放弃的逐行几何缓存方案，不应作为最终实现说明。

主机没有证明真实触摸命中链路、UIKit 对已缓存行高的自然查询顺序、实际 UIView / CALayer 对象的设备身份、真实返回动画的每一帧或真机滑动恢复时长。需要在相同服务号 tab 上以真机复录验证，同时检查两条返回路径的私密会话仍不可见。录屏触点的位移本身不能反推出系统是否收到 touchesMoved。
