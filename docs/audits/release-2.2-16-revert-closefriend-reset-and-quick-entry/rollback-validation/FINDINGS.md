# 2.2-16 密友回滚与一次性残留兼容

本目录只测试回滚与残留兼容。快捷页授权及 UIKit 手势由本次 release 的 quick-entry 测试另行覆盖。所有数据使用独立临时文件、独立 NSUserDefaults suite 与字典 Keychain double，不读取真实微信/Keychain。

## 实际回滚

以本次冻结的 2.2-15 工作树和前次保留的准确 2.2-14 副本做逐文件 diff。六文件（Reset.h/m、Runtime.h/m、Manager.m、Bridge.m）先通过普通文件写入完整还原到 2.2-14 字节，未用任何 Git 恢复命令。`exact-rollback-sha256.json` 保存 2.2-15、2.2-14 和精确回滚阶段的每个 SHA256，六项全部相等。每个 `.15-to-.14.diff` 是此次移除范围。随后在 Reset.m 与 Manager.m 上增加必需残留清理；新快捷页修改由其他工作单元独立记录，所以不能把最终所有文件冒称仍与 2.2-14 字节一致。

已删除 2.2-15 `reset-validation/` 全目录与孤立 `review-reset.md`，共 60 文件。只留路径、大小和 SHA256 的删除 manifest，不保留跳过、注释或未调用的旧凭据重置断言。历史包未修改。冻结旧生产源码属于回滚 provenance，不参与编译或正常入口。

## 2.2-15 已可能写入的数据

- 当前账号 `reset` 槽：UTF8 `close-friends-credential-reset-v1`，写入后进程可能在 marker 写入前退出；这是已废弃的凭据重置 intent。
- 当前账号 `credential-reset` 槽：UTF8 `close-friends-credential-setup-v1`，其含义原为只允许重新设密码的 durable marker。marker 值也可能损坏，2.2-16 不解释它。
- `biometric-domain` 可能还在或已删；`auth` 可能保留旧密码/计数、已删，或在新密码持久化后已有新 auth 而 marker 未删。
- 名单和选项仍在 account-scoped 加密 state，`policy` 密钥及 discovery 仍在。迁移不创建密码，也不猜测已删除的 verifier。

## 一次性清理

Manager 的实际 `resetStorage` 加载边界（`begin == NO`）只调用 `CSKeychainRemove(account,@"credential-reset",NULL)`。不存在该 kind 的业务 reader、writer、状态解释或新 API。删除只影响当前 account，成功后自然不会再出现。系统拒绝删除时该次继续正常加载，不转成 reset-pending、不弹错；下一次加载会重试，不能声称失败的删除已成功。

Reset.resume 仅对 `reset` 槽精确字节 `close-friends-credential-reset-v1` 做删除并返回成功，不再删除 auth/bio 或任何名单。该退休 intent 的删除失败同样非阻塞且重试。

真正 `close-friends-reset-v1` 全组 reset 保留原来的严格 forward-only 行为；unknown intent、intent 读取错误、真正全组 reset 的删除错误仍阻断加载并保留 intent。本测试验证上述分支，既有 full-reset 测试的断言与操作序列未改。

## 密码缺失与可达性边界

有合法 auth 时恢复 2.2-14 的普通密码流程，原密码仍有效。若 2.2-15 已删 auth 且加密 state 还在，普通 runtime 继续保持 2.2-14 的 fail-closed 隐藏行为，不能借迁移自动进入设密或显示微信列表。新 5 连击入口要用独立、账号限定、页面限定 token 读取有效 state，不依赖聊天列表解锁态。这一交接已明确给快捷入口实现。

另外，如果用户保存了 `hidePluginEntry=YES`，完全恢复的 2.2-14 根插件入口会被隐藏；缺失 auth 时原有首页恢复流程也无法认证。只完成本目录的六文件回滚和 marker 清理不能自动证明头像可达。该形态必须在根入口的最终实现/报告中明确处理，不能把不存在的 verifier 当成普通新用户，也不能声称本目录已验证 UIKit 可达。

## 红绿验证

最终相同测试：`RollbackMigrationTests.m` SHA256 `682adc1b47a57a5cf1cde582d35550845f74944f2782ea20c2d66deca8d3c874`；runner SHA256 `5a2fcf9f5bef53ecc29730e1addac77753fcfa74b7c28b92b081aa82fb15052d`。

- `red-final-schema/`：冻结且未修复的 2.2-15 真实 Reset、Runtime、Crypto、Policy、Store、EntryState、PluginStorage + 实际抽取的 Manager resetStorage block，232 检查，39 失败，编译成功、运行退出 1。
- `green-final-schema/`：修复后同一 fixture，232 检查，0 失败，编译成功、运行退出 0。
- 测试包含正常无残留密码必需、退休 marker/intent 各种先后阶段、auth/bio 部分缺失、清理失败重试、未知和不可读 intent 严格阻断、真实全组 reset、第二账号含自身 marker/intent 的全部 key 集及字节不变。
- 最终 Runtime 页面权限冻结后复跑 `green-release/`：同一 fixture/runner，232 检查、0 失败，provenance 对应最终源。
- 所有旧断言未修改。旧 2.2-15 的无密码恢复测试按用户要求已实际删除。

主机测试没有 UI 真机数据。设备手势、页面转换和 iOS Keychain 实际拒绝/允许删除均为 **未验证**。
