# 2.1-24：切换分组保留列表位置

日期：2026-10-30。基于同一 checkout 的 2.1-23，按用户要求聚焦核心回归。

## 行为与实现

点击或滑动切换聊天分组时，恢复目标分组已保存的会话位置；切回另一个分组时恢复它自己的位置。从聊天会话返回聊天列表继续保留原位置。没有可恢复锚点的分组、空列表和短列表沿用微信原生布局，不新增单独的位置缓存或强制回顶。

修改 [CSGroupListAdapter.m](../../../Controllers/CSGroupListAdapter.m) 的 `selectIndex:`：取消旧的 `pendingScrollToTop`，保留目标分组锚点。现有 `refresh` 已按“保存旧 publishedTabID 的锚点 → 发布目标分组 → 恢复目标锚点”的顺序执行，因此不重复调用保存。点击与滑动共用该方法，无需分别维护。保存位置沿用已有内存状态，不新增计时器、轮询或磁盘保存。

上一版 Hook 中关于切组回顶的注释同步更新；版本、内置说明及 README 更新到 2.1-24。与 2.1-23 冻结的生产输入比较，仅 adapter、Hook 注释和三处版本／说明文件改变，其余 42,508 份一致，见 [输入对照](production-input-comparison.json)。

## 核心回归

位置套件执行真实 `selectIndex`、锚点及 appearance 方法，fixture 保持生产的保存／发布／恢复顺序。覆盖 A/B 分组往返的独立位置、重复选择当前分组不滚动、新选择取消旧回顶请求、无锚点和短空列表的原生位置，以及聊天往返、刷新与行高变化。

修复前位置套件为 **131 项、13 失败**；修复后 **131 项、0 失败**。原始日志见 [修复前](regressions/group-viewport-before-fix.log) 和 [修复后](regressions/group-viewport-fixed.log)。

| 核心套件 | 检查数 | 失败数 |
| --- | ---: | ---: |
| 分组位置与聊天返回 | 131 | 0 |
| 分组选择稳定性 | 30 | 0 |
| 分组滑动及菜单交互 | 124 | 0 |
| 合计 | **285** | **0** |

[回归汇总](regressions/regression-summary.json) 记录日志与源码 SHA，修复前失败对照不计入成功总数。本次未扩展到圆角、备份或后台策略等无关套件；主机替身不覆盖微信／UIKit 真机渲染。

## 打包与交付

[Rootless 和 Rootful 构建](build-result.json) 均成功，均包含 arm64／arm64e，最低编译目标 iOS 15.0。沿用现有 Theos，在独立输出与 staging 目录完整编译，没有清理既有 `.theos` 或 `packages`。每套 6 条既有警告与 2.1-23 的警告集合完全一致，见 [警告对照](warning-baseline-comparison.json)。

[制品验证](package-verification.json) 已通过：两包版本、路径、依赖及完整载荷正确；符号 ZIP 的 12 个成员通过 CRC 和字节比较，四份交付 dSYM 的 UUID 与包内架构匹配；42,513 份生产输入与构建冻结清单一致，1,295 份历史制品独立重算哈希确认保留。另以 `shasum -a 256 -c SHA256SUMS` 独立复核三个交付文件，全部 OK。

- [Rootless 安装包](../../../packages/2.1-24-group-position/com.wechat.improve_2.1-24_iphoneos-arm64.deb)：用户当前使用的注入环境。
- [Rootful 安装包](../../../packages/2.1-24-group-position/com.wechat.improve_2.1-24_iphoneos-arm.deb)。
- [调试符号](../../../packages/2.1-24-group-position/com.wechat.improve_2.1-24_symbols.zip)。
- [SHA256SUMS](../../../packages/2.1-24-group-position/SHA256SUMS)。

未安装到设备或修改手机配置。真机验收可在 A 组滚动、切到 B 组再滚动，然后通过点击与滑动分别切回，确认各组位置；进入会话再返回应继续保持位置。本轮没有新增真机 CPU 或耗电采样。
