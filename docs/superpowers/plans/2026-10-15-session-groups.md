# Session Groups Implementation Plan

> For agentic workers: use subagent-driven-development for independent components and review, with the primary worker owning native integration. User approved implementation on 2026-10-15. Do not pause between tasks.

**Goal:** Replace hidden-row filtering with per-table native session projections while retaining all existing group settings and protecting native operations.

**Architecture:** Foundation projection and account preferences feed a UIKit adapter. Native controller and table hooks form an explicit, table-local index boundary; unknown asynchronous interactions revert to native presentation before creation.

**Tech Stack:** Objective-C ARC, Foundation, UIKit, Logos, Theos, iOS 15+, arm64/arm64e.

**Spec:** ../../session-groups-refactor-proposal.md

## Global Constraints

- Keep this checkout and preserve original user modifications, device processes, settings and databases.
- No device installation or restart; no iOS device is connected. Mac WeChat is not the target.
- Build into an independent directory; never run make clean.
- Retain legacy group archives; explicit import establishes account ownership.
- Tests use memory defaults and temporary build products; source/model checks cannot establish private UIKit runtime compatibility.
- Do not commit or push changes; retain a reviewable workspace diff.

## Task 1: Foundation projection (independent worker)

Files: Controllers/CSGroupProjection.h/.m, Tests/GroupProjectionTests.m, Tests/verify-group-models.sh.

Public contract: CSGroupRow values expose nativePath (Foundation NSIndexPath with section,row indexes), userName, kind (session/aggregate/business/fake), category (unknown/group/private/service), top, unreadCount, redDot. CSGroupProjection initWithSections:tabs:selectedTabID:filterDuplicates:accountID:revision:; readonly sections, accountID, revision, valid; nativePathForDisplayPath:, displayPathForNativePath:, rowAtDisplayPath:, badgeForTabID:. CSGroupBadge exposes count and redDot. tabs are WESessionTabItem. Include identity-based action validation through current projection and account.

- [x] Write literal fixture tests for two sections, B/D filtering, all/custom overlap, duplicate exclusion, unknown/business retention, numeric/red-dot badge behavior, duplicate identity rejection, stale account/target rejection, reorder round trips and empty groups.
- [x] Observe failing tests before implementing the contract; run production Foundation code on macOS.
- [x] Implement immutable copied rows and maps with bounded lookups, no UIKit and no mutable host objects.
- [x] Run full model suite, record counts and independent expected fixtures; review implementation and spec coverage.

## Task 2: Account preferences and settings (independent worker)

Files: Controllers/CSGroupPreferences.h/.m, Controllers/CSChatGroupSettingsViewController.m, Tests/GroupPreferencesTests.m, Tests/verify-group-preferences.sh.

Public contract: CSGroupPreferences initWithDefaults:accountID:; readonly accountID, tabs, customTabs, presetNames, tabOrder, hiddenPresetTabs; selectedTabID and filterDuplicates; reload; saveCustomTabs:presetNames:tabOrder:hiddenPresetTabs:; importLegacy; hasLegacyData. CSGroupCurrentAccountID(void) is supplied by native integration, declared locally extern until header available. No default-store access in tests; use a memory NSUserDefaults subclass.

- [x] Test missing order IDs, malformed values, isolated accounts, account unknown, original archive byte retention, idempotent legacy import and persistence read-back.
- [x] Implement versioned property-list profiles with original backup and no legacy ownership assignment.
- [x] Wire existing settings to account profiles; keep appearance keys and make duplicate filtering account-scoped; remove forced exit and post the established group settings Darwin event.
- [x] Guard delayed member/rename/delete callbacks by captured account and tab ID. Add explicit legacy import entry. Verify contact selection retains hidden members.
- [x] Run tests and review original functional controls remain reachable.

## Task 3: Tab component (independent worker)

Files: Controllers/WESessionTabContainerView.h/.m.

Public contract retained; add selectedTabID and updateUnreadCount:hasRedDot:forTabIndex:. updateTabs retains selected stable ID and deterministic fallback. Fixed search/add buttons plus positive-spacing scrollable tabs. Existing callbacks still use visible index.

- [x] Replace negative-gap layout, restore accessible controls and visible add button.
- [x] Resolve dynamic colors against view traits, catch malformed legacy archived colors.
- [x] Keep haptic/indicator/selected colors and numeric badges; support dot-only unread, reduced motion and stable selection.
- [x] Cross compile the changed UIKit component for both device architectures; explicitly report absence of runtime rendering validation.

## Task 4: Native bridge and table adapter (primary worker)

Files: Controllers/CSGroupNativeBridge.h/.m, Controllers/CSGroupListAdapter.h/.m, Hooks/SessionGroupHooks.xm; integrate Hooks/ListCornerRadiusHooks.xm, Controllers/WEContactSelectViewController.m.

Contract: CSGroupCurrentAccountID returns current verified host account without cached avatar defaults. Native bridge reads original section counts and immutable row values, checks selectors/signatures and object ivar type. Adapter owns one table, original delegates, native/display scope stack, snapshot, refresh transactions and chrome; hook functions are table-qualified and main-thread only.

- [x] Test pure invocation mapping/scope and literal callback fixtures before implementing them; preserve all-or-nothing conversion.
- [x] Implement explicit known callbacks, safe forwarding policy, native table reverse queries, selectedIndexPath subclass boundary and custom selection methods.
- [x] Merge native mutations without swallowing business update blocks; publish only after outer transaction/rebuild. Cancel stale asynchronous targets, fall back before opaque action creation.
- [x] Restore native search/header; inset changes track native baseline; defer while dragging/editing, remember identity anchors, safe off/account switch.
- [x] Shared display row roles drive main-list rounded styling; no unrelated page refactor.

## Task 5: Verification and review

- [x] Run Foundation model/preferences/mapping suites, compile all new files and modified Hooks for arm64 and arm64e.
- [x] Run full isolated Theos release build/package for rootless and rootful, fixing attributable build errors without changing unrelated behavior.
- [x] Independent review of account/data safety, row/index semantics, native operation fallback, lifecycle, retained settings and tests; resolve actionable findings.
- [x] Update implementation documentation with actual files/results and explicit device validation limits, preserve the proposal as the design record.

## Execution Ledger

Baseline 3d60e63b. Existing .DS_Store modification and untracked docs, .workbuddy and CSListCardGeometry.h preserved. No other active task shares this checkout. No iOS device available; runtime capability verification is a release acceptance gate, not a reason to substitute Mac WeChat or stop implementing compile-verifiable boundaries.

Task interfaces: projection supplies rows/maps/badges to native integration; preferences supplies ordered tabs/account data to settings and integration; tab component only consumes tabs and badge values. Workers own disjoint files. Tests use Foundation row paths rather than UIKit constructors for host execution.

Execution completed for source implementation, tests and isolated two-scheme packaging. Target-device acceptance remains unperformed and is documented in docs/session-groups.md; no deployment occurred. See artifacts/session-groups-refactor-2026-10-15/BUILD-INFO.json for final source hashes and package evidence.
