# Scroll-position validation, 2026-11-03

This audit executes the final scroll repair against a frozen 2.2-10 baseline. Group changes share the effective height immediately before the change (`contentOffset.y + adjustedContentInset.top`); they do not restore a separate saved height for each group. Ordinary updates within one group retain the existing visible-row anchor.

`run-scroll-position-validation.py --output-dir final` executes the production native and compatibility refresh methods, saved-viewport helpers, selection, layout, search/native-navigation entries, main-owner lifecycle hooks, native drag/status-bar hooks, and compatibility `forwardInvocation:`. Model/coordinator/bridge/projection/preferences/invocation-mapper/index-scope/policy/signature files compile as full production translation units. Only the unavailable UIKit/WeChat host and dispatch clock are controlled boundaries. The existing CPU regression suites retain their original no-op scroll boundary; the separate scroll suite explicitly enables the real methods.

The geometry double retains old row rectangles/content size after `reloadData`; the new geometry and host offset clamp occur at layout. It records effective offsets, native/display index scope and geometry generation. It can defer valid geometry and synchronously overwrite the offset, inset or table from `setContentOffset` callbacks. Assertions check the resulting position and pending-state consumption, not merely whether a setter was called.

The final current-product checks are:

| Suite | Assertions |
| --- | ---: |
| Native model/coordinator/bridge/adapter/scheduling | 3382 |
| Unread panel and ABI | 77 + 7 |
| Existing preferences/incremental/badges/appearance/header | 392 |
| Independent interaction scheduling | 101 |
| Compatibility refresh/publication/source | 93 |
| Core subtotal | 4052 |
| Actual native/compat scroll position and lifecycle | 199 |
| Total, excluding repeated selection subset | 4251 |

The 2994 selection-reuse assertions are a subset of the native 3382 and are not counted twice. The prior core total was 4055. Exactly three obsolete assertions were removed because the unreachable production `returnToGroupTop`/`pendingScrollToTop` API/state was deleted: one native publication case, one compatibility publication case and one historical incremental case. The two subsequent cumulative reload expectations in that historical fixture decrease by one; their structural-mismatch and special-row fallback assertions keep their original meaning. Actual status-bar top behavior is exercised through accepted/rejected native/compat `ShouldScrollToTop` and `DidScrollToTop` callbacks.

The new position suite covers shared-height A→B→A and queued A→B→C changes; native will/didAppear resets and repeated departure; ordinary same-group row reordering; short-list clamp; deferred/invalid geometry and changed inset with an old native top offset; genuine dragging and bounce ownership; event-driven interaction completion without polling; status-bar acceptance/rejection; native search/navigation priority; synchronous reentry and host overwrite of offset/inset/table; privacy/account/epoch boundaries; deletion of a queued custom group followed by valid fallback publication and resumed anchor capture; and actual preference future-schema refusal.

Six scroll negative controls must fail at behavior assertions: frozen 2.2-10 switching and returning, ignored failed restoration, omitted final-return completion, the mutable/copy retarget identity bug, and ignored preference readback rejection. Ten existing performance/interaction/compatibility negative controls are rerun, for 16 total. Negative controls modify only temporary extracted/copied compilations.

Compatibility's positive baseline is explicitly this audit's `baseline-2.2-10`. The older interaction/selection demonstrations read the previously frozen `session-groups-interaction-2026-11-03/baseline-2.2-8` without writing it. Historical tests come from a temporary `git archive 863bfdb350fddf678c349574d99badb241d98958:Tests`; the deleted root Tests directory is never restored.

All logs and structured results live under `final/`. `seal-validation.py` verifies current production/fixture mappings, the explicitly recorded baselines, all behavior/negative-control results and assertion totals, then writes `final/validation-integrity.json` binding the result/log/fixture bytes. No device, live WeChat preferences, account data, database, service, port or package is changed. This is functional evidence; it does not establish phone CPU/Core Animation/frame-pacing improvements or replace on-device acceptance. UI and observation suites are not claimed as rerun by this validation.
