# Observer regression mapping for 2.1-18

This final map supersedes the preliminary read-only inventory. It records how the previous 2.1-17 suite's 828 passing checks map to the current explicit synchronization behavior. The prior tests are preserved verbatim in `baseline/AINativeSyncObserverTests.m` and `baseline/verify-ai-native-sync-observer.sh`; historical 2.1-17 evidence remains unchanged.

| Existing regression group | Final treatment |
| --- | --- |
| `Installation` | Retains missing version, 8.0.79, non-string version, off-main installation, bundle getter restoration, valid 8.0.78 installation and idempotence checks. Only the whitelisted host installs the three hooks. Unsupported hosts do not drive plugin synchronization; this is no longer described as keeping a fallback. |
| Seven independent ABI rejection processes | All seven original mode names, encodings and no-hook assertions remain. No unsupported-host or method ABI refusal coverage was removed. |
| `NativeOrderAndFIFO` | Retains native create/return/handle arguments, results, order, FIFO idle publication and one-use completion. Allows additional raw-service proof capture while requiring completion to retain the original plugin frame context, and verifies plugin `allowsRequest:NO` versus natural `YES`. |
| `BindingAndMarkerLifetime` | Prior unbound-service refusals now supply explicitly missing or stale raw context evidence. Valid raw contexts may bootstrap naturally as required. Retains nested/throwing/stale-epoch scope cleanup. New `PluginScopeOwnership` separately tests two services with valid identity so identity rejection cannot hide a frame ownership defect. |
| `CreationRejections` | Retains native refusal, no new event, getting-data/busy flags, disabled ingress, failed Manager capture, and no response/no completion checks. |
| `ResponseRejections` | All 16 selector/CGI/message/return/continuation/processed/event/concrete-class variants and consumed-token no-retry checks remain. |
| `NativeIdleRejections` | All eight initialization/pause/need-sync/error/event/busy/epoch variants and no later revival remain. |
| `ServiceEpochAndThreadRejections` | Retains cross-service response ownership, epoch revocation at three stages and off-main callbacks. The post-off-main unbound-service refusal now uses missing raw context because healthy natural first events are supported. |
| `MetadataAndNativeExceptions` | Retains eight metadata exceptions, completion exception containment and propagation of all three native exceptions with original call counts and arguments. |
| `CreationReentry` | Retains a newer native create replacing the old observed transaction and preserving its captured Manager context. |
| `MarkerClaimReentry` | Retains first-claim consumption on success/refusal/exception and capture-getter scope reentry. Missing identity makes the old unbound negative meaningful; new valid-identity ownership tests prove the frame boundary independently. |
| `LateTerminalChangesAndAge` | Retains all late response mutations, consumed-token no revival, and 44.999-second / 45-second / backwards / NaN / infinity clock cases. Result freshness remains independent of the removed request cadence. |

The added semantic coverage is split into five groups:

- `NaturalBootstrapAndRequestOrigin`: first natural scenes 37, 12 and 6 without a preceding plugin request; scene 12 outside a plugin frame is a driver; plugin frames and all scene 6 continuations are non-driving; natural → one plugin request → stop is checked through a simulated Manager callback chain.
- `ContextOwnershipRejections`: 18 invalid raw context/account/service states and five ownership changes around capture/native handling/publication. Same username with a different context object remains insufficient evidence.
- `ContextGetterReentry`: seven context/service getters replace ownership evidence, username getter revokes epoch or reenters native create, and both class context getters throw.
- `PluginScopeOwnership`: two independently valid raw services cannot share one request frame even when the first native create refuses or throws; the second service may subsequently bootstrap outside the frame.
- `PostNativeIdentityReentry`: after-original getter reentry cannot leave an old binding, event replacement cannot be revived by restoring its old scalar, queued identity getters that start a new busy sync or revoke epoch cannot publish an old completion.

The shell runner still compiles the actual production Observer and native invocation adapter with `-Wall -Wextra -Werror`, runs every independent ABI process, and optionally compiles iOS arm64/arm64e Observer objects. Its temporary Manager prefix declares the two capture overloads and the completion method with `allowsRequest:`. It supplies no real Manager implementation; Manager integration has separate tests.

Final independent result: main process 1180 checks plus seven ABI processes × 6 checks = **1222 passing checks**, and both iOS object compilations passed. Check counts include fixture assertions and repeated loop paths, and should not be read as 1222 independent product scenarios. Exact command, hashes and boundaries are recorded in `observer-independent-review.md` and `observer-independent.log`.
