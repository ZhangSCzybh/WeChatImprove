# 1.9-8：朋友圈删除按钮布局与密友设置分组

2026-10-22，在原 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`、`main` 分支、基础提交 `f82de803` 上完成。沿用 Theos / Objective-C / Logos 框架，保留工作区已有备份功能与 1.9-7 密友功能改动。

## 修改

1. **修复隐藏范围图标后删除按钮跑到左侧。** 1.9-7 阻止详情页创建 `_privacyBtn`，但原生 `layoutActionArea` 仍从真实动态构造独立的 `WCActionAreaVM`，其排列包含范围元素（type 5）。原生逐个读取元素对应视图的位置，缺失视图的 `right` 返回 0，导致后续删除按钮（type 6）落到左侧。现在只在详情同步布局期间，让模型的 `+canShowShareGroupButtonWithDataItem:isDynamicTagEnabled:` 返回 NO，使模型元素与实际视图一致；其他位置、间距和换行继续由微信计算。作用域采用线程局部状态，退出或抛出异常均恢复。开关关闭后完整使用原生模型，真实动态权限与删除回调未修改。
2. **将图示 7 项移入“账号保护”**，顺序为：隐藏密友设置入口、隐藏插件入口、允许生物识别解锁、摇动立即锁定、首页长按解锁、长按触发时长、临时解锁时长。它们位于该组原有 6 项之后；保护选项保留 15 项。显示行通过配置 key 解析，开关使用原全局 key 索引，两个时长编辑入口按 key 分派。原配置 key 和存储逻辑保持不变。

原生静态证据基于微信 8.0.78 样本，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。新增类方法 ABI 为 `B28@0:8@16B24`，安装前核对签名。见 [模型构造和元素准备反汇编清单](native/manifest.json)、[方法元数据](native/methods.json) 及 [详情布局反汇编](../close-friend-controls-2026-10-22/native/WCCommentDetailViewControllerFB--layoutActionArea.asm)。

## 聚焦回归

本次只执行与两个改动直接相关的主机回归、改动文件双架构编译及一次完整打包；未重复全套历史测试。

- [布局及图标回归](privacy-regression.log)：26 项通过。测试替身按原生证据模拟独立元素模型与缺失视图的位置依赖，覆盖开关切换、重复布局、新详情、公开动态、原生顺序恢复、列表图标、跨线程与异常后的作用域恢复。
- [旧代码对照](privacy-before-fix.log)：使用本次修改前的适配器运行同一回归，明确失败于“隐藏后删除按钮应位于时间之后”。这补齐了 1.9-7 测试只确认按钮仍在视图树、未检查位置的缺口。
- [设置迁移检查](settings-regression.log)：提取实际分组、索引解析及开关保存方法执行，验证 7 项顺序、22 项完整且不重复、19 个开关写入对应选项并保留时长、两个时长项的新位置和源码入口条件。脚本为 [verify-settings.py](verify-settings.py)，不模拟完整 UIKit 编辑弹窗。
- [iOS 编译](ios-compile.log)：两个改动 `.m` 文件在 arm64 / arm64e 下通过 `-Wall -Wextra -Werror` 检查。
- [完整 Rootless 构建](build.log)：退出 0。构建保留项目原有的弃用 API 和链接器警告。

## 产物与环境

- [1.9-8 Rootless 安装包](../../../packages/com.wechat.improve_1.9-8_iphoneos-arm64.deb)
- [对应 arm64 / arm64e 调试符号](../../../packages/WeChatImprove-1.9-8-dSYMs.zip)
- [包版本、架构、UUID、源文件及保留文件核验](package-verification.json)

包 SHA-256：`0eddcfeb3f899b013e4b061236919b14eea45ccbf081720bd23cca218835a900`。版本声明、插件显示与更新说明统一为 1.9-8，两个 dSYM UUID 均与包内动态库一致。

使用原 checkout 和隔离构建目录，完成后将新产物复制到原 `packages/`。313 个构建源文件哈希与最终源码一致，32 个既有包及备份功能文件哈希保持一致；未运行 `make clean`、切换 checkout、修改用户配置、安装设备或重启微信。本项目无 Web 服务 URL 或前后端端口，密友运行数据仍使用微信原容器中的 `Library/Application Support/WeChatImprove/CloseFriends/`。

## 真机验证边界

当前未连接设备，以上为主机回归、静态原生证据和编译验证，尚未完成用户手机上的视觉验收。安装后完全退出并重新打开微信，核心核对两项即可：

1. 开启“隐藏全部朋友圈可见范围图标”，从“我的朋友圈”进入带范围限制的动态详情，确认删除按钮正常排列；关闭隐藏后，范围图标和删除按钮恢复原生顺序。
2. 在“账号保护”确认 7 项位置、已有开关值、0.5–2 秒长按时长和临时解锁时长；“保护选项”不再重复显示这些项目。
