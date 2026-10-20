# 密友 1.8-43：真机反馈修复

本版基于用户对 1.8-42 的真机验收反馈。代码、主机回归和 Rootless 双架构安装包已完成；**1.8-43 的实际设备复验尚未执行**。

工作目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`，分支 `codex/close-friends`，微信接口证据为 8.0.78。未切换工作副本、账号或数据库，未安装到手机、重启微信或推送代码。既有 `.theos` 和旧包保留。用户截图留在 `docs/audits/inbound/service-account-collections.jpg`，不包含在安装包或本次提交中。

| 反馈 | 本版处理 | 真机复验重点 |
| --- | --- | --- |
| 谁可以看跟随锁定 | 删除整页验证遮罩，原生模式选择和完成继续可用。部分可见／不给谁看的好友候选及候选搜索过滤密友。识别 MultiSelectContactsViewController.m_delegate；原生选择集合不被候选投影覆盖，提交合并隐藏的原有成员。 | 锁定时分别选择普通好友并完成；已选密友的真实可见／排除权限保持原值；取消不修改权限。 |
| 服务号／公众号出现会话集合 | 聚合遮罩只作用于 `chatroom_session_box`；服务号、公众号和其他聚合行交回原生 cell、归组及未读展示。 | 密友锁定与解锁切换，原生服务号／公众号入口、分组和普通会话顺序正常。 |
| 原生搜索昵称／备注漏过 | 单人、群聊和 top-hit 搜索按 `row.model` 中的真实 username 过滤，保留行包装、原始数据和索引一致性。 | 昵称、备注、拼音匹配与查看更多；普通联系人仍可搜索；解锁后恢复密友。 |
| 自制资料页 | 删除重建页面，保留微信原页。仅在原生按钮构建作用域中切到非好友分支，生成微信自己的“添加到通讯录”。按钮点击停止在本地提示，不发送申请、消息或修改关系。 | 共同群头像进入资料；原生布局、Add 按钮、点按行为及解锁后的发消息／音视频恢复。 |
| 长按仍要求密码 | 首页导航栏长按 1.2 秒直接临时解锁，轻触感反馈，不跳设置页。只在首页且账号有效时生效。 | 隐藏密友／插件入口后长按；列表与入口恢复；切后台或超时后重新隐藏。 |
| 搜索密码与设置精简 | 完整密码在首页查询／历史调用前本地识别并清空输入。普通搜索不累计密码错误；冷却期仍吞掉已识别密码。去掉兼容性状态区。 | 手输／粘贴密码解锁，搜索框清空；普通搜索与输入法组合正常；设置无兼容性状态。 |

临时显示继续使用原有时长（默认 300 秒），通知静默和来电拒接策略保持独立。隐藏入口选项保留，解锁期间暂时显示。长按无需密码是本次用户明确要求的快捷行为。

## 回归与交付

只运行受影响的五组主机回归，结果见 [host-results.json](host-results.json)。编译宏、版本字符串和安装包均为 `1.8-43`。最终构建为 `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-43`，产物为 `packages/com.wechat.improve_1.8-43_iphoneos-arm64.deb`，含 arm64 与 arm64e，最低 iOS 15.0。

首轮构建之后，只整理了重复 footer 重建和嵌套查询校验，补上候选动作的作用域检查；重跑相应 contacts/social fixture 并增量生成最终包。没有清理缓存、重复完整回归或重复分析无关模块。旧有 UILocalNotification/statusBarFrame 和 linker 弃用提示保留；最终构建详情见 [build-final.log](build-final.log)。

[validation.json](validation.json) 记录包与构建／staging dylib 的一致性、双架构、最低系统、版本、旧包校验和与源文件摘要。源文件摘要在最终构建后冻结；可运行 `python3 docs/audits/close-friends-1.8-43/verify-delivery.py` 重新核验。

## 原生证据与范围

复用 1.8-42 搜索单元格／profile 按钮反汇编。搜索三类 cell 均读取外层 row.model 后才取 CContact.m_nsUsrName，原实现遗漏此包装层。原生 Add 分支以及只限制 folded-chat 遮罩经过一次独立只读核对；未发现阻止交付的问题。

补充静态证据位于 [native](native)。目标 SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。REA 确认目标身份；其 metadata reader 受 64 MiB 输入限制，因此复用已有 mmap 元数据解析器及限定地址的 llvm-objdump 读取，没有运行目标程序。

- `WCMomentsPrivacyViewController.openAddFromFriend` 读取 selectedContacts 并设置 m_dicMultiSelect；`updateWithSelectedContactSet:` 清空并重建 selectedContacts，所以提交时保留隐藏成员，原始标签 ACL 不被截断。
- `ContactSelectView.onFilterContactCandidate:` 默认返回 YES；本版只对确认属于发布范围的 picker 拒绝隐藏成员。
- `FTSHomeViewController.onTextFieldChanged:` 读取 markedTextRange/text 后转交 mmInputBoxTextChanged:text:；语音入口为 onGetTextInput:isFromVoice:。拦截在原方法前执行，完整匹配才消费输入。
- `WeixinContactInfoAssist.reloadTableView` 调用 initData、reloadData、initFooterView、onTableViewReload。复用这个重建流程，取消额外重复 footer 重建；重入由 refreshing 和已渲染状态约束。

本次修复不扩展上一版未覆盖的来电／进程终止通知能力；静态证据和主机 fixture 不能代替上表中的真机复验。历史完整限制见 [1.8-42 交付记录](../close-friends-1.8-42/README.md)。
