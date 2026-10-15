# 列表圆角与会话分组的本次集成

本次任务只调整 `Hooks/ListCornerRadiusHooks.xm` 主会话 `styleCell` 的首尾判断，调用分组适配器导出的 `CSGroupCardPosition`。该函数按当前调用的原生/显示坐标域找到投影行，返回当前 section 的首行、末行；只有一行时两者同时为真。没有分组适配器或投影不生效时，沿用既有原生 section 行数判断。其他页面样式方法未重构。

分组 Hook 已移除重复绘制圆角、缓存可见首尾行、隐藏 Cell 和极小行高的实现。当前组的真实行数、角标、首尾角色来自同一个投影，避免两个自定义组共用按类型缓存的首尾行。

实际代码位于 `Hooks/ListCornerRadiusHooks.xm`、`Controllers/CSGroupListAdapter.h/.m` 与 `Controllers/CSGroupProjection.h/.m`。本工作区没有 `CSListCardRenderer`、`CSListCornerRadiusConfig`、`CSListCardRowContext` 或 `Tests/verify-list-cards.sh`，不将早期记录中对这些文件或 15,600 个几何场景的描述作为验证证据。已有的 `Headers/CSListCardGeometry.h` 保留，未纳入此次集成。

实际验证使用：

```sh
bash Tests/verify-session-groups.sh --check-ios
```

这包括生产投影/路径边界测试、Logos 生成、修改 Hook 的 arm64 和 arm64e 编译，以及另行执行的完整 rootless/rootful Release 打包。没有目标微信 UIKit 渲染或实机点击证据。

仍需验证分组首尾和单行圆角、空 section、置顶变化、Fake 列表转真实列表、搜索往返、浅深主题、横竖屏、原生选中/侧滑、关闭分组后的恢复。没有在本次任务中承诺四个页面所有既有圆角细节已被重构。会话分组完整实现和限制见 [会话分组说明](session-groups.md)。
