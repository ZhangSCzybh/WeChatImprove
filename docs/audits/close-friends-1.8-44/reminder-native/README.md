# Reminder picker native evidence (WeChat 8.0.78)

This is read-only static evidence from `/tmp/wechat-8.0.78-inset-analysis/WeChat`, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e` (arm64, decrypted). It does not claim device execution. The parent task owns the shared REA session; this independent scope reuses the existing mmap metadata decoder and bounded `llvm-objdump` disassembly without opening or closing a session.

## Finding

The reminder picker uses the same native `ContactSelectView` and `ContactsDataLogic` as the existing audience candidate projection, but adds a `ContactsSelectorController` delegate hop. The 1.8-43 `PublishingOwner` only accepts `WCMomentsPrivacyViewController`; it cannot recognize this reminder route.

Default reminder route, following delegate getters from the candidate data source:

```
ContactsDataLogic.m_delegate
  -> ContactSelectView.m_delegate
  -> MultiSelectContactsViewController.m_delegate
  -> ContactsSelectorController.delegate
  -> WCNewCommitViewController
```

The publishing editor also retains the same selector in `contactsSelectorController`, allowing a positive ownership identity check.

## Retained observations

- `WCNewCommitViewController.commonInit` at `0x1092865f8`: creates a `ContactsSelectorController` at `0x109286988`, stores it in the same ivar returned by `contactsSelectorController`, sets `delegate=self` at `0x1092869d0..0x1092869dc`, then initializes `contactsSelectorType=0`. When `togetherEnabled` is enabled, a later feature value can replace that type; do not assume all future picker variants are type 0.
- `WCNewCommitViewController.onWithContactCellClicked` at `0x109299dd8`: calls `addContact` on the retained selector (`0x109299f70..0x109299f84`). Native privacy gating runs before this call; it must remain native.
- `ContactsSelectorController.addContact` at `0x106f43944`: type 1 selects `showSessionSelectController`, otherwise `showMutiSelectContactViewController`. The selector references are `0x1200008f0` and `0x1200008f8`, respectively.
- `ContactsSelectorController.showMutiSelectContactViewController` at `0x106f4398c`: builds native preselected/ignored dictionaries, creates `MultiSelectContactsViewController` (`0x106f43c78`), sets its `m_delegate=self` (`0x106f43c88..0x106f43c90`), supplies the original selection dictionary (`0x106f43cd0..0x106f43ce0`), and calls `commonSetupMutiSelectContactViewController:`.
- `commonSetupMutiSelectContactViewController:` at `0x106f43e90`: sets the native title, common-search scene 21, member-count limit, history-group flag NO, scene 2, and UI-group scene 21. `setupMutiSelectContactViewControllerInSessionSelectController:` at `0x106f43f6c` forwards directly to this same common setup method. This is a narrow optional marker point for positively identifying alternate session-hosted picker variants.
- `MultiSelectContactsViewController.getContactSelectViewClass` at `0x104ea8df0` returns `ContactSelectView`. Its `initView` creates that view using `initWithFrame:delegate:` with `self` as delegate (`0x104ea54f4..0x104ea550c`). `ContactSelectView.initData:` creates `ContactsDataLogic` through `initWithScene:delegate:` with the view as delegate (`0x10100fc28..0x10100fc44`).
- `MultiSelectContactsViewController.actionDone` at `0x104ea1644` probes and invokes native selection callbacks, including `onMultiSelectContactReturnForSns:` at `0x104ea18a0`.
- `ContactsSelectorController.onMultiSelectContactReturn:` at `0x106f44ca8` is a no-op. The active SNS callback `onMultiSelectContactReturnForSns:` at `0x106f44cac` dismisses the picker and calls `didSelectContacts:`.
- `ContactsSelectorController.didSelectContacts:` at `0x106f4474c` turns selected `CContact` objects into non-empty `m_nsUsrName` strings, assigns a mutable copy to `arrContacts` (`0x106f448a8..0x106f448bc`), and invokes `delegate.onRemindContactSelected:` (`0x106f44908..0x106f4496c`).
- `WCNewCommitViewController.onRemindContactSelected:` at `0x1092a7420` passes the usernames to `enhanceDraftSaveController.setDraftRemindContactUsernames:`. This is real publishing/draft state, not candidate display data.

## Smallest safe change

Extend positive owner recognition for the exact reminder chain above, checking that the editor is `WCNewCommitViewController` and `editor.contactsSelectorController == selector`. Reuse existing `ContactsDataLogic` keys/rows/count projection and `ContactSelectView.onFilterContactCandidate:` filtering, plus account-epoch/reveal refresh behavior. Do not globally filter every `ContactsSelectorController`, and do not replace `arrContacts`, `m_dicMultiSelect`, or the callback argument with visible candidates. The original reminder selection/draft and publishing ACL must remain intact.

A common-setup association is an optional narrow alternative if supporting a session-hosted reminder variant: only mark a passed picker when the selector belongs by identity to the publishing editor. The alternate session route was identified, but its full nested delegate graph was not traced because the requested/default reminder route is already established.

## Verified ABI

`methods.json` retains exact arm64 Objective-C encodings. Relevant normalized signatures are:

- `ContactsSelectorController.addContact`, `showMutiSelectContactViewController`, `MultiSelectContactsViewController.actionDone`: `v@:`.
- `commonSetupMutiSelectContactViewController:`, `didSelectContacts:`, `onMultiSelectContactReturnForSns:`, `WCNewCommitViewController.onRemindContactSelected:`: `v@:@`.
- Object getters in the delegate chain: `@@:`.
- `ContactSelectView.onFilterContactCandidate:`: `B@:@` (YES includes the candidate; 1.8-43 evidence established this meaning).
- `ContactsDataLogic.getKeysArray`: `@@:`; `getContactsArrayWith:`: `@@:@`.

Reproduction: run `python3 docs/audits/close-friends-1.8-44/reminder-native/extract.py`, then `python3 docs/audits/close-friends-1.8-44/reminder-native/disassemble.py`. Inputs are read-only and only this evidence directory is written. Complete function bounds, method addresses, checksums and disassembly paths are in `manifest.json`; no retained disassembly is truncated.
