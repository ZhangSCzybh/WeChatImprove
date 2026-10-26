# Close Friends Implementation Plan

> 存储路径已按 2.0-3 更新（2026-10-24）：旧 Application Support 对应目录仅用于迁移读取，详见 `docs/audits/preferences-storage-migration-2026-10-24/README.md`。

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the approved account-owned close-friend privacy subsystem, including non-friend profile presentation from shared groups.

**Architecture:** Immutable policy snapshots are consumed at native presentation and notification boundaries. Native data remains complete; the existing session projection composes privacy before grouping. Authenticated local storage and account epochs own state; native mute and call handling use explicit adapters.

**Tech Stack:** Objective-C/Logos, Theos, Foundation, UIKit, Security, CommonCrypto, LocalAuthentication; iOS 15.0, arm64/arm64e.

**Spec:** docs/superpowers/specs/2026-10-20-close-friends-design.md

## Global Constraints

- Preserve current checkout /Users/zhangshichao/Documents/Workspace/WeChatImprove and established data; use codex/close-friends branch. No deployment or real-account changes during development.
- Objective-C/Logos, ARC, arm64/arm64e, iOS 15.0. No make clean; preserve prior packages.
- Message reception/storage/unread, real friendship, tag membership and publishing ACL remain native and intact.
- Unlock restores native lists; notification silence and independent incoming-call rejection remain enabled.
- Globally hide all Moments visibility icons when that preference and feature are enabled, including while revealed.
- Unknown method signatures are not called or hooked. Interface discovery is not device validation.
- Never expose plaintext memberships/credentials in standard defaults, logs, exports, ordinary backup or diagnostic files.
- All asynchronous actions recheck account epoch and current policy. No stale authorization on account change/background.
- Native mute restoration preserves user/remote edits. No fake friend requests or sent messages from profile masking.
- Unit tests use memory or temporary files; never actual WeChat account state.

## Shared interfaces

Task 1 owns `CSCloseFriendPolicy.h` and `CSCloseFriendStore.h`. Task 2 owns `CSCloseFriendBridge.h` and manager UI/auth. Later tasks consume these exact names; any adjustment is recorded in progress.md and carried to subsequent implementers.

```objc
typedef NS_ENUM(NSUInteger, CSCloseFriendSurface) {
 CSCloseFriendSurfaceSession, CSCloseFriendSurfaceContact,
 CSCloseFriendSurfaceForward, CSCloseFriendSurfaceTag,
 CSCloseFriendSurfaceSearch, CSCloseFriendSurfaceTimeline,
 CSCloseFriendSurfaceInteraction, CSCloseFriendSurfaceStatus,
 CSCloseFriendSurfaceProfile
};
// Foundation-only, immutable. Profile: enabled, friends, groups, options.
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic, copy, readonly) NSString *accountID;
@property(nonatomic, readonly) NSUInteger revision;
@property(nonatomic, readonly) BOOL enabled, revealed, blocked;
@property(nonatomic, copy, readonly) NSSet<NSString *> *protectedUserNames;
@property(nonatomic, copy, readonly) NSDictionary *options;
- (instancetype)initWithAccountID:(NSString *)accountID profile:(NSDictionary *)profile
 revealed:(BOOL)revealed revision:(NSUInteger)revision blocked:(BOOL)blocked;
- (BOOL)containsUserName:(NSString *)name;
- (BOOL)hidesUserName:(NSString *)name surface:(CSCloseFriendSurface)surface;
- (BOOL)silencesSession:(NSString *)session sender:(NSString *)sender;
- (BOOL)rejectsCaller:(NSString *)caller chatRoom:(NSString *)room video:(BOOL)video;
@end
FOUNDATION_EXPORT NSDictionary *CSCloseFriendDefaultOptions(void);
// Bridge snapshots are thread-safe; UI mutations are main-thread-owned.
FOUNDATION_EXPORT NSString *const CSCloseFriendPolicyDidChangeNotification;
FOUNDATION_EXPORT CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void);
FOUNDATION_EXPORT NSUInteger CSCloseFriendAccountEpoch(void);
FOUNDATION_EXPORT BOOL CSCloseFriendShouldHideUserName(NSString *name, CSCloseFriendSurface surface);
FOUNDATION_EXPORT BOOL CSCloseFriendShouldSilence(NSString *session, NSString *sender);
FOUNDATION_EXPORT BOOL CSCloseFriendShouldRejectCall(NSString *caller, NSString *room, BOOL video);
FOUNDATION_EXPORT BOOL CSCloseFriendHidesPrivacyIcons(void);
FOUNDATION_EXPORT id CSCloseFriendRead(id object, NSString *key);
FOUNDATION_EXPORT NSString *CSCloseFriendUserName(id object);
FOUNDATION_EXPORT void CSCloseFriendLock(void);
FOUNDATION_EXPORT void CSCloseFriendAuthenticate(UIViewController *presenter, void (^completion)(BOOL));
FOUNDATION_EXPORT void CSCloseFriendRecordCapability(NSString *name, BOOL available);
FOUNDATION_EXPORT NSDictionary *CSCloseFriendCurrentProfile(void);
FOUNDATION_EXPORT BOOL CSCloseFriendUpdateCurrentProfile(NSDictionary *profile, NSError **error);
FOUNDATION_EXPORT NSDictionary *CSCloseFriendMuteRecords(void);
FOUNDATION_EXPORT BOOL CSCloseFriendSaveMuteRecords(NSDictionary *records, NSString *accountID, NSUInteger accountEpoch, NSError **error);
// Runtime hook installation must compare normalized return and argument types.
FOUNDATION_EXPORT BOOL CSCloseFriendInstallHook(NSString *className, NSString *selector,
 IMP replacement, IMP *original, const char *typeEncoding);
```

Options use these exact keys: `hideSessions`, `hideContacts`, `hideForwarding`, `hideTags`, `hideSearch`, `hideTimeline`, `hideInteractions`, `hideStatus`, `maskProfiles`, `silenceMessages`, `autoMute`, `rejectVoice`, `rejectVideo`, `hidePrivacyIcons`, `showBadges`, `hideSettingsEntry`, `hidePluginEntry`, `biometric`, `shakeToLock`, `unlockSeconds`. First fourteen are YES; showBadges/entry hiding/biometric/shake are NO, unlockSeconds=300. Auth and restoration journal are not user-editable profile options.

### Task 1: Foundation policy and authenticated store

**Files:** Create Controllers/CSCloseFriendPolicy.{h,m}, Controllers/CSCloseFriendStore.{h,m}, Controllers/CSCloseFriendCrypto.{h,m}, Tests/CloseFriendCoreTests.m, Tests/verify-close-friend-core.sh.

**Interfaces:** Produces the immutable snapshot above, strict profile normalization, authenticated serialization and injected key-provider store. Crypto exports random bytes, PBKDF2 verifier and constant-time comparison. Store rejects future schemas, bad MAC, truncated data and wrong keys without overwriting bytes.

- [ ] Add executable Foundation tests using a memory profile and temporary store. Assertions include `hidden(A)==YES`, `hidden(B)==NO`, `revealed(A).hidden==NO`, `revealed(A).silenced==YES`, cross-account isolation, incoming caller/room distinction and malformed schema. Test save/load, wrong key, tamper, interrupted write/readback and plaintext not appearing in ciphertext.
- [ ] Run `bash Tests/verify-close-friend-core.sh`; record expected initial compile failure.
- [ ] Implement normalized immutable policy. Filter options are independent; blocked snapshots protect presentation rather than silently disabling. Input objects are type checked, copied and bounded.
- [ ] Implement encrypt-then-MAC using independent AES-256-CBC and HMAC-SHA256 keys (64 random bytes total), random IV, authenticated version header, bounded binary plist, MAC verification before decryption and atomic protected file replacement. Tests inject a key; production Keychain ownership is Task 2. Use PBKDF2-HMAC-SHA256 at least 210000 iterations, random 32-byte salt, 32-byte derived value.
- [ ] Run focused tests, read diff, commit only task files and record test evidence.

### Task 2: Runtime state, authentication, lifecycle and settings

**Files:** Create Controllers/CSCloseFriendBridge.{h,m}, Controllers/CSCloseFriendManager.{h,m}, Controllers/CSCloseFriendSettingsViewController.{h,m}, Hooks/CloseFriendLifecycleHooks.xm, Tests/verify-close-friend-runtime.sh. Modify Controllers/CSCustomViewController.m, Hooks/CustomEntryHooks.xm, Makefile for Security/UserNotifications if used.

**Interfaces:** Consumes Task 1. Produces all shared bridge APIs, guarded native hook installer, authenticated settings, durable journal API, thread-safe snapshots and change notification. Uses existing CSBackupAccountEpoch/CSBackupAccountIsSuspended rather than maintaining a conflicting native login hook owner.

- [ ] Add behavioral runtime tests with fake account/lifecycle/key provider; cover late biometric reply, wrong PIN/cooldown, background invalidation, cross-account writes and corrupt store holding protection.
- [ ] Implement device-only Keychain policy key and account credential verifier; root encrypted account store under Library/Preferences/WeChatImprove/CloseFriends. Preserve existing bytes on failure and never generate a replacement key over an existing unreadable store.
- [ ] Implement account snapshot publication, main-thread profile edits, independent journal writes, setup requiring valid password before enable, 300-second temporary reveal, optional biometric verification, immediate lifecycle cover and safe-page return. Authentication resuming after background/account change fails. Hook constructor does no service discovery or disk-heavy work.
- [ ] Add native-style settings in existing account/safety section, use WEContactSelectViewController for friends/groups, exact options above, password/change-password, explicit lock, expiry, hidden entry recovery via homepage navbar long press. Capability rows say interface available/unavailable and device verification pending, not complete protection. Gate direct settings instantiation and hidden plugin entry routes.
- [ ] Test guards and compile iOS sources; commit task files and evidence. Existing settings and backup failure recovery remain usable.

### Task 3: Session projection and unread integration

**Files:** Modify Controllers/CSGroupProjection.{h,m}, Controllers/CSGroupListAdapter.m, Hooks/SessionGroupHooks.xm; create Tests/CloseFriendSessionTests.m, Tests/verify-close-friend-session.sh. Extend relevant group extraction doubles only where needed.

**Interfaces:** Consumes snapshot from Task 2. Existing projection initializers retain source compatibility; add explicit privacy predicate/hidden set + revision initializer to pure projection (no global manager in Foundation policy).

- [ ] Test native [A,B,C] with A hidden maps display 0 to native B, all/group/custom badges exclude A, no duplicate subtraction, hidden set change invalidates reuse, revealing restores paths and unread. Include nativePaths validation, retained/aggregate rows and unknown identity handling.
- [ ] Apply privacy after full native section validation and before grouping/badge computation. Preserve native coordinates. Decouple projection activation from group chrome; grouping off retains privacy filtering with an All group.
- [ ] Guard native next/previous/unread/selected-session navigation against hidden names and avoid unfiltered nativePresentation bypass. Integrate policy change observer with existing coalesced refresh; ensure protected hiding is immediate despite interaction deferral. Counts/card edges use final projection.
- [ ] Run new test plus existing group preference/business/incremental/selection/search/lifecycle scripts, repair concrete regressions and commit.

### Task 4: Contacts, forwarding, tags, search and non-friend profile

**Files:** Create Controllers/CSCloseFriendContactAdapter.{h,m}, Controllers/CSCloseFriendSearchAdapter.{h,m}, Controllers/CSCloseFriendProfileAdapter.{h,m}, Hooks/CloseFriendContactHooks.xm, Hooks/CloseFriendSearchHooks.xm, Hooks/CloseFriendProfileHooks.xm, Tests/CloseFriendContactTests.m, Tests/verify-close-friend-contacts.sh. May add focused projection helper files under CSCloseFriend prefix.

**Interfaces:** Consumes bridge read/identity/policy functions; scoped copies and verified selectors only. Never changes CContactMgr global identity/relationship getters or source-model membership.

- [ ] Inspect ContactsDataLogic, ContactSelectView, SessionSelectView/Controller, ContactTag* and FTS* declarations and implement tests with native-like data models for counts/selection/immutability, source changes and reveal.
- [ ] Filter presentation arrays/dictionaries/section indexes and matching callbacks atomically; cover recent forwarding, selected recipients, group matches, search message aggregates/async updates. Preserve original search cursor; bounded extra-page loading only through a verified method. Gate unavailable result paths instead of publishing unfiltered protected results.
- [ ] Preserve hidden tag/ACL membership on edit; require authentication before destructive replacement where safe merging cannot be proven. On policy invalidation cancel unsafe pending forwarding selection rather than invisibly changing recipients.
- [ ] Inspect ContactInfoViewController, CBaseContactInfoAssist and WeixinContactInfoAssist; implement instance-scoped stranger presentation for hidden individuals: native friend message/call controls replaced by 添加到通讯录, real contact flags intact. Native construction callbacks can use bounded render context; no persistent global isMyContact lies. Mask action tap never invokes send verification/add/remove, and native message/voip methods recheck policy. Reveal restores source-generated native UI. Cover info, tag/remark and Moments/status links that otherwise reveal relationship, without hiding shared-group public identity.
- [ ] Run behavioral adapter tests, compile guarded hook signatures against SDK, inspect source preservation, commit.

### Task 5: Moments, interactions, publishing selectors and status

**Files:** Create Controllers/CSCloseFriendSocialAdapter.{h,m}, Hooks/CloseFriendSocialHooks.xm, Tests/CloseFriendSocialTests.m, Tests/verify-close-friend-social.sh.

**Interfaces:** Consumes bridge/policy plus any stable projection helper from Task 4. Owns presentation copies, not native source cache or database.

- [ ] Test mixed timeline, like/comment/refUserName, reply to hidden author, message counts, status username lists and indexed card navigation. Verify original arrays/counts/ACL unchanged after render.
- [ ] Implement verified WCTimeLine/WCDataItem presentation filtering with consistent section/item indexes and comment heights/counts; WCCommentListViewController interaction results and exposed unread/preview display use filtered projection. Rebuild on policy change; no delete/mark-read calls.
- [ ] Hide all WCTimeLineCellView privacy buttons (including revealed), collapse owned spacing, disable hit target/accessibility; undo on feature disable and cell reuse. Never invoke setDataItemPublic/Private or mutate isPrivate.
- [ ] Adapt WCMomentsPrivacyViewController and tag selectors; filter UI candidates without replacing WCCommitPrivacySetting.selectContacts/selectTags; authenticate before editing an existing hidden selection or whole visibility mode.
- [ ] Adapt TextStateFriendSquareViewController and card-list provider to same projection; no native state deletions. Guard direct card/profile entry and close revealed sensitive views on relock.
- [ ] Run tests, validate runtime selector encodings, commit.

### Task 6: Notifications, mute transactions, calls and payment summaries

**Files:** Create Controllers/CSCloseFriendNotificationAdapter.{h,m}, Controllers/CSCloseFriendMuteAdapter.{h,m}, Controllers/CSCloseFriendCallAdapter.{h,m}, Hooks/CloseFriendNotificationHooks.xm, Hooks/CloseFriendCallHooks.xm, Tests/CloseFriendAlertTests.m, Tests/verify-close-friend-alerts.sh. Modify Controllers/CSPaymentAutomation.m only for privacy-aware summary/reply policy.

**Interfaces:** Consumes policy/bridge snapshot, durable journal API and verified hook installer. No message receipt or database hook suppression.

- [ ] Test silent vs normal subjects, reveal remaining silent, room vs inviter distinction, original-mute preservation, user edit revoking restore ownership, restart/partial failure, one rejection per invite and ordinary call after cleanup.
- [ ] Implement identity-aware QuickReply and local notification output gates; suppress sound/vibration only with bound message identity. Correct completion exactly once. Targeted pending/delivered notification removal only with reliable account/target identity. Compute display badge contribution using confirmed native semantics, preserving underlying unread.
- [ ] Implement native mute transaction with saved original state before write, getter/readback, durable applied/owned record, account epoch recheck, external mutation owner revocation, bounded retry and conservative restoration. Unknown bool semantics/version must not write blindly; availability reflected in capability UI.
- [ ] Use verified VoIPInvitationService invitation/reject/UI paths; separate MultiTalk invitations and incoming float banners. Match call tokens by account+room+invite/msg, skip duplicate requests, no global reset of unrelated call, no interruption of already-established call. Preserve PushKit/CallKit required lifecycle and explicitly record unsupported system-first-frame coverage.
- [ ] Gate identity-bearing payment summary CSSend (and configurable automated replies) when source subject is protected without changing payment/ledger execution. Run alerts plus payment/message regression scripts, commit.

### Task 7: Integration, audit and package

**Files:** Update README.md, control, Headers/CSUserInfoHelper.h, Controllers/CSReleaseNotesViewController.m; create docs/audits/close-friends-1.8-42/README.md, validation.json and device-acceptance.md.

**Interfaces:** Integrates Tasks 1–6. New package version 1.8-42, rootless dual architecture; preserve prior artifacts.

- [ ] Execute all close-friend tests and repository-required host regressions once, write exact results/logs and note host-vs-device scope. Review full diff for source mutation, stale identity, unsafe hook signature, cross-feature regressions and secret logging.
- [ ] Build using `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-42`; no clean. Verify package metadata, dylib architectures, exports and package/source version agreement. Address concrete compiler/test failures and repeat only affected checks.
- [ ] Document actual covered adapters and unavailable routes honestly; record target version requirements and device acceptance matrix including shared-group profile buttons, unlock restore, tags/ACL and process-killed notifications.
- [ ] Finish on current checkout with reviewable commits, exact package path and no automatic device installation. Do not claim real-device acceptance without actual evidence.

### Execution update: focused validation

The user subsequently requested higher efficiency and fewer redundant tests/regressions. This takes precedence over the earlier broad per-task verification instructions: during implementation, run meaningful checks for changed core behavior and compile affected sources only. Reuse successful evidence for unchanged code; reviewers do not rerun suites to confirm reports. At integration, run the close-friend suites once and only directly affected existing regressions. The final package build supplies integration compilation, so a duplicate full isolated-object compile is unnecessary. New failures or code changes justify focused reruns; speculative coverage expansion does not.
