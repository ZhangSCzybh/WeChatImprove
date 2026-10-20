### Spec Compliance

- ❌ Issues found: the 300-second authorization deadline is enforced correctly in the runtime, but the required expiry-driven cover/safe-page transition can be deferred indefinitely during UI tracking because its sole timer is registered only in the default run-loop mode (`Controllers/CSCloseFriendManager.m:111`, `Controllers/CSCloseFriendManager.m:114`). See Important I1.
- ✅ The requested files and integration hunks are present. The production runtime is independently testable; the bridge retains the required interfaces; setup requires a valid password; profile and journal writes have distinct authorization rules; existing backup account ownership is reused (`Controllers/CSCloseFriendRuntime.m:43`, `Controllers/CSCloseFriendRuntime.m:84`, `Controllers/CSCloseFriendRuntime.m:134`, `Controllers/CSCloseFriendRuntime.m:142`, `Controllers/CSCloseFriendBridge.m:45`). The additional Runtime/Account/Signatures units and Task 1 C linkage changes are authorized integration choices.
- ⚠️ Cannot verify from the diff: actual device Keychain availability/entitlements, scene-cover timing, biometric system UI lifecycle, recovery gesture placement, and shake delivery. In particular, test whether supported biometric presentations deliver `UIApplicationWillResignActiveNotification`: the observer calls `resign:` and unconditionally invalidates the active LAContext through the lock path (`Controllers/CSCloseFriendManager.m:94`, `Controllers/CSCloseFriendManager.m:104`, `Controllers/CSCloseFriendManager.m:118`). Do not count runtime token tests as proof that real biometric interaction succeeds.
- ⚠️ Native notification/call/surface protection and auto-mute restoration are later-task integrations, not established by this task. The current capability text correctly states interface availability and pending device verification (`Controllers/CSCloseFriendSettingsViewController.m:55`).

### Strengths

- Account resolution fails closed when an authoritative accessor exists but returns nil or has an unsupported signature, rather than using cached self-contact data (`Controllers/CSCloseFriendAccount.m:11`). Boundary snapshots deliberately discard old-account membership so silence/rejection cannot carry into another account (`Controllers/CSCloseFriendRuntime.m:65`).
- Keychain writes use `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`, and key generation checks for an existing state path before creating a replacement (`Controllers/CSCloseFriendManager.m:29`, `Controllers/CSCloseFriendManager.m:52`). Persisted policy without a credential remains blocked (`Controllers/CSCloseFriendRuntime.m:57`).
- The actual runtime owns credential generation, cooldown persistence, token invalidation, independent mute-journal updates, and cached immutable snapshots. The tests exercise real temporary encrypted files and injected credential providers rather than a separate model (`Controllers/CSCloseFriendRuntime.m:84`, `Controllers/CSCloseFriendRuntime.m:97`, `Controllers/CSCloseFriendRuntime.m:142`, `Tests/CloseFriendRuntimeTests.m:72`).
- Reveal expiration uses an independently injected elapsed clock. Tests explicitly move wall time in both directions and demonstrate expiration and revision changes (`Controllers/CSCloseFriendRuntime.m:72`, `Tests/CloseFriendRuntimeTests.m:114`). Late lifecycle/auth replies and cross-account journal writes have behavioral coverage (`Tests/CloseFriendRuntimeTests.m:126`, `Tests/CloseFriendRuntimeTests.m:131`).
- Native hooks compare the full normalized return type, argument types, and count before installation; settings expose exactly the agreed option names and gate direct construction (`Controllers/CSCloseFriendSignatures.m:14`, `Controllers/CSCloseFriendBridge.m:64`, `Controllers/CSCloseFriendSettingsViewController.m:12`, `Controllers/CSCloseFriendSettingsViewController.m:17`).

### Issues

#### Critical (Must Fix)

- None established by this review.

#### Important (Should Fix)

- **I1 / P1 — Expiration navigation stops during UI tracking.** `Controllers/CSCloseFriendManager.m:111` uses `scheduledTimerWithTimeInterval:repeats:block:`, which schedules in the default run-loop mode. While a scroll view is tracking a finger, the main run loop runs in tracking mode and this timer does not fire. Its callback at line 114 is the only manager path that notices elapsed authorization and covers/pops the currently visible sensitive view. Although subsequent snapshot reads fail closed, an already rendered contact picker or other sensitive page can remain visible past the deadline for as long as tracking continues. Register the timer in common modes (or use a main-queue deadline mechanism that also runs during tracking), preserving the fresh snapshot check before locking. Add a focused regression for expiry while the run loop is in tracking mode; a normal runtime clock test does not cover the manager scheduling defect.

- **I2 / P2 — Verbatim duplicated native-entry removal logic.** `Hooks/CustomEntryHooks.xm:103` and `Hooks/CustomEntryHooks.xm:321` duplicate the same guarded section/cell traversal and removal block. This is a shared compatibility/security gate: fixing a selector, shape check, or deletion condition in one route must also fix the other. Extract one file-local helper accepting the host controller, and keep both hook methods as gate-plus-helper calls. Classified Important under the task-review contract’s explicit treatment of verbatim duplicated logic blocks.

#### Minor (Nice to Have)

- **M1 / P2 — Picker presentation does not match its dismissal contract.** `Controllers/CSCloseFriendSettingsViewController.m:82` pushes the existing `WEContactSelectViewController` onto the settings navigation stack. Its existing Cancel and Done handlers call only `dismissViewControllerAnimated:completion:` (`Controllers/WEContactSelectViewController.m:327`, `Controllers/WEContactSelectViewController.m:331`). When the settings stack is presented modally, those controls dismiss the whole containing presentation; when it is not, they do not pop the picker. Present the picker in its own navigation controller, or deliberately adapt its dismissal behavior for a pushed controller, so finishing selection returns to the close-friend settings page. The selection callback itself correctly rechecks authorization/token before saving (`Controllers/CSCloseFriendSettingsViewController.m:77`).

### Assessment

**Task quality:** Needs fixes.

**Reasoning:** The account-bound storage/authentication core and its focused behavioral tests are strong, and the monotonic deadline correction is implemented consistently. The UI expiration scheduler must keep running during tracking before the temporary-reveal guarantee is trustworthy; the duplicated gate logic should also be consolidated under the review contract.

### Checks and review scope

- Read the Task 2 brief before the implementer report, then reviewed the complete `bde53cfe..8f6d9d79` package in three contiguous sections without rereading changed full files. A subsequent mechanical extraction produced line references only.
- Named outside-diff risk: whether a blocked/epoch-boundary snapshot retains old-account memberships or accidentally enables entry hiding. Inspected `Controllers/CSCloseFriendPolicy.m` snapshot construction and predicates; confirmed the new runtime’s empty boundary profile does not silence/reject old members. Unknown policy keeps presentation blocked; existing non-sensitive plugin settings remain usable.
- Named outside-diff risk: account lock ordering and notification delivery. Inspected the focused account-boundary implementation in `Controllers/CSBackupBootstrap.m:123` and `Hooks/BackupLifecycleHooks.xm:9`. The handoff uses a recursive lock and account-change notification is dispatched to main; no new competing native login hook was added. Logout marks suspension before native work; the manager’s timer therefore also matters for visible-page invalidation before a later notification/activation.
- Named outside-diff risk: existing contact-picker integration might persist membership outside the encrypted store or have an incompatible completion/presentation contract. Inspected its public header and focused selection/persistence references, then the Cancel/Done handlers at `Controllers/WEContactSelectViewController.m:327`. No new persistence path was identified; the dismissal mismatch is M1.
- No tests were rerun. The reported passing runtime/core/framework/object-compilation results were not independently repeated, and no concrete test-output warning was provided in the report. No service, installation, real-account/Keychain operation, git mutation, or production edit was performed. This report is the sole write.
