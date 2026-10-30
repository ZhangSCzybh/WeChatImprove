# 2.1-26：返回聊天列表时保持未变化的顶部业务内容

日期：2026-10-30，Asia/Shanghai。基于现有工作目录和 `main` 分支构建，前版提交为 `3810d735`。

## 问题与修复

用户录屏显示：从“我”切回微信聊天列表后，约 1.07～1.17 秒，收藏置顶、电脑登录两行的图标和文字同时变空，白色圆角底板及下方会话位置保持，随后恢复。

源码确认离页的 `setPresentationSuspended:YES` 无条件合成 `Unknown | Content`，同时将内容归属改为未知。返回时，这会让内容没有变化的业务行也进入行重载及同步布局路径。

本版仅将离页合成的变化改为 `Unknown`：仍使快照失效并在返回时重新核对原生数据，同时保留已经入队的真实内容事件及其会话归属。真实未知刷新继续重载业务行；结构、账号和隐私变化继续使用原有发布边界。滚动高度捕获和恢复、搜索、圆角渲染及原生事件 Hook 未修改。

录屏现象与多余业务行重载相符，但没有采集微信原生按钮在 cell 之间重新挂载的运行时序，不能将这一具体 UIKit 过程当作已实测事实。

## 核心回归

按用户要求只执行以下三组修复后核心回归：

| 套件 | 检查数 | 失败数 | 证据 |
| --- | ---: | ---: | --- |
| 页面生命周期、顶部业务行与隐私边界 | 239 | 0 | [修复后日志](regressions/group-lifecycle-green.txt) |
| 分组切换及聊天返回滚动位置 | 151 | 0 | [日志](regressions/group-viewport.log) |
| 搜索进入、返回与分组内容 | 57 | 0 | [日志](regressions/group-search.log) |
| 合计 | 447 | 0 | [输入哈希和结果汇总](regressions/regression-summary.json) |

新增生命周期用例将真实离页/返回 Hook 产生并由生产 `refresh` 消费的事件状态，送入真实 `publishProjection:` 和 `CSGroupProjection` 发布判断。没有真实更新时，完整离开/返回对未变化业务行产生 0 次整表重载、0 次行重载、0 次同步布局请求；已归属会话只刷新对应行。另覆盖真实未知刷新、业务行增删、已验证输入值变化以及账号/隐私变化。

同套新增断言使用前版生产源码复现 239 项检查中的 7 项失败，见[修复前控制](regressions/group-lifecycle-red.txt)，不计入成功总数。红日志捕获后只收紧了两条断言说明并补充注释，断言逻辑没有变化。

主机替身提供业务行输入和 UIKit 操作计数，不验证微信原生业务文字读取、实际 UIView 身份或显示帧。原生快照没有收藏文字/电脑登录状态独立签名，真实同槽内容更新仍依赖原生通知、表格失效或原生视图就地更新，需真机覆盖。

## 构建与交付

Rootless / Rootful 均在独立临时目录完成全量编译、链接和打包，包含 arm64 / arm64e，最低目标 iOS 15.0。版本号、应用内说明和包元数据统一为 `2.1-26`。

- [构建结果](build-result.json)：两个方案退出码均为 0，42,513 份生产输入构建前后哈希一致。
- [输入差异](production-input-comparison.json)：相较 `2.1-25`，仅适配器、版本头、应用内说明和 `control` 四个生产文件变化，其余 42,509 份输入不变。
- [警告对照](warning-baseline-comparison.json)：两个方案各 6 条既有警告，内容及次数与 `2.1-25` 一致。
- [历史产物保护](preserved-artifacts-after.json)：既有 `.theos` 与安装包共 1,305 个文件未缺失、未修改；没有执行 `make clean`。
- [安装包核验](package-verification.json)：核对版本、安装路径、注入目标、payload、架构、依赖、dSYM UUID、符号归档和 SHA-256。

交付文件：

- [Rootless 安装包](../../../packages/2.1-26-banner-return/com.wechat.improve_2.1-26_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.1-26-banner-return/com.wechat.improve_2.1-26_iphoneos-arm.deb)
- [调试符号](../../../packages/2.1-26-banner-return/com.wechat.improve_2.1-26_symbols.zip)
- [SHA256SUMS](../../../packages/2.1-26-banner-return/SHA256SUMS)

## 真机验收

本版未向手机安装，未改写手机账号、配置或数据库。完成的是源码修复、主机核心回归和安装包交付，尚不能声称录屏中的闪烁已在真机消除。

沿用设备原有注入方案安装后完全退出并重新打开微信，在“我”/通讯录与微信之间往返，确认顶部两行持续显示；再检查离页期间收到消息、电脑登录状态或收藏置顶变化能够正常更新。分组切换及聊天返回继续按前版规则保持滚动高度。
