# Preferences 存储迁移：微信原生清理规则核验

## 结论与范围

对已分析的微信 **8.0.78** 样本，迁到 `Library/Preferences/WeChatImprove/BackupV2` 和 `Library/Preferences/WeChatImprove/CloseFriends` 可避开已确认的“未知文件”清理链：两个目录及其普通文件会递归继承 Preferences 的 `{bizType=33, storeTimeType=1, wechatFileClass=4, fileTypeInUse=0x7fffffff}`，`deleteFile:...` 的可删除标志保持 0，不进入 `DeleteBizFile:` / `DeleteBizUnknowFile:`。这是静态控制流结论，不是对用户真机删除者的运行时取证。

空目录不是永久保留：本样本可清理已空且超过约 14 天未变化的 Preferences 子目录；正常存在文件的目录不满足这条入口条件。该行为不构成删除已有备份的路径。

目标 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。本次复用 `../backup-deletion-2026-10-24/native/` 已保存的规则、元数据和反汇编，仅补齐目录标记、空目录判断及其调用者的有界反汇编，没有重跑完整规则分析或开启新的 native 会话。

## 1. 完整编译规则与覆盖规则

既有 `compiled-path-rules.json` 包含 1046 条完整规则；重建方法、字段布局和全量字节检查见 `../backup-deletion-2026-10-24/native/path-rule-findings.md`。

| 字段 | index 112 |
|---|---|
| relativePath | `Library/Preferences` |
| pathPrefixType | 1，应用容器根目录 |
| bizType | 33 |
| storeTimeType | 1 |
| wechatFileClass | 4 |
| fileTypeInUse | `0x7fffffff` |
| path CFString | `0x11e66f408` |
| 初始化路径指针的指令 | `0x1029a3c78` |

完整表中只有这一条包含 `Preferences`；没有 Preferences 的具体子规则，也没有 `WeChatImprove`、`BackupV2` 或 `CloseFriends` 的规则；没有 `Library/<reg>...` 的直接子级正则规则。根层 `<reg>.*WeChat.*` 只匹配根目录的一个路径分量，不能覆盖 Preferences 内部的路径。

`addPathComponent:withRule:toRootNode:supportModify:` 在 `0x10299f4d8` 判断是否最后一个路径分量，只给最终节点赋业务分类（`0x10299f4f0` 等）。因此这里是 Preferences 本身被标记，随后向下继承；不是仅因存在某个被标记后代便假定所有祖先受保护。

## 2. 目录及文件的递归继承

`+[MMDiskBizUsageHandler matchBizWithChildFolder:parentFolder:]`（`0x1029a010c`）先读取父目录四项分类及 `isMarkFolderWrap`，再按当前子目录 `lastPathComponent` 匹配即时子规则。具体规则节点已标记时 `0x1029a0364..0x1029a03f0` 将其分类写入目录。

没有匹配子规则、而父目录已标记时，`0x1029a0300` 进入 `0x1029a0304..0x1029a034c`，复制父目录全部四项分类；该路径不要求父目录保有一个非空 `m_bizMatchNode`。匹配到未标记的中间节点时，也可在 `0x1029a0414..0x1029a0454` 继承父分类。

新增证据 `MMFolderWrap--isMarkFolderWrap.asm`（`0x1029ad254`）确定标记条件：

- `m_onlyBizType >= 3`（`0x1029ad270`）；
- `m_onlyFileTypeInUse != 0x7ffffffe`（`0x1029ad288..0x1029ad290`）；
- `m_onlyWeChatFileClass > 0`（`0x1029ad2a4`）。

Preferences 的 `{33,1,4,0x7fffffff}` 满足条件，复制后的 WeChatImprove、BackupV2、CloseFriends 也继续满足，因此继承可递归进行。

`+[MMDiskBizUsageHandler fileMatchedBizType:inFolder:]`（`0x1029a0568`）未匹配具体文件规则时，在 `0x1029a070c` 调用 `isMarkFolderWrap`，为真则于 `0x1029a0718..0x1029a0764` 将目录四项分类写入返回结构。规则表没有这些目录的后代覆盖规则，故 `.wcbak`、plist 以及更深层普通数据文件均继承同一分类，不取决于扩展名。

## 3. storeTimeType=1 绕过文件删除

`-[MMDiskUsageScaner deleteFile:matchInfo:inFolder:withScanConfig:fileSize:logicFileSize:latestTimeInterval:]`（`0x1029c27f0`）读取分类结构 `+8` 的 storeTimeType。

1. `0x1029c2934..0x1029c2938` 对值 1 跳转 `0x1029c29a0`，将期限判断开关 `w24` 和期限 `w28` 清零；`0x1029c2a24` 将可删除标志 `w9` 清零，存于 `[sp+0x6c]`。
2. `0x1029c2b20` 因 `w24=0` 绕过按文件时间重新设置可删除标志的分支。`m_isDeleteExpireFileForDebug` 仅改变期限值，不会把此开关或可删除标志重新置 1。
3. `0x1029c3100..0x1029c3104` 读取仍为 0 的可删除标志，进入 `0x1029c3164` 返回未删除；后续 `m_isDelete`、`m_isDeleteUnknow` 和删除调用不会执行。
4. `DeleteBizUnknowFile:` 调用位于 `0x1029c3148..0x1029c3150`，`DeleteBizFile:` 位于 `0x1029c31bc..0x1029c31c4`，两者均在该门槛之后。紧急级别提高也不会改变 time1 分支的 0 标志。

因此对本条扫描链，可精确说“文件不会被删除”，不能简化成“该路径完全不会被扫描”。

## 4. 空目录清理边界

新增 `MMDiskUsageScaner--scanFolderBegin_withParentPath_withScanConfig_withScanStat_depth_.asm` 显示：`0x1029be99c` 获取子目录及文件后，`0x1029be9ac` 查询 `isEmptyFolder`；非空在 `0x1029be9b0` 跳过删除入口。只有为空，且 `isDeleteEmptyFolder` 开启（`0x1029be9c0..0x1029be9c4`），才在 `0x1029be9e0` 调用 `handleDeleteFolder:withFolderPath:withScanStat:`。

新增 `MMFolderWrap--isEmptyFolder.asm`（`0x1029ad8e0`）要求 `bStatOK` 为真、`m_arrChildFolder.count == 0`、`m_arrNotScanFileName.count == 0`。统计失败会返回非空，不会因一次统计失败直接触发目录删除。

`handleDeleteFolder:...`（`0x1029be55c`）取访问/修改/变更/创建时间中的最新时间。time1 仅在 class2 或 class5 时额外免删（`0x1029be600..0x1029be634`）；Preferences class4 不满足这项额外豁免。最新时间有效且距扫描开始达到 `0x127501 = 1,209,601` 秒（14 天加 1 秒，`0x1029be684..0x1029be690`）后，可调用 `DeleteBizDir:`。

这意味着迁移后“长期没有数据的空目录被删除再按需创建”仍可能发生。创建备份成功后真实非空的目录不走此入口。并发文件变更、其他调用者或热补丁的行为不能仅靠这些静态判断排除。

## 5. 其他清理入口：已检查范围与局限

- `MMCleanCacheMgr.p_cleanTmpPath` 从 `GetTmpPath` 获取根（`0x1028fe33c`），删除并重建该临时子路径；不是 Preferences 根。
- `p_cleanCacheAudio` 从 `GetSystemCachePath` 追加固定音频缓存名（`0x1028fe8d8..0x1028fe8f0`），再删除该缓存（`0x1028fe968`）。
- `p_cleanCachesWebkit` 使用 `GetSystemCachePath` 和 `GetWebKitStoragePath`（`0x1028fe518`、`0x1028fe5ec`）；检查的直接调用未将 Preferences 作为根。
- `cleanAppOtherCache`（`0x1028fddd4`）会向多个业务类分派 `cleanCacheMgrMakeToClean`，以及 `cleanDSMCache` / `cleanAttachmentCache`。本次未逐个反编译所有这些业务回调，不能将“本函数没有 Preferences 常量”表述成全部业务回调都已被排除。
- `MMLiveStorageCleanupLogic.cleanupStorageWithScenario:` 默认扫描四个直播目录（`0x1042b8d38..0x1042b8dc4`）：`localUsrDirPath`、`localUsrDirExtendedTempPath`、`localUsrDirTempPath`、`localUsrDirBriefTempPath`；还允许扩展回调添加 deviation directives（`0x1042b8e7c..0x1042b8f08`）。已检查的静态 responder 添加的是直播相关保留路径，没有添加 Preferences 删除路径；未穷尽所有运行时注册扩展。

完整编译规则的检查排除了这两个新目录的**静态路径分类覆盖规则**。它不等同于穷尽微信所有文件删除调用，也不替代真实安装版本、动态下发规则和现场文件系统日志。规则初始化热补丁入口（`0x1029a2750..0x1029a2758`）及 `patchAppendBizRule:` 可使设备规则与样本不同。

## 实施含义

这份证据支持按用户方案迁移存储并移除全局清理干预。插件自己的图片删除/恢复清理与两个持久化子目录同处 `Preferences/WeChatImprove`，必须另行限定资源操作的边界；原生 Preferences 规则不会防止插件自己执行删除。跨容器重装、卸载或用户主动移除数据也不受该规则保护。
