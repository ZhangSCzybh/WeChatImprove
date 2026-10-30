# Backup configuration registry inventory

The registry in `Controllers/CSBackupRegistry.m` authorizes exact domain/key pairs. This inventory includes the 2026-10-30 removal of automatic backup behavior and addition of the background-run policy. The registry has 316 fixed identities, including the inert historical automatic-backup field, a constrained per-account selection family and account-bound file families; it never treats a namespace prefix as permission to restore a key.

The fixed inventory contains 296 `standard`, 18 `legacy` and 2 `layout` identities. Its types are 139 `bool`, 129 `number`, 28 `string`, 8 `data`, 8 `array`, 3 `dictionary` and 1 `backgroundPolicy`. These counts come from the current `CSBackupRegistry.entries` result; dynamic lookup families are additional identities and are not included in these totals.

## Domain mapping

| Alias | Actual NSUserDefaults domain | Evidence |
| --- | --- | --- |
| `standard` | The host application's standard defaults domain | All general settings, including navigation, attachment layout, groups, payment automation preferences and custom text |
| `legacy` | `com.cyansmoke.wechattweak` | `CSAvatarSettingsViewController`, `CSBackgroundRunViewController`, `CSFavoriteSettingsViewController`, `CSBackgroundBlurManager` and their runtime readers |
| `layout` | `com.wechat.enhance` | `CSLayoutSettingsViewController` and `Hooks/LayoutHooks.xm`: only `font.chat_size` and `global.scale` |

`CSNavigationTitleSettingsViewController.h` declares `com.wechat.tweak.navigation.settings`, but the implementation and runtime readers use standard defaults. That unused suite name is not a preference key or an additional domain. Domain aliases are accepted exactly; literal suite names are rejected by lookup. Non-prefixed keys such as `roundAvatar`, `BackgroundRunEnabled`, `GameCheat_Enabled`, `WCTimeLineMessageTailText` and `kReceiveTransferAutoEnableKey` are included in their actual domains.

## Scope and resources

`global` preferences are not automatically assigned to an account. `account_profiles` and the account selection family have scope `account`; original account identifiers remain dictionary keys. Contact separator overrides and red-envelope allowed/blocked group lists have scope `relationship`. Only the contact override dictionary has `resource=contacts`, allowing the asset layer to process its nested `separatorImagePath` values. The group lists have no resource marker.

There are 10 `resource=file` string preferences: the eight normal/selected bottom bar icons, navigation separator image and touch trail custom image. Group profile member lists remain inside the account profile schema; the backup coordinator is responsible for selected account and relationship policy.

## Dynamic keys and values

The preference dynamic lookup family is `standard/com.wechat.enhance.chat_group.selection.<account>`. The suffix must be 1–128 ASCII letters, digits, underscores, hyphens or `@` characters, with no periods, whitespace or path separators. Lookup returns the concrete key with module `groups`, type `dictionary` and scope `account`. The stored value must contain exactly `version: 1` and a nonempty string `tabID`. The family is not represented by a writable wildcard row in `entries()`.

`scheduled/<account>` is a file-backed identity in module `scheduled_tasks`, with type `dictionary` and scope `account`. The account key has the same restricted syntax as selection suffixes. It maps to `Library/Preferences/WeChatImprove/ScheduledTasks/<SHA-256(account)>.plist`, never to an NSUserDefaults domain. Capture reads only the current account without taking the live scheduler’s exclusive writer lock. Portable values contain schema, account, master switch and up to 100 validated task definitions; execution history, nextRun and lastOccurrence are excluded. Restore requires source account = field account = current selected account; it pauses the master switch and clears execution state. Transaction before-images retain validated complete local state for exact rollback. Missing fields in old backups leave task files untouched.

All dynamic color field combinations are expanded as fixed keys: four bubble background RGBA palettes, four bubble text RGB palettes, six list-background RGBA palettes, bottom-bar background/border RGBA and touch-trail fill/border RGBA. Bubble text colors intentionally have no alpha preference. Color archive fields for message time, input text and group appearance are typed `data`.

Validation rejects unregistered or forged metadata, wrong classes, non-finite numbers, booleans other than numeric 0/1, non-string group members, malformed attachment numeric-ID arrays and malformed nested dictionaries. Profiles require schema version 1 and the fields written by `CSGroupPreferences`: `customTabs`, `presetNames`, `tabOrder`, `hiddenPresetTabs`, `selectedTabID`, `filterDuplicates` and `legacyImported`. Custom tab IDs/names/members and optional Foundation `NSDate` values for `created`/`updated` are checked. Duplicate custom IDs/order IDs and invalid preset references are rejected. Unsupported future profiles fail validation; they are not converted or stripped.

Archived UIColor bytes are retained as opaque bounded nonempty `NSData` (maximum 1 MiB). This layer does not decode or instantiate classes from them. Color interpretation remains the existing runtime's responsibility. Numbers are required to be finite `NSNumber` values; the registry does not reinterpret strings or normalize existing setting ranges. All accepted values must serialize as a binary property list. Array and dictionary collection limits protect restore planning from excessive input.

`legacy/BackgroundRunPolicy` belongs to module `background`, scope `global`, and uses the dedicated `backgroundPolicy` type rather than the generic string-to-string dictionary validator. `CSBackgroundRunValidatePolicy` requires exactly six keys: integer `version: 1`, CFBoolean `allDay`, integer `startMinute` and `endMinute` in 0–1439, integer `maxMinutes` from 0/5/15/30/60/120, and CFBoolean `energySaving`. Here 0 minutes means unlimited. Booleans cannot stand in for integer fields, and floating-point values are rejected even when numerically integral. A specified window requires different endpoints; an all-day policy may retain equal unused endpoints. Unknown fields, missing fields and future versions are rejected.

Fresh policy defaults are all-day operation, 08:00/23:00 retained window endpoints, a 30-minute maximum and energy saving enabled. Existing users with `BackgroundRunEnabled` but no policy retain their previous all-day, unlimited behavior without writing a new policy until they explicitly save one. An older backup without this optional field remains valid and does not replace the current policy. `BackgroundInterval` retains its separate historical identity and is not reinterpreted as the maximum duration. Successful-start time, remaining duration, timer generations and audio leases are runtime state and are not backup fields.

New snapshots retain an explicit `present: false` policy field so a user can restore the absence of a policy. For prepared-transaction compatibility, only this exact absent `legacy/BackgroundRunPolicy` field is excluded from current-state revision hashes and the raw reset fingerprint. All other fields, including every present policy value, still participate. Old prepared restore/reset journals therefore keep their original revision when no policy exists, while adding, changing or removing a stored policy invalidates a stale plan.

## Deliberate exclusions

- Authorization state and check timestamps (`CSAuthorizationStatus`, `CSLastAuthorizationCheckTime`), user agreement acceptance, cached avatar data and avatar URLs.
- Red-envelope and transfer total counts/amounts, the payment event ledger and payment processing state. Automation switches, delays, reply text and notification preferences are configuration and remain included.
- Backup history/metadata, last automatic-backup timestamp, and historical backup files. `com.wechat.enhance.backup.auto_enabled` remains an inert registered compatibility field so existing v2 files and prepared transaction revisions retain their exact field identities. It has no settings control, observer or scheduling consumer; capturing or restoring its old value cannot create a backup. New snapshots are created only by the explicit manual action; importing, reading and managing historical snapshot kinds remain supported.
- Group migration originals and historical snapshots: `chat_group.legacy_backup`, `chat_group.profile_backups`, and old import-only `custom_tabs`, `preset_names`, `tab_order`, `hidden_preset_tabs`, `filter_duplicate_contacts`, `selected_tab_id`, `selected_tab_index`, `currentTabIndex` values. Current account profiles are the supported group-definition configuration.
- Attachment tutorial acknowledgement, Darwin notification names, old abandoned indicator-animation preference and unknown/host defaults.

Text replacement preferences containing “count” or “balance” are user-authored display text; they are not payment/account statistics.

## Audit evidence

The audit reviewed all settings controller constants and preference writes, then cross-checked `Hooks/*.xm` and preference adapters. Particular dynamic writers/readers reviewed were `CSBubbleStylePolicy`, `CSBubbleStyleSettingsViewController`, `CSListCornerConfiguration`, `CSTabBarPreferences`, `CSTabBarStyleSettingsViewController`, `CSTouchTrailViewController`, `CSContactSeparatorManager`, `CSGroupPreferences`, `CSMessageActionPreferences`, `CSMessageMergePolicy`, `CSGroupAppearance`, `CSPaymentAutomation` and `CSPaymentLedger`. Attachment hidden-button and sort-order arrays store numeric identifiers, unlike red-envelope group-name arrays. Custom menu names store a string-to-string dictionary rather than separate localized preference keys.

## Exact fixed inventory

| Domain | Key | Module | Type | Scope | Resource |
| --- | --- | --- | --- | --- | --- |
| `legacy` | `BackgroundInterval` | `background` | `number` | `global` | — |
| `legacy` | `BackgroundRunEnabled` | `background` | `bool` | `global` | — |
| `legacy` | `BackgroundRunPolicy` | `background` | `backgroundPolicy` | `global` | — |
| `standard` | `GameCheat_Enabled` | `games` | `bool` | `global` | — |
| `standard` | `WCTimeLineMessageTailEnabled` | `timeline` | `bool` | `global` | — |
| `standard` | `WCTimeLineMessageTailText` | `timeline` | `string` | `global` | — |
| `legacy` | `avatarCornerRadius` | `avatar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.backup.auto_enabled` | `backup` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.corner_radius` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.enabled` | `bubble` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.kind` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_dark_color.alpha` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_dark_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_dark_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_dark_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_dark_text_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_dark_text_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_dark_text_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_light_color.alpha` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_light_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_light_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_light_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_light_text_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_light_text_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.receiver_light_text_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_dark_color.alpha` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_dark_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_dark_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_dark_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_dark_text_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_dark_text_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_dark_text_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_light_color.alpha` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_light_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_light_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_light_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_light_text_color.blue` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_light_text_color.green` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.bubble_style.sender_light_text_color.red` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.account_profiles` | `groups` | `dictionary` | `account` | — |
| `standard` | `com.wechat.enhance.chat_group.enabled` | `groups` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.haptic_feedback` | `groups` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.hide_all_badge` | `groups` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.hide_group_badge` | `groups` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.indicator_animation_enabled` | `groups` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.indicator_color` | `groups` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.indicator_color_dark` | `groups` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.selected_text_color` | `groups` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.selected_text_color_dark` | `groups` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.selection_indicator_style` | `groups` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.show_search_button` | `groups` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.swipe_gesture_enabled` | `groups` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.chat_group.tab_font_size` | `groups` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.consecutive_messages.spacing` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.image_sticker.enabled` | `message_actions` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.alpha` | `input` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.bold` | `input` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.border.color` | `input` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.border.enabled` | `input` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.border.width` | `input` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.color` | `input` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.content` | `input` | `string` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.cornerRadius` | `input` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.enabled` | `input` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.fontSize` | `input` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.inputText.roundedCorners` | `input` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.left_swipe_other.action` | `message_actions` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.left_swipe_self.action` | `message_actions` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.dark_bg_color.alpha` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.dark_bg_color.blue` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.dark_bg_color.green` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.dark_bg_color.red` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.enabled` | `list` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.left_margin` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.light_bg_color.alpha` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.light_bg_color.blue` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.light_bg_color.green` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.light_bg_color.red` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.alpha` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.blue` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.green` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.red` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.alpha` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.blue` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.green` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.red` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.radius` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.right_margin` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.alpha` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.blue` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.green` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.red` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.alpha` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.blue` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.green` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.red` | `list` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.merge_messages.avatar_position` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.merge_messages.enabled` | `bubble` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.merge_messages.scope` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.merge_messages.spacing_mode` | `bubble` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.backgroundColor` | `message_time` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.boldFont` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.cornerRadius` | `message_time` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.enabled` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.fontSize` | `message_time` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.showBelowAvatar` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.showDay` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.showHour` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.showMinute` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.showMonth` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.showSecond` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.showYear` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.singleLine` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.tapToShow` | `message_time` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.messageTime.textColor` | `message_time` | `data` | `global` | — |
| `standard` | `com.wechat.enhance.message_gesture.enabled` | `message_actions` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.allowedGroups` | `red_envelopes` | `array` | `relationship` | — |
| `standard` | `com.wechat.enhance.redenvelop.autoReceive` | `red_envelopes` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.autoReplyEnable` | `red_envelopes` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.blockedGroups` | `red_envelopes` | `array` | `relationship` | — |
| `standard` | `com.wechat.enhance.redenvelop.delay` | `red_envelopes` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.groupEnable` | `red_envelopes` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.groupReply` | `red_envelopes` | `string` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.groupScope` | `red_envelopes` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.notifyTarget` | `red_envelopes` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.pageSummary` | `red_envelopes` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.privateEnable` | `red_envelopes` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.privateReply` | `red_envelopes` | `string` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.receiveSelf` | `red_envelopes` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.redenvelop.serialReceive` | `red_envelopes` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.repeat.enabled` | `message_actions` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.revoke.enabled` | `revoke` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.right_swipe_other.action` | `message_actions` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.right_swipe_self.action` | `message_actions` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.scroll_sensitivity` | `groups` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.bg_color.alpha` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.bg_color.blue` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.bg_color.green` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.bg_color.red` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.border_animation` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.border_color.alpha` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.border_color.blue` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.border_color.green` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.border_color.red` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.border_style` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.border_width` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.click_effect` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.content_height` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.corner_radius` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.enabled` | `tabbar` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.haptic_feedback` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.hide_text` | `tabbar` | `bool` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.icon.chat` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.icon.contacts` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.icon.discover` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.icon.me` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.icon.selected.chat` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.icon.selected.contacts` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.icon.selected.discover` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.icon.selected.me` | `tabbar` | `string` | `global` | `file` |
| `standard` | `com.wechat.enhance.tabbar_style.position_offset` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.scale` | `tabbar` | `number` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.text.chat` | `tabbar` | `string` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.text.contacts` | `tabbar` | `string` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.text.discover` | `tabbar` | `string` | `global` | — |
| `standard` | `com.wechat.enhance.tabbar_style.text.me` | `tabbar` | `string` | `global` | — |
| `standard` | `com.wechat.enhance.voice_forward.enabled` | `message_actions` | `bool` | `global` | — |
| `legacy` | `com.wechat.tweak.background.blur.enabled` | `background` | `bool` | `global` | — |
| `legacy` | `com.wechat.tweak.biometric.auth.favorite` | `privacy` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.columns` | `attachments` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.group.hidden.buttons` | `attachments` | `array` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.group.sort.enabled` | `attachments` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.group.sort.order` | `attachments` | `array` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.layout.enabled` | `attachments` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.official.hidden.buttons` | `attachments` | `array` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.official.sort.enabled` | `attachments` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.official.sort.order` | `attachments` | `array` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.private.hidden.buttons` | `attachments` | `array` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.private.sort.enabled` | `attachments` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.private.sort.order` | `attachments` | `array` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.show.in.group` | `attachments` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.show.in.official` | `attachments` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.show.in.private` | `attachments` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.chat.attachment.spacing` | `attachments` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.contacts_replacement` | `custom_text` | `string` | `global` | — |
| `standard` | `com.wechat.tweak.custom_menu_names` | `custom_text` | `dictionary` | `global` | — |
| `standard` | `com.wechat.tweak.disable.allUpdateFunctions` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.forceUpdate` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.immediateRenameUpdate` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.loadAndExecute` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.loadBundle` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.loadMainUpdateBundle` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.loadPluginInBundle` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.loadResource` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.onPResUpdateFinish` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.registerUpdate` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.shouldTrace` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.tryRegisterUpdate` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.tryRenameTmpUpdateDataDir` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.unzipBundleUpdates` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.disable.unzipDownloadUpdates` | `updates` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.discover_replacement` | `custom_text` | `string` | `global` | — |
| `standard` | `com.wechat.tweak.entry.custom.title` | `entry` | `string` | `global` | — |
| `standard` | `com.wechat.tweak.entry.display.mode` | `entry` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.entry.show.in.more` | `entry` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.entry.show.in.plugin` | `entry` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.entry.show.in.setting` | `entry` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.friends_count_replacement` | `custom_text` | `string` | `global` | — |
| `standard` | `com.wechat.tweak.hide_channels_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_chat_time_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_channels` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_game` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_listen` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_live` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_look` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_miniprogram` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_nearby` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_scan` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_discover_search` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_favorite_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_moments_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_pat_message_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_qrcode_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_revoke_message_enabled` | `revoke` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_service_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_about` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_account_security` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_call` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_chat` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_chat_history` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_display` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_friend_permission` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_help` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_logout` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_more` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_notification` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_other` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_plugin` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_privacy` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_profile` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_storage` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_setting_switch_account` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_settings_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_sticker_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_voice_hint_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_wallet_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.hide_works_enabled` | `ui` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.main_title_replacement` | `custom_text` | `string` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.avatar.mode` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.avatar.radius` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.avatar.size` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.avatar.spacing` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.contact.overrides` | `navigation` | `dictionary` | `relationship` | `contacts` |
| `standard` | `com.wechat.tweak.navigation.nickname.position` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.nickname.size` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.separator.image` | `navigation` | `string` | `global` | `file` |
| `standard` | `com.wechat.tweak.navigation.separator.size` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.separator.text` | `navigation` | `string` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.avatar` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.in.group` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.in.official` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.in.private` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.other` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.other.nickname` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.popover.when.tap.avatar` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.remark.name` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.show.self` | `navigation` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.navigation.vertical.offset` | `navigation` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.simple_ui_enabled` | `custom_text` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.border.color.alpha` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.border.color.blue` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.border.color.green` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.border.color.red` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.border.enabled` | `touch` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.border.width` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.color.alpha` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.color.blue` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.color.green` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.color.red` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.custom.image.corner.radius` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.custom.image.enabled` | `touch` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.custom.image.path` | `touch` | `string` | `global` | `file` |
| `standard` | `com.wechat.tweak.touch.trail.display.state` | `touch` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.enabled` | `touch` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.only.when.recording` | `touch` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.size` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.tail.density` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.tail.duration` | `touch` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.touch.trail.tail.enabled` | `touch` | `bool` | `global` | — |
| `standard` | `com.wechat.tweak.version.custom` | `version` | `string` | `global` | — |
| `standard` | `com.wechat.tweak.version.selected` | `version` | `number` | `global` | — |
| `standard` | `com.wechat.tweak.wallet_balance_replacement` | `custom_text` | `string` | `global` | — |
| `layout` | `font.chat_size` | `layout` | `number` | `global` | — |
| `layout` | `global.scale` | `layout` | `number` | `global` | — |
| `legacy` | `hideBothAvatarInGroupChat` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideBothAvatarInOfficialAccount` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideBothAvatarInPrivateChat` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideOtherAvatarInGroupChat` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideOtherAvatarInOfficialAccount` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideOtherAvatarInPrivateChat` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideSelfAvatarInGroupChat` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideSelfAvatarInOfficialAccount` | `avatar` | `bool` | `global` | — |
| `legacy` | `hideSelfAvatarInPrivateChat` | `avatar` | `bool` | `global` | — |
| `standard` | `kReceiveTransferAutoEnableKey` | `transfers` | `bool` | `global` | — |
| `standard` | `kReceiveTransferAutoReplyEnableKey` | `transfers` | `bool` | `global` | — |
| `standard` | `kReceiveTransferDelayKey` | `transfers` | `number` | `global` | — |
| `standard` | `kReceiveTransferGroupAutoReplyKey` | `transfers` | `string` | `global` | — |
| `standard` | `kReceiveTransferGroupEnableKey` | `transfers` | `bool` | `global` | — |
| `standard` | `kReceiveTransferNotifyTargetKey` | `transfers` | `number` | `global` | — |
| `standard` | `kReceiveTransferPrivateAutoReplyKey` | `transfers` | `string` | `global` | — |
| `standard` | `kReceiveTransferPrivateEnableKey` | `transfers` | `bool` | `global` | — |
| `legacy` | `rotateAvatar` | `avatar` | `bool` | `global` | — |
| `legacy` | `rotateSpeed` | `avatar` | `number` | `global` | — |
| `legacy` | `roundAvatar` | `avatar` | `bool` | `global` | — |

## Verification

`bash Tests/verify-backup-registry.sh` compiles and executes Objective-C tests, including the production background policy validator, against the macOS Foundation framework using `xcrun --sdk macosx clang`, ARC, blocks and `-Wall -Wextra -Werror`. The executable is built in a unique temporary directory that is removed on exit. Its defaults round-trips use a uniquely named test suite and remove that suite afterward; they never read or write the user's established plugin or host defaults. No services, live data, installed application or package directories are modified.

The tests cover domain separation, non-prefixed preferences, unknown and payment denial, full bubble color expansion, concrete account selection constraints, stored NSNumber booleans, numeric/date/type rejection, nested group profiles, contact override structure, numeric attachment IDs, background policy metadata and strict six-key validation, legacy preferences without a policy, schema changes and forged entry metadata. Current result: 1,500 assertions passed. These are host-side preference registry tests; device rendering and restore integration belong to the backup coordinator/codec/asset tests.
