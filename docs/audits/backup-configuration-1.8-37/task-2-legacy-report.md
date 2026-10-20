# Task 2 report: read-only legacy backup conversion

Implemented the requested `+[CSBackupLegacyReader readURL:standardDomain:error:]` interface in `Controllers/CSBackupLegacyReader.h/.m`, with `Tests/BackupLegacyTests.m` and executable `Tests/verify-backup-legacy.sh`. No codec/assets/registry/runtime/settings files were changed during this task.

## Source evidence

Before the manager refactor, copied the existing manager to `/tmp/CSBackupManager-before-refactor.m` and inspected its real create/export/import/index logic. Its old exported protocol is JSON with `version: "1.0"`, `backupInfo`, export `createDate`, and `settings`. Preference domains appear as exact plist basenames without `.plist`. Top-level NSData values are `{__type__:"data", value:base64}`; nested non-JSON-safe values become an irreversible `{__type__:"unknown", value:description}` wrapper for the entire setting. `settings.WeChatImprove` is a recursive folder dictionary whose file leaves are base64 strings.

Old local backups are UUID directories containing copied plist files and an optional `WeChatImprove` resource tree. Their original metadata is **not inside the directory**: it is in the sibling parent `backup_info.json` array. The converter therefore requires its exact matching `backupId` record and preserves that record's original `createTime`, name and ID. It does not substitute directory mtime or import time. The old metadata's absolute `filePath` is ignored.

## Behavior

- Accepts both old `.wechatbackup` and `.wcbak` JSON files, plus original UUID backup directories. Binary-plist files return nil with no legacy error so the manager can use its v2 codec dispatch.
- Maps only exact standard-domain names supplied by the manager and `com.tencent.xin`, plus exact `com.cyansmoke.wechattweak` and `com.wechat.enhance` suite names. Local filenames must be those domain names plus `.plist`; no substring inference.
- Extracts only registered, explicitly present fields. It never emits `present:NO`, never modifies active preferences and never creates an inferred missing preference.
- Filters host/payment/protected keys and unknown domains with disclosure. Registered `__type__:unknown` fields are omitted with module/key-specific incomplete warnings; description text is never evaluated or unarchived.
- Preserves NSData wrapper bytes and local plist nested NSDate values. Wrong supported-key types, malformed wrappers, future legacy versions, missing metadata/settings and conflicting host-domain variants fail clearly.
- Flattens recursive JSON base64 resources or reads the local resource tree. Rewrites referenced top-level and nested-contact paths to `csbackup:<digest>` references. Known old fixed filenames include navigation/touch images and all eight normal/selected tab icons. Absolute old sandbox paths are never opened; only exact bundled basename matches or key-owned fixed fallback bytes are used. Ambiguous basenames fail.
- Captures only referenced image bytes into v2 assets, deduplicates by digest and warns about unreferenced old resources. A missing/invalid referenced image fails the conversion rather than silently dropping the field.
- Returns a canonically encoded and decoded valid v2 snapshot, including integrity. Creation date and original UUID remain unchanged; kind is `imported`. Source account and installation identity remain empty because the old format cannot prove them, and warnings disclose that limitation.

## Bounds and filesystem protections

Reads are capped at 32 MiB in aggregate, with the sibling index limited to 4 MiB; resource limits are 4 MiB per file, 24 MiB total, 256 files and 16 directory levels. Input containers are limited to 32 nested levels and 60,000 objects; output passes all current v2 codec limits. Local resources and recognized plist/index sources must be regular files. Reads open every path component with `openat`/`O_NOFOLLOW`, inspect file identity/size, read bounded bytes and reject source changes. Nonblocking opens prevent FIFO inputs from hanging before regular-file validation.

User-controlled symlinks, unsafe path components, NUL names, backslashes and traversal are rejected. Apple's fixed root-owned `/var -> private/var` and `/tmp -> private/tmp` aliases are accepted explicitly because Foundation's standard iOS container and macOS temporary URLs use them; this does not authorize links inside a backup or its parent. No imported filesystem targets are created. No staging directory is needed by the reader.

## Tests

Created the tests before implementation. Initial red command:

```sh
bash Tests/verify-backup-legacy.sh
```

Result: expected exit 1 because `CSBackupLegacyReader.m` did not yet exist.

Final command is the same. Result: **87 checks passed**, exit 0. It compiles with real macOS Foundation/CoreFoundation/ImageIO/CoreGraphics, ARC, blocks and `-Wall -Wextra -Werror` (existing CommonCrypto deprecation disabled). Coverage includes both old extensions, all domain mappings and substring-denial, original dates/IDs, protection filtering, unknown/lost group descriptions, NSData wrappers, image/base64 conversion, nested contact paths, selected icon fixed fallback, deduplication, explicit-empty fixed fallback, unreferenced warnings, malformed inputs, ambiguous basenames, NUL/traversal rejection, local nested dates/resources/index metadata, v2 dispatch, missing original index, source/directory symlinks, sparse oversized input and nonregular FIFO refusal.

The verifier creates a unique temporary directory for its executable and all input fixtures, removed by a shell trap even on failure. It does not instantiate NSUserDefaults or access real application configuration. Final `git diff --check` for the four owned paths also passed.

## Limits for integration

- Local directory conversion needs its original sibling index entry. A detached UUID directory without that metadata fails rather than inventing the original date. The original source tree/index remains read-only.
- Unknown values already lost by the old exporter cannot be reconstructed. If no known restorable fields remain, import fails instead of registering an empty backup.
- Source account/installation identity is intentionally unknown; the restore planner must maintain its existing relationship/account ownership safeguards.
- Fixed resource files without any explicit legacy preference cannot create an absent-field record. Such unassociated bytes are disclosed and omitted; an existing empty path field can preserve its known fallback resource without inventing absence.
- Unsupported old app bundle-domain variants must be explicitly supplied as `standardDomain` or added through a reviewed exact mapping. No broad `com.tencent.*` matching is used.
- No device import, active restore, services or package operations were performed. End-to-end import presentation and restore policy remain the manager/coordinator's responsibility.
