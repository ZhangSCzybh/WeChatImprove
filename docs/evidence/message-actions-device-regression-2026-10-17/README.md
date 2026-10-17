# Device regression fix report

Status: scoped fixes complete; host and static evidence pass; device acceptance and 1.8-1 packaging remain with the parent task.

## Environment and scope

All edits and checks ran only in `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`, branch `codex/message-actions-refactor-1.7-17`, starting HEAD `6edeedd1da5732c3aebae1789428383ce86eb727`. User reported installed plugin1.8-0 on WeChat8.0.78 with enabled gestures/repeat/voice forwarding, missing both plugin menus and swipe movement. Static evidence targets extracted8.0.78.34 arm64; it does not independently verify the phone's patch/build identity.

The parent relayed the final review's exactly two confirmed blockers. This single fix wave addresses both. No live service was started or switched; URL/ports/database do not apply to this local tweak source task. The original checkout, installed app, account, databases, historical messages/media and preferences were untouched. Tests use unique host defaults suites and temporary files/native doubles. No installation, real send, version bump, package replacement, push, merge or subagents occurred. Existing1.8-0 and prior packages, tracked `.theos` files, and release metadata remain unchanged.

## Confirmed root cause: native service proxy rejection

`MMContext.getService:` normally returns `MMServiceWrapper:NSProxy`. The account getter required a concrete `getSelfContact` Method on that proxy, so returned nil. Shared context creation then rejected every account-less request, suppressing both menus and the gesture action capability. The same concrete-only boundary also rejected later service calls.

The new regression constructs actual native-shaped classes (`MMContext`, `MMServiceWrapper:NSProxy`, `CContactMgr`, controller responder chain), and uses production `CSMessageNativeEnvironment`, context, coordinator and menu adapter. It does not inject `TestEnvironment` for this path. Reverting only `CSMessageNativeActionAdapter.m` to starting HEAD in an isolated temporary harness yields exit1:

```
production admission: account=nil context=nil menus=0 gesture=no
FAIL line 259: [environment.currentAccountID isEqual:@"me"]
```

The fix registers only runtime service wrappers returned by the known service lookup with the exact requested concrete service class. ABI checks use actual Methods on that class; `NSInvocation` still targets the original proxy, preserving native context forwarding/push/pop. Unknown/unregistered wrappers, wrong ABI and arbitrary dynamic signatures remain rejected. Core cell/model getters remain concrete-only; no unsafe unwrapping was added. Raw concrete service returns remain supported.

Coverage verifies recovered account/context, two menus and shared gesture admission, correct responder ownership, original proxy forwarding invocation counts, rejected wrong ABI and unregistered proxies, wrapped `CMessageMgr` insertion/`AudioSender` selection/download service dispatch, and old-context invalidation on account/service change. Source and target message identities remain separate. Native evidence proves selected voice uploaders are concrete `MMNewUploadVoiceMgr`/`UploadVoiceCDNMgr`, so no extra proxy allowance was introduced for them; destructive AudioSender resend is never selected.

Native contract report and reproducible extraction evidence: `docs/evidence/message-actions-native-2026-10-17/service-entry-report.md` and `service-entry-manifest.json`. All37 manifest file hashes verified.

## Confirmed blocker: cleanup cancelled confirmed waiting media

After `OnForwardMessageSend:` finished a native session successfully, the binding became a closed tombstone but retained its operation ID while media preparation continued. Native `clearData` then called finish with cancellation and cancelled the same confirmed pending send.

The execution runner now extracts the actual `OnForwardMessageSend:`, `OnForwardMessageCancel:`, and `clearData` hook bodies. Its native `%orig` replacement synchronously calls `clearData`, with counters proving each original executes exactly once. Reverting only `CSMessageActionCoordinator.m` to starting HEAD while retaining the service fix yields exit1:

```
production admission: account=me context=yes menus=2 gesture=yes
FAIL line 415: sender.calls.count==1
```

`finishForwardLogic` now treats the first native terminal outcome as authoritative and ignores repeated finish calls on a closed binding. Completion → nested clearData → media completion submits exactly once; duplicate/late callbacks do not resubmit. Genuine cancellation → late success → media completion submits zero and remains Cancelled. Existing180-second bounded operation cleanup, account/settings invalidation, and source/target tombstone matching remain intact.

No Hook production code changed: starting HEAD already called completion before `%orig`; the defect was closed-binding outcome reprocessing. Native picker, confirmation, cancellation, comments and cleanup bodies remain intact.

## Validation

Eight strict host suites completed exit0 with66,626 checks; compiler flags retain `-Wall -Wextra -Werror` on the execution suite. Logs are in `docs/evidence/message-actions-device-regression-2026-10-17`.

| Command suffix (`bash Tests/verify-<suffix>.sh`) | Checks |
| --- | ---: |
| message-actions-core | 1362 |
| message-actions-execution | 241 |
| message-gesture | 272 |
| message-time | 142 |
| message-merge | 53200 +2872 |
| bubble-style | 8269 +111 |
| revoke-interception | 73 |
| revoke-reference | 84 |

Green production admission prints `account=me context=yes menus=2 gesture=yes`. `red-service-proxy.log` and `red-closed-binding.log` retain independent negative controls run from temporary harnesses; production files were never reverted during those checks. `git diff --check` passes for production/tests and the fix report/logs. The retained native disassembler evidence is byte-for-byte researcher output (all manifest hashes match) and contains24 trailing-whitespace warnings in assembly comments; these do not affect instructions or source builds. Scoped self-review checked proxy dispatch ownership, exact ABI, close idempotence, genuine cancellation, source/read-only contracts and no package/environment changes.

## Remaining boundary

These tests establish the concrete shared-gate cause and host behavior, not successful installed UIKit gestures, real picker execution, recipient delivery/playback or performance. The gesture suite still uses UIKit/facade doubles; production-environment admission is separately exercised. Parent owns final scoped independent review, fresh dual-architecture1.8-1 build/package verification, and user-device acceptance. Do not describe this as installed or fully accepted until those steps are actually completed.
