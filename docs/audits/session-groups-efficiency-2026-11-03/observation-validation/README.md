# 2.2-10 分组观测范围

观测只出现在独立 `2.2-10+observe` 包。正式包将宏设为 0，并从编译源文件列表排除 observation `.m` 与 Logos hook；交付校验还对每个架构检查 signpost 字符串、导入与 API 符号。

所有 interval 都是同步方法边界的 elapsed wall time，包含同步宿主调用、可能的等待及嵌套操作，不能解释为纯 CPU 时间，也不能把嵌套 interval 相加。入口尝试、完成调用、实际 UIKit reload 与 Core Animation 提交是不同指标。

| 名称 | 边界与计数口径 |
| --- | --- |
| `AdapterRefreshDispatchAttempt` | Adapter `refresh` 总入口，包括各种早退；调用中可能由 native 转 compatibility。 |
| `AdapterRefreshAttempt` | 原有 native `refreshNativeSessionModel` 入口，仍包含早退。 |
| `CompatibilitySourceSnapshot` | 兼容源快照方法，包含缓存命中、宿主身份校验、元数据读取和失败返回。 |
| `AdapterProjectionBuild` | Adapter 投影构建方法，包含折叠快照处理；native 的元数据后备调用也可能进入，结合 route 判断。 |
| `AdapterPublication` / `CompatibilityPublication` | 两种发布方法的同步调用边界，调用完成可能没有任何 reload。 |
| `AdapterLayoutAttempt` | Adapter `layout` 方法调用，包含早退和无变化调用。 |
| `MainTableReloadData` / `MainTableReloadRows` | 只在已验证主列表的同步 publication scope 内，且 effective method 等于 UIKit base reload 实现时计数。 |
| `PublicationCompleted` | 已验证主表的发布调用正常完成；不代表界面内容实际变化。 |
| `ReloadDataCompleted` / `ReloadRowsCompleted` | 对应 reload 正常返回；rows 的 units 是此次路径数。 |
| `TabRecordsUpdateAttempt` / `TabLayout` | 进程内该类的方法范围，未建立可见 owner 关联，不直接称为屏幕分组栏刷新数。 |
| `KnownChangeHint` / `UnknownChangeHint` | Coordinator 输入的完整名单状态，units 为变化 kind。 |
| `AdapterKnownChangeHint` / `AdapterUnknownChangeHint` | Adapter 的 pending change 合并输入，覆盖 compatibility 具名通知；不可与 Coordinator 事件相加计算消息条数。 |

原有 `ModelFull`、`ModelDelta`、`ModelSelection`、`CoordinatorApply` 保留。hint 的 known 要求合法 NSSet、每项为非空字符串且不含 Unknown kind；结构 bit 不表示增量准入，仍由实际模型和 Bridge 校验证明。

`AdapterRoute` 在 refresh 进入与 finally 退出时各发一次，units 为固定 bitmask：

| 位值 | 含义 |
| --- | --- |
| 1 | Adapter 当前使用 native session model |
| 2 | Coordinator 已进入 sticky compatibility fallback |
| 4 | owner 是折叠会话控制器 |
| 8 | owner 是 `NewMainFrameViewController` 或其子类 |
| 16 | table/controller 两方向绑定都指向当前 Adapter |
| 32 | 此事件来自 refresh 的 finally 退出 |
| 64 | 当前为主线程 |

主表计数要求 8、16、64 都存在且 4 不存在，另外按发布方法核验 native/compat 状态。owner 校验支持 NSObject 派生的宿主主控制器，不要求 UIViewController。scope 为线程局部、栈上同步嵌套；nil/折叠/解绑/错误绑定/后台线程不会扩大主表计数范围。无法确认 UIKit override 分发时发 `ReloadDispatchUnverified`；这类记录缺失不能填为零次刷新。

事件仅记录固定枚举、kind、路径数量与 route 位。没有账号、会话名、消息内容或地址。观测本身仍有开销；正式包性能与观测包性能需分别标注。

`run-syntax-check.py` 用真实 iOS SDK 检查 arm64/arm64e、宏 0/1 的生产方法与 Logos 生成结果。真实 `.m` 的 scope/owner 主机行为验证见 `../review/observation/`。真机 CPU、CA commit 与 hitch 仍由后续 Instruments 实测确定。
