# Privacy admission cache tests

Production baseline: `8467df87bebb2998f021238b7d88eaea65266214`. Tests execute complete extracted `performSessionListLayout:` and `invalidateNativeSnapshot` bodies. Projection, policy, runtime, numeric ABI reader and index-scope implementations compile unchanged. UIKit cells/table and persistence/credential providers are explicit in-memory doubles.

| Suite | Unmodified baseline | Final source |
| --- | ---: | ---: |
| `verify-privacy-admission-cache.sh` | 218 checks / 4 failures | 218 checks / 0 failures |
| `verify-privacy-admission-cache-events.sh` | 115 checks / 6 failures | 115 checks / 0 failures |
| Total | 333 checks / 10 failures (excluded from success count) | 333 checks / 0 failures |

The original 218-check test and its script retain the exact hashes from `admission-test-freeze.json`. The additional test imports that original fixture without executing or changing its main/ assertions. `admission-test-freeze-final.json` locks all four test/script inputs. Both red runs use identical baseline input hashes; both final green runs use identical final input hashes. The additional red source is a read-only `/tmp` copy populated with `git show 8467df87:Controllers/...`; no checkout, package or `.theos` content was switched.

At K=25 and N=32, unmodified code performs **800 row hides queries**, **50 snapshot reads**, **25 original layouts**. Final code performs **32 row hides queries**, **50 snapshot reads**, **25 original layouts**. Stable runs record no dirty mark or refresh request. The four primary red failures cover this stable run and repeated scans after stable enabled/revealed/hideSessions values. Six additional red failures cover the stable admission before synchronous projection/table/native-invalidation/enabled/readability/retry changes.

Key invalidation coverage includes projection and policy identity, account, epoch/snapshot epoch, policy revision, enabled, revealed, blocked, hideSessions, unknown projection privacy revision, retry state, table identity, and explicit native invalidation. Read-only snapshot ivars are deliberately changed via KVC in isolated hostile fixtures to distinguish boolean keys while keeping identity/revision unchanged; production snapshots remain immutable. An unknown hideSessions type uses the prior uncached scan path on all three calls (96 queries), and is not accepted as a cached boolean.

Hidden-row projections never enter original layout. Policy changes during original layout shield all three fixture cells, hold layout, and produce one dirty/recovery request. On synchronous replacement followed by restoring the previous object, the next layout rescans 32 rows, demonstrating no old scan is stamped or retained for a changed boundary. Unsafe replacement projections are independently scanned and held.

Real `CSCloseFriendRuntime` public APIs cover temporary reveal, monotonic expiry, manual lock, friend/group membership insertion/removal, and changing hideContacts while leaving hideSessions enabled. Runtime mutation replaces the snapshot and advances revision. Each stale projection records originalLayouts=0, hiddenCells=3, dirty=true, requests=1; matching safe replacement resumes original layout. The provider uses an in-memory normalized profile and synthetic credentials, never real user storage or accounts.

`admission-red.log` and `admission-events-red.log` are the formal red logs; matching `*-provenance.json` files record source hashes. `admission-green.log` and `admission-events-green.log` are the formal final green logs. `admission-counts-before-after.json` contains structured raw count records. Preparation compile/runtime attempt logs and interim green attempts are retained separately and do not add to success counts. The interim 35-check `admission-reentry.log` is superseded by the final 115-check additional suite and is not counted.

These host checks do not measure real UIKit view identity, natural callback frequency, device CPU, real gesture delivery, animation composition, or intermediate screen frames. No device performance or visual conclusion is claimed. No production build, package, commit or push was performed by the test subtask.
