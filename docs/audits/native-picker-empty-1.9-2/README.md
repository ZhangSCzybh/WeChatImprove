# 1.9-2：密友选择器空名单保存

2026-10-21，在 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` 工作区继续修复，以当前 1.9-1 源码及已有设置调整为基线。

## 原因与修复

微信 8.0.78 的 `MultiSelectContactsViewController.updatePanelBtn`（`0x104e9f94c`）会根据已选人数创建新的完成按钮，直接设置 `enabled`，再替换导航按钮。默认选择场景下，这条路径绕过已有的 `updateRightBarItemEnabled:` 适配，所以原保存逻辑虽然支持空数组，界面仍不能点击。

仅在插件专用的 `CSNativeSettingsFriendPicker` 子类补齐 `updatePanelBtn` 转发：先调用注册时保存的原生 IMP，再按当前账号和授权状态调用原生按钮状态更新方法。这样保留微信的按钮、标题、人数和点击动作，并允许已授权的空选择保存。保存层、取消行为和群聊选择器实现不变；授权过期、重新锁定或账号切换仍不能写入名单。

直接调用保存的原生 IMP，避免 UIKit 外观机制增加动态子类后递归调用自身。未增加布局钩子、定时刷新或全局微信选择器修改。

原生方法的限定范围反汇编见 `MultiSelectContactsViewController--updatePanelBtn.asm`；二进制哈希、方法地址与签名记录在 `validation.json`。这是静态证据，不代表本轮已在手机观察到修复后的点击效果。

## 核心验证

- 修正测试替身，使其模拟原生重建按钮、直接按人数禁用的行为。修复前运行同一用例，确认在“取消最后一个密友后完成可用”处失败，见 `regression-before.json` / `.log`。
- `bash Tests/verify-native-contact-picker.sh`：88 项检查通过，包括初始空名单、清空后通过真实 target/action 保存、已有名单与人数标题、重复刷新、动态子类、取消、失效授权和账号切换，以及共享群聊选择器原有流程。
- `CSNativeContactPicker.m`：arm64 / arm64e 严格编译通过（`-Wall -Wextra -Werror`）。随后完整 Rootless 构建通过。
- 安装包版本、双架构、最低 iOS 15.0、暂存与打包二进制一致性、注入配置和 dSYM UUID 均已核对。详见 `validation.json`。

本轮仅运行原生选择器相关回归和编译交付检查。现有密友设置布局、备份页标题修复及历史安装包经哈希核对保留；构建缓存和暂存使用独立临时目录，没有执行 `make clean` 或修改设备数据。

- [1.9-2 Rootless 安装包](../../../packages/com.wechat.improve_1.9-2_iphoneos-arm64.deb)
- [1.9-2 双架构调试符号](../../../packages/WeChatImprove-1.9-2-dSYMs.zip)

尚未安装到真机。安装后重点复验：密友名单无勾选时直接完成、取消最后一个密友后完成，以及重新进入后仍为空名单。
