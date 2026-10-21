# 资料页入口修复 · 1.8-50

基于已回退的 1.8-48 代码，单独修复“从群聊头像进入资料页后，朋友圈与朋友资料无法进入”。安装包使用新版本号 1.8-50，Rootless、arm64 / arm64e、最低 iOS 15.0。

## 原因及修改

1.8-48 中 `showAlbumList` 与 `onSocialInfoHandle` 都由隐藏密友的通用动作 Guard0 拦截，点击被直接吞掉。现在仅对这两个浏览入口使用 `Navigate0`，在当前联系人、账号、assist 绑定有效时调用微信原方法。

静态证据已核实：`showAlbumList` 调用微信的个人朋友圈路由；`onSocialInfoHandle` 创建原生朋友资料页并 push。`jumpToContentViewController:` 实际为聊天入口，仍保留动作保护。复用已有 [8.0.78 原生方法证据](../close-friends-1.8-49/profile-native/README.md)，未重复分析整份二进制。

朋友圈主列表、个人朋友圈内容、详情、互动与社交路由 adapter 的文件 SHA-256 均与 1.8-48 完全一致，记录在 `scope.json`；生产代码改动只有 ProfileAdapter 的头文件/实现、ProfileHooks，另更新版本号与发布说明。本包没有加入 1.8-49 的强制布局刷新代码。

隐藏状态下仍按 1.8-48 的规则进入微信原生个人朋友圈：封面、头像等保持原生，密友动态区域使用原生空内容横杠；临时解锁后恢复内容。真实好友关系和原生“添加到通讯录”按钮展示保留。

## 验证与交付

- `bash Tests/verify-close-friend-profile.sh`：16 项通过，编译完整生产 adapter 与实际 hook 注册；覆盖两个入口、普通好友、解锁/重锁、原生按钮与敏感动作保护、失效绑定和跨账号。
- `bash Tests/verify-close-friend-album.sh`：19 项通过，覆盖入口后个人朋友圈的内容过滤、原生页尾、普通好友、解锁/重锁与原始数组保全。
- 双架构 `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-50` 构建，包元数据、符号、源码范围、dSYM UUID、build/stage/包内产物一致性及原安装包保全，由 `verify-delivery.py` 核验，结果记录于 `validation.json`。
- 仅运行上述两个专项，无设备安装、真实消息发送或数据库操作。

开发和构建继续在 `/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove`、`codex/close-friends-148` 分支完成。原项目 main 保持 `929d265b`；新包复制至其 `packages/com.wechat.improve_1.8-50_iphoneos-arm64.deb`，保留现有 1.8-48 / 1.8-49 包。

## 真机复验

安装后彻底退出并重开微信，确认插件版本为 1.8-50。从群聊点密友头像，分别点击“朋友圈”和“朋友资料”，验证原生跳转与返回；再切换密友锁定/解锁状态复验。主机回归和原生静态证据已完成，尚未在真机确认最终跳转效果。此前 1.8-48 的朋友圈首屏黑区问题不在本轮修复范围。
