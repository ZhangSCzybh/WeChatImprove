# 1.8-29 合并消息间距与快速滑动闪退修复

本次在既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 上，以用户确认回退后的 1.8-27 为基线，修复标准短文本首条间距、引用消息前后间距和所附主线程布局崩溃。发布版本 1.8-29，Rootless，arm64 / arm64e，最低编译目标 iOS 15.0。没有安装到手机，没有启动或切换服务、数据库、账号或工作区。

## 崩溃证据与修复

输入为 `docs/audits/inbound/WeChat-2026-10-20-090621.ips`，WeChat 8.0.78（8.0.78.34），iPhone15,3，iPhone OS 27.0.1。使用 reverse-engineer-anything 工作流，对已存在的本地微信二进制执行只读元数据与有限范围反汇编，并使用 1.8-27 dSYM 符号化；没有执行目标应用或修改微信二进制。

- 日志主程序 UUID `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE` 与本地微信 arm64 二进制一致。
- 日志插件 UUID `5521B98A-DD8E-3488-8121-CAF4A9B06BEE` 与 1.8-27 arm64e dSYM 一致。
- 插件栈还原为 `CSMessageCellPerformLayout → CommonMessageCellView layoutSubviews hook → CSBubbleStyleApply → CSDecodedImage → CSMessageNativeObject`。其中 `CSDecodedImage` 位于旧版 `CSBubbleStyleAdapter.m:107`。
- 微信栈顶为 `-[YYImage originImage]`，未重定位地址 `0x10a9bdb88` 的指令是 `ldr x8, [x0, #0x10]`。日志 x0=0、FAR=16，直接对应空 block 的 invoke 指针访问。
- 此 getter 先检查 `m_getBlock`，调用 `setIsDynamicImg:`，再重新读取并调用该 block，中间没有再次判空。日志证明崩溃时该 block 已为空；没有证据把具体清空时序进一步断言为某个线程竞争或某个回调。

修复集中在 `CSDecodedImage`：针对 YYImage，通过运行时 ivar 名称和对象类型读取 `m_originImage`、`_decodeImageLM`、`_decodeImageDM` 已发布的图片；不调用其 `originImage`、解码 getter 或 `CGImage`，嵌套 YYImage 也不递归触发解码。普通 UIImage 仍按原路径检查。未完成解码、未知存储契约或无有效图片时保留原图，等待现有 `CSBubbleStyleImageDecoded` 回调。背景样式和透明边距测量共用此安全入口。没有加入同步解码、等待、定时器或全表扫描。

证据：`crash-symbolication.json`、`native/metadata.json`、`native/YYImage--originImage.asm`。Ivar 的运行时偏移与磁盘元数据偏移会因 superclass 布局调整而不同；生产修复没有使用任何硬编码 ivar 偏移。

## 间距修复

1. 8.0.78 既有短文本布局记录/回归使用 38pt 正文与普通头像，旧首轮预设仍按 44pt 头像占位，导致身份所在短消息多留 6pt。将该明确版本范围的标准头像预算校准为 38pt，保留实际子视图边界检查；较大头像仍扩展空间。既有标定来源见 `docs/audits/merge-stability-1.8-24/README.md`，这不是新增真机测量，也不代表消除了所有版本几何预设。
2. 群聊发送方明确不占接收方昵称位置，首轮与尺寸失效判断均按收发方向判断昵称占用。
3. 旧实现把所有 type=49 / 引用消息都作为附加内容跳过压缩。本次仅放行明确 `TextMessageViewModel`、type=49 且 subtype=57 / isReferMsgType 的引用文本；其他 app 消息继续保留原生空间。
4. 同 UUID 微信反汇编证实 `TextMessageViewModel.contentHeight / contentViewSize` 只有正文与其内部内容；`CommonMessageViewModel measure:` 另外增加引用框占用：`4pt + replyTextSize.height + replyTextInset.top + replyTextInset.bottom`。`CommonMessageCellView layoutInternal` 将独立引用框放在正文下方 4pt，`initMsgReplyView` 按引用文本尺寸与 inset 设置其完整大小。按此契约读取真实引用指标，只缩短整条消息前后空隙，保留正文与引用框的原生内部间距。
5. 引用指标缺失、尺寸无效、宽度越界、分段长文本、翻译、AI 附加内容、公共尾部内容、头像下时间等继续按保护逻辑保留空间。

用户本次写“2px”，在询问物理像素 / 既有 2pt 且未收到新答复后，按字面采用 **2 个屏幕物理像素**：每个内部接缝上下各留 1/displayScale pt，并处理浮点误差避免 3× 取整多出 1px。3× 标准布局目标为 2/3pt。设置提示和更新说明同步单位。若接收方群昵称原生已贴行顶，不新增昵称留白；额外头像、昵称或其他真实内容会优先保留所需空间。因此不是对所有插件、字号和未知版本的无条件 2px 承诺。

保留 1.8-27 的现有缓存、历史失效和实测边界处理。本次没有恢复之前撤销的整套 1.8-28 滚动稳定性改造，也不宣称解决任意透明素材或未知布局下的所有间距跳动。

## 回归

先加入会拒绝延迟 getter 的 YYImage 替身，旧实现触发 `UnsafeLazyDecode` 异常退出（`bubble-before.log`）。该测试确定性验证不安全入口，未模拟真实系统 SIGSEGV 时序。新增接缝回归同样在旧实现上失败（`merge-before.log`）。

最终全部 **31 个 `Tests/verify-*.sh` 入口通过**，4 个独立进程并行，见 `regression-results.json` 与 `regression/`。核心结果：

| 入口 | 策略 / 数学 / 渲染检查 | 适配 / 生命周期检查 |
| --- | ---: | ---: |
| verify-message-merge.sh | 145,544 | 16,979 |
| verify-bubble-style.sh | 36,979 | 2,321 |

新增检查覆盖 1× / 2× / 3×、私聊与群聊、收发双方、首条/末条头像、四条短消息、引用在首/中/末条、两种引用高度、重复渲染、拖动/减速/停止、引用高度独立增长、引用数据无效和不支持的 app 消息。检查可见接缝、正文和引用不出界、原生正文尺寸不被改写、标准布局不触发停滑高度更新。崩溃入口覆盖未就绪/已就绪图片、普通/高亮、浅深色缓存、嵌套 YYImage，以及 600 次图片复用与解码回调循环。既有字体颜色、通话记录、相邻样式更新与恢复回归继续通过。

这些是 macOS + UIKit 替身测试、静态二进制分析和交叉编译，没有进行真机 UIKit 滚动、截图像素或帧率验收。

## 构建与保留验证

执行独立输出目录下的 `make -j4 package SCHEME=rootless`，没有 `make clean`。构建成功，用时 9.79 秒；仅存在授权/红包模块原有 API 弃用和链接器警告，本次修改模块无新增编译警告。

- 包内版本、插件版本常量与更新说明均为 1.8-29。
- 包内动态库、staging 动态库和构建动态库 SHA-256 一致；arm64 / arm64e 均包含，minos 均为 15.0。
- 两个架构的 dSYM UUID 与交付动态库一致；测试符号未导出，注入过滤配置相同。
- 全部 342 项发布源码与构建清单一致。
- 对任务开始时 44,445 个文件逐项比较，仅变更 `verification.json` 所列 13 个源码/测试/版本说明文件。
- 1,063 个既有包、符号、审计和输入文件逐项哈希一致，包括 **1.8-28 deb、dSYM 和所有既有分析记录**。
- 版本源码差异保存在 `source-changes.patch`；原源码备份位置见 `work-path.txt` 所指目录的 `baseline/`。

| 产物 | 字节 | SHA-256 |
| --- | ---: | --- |
| `packages/com.wechat.improve_1.8-29_iphoneos-arm64.deb` | 827,970 | `df6dc43d9d460f2295f893b7b97ca3503d31c760e6214bfd1a959a3e3d203403` |
| `packages/WeChatImprove-1.8-29-dSYMs.zip` | 3,488,170 | `e61dd5bd687ecadabc8096f0380bd0241d77b9a2c120101af49c968f8c45bd87` |

## 真机验收范围

安装 1.8-29 后完全退出并重新打开微信，保持原账号、聊天、字号和气泡设置。开启合并消息与紧密模式，重点查看私聊收发与群聊发送方连续四条短文本，并将一条引用消息分别放在首条、中间和末条；随后快速上下滑动历史，让惯性停止，检查闪退和间距。再确认长按高亮、浅深色切换和字体颜色仍正常。大头像、接收方群昵称、翻译和头像下时间以不重叠、不裁切为约束。
