# Task 2 release report

Status: package and host validation complete; independent final release review and user device acceptance pending.

- Worktree: `/Users/zhangshichao/.codex/worktrees/list-corners-refactor/WeChatImprove`
- Branch: `codex/list-corners-refactor-1.7-17`; original functional baseline `2aa7bcb8 / 1.7-17`; reviewed Task 1 fix commit `de6e8273`.
- Version: `1.7-19`. Build source commit: `cc882b56444d5966e53a0a3d1f1a8b9b7a594c2a` (control, actual UI version macro, concise Chinese release notes and architecture docs synchronized). Subsequent commit contains evidence/package only.
- Package: `packages/com.wechat.improve_1.7-19_iphoneos-arm64.deb`, 745470 bytes.
- SHA-256: `ce9a6d8ff8feed4e01f64c87bc1505d2745c006d3bb419816343edc61585e03b`.

## Actual checks and scope

Task 1 final production list suite: `bash Tests/verify-list-corners.sh` — **756 checks, 0 failures** after independent review fixes. Earlier initial Task 1 state had 742 checks; the final 14 added compatibility assertions reproduced 10 failures before fixing the native status expansion and disabled-session appearance regressions. The final 756 result supersedes the earlier count; it is not an additional suite to sum.

Existing protected integration suites: 11 group commands in `existing-feature-regressions.json` total **647 checks, 0 failures**. `bash Tests/verify-my-page-clean.sh` separately reports PASS without a numeric check count. Task 2 consumes those already-run results; no source/test change required rerunning them. The build uses precisely the reviewed production list sources.

The prepared script performed a completely fresh full `make package -j4` Release Rootless build using isolated `_THEOS_LOCAL_DATA_DIR`, build/package/staging paths; architecture object directories remained Theos-owned. Exact command, temporary build path, metadata and source hashes: `build-validation.json`. Complete durable build output: `build.log`; warning extract: `build-warnings.txt`; reproducible invocation and inspection logic: `build-release.py`.

Build exit 0. Package control is `Version: 1.7-19`, `Architecture: iphoneos-arm64`, `Depends: mobilesubstrate (>= 0.9.5000)`. Extracted dylib installs at `/var/jb/Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib`, has both **arm64 and arm64e**, and exactly matches the newly merged/signed build dylib. Both slices link UIKit/Foundation and existing system frameworks plus `@rpath/CydiaSubstrate.framework/CydiaSubstrate`; both include the Rootless `/var/jb/Library/Frameworks` rpath (`per-architecture-load-commands.json`). Package also includes the existing dylib filter plist. The artifact contains version string 1.7-19.

New header/footer policy, all four page decoration functions and existing renderer symbols are present; retired `CSListHeaderHeight` and failed-refactor class symbols are absent. No warnings from changed list sources. The full build retains unrelated existing source warnings and the historical linker option warning; **202 warning lines** are retained for inspection, and this is not a zero-warning project claim.

`post-build-integrity.json`: all **174 protected source hashes**, **48 existing regression test/source hashes**, **197 build input hashes**, and **782 pre-existing .theos/package file hashes** match their recorded values after packaging. No protected behavior source changed. No original-workspace sources or packages were modified by this task; parent owns the authorized final package copy after review. No clean, install, push, merge, service operation, device access or database/data access occurred.

## Device boundary

No phone test or live WeChat startup has been performed. Host doubles validate production logic and compile/link checks validate the package; they do not establish real private view hierarchy, Hook ordering, exact rendering, touch targets, launch success or performance. All user scenarios in `ACCEPTANCE.md` remain pending, including cold launch; round-corners/grouping combinations; search and swipe; contacts/discover/my-page special entries; status expand/collapse and QR; hidden/custom entries and favorites verification; themes, type sizes and width changes. No performance numbers are claimed.

The earlier Task 1 report is preserved as `task-1-report.md` and `implementation-report.md` in this durable audit directory; independent findings and fixes are in `review.md`. Final package/evidence commit is discoverable from Git history following the source commit above.
