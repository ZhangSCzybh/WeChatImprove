# 2.2-1 Adapter CPU host replay

Pinned source: `8467df87bebb2998f021238b7d88eaea65266214` (macOS arm64). This is a read-only host analysis: no repository source, test, build input, package, or production build was changed by this probe.

## Result and limit

The extracted production code has a **conditional** self-exciting path. With a conservative dirty-only table that clears its dirty flag before the layout override, one persistent invalid/nil native-snapshot input produces 4 refresh calls, 2 layout-guard calls and 5 queued callbacks, then drains. It does not demonstrate sustained idle CPU. With a table that keeps its dirty flag until the native original layout executes, the same single input produces 512 refresh calls and 512 guard calls before the event cap, with 2 callbacks still pending. Whether real UIKit retains or repeatedly reasserts layout dirtiness while this hook skips the original is not measured here.

The third, always-layout variant is a deliberate positive control. Treating every `layoutIfNeeded` as an unconditional layout would manufacture the loop; its results are not UIKit evidence. Valid snapshots, valid empty snapshots, and a single stale epoch or policy revision with a healthy source drain in all models. An explicitly supplied 60 Hz input causes exactly 60 refresh calls and 60 guard calls; this must not be described as autonomous 60 Hz work.

## Reproduce

Needs the pinned checkout, Apple Command Line Tools, macOS Foundation, Python 3, and bash. Run:

```sh
CP_REPO=/Users/zhangshichao/Documents/Workspace/WeChatImprove \
CP_OUT=/tmp/wechat-221-cpu-replay-reproduced \
  /tmp/wechat-221-cpu-replay/run.sh
```

`build.py` refuses a different HEAD or any selected source/header bytes differing from that HEAD. `source-provenance.json` records complete method hashes, original Adapter line numbers and input SHA256. `compile.log` is empty on this successful `-Wall -Wextra -Werror` host compile. `verify_results.py` validates the reported count relationships.

## What executes

Complete Adapter method bodies are extracted, with selector renaming only to insert call/CPU wrappers: `refresh`, `layout`, `performSessionListLayout:`, `requestRefresh`, `requestRecovery`, `scheduleRefresh`, `nativeSectionsForAccount:`, `projectionForSections:tabs:selectedTabID:accountID:`, and `publishProjection:previous:changes:previouslyProjecting:`. Relevant header publication, search, invalidation and cancellation methods are also extracted. Production `CSGroupProjection.m`, `WESessionTabItem.m` and `CSCloseFriendPolicy.m` compile directly; ListShield method bodies are copied without imports. Instrumentation records thread CPU (`CLOCK_THREAD_CPUTIME_ID`), monotonic wall time, call counts, and inclusive/exclusive CPU for the wrapped methods.

Boundaries are explicit doubles: UIKit views/tables/gestures, native table source, display/native index scopes, preferences reload, folded source, chrome/badge UI, title and scroll-anchor actions, native action handling, and independent badge-source maintenance. The latter is counted but not executed. Integer property reads use fixture KVC. This is not an execution of the whole WeChat process, actual private native getters, real table cells, scrolling, animation, or natural UIKit callbacks.

The deterministic dispatch queue runs one callback at a time, bounded at 512 events and a 250 ms virtual window (1.1 s for external 60 Hz). Virtual time advances by callback wall duration and jumps to due timers. Production async/timer branches and delay values remain unchanged. Immediate queued work can reach the count cap before the 50 ms retry is due. These counts establish behavior within the stated host scheduler; they do not establish an infinite loop or actual device callback frequency.

### Table layout assumptions

| Mode | Admission to layout override | When dirty clears |
| --- | --- | --- |
| `strict-layout` | Only when dirty; reloadData, nonempty reloadRows and table-header publication set dirty | Before entering the override |
| `dirty-until-original` | Same dirty-only admission | When native original layout actually executes |
| `always-layout-positive-control` | Every layoutIfNeeded, including a clean table | When native original executes; deliberately unrealistic control |

Neither dirty-clear timing has been observed on the phone. Chrome stubs do not dirty the table every call; current production `updateTabs` and appearance setters contain equality returns, so unconditional chrome-driven invalidation must not be assumed.

## Single-input and external-input counts

Invalid fixtures use duplicate session usernames on canonical native index paths, causing the actual projection validator to reject the immutable source. The nil fixture is a separate native-source read failure. Protected names are synthetic and do not match the generated safe rows. Blocked policy is an explicit distinct control.

| Model | Case | External inputs | Refresh | Guard | Native original layout* | reloadData* | Pending | Cap reached |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| strict-layout | valid-empty-native | 1 | 1 | 1 | 1 | 1 | 0 | no |
| strict-layout | valid-both-on | 1 | 1 | 1 | 1 | 1 | 0 | no |
| strict-layout | invalid-both-on-rev2 | 1 | 4 | 2 | 0 | 2 | 0 | no |
| strict-layout | invalid-both-on-rev0 | 1 | 4 | 2 | 0 | 2 | 0 | no |
| strict-layout | nil-native-both-on | 1 | 4 | 2 | 0 | 2 | 0 | no |
| strict-layout | invalid-group-only | 1 | 4 | 2 | 0 | 2 | 0 | no |
| strict-layout | invalid-privacy-only | 1 | 4 | 2 | 0 | 2 | 0 | no |
| strict-layout | invalid-both-off | 1 | 1 | 0 | 0 | 0 | 0 | no |
| strict-layout | blocked-policy | 1 | 1 | 1 | 0 | 1 | 0 | no |
| strict-layout | single-stale-epoch | 1 | 1 | 2 | 2 | 2 | 0 | no |
| strict-layout | single-stale-policy-revision | 1 | 1 | 2 | 2 | 2 | 0 | no |
| strict-layout | externally-driven-60Hz | 60 | 60 | 60 | 60 | 60 | 0 | no |
| dirty-until-original | valid-empty-native | 1 | 1 | 1 | 1 | 1 | 0 | no |
| dirty-until-original | valid-both-on | 1 | 1 | 1 | 1 | 1 | 0 | no |
| dirty-until-original | invalid-both-on-rev2 | 1 | 512 | 512 | 0 | 1 | 2 | yes |
| dirty-until-original | invalid-both-on-rev0 | 1 | 512 | 512 | 0 | 1 | 2 | yes |
| dirty-until-original | nil-native-both-on | 1 | 512 | 512 | 0 | 1 | 2 | yes |
| dirty-until-original | invalid-group-only | 1 | 512 | 512 | 0 | 1 | 2 | yes |
| dirty-until-original | invalid-privacy-only | 1 | 512 | 512 | 0 | 1 | 2 | yes |
| dirty-until-original | invalid-both-off | 1 | 1 | 0 | 0 | 0 | 0 | no |
| dirty-until-original | blocked-policy | 1 | 1 | 1 | 0 | 1 | 0 | no |
| dirty-until-original | single-stale-epoch | 1 | 1 | 2 | 2 | 2 | 0 | no |
| dirty-until-original | single-stale-policy-revision | 1 | 1 | 2 | 2 | 2 | 0 | no |
| dirty-until-original | externally-driven-60Hz | 60 | 60 | 60 | 60 | 60 | 0 | no |

*For the once-stale cases, native-original/reloadData state counters include the warm-up publication (one original layout and one reload). Profile method counts reset after warm-up. Thus a stale case has one observed external guard entry plus its recovery-publication guard, one recovery refresh, and only one additional reload. For other non-cost cases there is no warm-up.

### Why fallback can remain held

At Adapter lines 659–664 readiness requires matching account/epoch/privacy revision, valid projection, **and `!snapshotRetryAttempted`**. Failure fallback sets retry at 989–995, and creates an empty projection at 998–1000 through a constructor whose default revision is 0 (`CSGroupProjection.m:129`). Therefore revision 0 alone is not the cause: policy revision 0 also holds because retry remains true. The normal successful projection clears retry at 985.

The held guard sets dirty (672); publication invokes layoutIfNeeded (940); refresh clears privacyRefreshPending and finally schedules dirty work (904, 917). Under retained dirty state this closes a repeating path without repeated reloadData: at 512 refreshes, reloadData is still only 1. In the strict model the next identical empty projection needs no row reload and its clean layoutIfNeeded is a no-op. A 50 ms retry followed by the existing recovery schedule yields a second finite pair. The queue drains at roughly 150 ms virtual time, with held/retry still true. A drained CPU queue does not mean content recovered.

## N / M scale

20 direct production refresh calls per row below, after one warm-up. N is native row count, M is 1 All tab plus M−1 custom tabs with one member each. V=12 cell doubles, but visible index paths are empty: the CPU measurements omit real visible-cell delivery and row reload work. `cached-identical` retains the immutable native snapshot; `new-structure` replaces row identities and invalidates the native snapshot each iteration. Synthetic row construction occurs outside the timed production refresh. Timings are instrumented host CPU milliseconds, not phone CPU percentages. No extrapolation to arbitrary tab memberships or real native snapshot construction is justified.

| N | M | Cached total refresh CPU ms | New structure total refresh CPU ms | New structure projection CPU ms | New structure guard CPU ms |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 100 | 4 | 0.959 | 2.926 | 2.004 | 0.370 |
| 100 | 12 | 1.103 | 3.155 | 2.162 | 0.375 |
| 1000 | 4 | 7.030 | 27.141 | 19.037 | 3.524 |
| 1000 | 12 | 7.132 | 27.169 | 19.154 | 3.467 |
| 10000 | 4 | 77.097 | 276.174 | 193.674 | 33.726 |
| 10000 | 12 | 78.880 | 283.216 | 199.918 | 34.262 |

Cost-case state counters include the warm-up reload: cached count 1 means no timed refresh reload; fresh count 21 means 20 timed refresh reloads plus warm-up. Timed guard calls are respectively 0 and 20. The direct workload completes before the bounded queue pump, so its pump-only CPU can be near zero while refresh CPU is nonzero.

### Method tops from this run

CPU is exclusive unless marked inclusive. Projection method time includes actual production projection internals and policy/folded-boundary work; those internals are not independently wrapped. Refresh self time includes unwrapped refresh-internal operations, not simply source lines directly in refresh.

| Model / workload | Method | Calls | Inclusive CPU ms | Exclusive CPU ms |
| --- | --- | ---: | ---: | ---: |
| strict-layout / externally-driven-60Hz | `projectionForSections:tabs:selectedTabID:accountID:` | 60 | 17.324 | 17.324 |
| strict-layout / externally-driven-60Hz | `performSessionListLayout:` | 60 | 10.531 | 10.531 |
| strict-layout / externally-driven-60Hz | `refresh` | 60 | 28.408 | 0.378 |
| strict-layout / externally-driven-60Hz | `layout` | 60 | 0.100 | 0.100 |
| strict-layout / cost-cached-identical | `projectionForSections:tabs:selectedTabID:accountID:` | 20 | 64.804 | 64.804 |
| strict-layout / cost-cached-identical | `publishProjection:previous:changes:previouslyProjecting:` | 20 | 13.858 | 13.858 |
| strict-layout / cost-cached-identical | `refresh` | 20 | 78.880 | 0.161 |
| strict-layout / cost-cached-identical | `layout` | 20 | 0.052 | 0.052 |
| strict-layout / cost-new-structure | `projectionForSections:tabs:selectedTabID:accountID:` | 20 | 199.918 | 199.918 |
| strict-layout / cost-new-structure | `refresh` | 20 | 283.216 | 48.315 |
| strict-layout / cost-new-structure | `performSessionListLayout:` | 20 | 34.262 | 34.262 |
| strict-layout / cost-new-structure | `nativeSectionsForAccount:` | 20 | 0.623 | 0.623 |
| dirty-until-original / invalid-both-on-rev2 | `projectionForSections:tabs:selectedTabID:accountID:` | 512 | 17.212 | 17.212 |
| dirty-until-original / invalid-both-on-rev2 | `refresh` | 512 | 22.708 | 2.919 |
| dirty-until-original / invalid-both-on-rev2 | `layout` | 512 | 0.760 | 0.760 |
| dirty-until-original / invalid-both-on-rev2 | `performSessionListLayout:` | 512 | 0.702 | 0.702 |

## What is not proved

No device CPU profile, real UIView identity, real touch chain, real display frame, or natural idle/layout/notification frequency was measured. Source snapshot failures are controlled inputs, not observed phone incidents. The production native bridge can return nil for signature/logic mismatch (CSGroupNativeBridge.m:503–508), invalid counts (513–520), row/section count drift during read (556, 559), or exception (562); Adapter also rejects completed reads when account/epoch/model revision drifts (778). These concrete source paths establish reachability conditions, not their frequency or persistence on the phone.

To establish this candidate as the actual CPU cause, a device trace must correlate native snapshot success/retry, model revision/epoch, natural table layout entries, guard orig/hold decisions, refresh scheduling reason, and main-thread samples while no external events are supplied. Especially verify whether a held guard leaves or reasserts UIKit layout dirtiness. No fix or production instrumentation is included in this task.

## Files

- `run.sh`, `build.py`, `QueueAndProfile.h`, `FixtureTail.m`, `summarize.py`, `verify_results.py`: reproduction and checks.
- `source-provenance.json`, `ProductionBodies.h`, `FixturePrefix.m`, `Replay.m`: pinned inputs and generated fixture.
- `*-results.json`, `*-run.log`: raw counters, state, queue samples and method CPU/wall measurements for each table mode.
- `summary.json`, `method-top.json`: compact count/cost tables and sorted method tops.
- `compile.log`, `result-validation.log`: host compilation and result assertions.
