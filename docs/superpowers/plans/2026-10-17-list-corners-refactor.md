# 列表圆角完整重构 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task.

**Goal:** 从 `2aa7bcb8 / 1.7-17` 分支完成四页列表圆角重构，保持已实现功能和其他模块行为，验证后生成 `1.7-19` Rootless 验收包。

**Architecture:** Hook 保留原生接入及回调链；四页各有专属布局适配。配置集中、几何与 section 高度纯值计算、插件拥有背景独立渲染。会话分组继续唯一拥有投影、索引、搜索表头、代理和手势。第一版不引入第二套行数缓存或数据源代理。

**Tech Stack:** Objective-C / Logos / Theos，iOS 15+，arm64 + arm64e；macOS Foundation/CoreAnimation 与必要的 UIKit 替身测试。

**Spec:** `docs/audits/list-corners-native-2026-10-17/README.md`。用户已批准完整实施及打包，并将亲自实机验收；主机验证不能标为实机通过。

## Global Constraints

- 工作目录固定为 `/Users/zhangshichao/.codex/worktrees/list-corners-refactor/WeChatImprove`，分支 `codex/list-corners-refactor-1.7-17`；原工作区不得修改源码或旧包。
- 原 30 个配置键、5 个数值范围/默认值、六套 RGBA、设置交互、重启提示、当前 reset 行为均保持兼容。全零 RGBA 哨兵语义此次保留；不能借重构修改默认透明色语义。
- 保留会话/通讯录/发现/我四页圆角、独立边距、间距、角标、状态按钮、个人资料头部和所有已有页面特例。
- 不修改 `SessionGroupHooks.xm`、`CSGroup*`、隐藏入口、自定义入口、收藏验证、搜索/标题/底栏/消息等模块。
- 不替换 delegate/dataSource/prefetch，不写主会话 tableHeaderView/contentInset/contentOffset，不建立行数投影缓存，不改变菜单手势及事件。
- 高度回调仅 `%orig` + 纯值规则，禁止表格行数/section 数查询、数据源、布局/刷新；保留每个现有高度回调一次原调用。
- 不运行 `make clean`，不安装、推送或合并。不操作微信数据库、设备或服务。包为用户实机验收，不能宣称实机通过。

## Task 1: 配置、纯策略、四页适配与回归

**Files:**
- Create: `Controllers/CSListCornerConfiguration.h/.m`，集中键/defaults 读写语义及可显式失效的配置快照。
- Create: `Controllers/CSListCornerSectionPolicy.h/.m`，只依赖值的高度及 section 装饰规则。
- Create: `Controllers/CSListCornerPageContext.h/.m`，目标页面/主表识别、背景所有权、一次操作上下文；不管理数据源。
- Create: `Controllers/CSListCornerSessionAdapter.h/.m`、`CSListCornerContactsAdapter.h/.m`、`CSListCornerDiscoverAdapter.h/.m`、`CSListCornerMoreAdapter.h/.m`，分别负责四页专属原生布局。
- Modify: `Hooks/ListCornerRadiusHooks.xm`、`Controllers/CSListCornerRenderer.h/.m`、`Controllers/CSListCornerRadiusSettingsViewController.m`。
- Test: `Tests/verify-list-corners.sh`、`Tests/ListCorner*`、必要的独立 UIKit 替身目录与生产 Hook 提取脚本。
- Remove only if verified orphan: `Headers/CSListCardGeometry.h`。

**Interfaces:**
- Preserve `CSListApplyCardBackground(UIView *, CGRect, CGFloat, BOOL, BOOL, UIColor *)` and existing `CSGroupCardPosition` signature.
- Pure section functions consume page enum, enabled flag, originalHeight, section, pinnedGap, normalGap; they have no table/view/delegate/block input.
- Per-page cell adapters consume cell, table and current indexPath/context, and only decorate verified owned lists. Explicit immutable configuration snapshot passed through one operation avoids repeated defaults reads.
- A failed group role lookup while grouping is active must not fall through to native row-count guessing. No group refresh requests from decoration.

- [x] Write meaningful regression fixtures before switching production callers: freeze 1.7-17 legal-value configuration/heights and four-page special layout requirements. Use injected in-memory defaults; never write user defaults.
- [x] Centralize keys/defaults and RGBA loading. Cache immutable numeric/color inputs, invalidate on explicit settings saves and appropriate defaults changes; select view trait style per operation. Keep save/restart behavior and numeric validation. Replace localized-title identity with item identity. Remove orphan notification sends only once local invalidation is connected. Reset must retain existing switch and gap-color behavior.
- [x] Extract all eight height callbacks into pure policy. Header examples: session 0 adds pinnedGap, 1/2 adds normalGap, others unchanged; contacts 0...3 zero, others original+10; discover/me original+10. Footer enabled: contacts zero, others 0.01. Disabled always original.
- [x] Move repeated background and ownership mechanics into context. Use associated-object ownership rather than adopting unrelated tag matches. Only plugin background is masked and non-interactive. Verify actual contentView each operation; no strong global cell/table cache. Guard invalid/zero geometry and per-object reentry; do not suppress native `%orig`.
- [x] Migrate session adapter retaining group query and native index scope. Preserve MainFrame/Fake widths, banner geometry and callbacks. Restrict to actual owner table so search results using the same class are unaffected. Do not alter group files.
- [x] Migrate contacts/discover/me preserving their distinct layout formulas and special subview roles. Prefer identified native containers/known classes to arbitrary recursive rewrites. Keep contacts first-four-section grouping but bound queries by actual sections. Use actual container width; verify idempotence for nested content and discovery badges. Retain any compatibility refresh whose replacement is unproven, clearly document it rather than deleting functionality.
- [x] Refactor profile header separately: restrict MMUIButton hooks to the actual More header, retain original callbacks, replace direct layoutSubviews/global dispatch_once with bounded normal layout invalidation, ensure frame/radius repair when native has reset them. Preserve status card and touch targets.
- [x] Test production policy + extracted Hook with a table that throws on row queries/reloads during height evaluation; run under real group index scopes. Test first/middle/last/single roles, renderer reuse and native resets, content replacement, width changes, active-invalid group paths, non-target tables and recursion. Tests must execute production logic, not merely look for strings.
- [x] Run `bash Tests/verify-list-corners.sh`. Compile changed Objective-C/Logos for both iOS architectures using isolated Theos output. Fix discovered issues. Review own diff for accidental feature loss and unchanged protected files.
- [x] Commit only Task 1 source/tests and report test output and remaining device-only verification in task report.

## Task 2: 全分支审查、版本与安装包

**Files:** `control`，`Controllers/CSReleaseNotesViewController.m`，实际显示版本的既有入口；`docs/list-corners.md`；`docs/audits/list-corners-refactor-1.7-19/`；新版本 package。

**Interfaces:** Task 1 verification command `bash Tests/verify-list-corners.sh`; unchanged group and other-feature code is the integration baseline.

- [x] Review Task 1 diff against native audit and original Hook method inventory. Resolve important findings and re-run covering regressions.
- [x] Run existing group header, search, interactions, business, selection, viewport, lifecycle, incremental, preferences, appearance and indicator tests plus my-page-clean. Record commands, counts and failures accurately; do not quote historical counts.
- [x] Update version to `1.7-19` and add truthful release notes including device acceptance boundary. No other feature code changes.
- [x] Build complete Release Rootless arm64/arm64e package from this worktree with a fresh temporary `_THEOS_LOCAL_DATA_DIR`. Preserve existing package and .theos artifacts. Use unique build output paths and do not run install.
- [x] Extract new deb into temporary inspection directory; verify control version/architecture, install location, fat library slices, dependencies, new module symbols and absence of retired `CSListHeaderHeight`.
- [x] Record package SHA-256, commit/base, protected-file hash comparison, build result and device checklist. Copy only the new `1.7-19` package to original workspace packages for convenient delivery without overwriting any existing file.
- [x] Commit scoped release/docs changes, deliver branch, worktree, package path, hash, actual tests and pending device scenarios. Leave branch unmerged for user acceptance.

## Review checklist

Task 1 internal consistency: pure section policy has no UIKit dependency; adapters may query ordinary row data only outside height callbacks; no new row-count observer system. Scope includes all four pages and settings, not only foundation extraction. Task 2 consumes the actual verification command and reviews unchanged integration owners. The original-workspace untracked stage-one plan/test are not inputs to this full branch and remain untouched.
