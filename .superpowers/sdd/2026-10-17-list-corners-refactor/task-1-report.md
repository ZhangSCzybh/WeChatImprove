# Task 1 implementation report

Status: DONE_WITH_CONCERNS — implementation and host/build checks complete; device acceptance remains required.

Workspace: `/Users/zhangshichao/.codex/worktrees/list-corners-refactor/WeChatImprove`

Branch: `codex/list-corners-refactor-1.7-17`; starting commit `9c699587` (approved 1.7-17 baseline plus planning evidence). No source changes were made in the original workspace. No service, account, database, device, install, package, release version or protected feature source was modified by Task 1.

## Delivered implementation

- `CSListCornerConfiguration` owns the original 30 persisted key names, five numeric defaults, injected defaults storage, six RGBA color sets and immutable cached snapshots. Operations resolve light/dark colors from the target content/table trait. All-zero RGBA sentinel semantics remain unchanged. Explicit saves synchronize and invalidate; defaults notifications only invalidate, with no write/synchronize on the observation path.
- Settings use centralized loading and writes, retain the five existing picker ranges (radius 5–30, left/right 1–30, pinned/normal gap 0–50), restart prompt and existing reset behavior. Reset keeps the enabled switch and all gap colors. Preview selection uses item identity. Orphan Darwin notification sends were replaced by actual local invalidation through the save API.
- Foundation-only `CSListCornerSectionPolicy` consumes values only. All eight height callbacks keep exactly one original call, then apply the pure policy. Main-table identity checks use only runtime class/ivar identity, never row/section/layout/data-source queries. Contacts first-four headers are zero and footer zero; other existing gap and footer formulas remain compatible.
- `CSListCornerPageContext` verifies the controller's actual primary-table ivar and follows bounded responder ownership for cell-level callbacks. No data source/delegate, projection cache, table-header, inset, offset or grouping lifecycle ownership was added. Every operation re-reads actual contentView. Geometry stays local to that actual container, preserving native swipe translation. Invalid/zero geometry is ignored.
- Plugin backgrounds use associated-object ownership, never adopt native tag matches, remain noninteractive, and repair reset frame/color/mask properties. Replaced content containers receive a fresh background and the previous plugin background is detached. Only plugin background layers receive card masks. Known native item/subcontent background roles are cleared; unrelated native views and menu containers retain their state.
- Four independent page adapters contain existing distinct layout formulas. Session retains MainFrame/Fake nominal widths, banners, actual group role lookup and native/display index scope. Active-invalid group role paths never query native row counts. Contacts bounds first-four-section aggregation by actual section count and preserves native ContactsItemView internals. Discover retains direct/nested icon/text/rich-text formulas and badge spacing; original/applied frame tracking makes repeated decoration idempotent. More retains direct cell layout and actual owner-table boundaries.
- Profile-header adaptation is separate and restricted to the actual More primary table's header. It retains native visible header color, avatar/text/status/QR positioning, expanded height and touch targets, uses actual table width, and only rounds a plugin-owned backing view. Global dispatch_once and direct layoutSubviews calls were removed. Frame corrections use normal setNeedsLayout only when a correction is necessary; native resets are repaired.
- The established Discover viewWillAppear asynchronous one-shot reload is intentionally retained. Its replacement has no device evidence, so removing it would be an unverified behavior change.
- `Headers/CSListCardGeometry.h` was removed only after `rg` confirmed it had no production or test callers.

## Verification and actual output

`bash Tests/verify-list-corners.sh`

```text
List corners: 742 checks, 0 failures (production modules, extracted Hooks + group role function, real index scopes; host doubles, no device rendering claim)
```

The command compiles the actual production configuration, policy, context, renderer and four adapters with isolated UIKit doubles. It extracts all eight current height Hook bodies, the two global cell layout Hook bodies, the existing production CSGroupCardPosition implementation, production reset mutations and the five picker validation bodies. It links the unchanged production CSGroupIndexScope implementation. Storage is an injected in-memory fixture; shared configuration is overridden in the test process before any production storage access. Tests never write real user defaults.

Coverage includes all 30 keys, six RGBA sets and sentinel colors, cache identity/invalidation, synchronous save persistence, notification no-write behavior, reset retention, all 285 integer picker-range cases, enabled/disabled heights, original-call counts, real native/display group scopes, query/reload-throwing tables during height evaluation, non-owner tables, group active-invalid paths, all four corner roles, cached path reuse, native mask/frame/color reset repair, content replacement and old-background cleanup, width changes, local swipe coordinates, opaque known native backgrounds, Contacts short-section/nested layout, Discover badges and nested MMUIView/rich text, profile status/QR/expanded height, disabled/non-target global layout query exclusion and layout/contentView reentry.

Fresh isolated iOS build:

```sh
TASK_THEOS_DIR=$(mktemp -d /tmp/list-corner-ios-fixed.XXXXXX)
make -j4 SCHEME=rootless _THEOS_LOCAL_DATA_DIR="$TASK_THEOS_DIR"
```

Actual fresh output directory: `/tmp/list-corner-ios-fixed.dgIcXX`; log `/tmp/list-corner-ios-fixed-build.log`. After final covered source corrections, the same isolated build directory was used to rebuild changed translation units and re-link:

```sh
make -j4 SCHEME=rootless _THEOS_LOCAL_DATA_DIR=/tmp/list-corner-ios-fixed.dgIcXX
```

Final log: `/tmp/list-corner-ios-final-incremental.log`. Exit 0; both architectures compiled and linked, then merged and signed. No warnings from changed Task 1 sources in the final build. Existing warnings remain in unrelated hooks, plus the pre-existing obsolete `-multiply_defined` linker warning.

```text
Architectures in the fat file: /tmp/list-corner-ios-fixed.dgIcXX/obj/WeChatImprove.dylib are: arm64 arm64e
```

An earlier attempted build explicitly overrode THEOS_OBJ_DIR and failed because both architecture jobs shared/deleted Logos intermediate files. That invocation was corrected by overriding only `_THEOS_LOCAL_DATA_DIR`, letting Theos create its own architecture subdirectories. This was a build invocation issue, not a source compile failure. No make clean, install or package command was run.

Additional self-review:

```text
Hook inventory: 35 35 missing: set() added: set()
Protected source differences against 9c699587: none
```

`git diff --check` passes. Search of changed production modules found no delegate/dataSource replacement, group refresh request, main-table header assignment, inset/offset write or direct layoutSubviews call. Task 2's parent-owned regression/audit files were not staged by Task 1.

## Remaining actual limitations

These are host behavioral tests and compiler checks. They do not establish live WeChat UIKit hierarchy, Hook ordering, exact device pixels, frame rate/memory, cold-launch success, long text/dynamic type, or all combinations of hidden/custom entries, favorites verification, status expansion/dragging, QR touch areas, side swipe/search and grouping. Unknown native content roles are preserved rather than recursively rewriting arbitrary labels/images; device acceptance should especially inspect opaque/new private containers and status-card boundaries. The original broad line/subview scanning was narrowed to known owned roles; native separators outside those verified roles need visual acceptance.

The final user package, release metadata, independent review, protected regression evidence and device checklist belong to Task 2. No device installation or acceptance claim is made here.
