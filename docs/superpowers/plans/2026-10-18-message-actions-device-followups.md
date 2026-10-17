# 1.8-2 device regression correction plan
Approved scope: repair five user-reported1.8-1 symptoms on WeChat8.0.78, preserving established unified action design and source/account/target ownership. User explicitly includes card messages in long-press repeat.

## Task 1: Evidence-backed correction
Inspect actual menu paths/receiver ABI, text route and voice data path/readiness/feedback. Implement one coordinated fix for missing type menus, text pre-submit refusal, false normal-handoff Unknown popup and voice download stall/native false success. Preserve service proxies and account context, source immutable, unknown-no-replay, native confirmation/comments/cleanup, per-target outcomes and gesture lifecycles. Add negative regression controls and production-shaped integration tests; run relevant host suites and target syntax/build. Independent code review; fix confirmed findings.

## Task 2: Corrected release
Update version metadata/docs to1.8-2, record original1.8-1 user failures truthfully, preserve old packages. Commit source before fresh isolated Rootless dualarch build; verify actual package metadata/payload/classes/hook registration/hash and exact source commit. Retain regression/native evidence and limitations. Independent release check, preserve branch/worktree, deliver new package without installing/sending/pushing/merging.
