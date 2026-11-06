# 余下 73 套既有回归补齐

此前已运行 6 套消息/气泡/布局脚本及 21 套 close-friend 脚本。本次执行剩余全部 **73 个 verify-*.sh**，不修改原脚本、夹具或断言，不在根目录恢复 Tests。

结果为 **60 通过、13 失败、0 安全跳过**。13 个失败都用冻结且未修改的 2.2-15 源进行同脚本对照，全部复现相同 exit 1 和逐条相同诊断，**相对 2.2-15 的新增失败为 0**。不能把这 13 项写成通过，也不能声称历史 100 项已全绿。

失败分类：**11 套宿主夹具/抽取体编译不兼容，2 套旧提取器合同失败**；没有运行到新增行为断言才失败的项。group 类旧 fixtures 缺少 native-session/viewport 等已有声明，部分脚本抽取误匹配方法声明；miniapp/隐私 admission fixtures 使用同样过时的源接口。group-lifecycle 缺少旧 selector 产生 ValueError；group-viewport 提取器断言拒绝现有方法。所有对照诊断及多重集保存在 summary.json，不为无关模块修改生产或旧断言。

## 安全与隔离

先逐项审查 73 个 shell 脚本并 bash -n（0 语法失败），再独立审查 95 个直接/动态 fixture 源。没有 make/clean/Git 变更、主树 .theos/packages 写入或真实 Keychain/网络用户写入。backup-bootstrap 只读取 Theos Logos、在临时目录生成代码并做语法编译。defaults 使用 UUID suite、内存替身或 NSArgumentDomain volatile，网络使用 NSURLProtocol/TestClient，Keychain 访问符号为替身，文件根为 mktemp、UUID 或 argv 注入。详见两个 safety 报告。

最多 **3 并发**；每个脚本单独 TMPDIR 与 `_THEOS_LOCAL_DATA_DIR` / `THEOS_BUILD_DIR` / `THEOS_PACKAGE_DIR`。没有重设 HOME、home 或 CODEX_HOME。脚本可选的 provenance 输出被限定在本审计目录，旧 source override 环境变量被移除以免误测其他源码。失败对照使用独立 baseline-fixture；它的测试文件与当前 fixture 保持相同原字节，源码符号链接指向 frozen 2.2-15。

现行生产 378 文件、原始 fixture 277 文件前后 SHA256 完全一致；fixture 还逐项与初始 git archive provenance 复核相等。每个结果附脚本 SHA、真实命令、cwd、exit、临时变量、时间与日志；全部生产与夹具 SHA 在 before/after manifest。

## 逐脚本状态

| 脚本 | 2.2-16 exit | 冻结 2.2-15 对照 | 分类 |
|---|---:|---|---|
| [verify-ai-background-sync.sh](current/verify-ai-background-sync.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-backup.sh](current/verify-ai-backup.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-coordinator.sh](current/verify-ai-coordinator.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-credentials.sh](current/verify-ai-credentials.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-foundation.sh](current/verify-ai-foundation.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-images.sh](current/verify-ai-images.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-manager.sh](current/verify-ai-manager.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-native-sync-observer.sh](current/verify-ai-native-sync-observer.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-native.sh](current/verify-ai-native.sh.log) | 0 | 无需对照 | 通过 |
| [verify-ai-store-async.sh](current/verify-ai-store-async.sh.log) | 0 | 无需对照 | 通过 |
| [verify-authorization-prompt.sh](current/verify-authorization-prompt.sh.log) | 0 | 无需对照 | 通过 |
| [verify-authorization-read.sh](current/verify-authorization-read.sh.log) | 0 | 无需对照 | 通过 |
| [verify-avatar-input-style.sh](current/verify-avatar-input-style.sh.log) | 0 | 无需对照 | 通过 |
| [verify-background-blur.sh](current/verify-background-blur.sh.log) | 0 | 无需对照 | 通过 |
| [verify-background-privacy.sh](current/verify-background-privacy.sh.log) | 0 | 无需对照 | 通过 |
| [verify-background-run-runtime.sh](current/verify-background-run-runtime.sh.log) | 0 | 无需对照 | 通过 |
| [verify-background-run.sh](current/verify-background-run.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-assets.sh](current/verify-backup-assets.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-audit.sh](current/verify-backup-audit.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-bootstrap.sh](current/verify-backup-bootstrap.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-codec.sh](current/verify-backup-codec.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-compatibility.sh](current/verify-backup-compatibility.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-deletion-ui.sh](current/verify-backup-deletion-ui.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-deletion.sh](current/verify-backup-deletion.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-engine.sh](current/verify-backup-engine.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-manual-management.sh](current/verify-backup-manual-management.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-performance.sh](current/verify-backup-performance.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-registry.sh](current/verify-backup-registry.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-reset.sh](current/verify-backup-reset.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-restore-paths.sh](current/verify-backup-restore-paths.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-store.sh](current/verify-backup-store.sh.log) | 0 | 无需对照 | 通过 |
| [verify-backup-transactions.sh](current/verify-backup-transactions.sh.log) | 0 | 无需对照 | 通过 |
| [verify-custom-text.sh](current/verify-custom-text.sh.log) | 0 | 无需对照 | 通过 |
| [verify-group-appearance.sh](current/verify-group-appearance.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-group-badges.sh](current/verify-group-badges.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-group-business.sh](current/verify-group-business.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-group-header.sh](current/verify-group-header.sh.log) | 0 | 无需对照 | 通过 |
| [verify-group-incremental.sh](current/verify-group-incremental.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-group-indicator.sh](current/verify-group-indicator.sh.log) | 0 | 无需对照 | 通过 |
| [verify-group-interactions.sh](current/verify-group-interactions.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-group-lifecycle.sh](current/verify-group-lifecycle.sh.log) | 1 | exit 1；诊断相同 | 已有提取器失配 |
| [verify-group-picker.sh](current/verify-group-picker.sh.log) | 0 | 无需对照 | 通过 |
| [verify-group-preferences.sh](current/verify-group-preferences.sh.log) | 0 | 无需对照 | 通过 |
| [verify-group-search.sh](current/verify-group-search.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-group-selection.sh](current/verify-group-selection.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-group-viewport.sh](current/verify-group-viewport.sh.log) | 1 | exit 1；诊断相同 | 已有提取器失配 |
| [verify-layout-preferences.sh](current/verify-layout-preferences.sh.log) | 0 | 无需对照 | 通过 |
| [verify-list-corners.sh](current/verify-list-corners.sh.log) | 0 | 无需对照 | 通过 |
| [verify-managed-image-files.sh](current/verify-managed-image-files.sh.log) | 0 | 无需对照 | 通过 |
| [verify-message-actions-core.sh](current/verify-message-actions-core.sh.log) | 0 | 无需对照 | 通过 |
| [verify-message-actions-execution.sh](current/verify-message-actions-execution.sh.log) | 0 | 无需对照 | 通过 |
| [verify-miniapp-first-frame.sh](current/verify-miniapp-first-frame.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-miniapp-private-layout.sh](current/verify-miniapp-private-layout.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-my-page-clean.sh](current/verify-my-page-clean.sh.log) | 0 | 无需对照 | 通过 |
| [verify-native-contact-picker.sh](current/verify-native-contact-picker.sh.log) | 0 | 无需对照 | 通过 |
| [verify-native-reward.sh](current/verify-native-reward.sh.log) | 0 | 无需对照 | 通过 |
| [verify-navigation-images.sh](current/verify-navigation-images.sh.log) | 0 | 无需对照 | 通过 |
| [verify-navigation-title-batch.sh](current/verify-navigation-title-batch.sh.log) | 0 | 无需对照 | 通过 |
| [verify-payment-core.sh](current/verify-payment-core.sh.log) | 0 | 无需对照 | 通过 |
| [verify-plugin-framework.sh](current/verify-plugin-framework.sh.log) | 0 | 无需对照 | 通过 |
| [verify-plugin-storage-migration.sh](current/verify-plugin-storage-migration.sh.log) | 0 | 无需对照 | 通过 |
| [verify-preference-concurrency.sh](current/verify-preference-concurrency.sh.log) | 0 | 无需对照 | 通过 |
| [verify-privacy-admission-cache-events.sh](current/verify-privacy-admission-cache-events.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-privacy-admission-cache.sh](current/verify-privacy-admission-cache.sh.log) | 1 | exit 1；诊断相同 | 已有宿主夹具编译失配 |
| [verify-revoke-interception.sh](current/verify-revoke-interception.sh.log) | 0 | 无需对照 | 通过 |
| [verify-revoke-reference.sh](current/verify-revoke-reference.sh.log) | 0 | 无需对照 | 通过 |
| [verify-scheduled-task-backup.sh](current/verify-scheduled-task-backup.sh.log) | 0 | 无需对照 | 通过 |
| [verify-scheduled-task-manager.sh](current/verify-scheduled-task-manager.sh.log) | 0 | 无需对照 | 通过 |
| [verify-scheduled-task-swipes.sh](current/verify-scheduled-task-swipes.sh.log) | 0 | 无需对照 | 通过 |
| [verify-scheduled-tasks.sh](current/verify-scheduled-tasks.sh.log) | 0 | 无需对照 | 通过 |
| [verify-tabbar.sh](current/verify-tabbar.sh.log) | 0 | 无需对照 | 通过 |
| [verify-touch-trail.sh](current/verify-touch-trail.sh.log) | 0 | 无需对照 | 通过 |
| [verify-transfer-admission.sh](current/verify-transfer-admission.sh.log) | 0 | 无需对照 | 通过 |


每个失败的 frozen .15 日志位于 baseline/；current/ 保存本次 live 源日志。执行工具是 run-remaining.py；运行时未修改它调用的历史 verify 脚本。没有真机，全部结果属于主机测试及 SDK/Logos 编译。
