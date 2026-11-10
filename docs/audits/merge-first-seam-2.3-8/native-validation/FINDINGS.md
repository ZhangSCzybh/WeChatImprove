# WeChat 8.0.80 first group seam: native evidence

This audit read the supplied arm64 executable without executing it. The source image SHA-256 is `571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`. `metadata.json` records the real class relationships, Objective-C type encodings, ivars, and method addresses. The adjacent bounded disassemblies preserve the evidence; `-annotated.asm` adds selectors, ivars and CFStrings resolved from that same executable.

## Empty status description is a non-nil sentinel

`CommonMessageViewModel.chatRoomTextStateIconDescription` (`@16@0:8`, IMP `0x10104c8b0`) returns an empty constant NSString at `0x10104ca10`–`0x10104ca14` when there is no eligible status icon. The CFString is at `0x11cf9be58`; its contents are empty. The paths include disabled display name, non-head part, disabled group status feature, contact of another class, and missing recent text state. A real status follows `mostRecentTextState → iconWrap → iconDescription` instead.

Consequently, testing only whether this getter returns non-nil rejects the dynamic native geometry for ordinary named first rows. Later rows do not enter that named branch. The 2.3-7 fallback freezes the entire native row from its first measurement; this is a first-row-specific source of retained spacing. Treat the empty NSString as absence; preserve the conservative fallback for a non-empty string or an unknown description object.

The user's observed incoming first seam was 13pt versus 2pt later (11pt excess). This audit establishes the fallback trigger, not an independent runtime measurement of the 11pt. The exact remaining native margin depends on theme, font and bubble asset. Do not describe 11pt as a universal constant or remove a fixed 11pt from native rows.

## Avatar view includes an invisible 3pt margin on each side

`CommonMessageCellView.initHeadImageView` constructs `MMHeadImageView`. At `0x10103b478`–`0x10103b55c`, wrapper `setSize:` receives `ceil(systemFont.lineHeight) + 2*T + 6` on each axis. At `0x10103b668`–`0x10103b734`, `setImageSize:` receives `ceil(systemFont.lineHeight) + 2*T`, where `T` is the native `text_message_margin_top` theme value.

`MMHeadImageView.layoutSubviews` (`0x103dd6dd8`) sets `_headImageView.frame` to `((wrapper.width-imageSize.width)/2, (wrapper.height-imageSize.height)/2, imageSize.width, imageSize.height)` at `0x103dd6f2c`–`0x103dd6f90`. Thus a visible 37pt avatar has a 43pt wrapper and 3pt invisible margin at the top and bottom. Counting the wrapper's lower edge produces the user's outgoing first seam of 5pt instead of the requested 2pt. The 37pt size is the reported device observation; the native evidence proves the 6pt wrapper/image difference.

The `headImageView` getter (`@16@0:8`, IMP `0x103dd9560`) directly returns the `_headImageView` ivar. Its actual type is `MMUILongPressImageView *`, and `MMHeadImageView` inherits `MMUIView`. Reading this object through a checked object-returning getter is signature-safe. The native `imageSize` getter uses `{CGSize=dd}16@0:8`.

## First-render geometry must not depend on the child's completed layout

`MMHeadImageView.setImageSize:` (`0x103dd8fe8`–`0x103dd9030`) stores `_imageSize`, computes the preferred corner size, and calls the inner image's `setSmoothCornerRadius:`. It calls neither `setFrame:` nor `setNeedsLayout`. The inner frame is established by the child's later `layoutSubviews`.

The enclosing CommonMessageCellView can therefore reach the merge render hook before the inner image's new frame exists. A helper that requires `inner.bounds.size == imageSize` and otherwise charges the wrapper can incorrectly retain the 3pt in the monotonic safety envelope on the first pass. For the inspected MMHeadImageView hierarchy, a finite positive `imageSize` within the wrapper can provide the same centered visible rectangle as the native layout even before the child is laid out. Keep guards for unrelated classes, transforms, invalid sizes, nonstandard bounds, and visible decoration. This is an evidence-based first-pass measurement; forcing child layout is unnecessary.

## Default border does not block the visible-image measurement

`MMHeadImageView.initWithUsrName:headImgUrl:bAutoUpdate:bRoundCorner:` explicitly sets `_addBorder = NO` at `0x103dd6b18`–`0x103dd6b1c`, creates a UIImageView without assigning an image at `0x103dd6c28`–`0x103dd6c40`, and sets its hidden flag to `!_addBorder` at `0x103dd6c4c`–`0x103dd6c60`. `CommonMessageCellView.initHeadImageView` contains no border-image or add-border setter. `setAddBorder:` (`0x103dd8100`) keeps the same hidden semantics. The default border is hidden, so the safety guard for a visible border image does not reject the ordinary avatar.

Actual custom borders must continue to count their visible extent. A border UIImageView that is visible and has an image or highlighted image is grounds for retaining its full bounds conservatively; this audit does not prove arbitrary custom assets are transparent.

## Focused verification and remaining limits

The useful regression fixtures are independent native coordinates: named first row with `chatRoomTextStateIconDescription = @""`; non-empty status preserving native fallback; 43pt wrapper with 37pt centered inner image; and a first render where imageSize is 37pt while the child frame remains zero. Assert the requested 2pt bubble seams and a stable height/origin pair through repeated layouts. A visible border fixture should retain the conservative footprint.

This audit did not install a package, restart a service, touch chat data, or run the iOS UI. The native source confirms the two first-row-specific causes and the first-render hazard. Final device acceptance remains necessary for the observed incoming 11pt excess and custom-avatar workflows.
