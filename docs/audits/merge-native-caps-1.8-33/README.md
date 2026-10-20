# 1.8-33 紧密合并间距偏大修复

用户反馈：1.8-32 中合并的角形和头像已生效，但单行文本、短语音及引用消息前后的间距仍明显偏大。输入截图为 `/Users/zhangshichao/Downloads/IMG_7443.PNG`，文件哈希及引用的原生分析证据见 `evidence-references.json`。目标仍为标准组内接缝 **2pt 逻辑点**，保持查看历史消息时的稳定布局。

## 原因与证据

1.8-32 的模型边距资格检查要求目标高度不小于 `capInsets.top + capInsets.bottom + 1 / image.scale`。微信 8.0.78 的标准气泡固定区域为上 30pt、下 8pt，合计 38pt；38pt 的短消息因此在首次行高测量时被拒绝。随后 `CSNativeProfile` 走稳定原生回退，导致自定义样式和合并决策正常，间距却没有压缩。视图边距接口中也存在同样的额外像素要求。

原生证据复用此前只读分析，未重新扫描或执行微信二进制：

- [BubbleManager 反汇编](../merge-layout-1.8-32/native/BubbleManager--bubbleInfoWithType_position_style_isSender_.asm)：`0x104aef088` 起的四个浮点参数为 `30, 25, 8, 20`，传给 `setEdgeInsets:`。
- [BubbleInfo 反汇编](../merge-layout-1.8-32/native/BubbleInfo--getBubbleImage_isDarkMode_useCache_.asm)：`0x104aeddd0` 读取 `edgeInsets`，`0x104aeddDC` 起交给 `resizableImageWithCapInsets:resizingMode:`。
- 已选定原生目标：微信 8.0.78 build 8.0.78.34；SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`；UUID `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE`。

原有联合测试使用较小的合成 capInsets，没有覆盖原生 30/8 固定区域与 38pt 高度相等的边界。本次先补入该边界，生产代码尚未修改时，联合回归明确失败于 `CSBubbleStyleModelInsets`，见 `reproduction-before-fix.log`。

## 修复范围

生产行为仅改动 `Controllers/CSBubbleStyleAdapter.m` 中两处尺寸资格判断：目标高度、宽度允许恰好等于固定区域之和。源模板需有可伸缩区域，但目标图形可以把中心缩到零，固定边缘仍完整保留；不应要求目标另外容纳一个物理像素。严格小于固定区域的尺寸仍然拒绝。

合并适配器、布局策略、图片解码观察与钩子均未修改。继续使用首次确定的行高和位移；停止滚动、图片就绪、按压态就绪、无变化缓存通知不会二次收紧。间距常量仍为 2pt，不作屏幕倍率折算。引用框自身与正文之间的原生布局继续保留。

没有新增定时器、轮询、像素扫描、模板请求、视图遍历或表格刷新；沿用原有有界图片缓存。`YYImage.originImage` 等危险延迟解码 getter 仍不会被调用。

## 回归

`Tests/MergeBubbleIntegrationTests.m` 编译实际气泡与合并模块，以 UIKit/微信替身执行。新增 49pt 合成源图，固定区域使用原生 `30/25/8/20`，源尺寸确实大于固定区域。图片像素是测试合成数据，并非提取的微信原始资源。

- 目标高度 38pt、宽度 45pt 的相等边界，以及略大、略小边界；同时检查模型和视图接口，覆盖 1×/2×/3× 模板倍率。
- 普通/按压态可见范围并集、浅/深色边距和模型暂未提供宽度的情况。
- 联合矩阵从 192 组扩展到 576 组：原有小固定区域、原生固定区域文本、原生固定区域短语音混排；叠加收发方向、群聊/私聊、首末头像、引用、样式开关、明暗主题和倍率。
- 每组在创建 Cell 和图片解码之前确认首次紧密行高，随后连续验证拖动、减速、停止、延迟图片就绪、按压、无变化缓存通知。标准可见接缝为 2pt；群聊接收方末条昵称仍保留自身占用。
- 维持原有媒体类型、缺失元数据恢复、稳定回退、宽度真实变化及临时空缓存覆盖。

联合回归通过 **125,630 项断言**。完整 **32/32** 个回归入口通过，见 `regression-results.json` 和 `regression/`。测试验证无二次收紧、无多余表格更新、重复布局时模板扫描次数不增长。

这些结果验证主机上的逻辑与调用次数，不等同于 iPhone 原生 UIKit 渲染、帧率、功耗或温升测量。真实设备上仍需用用户当前微信、注入环境和配置核验截图中的文本 → 语音 → 引用混排，以及快速滑动和停止后的表现。

## 工作区与打包

以本轮开始时的 1.8-32 工作区为基线，不使用 Git HEAD 覆盖已有未提交工作。`work-path.txt` 记录 345 个构建/回归输入的基线副本目录；`baseline-sha256.json` 记录 43,841 个已有文件哈希。仅更新气泡适配器、联合测试、版本号、更新说明和项目 README，共六个源码/文档文件，具体差异见 `changes.patch`。旧 deb、dSYM、录屏、崩溃日志、分析记录均保留。

构建从原工作区执行，Theos 对象和临时包写入单独目录，未执行 `make clean`。`run-build.py` 保存构建命令、源码清单与日志；`verify-delivery.py` 核对版本、Rootless、arm64/arm64e、最低 iOS 15.0、包内/暂存/构建 dylib 一致性、dSYM UUID、注入过滤器、测试符号不进入成品、旧产物哈希和修改范围。

最终构建结果见 `build-result.json`，交付校验与 SHA256 见 `verification.json`。交付路径为 `packages/com.wechat.improve_1.8-33_iphoneos-arm64.deb` 和 `packages/WeChatImprove-1.8-33-dSYMs.zip`。本轮不安装到设备。
