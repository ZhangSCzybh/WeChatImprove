# Review outcome carried into corrected release

The parent task reports that final broad review of1.8-0 found exactly two P1 blockers:

1. Native `MMServiceWrapper:NSProxy` results were rejected by concrete-only service/account admission, leaving no action context and suppressing both plugin menus and gesture capabilities on the reported WeChat8.0.78 environment.
2. Native successful completion followed by `clearData` could reprocess the closed binding as cancellation, cancelling confirmed operations still waiting for media.

Consolidated fix `1808c982edd31e54127afba72053216dec98898b` addresses both. Parent-reported scoped reviewer `review_device_fix` marked both **ADDRESSED**, with **no new Important findings** on that exact commit. This release task consumes that result; it did not dispatch another reviewer or alter production behavior/Hook order.

The fix's permanent report and8 host logs are under `../message-actions-device-regression-2026-10-17/`. `host-regression-reference.json` records their exact hashes and successful66,626-check result, while build provenance confirms the only subsequent production/test input differences are version display and release-note metadata.

All **37** files in the native `service-entry-manifest.json` were hash-verified again during this release; `native-evidence-verification.json` records exact hashes and artifact identity. These are local8.0.78.34 static-native records, not current-phone runtime identity or device acceptance. User-reported1.8-0 failure and post-fix acceptance remain distinct: post-fix install and acceptance have not occurred.

Parent owns final scoped release review, any final branch review ledger and user delivery. Any later production change requires fresh build/package verification.
