# SDD ledger — plan: docs/superpowers/plans/2026-10-17-list-corners-refactor.md

Base: 2aa7bcb8. Plan commit: 9c699587. User authorizes full implementation and packaging for own device acceptance.

| Tasks | Interface/shared files | Preflight result |
|---|---|---|
| 1 internal | config + pure policy + adapters + Hook + tests | Compatibility constraints explicit; no new data-source proxy or row-count cache; device-only evidence not claimed. |
| 2 internal | release docs/control/build | Unique 1.7-19 package; fresh build outputs; no install or clean. |
| 1 → 2 | verify-list-corners.sh, production changes | Review before packaging; keep protected feature source hashes equal to 1.7-17. |

Task 1: in progress, base 9c699587.

Task 1: review 9c699587..52e888b9 — 2 Important open: status content zero-height visibility regression; disabled session appearance baseline behavior. Fix round 1/5 assigned to original implementer. Existing unrelated compiler warnings recorded as non-blocking and outside protected-source scope.

Task 1: fix round 1/5 (2 addressed, 0 open; commits 52e888b9..de6e8273).
Task 1: complete (commits 9c699587..de6e8273, independent spec and quality review clean).
Task 2: in progress, base de6e8273.

Task 2: complete (commits de6e8273..b66a9dee, independent release spec/quality review clean; final user-package copy remains parent delivery step).
Final whole-branch review: in progress, base2aa7bcb8 headb66a9dee.

Final whole-branch review: clean (2aa7bcb8..b66a9dee), no open/parked findings.
Delivery: copied new1.7-19 package exclusively to original packages directory, SHA verified; original20 protected files including1.7-17 package unchanged.
Finish: user-requested acceptance package delivered; keep branch/worktree as-is, no merge/push/install.
