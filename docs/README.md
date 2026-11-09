# 文档索引

当前发布记录：[2.3-4 防撤回蓝字点击入口与原文定位](audits/revoke-jump-2.3-4/README.md)。

2.3-4 同时保留 2.3-1～2.3-3 的发现页外观、添加入口和编辑页布局修复。

## 近期修复与分析

- [2.2-20：清理与交付](audits/release-2.2-20-cleanup/README.md)

- [2.2-19：设置子页原生底栏](audits/release-2.2-19-settings-subpage-tabbar/README.md)
- [2.2-18：返回设置列表的留白](audits/release-2.2-18-settings-return-header-gap/README.md)
- [2.2-17：快捷页完整重置密友](audits/release-2.2-17-quick-entry-closefriend-reset/README.md)
- [2.2-16：密友凭据重置回滚与头像快捷入口](audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/README.md)
- [2.2-15：气泡紧密间距](audits/release-2.2-15-8080-compact-and-closefriend-reset/README.md)
- [微信 8.0.80 适配](audits/wechat-8.0.80-2026-11-05/README.md)
- [设置列表外观差异分析](audits/ui-layout-version-diff-2026-11-06/README.md)
- [原始 18 项回归豁免](audits/release-2.2-20-cleanup/WAIVER.md)与[本轮沿用说明](audits/release-2.2-20-cleanup/WAIVER-CONTINUATION.md)

## 归档规则

保留发布报告、授权、回归日志、红绿证据、测试源码和必要的生产快照。历史 Instruments 原始录制、体积较大的原始导出、重复 HeadersFile 快照、Git 状态快照和编译缓存移至项目外本机归档；原文件没有销毁。具体路径、哈希与恢复方法见 [归档索引](audits/release-2.2-20-cleanup/ARCHIVE-INDEX.md)。安装包仍保留在仓库 packages 目录，本轮不覆盖历史包。

部分旧文档在本轮开始前已经从工作树删除，其已提交版本可在 Git 历史中查看。本轮的清理清单与既有缺失分开记录。历史报告中的数字、豁免与未验证范围保留原意，不把过去结果冒充当前验证。
