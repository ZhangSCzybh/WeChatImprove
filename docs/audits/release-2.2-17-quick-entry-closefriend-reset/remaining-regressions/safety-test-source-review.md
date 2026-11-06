# 其余 73 个既有回归的测试源安全复核

本复核只读查看新 audit 中从 HEAD 恢复的既有测试与生成器；未执行回归、未修改任何既有测试/生产源码。本表与执行者对 shell 脚本的独立审查互补。

结论：审查范围内 **73 个脚本均可在每脚本独立临时 TMPDIR 下运行，未发现必须因测试源安全问题跳过的脚本**。这表示可安全执行，不表示编译或既有断言一定通过；失败仍应原样留档。

## 真实持久化与外部 I/O 的核验

- Defaults：备份、布局、群聊、支付、背景运行、消息动作等写入使用 UUID 命名的独立 suite，cleanup 只删除该 suite。需要读取 standardUserDefaults 的夹具使用进程内 swizzle/宏替身（例如 GroupIndicator、ManagedImageCleanupIntegration、MyPageClean、NavigationTitleBatch、TabBar、TouchTrail），或仅覆盖 NSArgumentDomain 的 **volatile** 值（GroupSearch、RevokeInterception）。未发现往真实插件域持久写入的 fixture。
- Keychain：`AIClientTests.m:10/15/20` 直接定义 SecItemAdd/CopyMatching/Delete 替身，数据在内存 FakeSecrets。`verify-ai-credentials.sh` 生成包装代码把 SecItemCopyMatching 宏替换为 `CSAITestCopyMatching`。`AIReplyManagerTests.m:188` 起的同步/异步凭据 API 均为内存字典替身，不链接真实凭据存储实现。
- 网络：`AIClientTests.m:89` 使用 ephemeral session + AIFakeProtocol；`NavigationImageTests.m:217` 使用 ImageProtocol。AI coordinator/manager 的实际请求对象均为 TestClient/假 completion。`.invalid` / example URL 是受控输入，未发现 curl/wget 或真实会话发送路径。原生联系人、发消息、红包/收款、奖励入口均是 fixture class/double，不操作设备上的微信进程。
- 文件：临时文件来自 UUID 临时目录、脚本 argv 注入的 mktemp 路径，或测试目录形态注入的 library/root。`BackupRestorePathTests` 与 `PluginStorageMigrationTests` 中的 `/Library` 是临时 base 的子路径，不是系统/用户 Library。ManagedImageFile 中 `/private/var` 是对临时路径别名的检查，不固定写那个目录。
- `BackupStartupIntegrationTests.m:83` 的固定 `test-only-store` 位于 NSTemporaryDirectory，而且 TestStore 的 journal/archive/save 方法为内存 facade；这里不实际写该固定目录。
- BackgroundRun 三个额外动态编译夹具均使用 UUID suite；AVAudioSession/AVAudioPlayer 编译宏替换为 CSTest 类，输出 wav 由 shell 注入 mktemp 文件名，`afinfo` 只读该 wav。
- 子进程：备份事务、兼容、插件存储迁移、定时任务备份的 NSTask 只启动本次临时编译出来的 argv[0]，继续传入同一个临时路径与测试 suite；故意中断不触及真实服务。
- 生成器 `extract-*.py` 只读生产源码，写 shell 指定的临时 output 或同目录派生文件。`verify-group-proxy.py` 也只在 TemporaryDirectory 生成和编译 probe。所见 git 命令仅 rev-parse provenance，未发现 reset/checkout/stash/commit、make clean、历史 packages 或主 .theos 写入。

建议执行条件：保持原 HOME，不替换用户环境；为每脚本设置独立 TMPDIR 和已准备的三项 Theos 输出变量。所有运行日志和实际退出码写新 audit，不能把安全审查当作测试通过。

## 范围清单

| 脚本 | 直接引用的测试/生成器 | 安全结论 |
| --- | --- | --- |
| verify-ai-background-sync.sh | AIBackgroundSyncTests.m | 可在临时运行目录执行 |
| verify-ai-backup.sh | AIReplyBackupTests.m | 可在临时运行目录执行 |
| verify-ai-coordinator.sh | AIReplyCoordinatorTests.m | 可在临时运行目录执行 |
| verify-ai-credentials.sh | AICredentialStoreTests.m | 可在临时运行目录执行 |
| verify-ai-foundation.sh | AIClientTests.m, AIReplyStoreTests.m | 可在临时运行目录执行 |
| verify-ai-images.sh | AIImagePreparerTests.m | 可在临时运行目录执行 |
| verify-ai-manager.sh | AIReplyManagerTests.m | 可在临时运行目录执行 |
| verify-ai-native-sync-observer.sh | AINativeSyncObserverTests.m | 可在临时运行目录执行 |
| verify-ai-native.sh | AIReplyNativeTests.m | 可在临时运行目录执行 |
| verify-ai-store-async.sh | AIReplyStoreAsyncTests.m | 可在临时运行目录执行 |
| verify-authorization-prompt.sh | AuthorizationPromptTests.m | 可在临时运行目录执行 |
| verify-authorization-read.sh | AuthorizationReadTests.m | 可在临时运行目录执行 |
| verify-avatar-input-style.sh | AvatarInputStyleTests.m | 可在临时运行目录执行 |
| verify-background-blur.sh | BackgroundBlurTests.m | 可在临时运行目录执行 |
| verify-background-privacy.sh | BackgroundPrivacyCoverTests.m | 可在临时运行目录执行 |
| verify-background-run-runtime.sh | BackgroundRunRuntimeTests.m | 可在临时运行目录执行 |
| verify-background-run.sh | BackgroundRunFakeRuntime.m | 可在临时运行目录执行 |
| verify-backup-assets.sh | BackupAssetsTests.m | 可在临时运行目录执行 |
| verify-backup-audit.sh | BackupAuditTests.m | 可在临时运行目录执行 |
| verify-backup-bootstrap.sh | BackupBootstrapTests.m | 可在临时运行目录执行 |
| verify-backup-codec.sh | BackupCodecTests.m | 可在临时运行目录执行 |
| verify-backup-compatibility.sh | BackupCompatibilityTests.m | 可在临时运行目录执行 |
| verify-backup-deletion-ui.sh | BackupDeletionUITests.m | 可在临时运行目录执行 |
| verify-backup-deletion.sh | BackupDeletionTests.m | 可在临时运行目录执行 |
| verify-backup-engine.sh | BackupEngineTests.m | 可在临时运行目录执行 |
| verify-backup-manual-management.sh | BackupManualManagementTests.m | 可在临时运行目录执行 |
| verify-backup-performance.sh | BackupPerformanceTests.m | 可在临时运行目录执行 |
| verify-backup-registry.sh | BackupRegistryTests.m | 可在临时运行目录执行 |
| verify-backup-reset.sh | BackupResetTests.m | 可在临时运行目录执行 |
| verify-backup-restore-paths.sh | BackupRestorePathTests.m | 可在临时运行目录执行 |
| verify-backup-store.sh | BackupStoreTests.m | 可在临时运行目录执行 |
| verify-backup-transactions.sh | BackupTransactionTests.m | 可在临时运行目录执行 |
| verify-custom-text.sh | CustomTextMatchTests.m | 可在临时运行目录执行 |
| verify-group-appearance.sh | GroupAppearanceTests.m | 可在临时运行目录执行 |
| verify-group-badges.sh | GroupBadgeTests.m | 可在临时运行目录执行 |
| verify-group-business.sh | GroupBusinessRowTests.m, extract-group-business.py | 可在临时运行目录执行 |
| verify-group-header.sh | GroupHeaderSemanticsTests.m, extract-group-header.py | 可在临时运行目录执行 |
| verify-group-incremental.sh | GroupIncrementalTests.m | 可在临时运行目录执行 |
| verify-group-indicator.sh | GroupIndicatorTests.m, extract-group-indicator.py | 可在临时运行目录执行 |
| verify-group-interactions.sh | GroupInteractionTests.m, extract-group-interactions.py | 可在临时运行目录执行 |
| verify-group-lifecycle.sh | GroupLifecycleTests.m, extract-group-lifecycle.py | 可在临时运行目录执行 |
| verify-group-picker.sh | verify-native-contact-picker.sh | 可在临时运行目录执行 |
| verify-group-preferences.sh | GroupPreferencesTests.m | 可在临时运行目录执行 |
| verify-group-search.sh | GroupSearchTests.m, extract-group-search.py | 可在临时运行目录执行 |
| verify-group-selection.sh | GroupSelectionTests.m, extract-group-selection.py | 可在临时运行目录执行 |
| verify-group-viewport.sh | GroupViewportTests.m, extract-group-viewport.py | 可在临时运行目录执行 |
| verify-layout-preferences.sh | LayoutPreferencesTests.m | 可在临时运行目录执行 |
| verify-list-corners.sh | ListCornerSemanticsTests.m, extract-list-corners.py | 可在临时运行目录执行 |
| verify-managed-image-files.sh | ManagedImageCleanupIntegrationTests.m, ManagedImageFileTests.m | 可在临时运行目录执行 |
| verify-message-actions-core.sh | MessageActionCoreTests.m | 可在临时运行目录执行 |
| verify-message-actions-execution.sh | MessageActionExecutionTests.m | 可在临时运行目录执行 |
| verify-miniapp-first-frame.sh | CloseFriendSessionTests.m, MiniappFirstFrameTests.m, MiniappPrivateLayoutTests.m, verify-miniapp-private-layout.sh | 可在临时运行目录执行 |
| verify-miniapp-private-layout.sh | MiniappPrivateLayoutTests.m, verify-close-friend-session.sh | 可在临时运行目录执行 |
| verify-my-page-clean.sh | MyPageCleanTests.m | 可在临时运行目录执行 |
| verify-native-contact-picker.sh | NativeContactPickerTests.m | 可在临时运行目录执行 |
| verify-native-reward.sh | NativeRewardPresenterTests.m, NativeRewardRouteTests.m | 可在临时运行目录执行 |
| verify-navigation-images.sh | NavigationImageTests.m | 可在临时运行目录执行 |
| verify-navigation-title-batch.sh | NavigationTitleBatchTests.m | 可在临时运行目录执行 |
| verify-payment-core.sh | PaymentAutomationTests.m, PaymentCoreTests.m | 可在临时运行目录执行 |
| verify-plugin-framework.sh | BackupStartupIntegrationTests.m, PluginEntryTests.m | 可在临时运行目录执行 |
| verify-plugin-storage-migration.sh | PluginStorageMigrationTests.m | 可在临时运行目录执行 |
| verify-preference-concurrency.sh | PreferenceConcurrencyTests.m | 可在临时运行目录执行 |
| verify-privacy-admission-cache-events.sh | PrivacyAdmissionCacheAdditionalTests.m, verify-privacy-admission-cache.sh | 可在临时运行目录执行 |
| verify-privacy-admission-cache.sh | PrivacyAdmissionCacheTests.m | 可在临时运行目录执行 |
| verify-revoke-interception.sh | RevokeInterceptionTests.m | 可在临时运行目录执行 |
| verify-revoke-reference.sh | RevokeReferenceTests.m | 可在临时运行目录执行 |
| verify-scheduled-task-backup.sh | ScheduledTaskBackupTests.m | 可在临时运行目录执行 |
| verify-scheduled-task-manager.sh | ScheduledTaskManagerTests.m | 可在临时运行目录执行 |
| verify-scheduled-task-swipes.sh | ScheduledTaskSwipeTests.m | 可在临时运行目录执行 |
| verify-scheduled-tasks.sh | ScheduledTaskTests.m | 可在临时运行目录执行 |
| verify-tabbar.sh | TabBarNativeTests.m | 可在临时运行目录执行 |
| verify-touch-trail.sh | TouchTrailRuntimeTests.m | 可在临时运行目录执行 |
| verify-transfer-admission.sh | verify-payment-core.sh | 可在临时运行目录执行 |
