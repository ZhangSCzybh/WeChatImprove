# Spacing evidence for 1.8-34

This investigation uses the same WeChat 8.0.78.34 executable identified by the
incoming crash: UUID `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE`, SHA-256
`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`.
`extract.py` reads Objective-C metadata and `disassemble.py` produces bounded
method disassembly using `xcrun llvm-objdump`. No device execution was available.

## Confirmed hierarchy mismatch

`CommonMessageCellView initHeadImageView` adds the avatar to the cell itself at
`0x100f592b0`–`0x100f592c0`. `CommonMessageCellView layoutInternal` separately adds
`m_contentView` to that cell at `0x100f54298`–`0x100f542ac`. Text backgrounds are
added to `m_contentView` at `0x105bf4d08`–`0x105bf4d28`; voice backgrounds use the
same parent at `0x10627686c`–`0x10627688c`.

The old adapter required `head.superview == bubble.superview` before placing the
avatar within a compact row. This is false in the real text/voice hierarchy, but
the joint regression fixture incorrectly used a common parent. The avatar was
therefore included in seam bounds and could expand a previously compact plan.

The focused source fix compares rectangles in cell coordinates and permits only
the already qualified cell/content container parents. Unknown hierarchies,
transforms, avatars over 38pt, insufficient row height, and actual lane overlap
retain the safety path. The new regression includes an offset container whose
local coordinates overlap the avatar even though its cell coordinates do not,
then moves it into a real overlap to verify stable safety expansion.

`../../agent-spacing-before.log` records failure after the first render changed
the published height. `../../agent-spacing-after.log` records 235,148 policy
checks and 17,255 adapter/lifecycle checks passing after the fix. These are host
UIKit doubles and do not establish device rendering or performance.

## Short rows are not necessarily 38pt

`VoiceMessageViewModel voiceNodeHeight` computes ordinary height from
`2 * text_message_margin_top + ceil(systemFont.lineHeight)` at
`0x10628dcbc`–`0x10628dcfc`, returning it directly when there is no translation.
The strings are `text_message_margin_top` and `#message_node_view`; this is a
font-dependent result, without a 38pt minimum clamp.

The original PNG, sampled without resizing by `measure-screenshot.py`, contains
seven short text/voice custom fills each 111 physical pixels high. At the supplied
3x resolution this is **37pt visible height**. Consecutive short bubbles have a
162px pitch and 51px blank seam, corresponding to 54pt and 17pt. Exact edge
samples are in `screenshot-measurements.json`.

This is visible fill evidence; it does not expose the original UIView frame or
model `contentViewSize`. It therefore should not be presented as a runtime frame
measurement. It does establish that the earlier synthetic 38pt body fixture
cannot substitute for this screenshot's measured visible geometry.

The remaining native cap validation rejects any target shorter than 38pt. The
native text type is 12; the BubbleManager jump table at `0x118d8e878` maps type 12
to `0x104aef17c`, retaining the initial `{30,25,8,20}` caps. This validation needs
to distinguish native template constraints from a custom template fitted to the
actual target. No native cap validation source was modified by this subtask.

## Other verified contracts

- `BubbleInfo getBubbleImage:isDarkMode:useCache:` has ABI `@28@0:8B16B20B24`,
  matching the adapter's three BOOL arguments and object return.
- Native `contentViewSize` has encoding `{CGSize=dd}16@0:8`. Text measurement
  returns unspecified width zero and the actual body height.
- An unsplit text row's `cellDataForRow:` returns its model directly.
- The controller's height callback calls that row model's `rowHeight`, which
  performs native measurement when needed and rounds the row height upward.
- Ordinary absent voice translation does not make `canShowTranslateLoadingView`,
  `canShowTextTranslateView`, or `canShowTextTranslateText` true. `canShowAIReply`
  reads the message's `m_showAIReply` state; no always-true default was found.
- Native quote row measurement adds 4pt plus reply height and the vertical reply
  insets outside `contentViewSize`, matching the current quote accounting.

None of these contracts alone establishes the user's full device runtime state.
