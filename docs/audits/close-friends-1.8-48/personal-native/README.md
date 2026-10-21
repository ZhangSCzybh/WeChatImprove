# 原生个人朋友圈空内容展示

基于本地微信 8.0.78 二进制的只读元数据及有边界反汇编。目标 SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。没有运行微信、读取真实账号数据库或更改好友关系。

- `WCTimelineRouterHelper +navigateToUserPageViewController:contact:scene:thumbnailCnt:source:`（`0x10a1658ec`）读取 `WCFacadeDynamicConfig -Moments_enableFlutterUserPage`（`B@:`）。false 分支创建 `WCListViewController`，传递原联系人、scene、缩略图数和 source，再执行原生导航。路由反汇编保存在同级 `../detail-native/`。
- `WCListViewController -reloadStyle`（`0x109018c48`）从自己的 `m_arrPhotoDatas` 和 `m_starredDataItems` 取数据，创建 `WCListView`。classref `0x1201a7090` 确认为 `WCListView`。原联系人、pageContext、封面配置及其他原生参数原样传入。
- 只在隐藏密友页面构造原生视图期间，将这两组页面私有数组临时替换为空数组，`@finally` 恢复原引用。服务数据、WCDataItem 和真实好友关系不变。原生视图保留联系人 header，生成空动态行。
- 原生 `WCListView -shouldReloadData:starredDataItems:jumpState:prePage:`（`v@:@@BB`）负责后续展示更新。隐藏期间接收空展示数组并结束 jump/prePage 状态；原生 `updateRowsData` 另有同步保护，防止更新或缓存重建恢复隐藏内容。
- `WCListView -onNoMoreDataWithRet:andTip:` 调用 `WCTimeLineFooterView -onStateOfNoMoreData:`。该方法在 `0x10a0aaf70` 调用 `genStandardTerminatorViewWithTip:`；nil tip 使用 `MMTerminatorView` 默认横杠和圆点，无自定义文本和替代页面。隐藏期间也关闭原生“暂无内容”文本，以保留用户截图中的横杠效果。
- 锁定／解锁时，仅对隐藏状态改变的页面调用原生 `reloadStyle`，由完整 controller 数组重建内容与 footer；普通好友页面不为策略刷新重建。不主动调用 `WCListViewController refreshFooter`，该方法会向 Facade 请求下一页。
- 已启用相关保护且名单非空时，通过只读配置 getter 返回原生个人页／主列表分支；临时解锁仍保持相同分支，确保重新锁定可刷新已打开页面。停用恢复原返回值。

`Tests/verify-close-friend-album.sh` 对完整生产 adapter 的 Hook 做 Foundation 定向回放，共 19 项检查：原生 header 身份、空内容／横杠调用、后续数据与 footer 更新、普通好友、解锁／重锁、账户变化、异常时恢复源数组、原生路由选择。UI 替身不证明真机像素布局；横杠位置及原生动画仍需安装包验收。
