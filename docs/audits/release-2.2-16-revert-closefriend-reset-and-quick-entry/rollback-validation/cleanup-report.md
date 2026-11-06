# 密友回滚最终清理补充审计

本审计只读检查 live `Controllers/`、`Hooks/`、`Headers/` 的 377 个源文件；旧 frozen baseline 只作为 provenance，不参与 live 扫描。此次没有修改生产文件。JSON 含完整搜索项、命中行、源文件快照 SHA256。

已退回的凭据重置 API、状态和静态常量（包括 `CSCredentialResetIntent`、`CSCredentialSetupMarker`、`credentialResetToken`、`credentialResetRequired`、`requiresPasswordSetup` 及 `forgotPasswordFrom/canRecoverCredentialFrom/confirmCredentialResetFrom`）共 17 个搜索项，live 源码命中为 **0**。

可执行源码只保留两个精确旧数据清理用例：

- `Controllers/CSCloseFriendManager.m:101`：`if(!begin)CSKeychainRemove(account,@"credential-reset",NULL);`
- `Controllers/CSCloseFriendReset.m:46`：`if(!readError && [intent isEqual:[@"close-friends-credential-reset-v1" dataUsingEncoding:NSUTF8StringEncoding]]) {`


其中 kind 只有直接移除，没有读取、写入或分支授权；旧凭据 intent 只有精确字节匹配后移除，不再执行旧清凭据功能。应用内发布说明包含“撤回无密码重置”和“移除忘记密码”等解释性文案，是用户要求的新版本变更说明，不是遗留入口或状态。

旧 2.2-15 `reset-validation/` 及 `review-reset.md` 均已不存在；删除 manifest 留在本目录，仅记录 SHA/大小，无跳过或死测试。

## 首页恢复手势未变

从 Manager `- (void)checkHomepageSearchPassword:` 至文件结束（包括最终 `@end`）整段共 4274 字节，现行内容与 frozen 2.2-15 **逐字节相同**。两边 SHA256 均为：

`734d3e2a02e5a1d82424056571fc4a391f4d2a5c49bdd7c51d7771ccccbe54ba`

这段完整包含首页搜索密码转发、`recovery:`、恢复手势启停、安装和 target 查找。类扩展中 `recoveryPage`、`recoveryTarget`、`recoveryGesture`、`recoveryEpoch` 四个属性声明亦逐行与 frozen 2.2-15 相同。没有依赖方法名搜索来替代字节证明。

## 与新快捷页功能的区分

Runtime 中出现的 `settingsAccess` / `settingsAccessToken` / `isSettingsTokenCurrent:` / `profileForSettingsToken:` / `invalidateSettingsAccessToken:` / `updateProfile:settingsToken:error:` 属于本次明确要求的页面访问功能，不属于撤回的密码重置代码。它是内存中的账号/epoch/visit token，不是 `credential-reset` Keychain kind，也不是旧 `credentialResetRequired` 状态。此处记录当前快照，不替代 quick-entry 专项行为测试。

## 保留的可达性边界

[回滚与迁移报告](FINDINGS.md) 中关于 **auth 已删除且 hidePluginEntry=YES 时头像不可达** 的说明仍然保留。恢复 .14 的 Bridge 与首页行为，不能自行恢复一个已删除的 verifier；本清理审计不声称该根入口形态已解决。需要用户/根任务确定的边界不因清理报告而删除。

无真机，iOS 手势和页面转场均为 **未验证**。
