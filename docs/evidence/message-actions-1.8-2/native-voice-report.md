# Voice preparation and native success UI — 8.0.78.34 / 1.8-2

Static, read-only investigation on 2026-10-18. Target `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`, arm64, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`, cryptid 0; REA open_binary reconfirmed identity. No device launch, installation, account/database access, live send or original-checkout edits. Requirements: `.superpowers/sdd/2026-10-18-message-actions-device-followups/requirements.md`. Existing 2026-10-17 evidence is reused, never overwritten. New `.asm` bounds come from LC_FUNCTION_STARTS, not a guessed next selected method. Nearest exported symbol headings are not method names. `native-voice-selected-methods.json` binds exact method identity/ABI/address; `native-voice-all-methods.json` is only the selected voice-related classes, not a full-binary inventory.

## Proven defect and limits of attribution

`CSMessageMediaProvider.snapshot:` currently sets completion only for `m_uiDownloadStatus == 1 || == 9`. Native status is a bitfield:

* `CExtendInfoOfVoiceMsg -IsDownloadEnded`, `B16@0:8`, `0x104b9a5d4`, returns status **bit 0** (`and w0,w20,#1` at `0x104b9a610`).
* `-SetPlayed` ORs **0x4** at `0x104b9a680`.
* `-SetPlaySounded:` ORs **0x10** at `0x104b9a7f4`.
* `-IsRecording`, `B16@0:8`, `0x104b9a6a4`, is `isSenderFromMsgWrap(refWrap) && !(status & 0x8)`; bit 3 is tested at `0x104b9a6e0`.

Consequently played completed incoming status 5/17/21 and outgoing 13/25/29 are rejected by the current equality test. This explains a mechanism affecting both self/other voices and unnecessarily requesting a download before even reading the valid file. These are bit combinations derived from observed setters, not newly guessed enum constants. The actual phone source's status was not observed, so exact device causation remains unverified.

Completion bit alone is insufficient: AudioSender prepares an ongoing recording with status 1 and zero voice duration. The recorder callback supplies the independent outgoing finalized-recording contract: `OnRecorderPart:Offset:Len:EndFlag:ForceDelete:Duration:` is `v44@0:8@16I24I28I32B36I40` at `0x10017c66c`; EndFlag is captured from x5, compared to 1 at `0x10017cb7c`; the terminal branch ORs status **0x8** at `0x10017cd00` and calls `updateMessageToDB:` at `0x10017cd78`. That update calls `UpdateContent:nil` at `0x10017a704`. Thus a source must be not recording as well as download-ended before local bytes are eligible. Refuse an ongoing source instead of scheduling a network replacement of its growing recording.

## Local XML, field ownership, path, format and byte verification

`CExtendInfoOfVoiceMsg -UpdateContent:` at `0x104b9a280` generates the literal CFString at `0x11e7a99c8`:

```
<msg><voicemsg voicelength="%u" voiceformat="%u" forwardflag="%u" />%@</msg>
```

It intentionally lacks `length`, `endflag` and `cancelflag`. Absence cannot be interpreted as explicit zero/end-not-reached. In particular, do not make positive network XML length mandatory for a natively finalized outgoing recording. Current production already has a codec-duration fallback, so missing XML length alone is not proven to be its present blocker. Explicit cancellation/nonterminal network flags still deny readiness; an absent extension end flag is not independent evidence of unfinished recording, because the native local serialization omits it.

The scalar voice fields are owned by **CExtendInfoOfVoiceMsg**, reached via CMessageWrap forwarding/type extension: `m_uiVoiceTime` `0x104b9a910`, `m_uiVoiceFormat` `0x104b9a920`, `m_uiVoiceEndFlag` `0x104b9a930`, `m_uiVoiceCancelFlag` `0x104b9a940` are `I16@0:8`; `m_dtVoice` `0x104b9a960` is `@16@0:8`. A direct class-method-list check on CMessageWrap does not prove those getters unavailable. Use the established forwarding-aware adapter or actual type extension with ABI validation. Getter absence must not become numeric zero; format zero is valid (prior ordinary-repeat evidence).

`+[CMessageWrap getPathOfAudio:]` is **correctly a class method taking the wrapper**, `@24@0:8@16`, `0x104baa93c`. It obtains `getUserNameFromMsgWrap:`, localID and native GetDocPath, then `GetPathOfMesAudio:LocalID:DocPath:`. It is not a filename/string argument API. This is not an ABI root cause.

`-[CMessageWrap getVoicePath]`, `@16@0:8`, `0x104b9ae04`, is the more general native source resolver: reminder-attachment observer, enterprise chat path, then `GetChatName` + localID + native GetDocPath. The normal fallback calls `GetPathOfMesAudio:LocalID:DocPath:` at `0x104b9b044`. Prefer this validated instance selector, retaining the existing verified class selector as capability fallback for ordinary supported messages; do not synthesize account filesystem paths.

`-[CMessageWrap getVoiceFormat]`, `I16@0:8`, `0x104b9abc4`, reads `m_uiVoiceFormat` for ordinary sources. For values -1/4/7 it inspects bytes through getVoicePath and AudioHelper. Native playback `AudioReceiver StartPlay:Path:fromTime:` calls **getVoiceFormat**, not only the raw metadata getter. `AudioHelper +isSilkFile:` is `B24@0:8@16` at `0x10016fc84`, checks `#!SILK` at byte offset 1. `+isOpusFile:` same ABI at `0x10016fd54`, checks `#!OPUS_RAW_V1` at offset 0. These are format checks, not completeness checks. Neither is permission to accept a partial header-only file. getVoiceFormat maps positive Silk detection to 4 and Opus to 7 without mutating the source field.

Implementable preparation contract (conservative product design, derived from the above):

1. Verify exact account/source/chat/localID and forwarded getter signatures. Snapshot download-ended bit, sender/not-recording state, format, duration and cancellation metadata. For outgoing source, require the native finalized-recording condition, not status1 alone.
2. Read immutable m_dtVoice when available; otherwise use native getVoicePath and a stable file read (size/mtime before/after, actual bytes count). This only proves a stable read, not completeness.
3. Require known supported format and positive millisecond duration. When XML declares positive byte length, require actual count to match; do not bypass a mismatch after a terminal callback. For no declared length, use native completed/nonrecording state plus codec validation and native measured duration consistent with the source duration. Retain strict partial/truncated/unknown-format negative controls; never substitute file existence.
4. Respect explicit cancel/nonterminal flags and correlation. A terminal matched callback may resolve prior download-in-progress metadata but cannot make malformed bytes valid. Re-fetch persisted source metadata after native original callback when possible; the original UI wrapper need not be the object native updated.
5. On completed local source with malformed/missing bytes or absent remote download metadata, fail with bounded source-unavailable feedback. Do not automatically invoke a downloader merely to repair an eligibility mismatch.

Duration helper implementations and units are retained in `../message-actions-native-2026-10-17/ordinary-repeat-contracts.md`: Silk `AudioUtil +calcSilkVoiceTime:` and Opus `OpusAudioPlayer +calculateVoiceTime:` consume NSData, return uint milliseconds. The numeric byte-count helper has its own verified `I24@0:8I16I20` ABI. Preserve the source duration in milliseconds. This pass does not establish a universal codec-duration error tolerance or certify malformed streams solely from helper return.

## Download service and source-preservation constraint

`VoiceMsgDownloader -onServiceInit` `v16@0:8` at `0x10629233c` constructs CGI/CDN downloaders, assigns receiver/delegate to self, calls **Start** on each at `0x1062923a4`/`0x1062923e8`, creates failure set, registers current-context extension. Obtain this established service through verified active account/context service resolution. Do not alloc/init a bare downloader or manually replay onServiceInit; that does not provide the established service lifecycle.

`-downloadMsg:` `v24@0:8@16`, `0x1062924dc`, takes the exact source wrapper, chooses native CDN/CGI using canUseCdnDownload/bypass, obtains chat/from/to/current account, passes localID/serverID/createTime/XML/**m_dtThumbnail** to `OnSyncDownload:LocalID:n64SvrID:CreateTime:Xml:Voice:`. The final Voice argument is not m_dtVoice. This operation returns void; successful selector invocation is not download completion. A correctly initialized service has nonnil internal CGI/CDN receivers; direct ivar dispatch to nil would otherwise silently do nothing.

A crucial reason to avoid speculative download: `CDownloadVoiceMgr -OnSyncDownload:...` at `0x101175198` parses XML; when cancelFlag is not 1 and supplied Voice/m_dtThumbnail has zero length (`0x1011755dc–5f0`), it computes the native file path, calls FileExist and **RemoveFile:** at `0x101175740–748`, then AddNewDownload at `0x101175750`. This branch does not first preserve an already complete local recording. Calling it for a wrongly rejected played source can delete existing local audio. This is static branch behavior, not a claim that the phone file was deleted. The source wrap must not be cloned/mutated to force network flags; correct eligibility/read handling before download is essential.

Retained callback contract remains: `VoiceMsgDownloader OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:` is `v68@0:8@16I24q28I36I40I44I48@52I60I64`, `0x106292bf8`. The native success code is **ErrNo=3**, terminal EndFlag=1. Call original first; correlate account epoch, source chat/localID and available serverID; then re-read/revalidate media. CDN terminal sender is `handleDownloadCDNSuccess:`; CGI supports chunks. Callback itself is not a media checksum. Keep timeout, error completion, shared per-source download/subscriber cancellation, and no retry after any send attempt.

## Native false success indicator, minimal scoped hook

`ForwardMessageLogicController -OnSharePreConfirmSheetViewSend:` invokes per-recipient forwarding, then performs success UI without remote delivery acknowledgement. In the inspected branch at `0x101c30bc0` it reads `self.bShowSendSuccessView`. If true (and delegate decision true), it calls the sheet's `showSendSuccessView`. Otherwise it dismisses the sheet, then reads `self.bHiddenSendSuccessToastView` at `0x101c30c04`; **false enters a fallback success toast**. Merely returning NO from bShowSendSuccessView is insufficient.

Two existing exact instance getters are `B16@0:8`: `bShowSendSuccessView` at `0x101c3c340`, `bHiddenSendSuccessToastView` at `0x101c3c360`. For the exact logic bound to an enhanced voice operation whose send state is pending/unconfirmed, a scoped hook may return NO and YES respectively. Return original values for every unrelated/unbound flow. This preserves original confirmation handler, user comment, sheet dismissal and delegate cleanup; do not suppress global toast APIs or skip the whole native callback. `shouldShowSendSuccessView:` is queried on the **delegate**, not a method implemented on this logic class; that is a less precise interception point. The separate `onSendSuccess` at `0x101c307e8` is another receiver's lifecycle/UI method and is not delivery proof.

A per-operation binding/lifetime or explicit retained enhancement marker must last through these getter calls; clearing it in an earlier delegate callback would re-enable the false success UI. This is an implementation lifetime requirement, not a reason to globally suppress ordinary forwarding feedback.

## Required negative/positive regression shapes

Production-path tests should exercise completed incoming status5/17/21 and completed outgoing9/13/25/29 with valid native bytes; sender status1/5/17 lacking bit3 must not submit. Include native local XML without length/endflag, explicit nonterminal/cancelled XML, wrong byte count, truncation, unknown getter/format, growing file, account change, source mismatch, late callback after cancel, and callback ErrNo0/3 with EndFlag0/1. Verify missing/invalid complete outgoing source does not call destructive downloader. Verify actual forwarding getters hide both success-sheet and fallback-toast branches only for the exact bound enhancement and retain comments/cleanup/unrelated originals. Actual phone acceptance after packaging remains unperformed.
