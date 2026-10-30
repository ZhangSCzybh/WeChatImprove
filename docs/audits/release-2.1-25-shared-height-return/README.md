# 2.1-25：共享当前滚动高度及聊天返回位置

日期：2026-10-30。此目录记录最终交付版本，包含切换分组和从聊天返回两项修正。

## 最终行为

- 点击或横滑切换分组，目标组沿用切换瞬间的当前列表高度。A 在 500 时切到 B，B 也是 500；在 B 滚到 800 后切到 C 或 A，继续沿用 800。
- 从聊天会话返回列表，恢复进入前的高度。即使聊天期间会话排序、行高或微信原生 appearance 回调改变了 offset/inset，也按进入前的高度恢复。
- 高度按 `contentOffset.y + adjustedContentInset.top` 计算，目标内容不足时限制到实际可滚动范围。下一次切组继承限制后的实际高度。
- 普通同组消息刷新继续按可见会话行定位，保留原来的更新保护。用户明确回顶时仍执行回顶。

切组使用刷新前即时捕获的高度，覆盖目标组旧的行锚点。从聊天返回只在首次离页时保存一份带账号和 epoch 的内存记录，重复 disappearance 不覆盖；真实 `viewDidAppear` 在原生回调和 attach 后最终校正并清除记录。新切组或明确回顶优先，账号/epoch 不匹配使旧记录失效。没有新增定时器、轮询或位置磁盘保存。

## 核心回归

| 套件 | Checks | Failures |
| --- | ---: | ---: |
| [Viewport](regressions/group-viewport-fixed.log) | 151 | 0 |
| [Lifecycle](regressions/group-lifecycle.log) | 226 | 0 |
| [Search](regressions/group-search.log) | 57 | 0 |
| 合计 | 434 | 0 |

各套件退出码均为 0。测试直接提取生产方法与 appearance Hook，替换宿主依赖后执行；覆盖共享高度、目标旧位置不干扰、不同 inset、聊天期间行位置变化、原生 appearance 改 offset、短/空列表、取消导航、账号失效与显式回顶。Lifecycle 同时确认隐藏状态下 20 个原生事件产生 0 次列表发布。测试及生产源 SHA-256 见 [核心回归汇总](regressions/regression-summary.json)。本轮聚焦上述相关套件，没有扩大到无关功能回归。

## 构建与产物

- 版本号、应用内更新内容与包元数据统一为 `2.1-25`。
- Rootless 和 Rootful 各包含 arm64 / arm64e，最低编译目标 iOS 15.0；使用独立临时构建目录，两个 scheme 均 exit 0。
- 每个 scheme 的 6 条警告与 `2.1-24` 去除终端颜色后的内容及次数完全一致，无新增警告，见 [警告对照](warning-baseline-comparison.json)。
- 42,513 份生产输入构建前后 SHA-256 一致。相较 `2.1-24` 仅 6 个生产文件变化，其余 42,507 份不变，见 [输入比较](production-input-comparison.json)。
- 保留既有 `.theos` 与全部历史包；1,301 份既有产物构建后未缺失、未变化，见 [保护结果](preserved-artifacts-after.json)。未执行 `make clean`。
- 最终包路径和校验：见下方交付链接；元数据、安装路径、payload、架构/依赖、dSYM UUID、符号 ZIP 及 SHA-256 的验证结果见 [包验证记录](package-verification.json)。

交付文件：

- [Rootless 安装包](../../../packages/2.1-25-shared-height-return/com.wechat.improve_2.1-25_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/2.1-25-shared-height-return/com.wechat.improve_2.1-25_iphoneos-arm.deb)
- [调试符号](../../../packages/2.1-25-shared-height-return/com.wechat.improve_2.1-25_symbols.zip)
- [SHA256SUMS](../../../packages/2.1-25-shared-height-return/SHA256SUMS)

历史 `release-2.1-25-shared-height` / `packages/2.1-25-shared-height` 是追加聊天返回要求前的未交付中间构建，予以保留。本次应使用带 `shared-height-return` 的最终目录。

## 验证边界

本次未安装到手机，未进行微信真机滚动、CPU、耗电或温度测量。434 项为主机上的生产逻辑回放，不等同于微信/UIKit 真机显示验收。需要用最终 Rootless 包确认实际点击/横滑切组，以及进入聊天后返回的滚动位置。
