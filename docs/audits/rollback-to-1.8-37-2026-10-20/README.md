# 回退至 1.8-37（2026-10-20）

按用户要求撤回 1.8-38 的备份界面调整，源码恢复至已交付的 1.8-37。保留 1.8-37 的完整备份、恢复事务及其所有既有改动。

恢复两个备份页面、版本 header、control、更新说明和 README；移除 1.8-38 新增的 `CSSettingsAppearance.h/.m`。六个恢复文件与界面调整前的 SHA-256 完全一致，1.8-37 源码清单的 254 个文件全部匹配，界面调整前记录的 293 个文件全部匹配。

已通过两个页面的 iOS arm64 严格语法检查、备份引擎 22 项检查和 `git diff --check`。源码与原 1.8-37 产物记录完全匹配，复用已经验证的 1.8-37 安装包，没有重复构建或运行无关全量回归。

- [回退核对](verification.json)
- [检查结果](check-results.json)
- [备份引擎日志](verify-backup-engine.log)
- [回退前 1.8-38 源码归档](source-before-rollback-1.8-38.zip)
- [1.8-37 Rootless 安装包](../../../packages/com.wechat.improve_1.8-37_iphoneos-arm64.deb)

历史 1.8-38 安装包和审计记录保留；当前源码和 README 指向 1.8-37。未执行 Git reset、make clean、手机安装、服务切换或真实微信数据操作。
