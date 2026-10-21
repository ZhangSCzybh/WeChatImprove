# 朋友圈页面身份：静态证据

目标：`/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。REA `open_binary` 核对为 arm64 Mach-O，完成后关闭会话。复用工程现有 Objective-C 元数据解析器，读取本轮相关类与方法，未执行微信。

| 页面类 | 已观察到的身份字段／原生行为 | 本次用途 |
| --- | --- | --- |
| WCListViewController | `m_contact`，`m_contact` / `setM_contact:` | 个人朋友圈所属联系人 |
| WCTimelineFlutterProfileViewController | `_contact`，`contact` / `setContact:`；`initWithContact:source:` 使用联系人 `m_nsUsrName` | 新版个人朋友圈所属联系人 |
| WCCommentDetailViewControllerFB | `_dataItem`，`dataItem` / `setDataItem:`，类型 WCDataItem | 原生朋友圈动态作者 |
| WCTimelineFlutterDetailViewController | `_dataItem`，`dataItem` / `setDataItem:`；完整初始化读取 `username` | 新版朋友圈动态作者 |
| WCTimelineFlutterAlbumV2ViewController | `initWithSource:` 用 `getCurUsrName` 构造相册参数 | 自己的相册不因密友开关整页锁定 |
| WCCommentDetailViewController | `_viewModel: WCCommentDetailViewModel`、`_funcParams: WCFinderPushFeedViewParams` 及 Finder 评论行为；无 WCDataItem 字段 | 移出错误的朋友圈整页 gate 注册 |

`metadata.json` 保存类继承与 ivar 信息；`methods.json` 限定为初始化、页面生命周期和身份 getter/setter 签名。setter 均为对象参数的 `v@:@`，生命周期为 `v@:`，生产安装继续校验 ABI。

`*.asm` 保存五个相关初始化的完整有界反汇编；`manifest.json` 记录区间及文件指纹。静态资料确认的是本地二进制声明和代码路径，不能证明设备当前启用了哪个页面分支，也不证明 Flutter 的点赞／评论序列化过滤。
