# Service row shielding probe

The initial red run used untouched `58e0b0dfc611e14aa2d2f8e07c0f2ffb80a7ec6a` production source. `red-provenance.json` records source equality and SHA256. Command: `bash Tests/verify-group-service-shield.sh`. Result: **490 checks, 20 failures**; the red run is excluded from successful regression totals.

The test executes extracted `shieldVisiblePrivateRows`, the complete production shield implementation, the real proxy, native bridge, projection, and `CSCloseFriendSnapshot`. UIKit cells/table geometry are deterministic host doubles. `miniapp-container-return` and `chat-return` are controlled entry labels, each with **zero standard appearance callbacks**; these labels do not assert the phone's natural callback sequence.

For each of `brandsessionholder` (公众号) and `brandservicesessionholder` (服务号), the baseline locked-ready input gives:

| Predicate / result | Host value |
| --- | --- |
| delivered row known and same account | yes |
| `unknown` | 0 |
| `hidesUserName:surface:Session` | 0 |
| `kind == Aggregate` | 1 |
| `protectedUserNames.count` | 2 |
| `Aggregate && protectedUserNames.count > 0` | 1 |
| cell hidden after shielding | 1 |

This proves the blanket aggregate predicate independently causes the two holes, without missing delivery or account mismatch. It does not prove which predicate ran on the user's phone. Each controlled locked Whole/Service entry hides **2 harmless aggregate rows**; the Group/Friend fixtures contain **0 service aggregates**, consistent with the actual membership logic. Unlocked Whole/Service entries hide **0 harmless rows**. In unlocked-to-locked stale deliveries the **2 real protected rows** are hidden, and the **2 harmless aggregate rows** are incorrectly hidden too.

The shield itself causes **0 reloadData**, **0 reloadRows**, and **0 contentOffset writes**. It preserves contentSize/offset while setting cell.hidden. The distinct UI proxy neutral-count path and actual gesture behavior are outside this probe; see the scroll probe and device evidence limits in the release audit.

Every predicate and per-stage result is preserved in `red-current-untouched30.jsonl`; failed assertions are in the paired `.stderr`. The harness asserts both harmless aggregate identity and ordinary row visibility, causing 20 failing assertions from 12 incorrectly hidden row occurrences (overlapping harmless/aggregate assertions are intentionally distinct contracts).

The final harness additionally tests 20 unknown-content inputs: miniapp/chat controlled entries × nil policy, blocked policy, missing delivered identity, delivered-account mismatch, policy-account mismatch × existing mask nil/non-nil. The final **unchanged harness** run against frozen baseline adapter/hooks/shield reports **706 checks, 76 failures**; current production reports **706 checks, 0 failures**. See `red-unknown-frozen30.{jsonl,stderr}`, `green-service-shield.{jsonl,stderr}`, and `complete-provenance.json`. Frozen baseline source bytes are verified against the immutable Git commit, rather than using a modified current shield with old adapter source. Red passes are excluded from success counts.

The initial extended attempt had 690 checks and emitted Objective-C duplicate-class warnings for fixture `CALayer`/`CATransaction`. Those logs are retained as `*-attempt1.*`. Renaming the fixture runtime classes removes the ambiguity; final red/green stderr contains only failures/result text, with no duplicate-class diagnostics. Sixteen final assertions also require a known-ready return to avoid an unnecessary whole-list neutral mask.

After the fix, all 20 unknown inputs use one empty content-layer mask, expose no content to accessibility, and change **0 individual cell.hidden flags**. Repeated unknown shielding retains the same mask identity. There are **0 reloads and 0 offset writes**; contentSize is retained. `prepareForPublication` retains the whole mask, so preparing reused cells cannot uncover stale rows. `finishTablePublication` restores exactly the previous layer mask and accessibility flags after a controlled verified-readiness stage. Whole/Service locked-ready returns now hide **0 harmless aggregate rows**; both real protected stale deliveries remain individually hidden. All stage metrics are compared in `stage-comparison.json`.

These are direct production-body operations on host doubles. They do not prove Core Animation's screen rendering, the phone's touch chain, or its callback schedule. The empty-mask privacy assertion describes the production layer property contract; actual intermediate screen frames require device recording.

## Completion safety follow-up

`GroupNeutralCompletionTests.m` covers the release of a complete content mask after readiness. On immutable 2.1-30 its **36 checks / 15 failures** are retained in `red-completion-frozen30.*`. On the initial 2.1-31 draft before adding the helper, the same assertions report **36 / 19 failures** (`red-draft-completion.*`). One initial compile attempt lacked newly introduced fixture properties; it is retained as `red-draft-completion-compile-attempt1.*` and does not count as a red assertion run.

Final completion result is **36 / 0** in `green-completion-final.*`; final Service result is **706 / 0** in `green-service-final.*`. The final Service baseline control, with the current fixture and immutable original production adapter/hooks/shield, is **706 / 76** in `red-service-final-frozen30.*`. Successful checks from these two final suites total **742**, without adding prior attempts or any red-run passes.

The completion fixture deliberately replaces one visible cell either with a marked blank placeholder or an unassociated raw cell whose text contains a protected identity. The production helper requests **one local row refresh**, retains the content mask during layout, invokes **zero protected native cell getters**, and uses **zero full table reloads**. If a controlled synchronous callback changes the policy during that repair, the mask remains installed. If readiness stays current, final visible placements match the filtered projection before the mask is removed. The fixture also covers ready filtered and native-unlocked layouts while a publication is in progress: nested layout retains the mask and requests a natural completion layout, then an idle layout completes it without depending on an optional native scroll callback.

The production helper does not reconfigure known matching banner cells. It validates `indexPathForCell:` under display coordinates, invalidates temporary neutral height metrics through a layout-only update, repairs only mismatched visible placements, restores the saved safe offset after measurement/repair, and rechecks account/epoch/policy admission after every operation that may reenter native code. The six protected definitions remain outside these edits. The isolated old Privacy/Layout fixtures explicitly stub the new completion stage; Container and this dedicated suite extract and execute its real implementation.
