# Finger-drag ownership validation, 2026-11-05

The final production source passes **4,317 distinct functional assertions**: the existing 4,052 core assertions, 199 scroll-position assertions and 66 finger-drag ownership assertions. `final-result.json` verifies 410 integrity conditions across the current source, final delivery build inputs, executed fixture files and result logs. Its Adapter implementation hash is `bee5a152efd27eec8268f92ba03488fc1cb96be4dab0ee916ecb568d2f57fc62`.

The behavior being repaired is a finger drag after returning from a chat. A newer finger drag cancels every older pending height and row anchor. A viewport captured before that drag cannot later become a fresh group-switch restoration. The existing native table pan recognizer provides an independent target/action signal when the host does not forward its delegate callback. The production callback handles `Began` only and preserves the admission rules for horizontal group gestures.

## Final executed results

| Suite | Assertions | Log |
| --- | ---: | --- |
| Native model/coordinator/bridge/adapter/scheduling | 3,382 | `root-final/current-native.log` |
| Compatibility publication/source | 93 | `agent-final/compatibility.log` |
| Interaction scheduling | 101 | `agent-final/interaction.log` |
| Hidden-friend unread panel and ABI | 77 + 7 | `agent-final/unread-panel-and-abi.log` |
| Preferences/incremental/badges/appearance/header | 23 + 179 + 136 + 8 + 46 | `agent-final/legacy-core.log` and individual logs |
| Core subtotal | **4,052** | `agent-final/core-result.json` and `root-final/result.json` |
| Existing actual scroll-position/lifecycle methods | 199 | `root-final/current-scroll.log` |
| Finger-drag ownership | 66 | `root-final/current-quick-top.log` |
| Distinct total | **4,317** | `final-result.json` |

All executed commands exit with status 0. Repeated or subset runs are not counted again. The old UI/observation suites, earlier negative-control collection and model benchmark were not rerun for this repair.

The new suite runs both native and compatibility paths. It covers returning with a pending departure height; a finger drag whose delegate begin callback is missing; the real native pan target/action callback followed by dragging, deceleration completion, final appearance, layout and refresh; completed-return row anchors; a viewport retained before the drag and delivered after a group change; subsequent valid group changes and later chat returns; `Changed`/`Ended` pan events; an unrelated table pan; horizontal group-motion admission through both native-pan and delegate entries; and synchronous user cancellation while the host accepts an offset write. The existing 199 assertions continue to exercise shared group height, departure/appearance behavior, deferred geometry, privacy/account boundaries, search and native navigation.

`reproduction/baseline-table-pan.log`, `baseline-anchor.log` and `baseline-source.log` capture three functional failures against the frozen 2.2-11 implementation: the final modeled native height becomes 1150, 1180 and 1210 respectively, instead of 0. Each run stops at its first native-mode failure. They were captured while the new fixture was being developed, before its final source freeze; the final positive runs have their own complete fixture hash mapping. These captures demonstrate the source-state defects under the modeled event sequences. They do not establish the actual private callback stack in the phone recording.

## Execution and evidence boundaries

`root-final/result.json` records the quick, existing-scroll and native-core commands and their environments. The remaining commands are the same `run-native-behavior.sh` with `WECHAT_COMPATIBILITY_ONLY=1` or `WECHAT_INTERACTION_ONLY=1`, `run-unread-panel.sh`, and `run-legacy-core.py --output-dir agent-final`. Run these from the intended checkout; all artifacts belong to this new audit. The copied older comparison wrappers retain their historical baseline defaults and were not used for the final runs.

The extraction compiles the production Adapter refresh, viewport, anchor, gesture and lifecycle methods; full production model, coordinator, bridge, projection, preferences, invocation mapping, index scope and privacy/signature translation units are also compiled. Only unavailable UIKit/WeChat objects, native gesture delivery, geometry and dispatch time are controlled boundaries. The pan double models the existing recognizer's target/action delivery independently from delegate forwarding. Reload geometry remains deferred until layout, with recorded offset writes and native/display coordinate scope.

Legacy tests come from `git 863bfdb350fddf678c349574d99badb241d98958:Tests`, exported only to a temporary directory. Their compatibility adaptations remain listed in `agent-final/legacy-core-result.json`; the deleted checkout `Tests/` is not restored. These tests do not access a phone, live WeChat defaults, account data, databases, ports or services.

This is executable functional and build-source evidence. It does not replace physical-phone acceptance or establish CPU, Core Animation, energy or frame-pacing changes.
