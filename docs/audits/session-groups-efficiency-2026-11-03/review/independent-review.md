# Independent review of 2.2-10 efficiency changes

Reviewed the current production implementation against the frozen `baseline-2.2-9`, without device access or production edits. Only this new audit's review evidence was written.

## Scope and findings

- `CSGroupListAdapter.m`: compatibility metadata capture, complete change-name propagation, source revision guards, account/epoch/privacy boundaries, partial publication and header mutation guards.
- `WESessionTabContainerView.m`: title/badge metric caches, parent geometry invalidation, size and safe-area changes, selected-tab acknowledgements, animation continuation/cancellation, capsule layer geometry.
- Observation header, implementation and Logos hooks: formal macro isolation, ownership evidence, synchronous scopes, reload dispatch coverage, compatibility timing and outcome semantics.

No definite new correctness regression was found in the reviewed Adapter/UI changes. The compatibility metadata path keeps the existing ABI validation, native coordinate scope, whole-source identity/position/count reads and post-capture revision/account/epoch checks. Metadata reuse additionally requires the previous projection's privacy revision to match a known current policy. A source getter or header/layout callback that raises another change prevents the current publication from using the old batch's partial-refresh hint; the next batch's names remain pending.

Compatibility publication compares immutable coordinate, identity, category, top, privacy and folded-scope fields, verifies UIKit's existing section/row counts, and compares copied visible values independently of the hinted names. Account, selected-tab, privacy revision, unknown hint, anonymous/aggregate rows, scroll-to-top or shape mismatch retain the complete publication. Held layout is still released even when no row changes.

UI metric caches are keyed by rendered text and actual fonts. Parent button geometry is invalidated on tab-record changes, effective font changes, viewport changes and badge width changes. Same-width badge updates retain accessibility updates and the button's own label invalidation. Stable selection acknowledgement avoids a synchronous layout; disabling animation explicitly removes an existing animation. Equal animated targets preserve their in-flight animation. Capsule geometry uses bounds/position while scaled.

Two observation issues were reported and corrected by the root agent during review: known-hint events now validate the set and reject Unknown kinds; publication ownership now includes the main-thread route bit so completion and reload-scope verification agree.

## Runtime scope fixture

Run `python3 docs/audits/session-groups-efficiency-2026-11-03/review/observation/run-observation-review.py` from the checkout. It compiles the real observation `.m`, its real header and unchanged extracted ownership helpers against deterministic host UIKit identities. `observation/result.json` records input SHA-256 hashes and the result.

The current fixture passes 63 checks: base/inherited reload dispatch; overridden reloadData/reloadRows rejection; nested tables and a nil nested scope; exception/finally restoration; background scope isolation; main-owner eligibility without requiring a public UIViewController superclass; native and compatibility routes; folded owners; stale/missing table/owner bindings; main-thread ownership; actual known-hint validation for missing, invalid, empty, Unknown, Unread and Content|Structure inputs.

This fixture proves the C scope and owner-gate behavior for its controlled runtime. It does not prove real WeChat reload dispatch coverage, signpost delivery, actual method duration, UIKit rendering, device CPU, CA commits or frame rate.

## Measurement and optimization coverage

Signpost intervals measure elapsed synchronous time including probe and synchronous host work. Nested intervals overlap and must not be added to report CPU time or a single model round. Outer Adapter refresh/layout attempts can return early. Model, source snapshot, projection, publication, table reload, tab-record rebuild and CA commit are separate metrics. Reload counts cover verified plugin publication scopes, not every host-initiated reload. Subclass overrides or unavailable target verification produce incomplete coverage, not a measured zero.

The reviewer reported that the initial compatibility implementation's metadata fast path rejected Structure hints, whereas real named message hooks use Content|Structure. The final Bridge now admits that exact combination only after a stricter proof: equal whole-source section/row shape, valid old base Session rows and coordinates, matching current names and top flags, global name uniqueness, no reserved aggregate identity and no current aggregate flags. Changed rows still perform full metadata reads and must preserve name/kind/category. Final section and row counts are checked before any result or previous array is returned. Any failed strict proof restarts one complete build with Unknown, which disables metadata reuse and the strict proof; no partially reused result is published. A present aggregate flag must have a supported integer ABI and return zero; an unreadable flag rejects the proof and a throwing getter reaches the safe nil result. Unknown hints retain full metadata reads.

The independently reviewed final Bridge SHA-256 values are `0d32a318d0ebcb99669fa72999dd3bfdff6da7ba19eaa3fc759240cd457b255f` for the header and `ef2af4e1b7286c8a04ced929c6b30ba071bbffc71563b22164fd63d312344881` for the implementation. This includes the removal of the redundant second identity read after the strict proof. No blocking issue was found in this follow-up. Behavior regressions and measured getter counts for the real Content|Structure combination are recorded by the separate production Bridge/Adapter validation suite.

The strict path still scans every identity/top flag and checks two optional aggregate flags. Its metadata reduction must not be described as making the entire refresh O(changed sessions).

Hint events now separately identify Coordinator input (`KnownChangeHint`/`UnknownChangeHint`) and actual Adapter merge input (`AdapterKnownChangeHint`/`AdapterUnknownChangeHint`). These sources must not be added together as distinct message counts.
