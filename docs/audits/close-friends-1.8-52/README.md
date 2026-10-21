# 解锁后朋友圈首屏黑区修复 · 1.8-52

基于 1.8-51（`28a458ec`），处理解锁密友后进入朋友圈，部分区域黑屏、拖动后才恢复的反馈。只修改主时间线展示适配及版本说明。

## 录屏与原因

已读取用户 8.29 秒录屏，文件身份见 `recording.json`。约 2–3 秒进入朋友圈时，旧位置的一条动态显示正常，下方为大片黑区；拖动后，多条动态与互动内容恢复。采样图保存在 `recording-frames.jpg`。录屏能确认缺失发生在首屏展示，不能单独确定具体的黑色 UIView/CALayer。

代码与微信 8.0.78 静态证据确认两处刷新缺口：

1. 原先策略通知清理高度/展示缓存后，递归调用页面内表格与集合视图的 `reloadData`。它跳过微信时间线的 `reloadDataWrap`，后者还会设置 `_isReloadingData` 并清理原生延迟行刷新记录。解锁后新增的动态及互动需要同步完成这条原生刷新链路。
2. 行数、行高、创建单元格使用过滤后的列表，但 `tableView:willDisplayCell:forRowAtIndexPath:` 没有进入相同投影。静态证据确认该回调仍通过 section 计算索引并调用 `getTimelineDataItemOfIndex:`，还参与显示缓存与布局；隐藏成员位于前面时，它读到的原始数据会与单元格对应项不同。

这些缺口与“滚动触发后续显示流程后恢复”的现象一致。未取得手机进程的视图层次/调用栈，具体黑色图层和最终修复视觉效果仍需真机验收，不能由主机测试替代。

## 修改

- 页面即将出现时，按当前账号与策略版本清理投影/高度/展示缓存，调用一次原生 `reloadDataWrap`；方法不可用时只刷新所属时间线表格。
- 后台页面收到策略通知时只使缓存失效，回到页面再刷新；正在显示的页面立即刷新。同一策略版本、重复 appearance/通知以及刷新中的重入均不会追加原生刷新。
- 将 `willDisplayCell` 纳入与行数、行高和内容相同的投影，保留原始业务数据及原生显示回调。
- `viewDidAppear` 仅作尚未准备好的页面的补充入口。同一版本已经处理时直接返回。

1.8-49 的强制布局逻辑没有恢复。该版本在 `reloadDataWrap` 中标记布局、在 `viewDidLayoutSubviews` 中再次强制布局，而微信原生 `viewDidLayoutSubviews` 本身会请求列表刷新，静态上存在反复触发布局/刷新的路径。本版不 Hook 这两个方法，不调用 `layoutIfNeeded` 或手动模拟滚动，由 UIKit 完成原生渲染。

## 验证与交付

- `bash Tests/verify-close-friend-social.sh` 通过。执行真实投影、生命周期 Hook 和显示回调包装，覆盖首屏原生刷新、过滤后显示索引、离屏解锁后再进入、解锁/重锁、重复通知与重入、停用、旧账号，以及既有互动/发布选择逻辑。硬件与 UIKit 像素渲染未由 fixture 模拟。
- `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-52`：arm64 / arm64e，最低 iOS 15.0。构建和包校验记录见 `build-result.json`、`validation.json`。
- 生产范围与保留文件摘要在 `scope.json`。未重复运行未改动的摇动、通话、搜索、资料页及个人朋友圈专项。

开发和构建仍使用 `/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove`、`codex/close-friends-148` 分支。交付包为原项目 `packages/com.wechat.improve_1.8-52_iphoneos-arm64.deb`，原项目 main 源码和旧安装包保留。没有安装到手机或操作实际微信数据。

真机重点复验：完全退出重开微信，锁定密友进入朋友圈后返回；长按解锁后再次进入，停留不滑动，检查首屏内容完整且能正常返回。随后在锁定/解锁状态各重复一次。
