# 朋友圈可见范围图标：限定原生证据

目标为既有 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，微信 8.0.78 arm64。2026-10-22 重新计算 SHA-256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。只读解析 Objective-C 元数据，并用既有脚本及 `llvm-objdump` 按真实函数边界反汇编。没有启动微信、操作设备、读写账号数据库或运行服务。REA session 查询显示未打开目标；为了避免对 541 MB 二进制做全量自动分析，复用仓库现成的有边界分析方式，没有打开/关闭原生 REA 会话。

## 已验证的图标身份

- `WCListBaseCellView -initSharedImageView`（`0x108fe74bc`）和 `WCCommentDetailViewControllerFB -createPrivacyBtn`（`0x106e79444`）都把 CFString `0x11e7d3888` 传给 `svgImageNamed:size:color:`。该 CFString 的内容为 **`person_2_filled`**，符合截图中的可见范围小人图标。
- `WCPhotoMutipleImageBottomBackgroundView -initPrivateImageView` 使用 CFString `0x11e5c0128`，内容为 **`lock_filled`**。该 view 与 `WCAlbumPickerCollectionCellView -updatePrivacyIcon` 都依据 `WCDataItem.isPrivate` 设置 `privateImageView.hidden = !isPrivate`。它们是私密锁的补充路径，不能把它们当成截图小人图标的唯一根因。
- 实际元数据中 `WCListBaseCellView` 继承 `MMUIView`，`WCListPhotoCellView` 继承 `WCListBaseCellView`。仓库老 Headers 中的 `NSObject` 父类声明不适合作为当前版本的证据。

## 我的朋友圈列表与缩略图

`WCListCellStatusInfo -showsGroupedStatus` 和 `-showsPrivateStatus` 的 ABI 都是 `B16@0:8`，分别在 `0x108fe8db8` 与 `0x108fe8db0`。它们属于显示状态对象；修改它们的返回值可以控制当前 UI 判断而不改 `WCDataItem` 或发布权限。

以下路径均实际调用这两个 getter：

1. `WCListBaseCellView -initStatusIconImageView`（`v16@0:8`，`0x108fe7290`）：根据状态条件调用 `initSharedImageView` / `initLockedImageView`，还独立处理星标和失败图标。该方法**不会清除已经存在的图标**。
2. `WCListBaseCellView +allStatusIconImageViewWidthWithGroup:groupItem:`（`d32@0:8@16@24`，`0x108fe54d4`）：把显示状态用于图标占用宽度。
3. `WCListBaseCellView -statusIconAccessibilityComponentsWithDataItem:`（`@24@0:8@16`，`0x108fe8068`）：把显示状态用于无障碍可见范围信息。
4. `WCListPhotoCellView -initView` 创建每张图的 `WCListCellStatusInfo`，调用 `WCListThumbViewHelper +updateGenericImageView:withStatusInfo:`（`B32@0:8@16@24`）。helper 按实际 view 类分发给 `+updateSingleImageView:withStatusInfo:` / `+updatePuzzleImageView:withStatusInfo:`（均 `v32@0:8@16@24`）。这两个方法把 `showsGroupedStatus` 直接传入 `showSharedStatus:`，把 `showsPrivateStatus` 传入 `showLockStatus:`，false 也会调用；星标、Live Photo、失败状态独立传递。

缩略图 helper 的 classref 已解析：`0x120179aa8 → WCImageView`，`0x1201a7048 → WCPuzzleImageView`。截图的图片右下角叠加小人图标由这条缩略图路径覆盖，单独处理 `m_sharedImageView` 不足以覆盖图片列表。

`WCListBaseCellView -setGroupItem:inGroup:`（`v32@0:8@16@24`，`0x108fe66bc`）更新 group、groupItem、行数据和 `m_dataItem`，再调用 `initView`、`layoutStatusIconImageView`、`updateAccessibility`。它适合作为刷新跟踪与复用入口。

`WCListPhotoCellView -initView` 开头调用 `initImageGridView`；后者在 `0x108ff56c8` 对已有 `m_imageGridView` 调用 `removeAllSubViews`，再重新挂接容器。随后 `initView` 按当前行数据重建图片和状态。因此在图标隐藏策略变化时，通过当前 cell 的原生 `initView` 重建，能让当前 getter 策略重新作用于已有缩略图。

对于基类的 `m_sharedImageView` / `m_lockedImageView`，需要额外移除或隐藏已有实例。`initSharedImageView` 有实例就复用并 `addSubview:`，不会重置 hidden；退出隐藏状态必须配套恢复，而不能只调用该方法期待自动恢复。`layoutStatusIconImageView`（`v16@0:8`，`0x108fe775c`）在占用宽度前检查图标存在、superview 存在且 `!isHidden`；隐藏或移除不会再扣减该图标的 `width + 4`。

## 朋友圈详情

精确 ABI：

| 方法 | ABI | 地址 |
| --- | --- | --- |
| `-canShowPirvacyButton`（原生拼写如此） | `B16@0:8` | `0x106e875cc` |
| `-createPrivacyBtn` | `@16@0:8` | `0x106e79444` |
| `-initTableHeaderView` | `v16@0:8` | `0x106e7cc04` |
| `-_recreateExtensionViewsInTableHeaderView:` | `v24@0:8@16` | `0x106e7f674` |
| `-layoutActionArea` | `d16@0:8` | `0x106e87648` |
| `-actionAreaSubViewWithType:` | `@24@0:8Q16` | `0x106e8817c` |
| `-onShowGroup` | `v16@0:8` | `0x106e8fc1c` |

`_recreateExtensionViewsInTableHeaderView:` 开头调用 `_cleanExtensionViewsInTableHeaderView:`。clean 在 `0x106e7f2ec–0x106e7f304` 移除 `_privacyBtn` 并写 nil。之后，recreate 在 `0x106e7fcdc` 调用 `canShowPirvacyButton`；true 才调用 `createPrivacyBtn`，将返回对象保存为 `_privacyBtn`，并添加到 header。因此抑制显示 predicate 后通过原生 header 重建可移除旧图标，恢复 predicate 后可按原生逻辑重新创建。

`createPrivacyBtn` 返回真实按钮对象而不是 void；本人朋友圈时绑定 `onShowGroup`，并设置原生 accessibility label。不要把返回值误当 void，也不应返回 nil 再交给原生无条件 `addSubview:` 链。已创建对象可额外设置 hidden、不可点击及隐藏无障碍入口。

`actionAreaSubViewWithType:` 的 type 5 返回 `_privacyBtn`。`layoutActionArea` 使用原生布局对象生成的 `layoutInfoMap`，再给相应 view 设置位置和宽度；图标 hidden 不保证单独消除模型计算的间距。本次需求是图标隐藏，若不扩展完整布局模型，不应声称已消除所有可能的留白。该方法返回 double，hook 必须保留返回值。

`initTableHeaderView` 的完整直接调用链为：创建 header → recreate main views → recreate extension views → layout header → setTableHeaderView → layout header subviews。限定反汇编中未发现发布、修改可见范围或数据库写入的入口。这个结论是 UI 重建入口的静态证据，不是证明其所有图片/广告子视图绝对不会读取资源或发送展示埋点的完整调用图审计。

## 原生与 Flutter 路由

- `WCTimelineRouterHelper +isFlutterDetailEnabled`（`B16@0:8`，`0x10a166404`）读取 `WCFacadeDynamicConfig -Moments_enableFlutterDetail`（`B16@0:8`）。此前的 `../../close-friends-1.8-48/detail-native/` 证据已验证两个 `navigateToCommentDetailViewController:...` helper 在 false 分支创建 `WCCommentDetailViewControllerFB`。
- `+navigateToUserPageViewController:contact:scene:thumbnailCnt:source:`（`v48@0:8@16@24I32I36@40`，`0x10a1658ec`）读取 `WCFacadeDynamicConfig -Moments_enableFlutterUserPage`（`B16@0:8`）；false 分支为原生 `WCListViewController`。
- 只开启“隐藏全部朋友圈可见范围图标”、名单为空时，也必须纳入对应路由条件，否则仍可能进入未覆盖的 Flutter UI。无需写入动态配置；按启用条件覆盖只读返回值即可，关闭后恢复原返回值。

## 边界与未知

截图本身无法证明设备使用原生还是 Flutter 页；本目录证据只证明 8.0.78 的原生类、方法 ABI 和上述静态调用路径。没有验证手机上当前安装版本、实际页面 routing、动态子类替换或屏幕最终像素。Flutter/Dart 直接绘制路径未逆向，个人页或详情已在 Flutter 中打开时的即时迁移也未验证。生产实现仍需 host 回放及 iOS 编译验证，并把真机截图验收与静态证据区分。

可重跑 `extract.py` 与 `disassemble.py`。`methods.json` 是所选类元数据，`metadata.json` 包含对象 ivar 类型，`manifest.json` 记录目标与方法范围；全部已保留方法体均未截断。请用运行时名字查询对象 ivar，不要把本报告的数值偏移写入生产代码。
