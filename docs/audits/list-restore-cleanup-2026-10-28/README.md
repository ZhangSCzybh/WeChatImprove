# 2.1-3 列表恢复代码清理 · 2026-10-28

按用户“清理相关无用代码和调试代码、聚焦核心回归”执行。本轮仅清理现有列表前台恢复逻辑，不增加功能；版本保持 2.1-3，仅源码和编译验证，不发布新包。

## 清理结果

- 删除 ListRestore 临时日志、defaults 诊断开关读取、去重集合和日志原因计算。
- 删除仅供诊断的 lastCanvas、pending、restoredSinceResume 状态。它们原本不承担重试调度，正常布局回调仍会修复有效尺寸下的卡片。
- 将恢复入口的阶段字符串改为 BOOL refreshGeometry；前台/布局回调为 YES，背景 setter 为 NO，避免把功能模式绑定到日志文字。
- 删除全量几何恢复之前仅用于诊断的颜色预扫描和重复尺寸读取；保留 setter 无变化时提前返回。
- 删除测试中启用临时诊断的 defaults 设置；全部行为断言保留。当前使用文档同步说明诊断已从源码移除。

保留生命周期/scene 监听、精确列表归属判断、弱引用、重入保护、setNeedsDisplay/setNeedsLayout、原生布局后修复、有效尺寸检查、连续卡片规则及原有配置取值。未添加数据源查询、reload、滚动位置赋值或定时器。

## 实际验证

只执行 `bash Tests/verify-list-corners.sh` 一次：**1,357 项，0 失败**，其中原有 341 项前台恢复相关断言全部保留。主机替身覆盖首帧、两轮前后台、未读/section 变化、scene、原生覆盖、空组、关闭再开及滚动位置；未作新的真机验收声明。

在独立临时目录完成 rootful scheme 的 arm64 + arm64e 编译、链接，退出码 0。12 条警告均为上一版已存在的弃用 API / 链接选项警告，新增 0。未重复编译 rootless scheme、未执行 package 或 clean。虽复制了已验证缓存，Theos 因构建路径变化实际重新编译了 406 个单架构单元；此事实以构建日志为准。

清理前核对 2.1-3 发布输入 366 项，SHA256 全部一致。清理后 605 项源码/测试/配置跟踪项中仅 5 个指定文件发生改变；`Controllers`、`Hooks`、`Tests` 已无上述诊断标识。

校验此前存在的 packages、历史审计和工作区 .theos 共 **4,624 个文件**，SHA256 全部不变。其中 packages 下 21 个文件均保留，未新增安装包。已交付的 2.1-3 deb / symbols 仍对应清理前的源码，清理后的代码尚未重新打包。

## 证据

- [改动及前后 SHA256](changes.json) · [逐行差异](changes.diff) · [清理前副本](source-before.zip)
- [核心回归日志](list-corners.log) · [测试结果](test-result.json)
- [构建命令和目录](build-environment.json) · [构建日志](build-rootful.log) · [警告与架构核对](build-verification.json)
- [历史产物保护检查](preservation.json) · [完成检查](final-check.json)
