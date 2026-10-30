# Independent Observer regression review

Recorded at 2026-10-29 21:23 UTC (2026-10-30 05:23 Asia/Shanghai) in the established checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`.

## Result

`bash Tests/verify-ai-native-sync-observer.sh --ios` passed:

- Main Observer fixture: **1180 checks**.
- Seven independent ABI rejection processes: **6 checks each**, **42 total**.
- Combined runtime assertions: **1222 checks**.
- Production Observer object compilation: **iOS 15.0 arm64 and arm64e passed**.
- Compiler policy: `-Wall -Wextra -Werror`; no warnings or errors appeared in the log.
- Directed `git diff --check` on the two assigned test files passed.

Raw output is saved in `observer-independent.log`. Assertion counts include fixture and repeated-loop checks, not that many distinct product scenarios.

## Evidence and preserved coverage

The shell fixture compiles `Controllers/CSAINativeSyncObserver.m` directly, with the leading production native dispatch implementation extracted from `Controllers/CSMessageNativeActionAdapter.m`. Its `MSHookMessageEx` implementation replaces actual Objective-C method IMPs. This exercises the installed production create, return and handle hooks rather than a copied Observer state machine. A temporary directory contains fixture headers, binaries and iOS object files and is removed on exit.

Both previous test files were copied verbatim before edits to `baseline/AINativeSyncObserverTests.m` and `baseline/verify-ai-native-sync-observer.sh`. All 11 original regression groups remain, as do the seven independent ABI modes. `observer-test-change-map.md` explains the intentional adaptations of old unbound-service negatives to explicit invalid raw ownership, alongside the new first-event positive path. Version whitelist refusals remain mandatory and were not removed.

New fixtures provide the real native class names `MMContext` and `MMBaseService`; `NewSyncService` inherits the latter's `context` getter. A healthy service requires exact context class identity, user/non-invalid flags, nonempty account, both global context pointers identical to the raw service's context and `isServiceRemoved == NO`. Manager capture records the service account and refuses a raw Bob context while the stub's current Manager account is Alice.

The tests reject missing/wrong/subclass contexts, invalid flags, empty/non-string usernames, removed services, missing/different global contexts, getter exceptions and Manager account disagreement. They replace context objects with the same account around capture and completion, mutate all seven ownership getter paths, revoke epochs inside native getters, and reenter creation from capture and identity getters.

The origin assertions distinguish natural scene 12 outside the plugin frame from scene 12 inside the real plugin request scope. Fresh natural scene 37/12 may drive one extra request. Plugin-origin results, natural-looking calls within plugin scopes, and all scene 6 continuations pass `allowsRequest:NO`. A simulated Manager request callback verifies that natural completion can produce one plugin request whose result stops the chain; a plugin result alone produces no further requests.

The final targeted regressions cover the last production fences reviewed by the owner:

1. An identity getter installed inside the original native create reenters create 99 during post-original event attachment. The interrupted outer call cannot retain a binding that permits a later natural-looking event to borrow another plugin frame.
2. A post-original identity getter changes the native event scalar. Restoring its previous scalar later does not revive the rejected observation.
3. A queued identity getter starts another accepted native sync. Although context identity is unchanged, the resulting busy flags block publication of the old completion.
4. A queued identity getter increments the account epoch, blocking old completion after the getter returns.
5. Two services with valid identity cannot share one claimed plugin frame, including when the first native creation refuses or throws. The second service remains able to bootstrap through a later natural call outside the frame.

## Input hashes

SHA-256 values recorded after the final passing run:

| Input or evidence | SHA-256 |
| --- | --- |
| `Controllers/CSAINativeSyncObserver.m` | `5b77491716de0d510e1a499b0b1b84a8de459061918536061e136865a178128b` |
| `Controllers/CSMessageNativeActionAdapter.m` | `e5e5c4667e86c5fda12fc0ed9c1c553a21d06e7091d139522850ad8274e022fc` |
| `Controllers/CSAIReplyManager.h` | `a5c5cb75446c1a502b9c5efd07a7878317870e6eb7b7262c815969586b492ab9` |
| `Tests/AINativeSyncObserverTests.m` | `f42b2c948e3bc7fdf5efe8d60bddfdf9debdf755a62190dad2e56c20b3f6bf2c` |
| `Tests/verify-ai-native-sync-observer.sh` | `a267bcbe81f43d024d46b19f33cca1b988ec1764826ebc657601e18c71e70bd7` |
| Baseline `AINativeSyncObserverTests.m` | `3348612ecd78c8589a70384d6feef86d529dbee4882c3ef205dff5bafcd46978` |
| Baseline `verify-ai-native-sync-observer.sh` | `8f78ada50875b4eb8a83a96e984e9dd9efd9f46335da931c06fef4d239e6f517` |
| `observer-independent.log` | `0f496dc4a6793e96865d1f1900fcf2538a10f68b5570674aa93e5e3e64871e62` |

## Boundaries

This review changed only `Tests/AINativeSyncObserverTests.m`, `Tests/verify-ai-native-sync-observer.sh` and the assigned audit materials. Production Observer and Manager changes were owned by other agents. No full package build, install, service restart, account interaction, database operation, real WeChat execution or network request was performed in this regression run. Existing `.theos` and `packages` artifacts were left untouched by this subtask.

The Manager is a deliberate fixture stub, so these tests prove Observer identity/origin publication and native call preservation, not real Manager scheduling or account resolution. The separate Manager suite and package verification remain the owner's integration gates. iOS object compilation confirms source compatibility for the two targets; it does not prove live device behavior.
