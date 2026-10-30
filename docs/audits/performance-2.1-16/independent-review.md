# 2.1-16 independent review

## Backup inventory, deletion guards, and asset validation

Read-only cross-review of `Controllers/CSBackupStore.h/.m`, `Controllers/CSBackupEngine.m`, `Controllers/CSBackupAssets.h/.m`, and `Controllers/CSBackupCodec.m`, together with `backup-report.md` and the relevant `Tests/BackupPerformanceTests.m` cases. No production files were changed and no additional tests were run during this review. The reported 342 new checks and existing backup checks are execution evidence from the implementation task, not an independent rerun.

No substantive blocking issue was found in the new implementation boundaries reviewed:

- The inventory belongs to an outer serial operation and is cleared in `@finally`, including exceptional exits. Snapshot reuse checks the matching account/install source and current file identity. File discovery, migration handling, metadata checks, and full reads when identity changes remain in place.
- Restore continues through the original full snapshot validation path. Manual deletion retains filename and directory safety checks and active restore-journal protection. Automatic cleanup additionally rechecks protection metadata, the current journal, and expected file identity after the deletion callback. Invalid metadata, invalid journals, changed files, and unavailable snapshots are preserved.
- Asset freezing copies actual bytes into owned immutable `NSData`, including bytes originally backed by mutable or mapped data. Encoding validates and seals the frozen assets. Materialization independently validates every unique asset, including unreferenced entries, before validating each field reference and destination. Verification results are not reused between independent encode, decode, and materialize operations.

The existing filesystem limitation remains: an arbitrary external concurrent filesystem mutation cannot be made atomic by these checks alone. The implementation does not claim that guarantee; its operation ownership and final guards preserve the intended application-level protection.

## AI ingress read-only follow-up

The new immutable allowed-session set and epoch are read and published under `os_unfair_lock`, with a strong local retaining the reader snapshot before unlocking. The enabled state uses an atomic property, while account/session and final-send validation remain in their original main-thread paths. No blocking issue was found in the reviewed ingress publication and read boundaries. No production changes or additional tests were made for this follow-up review.
