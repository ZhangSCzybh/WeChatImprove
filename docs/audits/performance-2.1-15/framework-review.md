# 2.1-15：朋友圈详情、折叠分组和通讯录索引

本记录覆盖本轮批准的性能优化第 1、2、6 点。只调整展示时的计算范围；不更换账号、不写微信消息/关系/未读、不启动服务或数据库，也不改变打包方案。完整版本说明和最终安装包由本轮发布任务统一管理。

## 朋友圈详情

`Controllers/CSCloseFriendDetailAdapter.m` 在页面仍属于当前账号、当前策略没有隐藏互动时，直接由微信原生代码读取和维护原数组。插件保留用于动作绑定的 item/revision 元数据与原有刷新机制，跳过数组扫描、社交投影和临时数组替换。没有替换数组的回调结束后不会恢复旧引用，因此原生代码在回调内更新的数组仍然有效。

隐藏互动时仍逐元素核验源数组，不按同一个 mutable pointer 判定内容未变。旧账号页面继续显示空互动；需要替换数组的路径仍通过 `@finally` 还原，点击仍以实际对象和源下标映射。

主机回归使用真实生产 Hook 主体：143 项通过。新增行为覆盖 100 次原生 count 回调的源元素读取和投影构造次数均为 0、原地替换/重新锁定、同指针同长度源变更、原生数组引用替换和异常后恢复。日志：`framework-detail.log`。

## 折叠分组

`Controllers/CSGroupListAdapter.m` 保留用于选择最终可见摘要候选的第一个完整 child projection。原生 bridge 仍仅格式化该候选，随后通过 `CSGroupProjection` 的不可变摘要替换方法附加正文和名称前缀。

摘要替换必须命中最新可见 session，且路径、用户名、类别、置顶、未读、红点和排序元数据一致；隐藏行、较旧候选和元数据变化均拒绝。仅复制目标所在的输入/展示 section 与外层数组，共享已验证的映射、归属、计数及角标。原投影不变；最终发布的账号、epoch 和策略 revision 校验保留。

测试在临时副本的完整生产构造器中计数：一次折叠发布从两次完整 child projection 加一次 parent，变为一次 child 加一次 parent（共 3→2）；摘要替换不调用完整构造器。真实 bridge/adapter/session 回归 155 项、原生展示 44 项、分组角标 136 项通过。覆盖既有分组归属、全部隐藏、原生摘要来源、格式化期间账号/策略变化，以及新增的不可变替换与计数/映射保持。日志：`framework-session.log`、`framework-group-badges.log`。

## 通讯录索引的同步读取范围

仅为 `ContactsViewController.mmsectionIndexTitlesForTableView:` 的已绑定主表建立同步读取范围。不覆盖整个 reload、numberOfSections、逐行 cell、一般转发选择器或跨事件读取。

宿主依据是仓库已有的微信 8.0.78 反汇编：

- `docs/audits/close-friends-1.8-42/surface-native/ContactsViewController--mmsectionIndexTitlesForTableView_.asm`
- `0x1010edbb8` 和 `0x1010edc08` 两次调用 `getKeysArray`。
- 两次调用之间只对第一次结果取 `count`，并向新创建的本地数组追加索引标记；没有对 `ContactsDataLogic` 的源写入、重载或异步操作。
- `numberOfSectionsInTableView:` 实际只调用一次 keys；`getContactCount` 的原生实现直接读取 ivar。它们未被纳入新增范围。

先验证运行时方法 ABI，并验证线程、主表、logic 和 delegate 关系。第一次 keys 读取仍完整核验原生 keys 和各 section；同一个同步索引回调内第二次读取复用该投影，因此完整核验次数为 2→1。范围通过 `@finally` 退出；意外嵌套会清除外层的已缓存投影，外层恢复后重新核验。不增加 TTL 或猜测性模型 mutation hooks。范围外 keys/count 的原有完整源核验保留。

每次读取继续校验策略 revision、accountID 和 epoch；完整源读取期间发生账号/策略变更则不发布刚读取的旧结果。联系人缓存本身也要求账号与 revision/epoch 一致。临时显示仍按原生索引返回。

新增测试直接编译生产缓存、keys/rows、索引 Hook 和原生 surface 判定，16 项通过：双 keys 仅一次完整核验、范围外每次核验、下次读取发现同指针同长度源变化、无关表不复用、账号/epoch/revision 变化、异常和意外嵌套清理、读取期间切账号返回空、源数组保持及临时显示。原联系人/转发/资料页/搜索回归也通过。日志：`framework-contacts-read.log`、`framework-contacts-regression.log`。

## 编译与边界

上述 Objective-C 生产文件及经 Logos 预处理的联系人 Hook 已通过 arm64、arm64e 的 iOS 15 语法编译。日志：`framework-ios-syntax.log`。本轮未执行真实设备 UI 验收；结果证明代码路径与计数行为，不宣称真机帧率或整页耗时改善。最终双方案完整编译由主发布流程执行。
