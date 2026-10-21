# Profile entrance fix — 1.8-49

Static target: WeChat 8.0.78 `/tmp/wechat-8.0.78-inset-analysis/WeChat`, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. The binary was read only; no device process or account operation was run.

Observed native routing:

- `WeixinContactInfoAssist -showAlbumList` (`v16@0:8`, `0x10a94db08`) calls `WCTimelineRouterHelper +navigateToUserPageViewController:contact:scene:thumbnailCnt:source:` at `0x10a94ddb8`. Its original navigation and existing album content adapter can be used without building another screen.
- `WeixinContactInfoAssist -onSocialInfoHandle` (`v16@0:8`, `0x10a93e160`) creates `genSocialInfomationViewController` and calls native `PushViewController:animated:` at `0x10a93e1f4`.
- `ContactInfoViewController -jumpToContentViewController:` (`v24@0:8@16`, `0x100fbb220`) forwards to `-jumpToContentViewController:completion:`. The latter uses `newMessageByContact:msgWrapToAdd:showMainView:animated:extraInfo:completion:` and `PushOtherBaseMsgControllerByContact:...`; despite the general name, this is a chat entry. Its existing concealed-profile action guard must remain.

The bug was in the plugin's registration: both read-only entrance callbacks used the same hidden-profile action blocker as messaging. `Navigate0` now admits those two native routes for the current concealed profile. Account epochs, current assist identity, contact identity, and binding generations still reject retired or mismatched objects. The Add button presentation and send/call/add guards are unchanged.

`Tests/verify-close-friend-profile.sh` compiles the complete production adapter and exact production hook registration body against minimal native/UI substitutes. Sixteen focused checks cover: locked album/social-info entrance, sensitive actions blocked, native Add presentation without relationship mutation, reveal/relock, ordinary friend pass-through, retired assist, changed contact, blocked account snapshot, account switch, and expired owner.

This is static evidence plus host regression, not device rendering verification. The installer/package and true device acceptance are tracked by the parent 1.8-49 audit.
