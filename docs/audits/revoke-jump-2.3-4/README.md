# 2.3-4：微信 8.0.80 防撤回蓝字点击兼容修复

用户反馈：防撤回提示中的蓝色原文无法点击定位，原消息也没有高亮。本次只处理这条交互链，并按用户要求聚焦核心回归、打包 2.3-4。

## 改动

此前点击仅依赖微信 `SystemMessageCellView` 的链接回调。本版在该 cell 完成原生布局后，为含有效防撤回引用的提示绑定独立 tap 手势，直接通过当前 `RichTextView.arrStyles` 的原生命中方法识别触点所在蓝字。这个入口不依赖原生链接回调是否送达。

只在防撤回开启且实际命中本插件链接时接管；普通文字、普通链接与提示周围空白继续交给微信。手势开始与结束均核对当前引用、model、账号、窗口、滚动状态和实时开关。普通消息不新增手势；复用成普通消息时禁用已有手势。同一次触摸完成后清空待处理状态，并在成功识别时取消底层富文本触摸，避免一次点击重复提交。

新入口调用已有 `CSMessageHandleRevokeLink`，继续执行当前页面、账号、会话、server/local ID 和原消息存在性校验。原文定位、等待布局与显示帧稳定、调用微信原生高亮的实现未改动；既有提示持久化格式和新撤回拦截规则也未改动。

生产改动：新增 `Controllers/CSRevokeTapAdapter.h/.m`，在 `Hooks/RevokeHooks.xm` 增加 System cell 布局后的绑定；同步版本号和本版更新说明。其他已在工作树中的 2.3-3 修复继续包含在安装包中。

## 定点核验与核心回归

微信 8.0.80.34 指定主程序的静态核验确认：RichTextView 继承 UIView；`getRichTextView`、`arrStyles` 和 `+targetLinkStyleFromStyles:withPoint:` 支持本次使用的对象、CGPoint 与返回值约定。直接复用原生样式命中，避免自行推算蓝字范围。证据见 [native-hit-test.md](native-hit-test.md)。

| 检查 | 结果 | 范围 |
| --- | --- | --- |
| `Tests/verify-revoke-tap.sh` | 61 通过，0 失败 | 原生链接回调缺席时的独立点击入口；精确蓝字、普通链接放行、重复绑定/动作、复用、正文变化、账号/开关变化、离屏、拖动与取消 |
| `Tests/verify-revoke-reference.sh` | 84 通过，0 失败 | 持久化提示引用与撤回事件解析 |
| `Tests/verify-revoke-interception.sh` | 73 通过，0 失败 | 既有生产撤回拦截及原生服务替身 |
| `Tests/verify-message-merge.sh` | 235148 + 17566 通过，0 失败 | 原文定位、布局稳定后原生高亮、消息布局与导航生命周期 |

测试日志位于本目录 `tap.log`、`verify-revoke-*.log` 和 `verify-message-merge.log`；既有核心脚本的命令、哈希与输出见 `core-results.json`。新手势测试使用进程内 volatile defaults，不写用户设置。未重跑无关功能的全量历史脚本，也未将以往失败算作本版通过。独立代码复核后补齐了实时总开关检查，并保持关闭功能时的原有行为。

## 安装产物

版本：`2.3-4`；Rootless 与 Rootful 均包含 `arm64` / `arm64e`。在临时源码快照内构建，未运行仓库的 `make clean`，未改动主工作树 `.theos` 或旧安装包。构建前后验证源码一致、历史包哈希不变，并从 deb 解包核对包版本、架构、导航与新点击入口符号，以及各架构 dSYM UUID。

- [Rootless deb](../../../packages/2.3-4-revoke-jump/com.wechat.improve_2.3-4_iphoneos-arm64.deb)
- [Rootful deb](../../../packages/2.3-4-revoke-jump/com.wechat.improve_2.3-4_iphoneos-arm.deb)
- [重签 IPA 用 dylib](../../../packages/2.3-4-revoke-jump/WeChatImprove.dylib)
- [调试符号](../../../packages/2.3-4-revoke-jump/com.wechat.improve_2.3-4_symbols.zip)
- [SHA256SUMS](../../../packages/2.3-4-revoke-jump/SHA256SUMS)

构建命令与产物验证见 `build.py`、`build-commands.json`、`build-result.json`。Rootful 提取的 dylib 原样作为重签产物提供；两种 deb、dylib 和符号包的 SHA-256 已复核。

## 验证边界

录屏确认点击后没有可见定位或高亮响应，但本次未对手机进行运行时附加，未证明用户手机上原有链接回调具体中断在哪一层。本版提供独立点击入口以覆盖该情况，不将已被历史审计否定的 HTTP 前缀或其他插件假设列作根因。

新增点击测试与既有导航测试均为主机替身测试。微信 8.0.80 真机上的完整点击、真实滚动/长按竞争及原生高亮观感仍待使用 2.3-4 复验。本次没有安装或重启手机微信，也没有切换账号、配置或聊天数据源。
