## Spec Compliance

- ❌ Issues found: deferred next/previous/unread navigation does not re-evaluate current privacy before choosing native traversal. See Important finding below.
- ✅ Projection filters before badge/group routing, retains native coordinates, invalidates reuse on privacy changes, and neutralizes aggregate presentation without mutating its source (`Controllers/CSGroupProjection.m:183`, `Controllers/CSGroupProjection.m:200`). Grouping/search/native presentation retain the privacy projection (`Controllers/CSGroupListAdapter.m:455`, `Controllers/CSGroupListAdapter.m:484`).
- ⚠️ Device presentation/lifecycle acceptance remains unverified; interface metadata and host doubles are not device validation. Notification silence/call rejection and application tab/icon badges are outside this task gate.

## Strengths

- Folded assessment explicitly distinguishes unknown, no-hidden, mixed and all-hidden; empty/unreadable identities cannot prove all-hidden (`Controllers/CSGroupNativeBridge.m:60`, `Controllers/CSGroupNativeBridge.m:76`). The projection checks account, epoch and policy revision after assessment (`Controllers/CSGroupListAdapter.m:566`).
- Immediate table shielding and priority refresh prevent interaction deferral from retaining old protected cells (`Controllers/CSGroupListAdapter.m:161`, `Controllers/CSGroupListAdapter.m:430`). The owned cell cover restores native view/accessibility state and leaves source unread intact (`Controllers/CSCloseFriendSessionPresentation.m:15`).

## Issues

### Important — recheck privacy when deferred navigation executes

- `Hooks/SessionGroupHooks.xm:117` and `Controllers/CSGroupListAdapter.m:702`: `onNextUnreadChat`, `onNextChat`, and `onLastChat` call `navigatePrivateSessionsForward:unreadOnly:` only before queuing. Their queued blocks execute native `%orig` directly. The queue wrapper checks epoch, account and application activity, but not current privacy. If a command is queued while revealed (for example during an open menu or publication) and privacy locks before it drains, it executes native traversal instead of the required visible-only traversal. A hidden native destination can then be vetoed by the selection guard without advancing to an available visible destination. This also violates the explicit requirement that asynchronous actions recheck current policy.
- Exact actionable change: **Inside each of those three queued blocks, call `navigatePrivateSessionsForward:unreadOnly:` again with the corresponding direction/unread flag and execute native `%orig` only if it returns NO. Preserve the existing account/epoch/application guard. Add one focused regression that queues navigation while revealed, locks before draining, and verifies navigation reaches the next eligible visible session.**

## Assessment

**Task quality: Needs fixes.** The projection and folded integration are well scoped and source preserving; the deferred navigation branch needs the same current-policy dispatch as immediate navigation.

- Checks: read supplied diff (initial combined tool output truncated; read missing portions in bounded chunks), requirements, report and native evidence; no git recreation or tests rerun. Reported 1,024 passing host checks and arm64/arm64e compilation were reviewed as reported evidence.
- Focused outside-diff checks: privacy activation risk — unchanged `isActive` returns `projecting` (`Controllers/CSGroupListAdapter.m:194`); folded mutation/mapping risk — existing generic UITableView hooks cover attached folded tables (`Hooks/SessionGroupHooks.xm:242`, `Hooks/SessionGroupHooks.xm:315`), and native metadata matches the newly installed folded signatures; queued-policy/background risk — manager locks on resign (`Controllers/CSCloseFriendManager.m:125`). No production, account, service or git state changed.
