# 密友真机反馈修复 · 1.8-49

基于 1.8-48（`01aaef8cee2e8f920eddf715a279df55247d76f9`）处理本轮两项反馈，产物为 Rootless，含 arm64 / arm64e，最低编译目标 iOS 15.0。

| 反馈 | 本轮修改 |
| --- | --- |
| 解锁后进入朋友圈，首屏下半部分黑屏，滑动后恢复 | 策略刷新改走微信原生 `reloadDataWrap`；首次显示、原生刷新与布局结束时完成当前投影的表格及页尾布局，补齐之前只调用 `reloadData` 的缺口。保持原生封面、页尾、位置与数据。 |
| 群聊头像进入资料页后，“朋友圈”“朋友资料”点击不正常 | 从敏感动作拦截中单独放行 `showAlbumList` 和 `onSocialInfoHandle`，调用微信原生导航；保留当前联系人、assist 代次和账号校验。 |

朋友圈隐藏策略继续沿用 1.8-48：进入页面保持原生，隐藏状态下密友个人朋友圈的动态区域显示原生空内容横杠。资料页的“添加到通讯录”原生展示保留；发消息、通话、添加等动作和真实好友关系不因本轮改动而改变。搜索联想、完整密码解锁、挂断回复等未修改。

## 环境与交付

在既有工作区 `/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove`、分支 `codex/close-friends-148` 开发构建。原目录 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main`（`929d265b`）保持原状，只向其 `packages` 新增本轮 deb。未启动服务、切换数据库、安装到手机或发送真实消息；没有执行 `make clean`。

## 验证

- `bash Tests/verify-close-friend-social.sh` 通过：实际生命周期 hook、首次显示、解锁/重锁即时布局、原生页尾与位置保留、后续数据刷新、未加载/旧账号页面及关闭功能旁路；已有原生 Moments 入口、时间线/互动投影和发布选择核心回归同时通过。
- `bash Tests/verify-close-friend-profile.sh`：16 项通过，使用完整生产 adapter 和实际 hook 注册，覆盖两条原生导航、敏感动作保护、解锁/重锁、普通好友、失效 assist、身份错配和跨账号。
- `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-49` 成功。包版本、双架构、最低系统、符号、dSYM UUID、build/stage/包内 dylib 一致性及两份交付包由 `verify-delivery.py` 检查。
- 仅执行相关回归，未重复运行未修改的分组、搜索、来电和备份全量专项。构建保留现有弃用 API / 链接选项警告，本轮修改文件未新增编译警告。

详细证据：`timeline-native/README.md`、`profile-native/README.md`、`host-results.json`、`build.log`、`validation.json` 与 `source-manifest.json`。

## 真机复验

安装后彻底退出并重开微信，确认插件版本为 1.8-49：

1. 解锁密友后进入朋友圈，停留不滑动，检查下半屏；返回后再次进入，并在锁定/解锁后重复。保留原有内容、滚动位置和原生页尾。
2. 群聊点击密友头像，分别进入“朋友圈”和“朋友资料”。朋友圈入口正常进入原生页面，锁定时仅动态区域为空；解锁后恢复内容。普通好友同样可正常进入。

主机回归验证代码调用、投影和布局时序；原生静态证据验证入口与方法语义。尚未安装到真机，截图中的实际黑色图层及最终首帧效果仍需设备复验。
