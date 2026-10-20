# Task 1 report: exact configuration registry

Completed the requested registry interface and inventory without modifying existing runtime hooks, settings controllers, dependencies, package directories, services or live defaults.

## Delivered files

- `Controllers/CSBackupRegistry.h/.m`: 313 explicit fixed preference identities, exact domain aliases, stable readable English module IDs, concrete constrained per-account selection lookup, type/schema validation.
- `Tests/BackupRegistryTests.m` and executable `Tests/verify-backup-registry.sh`: real macOS Foundation host tests with temporary executable directory and unique disposable defaults suite.
- `docs/backup-configuration-registry.md`: exact fixed key inventory, real domain mapping, dynamic families, scope/resource semantics, audit evidence, exclusions and limits.

## Audit findings

- Standard defaults hold navigation preferences despite the unused separate-suite declaration in its header. Actual layout defaults use `com.wechat.enhance`; avatar/background/favorite/background-blur use `com.cyansmoke.wechattweak`.
- Non-prefixed avatar/background, game, timeline and transfer keys must be explicitly included. Prefix-only backup selection loses these settings and can authorize unrelated host keys.
- Bubble colors use `sender_light_color`, `receiver_light_color`, `sender_dark_color`, `receiver_dark_color`; text colors use corresponding `*_text_color` RGB keys with no alpha. All combinations are fixed rows. List, bottom-bar and touch color fields are also explicit.
- Attachment sort/hidden arrays store numeric button identifiers, not string identifiers. Contact group lists store strings.
- Current group profiles contain nested Foundation dates. Their schema is validated directly without unarchiving; account selection writes are separate `{version:1, tabID:...}` dictionaries.
- Contact overrides are `scope=relationship, resource=contacts`; red-envelope allowed/blocked lists are `scope=relationship` with no resource field, as coordinated with the parent task.
- Ten top-level path string keys are `resource=file`: eight bottom-bar icons, navigation separator image and touch-trail custom image. Nested contact separator image paths are handled through the contact resource dictionary.
- Authorization/agreement/avatar caches, payment totals/ledger, tutorial acknowledgement, backup timestamps/history and group historical/migration snapshots are excluded. Old group import-only archive keys are excluded; current account profiles are included.

## Validation

Tests were created before implementation. Initial red command:

```sh
bash Tests/verify-backup-registry.sh
```

Result: exit 1, expected compile failure because `Controllers/CSBackupRegistry.m` had not yet been created.

Final command:

```sh
bash Tests/verify-backup-registry.sh
```

Result: exit 0, `Backup registry passed 1390 assertions`; compiled with real macOS Foundation, ARC, blocks, `-Wall -Wextra -Werror`. Coverage includes exact domain mapping, unknown denial, non-prefixed keys, payment exclusion, dynamic selection suffix constraints, fixed color expansion, malformed values, profile dates/schema/references, relationship metadata, attachment numeric arrays, contact dictionaries and forged metadata. `git diff --check` also passed for all five delivered paths.

## Limits and integration notes

- `entries()` returns fixed identities only. The selection family is recognized by `entryForDomain:key:`; backup capture must enumerate actual stored keys to discover those concrete entries.
- Account IDs permit 1–128 ASCII letters/digits/underscores/hyphens/`@`, excluding whitespace, dots and separators. Profiles preserve their original account IDs. Parent was informed of this constraint.
- All included profiles must be supported schema version 1. Unsupported future profiles fail full capture clearly, preserving existing defaults rather than silently stripping or converting them. Parent confirmed this intended fail-safe behavior.
- UIColor NSData is bounded, opaque data; this registry never instantiates archive classes. Semantic interpretation belongs to existing secure runtime color readers.
- Host tests verify registry behavior; device rendering and end-to-end backup restoration are outside this component. No app/service restart or real-user restore was performed.
