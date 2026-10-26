# 2.0-9：切换器与摇动锁定的静默隐藏

2026-10-24。按用户澄清，“摇晃隐藏”指现有摇动锁定的静默效果。本版撤除 2.0-8 的抖动、缩放、文字占位，补齐后台锁定的同步时序。测试和构建使用原 checkout、已有独立 Theos 缓存及临时测试目录，没有连接或改写真机数据。

## 两条路径的实际差异

修复前代码保存在 [`before/Controllers/CSCloseFriendManager.m`](before/Controllers/CSCloseFriendManager.m)。

| 阶段 | 前台 `handleShake` | `resign` / `suspend`，后台模糊关闭 |
| --- | --- | --- |
| 进入锁定 | `canLockForShake` 通过后直接调用 `lockAndReturnToSafePage` | 先设置 `backgroundCoverRequired=YES`，再调用同一个锁定方法 |
| 遮罩 | `cover` 在锁定之前同步添加临时整窗遮罩 | `cover` 因后台模糊关闭而不添加，并清掉已有遮罩 |
| 授权状态 | `runtime.lock` 同步撤销授权 | 同样同步撤销授权 |
| 退出密友聊天 | 原生导航以 `animated:NO` 执行 | 相同导航函数与无动画参数 |
| 策略刷新 | `runtime.didChange → schedulePolicyRefresh → dispatch_async(main)` | 同样排到下一轮主线程 |
| 收尾 | 另一个主线程异步块移除前台遮罩 | `setActive:NO` 又使策略失效；旧顺序没有同步消化它 |

需要纠正一个源码层面的假设：原 `handleShake` 也不是所有工作都在同一帧同步完成。它是先同步挂遮罩，后异步刷新，再异步移除遮罩。前台遮罩掩盖了中间过程；后台模糊关闭后，该遮挡不存在。

录屏中的整表空白还有一个确定的列表级原因：2.0-7 `CSGroupListAdapter.closeFriendPolicyChanged:` 将整张 `UITableView` 隐藏，而 `refresh` 的非活跃门禁直接返回，直到回前台才恢复表格。因此分组栏、头部和普通会话一起消失，标题与底栏保留。重新解码视频的帧证据和原版代码见 [2.0-8 的历史分析](../switcher-hide-transition-2.0-8/README.md)。2.0-8 修正了表级门禁，但新增动画不符合最终需求，且 Manager 的异步策略通知仍然存在。

原始视频能够确认可见空白区间，不能据此确定 SpringBoard 的内部快照调用时刻，也没有真机 trace 证明快照必定位于某个通知之前或之后。本次保证插件在生命周期回调返回前完成锁定和会话策略发布，不再主动把它推迟到下一轮主线程；最终系统快照仍需真机验收。

## 最小修复

`Controllers/CSCloseFriendManager.m`：

1. 把策略通知收尾提取为 `flushPolicyRefresh`。常规配置变化仍可合并异步处理；锁定主动同步消化待处理策略，已经排队的任务发现没有 pending 后直接返回。
2. `lockAndReturnToSafePage` 在 `UIView.performWithoutAnimation` 内依次完成：按原开关规则挂罩 → 撤销授权/验证 → 无动画退出敏感页 → 同步通知并更新列表 → `layoutIfNeeded` → 移除前台临时遮罩。前台不再把移除遮罩留到后续主线程回合。
3. `suspend` 将 `setActive:NO` 提前到共享锁定方法之前，把它产生的策略失效一起纳入同步刷新。
4. 回前台时先消化最新策略，再解除已有遮罩。生物识别短暂 inactive 的挑战保留分支继续沿用；真正后台仍立即取消挑战。

`Controllers/CSGroupListAdapter.m` 与 `Controllers/CSCloseFriendListShield.h/.m`：

- 保留此前修正的隐私专用非活跃刷新通道，保持表格与表头可见，普通后台更新仍不持续发布。
- 删除整个 `CSCloseFriendListTransition`，不再提交 `CSCloseFriendHideShake` / `CSCloseFriendHideSettle`，没有隐藏动画、缩放、截图或动画结束回调。
- 正常锁定在当前调用中同步过滤密友，普通会话直接保留。
- 微信原生列表事务尚未结束时，只让敏感/无法确认安全的单元格不可见；不隐藏整表、不添加“密友已隐藏”文字或新视图。事务结束后直接发布最终列表。极端事务延迟时，原表仍可能暂时保留该行高度，但不会因此移除普通会话和分组栏；本次没有绕过原生事务强行修改行数。
- 单元格复用前归还原可见性，不覆盖新单元格配置；发布异常或账号不可读时继续抑制敏感内容。

关闭后台模糊时依旧不添加整窗后台遮罩。本次是修复内容发布时序，未重新引入后台视觉遮挡。

## 修改前失败证据

生产代码修改前完成三组验证：

| 被测实现 | 结果 | 证据 |
| --- | --- | --- |
| 保存的 2.0-7 列表代码 | 空白边界 2 项，2 失败 | [`before-blank.log`](before-blank.log) |
| 2.0-8 Manager，新增同步时序要求 | 37 项，5 失败 | [`before-timing.log`](before-timing.log) |
| 2.0-8 列表转场，新增无动画要求 | 98 项，3 失败 | [`before-silent.log`](before-silent.log) |

空白边界用例在发送 inactive + 锁定通知后直接检查，不经过 RunLoop drain：表格必须可见，隐私发布必须完成。时序用例同样在生命周期方法返回后立即检查策略代数，再运行下一轮确认没有重复通知。无动画用例检查实际提交到 layer 的动画。

## 修复后核心回归

六个相关入口合计 **641 项检查，0 失败**，没有跑全量脚本：

| 入口 | 检查数量 | 主要覆盖 |
| --- | ---: | --- |
| `Tests/verify-group-lifecycle.sh` | 98 | 切换器空白边界、事务延迟、敏感单元格抑制、无抖动/缩放、异常、账号、重用、无后台刷新循环 |
| `Tests/verify-group-search.sh` | 54 | 共用的完整 `refresh` / 投影路径，普通会话及分组/表头保留 |
| `Tests/verify-background-privacy.sh` | 40 | 真实 Manager 方法的同步发布、无动画作用域、布局、摇动与后台路径、模糊开关 |
| `Tests/verify-background-blur.sh` | 229 | 后台模糊开关及生命周期兼容 |
| `Tests/verify-close-friend-runtime.sh` | 202 | 运行时 94、到期调度 9、生物识别 99；包含真实新策略调度方法 |
| `Tests/verify-close-friend-shake.sh` | 18 | 现有摇动识别、生命周期、过期回调、原生后备路径 |

另单独重放原空白边界，2 项均通过，见 [`switcher-blank-fixed.log`](switcher-blank-fixed.log)；不重复计入上述 641 项。

所有日志位于本目录。测试直接提取生产方法并编译真实单元格保护代码、运行时/投影代码，UIKit 和系统认证采用宿主替身。它能证明通知/发布时序与视图状态，不能替代真机的逐帧渲染和 SpringBoard 截图验证。

## 构建与验收

版本 **2.0-9**。增量构建 Rootful `iphoneos-arm` 与 Rootless `iphoneos-arm64`，两者均包含 arm64 / arm64e；历史包及符号保留，未执行 `make clean`。配置见 [`build-environment.json`](build-environment.json)，源码摘要见 [`source-sha256.json`](source-sha256.json)。

[`verify-packages.py`](verify-packages.py) 校验版本、架构、匹配 dSYM、同步策略与单元格保护符号；确认旧转场类和两个动画 key 不在 dylib 中、测试替身未混入。包路径、大小和 SHA-256 记录在 [`packages.json`](packages.json)。

真机验收步骤：

1. 使用原注入/签名流程更新并完全重开微信，确认设置页为 2.0-9，保留原账号、配置和数据。关闭后台模糊，在“私聊”准备至少一条普通会话和一条密友，临时解锁密友。
2. 慢速拉起切换器、取消返回、再次拉起并真正回桌面。录屏逐帧检查：密友直接消失，普通会话和分组栏保持存在，没有只剩标题/tabbar 的空白帧，没有抖动、缩放、淡入淡出或提示占位。
3. 回前台重新解锁，轻摇手机触发“摇动立即锁定”，应同样静默隐藏。连续重复，检查没有延迟闪白或残留遮罩。
4. 从密友聊天页切后台，回前台应在安全会话列表；再在列表滚动、侧滑菜单、收到新消息的情形重复。普通会话应可继续点击。
5. 分别开启/关闭后台模糊验收其原有行为；Face ID 临时 inactive 仍应正常完成验证，真正切后台应取消验证并保持锁定。

目前没有连接真机。若仍出现闪空，请提供 2.0-9 录屏、iOS/微信版本、后台模糊与分组开关状态，以及当时所在页面，以便定位实际 UIKit/宿主时序。
