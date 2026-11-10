# 小丑功能转账菜单与系统时间修复：2.3-6

用户反馈已交付 2.3-5 在长按转账时缺少“修改金额”，以及修改系统时间后不能随原生点击在两种格式间切换。视频 `ScreenRecording_11-09-2026 16-11-08_1.MP4` 显示一次点击联动切换多条时间，格式分别为 `11月2日 13:39` 与 `11月2日 星期一 13:39`。

## 修复与依据

- 转账金额识别原先要求标题含 ¥、￥或元；微信 8.0.80 的 `innerTitleText` 可直接返回 `m_nsFeeDesc`，没有保证补齐币种标记。新增严格整串匹配，接受纯数字、规范千分位与币种前后缀。保留消息类型 49、原生转账 cell、当前账号／聊天与请求身份校验，不扩展到普通应用卡片或红包。真实 UIKit 菜单到编辑再到显示的检查能复现旧版纯金额菜单缺失，并在修复后通过；静态证据不能证明它是用户设备上唯一的过滤原因。
- 原隐藏方式 `source.layer.opacity=0` 在真实 UIKit 中同时让 `UIView.alpha=0`，导致原生命中目标失效。改为保存原 mask 并安装透明组合遮罩，保留原生 alpha、交互属性及手势。恢复以插件 mask 的对象身份为条件，避免覆盖原生后来安装的新 mask。
- 原替换时间写死为一种格式。现在从微信 `isNeedShowTimeInDetail` 读取模式，在原生 `toggleTimeShowMode:(double)` 执行后重投影当前页面的时间显示；星期由各自替换日期计算。原生切换只对现有时间模型调用 `resetLayoutCache` 与 `updateLayouts`，没有重建模型；页面内存中的日期记录可保留。替换时间标签的点击区域随显示宽度调整，恢复时还原。
- 真实 UIKit 回归另发现，保留控制器切换聊天时失效操作产生的 `needsNativeReload` 没有传递到新会话。调整读取时序，使原生表格缓存行高随旧临时会话失效而恢复。

原消息对象、原系统时间、图片文件、数据库及真实支付信息均不写入；离开会话或关闭对应功能后恢复。生产修改相对已交付快照见 [patch](production-changes-from-2.3-5.patch)。

## 验证结果

| 检查 | 通过数量 |
| --- | ---: |
| 偏好与备份 | 249 |
| 菜单适配 | 302 |
| 页面内存会话 | 120 |
| 布局、日期、金额规则 | 116 |
| 真实 Mac Catalyst UIKit 展示 | 328 |
| 小丑功能合计 | 1115 |
| 既有消息手势／生命周期 | 369 |
| 既有消息时间 | 142 |
| 既有消息动作执行 | 2578 |

最终 [328 项展示日志](tests/final-presentation-green.log) 包含两条已编辑时间的整页联动，以及 8 种金额标题从生产菜单、target action、UIAlertController 输入、替换显示到退出恢复的完整流程。原始时间值、正文与币种前后缀均校验保留。先前首轮 319 项日志也保留，随后增加了第二个时间节点的联动验证。

旧 2.3-5 快照的两组反向检查均编译成功并以预期断言失败：纯金额没有生成菜单、编辑时间将原生 alpha 变为零。复现脚本和完整命令见 [tests 说明](tests/README.md)。所有偏好测试使用隔离域，没有访问真实用户相册或微信数据。

视图、layer、hitTest、测量、表格缓存与 UIAlertController 使用真实 Mac Catalyst UIKit。微信私有类、模态呈现与相册服务边界使用替身；时间检查在真实 hitTest 后调用原生回调替身，没有注入真实触摸事件。微信 8.0.80 原生接口证据位于 [native](native/README.md)。这些结果不代表已在 iPhone 微信复验。

另追踪 `operationMenuItems` 之后的原生去重、过滤和 `SessionMenuAdjuester`：普通会话没有针对未知 menuType 或转账的通用白名单，插件金额项的 `0x43534303` 不在已知移除或重排类型中。原生的受限消息策略仍可能限制菜单，保持原生执行；328 项主机展示检查未执行这个原生最终链，以上结论来自精确方法的静态反汇编。

## 构建与交付

在原 checkout 的独立临时快照中并行完成 Rootless 和 Rootful 的 `make package`，两个构建均成功，均含 arm64／arm64e。核对包版本、架构、PhotosUI 依赖、新时间模式刷新导出符号、dSYM UUID 与 SHA-256。构建前后生产输入一致；最终 checkout 与构建清单相同。既有弃用 API 和链接器 warning 保留，没有本轮新增编译错误。

交付目录为 [packages/2.3-6-clown-menu-time-fix](../../../packages/2.3-6-clown-menu-time-fix/)，包含两种 deb、重签用 dylib、调试符号与 SHA256SUMS。原 2.3-5 的五个交付文件保留并核对原 SHA-256。本轮没有安装到设备，没有切换运行环境或修改账号／聊天数据。

- [构建结果](build-result.json)
- [生产输入清单](production-inputs.json)
- [验证汇总](verification-summary.json)
- [Rootless 构建日志](rootless-build.log)
- [Rootful 构建日志](rootful-build.log)
