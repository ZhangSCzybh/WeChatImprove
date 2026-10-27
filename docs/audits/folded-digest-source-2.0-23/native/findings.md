# 8.0.78 折叠摘要取数证据

目标 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。本次使用已选择的 REA 原生目标会话确认目标，延用有界 Mach-O 元数据解析和 LLVM 反汇编；未执行微信、未在用户手机注入探针。原生会话已关闭。下述结论为静态证据，不冒充设备运行日志。

## 确定的类型错误

| 方法 | IMP | 完整编码 |
| --- | --- | --- |
| CMessageWrap.m_n64MesSvrID | 0x104bb3fec | q16@0:8 |
| MainFrameCellData.m_n64MesSvrID | 0x104a8229c | Q16@0:8 |

`methods.json` 中两条 getter 编码不同。CMessageWrap getter 的机器码是读取完整 64 位字段，类型为 signed q；不是一个保证非负的有符号计数器。2.0-22 的 `FoldedMessageID` 只允许 Q，因而源消息 ID 必定被拒绝为零。主机替身曾声明 unsigned Q，遗漏了真实签名差异。

2.0-23 分别按 q/Q 的真实调用签名读取，再无损映射为 64 位身份位。不能用饱和整数读取器，否则两个高位 ID 会合并为 LLONG_MAX。回归保留了高位 ID 相等及不相等的两种检查。

## 无 CellData 时的原生路径

| 方法 | IMP | 证据与处理 |
| --- | --- | --- |
| MainFrameCellDataManager.getCellDataByUsrName: | 0x104a836a8 | 字典查找，不创建缓存；启动时不存在缓存是合法状态。仍作为首选只读路径。 |
| +MainFrameCellData.digestForMsg:withSender: | 0x104a78584 | 原生消息摘要格式化，签名 @32@0:8@16@24。文本、图片、链接/应用消息、引用等分支沿用微信语言/消息类型逻辑，sender 是已带分隔符的原生前缀。 |
| CMessageWrap.copyWithZone: | 0x104b9f00c | 分配另一 CMessageWrap，再调用 copyToMsg:。 |
| CMessageWrap.copyToMsg: | 0x104b9e4ac | 复制消息身份、内容、发送人等；三类 extendInfo 调用 copy，并把其 m_refMessageWrap 指向新消息。 |
| CMessageWrap.ChangeForDisplay | 0x104ba1b9c | 会解析/修改消息内容与发送人，因此只能对副本调用。 |
| MainFrameCellData.getGroupName | 0x104a781fc | 从 m_sessionInfo 读取 m_contact、m_msgWrap；按原生联系人规则取得发送人展示名称和“: ”前缀，自发消息等允许空前缀。会改当前 CellData 的局部标志，故只在新建临时实例调用。 |
| MainFrameCellData.init | 0x104a7657c | 普通初始化，不初始化缓存/红点。 |
| MainFrameCellData.setM_sessionInfo: | 0x104a821e4 | 单纯 strong 引用赋值。临时绑定只有上述两个 getter 的本地只读上下文，不使用宿主 MMSessionInfo setter。 |

流程：优先校验现有 CellData；缺失、文本空、缓存会话或消息身份不匹配时复制当前会话的消息。确认不是同一对象、消息 ID 位相同、三类扩展信息及 referHostMsg 没有意外同一对象别名，再对副本进行 ChangeForDisplay；群聊在新建临时 CellData 上用 getGroupName 取前缀；调用原生 digestForMsg:withSender:。只复制其字符串结果到 CSGroupRow。缓存重入/格式化之后再次确认源消息对象、消息 ID、会话名和有效排序时间没有变化。

本路径不是把 native formatter 宣称为“纯 getter”。它具有本地解析行为，只允许作用于脱离原模型的消息副本及临时展示对象；没有调用缓存创建器或红点处理入口。反汇编中直接调用的服务包含语言、联系人等读取及消息文案解析；没有在手机上证明所有版本、所有私有消息扩展的传递副作用。兼容范围以本次 8.0.78 静态证据和核心替身回归为准；未知签名、不能复制、别名或解析异常均回退并给原因码。

## 没有采用的入口

- `getCellData:` 会创建/保存缓存并处理 red tips。
- `initWithSessionInfo:`、`makeTextSession:`、`makeTextForMessageLabel` 属于完整 native cell 构建，有更新时间、红点或联系人写入分支；不调用。
- `MMSessionInfo.setM_msgWrap:` 自身会处理时间，不能在宿主会话上替换消息。也没有为了取前缀去执行这个 setter。
- `GetDisplayContent` / `m_nsContent` 不能作为通用列表摘要：部分类型会是原始 XML/内容，缺少原生类型文案。没有手动解析 XML 或使用全局聚合摘要。
- 已索引的 MMSessionInfo 方法中未确认一个适用于所有消息类型的持久化摘要 getter；`m_waUpdatableMsgDigest` 是特殊功能字段，不能代替通用摘要。
- 从折叠子 cell 抓 message label 会依赖页面首次渲染；本版用消息副本原生格式化消除这一前提，不增加 UI 抓取或独立文本缓存。

完整方法记录见 `methods.json`；有界反汇编的起止和是否截断见 `disassembly-inventory.json`；哈希见 `manifest.json`。这些证据不等同于已真机验证。
