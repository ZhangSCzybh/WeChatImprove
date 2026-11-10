# 2.3-9：向上查看历史消息时的滚动回退

用户确认 2.3-8 的连续消息间距正常，随后提供约 3.25 秒的新录屏，反馈向上查看历史消息时会短暂回退，再继续滚动。本轮在原 checkout 上修复、聚焦合并与气泡核心回归并打包，没有安装到手机。

## 现象与原因

根据用户提供的录屏，用 ffmpeg 提取并目视检查了全片缩略图和 1.4–2.0 秒局部帧。录屏和抽帧图片保留在本地审计目录，不随代码提交。约 1.75–1.80 秒，同一时间分隔、头像及相邻气泡整体向上回退，随后重新向下移动；这些帧没有显示对应的连续消息接缝重新变宽。时间为抽帧近似位置，没有将图像像素换算为设备 pt。录屏本身不能证明具体回调执行时刻。

微信 8.0.80 的原生实现提供了可复现这一回退的明确原因：`onLoadMoreMessage` 保存旧总高和旧 offset，补入历史节点后以 `旧 offset + 新总高 − 旧总高` 补位。但其 `getCurContentSizeHeight` 累加的是模型原生 `sectionHeight`；紧密合并的显示高度是在 table delegate 返回时才计算。历史批次加入后，两种高度的增量不同，导致补位过量。新增历史还可能改变原首条消息的合并与昵称决策，因此只扣掉新增行的固定间距不能覆盖完整变化。

原生 `MMTableView` 已将 estimated row/header/footer height 设为 0，静态证据不支持将本次回退归因于估高切换。完整方法编码、地址、反汇编和边界说明见 [原生证据](native-validation/FINDINGS.md)。

## 修复

- 用完整 `onLoadMoreMessage` 事务包住加载、reload 和最终原生位置补偿，避免 finished-loading 回调提前触发行高刷新；`flush` 同时检查原生 `isReloadingData`。
- 只在启用、范围匹配、紧密模式、支持的微信版本及历史事务内，把 `getCurContentSizeHeight` 投影到实际 table delegate 的显示高度。复用现有合并与小丑显示行高组合，包含未显示的新历史节点和原首条的合并变化。
- 测量前先保存所有原生 section 基线，保留原生 header 等贡献。原生每 section 截断一次，扣除量严格使用 `floor(nativeSection)`；显示高度保留小数累计到最终 unsigned 返回。
- 对异常签名、异常高度、列表变化、重入等情况返回原生总高；事务外、正常间距及关闭状态直接旁通。

本轮不写入紧密高度到原生模型缓存，不新增 contentOffset 写入。新增扫描只发生在历史加载的总高查询，复杂度为 O(消息行数)，没有新增逐帧滚动扫描或轮询。2.3-8 的昵称、头像、间距与首次布局几何代码未改动。

## 核心回归

冻结 2.3-8 的适配器，使用显式兼容 shim 维持旧版原生高度行为；编译成功后能复现两项语义失败：

| 检查 | 2.3-8 冻结基线 | 修复后 |
| --- | --- | --- |
| 历史批次锚点 | 原生增量 246pt、显示增量 156pt，锚点回退 90pt | 同一消息屏幕位置保留用户滚动位移 |
| reload 中刷新 | 额外 1 次行事务、1 次 offset 写入 | reload 中没有额外事务或 offset 写入 |

以上数值来自合成测试，并非录屏测量。最终回归与打包使用同一生产适配器 SHA-256：`a34431f37af16f7e6e2892b122074bd954d3ab617ab302271ec31e5d8f82fc9e`。

- 合并策略：235,148 项通过。
- 原生适配与生命周期：41,190 项通过。
- 气泡联合布局：2,880 组合、1,392,136 项检查通过。

历史专项覆盖紧密、紧密加外层显示高度、正常及关闭配置，在拖动、惯性、静止状态下连续补入三批历史；覆盖 sender 边界、旧首条变为中间条、原生缓存不污染、header 保留、嵌套事务、重入与事务外旁通。小数高度用例验证 unsigned ABI 引起的锚点残差不足 1pt。联合布局覆盖昵称、双方首缝、媒体、后到元数据和回退布局。详细数据来源与最终 SHA 绑定见 [回归来源](tests/history-regression-provenance.json)、[核心日志](tests/final-merge.log) 和 [联合日志](tests/final-integration.log)。

## 构建与交付

使用当前生产源码的临时快照，在隔离的对象、staging 和 package 路径并行构建 Rootless、Rootful，没有执行 `make clean`。两种包均为 2.3-9，含 arm64 / arm64e，核对了新增历史修复符号、依赖与 dSYM UUID。构建有项目既有的 API 弃用和链接器选项警告，没有构建错误。构建前后的生产文件及历史安装包保持一致。

- [Rootless 安装包](../../../packages/2.3-9-merge-history-scroll/com.wechat.improve_2.3-9_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.3-9-merge-history-scroll/com.wechat.improve_2.3-9_iphoneos-arm.deb)
- [重签用 dylib](../../../packages/2.3-9-merge-history-scroll/WeChatImprove.dylib)
- [调试符号](../../../packages/2.3-9-merge-history-scroll/com.wechat.improve_2.3-9_symbols.zip)
- [SHA-256 校验](../../../packages/2.3-9-merge-history-scroll/SHA256SUMS)

[构建结果](build-result.json)、[生产输入清单](production-inputs.json) 和 [最终核对](final-verification.json) 留作追溯。旧版本安装包保留。

未启动或切换服务，未修改聊天数据库或账号数据，未安装插件到手机。主机回归、原生静态证据和构建检查不能替代 iPhone 微信对触摸动量、滚动限位及多批历史加载的实际验收。真机重点复验：保持当前正常间距配置，连续上滚触发多次历史加载，观察同一条消息是否仍短暂反向移动，并确认停滚后保持稳定。
