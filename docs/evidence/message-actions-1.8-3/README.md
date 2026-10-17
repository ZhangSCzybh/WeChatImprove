# 1.8-3 evidence

Scope: first-batch native action/menu simplification, native sticker controller lookup, and the subsequently requested dice/rock-paper-scissors independent menu hook. Source baseline: `2c343db2f21ec04267d7390c578871ff6b080e9b`; branch `codex/message-actions-refactor-1.7-17`.

The [native report](emoticon-native/report.md) distinguishes a reproducible controller topology omission from the user's unobserved phone state, and identifies the independent game menu builder. [Native manifest](emoticon-native/manifest.json) hashes the retained metadata, bounded assembly and referenced existing send/copy evidence against the local WeChat 8.0.78.34 arm64 sample.

[Baseline negative controls](host/baseline-negative-controls.json) contain four expected assertion failures from current regression cases run against baseline Controllers/Hooks in a temporary copy. These are behavior failures, not compiler failures. Test development also encountered an initial fixture compilation issue, an incorrect stale-message identity fixture (retaining the same server ID), and a misplaced feedback-count assertion after cancelling operations; these were corrected before the passing final run.

Final host logs: [execution](host/execution.log), [core](host/message-actions-core.log), [gesture](host/message-gesture.log), [time](host/message-time.log), [merge](host/message-merge.log). All five suites passed: 522 + 1,362 + 272 + 142 + 53,200 + 2,872 = **58,370 checks**. Execution output was captured from the completed tool result; the other four stdout/stderr streams were written directly by the runner. Host doubles and isolated preferences do not establish phone execution or receipt.

[Build runner](build-release.py) records the exact source commit, command, fresh directories, toolchain, timing and exit status in `build-provenance.json` and retains `rootless-build.log`. It snapshots previous package hashes and tracked `.theos` hashes before building and verifies preservation afterward. No clean, install, native send, push or merge is part of this procedure.

[Artifact verifier](verify-artifact.py) checks the actual Debian package metadata, Rootless paths, injection filter, embedded version, exactly arm64+arm64e, 16 required Objective-C classes, 12 exports and 45 required Hook pairs per slice, including all 10 menu builders. Outputs include `artifact-manifest.json`, `artifact-verification.log`, metadata, contents and per-slice registration evidence. Static registration does not establish that the installed phone loads these hooks.

The only delivery checkout is `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`. The user's main checkout, accounts, databases and running applications are not substituted or restarted. See the [release notes](../../message-actions-1.8-3.md) for behavior, limitations and device acceptance steps.
