# 1.8-31 自定义气泡延迟解码修复

## 问题与原因

用户反馈 1.8-30 自定义气泡不显示。比较交付基线可知，1.8-29 与 1.8-30 的气泡 adapter 相同，回归与 1.8-29 防闪退改动后的图片就绪处理有关，并非 2pt 单位改动。

确认的源码缺陷：

1. 原先的失败缓存只比较 YYImage 包装对象地址。同一对象在原位完成解码后仍命中失败缓存。
2. 监听的 `didSetDynamicYYImage` 用于注册深色模式监听，不是解码完成事件；首次 native 解码时它可以早于像素发布。
3. 原先要求普通图和按压图同时就绪。微信显示普通态时通常只解码普通图，因此未按压时样式一直被阻塞。

这三点由微信 8.0.78 静态证据和主机回归交叉验证；未声称直接观察到用户设备本次运行过程。

## 原生证据

只读分析沿用已选定的 `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`，UUID `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE`，对应用户提供的 WeChat 8.0.78.34 崩溃版本。`native/` 中保留元数据、提取脚本及有界反汇编；这些是本地静态分析原始证据，不是运行时抓取或伪造的 REA Evidence ID。

- `+[YYImage imageWithUIImage:]`，`0x10a9bd4a4`：将 UIImage 捕获在 block 中，调用 `initWithBlock:prefertSize:`，不会预先发布普通 UIImage。
- `-[YYImage setIsDynamicImg:]`，`0x10a9bd7fc`：向 delegate 调用 `didSetDynamicYYImage`。
- `-[YYAsyncImageView didSetDynamicYYImage]`，`0x10a9bbdf8`：检查 `didSetDarkModeObserver`、调用 `addDarkModeObserver:`，不是 decode completion。
- `-[YYAsyncImageView newAsyncDisplayTask]`，`0x10a9bba50`：构造 task 的 `displayContentsForLayer` block，block 入口 `0x10a9bbba4`。
- 上述 block 的描述符签名是 `@"UIImage"32@?0{CGSize=dd}8@?<B@?>24`，即 `UIImage *(CGSize, BOOL (^)(void))`。它优先解码当前按压图，未按压时只解码普通图，必要时才读取默认图。
- `-[YYImage decodeImage]`，`0x10a9bdc18`：发布当前模式的 decodeImageLM/DM 后返回，允许在 native block 返回后安全安排主线程刷新。

先前 `originImage` 在 `0x10a9bdb88` 的 nil block + 0x10 访问证据继续保留于 `../merge-spacing-crash-1.8-29/`。本次没有重新从布局主动调用 `originImage`、`image`、`decodeImage` 或 wrapper 的 `CGImage`。

## 实现

- 缓存同时比较普通/按压已解码图片身份，保留引用防止地址复用。就绪变化会重试，稳定状态不重复扫描像素或改写背景。
- 普通态可独立应用样式；暂不可用的按压态保持原生，实际显示并解码后再应用对应样式。
- 将错误的动态图片通知 hook 改为观察 `newAsyncDisplayTask` 的真实显示 block。仅处理关联到受支持消息的背景，验证 task 类和 getter/setter 类型，原 block 只调用一次，原返回值及参数透传。
- 后台 block 不读写 UIKit 或 binding；主线程回调校验 cell、model、background、binding 和原生图片对，取消、复用或图片替换后的过期任务不更新消息。
- 插件生成模板在包装为 YYImage 时保留已知 UIImage，透明边距测量不必等待包装对象再次解码。
- 未修改合并布局源码；2pt 逻辑间距、引用消息占用、群聊发送方处理与既有防闪退策略保留。

## 回归与交付

`regression-before.log` 保留修复前失败：同一 wrapper 的 pixels 就绪后再次布局仍未应用气泡。测试新增真实 display-task ABI 的主机替身与延迟工厂，分别覆盖普通态先于按压态、无额外布局的后台/主线程完成、任务取消、解绑、功能关闭、model 替换、native 图片替换、非消息视图、插件生成 wrapper 尚未解码时的边距，以及缓存稳定性。原有懒 getter 触发异常测试继续防止重新引入主动解码。

全部回归结果见 `regression-results.json` 和 `regression/`；构建命令、日志、包元数据、双架构符号匹配、文件校验及旧产物保留见 `build-command.json`、`build.log`、`verification.json`。只使用原 checkout 编译；中间目录隔离在 `work-path.txt` 指向的临时目录，未执行 make clean。

范围限制：主机测试使用 UIKit 替身及 CoreGraphics 渲染验证；没有 iPhone 进程内渲染、滚动手势、原生显示队列顺序或多插件组合的实测结果。本包需在目标微信验证普通/引用/语音/通话、收发浅深色、长按与快速滚动。首次图片仍需由微信原生解码完成才应用，当前策略不主动强制解码。

## 本次结果

- 全部 31 个回归脚本通过。气泡策略/渲染/所有权 36,979 项、实际 adapter 主机生命周期 2,490 项；合并策略 235,148 项、合并 adapter 16,979 项。
- Rootless arm64 / arm64e 编译打包成功，最低编译目标 iOS 15.0；包内 dylib 与构建/暂存产物一致，两架构 dSYM UUID 匹配。
- 编译只出现既有授权模块 openURL 与红包模块 statusBarFrame 的废弃 API 警告，本次气泡改动无新增编译警告。
- 校验原始基线 44,574 个文件，仅修改允许的 10 个源码/测试/版本文档；1,192 个旧文档及产物文件哈希一致，未删除或覆盖旧 deb。
- 合并 adapter/policy 源码哈希与 1.8-30 相同。构建源文件清单 342 项与最终 checkout 一致。

- `packages/com.wechat.improve_1.8-31_iphoneos-arm64.deb`：826,868 bytes；SHA256 `b79db0010551e0222ad8771f309b1a1f334caaf71563a740ab4cee0cff96fd46`。
- `packages/WeChatImprove-1.8-31-dSYMs.zip`：3,493,676 bytes；SHA256 `b5fe5e16148e7a4fb1c9cf17ca3be51c00f7c45fd59f50c2202856b6086498b0`。
