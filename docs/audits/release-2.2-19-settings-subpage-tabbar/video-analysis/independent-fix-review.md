# Independent review of the 2.2-19 fix and red/green evidence

Reviewed against the frozen **2.2-18** source, not against Git HEAD (which also predates earlier uncommitted releases). No production or fixture files were modified for this review. The exact diffs, before/after SHA256, fixture comparison, phase counts, sample hashes and independent binary reexecution results are retained in `independent-fix-review.json`.

## Production scope and prohibited approaches

The functional change is exactly **three files, +7 / −0 lines, five getters**:

| File | Added lines | Effective getter owners |
|---|---:|---|
| `Controllers/CSSettingsTableViewController.m` | 3 | Shared settings table base; one explanatory comment and blank line |
| `Controllers/CSAIReplySettingsViewController.m` | 2 | `CSAIConnectionEditor`, `CSAIPresetEditor` |
| `Controllers/CSScheduledTaskSettingsViewController.m` | 2 | `CSScheduledTaskTextEditor`, `CSScheduledTaskTimeEditor` |

Each getter is exactly `- (BOOL)hidesBottomBarWhenPushed { return YES; }`. This supplies the navigation contract **before initialization/view loading/appearance**, when the independently reviewed native transition code reads destination policy. It does not manually alter the native bar, observe the tab controller globally, or leave a sticky global visibility override.

No added line calls `setHidden:`, `setAlpha:`, inserts a mask/snapshot, changes content inset or scroll range, delays a callback, changes animation duration/rate, disables the style feature, writes a preference, changes a credential/permission/version gate, or adds a testing backdoor. The native tab/style production files are unchanged. The four nested plain `UIViewController` editors need their own getters because they do not inherit the shared settings table base; this is relevant coverage, not unrelated behavior change.

## Route coverage review

The generated test declarations derive the actual source `@interface` parent chain, including indirect AI-page inheritance. The shared getter covers **44 source-derived descendants**. Four directly derived UIKit editors execute extracted production getters. The two named close-friend entry labels target the same `CSCloseFriendSettingsViewController`, giving **50 test labels**, not 50 independently executed production screens.

Independently checked requested classes include account information, favorites, navigation title/avatar, avatar settings, touch trail, simplify/clean UI, bubble style, list corners, tab style, layout, attachment layout, backup/restore previews and repair, AI settings/options/history/conversation pages, and the nested AI/scheduled editors. `CSCloseFriendSettingsViewController.h` declares inheritance from `CSSettingsTableViewController`; the current route report correctly reflects this for both ordinary and avatar-five-tap entry.

The test does **not** execute those menu handlers, authentication/confirmation UI, or child implementations. It compiles the complete production shared base against a host UIKit double, then creates source-derived empty page subclasses and four getter-only editor classes. It is evidence for inheritance and policy availability. Requested real-screen paths remain **未验证**. `WEContactSelectViewController` is outside this inherited chain but has no found creation/push call site in the bounded Controllers/Hooks search; the actual contact flows use native modal pickers, which this fix leaves alone. Native/system picker runtime behavior is unverified.

## Red/green integrity and independent reexecution

The four fixture files are byte-for-byte equal between `red-runtime-2.2-18` and `green-2.2-19`:

| Fixture | SHA256 |
|---|---|
| `NavigationTests.m` | `b93313555dc4e56bd51a3b6498ee7cedf72eaef9a794a516be87ce4522c6a5a1` |
| `UIKitDouble.m` | `a0cd0ea45ba52be65df66c6780ce64a116fd3b9fa2472d0dda2ffa0f8246d0d6` |
| `UIKit/UIKit.h` | `4f70098249dc129ab96fa6caf60145b2e4188c49c9001c2d997ab2a1cdde125b` |
| `run_validation.py` | `785c92ea050af51407123d618860e308c821064185f6d665de945e297ec1e2f9` |

Both provenance records contain full compile/run commands and source hashes before/after. Their before/after sets agree. All captured production files match the recorded capture hashes. The red production captures also match the frozen 2.2-18 baseline exactly. Full red/green samples remain in their original `samples.json` files; no assertions, fixtures or original samples/logs were edited.

| Run | Total assertions | Passed | Failed | Samples | Original exit | Independent reexecution exit |
|---|---:|---:|---:|---:|---:|---:|
| Frozen old production / red | 101,400 | 83,400 | 18,000 | 49,200 | 1 | 1 |
| Fixed production / green | 101,400 | 101,400 | 0 | 49,200 | 0 | 0 |

Independent reexecution used the already-compiled immutable binaries and `/dev/null` as the JSON output destination; it did not overwrite original evidence. Logs are retained beside this report.

## It checks an intermediate policy state, with a clear modeling boundary

For each source-derived label, the fixture crosses style on/off, modal/nonmodal and three initializer choices, then repeats the cycle twice. It records root appearance, push start, **12 push-middle samples**, push completion, pop start/cancellation/retry, **12 pop-middle samples**, root/plugin-list return, main-screen exit and tab-selection cycles.

In old-production samples, **every push-middle phase has 600 visibility failures**, including `push-middle-01`; push completion also has 600. The root-before-push and root-after-pop samples themselves pass. Therefore it does not merely compare entering-before/returning-after states. The old result contains 16,800 modeled visibility failures and 1,200 before/after-view-load getter failures, totaling 18,000. The fixed production eliminates all of them under the same model and fixture.

However, the twelve push-middle samples repeat the same modeled policy/transition-copy state. They are **not twelve frames rendered by UIKit**, do not interpolate native geometry, and do not establish that the actual device never renders a capsule. The model is a compact approximation of the statically confirmed policy contract; its object `hidden`, `alpha`, `superview`, `frame` and `window` are deliberately artificial. All 49,200 samples explicitly say `host-policy-model; NOT device runtime` and `MMTabBar_runtime=UNAVAILABLE; this is a model object`. The historical output-directory label `red-runtime-2.2-18` must not be interpreted as native MMTabBar runtime evidence.

## Reverse direction and style limits

The model verifies the destination contract does not persist into an ordinary main-screen VC, root/plugin-list policy stays hidden, modal isolation is modeled, and repeated entry/exit does not carry a sticky hide override. Style on/off is only a Boolean input to this navigation model. `nativeBarCount=1` is a controlled model field; tab selection is a model property assignment.

Consequently this new fixture does **not** verify actual main-screen rounded corners, border width, scale, custom icons, hidden labels, live unread badges, selected “Me”, four-tab flicker, duplicate native views, touch interception, modal transitions or rendering with the style feature disabled. The existing style suite can independently exercise adapter behavior, but all requested end-to-end device behaviors remain **未验证**. The video fixed-ROI pop counterexample from the separate report remains relevant and has not been reinterpreted as a runtime hide event.

Review outcome: the minimal production implementation is consistent with the statically confirmed navigation contract and stays within the prohibited-change boundaries. Host red/green evidence is intact and catches intermediate **modeled** visibility. Actual runtime phase logs and fixed-device acceptance cannot be claimed from this evidence.
