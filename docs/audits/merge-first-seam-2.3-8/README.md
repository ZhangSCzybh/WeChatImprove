# 2.3-8：修正连续消息的首个接缝

2026-11-09，基于用户正在使用的微信 8.0.80 / 插件 2.3-7 工作区修正首条与第二条间距。用户已确认 2.3-7 的停滚重排恢复正常；本轮保留该布局时序，修正首条消息的两处占位误判。没有安装到 iPhone、重启微信或操作账号与聊天数据库。

## 截图与两处原因

用户新截图 `IMG_7638.PNG` 为 1290×2796，按 3× 换算，两组接收方三条文本的接缝均为 13pt / 2pt，发送方为 5pt / 2pt。可见头像与短文本气泡高度均为 37pt。原图散列、坐标与测量方法见 [image-measurements.json](image-measurements.json)；收发方标注截图保留在本地，不随代码提交。截图中的版本文字属于历史聊天内容，不作为当前安装版本的依据。

1. 普通群昵称的 `chatRoomTextStateIconDescription` 返回空 NSString，且该对象非 nil。2.3-7 只判断对象是否存在，因此将普通的无状态昵称误当作附加状态，首次即冻结整条原生行高；后续消息不进入有昵称的分支，造成首缝特有的额外留白。现在将空字符串视为没有状态，非空字符串与未知描述对象继续使用保守回退。
2. 原生 `MMHeadImageView` 外层比内层图像宽高各多 6pt，图像居中；截图对应可见 37pt、外层 43pt，上下各有 3pt 不可见占位。旧逻辑把整个外层当作头像大小，超过普通头像的 38pt 资格上限，并把下方 3pt 留白计入首缝，所以发送方首缝成为 5pt。现在只对核验过的原生层级读取 `headImageView` / `imageSize` 并计算可见边界，保留真实超大头像、可见边框、未知层级与异常变换的完整安全占位。

两处原因均有提供的微信 8.0.80 arm64 可执行文件静态证据，方法签名、ivar、地址与注释汇编见 [native-validation/FINDINGS.md](native-validation/FINDINGS.md) 及同目录文件。接收方截图多出的 11pt 是该设备画面的观察值；空状态判断证明了回退触发原因，没有把 11pt 写成固定扣减值，也不将其描述为所有主题、字体的通用常量。

## 首次布局与安全边界

原生 `setImageSize:` 先记录尺寸，内层图像的 frame 由之后的子视图 `layoutSubviews` 才居中设置。父消息视图先于头像子视图进入首轮 Render 时，内层 frame 可能为空或保留旧尺寸。如果首轮因此回退使用 43pt 外层，会把额外 3pt 永久写入只扩不缩的安全包络。

本轮按照已验证的原生居中规则，用有效的 `imageSize` 和外层 bounds 在父视图首次布局时确定同一份可见矩形；不等待子视图完成，也不强制触发子视图布局。普通边框原生默认隐藏；真实可见且有图片的边框继续保留其占位。滚动 flush 与 2.3-7 逐字一致；停滚保护、首次确定高度与位移、只扩不缩的越界保护继续保留。

## 回归与反向验证

测试加入独立的原生坐标 fixture：主题上边距 5pt、昵称长度 15pt，无昵称正文 y=8pt，有昵称首条正文 y=20pt，头像外层 y=5pt / 43pt、内图 (3,3) / 37pt，正文高 37pt。普通昵称明确返回空字符串；分别覆盖内图初始 frame 已就绪、空 frame、旧尺寸 frame。重复拖动、减速、停止和后续子视图布局时，要求首缝与其余接缝均为 2pt，行高与位移不再晚变。原有真实状态与 60/74pt 大头像回退用例继续通过；可见边框的保守分支经过原生证据和代码审查，未在本轮增加该分支的独立动态用例。

固定 2.3-7 Adapter 的红例使用最终 fixture 复跑：发送方复现 5pt 首缝。接收方空状态红例使用 **90pt 合成原生行高**，因冻结完整行高而得到 **34pt** 接缝；此例证明空字符串触发错误回退，**不等同于复现截图中的 13pt**，也不声称 90pt 是截图真实外层行高。红例旧代码、结果、fixture 与 Adapter 散列见 [tests/native-avatar-red-result.json](tests/native-avatar-red-result.json)、对应 red 日志和 [tests/final-fixture-sha256.json](tests/final-fixture-sha256.json)。

最终生产 Adapter SHA-256 为 `e08e5bfb81a6102fe2069b918dcc785e6b750020975e37035185ce4b8e7352d6`，最终测试输入与打包输入一致，结果如下：

| 验证 | 通过结果 | 证据 |
| --- | --- | --- |
| 消息合并 / 导航策略 | 235,148 项 | [final-merge.log](tests/final-merge.log) |
| 原生适配 / 导航生命周期（UIKit 替身） | 37,136 项 | [final-merge.log](tests/final-merge.log) |
| Merge + Bubble 联合布局 | 2,880 组接缝组合、1,392,136 项检查；四种媒体、晚到元数据与主题、安全回退，停滚不晚缩、无无效行高事务 | [final-integration.log](tests/final-integration.log) |
| 气泡策略 / 渲染 / 图像所有权 | 36,979 项 | [bubble-core.log](bubble-core.log) |
| 气泡适配生命周期 | 2,555 项 | [bubble-core.log](bubble-core.log) |

最终检查摘要与日志散列见 [final-verification.json](final-verification.json)。主机 UIKit / 微信类替身与原生静态证据验证了受控协议和几何，不能代替 iPhone 安装后的实际显示与滚动验收。

## 构建与交付

[build.py](build.py) 将当前工作区生产输入复制到临时快照，使用 Theos 与 Xcode iPhoneOS 27.2 SDK；Rootless / Rootful 使用独立对象、staging 与 package 目录，没有执行 `make clean`。Rootless 构建退出 0，用时 21.79 秒；Rootful 构建退出 0，用时 21.80 秒。两种包均已核对版本、deb 方案架构、arm64 / arm64e dylib 架构、导出符号和 dSYM UUID。

交付位于 `packages/2.3-8-merge-first-seam/`：

- [Rootless 安装包](../../../packages/2.3-8-merge-first-seam/com.wechat.improve_2.3-8_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.3-8-merge-first-seam/com.wechat.improve_2.3-8_iphoneos-arm.deb)
- [Rootful 重签用双架构 dylib](../../../packages/2.3-8-merge-first-seam/WeChatImprove.dylib)
- [两种方案与架构的符号 ZIP](../../../packages/2.3-8-merge-first-seam/com.wechat.improve_2.3-8_symbols.zip)
- [SHA256SUMS](../../../packages/2.3-8-merge-first-seam/SHA256SUMS)

[build-result.json](build-result.json) 记录实际命令、耗时、元数据、产物散列与 UUID；[production-inputs.json](production-inputs.json) 记录构建输入。构建期间生产源码未变，当前源码与构建 manifest 一致，新产物散列及旧 2.3-7 的四项产物散列均已核对。旧包与本轮开始前的既有工作区改动保留，未提交 Git。

本轮 [baseline/manifest.json](baseline/manifest.json) 保存 18:33 的七个指定源码 / 文档散列及副本，并保留 HEAD、Git status 与当时的已跟踪工作区差异。只保存本轮需要的文件，没有复制全部历史 docs / packages。

## 待 iPhone 复验

本轮尚未安装到手机。微信 8.0.80 中分别检查显示群昵称与隐藏昵称、收发双方首条保留头像的连续短文本和语音，要求首缝与后缝均保持 2pt；慢拖、快速滑动与惯性停止后继续稳定。真实昵称状态、头像边框、较大头像及语音转写仍应完整显示，不应为追求紧密间距发生裁切。
