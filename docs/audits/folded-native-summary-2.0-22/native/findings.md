# 原生摘要只读来源（微信 8.0.78 / 静态证据）

目标 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。以下结论来自 Objective-C 元数据和有界反汇编，不是设备运行结果。

REA 已核对目标身份；其原生 dispatch 元数据快照超过 64 MiB 内存预算，改用项目已有的只读 mmap 元数据解析器与 `llvm-objdump` 有界反汇编。`rea-evidence.json` 的 export 为空（0 记录），不能用它作为下列结论的证据；实证文件是 `methods.json` 及带 selector 注释的 `.asm`。没有执行目标程序。

| 原生方法 | 地址 | 已观察行为与取舍 |
| --- | --- | --- |
| ChatBoxMgr.chatBoxSessions | 0x100e49ac0 | 返回折叠会话集合；本次唯一成员源，读取后复制数组。 |
| ChatBoxSessionListViewController.logicGetCellDataAtIndexPath: | 0x100e4b3fc | 先取该折叠会话，再由 MainFrameCellDataManager 取得 CellData，证明摘要来自各会话的原生 cell 数据。 |
| MainFrameCellDataManager.getCellDataByUsrName: | 0x104a836a8 | 对内存映射调用 objectForKey:，无生成或保存分支。本次仅使用这条读取。 |
| MainFrameCellDataManager.getCellData: | 0x104a82bec | 会创建 CellData、读写/删除磁盘缓存、saveCellData: 及处理 red tips；本次不调用。 |
| MainFrameCellData.initWithSessionInfo: | 0x104a765c8 | 保存会话、从 m_msgWrap 绑定 m_n64MesSvrID；还更新 UI 字段及未读，不能作为只读构造器使用。 |
| MainFrameCellData.m_textForMessageLabel | 0x104a82308 | 原生已生成的摘要字段；m_sessionInfo（0x104a821dc）和 unsigned Q 的 m_n64MesSvrID（0x104a8229c）用于身份验证。 |
| MainFrameCellData.makeTextForMessageLabel | 0x104a76e94 | 原生群聊名称/消息摘要生成分支；配合 makeTextSession:（0x104a7cfd4）及 makeTextForQuoteMessage（0x104a80370）处理消息类型与引用。只读现成结果，不自行重建前缀或解析 XML。 |
| MainFrameCellData.digestForMsg:withSender: | 0x104a78584 | 包含 ChangeForDisplay 等修改消息显示状态的调用，不用作兜底。 |
| MMSessionInfo.compare: | 0x1046ae32c | 见下方时间规则；原生列表有置顶优先级，不能直接取数组第一条。 |

原生有效时间：先取非零 `sortTimeOverride`，否则 `m_uLastTime`；置顶会话与 `m_uTopTime` 取最大值，非置顶与 `m_uUnTopTime`、`sortTime` 取最大值。摘要在经过既有分组/隐私过滤的会话中取有效时间最大者，不沿用原生的置顶位置优先级。相同最大时间的会话均属于最新时间，保留首个同时间候选；不是按名称选取。

生产兼容边界：运行时验证 accessor 的参数/返回类型；缓存必须绑定同一个会话对象，且缓存与当前消息的精确 unsigned 64 位服务端 ID 相等且非零。然后复制 NSString 或 NSAttributedString.string，保持微信已生成的可见文本。缺失接口、缓存未生成/过期、未知时间、消息 ID 无法验证或最新会话没有摘要时，回到“折叠的聊天”中性文案；不会把较旧消息假称最新，也不会借用全局聚合入口。

这些字段在已核对的 8.0.78 二进制中存在；其它微信版本的运行状态、缓存何时就绪仍需真机验收。适配器对未知/不符类型保守回退，不假设其它版本有同样内部结构。
