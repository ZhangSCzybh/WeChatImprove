# Backup configuration implementation plan

> **For agentic workers:** Use subagent-driven-development for isolated components and independent review. Track steps below; do not create additional worktrees or change the user's source/data environment.

**Goal:** Replace unsafe whole-domain backup/reset with complete plugin snapshots, safe selected restore, automatic protection and legacy import.

**Architecture:** Keep existing defaults domains and keys. A Foundation registry/codec/store/transaction core owns persistence, with an asynchronous UIKit manager and preview UI. Defer Logos installation only while an interrupted/pending restore is resolved, so feature consumers never observe partial settings.

**Tech Stack:** Objective-C ARC, Foundation/CoreFoundation/CommonCrypto, UIKit, Logos/Theos, macOS host tests.

**Spec:** `docs/superpowers/specs/2026-10-20-backup-configuration-design.md`

## Global constraints

- Existing checkout remains `/Users/zhangshichao/Documents/Workspace/WeChatImprove`; no device install, live restore, database change, message sending or package-directory clean.
- iOS minimum 15.0; arm64 + arm64e; no new third-party dependency.
- Only registered plugin keys can be written. Preserve unknown/host keys, unselected account profiles, payment ledger and statistics, authorization caches and historical backups.
- Use temporary directories and unique defaults suites for host tests. Preserve existing user changes and packages.
- Current account is rechecked before staging/applying; account profiles retain their original IDs.
- `.wcbak` v2 is binary plist; legacy imports are read-only conversions. No generic unarchiving from input.
- All file operations return errors; no partial success. Backup/restore runs off UI thread except preferences/account capture and the <=4 KiB confirmation plus synchronous callback release under the native account boundary lock. Device fsync latency remains unmeasured.

## Task 1: Exact configuration registry

Create `Controllers/CSBackupRegistry.h/.m`, `Tests/BackupRegistryTests.m`, `Tests/verify-backup-registry.sh`.

Interface:
```objc
@interface CSBackupRegistry : NSObject
+ (NSArray<NSDictionary *> *)entries;
+ (NSDictionary<NSString *, NSString *> *)moduleTitles;
+ (nullable NSDictionary *)entryForDomain:(NSString *)domain key:(NSString *)key;
+ (BOOL)validateValue:(id)value entry:(NSDictionary *)entry error:(NSError **)error;
@end
```
Domain aliases are `standard`, `legacy` (`com.cyansmoke.wechattweak`), `layout` (`com.wechat.enhance`). Entries contain `domain`, `key`, `module`, `type` (bool/number/string/data/array/dictionary), `scope` (global/account/relationship), and optional `resource` (file/contacts). Include explicit dynamic color fields and constrained per-account selection family. Exclude counts, ledger, authorization, agreement, caches and migration backup originals.

- [x] Write behavior tests for exact domain lookup, non-prefixed keys, unknown denial, nested group dates, malformed types and payment exclusion; run red.
- [x] Audit all setting writers and runtime readers; implement reviewed static entries and validators. Do not edit unrelated runtime code.
- [x] Run host tests; independently review inventory and domain mapping.

## Task 2: Snapshot codec and resources

Create `CSBackupCodec.h/.m` and `CSBackupAssets.h/.m`, with separate codec/assets/legacy test files.

Codec interface: `+encode:error:`, `+decode:error:`, `+digest:`. Snapshot dictionary has `magic`, `formatVersion`, `id`, `createdAt`, `name`, `kind`, `source`, `fields`, `assets`, `warnings`; each field stores domain/key/present/value. Assets are SHA-256 keyed data. File references become `csbackup:<digest>` placeholders, expanded only at approved resource destinations.

- [x] Assert nested NSDate/NSData survive encode/decode; corrupted digest, future schema, malformed fields and limits reject before writes.
- [x] Capture only referenced image bytes, rewrite nested contact paths, validate regular files under the resource root; reject missing files and symlinks.
- [x] Implement legacy JSON and directory parsing preserving original time and warnings for irreversible unknown values; absent legacy fields never delete current keys.
- [x] Run round-trip and malformed input tests.

## Task 3: Store and recoverable transactions

Create `CSBackupStore.h/.m`, `CSBackupEngine.h/.m`, extend core tests.

Engine uses injected defaults by alias, storage URL and resource root, and exposes synchronous serial-core methods for capture/save/list/import/preview/prepare/applyPending/cancelPending. UIKit calls these asynchronously. Plans persist source fingerprint, selected module/account set, before/after field lists and staged resource writes. Journal states prepared/applying/committed/rollingBack/rolledBack are durable; only approved entries may be applied.

- [x] Write fail-first tests for host-key preservation, original domains, selected account merge, explicit absence, old incomplete imports and revision/account conflicts.
- [x] Implement immutable snapshot publishing, index reconstruction, typed digest, and UUID-only filenames.
- [x] Stage verified restore and protection snapshot before active writes. Apply with durable journal; rollback failures keep evidence and report failure.
- [x] Test process restart and forced failure at each persistent step, including cross-process defaults persistence. Protect ledger and unknown sentinel files.
- [x] Implement count-based retention excluding manual/favorite/active protection backups.

## Task 4: Manager, scheduler and native UI

Replace `CSBackupManager.h/.m`, preserve the unused `CSBackupInfo.h/.m` compatibility type, replace backup/reset settings pages, add restore preview controller.

Manager reports asynchronous list/create/import/export/delete/preview/prepare operations and one process-wide serial I/O queue. Preview selects modules/accounts and shows changes, warnings and source. Reset uses a snapshot with absent registered fields, preserving accounts outside the selected scope. UI never sends private file messages or calls exit(0).

- [x] Add manager scheduling tests: no-change dedupe, dirty debounce, foreground catch-up, failure does not advance success, retention protection.
- [x] Use native grouped tables for list/status and module/account selection; block duplicate UI operations; import does not restore.
- [x] Preserve existing auto-enabled preference and show accurate saved/prepared/applied states. Keep old backups visible for conversion.
- [x] Verify all UIKit code through device-target build and targeted UI doubles where feasible.

## Task 5: Startup integration and existing feature preservation

Create `CSBackupBootstrap.h/.m`; modify Logos constructors mechanically to call `CSBackupWhenReady(^{ ... });`, preserving existing `%init` variants. Custom entry remains available for recovery. Asset writers are checked for capture consistency by before/after bytes and revision validation.

- [x] Test callbacks run immediately with no pending work and run once only after a successful apply/rollback; interrupted failure holds consumers while recovery entry remains usable.
- [x] Preserve normal constructor order/timing on the fast path. Pending work runs bounded asynchronous I/O, installs hooks on main after account is known; cancellation and failure states are visible.
- [x] Add migration/upgrade protection without mutating existing settings; no automatic replay of pending business tasks.
- [x] Run all existing regression scripts affected by preferences/lifecycle plus the complete suite once after changes settle.

## Task 6: Packaging, independent review and evidence

- [x] Update version to 1.8-37 in control/header/release notes and document actual behavior in README.
- [x] Run all `Tests/verify-*.sh` with saved exit codes/output; address failures in scope.
- [x] Build Rootless using isolated `_THEOS_LOCAL_DATA_DIR`, `THEOS_BUILD_DIR` and `THEOS_PACKAGE_DIR`; never override both architectures into one object directory or run make clean.
- [x] Check package version, architecture, filter, symbol UUIDs; copy only the new named package and dSYMs into packages.
- [x] Independent review of new persistence paths and Hook initialization; fix findings and rerun covering checks.
- [x] Save validation and residual device acceptance requirements. Report implementation/build evidence without claiming real-device acceptance.

## Execution notes

- 2026-10-20: User approved design and implementation. Work stays in established checkout; branch `codex/backup-configuration` isolates commits without moving source or data.
- Shared interfaces: tasks 1→2/3 use entry maps; 2→3 uses typed codec; 3→4 uses engine methods; 4→5 uses one manager instance. Each task owns its files; no concurrent edits to shared files.

- 2026-10-20 final: all six implementation tasks completed. Final 41/41 host scripts passed, Rootless arm64/arm64e package and both dSYM UUIDs verified. Exact evidence and device-only acceptance gaps are recorded in `docs/audits/backup-configuration-1.8-37/README.md`.
- Final handoff ruling: tiny confirmation is synchronously published/read back under native account lock, followed by immediate gate release; large I/O remains on the serial queue. Unconfirmed cancellation rolls back, unconfirmed replacement rejects. Scope is process-interruption recovery, not unconditional power-loss durability.
- Device installation and acceptance have not been performed. No service/database switch, live data access, Git commit or push occurred.
