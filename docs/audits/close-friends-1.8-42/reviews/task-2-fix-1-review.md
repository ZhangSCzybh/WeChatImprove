### Finding Verdicts

- **I1 — Expiration navigation stops during UI tracking — ADDRESSED.** `Controllers/CSCloseFriendManager.m:113` isolates the actual scheduling method; line 117 creates an unscheduled timer and line 124 explicitly registers it in `NSRunLoopCommonModes`. The callback retains its fresh snapshot check and safe-page transition. `Tests/CloseFriendSchedulingTests.m:32` adds a custom common mode and executes only that mode; lines 39–42 verify the default-mode control timer stays unfired, the production callback transitions exactly once, authorization is locked, and the timer remains valid. `Tests/verify-close-friend-runtime.sh:11` extracts the production method verbatim into this fixture, so the regression covers the changed scheduler rather than a separately implemented timer.
- **I2 — Verbatim duplicated native-entry removal — ADDRESSED.** `Hooks/CustomEntryHooks.xm:59` defines one file-local `CSRemoveHiddenPluginEntryFromHost` helper. Both route gates call it (`Hooks/CustomEntryHooks.xm:120`, `Hooks/CustomEntryHooks.xm:326`); guarded reads, collection shape checks, matching-row deletion, and unrelated-row preservation remain intact. `Tests/PluginEntryTests.m:89` exercises the production helper through the updated extraction script.
- **M1 — Picker presentation/dismissal mismatch — ADDRESSED.** `Controllers/CSCloseFriendSettingsViewController.m:83` wraps the picker in its own navigation controller and lines 84–85 present that controller modally. The existing picker Done/Cancel dismissal now closes that picker presentation and returns to the close-friend settings page. The completion still refreshes the account, checks authorization/token, and merges the latest profile before saving (`Controllers/CSCloseFriendSettingsViewController.m:77`).

### New Breakage in the Fix Diff

- **Minor — Picker save failures cannot reliably display the existing error alert while the picker modal is still presented.** `Controllers/CSCloseFriendSettingsViewController.m:80` synchronously invokes the existing `save:` path from the picker completion, while line 85 now leaves `self` presenting the picker navigation controller. If the profile write fails, the existing error UI tries to present another alert from `self` before the picker Done handler dismisses its modal. UIKit will reject that overlapping presentation, so the user can return to settings without the “未保存” explanation. Defer reporting the save error until picker dismissal completes, or have the picker host display it with an appropriate completion/dismissal sequence. This affects failure feedback; the write still fails closed and does not bypass authorization.

### Out-of-Scope Observations

- None newly identified. Previously recorded physical-device Keychain, biometric, scene-cover, gesture, and shake acceptance limits remain unchanged and do not extend this scoped fix loop.

### Checks

- Reviewed the complete `8f6d9d79..50590087` fix package once and compared it against I1, I2, M1 and the appended fix report. No unchanged surfaces were rereviewed and no outside-diff investigation was performed.
- The appended report names and supplies successful outputs for the affected runtime/scheduler tests (76 + 5 checks), plugin/backup tests (21 + 14 checks), arm64/arm64e object compilation, and clean diff checks. The reported scheduler RED failure corresponds to the original default-mode defect, and the new test’s negative control supports the claimed GREEN mechanism. Results were not rerun.
- No production writes, git mutations, service operations, installation, real-account access, or subagents. This report is the sole write.

### Verdict

**Fix round: All findings addressed, no new Critical/Important breakage.** I1, I2, and M1 are closed. The new modal-save error-feedback issue is Minor and non-blocking for this task gate.
