# Blank main-list regression validation

The final frozen-source run passed **280 native/model/bridge/adapter/scheduling checks**, **77 unread-panel checks**, **7 unread-panel ABI checks**, and the **393 existing core regression checks**. Results and per-file production hashes are in `final/behavior-result.json`, `final/legacy-core-result.json`, and the individual `final/*.log` files. Production inputs did not change during the recorded behavior run.

Run from the repository root:

```sh
python3 docs/audits/session-groups-blank-2026-11-03/validation/record-validation.py --output-dir final
python3 docs/audits/session-groups-blank-2026-11-03/validation/run-legacy-core.py --output-dir final
```

These runners compile temporary macOS Foundation executables and use process-local in-memory defaults. They do not read or write the user's preferences, WeChat account, chat database or device. Deleted workspace `Tests/` files remain deleted; existing test fixtures are exported from baseline commit `863bfdb350fddf678c349574d99badb241d98958` only into temporary directories. Earlier candidate and interim results remain in their original locations.

## What changed in the fixtures

`NativeGroupBehaviorTests.m` now matches two host details from the checked-in class dumps: `MMNewSessionMgr.m_arrSession` is an object ivar without a getter, and `MainSessionInfoItem.mainUnReadCount` returns `unsigned int`.

The previous adapter fixture replaced metadata construction and username reads with macros and used a simplified path resolver. This audit calls **the actual production `CSGroupBuildNativeSectionsReusing`, `CSGroupNativeUserNameAtPath` and `CSGroupResolveNativeRowPath`**. Native data-source methods and host session objects remain controlled fixture boundaries. The exact production adapter bodies are extracted by `extract-production-bodies.py`; this includes publication, stable-identity cell binding, shielding, fallback adoption, source notifications, bounded recovery and refresh scheduling.

`BlankRegressionFixture.h` adds regression coverage for:

- Raw `MMSessionInfo`, `MainSessionInfoItem.mainSession` and `MMBaseSessionInfo.sessionId` identity, category, unread/red-dot metadata and native path resolution, including wrappers/base sessions returned through `CellData`.
- Data-only Fake rows, stale Fake identities replaced by real sessions, valid anonymous Business rows, anonymous-to-session transitions, out-of-bounds identities and aggregate rows.
- Metadata snapshot reuse and rejection when native row counts change during enumeration.
- A nil empty top or normal partition, an optional nil all-top partition, both primary partitions still loading, delayed raw source availability, and raw unread enhancement resuming after load.
- Raw hidden flags, incompatible categories and duplicate raw identities declining statistics enhancement while the validated host presentation remains available. Privacy filtering remains active when raw statistics are unavailable.
- A concrete private ABI mismatch automatically selecting compatibility mode without erasing a ready native source.
- Fallback requests denied while privacy is blocked; filtered-source restoration; sticky fallback; native folded counts; complete-source read rejection when policy changes during the read.
- A real source mutation during fallback restore setters, preserving a newly arrived session after the canonical host rebuild.
- Partial native setter failure leaving `applied=NO`, followed by recovery of the entire host source before compatibility ownership is released.
- Rejected real bridge snapshots following the actual 0.1/0.25/0.5 second recovery sequence, followed by a valid snapshot resetting the budget. Native rebuild/source notifications occur inside the rejected metadata reads.
- Another four consecutive real bridge failures with genuine external rebuild/source notifications between attempts, after `refresh` returns and while `publishing=NO`. Those notifications preserve the attempts and generation instead of repeatedly clearing the budget. The fourth failure triggers the real coordinator fallback and adapter adoption, wraps data source/delegate/prefetch, reaches the legacy refresh entry, and keeps the privacy shield until that downstream path can publish.

The original 179 native behavior assertions are retained, with the former “raw hidden/missing means blank list” expectations corrected. One old assertion was also corrected: its simplified path resolver always rejected valid anonymous Business rows, while the production bridge permits a verified Business row to render. The 101 added assertions bring the native suite to 280. The existing unread-panel and legacy suites continue to exercise their earlier scopes independently.

The explicit negative control `WECHAT_VALIDATION_RESTORE_OLD_RECOVERY_RESET=1 bash docs/audits/session-groups-blank-2026-11-03/validation/run-native-behavior.sh` restores the removed attempts/generation reset only in the temporary extracted notification body. It fails the external-notification budget assertion, while the normal run passes. `final/old-recovery-reset-negative-control.json` and its log record that expected failure and verify the production adapter remained unchanged. The default test run never enables this control.

## Original failing-source evidence

`host-shapes-output.txt` and `host-shapes-source-hashes.json` preserve the first probe, recorded before the fixes. The ABI-accurate ivar-only raw source and unsigned wrapper both worked. However, each of the following inputs erased a nonempty native partition and left `boundary=1`:

```text
nil empty top partition: boundary=1 published_normal_count=0 native_normal_count=1
nil empty normal partition: boundary=1 published_top_count=0 native_top_count=1
unavailable raw source with ready main arrays: boundary=1 published_normal_count=0 native_normal_count=1
```

This establishes a reproducible defect in the original candidate. It does not establish which private runtime input occurred on the user's iPhone. `reproduce-host-shapes.py` retains these original files on later runs and writes current observations under `host-shapes-current-*`.

## Evidence limits

The native coordinator/model/bridge/projection/preferences compile as production translation units; extracted adapter and hook method bodies are unchanged. UIKit rendering, real WeChat synchronous table transactions, account lifecycle and native service loading still require device verification. After fallback, this fixture observes the legacy refresh entry and retained shield; it does not compile the entire legacy adapter's UIKit publication path. The 393 legacy checks exercise its projection/preferences/appearance/header logic separately. These host checks therefore do not replace installation and acceptance in the user's WeChat 8.0.78 environment.
