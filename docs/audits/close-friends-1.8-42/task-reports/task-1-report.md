# Task 1 report — Foundation policy and authenticated store

Status: DONE. Commit: `55219769` (`Add close-friend immutable policy and authenticated account store`).

Work stayed in `/Users/zhangshichao/Documents/Workspace/WeChatImprove`, branch `codex/close-friends`, starting from `54762b7f`. Only the eight assigned source/test files were committed. No service, real account, application data, package, database, runtime hook, manager or UI was touched. This report is local planning evidence.

## Files

- `Controllers/CSCloseFriendPolicy.h` and `.m`: Foundation-only immutable snapshot, strict profile normalizer and exact option defaults.
- `Controllers/CSCloseFriendCrypto.h` and `.m`: secure random bytes, independent AES-256-CBC/HMAC-SHA256 keys, authenticated envelope, PBKDF2-HMAC-SHA256 and constant-time equal-length comparison.
- `Controllers/CSCloseFriendStore.h` and `.m`: injected account key provider, isolated encrypted account state, strict schema validation, staged protected atomic replacement with verified readback.
- `Tests/CloseFriendCoreTests.m` and executable `Tests/verify-close-friend-core.sh`: Foundation host tests using generated keys, memory profiles and a new temporary directory removed after success.

## Tests and exact evidence

Initial RED command: `bash Tests/verify-close-friend-core.sh`, exit 1, before any implementation files existed:

```text
clang: error: no such file or directory: 'Controllers/CSCloseFriendPolicy.m'
clang: error: no such file or directory: 'Controllers/CSCloseFriendCrypto.m'
clang: error: no such file or directory: 'Controllers/CSCloseFriendStore.m'
```

First GREEN after implementation: `CloseFriendCoreTests: 23 checks passed`. Expanded test compilation briefly exposed an Objective-C literal/macro comma issue; changing the assertion helper to a variadic macro fixed that test-only compile error.

Final GREEN command: `bash Tests/verify-close-friend-core.sh`, exit 0:

```text
CloseFriendCoreTests: 209 checks passed
```

Compiler uses ARC, blocks, `-Wall -Wextra -Werror`, Foundation and Security frameworks. `git diff --cached --check` passed with no output before commit.

Coverage includes protected/unprotected names, revealed presentation with continued silence, each of the nine independent presentation switches, exact twenty option defaults, caller versus room membership, independent voice/video/silence switches, immutable copied membership, malformed boolean/name/options input, blocked snapshots, save/load, missing and separate accounts, account binding in authenticated plaintext, wrong-key reads and writes, no plaintext membership in ciphertext, changed header/IV/ciphertext/MAC, truncation, valid-MAC future envelope version, valid-MAC future/boolean/floating schema, valid-MAC XML payload and invalid profile, refusal to overwrite those files, interrupted staged write and corrupted staged readback preserving old bytes, temporary stage cleanup, encrypted mute records, key-provider error propagation, POSIX file/directory modes and backup exclusion. PBKDF2 output matches an independent Python hashlib vector for the 32-byte `00..1f` salt and 210000 iterations.

## Exact interfaces for Task 2

Import `CSCloseFriendPolicy.h`:

```objc
NSDictionary *CSCloseFriendDefaultOptions(void);
NSDictionary * _Nullable CSCloseFriendNormalizeProfile(id profile, NSError **error);
```

The snapshot initializer/properties/methods exactly match the brief. `friends` and `groups` are arrays of nonempty strings. All four profile keys (`enabled`, `friends`, `groups`, `options`) are required; unknown keys/options and numeric/string substitutes for actual boolean values are rejected. Missing individual options receive defaults. Names are bounded to 512 characters, cannot contain control characters, and arrays are bounded to 10000 entries each. Duplicate names are removed without mutating input. `unlockSeconds` is an integer value in 1...86400. All returned data is immutable.

A blocked snapshot, invalid profile, or invalid/empty account identifier forces `blocked=YES`, `revealed=NO` and hides every valid username on presentation surfaces. It does not invent membership for silencing or call rejection. Normal presentation needs enabled + member + selected surface + not revealed. Notification silence and independent voice/video rejection remain effective while revealed. This is a Foundation-only contract, with no UIKit or manager references.

Import `CSCloseFriendStore.h`:

```objc
typedef NSData * _Nullable (^CSCloseFriendKeyProvider)(NSString *accountID, NSError **error);
- (instancetype)initWithRoot:(NSURL *)root keyProvider:(CSCloseFriendKeyProvider)keyProvider;
- (nullable NSDictionary *)loadStateForAccountID:(NSString *)accountID error:(NSError **)error;
- (BOOL)saveState:(NSDictionary *)state forAccountID:(NSString *)accountID error:(NSError **)error;
```

Provider returns exactly 64 bytes. Task 2 owns production Keychain retrieval/generation and must never replace an unavailable key to recover from read failure. Provider NSError identity propagates unchanged. Missing state returns nil with `CSCloseFriendStoreErrorDomain`, code `CSCloseFriendStoreErrorMissing` (2); this is the only not-yet-created state condition. Other invalid/IO values use codes 1/3, crypto/profile validation has its own domains. Every failure returns an NSError when requested.

State is `{profile: <normalized profile>, muteRecords: <dictionary>}`. `profile` is required; omitted muteRecords normalizes to an empty immutable dictionary. Unknown state keys are rejected. `muteRecords` is separate from user-editable profile options and bounded as a property-list dictionary (depth 12, traversal budget 100000, individual string/data size 65536). Task 2 owns record semantic validation and must preserve existing muteRecords during profile edits and preserve profile during journal edits. Credentials/verifiers are **not** accepted in this state; they remain in the runtime Keychain as agreed.

Store serializes all instances in-process. The runtime remains responsible for account epoch checks and main-thread mutation ownership around read-modify-write. It must not allow a second process to mutate this directory.

Import `CSCloseFriendCrypto.h`:

```objc
NSData * _Nullable CSCloseFriendRandomBytes(NSUInteger length, NSError **error);
BOOL CSCloseFriendConstantTimeEqual(NSData *a, NSData *b);
NSData * _Nullable CSCloseFriendPasswordVerifier(NSString *password, NSData *salt, NSUInteger iterations, NSError **error);
NSData * _Nullable CSCloseFriendEncrypt(NSData *plaintext, NSData *key, NSError **error);
NSData * _Nullable CSCloseFriendDecrypt(NSData *envelope, NSData *key, NSError **error);
```

For a new verifier, Task 2 generates salt with `CSCloseFriendRandomBytes(32, error)` and stores salt/iterations/verifier in its Keychain auth item. Verifier rejects an empty password, >4096-character password, non-32-byte salt, iterations below 210000 or above 2000000; derived output is 32 bytes. Equal-length comparison loops over all bytes; public length mismatch returns immediately. Random-byte requests are bounded to 1...4 MiB.

## Envelope and durability

Each account uses `state-<SHA256(accountID)>.bin`, without raw identifiers in filenames. This opaque hash is an index, not a secret/credential. Inside authenticated encryption: binary plist `{schema: 1, accountID: ..., state: ...}`. Account binding prevents moving one account's valid payload under another account's filename, even with an identical injected key. Only binary plist format and integer schema 1 are accepted.

Envelope bytes: eight-byte `CSCF` + big-endian version 1 header, random 16-byte IV, AES-256-CBC PKCS#7 ciphertext, then 32-byte HMAC-SHA256 over **header + IV + ciphertext**. AES uses key bytes 0...31; HMAC uses bytes 32...63. Decrypt checks bounds, verifies MAC, verifies version, decrypts, then parses the plist. Plaintext is bounded to 4 MiB. No log or standard defaults write exists.

Save validates the new state and existing destination before staging. Existing corrupt/wrong-key/future data cannot be overwritten through this API. Stage is created exclusively with mode 0600, iOS complete file protection is set before content writes, the file is fsynced, reread, compared and authenticated/validated before atomic rename. Root is 0700, protected on iOS and excluded from backups. Failed stages are removed. A process death may leave only encrypted `.pending-*` bytes; readers ignore them. Directory metadata is fsynced best-effort after rename.

## Boundaries and follow-up ownership

No implementation concern blocks Task 2. Host tests validate Foundation/CommonCrypto logic and backup flags; they do not prove iOS Data Protection behavior or crash/power-loss guarantees on a physical device. Directory fsync is best-effort after the atomic commit, so a post-rename durability failure is not represented as a rollback. Interruption tests inject failure/corruption between staging and publication, rather than terminating a real iOS process. Runtime/Keychain, account epochs, profile editing, capability registry, notification constant/bridge, native mute restoration and all actual hooks remain assigned to later tasks.
