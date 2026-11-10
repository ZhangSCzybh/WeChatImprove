# 2.3-7：群昵称连续消息间距与停滚布局

本轮基于用户确认的微信 8.0.80 / 插件 2.3-6 现有工作区，保留其中已完成的小丑菜单、时间显示及其他既有功能，修正消息合并首次几何计算，并打包 2.3-7。未安装到手机、未操作微信账号或聊天数据库。

## 问题与定位

用户原图 1290×2796 中前三组文本接缝均为首缝 6px、后续 15px（按 3× 换算为 2pt / 5pt）；用户确认全局隐藏昵称后间距正常。录屏约 0.683→0.700s 出现连续语音间距重排，下方内容累积下移约 45px。画面证明几何发生变化，但不能单独确定全部触发条件。

旧 `CSNativeProfile` 用 named 17 / unnamed 8 预测正文起点。既有 8.0.80 原生汇编显示：读取 `message_node_bkg_margin_top` 得到 M；头像原点为 M；无昵称正文原点为 M + (原生显示头像 ? 3 : 0)；有昵称正文起点为 ceil(M + [UIFont dynamicLength:16])。昵称分支覆盖无昵称分支，不是在 M+3 上再叠加昵称。依据见相邻历史审计 `release-2.2-15-8080-compact-and-closefriend-reset/native-validation/CommonMessageCellView-layoutInternal-annotated.asm` 的 0x101036190、0x101036260、0x10103649c、0x10103653c。

首次预测与真实内容原点不一致，会由 Render 的只扩不缩安全包络保留额外空间；拖动/减速期间 flush 暂缓，停滚后再做行高事务。故本次修正首次输入，不删除安全检查或滚动保护。

## 实现范围

- `CSMessageMergeAdapter.m`：通过签名核验读取当前 MMContext / MMThemeManager / MMThemeUtil / UIFont 的原生指标；保留昵称，统一行高、正文位移与头像保护边界。普通消息的组内目标仍为 2pt。
- 将原生正文起点、头像起点及头像状态纳入几何变化判定；主题或字体变化即使没有改变正文尺寸和原生行高，也能在行高请求边界重建同一份计划。
- 正常间距直接跳过新增主题读取。Render 不增加逐帧主题查询、轮询或调试日志。
- 缺失/非法原生指标、有未完整建模的昵称状态附加内容时，首次即保留原生行高；后到元数据不触发晚缩。保留真正越界、未知变换、较大头像、引用和转写等原有安全处理。
- `control`、显示版本与本版更新说明同步为 2.3-7；README 更新交付入口。

## 核心验证

新增测试在旧生产代码上出现语义失败，红例和旧 adapter SHA 见 `tests/red-merge.log`、`tests/red-integration.log`、`tests/baseline-adapter-sha256.json`。修复后的核心回归：

| 脚本 | 覆盖 | 结果 |
| --- | --- | --- |
| verify-message-merge.sh | 分组/导航策略、原生适配、昵称显示/隐藏、动态 M/D、缺失/非法输入与安全回退 | 通过，详见 tests/green-merge.log |
| verify-merge-bubble-integration.sh | 真实 Merge+Bubble 适配器、连续文本/语音、动态昵称位置、延迟图片、停滚零额外行高事务 | 通过，详见 tests/green-integration.log |
| verify-bubble-style.sh | 模板、渲染、图像所有权及气泡生命周期 | 36,979 + 2,555 检查通过 |
| verify-message-time.sh | 消息时间生产 Hook 生命周期 | 142 检查通过 |
| verify-message-gesture.sh | 消息手势与共同布局生命周期 | 369 检查通过 |

动态测试输入 M8/D16→M11/D18，保持同一个模型、正文大小、宽度和 native row height，要求首次计划与实际渲染接缝一致，12轮拖动/减速/停止不新增行高更新或滚动偏移。语音代表包含播放 glyph、转文字侧边按钮显隐和 YY 普通/按压解码。普通头像替身改为与原生 CSS 一致的 y=M / 38pt；专门的大头像、横向重叠及真实越界安全测试保留。

联合脚本在并行编译期间曾出现原有 NSCache 扫描次数断言失败，未放宽或删除断言；随后串行完整检查通过。主机 UIKit/微信替身验证的是受控协议与几何，不能替代 iPhone 真机显示和滚动验收。

## 编译与产物

运行 `python3 docs/audits/merge-nickname-scroll-2.3-7/build.py`，将本工作区当前完整生产输入复制到临时快照，使用 Xcode iPhoneOS 27.2 SDK / Theos，Rootless、Rootful 各自独立的对象、暂存和包目录。未执行 make clean。两方案均退出 0，均包含 arm64 / arm64e。

交付目录为 `packages/2.3-7-merge-nickname-scroll/`：

- `com.wechat.improve_2.3-7_iphoneos-arm64.deb`：Rootless。
- `com.wechat.improve_2.3-7_iphoneos-arm.deb`：Rootful。
- `WeChatImprove.dylib`：Rootful 重签注入用双架构 dylib。
- `com.wechat.improve_2.3-7_symbols.zip`：两种方案、两种架构的 dSYM。
- `SHA256SUMS`：四项产物 SHA-256。

`build-result.json` 记录 deb 元数据、双架构、dylib SHA、dSYM UUID、生产输入在构建期间未变及历史包哈希保持一致；`production-inputs.json` 记录构建源码散列；构建日志为 `rootless-build.log`、`rootful-build.log`。本轮没有提交 Git，也没有覆盖旧交付包。2.3-6 的既有未提交改动保留，开始时快照位于 baseline/，完整原有差异见 preexisting.patch。

## iPhone 复验重点

微信 8.0.80，群聊显示昵称、首条保留头像、紧密间距，接收四条连续短文本，确认三个可见气泡接缝一致且昵称完整；全局隐藏昵称后继续一致。连续语音分别慢拖、快速滑动和惯性停止，确认停稳后不再出现额外间距重排。展开真实转写或附加内容时仍应完整显示，不能裁切。以上真机工作尚未执行。
