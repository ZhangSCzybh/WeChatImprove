# 密友 1.8-47：普通好友朋友圈误锁修复

2026-10-21。基于 `codex/close-friends` 的 `f240a3fa`，沿用 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 工程和 Theos 配置。Rootless，arm64 + arm64e，最低编译目标 iOS 15.0。

## 原因与修复

原先 `CSCFSocialProtectRoute` 对个人朋友圈和详情页统一传入 `force=YES`。只要当前账号有隐藏中的密友、朋友圈或互动隐藏选项开启，即使正在查看普通好友，也会覆盖原生页面并显示“解锁后查看”。

本次按页面身份判断访问：`WCListViewController.m_contact`、`WCTimelineFlutterProfileViewController.contact`、`WCCommentDetailViewControllerFB.dataItem.username` 和 `WCTimelineFlutterDetailViewController.dataItem.username`。普通好友页面走原生加载和布局；隐藏中的作者继续受保护。页面访问不使用点赞者、评论者或可见范围名单作为作者，避免其中包含密友时误锁整页。

在页面加载、布局、身份 setter 和密友策略变更时重新计算，不缓存上一次联系人的许可。身份暂未就绪时维持保护，身份确定后立即刷新；换号后的旧页面仍受账号边界保护。自己的 Flutter 相册根据原生初始化路径放行。`WCCommentDetailViewController` 实际是 Finder 评论页面，移出朋友圈拦截名单；朋友圈原生详情为带 `FB` 后缀的类。

搜索和来电回复源码未修改。1.8-46 的原生实时联想、网络搜索提示及完整密码解锁口径沿用。

## 证据与验证

- [页面元数据与初始化证据](social-native/README.md)：在既有微信 8.0.78 本地二进制中核对类、字段、签名和自己的相册入口；只做静态分析。
- `Tests/verify-close-friend-social.sh`：通过。新增 fixture 安装真实生产路由注册、生命周期和身份 setter hooks；覆盖普通好友／密友的原生与 Flutter 个人页面、含密友互动的普通动态不误锁、身份替换、解锁／重锁、账号切换、功能停用、关闭朋友圈隐藏，以及自己的相册和 Finder 页面。沿用同一脚本验证原生主朋友圈投影、互动过滤、源数组及 ACL 保留、提醒谁看等已适配流程。
- `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-47`：双架构构建；结果见 `build-result.json` 与 `build.log`。
- `verify-delivery.py`：复核源码指纹、版本、包内动态库与构建／暂存产物一致、架构、最低 iOS、dSYM 及旧 deb 保留。结果见 `validation.json`。

本次仅修正页面访问判定，不把它当作 Flutter 数据层或原生个人详情所有点赞／评论展示路径均已过滤的证据；对应完整过滤能力仍未声明可用。既有主朋友圈互动过滤的回归已通过。

未安装到设备、发送消息或修改用户账号数据。主机 fixture 验证页面身份与 gate 决策，UIKit 遮罩绘制由 iOS 构建检查，实际设备显示仍待验收。重点复验：锁定时打开普通好友朋友圈和一条动态不提示解锁；打开隐藏密友的相同入口仍受保护；临时解锁后查看，再锁定并回到普通好友页面正常。
