# 1.8-49 回退记录

用户报告 1.8-49 解锁后进入朋友圈卡住、无法滑动或返回，并明确要求回退至 1.8-48。

已在既有 `codex/close-friends-148` 工作区恢复 1.8-48 的生产代码、测试、版本号、发布说明与 README，目标提交为 `01aaef8cee2e8f920eddf715a279df55247d76f9`。1.8-49 的时间线布局刷新和资料页入口变更均撤回，保留原提交历史和已交付安装包。

验证：1.8-48 source-manifest 中 465 个文件的 SHA-256 全部匹配；Controllers / Hooks / Headers / Tests / Makefile / control / README / 注入 plist 与目标提交无差异。此次没有新增修复，也未重复构建或运行未修改代码的回归。

原项目 `packages/com.wechat.improve_1.8-48_iphoneos-arm64.deb` 版本和 SHA-256 已核对：`0114f0ed42294c8aeb27af4b6b57a7006c5c7bd4cd66197a52dd44d2e3432eb6`，大小 1112328 字节。沿用该原始包回退，未覆盖重打。

原共享目录 main 分支保持 `929d265b`；本次源码回退发生在既有开发工作区。现有 .theos 构建缓存保留，不作为回退交付产物。手机尚未安装回退包。
