# 微信 8.0.78 密友展示边界静态核对

日期：2026-10-20。目标：`/tmp/wechat-8.0.78-inset-analysis/WeChat`，arm64 Mach-O，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`，与主任务既有证据一致。

本次只读取目标文件和仓库，未运行微信、连接账号、启动服务、构建或提交。复用主任务已确认的目标及 ObjC 解析器前缀，新增结果仅写入当前 SDD 的 `surface-native/`。共解析 37 个类、2,741 个类/实例方法，对 79 个选定方法按 LC_FUNCTION_STARTS 边界反汇编，单函数上限 16,000 字节，本次没有截断。元数据及反汇编是**当前样本静态观察**，不等于真机验证。所有实际 hook 仍须检查运行时类、编码、类型及所属页面。

## 证据入口

- `surface-native/methods.json`：真实 selector、instance/class、类型编码、IMP、下一函数边界。
- `surface-native/metadata.json`：真实父类、属性、ivar 名和静态 offset。offset 只用于解释反汇编，生产代码不得硬编码这些数值。
- `surface-native/manifest.json`：目标摘要、覆盖类、文件摘要、每份反汇编范围。
- `surface-native/extract_surfaces.py`、`surface-native/disassemble_surfaces.py`：可重现的只读分析脚本。后者会复用已存在的同名反汇编，避免重复分析。

`.asm` 中 `; selector` 是从目标选择器指针解析的辅助注释，`ivar Class.name` 与本次 metadata 交叉核对。其他可打印数据偶尔也会被附注，不可把任意可打印内容视为 selector。记录的地址是未加 ASLR slide 的虚拟地址。

## 可直接采用的边界

| 表面 | 建议的最小接入 | 当前样本证据 | 必须一起处理 |
|---|---|---|---|
| 通讯录 | 为已绑定 ContactsViewController/ContactSelectView 的 ContactsDataLogic 实例建立只读展示快照；统一适配 `getKeysArray`、`getContactsArrayWith:` 和显示 count | getters、ContactsViewController 的行数/建 cell/点击均有实际函数证据 | 特殊 section 保持原语义；收藏联系人独立数组；字母索引；空组；异步结果；别把全局 CContactMgr 变成查不到密友 |
| 转发最近会话 | `SessionSelectView.filterContact:` 返回 `orig && visible`；状态变化后重建该页面数据 | initData 的循环直接调用此方法再加入本页 `m_arrContacts`，之后计算置顶数 | 搜索与最近转发横排是另外两路，不能只安装此 hook |
| 最近转发横排 | `RecentForwardScrollView.contactsForRecentForwardMenu` 返回过滤副本 | initView 用该返回值 count、创建图标；点击使用 `iconViews[tag].oContact` | 重建 iconViews/tag/宽度/空态；仅作用于授权转发页面实例 |
| 联系人/群搜索 | `FTSSingleContactSectionController`、`FTSGroupContactSectionController` 的 `didUpdateWithModel:` 后，对本页 `contacts` 设置过滤副本 | 原方法直接写 `_contacts`，计数和 cell 消费同一 ivar | 只 hook setter 会漏；保留原始 rows 便于解锁恢复；群搜索有额外入口行 |
| 置顶搜索建议 | `FTSTopHitsSectionController.didUpdateWithModel:` 后处理本页 `topHitItems` | 本页独立数组，numberOfSearchItems 取其 count | 数组异构，仅对已识别联系人类型做 ID 规则；保留功能、小程序等其他类型 |
| 聊天记录搜索的 split 分支 | 适配 `FTSMessageSectionController.displayedMgrSessionIndexes` 返回的 NSNumber 索引数组 | 显示数量、username、消息条目均通过这个映射 | 非 split 分支、talker 特殊入口、群内密友作者命中必须另做；不要只改 count |
| 标签成员详情 | `ContactTagNewDetailViewController.processContactSectionData:` 对隐藏成员不生成本页分组；保持完整成员模型 | 函数仅解析 section key 并把 contact 加入本页 section 数组；count/cell/click/delete 使用此字典 | 标题人数/空态、标签搜索和“谁可见”选择回调单独处理 |
| 标签列表摘要 | 在 `makeContactItemCellContent:withTagData:searchText:` 之后更新 cell 的显示人数/显示成员字符串 | 原方法读取完整成员 count，再调用本页显示 setter | 不替换持久成员，不让 cell.tagData 变成删减过的可写业务模型 |
| 密友资料 | 绑定具体 VC/assist 的展示状态，受控作用域下返回非好友展示；替换好友操作 section 为本地“添加到通讯录”展示动作 | VC、base assist 的关系 getter 和 `WeixinContactInfoAssist.addMsgActionView` 均已确认 | 必须拦截本地伪按钮 action，不能 fall through 到真实添加/验证链路；解锁后原生重建 |

## 1. 通讯录的 count、item、index

### 真实方法与结构

`ContactsViewController` 的真实父类是 `MMTabBarBaseViewController`，不是旧 dump 展示的 NSObject。它持有 `m_contactsDataLogic`、`m_countLabel`，并新增独立 `_favourContactArray`，存在 `favourContactArray`/`setFavourContactArray:`（`@16@0:8` / `v24@0:8@16`）。

`ContactsDataLogic` 的本页分组数据：`m_dicAllContacts`、`m_arrAllKey`、`m_arrFilteredContacts`、`m_uiContactCount`、`_myNormalContactArray`、`_myNormalContactArrayUnfiltered`。以下方法真实存在：

| selector | 类型编码 | IMP |
|---|---|---|
| `getContactCount` | `I16@0:8` | `0x10109e820` |
| `getAllNormalContact` | `@16@0:8` | `0x10109e8a0` |
| `getAllNormalContactUnfiltered` | `@16@0:8` | `0x10109e8ec` |
| `getKeysArray` | `@16@0:8` | `0x1010a64c4` |
| `getContactsArrayWith:` | `@24@0:8@16` | `0x1010a6618` |
| `getAllContactsDictionary` | `@16@0:8` | `0x1010a6708` |
| `getAllContacts` | `@16@0:8` | `0x1010a6718` |
| `getFilteredContacts` | `@16@0:8` | `0x1010a68ac` |
| `reloadContacts` | `B16@0:8` | `0x1010a458c` |

`ContactsViewController.tableView:numberOfRowsInSection:` 在 `0x1010e846c–0x1010e84ec` 执行 `ConvertToNormalContactSection:` → `getKeysArray` → key → `getContactsArrayWith:` → count。

`makeCell:tableCell:section:row:` 在 `0x1010eabd8–0x1010eac38` 使用相同 key/array 取对象。`tableView:didSelectRowAtIndexPath:` 也按普通分组路径读取这些 getter，因此对**具体本页 logic 实例**建立一致的 key/array 快照能让显示与点击共用数据，优于单独翻译 cell 的 indexPath。

`getKeysArray`/`getContactsArrayWith:` 对 scene 13、14 有 RecentVideo/RecentVoice 的特殊路径，不能全局覆盖所有 logic 实例。展示快照应在生成时保存原始 key → 原始数组，并在同一策略版本下派生过滤 key/数组；主线程 UI 更新期间不可让 key 与数组分别使用不同版本。

### 不可误用 onFilterContactCandidate

`ContactsViewController.onFilterContactCandidate:`（`B24@0:8@16`，`0x1010ede58`）本身是 `mov w0,0; ret`。

`ContactsDataLogic.filterContactsViewContacts:`（`v24@0:8@16`，`0x10109f8b8`）只有 `m_bCanFilterInContactsView` 开启且 delegate 实现该回调才消费它；在 `0x10109fb8c` 得到结果后，`0x10109fbb8–0x10109fcbc` 显示 **NO 跳到下一联系人，YES 继续保留条件**。在默认恒 NO 的 delegate 上直接把 gate 打开会让正常联系人一起被排除。

`ContactSelectView.onFilterContactCandidate:`（`0x10101a550`）将结果转发给 delegate，delegate 不存在或不实现时默认 YES。不能因 selector 相同而给所有类安装同一套未经区分的默认行为。

## 2. 转发列表、横排和增量搜索

`SessionSelectView.filterContact:`（`B24@0:8@16`，`0x1057e4d5c`）是允许谓词。函数末尾读取 `m_ignoredContacts[m_nsUsrName]`，在 `0x1057e51d0–0x1057e51d4` 把“结果为 nil”转换成 YES。原有禁止项、企业类型、群限定条件仍应由 orig 保留。

`SessionSelectView.initData`（`v16@0:8`，`0x1057e43c8`）在 `0x1057e49a4` 使用 `forwardableSessionEnumerator`，读取会话身份并取/复制联系人；`0x1057e4a38` 调用 `filterContact:`，之后才加入 `m_arrContacts`，最终在 `0x1057e4bb0` 设置 `topSessionCount`。因此在此谓词补充密友规则，原生列表构造可以自然维护 count/置顶分组。

`tableView:numberOfRowsInSection:`（`q32@0:8@16q24`，`0x1057e7a68`）实际读取 `m_arrContacts.count`、`topSessionCount`、`selectedTopSessionCount`，并处理特殊 section。`contactForRecentChatRowAtIndexPath:`（`@24@0:8@16`，`0x1057f3f60`）调用 `contactIndexForRecentChatRowAtIndexPath:`（`q24@0:8@16`），折叠置顶/多选分支还枚举 `m_arrContacts` 的选中项；不能只重写可见行数。

**旧建议的刷新回调在此版本不可用**：`SessionSelectView.onContactsDataChange`（`0x1057e51f0`）是单个 `ret`，`onFilterContactCandidate:`（`0x1057e51f4`）是恒 NO。这两个名字存在不代表可覆盖列表刷新。

最近转发横排完全独立：

- `RecentForwardScrollView.contactsForRecentForwardMenu`：`@16@0:8`，`0x105513c08`。读取服务的 `recentForwardSessions`，取每个 `m_contact`，应用群/已删除等条件后生成新的 NSMutableArray。
- `initView`：`v16@0:8`，`0x1055126e4`。`0x105512868` 调用上述 getter，再用 count 创建图标和数组 `iconViews`。
- `onItemClick:`：`v24@0:8@16`，`0x10551481c`。读取手势 view.tag → `iconViews[tag]` → `oContact` → delegate `clickRFItemCallBack:`。`indexForContact:`（`q24@0:8@16`）也遍历图标的 `oContact.m_nsUsrName`。

适配 getter 返回副本后调用该页面原生重建，能保持图标/tag/点击身份一致；不能调用 `deleteContact:` 或最近转发记录删除接口来隐藏。全隐藏时还需收起横排标题及占位高度，原生 `hasRecentForward` 是否仍基于服务原始记录需在 UI 验收中覆盖。

搜索方面，当前新增：

- `SessionSelectView.sessionSelectMessageSearchLogic:shouldIncludeContact:`：`B32@0:8@16@24`，`0x1057f57d4`。YES 代表包含。普通联系人先构造一个数组送 `FilterSearchResultOfNormalContacts:`，再判断是否非空；群走群限定条件。可以按已知联系人 ID 添加拒绝条件。
- `SessionSelectMessageSearchLogic` 的合并接口是 `mergeResultsIntoContacts:groups:topHitItems:sectionKeys:sectionResults:`，编码 **`B56@0:8^@16^@24@32^@40^@48`**。这里是 out-object 指针参数，不是全部 id；不要用宽松 `objc_msgSend(id,id,...)` 猜签名。
- 仍需过滤 `arrSearchResultOfContacts/Group/TopHit`、`dicSearchResult/arrSectionKey` 的页面快照及异步回调。查询任务 key 和策略版本必须一起校验。

## 3. FTS：已确认的页面边界与尚未闭合的模式

### 联系人、群和 TopHits

`FTSSingleContactSectionController` / `FTSGroupContactSectionController` 均有 `contacts` getter (`@16@0:8`) 和 setter (`v24@0:8@16`)，但原生 `didUpdateWithModel:` **绕过 setter 直接写 ivar**：

- Single：`0x1017e01d8`，要求 `_TtC6WeChat20FTSNormalSectionData`，取 `rows`，在 `0x1017e0244` 写 `_contacts`。
- Group：`0x101759ba8`，取 `model.data`，在 `0x101759bdc` 写 `_contacts`。
- Single `numberOfSearchItems`：`q16@0:8`，`0x1017e082c`，直接 `_contacts.count`。
- Group `numberOfSearchItems`：`q16@0:8`，`0x101759df0`，等于 `_contacts.count + shouldDisplayChatRoomEntry`。不能把“更多群聊/群入口”等额外行误认为联系人数组成员。
- `dataCellForItemAtIndex:indexPath:`：`@32@0:8q16@24`，Single `0x1017e0260` / Group `0x101759e3c`，取本页数组，联系人分支使用 `m_nsUsrName` 取 matchTip。
- Single `didSelectDataRowAtIndex:indexPath:`（`v32@0:8q16@24`，`0x1017e04fc`）读取当前 cell.contact 交给 `router.openMessageContentView:`。状态改变后必须同步重建 cell，不能仅改数组。

推荐 `didUpdateWithModel:` 后保存原始 rows 引用，再用本页 setter 安装过滤副本；触发解锁重建时以保存的原始 rows 或新模型恢复。新 `onFTSContactSearchFinish:` 会从 manager 获取结果并构造新 section model，再 `reloadListWithDataUpdate:`，因此覆盖 didUpdate 比全局截断任务结果更清楚。

`FTSBaseSectionController.numberOfItems`（`0x101699820`）消费 `numberOfSearchItems`、`maxDisplayItemsCount`、`hasFoldButton`，原生标题/折叠布局应继续工作。还要确保“更多 n 条”和 model 的 `searchItemCount` 使用显示语义。

`FTSTopHitsSectionController` 有本页 `topHitItems/setTopHitItems:`。数据数组是异构的：反汇编包含 feature、小程序、微店、视频号、setting、客服与普通联系人分支。只能对证实是 CContact 等携带结构化身份的项匹配密友，不要把所有条目的 `key` 当微信 username。普通联系人分支在 `0x1017fb414` 读取 `m_nsUsrName`。

### 聊天记录 split 显示映射

| selector（FTSMessageSectionController） | 编码 | IMP |
|---|---|---|
| `displayedMgrSessionIndexes` | `@16@0:8` | `0x101797cf8` |
| `displayedSessionUserCount` | `Q16@0:8` | `0x101797e58` |
| `mgrSessionIndexForDisplayedItemRow:` | `Q24@0:8q16` | `0x101797db4` |
| `sessionUsernameForDisplayedItemRow:` | `@24@0:8q16` | `0x101797eac` |
| `sessionMsgItemsForDisplayedItemRow:` | `@24@0:8q16` | `0x101797fec` |

`displayedMgrSessionIndexes` 调用 `FTSFeatureMessageSplitter.sharedInstance` 的 `regularSessionIndexesForQuery:taskKey:` 返回索引数组。`displayedSessionUserCount` 对它取 count；`mgrSessionIndexForDisplayedItemRow:` 取数组中的 NSNumber.uintValue；后两项经映射向 `FTSMessageMgr` 查询 username/消息列表。

`FTSMessageMgr` 中真实接口：

- `getSessionUserCountForQuery:taskKey:`，`Q32@0:8@16@24`。
- `getSessionUsernameForQuery:atIndex:taskKey:`，`@40@0:8@16Q24@32`，`0x101792d18`。
- `getSessionMsgItemsForQuery:atIndex:taskKey:`，`@40@0:8@16Q24@32`，`0x101792cb4`。

推荐在页面 getter 取原始映射后，按原始 manager index 解析 username，过滤映射副本；**不要重新排列/删除 manager 的底层结果**。这样 count 与 cell/点击的 session lookup 共用一个可见映射。必须保存原始索引数值而不是过滤后重新从零编号。

限制：`numberOfSearchItems`（`0x101795d6c`）明确先检查 `splitEnabled` 和 `model.data isKindOfClass:FTSMsgSearchResultWrap`，只在匹配时用 `displayedSessionUserCount`；另有 `isTalkerEntryEnabled` 的特殊行。非 split 时调用原 model.data 的 `getResultCountForDisplay`。所以只 hook displayedMgrSessionIndexes **不等于聊天记录搜索完整覆盖**。

非 split 的可选方向是将页面的 `_TtC6WeChat14FTSSectionData` 构造为拥有展示用 wrapper 的副本，再交给本页；该类真实存在 `initWithType:data:searchItemCount:`（`@40@0:8Q16@24q32`）、`data/setData:`、`searchItemCount/setSearchItemCount:`。不能直接改原 model.data，也不能仅删 arrSessionResult 而遗漏 dicSessionResult/arrMsgItems/dicClusterSubResults。

另一个未完全闭合的点是普通群内密友发送者命中：session username 仍是普通群，需要从实际消息 item/wrap 解析结构化发送者。若只是昵称出现在任意正文里，本次证据不支持可靠过滤。talker 入口、智能搜索、媒体聚类/深层“查看更多”需单独补齐和验收，不能以这一映射代表所有搜索。

## 4. 标签成员：保留真实标签，过滤派生分组

`ContactTagData` 在样本中真实继承 `ContactTagItem`，继承 `m_uiID`、`m_nsName`、`m_uiIndex`，自身 `m_arrContactNameList` 是 NSArray；旧头文件把它显示为 NSObject，丢失继承信息。

`ContactTagNewDetailViewController.reloadDataAndView`（`v16@0:8`，`0x10105f9ec`）先清空 `_contactsKeyArray`、`_contactsDict` 和成员显示源，某分支会调用 `ContactTagMgr.getContactsForTagName:` 并设置 `contactTagData.m_arrContactNameList`。随后使用完整名单 count 设标题，再解析联系人，调用 `processContactSectionData:`（`0x10105fdd8`）、`sortTagContacts` 和 table reload。

`processContactSectionData:`（`v24@0:8@16`，`0x101061468`）只做 `fixContactFullPyAndParseContactKey:` → `addContactSectionKey:` → section-array `safeAddObject:`。这是可在页实例范围跳过隐藏成员的派生结构入口，避免篡改业务名单。

| 路径 | 真实方法/地址 | 行为 |
|---|---|---|
| section 数 | `numberOfSectionsInTableView:`，`q24@0:8@16`，`0x1010617a4` | 读取 `_contactsKeyArray.count` |
| 行数 | `tableView:numberOfRowsInSection:`，`q32@0:8@16q24`，`0x1010617bc` | key → `_contactsDict[key]` → count |
| cell | `makeMemberContactCellContent:WithIndexPath:`，`v32@0:8@16@24`，`0x101062100` | key/row 取联系人，交给 `makeMemberContactCellContent:contact:` |
| 点击 | `onClickContactItemCellWithIndexPath:`，`v24@0:8@16`，`0x101062cd8` | 同一 key/row 取联系人并设置新资料页的 m_contact |
| 删除 | `handleDeleteContactAtIndexPath:`，`v24@0:8@16`，`0x101061ebc` | 同一 key/row 取联系人，再调用 `doRemoveTagMembers:` |

这也证明单改行数/隐藏 cell 会删除错误联系人。派生字典过滤后原生点击/删除对象仍一致，但**整体编辑提交不能用过滤后的展示成员数组覆盖真实标签**。`curMemberContactList` 和 `contactTagData.m_arrContactNameList` 应完整保留，提交只合并用户对可见项的明确变动。

标题在 `0x10105fbb8` 使用完整 count，末尾空态判断也未必使用过滤字典；需在重建结束后用可见计数更新标题、emptyView 和 table visibility。搜索可能使用完整 curMemberContactList，必须另加本页结果过滤；本次没有证明单 hook processContactSectionData 能覆盖标签搜索。

标签列表 `ContactTagListViewController.makeContactItemCellContent:withTagData:searchText:`（`v40@0:8@16@24@32`，`0x10104915c`）明确调用：`m_arrContactNameList.count` → `setMemberCountText:`；还调用 `setMemberListText:`、`setMemberListAttributedText:`、`setShowMemberList:`、`getMemberDesc:`，最后 `setTagData:` 和 `updateView`。应更新 cell 的展示字段，保留其真实 tagData。切勿把展示 clone 当作随后编辑/发布的 tag 模型。

“谁可以看”的成员/标签提交及动态标签 ACL 必须继续采用主方案的原始值 + 可见变化合并规则。本次仅核对标签展示，没有把发布权限修改接口当成隐藏入口。

## 5. 资料页：假入口必须截断真实业务动作

真实类型和关系：`ContactInfoViewController : MMUIViewController`，`m_contact` + `m_oContactInfoAssist`；`WeixinContactInfoAssist : CBaseContactInfoAssist`，base assist 自身有 `m_contact`。此二者的 `isInMyContactList` 都存在，编码 `B16@0:8`。

- VC `isInMyContactList`：`0x100fb6b10`。
- Base assist `isInMyContactList`：`0x10029ed74`；实际从 CContactMgr 获取联系人，再调用联系人 `isMMContact`，不能全局 hook 底层关系位。
- `WeixinContactInfoAssist.addMsgActionView`：`v16@0:8`，`0x10a94b9c4`。`0x10a94ba30` 检查局部关系 getter；原生此方法会创建 `onNewMessage:`、`onOpenVoipActionSheet:`、`onSayHelloToContact`、`onAddToContacts`、`onVerifyContactOk` 等不同按钮分支。
- `initFooterView`、`initFooterBtnArea`、`initFooterStackView` 和 `reloadTableView` 会重建展示；不能只在 viewDidLoad 改一次标题。

可行的实现约束：由受保护资料 VC 关联其 assist，按账号+username+锁定态标记；仅在该页面渲染/重建范围令 `isInMyContactList` 呈现 NO，且对好友操作 section 做明确替换，确保不走其他“打招呼/验证”分支。呈现本地“添加到通讯录”按钮，回调由插件处理，不外发好友申请、不真的删除好友、不发消息。解锁后清除展示覆盖，调用原生页面/assist 重建。

真实危险动作已有静态证据，必须阻断伪入口落入这些方法：

| selector | 编码 | IMP |
|---|---|---|
| `WeixinContactInfoAssist.onAddToContacts` | `v16@0:8` | `0x10a950f94` |
| `WeixinContactInfoAssist.doSendVerifyOrAddContact` | `v16@0:8` | `0x10a951830` |
| `WeixinContactInfoAssist.doAddContact` | `v16@0:8` | `0x10a954854` |
| `ContactInfoViewController.onAddToContact` | `v16@0:8` | `0x100fbecc4` |
| `CBaseContactInfoAssist.onAddToContacts` | `v16@0:8` | `0x10029f478` |

`WeixinContactInfoAssist.onAddToContacts` 会重新读取真实好友状态，随后存在 `tryAddContactByPreFetchVerifyTicket`、`goToAddContactWhenHadContactVerify`、`doSendVerifyOrAddContact` 分支（`0x10a95132c/0x10a951340/0x10a9514c8`）。因此“关系 getter 假装非好友”并不能保证原生按钮无副作用。UI 的本地 target-action 应优先换掉，另对已标记 protected assist/VC 的上述入口做防御，不影响普通联系人。

顶部菜单、手势/VoiceOver、旧 view controller 回栈也可能进入好友动作；受保护状态在 action 执行前再次判断。这里不建议把本次仅静态确认的局部 getter包装成全局非好友逻辑。

## 6. 附：所有朋友圈分组/部分人可见图标（独立展示偏好）

用户已经确认范围是所有此类图标，与密友名单无关；真实朋友圈可见权限保持原样。

最小当前版本候选：

- `WCTimeLineCellView.initPrivacyButton:`，`v24@0:8@16`，`0x10a072ecc`。
- ivar `m_privacyButton : MMUIButton`（offset 地址 `0x120274078`，动态读 ivar，不硬编码 offset）。
- `onShowGroup`，`v16@0:8`，`0x10a064bc4`；它从 `timelineCellViewDelegate` 调用 `onWCTimeLineCellViewShowGroup:` 并传原 `m_dataItem`。
- `layoutSubviews`，`v16@0:8`，`0x10a088924`；`accessibilityLabel`，`@16@0:8`，`0x10a09538c`。

`initPrivacyButton:` 会设置图标、touchInsets、accessibilityIdentifier；末尾 `removeAllTargets` 后，对当前用户的动态绑定 `onShowGroup`，再 addSubview（`0x10a073510–0x10a073584`）。

布局不是按 hidden 判断：`layoutSubviews` 在 `0x10a089850` 取按钮，发送先前装载的 `superview` selector（`0x10a0895cc`），若有父视图就在 `0x10a089874–0x10a089894` 设置位置，并把游标推进到按钮右边 + 8pt。**仅 hidden=YES 仍会占位。**可靠的展示处理是在 init 完成后、原生 layout 前把按钮从父视图移除，同时 `userInteractionEnabled=NO`、`isAccessibilityElement=NO`、`accessibilityElementsHidden=YES`，并在开关开启时让 onShowGroup 不继续转发。不要清掉 WCDataItem 的 sharedGroupIDs/isPrivate/ACL。

关闭偏好后让原生 `initPrivacyButton:`/更新路径重新装配目标、图标和父子关系，避免恢复一个仍无 target 的旧按钮。若祖先自定义 accessibilityElements 曾缓存该按钮，还需移除缓存项/重建无障碍元素列表。当前 accessibilityLabel 有独立拼接流程；本次限定检查没有发现直接发送 privacy/group selector，但这不证明所有本地化/父层描述都无分组提示，仍需 VoiceOver 实测。

## 仍需落实的验收与不确定项

1. 运行时签名核对（尤其 `B`/`I`/`q`/`Q` 和 out-object 指针）及类继承；禁止按旧头文件猜 ABI。
2. 通讯录普通列表、星标、标签搜索、普通/企业/群选择、转发置顶折叠与最近横排，各自 count/cell/click/long press 一致。
3. FTS 首页与详情、异步回调、split 开/关、talker 特殊入口、群内发送者、智能搜索和媒体聚类分别验证；本文明确的映射只覆盖其中部分。
4. 标签隐藏只改变展示；原始标签和朋友圈发布 ACL 的任何编辑需做前后等价/可见变动验证。尤其“不给谁看”不能因过滤漏掉隐藏成员。
5. 资料页伪“添加”点击、VoiceOver 和旧界面回栈不产生任何好友申请/消息请求；解锁恢复原生操作，但通知静默继续独立生效。
6. 以账号标识、策略 revision、锁定态、查询 taskKey 标记快照；异步过期结果不可把密友重新插入页面。锁定时先失效旧快照并刷新可见页面，原生服务缓存保持完整。

本报告提供已证实的静态接入边界和覆盖缺口，不将“selector 存在”“编译成功”或“模拟数据测试通过”表述为真实账号工作流已通过。
