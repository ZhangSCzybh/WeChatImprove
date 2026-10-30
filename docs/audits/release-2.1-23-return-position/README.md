# 2.1-23：修复聊天返回后列表自动回顶

日期：2026-10-30。基于同一 checkout 的 2.1-22 交付源码修复，继续提供 Rootless 与 Rootful 两套安装包。

## 问题与修改

从会话返回主聊天列表时，`NewMainFrameViewController -viewDidAppear:` 在完成原生回调和分组恢复后，无条件调用 `returnToGroupTop`。该方法发出回顶请求并删除当前分组保存的滚动锚点，导致已保留的位置被覆盖，后续数据刷新也无法恢复原锚点。

本版移除这一次无条件调用。普通页面返回沿用现有原生位置与分组锚点；主动点击或滑动切换分组继续请求回顶，已经由用户操作发出的待执行回顶请求也继续保留。恢复发布、密友隐私遮挡、搜索和交互期间的滚动保护沿用既有处理。相关源码见 [SessionGroupHooks.xm](../../../Hooks/SessionGroupHooks.xm)。

与上一版冻结的 42,513 份生产输入比较，仅四个文件改变：该 Hook、`control`、插件内版本常量和版本更新说明；其余 42,509 份一致，没有新增或删除生产文件，见 [输入差异](production-input-comparison.json)。本次运行逻辑只删除一次回顶调用，没有新增定时器、轮询或位置检测任务。手动备份、后台运行策略及上一版列表性能优化均继续包含。

## 回归证据

新增回归提取实际四个 appearance Hook，结合实际暂停、滚动锚点和回顶方法，覆盖完整进入／返回、取消转场、重复出现、空／短／长列表、返回后的数据刷新及行高变化，同时验证显式切组的回顶请求跨暂停后仅执行一次。

相同新测试使用旧 Hook 得到 **120 项、16 项失败**，使用修复后 Hook 得到 **120 项、0 失败**。[旧 Hook 日志](regressions/group-viewport-old-hook.log) 和 [修复后日志](regressions/group-viewport-fixed.log) 是为发布审计重新执行的可复现对照；首次红测未保存磁盘日志，不将重建日志标为首次输出。[对照元数据](regressions/group-viewport-comparison.json) 记录旧 Hook 的 HEAD 来源、命令、源码及日志 SHA。

| 套件 | 检查数 | 失败数 |
| --- | ---: | ---: |
| 列表位置与返回生命周期组合 | 120 | 0 |
| 分组选择稳定性 | 30 | 0 |
| 分组交互 | 124 | 0 |
| 增量列表更新 | 187 | 0 |
| 页面与前后台生命周期 | 223 | 0 |
| 分组表头语义 | 46 | 0 |
| 列表圆角及分组角色 | 1,631 | 0 |
| 合计 | **2,361** | **0** |

完整成功套件及日志 SHA 见 [回归汇总](regressions/regression-summary.json)。旧 Hook 的失败对照不计入成功套件合计。主机测试使用隔离依赖替身，不覆盖完整 UIKit／微信真机渲染。

## 编译与产物核对

使用既有 `/Users/zhangshichao/theos`，在新的独立输出和 staging 目录为两种 scheme 完整构建，均成功，包含 `arm64` 与 `arm64e`，最低编译目标 iOS 15.0。[构建结果](build-result.json) 和 [Hook 编译证据](hook-compilation-verification.json) 确认修改后的 Hook 在两种 scheme、两架构编译，源码与冻结清单一致。

每套构建有 6 条既有警告，去除终端颜色后与 2.1-22 警告多重集合完全相同，没有新增警告，见 [警告对照](warning-baseline-comparison.json)。未执行 `make clean`；既有 `.theos` 与 `packages` 中 1,291 份产物全部保持原字节，见 [保全结果](preserved-artifacts-after.json)。

[完整包验证](package-verification.json) 确认两包版本均为 2.1-23，完整载荷与对应 staging 一致，安装目录、依赖、架构、最低系统及 Filter 正确；已有功能、后台策略及手动备份符号存在，已删除的自动备份调度器与旧自动保存方法缺席。调试符号 ZIP 的 12 个成员通过 CRC 和字节核对，四份归档 dSYM 的 UUID 与两包的两个架构逐一匹配。最终重新读取 42,513 份生产输入及 1,291 份历史产物，均与构建记录一致。另以独立 `shasum -a 256 -c SHA256SUMS` 复核三个交付文件，全部 OK。

## 交付文件

- [Rootless 安装包](../../../packages/2.1-23-return-position/com.wechat.improve_2.1-23_iphoneos-arm64.deb)：1,543,316 字节，适用于用户之前使用的 Rootless 注入环境。
- [Rootful 安装包](../../../packages/2.1-23-return-position/com.wechat.improve_2.1-23_iphoneos-arm.deb)：1,541,390 字节。
- [调试符号](../../../packages/2.1-23-return-position/com.wechat.improve_2.1-23_symbols.zip)：11,188,598 字节。
- [SHA256SUMS](../../../packages/2.1-23-return-position/SHA256SUMS)。

本轮未向手机安装、修改手机配置或切换账号，也未进行真机 CPU、温度及续航采样。安装后仍需在原 iPhone／微信环境确认：把列表滚到中间，进入一个会话再返回，应保留原位置；随后主动切换分组，应继续回顶。真机显示与交互验收不能由上述主机回归及打包结果替代。
