# 密友功能原生接口依据

这些报告是微信 8.0.78 的静态样本分析，用于选择接口和约束调用，不代表真机行为已经通过验收。目标 SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。未运行分析目标或连接真实账号。

- [联系人、转发、搜索与资料](surface-native-report.md)
- [朋友圈、互动、状态及展示缓存](social-native-report.md)
- [通知、免打扰与通话](alert-native-report.md)
- [折叠群聊和聚合预览](session-native-report.md)

配套目录保留 selector/ABI 清单、定界反汇编、提取脚本与 SHA-256 清单。除报告内的归档路径修正及相应报告摘要更新，证据文件保持原字节。脚本依赖仓库中 `docs/evidence/close-friends-native-2026-10-20/extract.py` 和 `docs/evidence/message-actions-native-2026-10-17/classes.json`；重现时还需要原本地分析样本，目标二进制不包含在仓库交付中。

应用运行时仍须验证实际方法签名。不存在已验证匹配拒接路径的 main ilink 来电只支持已知身份的应用内提示抑制，不标记为已拒接，不替换成会干扰其他房间的通用挂断。所有设备和系统通知表现以独立验收记录为准。

补充的 `search-feature-metadata.json` 只核对已知 FTSFeatureMessageSectionController 的父类与方法表：它继承 FTSMessageSectionController，没有重写本次已拦截的 count/cell/selection/update/search 边界。该结论支持已知特征消息分区沿用父类保护，不代表未知新版本搜索路径通过设备验收。提取复用 surface-native/extract_surfaces.py 的只读解析逻辑，仅缩小 selected 类名单，未再次反汇编或执行目标。

补充的 `social-identity-metadata.json` 核对三个明确缺失的身份边界：WCSNSMessage.comment/refComment 指向 WCUserComment；后者 username/refUserName/dataItemUsrName 提供评论者、被回复者、动态作者身份；消息 objID/parentObjID 是对象 ID，不作为用户名。TextStateTopicModel.usernames 返回主题下的用户名列表。以上均是已观察到的对象返回 ABI，仍须运行时检查实际类型。该补查复用同一提取器，只读取三类的属性和方法表，未重复反汇编。

`discovery-metadata.json` 定向核对发现页朋友圈入口：badgeAtMomentCell 返回 BOOL、numberOfUnreadAtMomentCell 返回 NSInteger，updateWCTimeLineView: 为 void/object；m_timelineHeadView 和 m_timelineRedDotView 为对象 ivar。numberOfUnreadAtTab 同时涉及其他发现页内容，不以清零整个发现页替代朋友圈适配。此文件仅提供类型和入口依据，不推断未经反汇编的更新方法业务语义。
