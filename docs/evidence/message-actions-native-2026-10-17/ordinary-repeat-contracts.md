# Ordinary repeat contracts and voice duration follow-up

Date: 2026-10-17. Read-only static research; no device sends, services, accounts, or databases touched. This supplements `report.md`; it does not replace the first report or its manifest. Baseline plugin source was read with `git show 2aa7bcb8:...`, not from another task's edited files.

## Target and confidence

The native target is the same extracted, unencrypted arm64 WeChat 8.0.78/build 8.0.78.34 executable at `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. Device/runtime identity remains unverified. Addresses below are unslid virtual addresses. Objective-C method encodings come from the target's metadata; control flow comes from bounded LLVM disassembly annotated with selector references. Selector annotations are aids, not decompiler output. Indirect callees and nested payload copy implementations were not exhaustively analyzed.

## Implementation decisions supported by this evidence

1. Do not use `CMessageMgr.ResendMsg:MsgWrap:` for repeat. It is a retry operation with source mutation, persisted identity lookup, and a conditional deletion of the input message.
2. Preserve source chat/local/server IDs only on an independent **factory input** for reading media. Give the final outgoing wrapper a fresh identity before its one native insertion/send entry.
3. Do not call `SendMessageMgr.AddMsgToSendTable` on a wrapper whose local ID is zero. The earlier report proves this queue requires an existing local record.
4. `CMessageMgr.AddMsg` owns insertion and ordinary dispatch. It must not be followed by a second queue call. Apps, videos, and emoji have dedicated insertion/upload owners.
5. Native forwarding factories are useful payload adapters, but they intentionally apply forwarding semantics. Their existence does not prove exact repeat equivalence for every subtype.
6. `m_uiVoiceTime` and native uploader `VoiceTime` are milliseconds. Preserve the raw field, without the legacy `>300` unit heuristic.

## Recommended route matrix

| Source type | Independent payload preparation | One native operation | Qualifications |
|---|---|---|---|
| Text 1 | Existing logic-controller text route, display content appropriate to the current chat | `SendTextMessage:` or ABI-checked `SendTextMessage:externInfo:` | Void return means invoked, not server delivery. Factory text uses `GetDisplayContent`, not an opaque XML clone. |
| Image 3 | `ForwardMsgUtil +imgMsgFromMsgWrap:` on a detached source preserving media lookup IDs | `CMessageMgr -AddMsg:MsgWrap:` | Factory materializes image/thumbnail or CDN forwarding metadata; retain required image upload status. A plain wrapper copy may lack image bytes. Detach mutable image info (see ownership below). |
| Video 43 | `+GenForwardVideoFromMsgWrap:` yielding independently owned `CaptureVideoInfo` | `-AddVideoMsg:ToUsr:VideoInfo:` or verified four-argument variant with type 43 | Generator result is **not** a CMessageWrap on this target. Native video add constructs/inserts its own new wrapper and starts upload. Preserve `m_bForward=YES` while reusing source paths. |
| Emoji 47 | `+emojiMsgFromMsgWrap:` or fresh wrap with valid MD5 plus required emoji payload | `-AddEmoticonMsg:MsgWrap:` | Native method inserts and uploads; no extra queue. Game/dice emoji forwarding invokes `SetGameContentForMsgWrap:` and may change game semantics. |
| Card 42 | `+cardMsgFromMsgWrap:` | `-AddMsg:MsgWrap:` | Allocates a new wrapper of source type and copies content. No source media lookup required in this factory. |
| Location 48 | `+locMsgFromMsgWrap:` | `-AddMsg:MsgWrap:` | Factory delegates to `locationMsgWrapFromMsgWrap:`, then sets sender/time/status/image status and updates content. Delegated builder's deep-copy behavior is not established here; require distinct output. |
| App 49, record/note | `+appMsgFromMsgWrap:` retaining record payload | `-AddRecordMsg:MsgWrap:` | Native forward sender checks `IsRecordOrNoteMsg:` and selects this dedicated entry. Preserve capability instead of flattening to generic queue. |
| App 49, local file | App factory plus readable source app-data path resolved **before** outgoing identity reset | `-AddAppMsg:MsgWrap:DataPath:Scene:` | Native path variant inserts, hard-links source file into new identity's path, writes thumbnail and starts app upload. Never supply the new output path as the source path. |
| App 49, other | App factory plus required app data (or nil only when native remote attachment metadata suffices) | `-AddAppMsg:MsgWrap:Data:Scene:` | Dedicated app entry owns insertion, payload/thumbnail writing and upload. `AddMsg` only explicitly reroutes `isReferMsgType`; it does not universally replace app upload. |
| Other supported ordinary type | Fresh distinct wrapper with complete type payload | `-AddMsg:MsgWrap:` | This proves insertion/dispatch ownership, not that every arbitrary native message type is repeatable. Unknown/incomplete payload must be reported unsupported rather than queued with ID zero. |

All selections should be made before the first send-capable invocation. A void native method returning normally is not grounds to try another send operation. Once a send-capable entry has been invoked, exceptions or missing acceptance evidence cannot justify automatically sending again.

## ABI and insertion ownership

`ordinary-methods.json` records all inspected encodings. Core entries:

| Class / selector | Address | Encoding / return |
|---|---|---|
| CMessageMgr `AddMsg:MsgWrap:` | `0x104b2dc1c` | `v32@0:8@16@24`, void |
| CMessageMgr `ResendMsg:MsgWrap:` | `0x104b2e4e0` | `v32@0:8@16@24`, void |
| CMessageMgr `AddVideoMsg:ToUsr:VideoInfo:` | `0x104b350b4` | `@40@0:8@16@24@32`, object |
| CMessageMgr `AddVideoMsg:ToUsr:VideoInfo:MsgType:` | `0x104b35dc4` | `@44@0:8@16@24@32I40`, object |
| CMessageMgr `AddShortVideoMsg:ToUsr:VideoInfo:` | `0x104b350c4` | `@40@0:8@16@24@32`, object |
| CMessageMgr `AddEmoticonMsg:MsgWrap:` | `0x104b39674` | `v32@0:8@16@24`, void |
| CMessageMgr `AddAppMsg:MsgWrap:DataPath:Scene:` | `0x104b3a1f8` | `v44@0:8@16@24@32I40`, void |
| CMessageMgr `AddAppMsg:MsgWrap:Data:Scene:` | `0x104b3aa84` | `v44@0:8@16@24@32I40`, void |
| CMessageMgr `AddRecordMsg:MsgWrap:` | `0x104b42fb4` | `v32@0:8@16@24`, void |
| ForwardMsgUtil factories in matrix | See index | `@24@0:8@16`, object |

`AddMsg` first routes `isReferMsgType` to `AddAppMsg:...Data:nil Scene:1` (`0x104b2dc6c–98`). Otherwise it updates image content when appropriate, then calls its **backing storage object's** `AddMsg:MsgWrap:` at `0x104b2dd60–7c`. It tests the resulting local ID at `0x104b2dd80–90`; zero exits through logging. Nonvoice ordinary handling checks image upload state: a local image goes to `StartUploadImageMsg:MsgWrap:` (`0x104b2e308–31c`), while the ordinary path calls `AddMsgToSendTable` (`0x104b2e27c–288`) and `SendMsg` (`0x104b2e2ec–2f0`). Notifications/session updates are also native-owned. Therefore generic `AddLocalMsg + queue` bypasses behavior already present in `AddMsg`, and an extra queue call after AddMsg duplicates responsibility.

`AddEmoticonMsg` validates MD5/type, updates content, calls backing storage AddMsg (`0x104b39734`), requires assigned local ID, posts native notifications and calls its uploader `StartUpload:` (`0x104b39a2c`). `AddAppMsg:Data:` calls `AddLocalMsg` (`0x104b3ae00`) and validates local ID. It writes app data and thumbnail under the new identity before `StartUploadAppMsg:MsgWrap:Scene:` (`0x104b3b3ec`). `DataPath` calls AddLocalMsg (`0x104b3a4b8`), resolves the new app-data path, and uses `HardLinkFile:To:` (`0x104b3a7bc`) before `StartUploadAppMsg` (`0x104b3aa18`). These methods modify their outgoing wrapper and files; only independently owned fresh output belongs here.

## Why ResendMsg is unsafe for repeat

In `ordinary--CMessageMgr--ResendMsg_MsgWrap_.asm`, `x20` is the original caller-supplied wrap, `x19` the caller-supplied chat, and `x25` the internal copy:

- Type 34 is rejected at the start. The native sender check is `isSenderFromMsgWrap:` at `0x104b2e620`; non-self input exits (`0x104b2e62c → 0x104b2e734`).
- `ChangeForDisplay` runs on input `x20` at `0x104b2e634–640`. Input local ID is read at `0x104b2e64c–658`. A video branches to `ResendVideoMsg` with that same input at `0x104b2e71c–72c`.
- For other types it calls `[input copy]` at `0x104b2e820–82c`. Image/thumbnail/app paths are resolved using source chat/local ID. Thus zeroing the input ID removes the very lookup identity needed for payload preparation.
- The tail checks app file/status exceptions and video overwrite ID (`0x104b2f17c–230`). On its ordinary path, a nonzero internal-copy local ID leads to **`[self DelMsg:callerChat MsgWrap:originalInput]`** at `0x104b2f234–258`. The argument is x20, not x25.

A source clone with the same persisted local ID can still name the source database record. Pointer inequality alone does not protect historical data. Conversely a source clone reset to local ID zero can prevent correct path lookup. The robust boundary is factory input (read identity) versus outgoing output (fresh identity), followed by a new-message entry, not ResendMsg.

## Factory semantics and source ownership

`CMessageWrap -copyWithZone:` at `0x104b9f00c` allocates a new instance, initializes its message type, and invokes source `copyToMsg:`. `copyToMsg` copies base identity fields as well as content and extensions. It copies the three type/from/biz extension containers and rebinds their `m_refMessageWrap` to the new wrap (`0x104b9e8f8–9a4`). This is more complete than manually copying only text fields, but is not a universal deep-copy contract: `groupInfo` is passed directly at `0x104b9ef80–fa8`, as is `referPartialInfo` (`0x104b9ee68–90`). Nested extension copy implementations were not exhaustively inspected.

Factory-specific evidence:

- Text (`0x101c49968`) calls source `GetDisplayContent` and `GenTextMsgWithContent`, preserves ignoreSoftBank/weappSourceUsername and regenerates message source. This is intentionally regenerated displayed text.
- Image (`0x101c49bc0`) allocates type3, sets self/time/status/forward flags, retrieves source HD/middle data and thumbnail, handles CDN/HD/vcodec/wxam/live photo paths and metadata, and preserves app metadata/grouping. It can reuse input `m_oImageInfo` (`0x101c4a828–898`), and later calls `setAssetId:` on that object (`0x101c4a9a0`). A defensive wrapper copy alone does not establish ownership of this nested mutable item; clone/detach it before factory use.
- App (`0x101c4b194`) allocates type49 and copies title/description/thumbnail, app/file/media metadata, record/share/product/canvas/miniapp/Finder/live/music and newer nested items, source attachment/CDN information, and content. It regenerates record payload (`genForwardAppRecordItemFromMsg:` at `0x101c4bbdc`), uses Finder `forwardItemBy:` (`0x101c4c2bc`), and updates forwarding last-message metadata (`0x101c4c6e8`). Many nested objects are handed directly to setters. This is broad native subtype preservation, with explicit forwarding transforms; exact repeat equivalence and universal nested immutability are not established.
- Emoji (`0x101c4d8b0`) allocates type47 and copies MD5/type/product/designer/dimensions/URL/auth/attached-text fields. A game-type branch invokes `SetGameContentForMsgWrap:` (`0x101c4dbf8`), so dice/game behavior must be treated explicitly.
- Card (`0x101c4dd88`) allocates source message type, sets sender/time/status, and copies source content.
- Location (`0x101c4df18`) delegates construction to `locationMsgWrapFromMsgWrap:` and then normalizes sender/time/status/image status/content. Its delegated constructor needs runtime pointer/type validation.

No direct DelMsg/Resend/insertion/send entry is present in these bounded factory bodies. This establishes that they are payload builders at this level; it does not certify every indirect helper or shared nested object as side-effect free. Prefer independent input/output, detach known mutable nested objects touched by the path, validate the factory result, and never reset IDs on the original source.

## Video: CaptureVideoInfo and one insertion/upload owner

`GenForwardVideoFromMsgWrap:` (`0x101c4e770`) reads `source.m_dicForwardParas[@"CaptureVideoInfo"]`. If present, it returns that object unchanged (`0x101c4e7a4–7f4`). On the fresh branch, the class reference at `0x120176520` resolves to `CaptureVideoInfo` (`0x12036fab8`), which it allocates at `0x101c4e85c–868`. It populates source thumbnail/video/raw paths, size/time/md5/newmd5, streaming/app/CDN/raw/asset metadata and sets `m_bForward=YES` (`0x101c4e9bc–9c8`). No CMessageWrap fallback is produced by this method on the studied target.

Do not treat a cached CaptureVideoInfo as independently owned. Clone it with a verified copy contract or clear only the detached input's independent forwarding-parameters cache before generation; never mutate the original dictionary. Do not assume unknown objects with a `msgWrap` selector are safe payloads.

`CMessageMgr AddVideoMsg:ToUsr:VideoInfo:` simply tail-calls its four-argument variant with type43 (`0x104b350b4–0c0`). The four-argument method constructs a new wrapper via `CreateVideoMsg:ToUsr:VideoInfo:MsgType:retMessageWrap:` (`0x104b35f10`), preserves video app/source/grouping metadata, inserts through backing storage (`0x104b363b8`), checks assigned local ID (`0x104b3646c`), prepares media files, posts native notifications, and starts `uploadVideoUnifyMgr.StartUpload:` (`0x104b36e14–e30`). It returns the newly constructed wrapper in x24 at `0x104b36f24–44`.

`VideoInfo.m_nsSpecifiedChatName`, when nonempty, overrides the explicit recipient (`0x104b35e28–e84`). Normalize it on the independent info to the intended target or clear it. `m_bForward` selects hard-link branches (`0x104b36b48`, `0x104b36bd0`, `0x104b36bf4`) instead of rename branches (`0x104b36b78`, `0x104b36c28`, `0x104b36c4c`); do not clear it when retaining original source paths. This also applies to raw video handling. A nonnil return is a local result, not server success. Once this send-capable method has been called, do not fall through to AddShortVideoMsg or queue another message because a result check failed.

## Voice duration is milliseconds

`AudioUtil +calcVoiceTime:VoiceFormat:` is `I24@0:8I16I20` at `0x10017ea0c`. `+calcSilkVoiceTime:` is `I24@0:8@16` at `0x10017eb6c`, a tail call to `SilkAudioPlayer +calculateVoiceTime:`.

- `SilkAudioPlayer +calculateVoiceTime:` (`0x1059f7988`) iterates decoder frames and adds **20** to duration per frame (`0x1059f7a70–88`). Its other decoder sizing constants include 0.02 seconds/frame. The returned integer is elapsed milliseconds.
- `OpusAudioPlayer +calculateVoiceTime:` (`0x1052ad4fc`) computes decoded PCM bytes divided by `(channels * sampleRate * 2)` and multiplies by float **1000** (`0x1052ad718–738`; immediate `0x447a0000`), then converts to an unsigned integer. This independently establishes milliseconds.
- `UploadVoiceCDNMgr.ResendVoiceMsg` obtains calcSilk/calcVoiceTime and writes it directly to `m_uiVoiceTime` (`0x105f63218–27c`); later passes that field to AddNewPart's VoiceTime.
- `MMNewUploadVoiceMgr.ResendVoiceMsg` uses `m_uiVoiceTime` unchanged for format4/SILK (`0x10453bf88–98`), and derives cumulative chunk milliseconds for other formats (`0x10453bf9c–bfb4`). Native upload VoiceTime remains milliseconds in both branches.

Therefore copy a valid source `m_uiVoiceTime` unchanged into the fresh voice wrapper. For absent/invalid duration, use the appropriate verified native codec duration calculation, not a value-magnitude guess. Display seconds conversion is a UI concern and must not change the upload field.

Format zero is a valid native enum value. `calcVoiceTime:VoiceFormat:` explicitly branches on zero (`0x10017ea34 → 0x10017eac4`) and computes `floor(floor(byteCount/2)/7) * 20` milliseconds. Format1 computes `floor(byteCount/60) * 20`, format4 delegates to silk duration, and format7 to opus duration. The human codec name for format0 was not proven; its validity does not depend on naming it. Distinguish a missing getter or failed metadata read from a successful read whose numeric value is zero.

Download-status values alone are not universal completion evidence. In `VoiceMsgDownloader.OnRecvData`, ErrNo3 leads to `m_uiDownloadStatus = (EndFlag == 1)` (`0x106292f20–38`), so status1 means complete in that callback path. But `AudioSender.prepareSend:` sets status1 while constructing a new recording with voiceTime0 (`0x10017afd8–0x10017b020`), and `AudioSender.ResendVoiceMsg` sets status9 on the new wrapper before loading/copying media (`0x1001799cc–9d8`). Neither `status==1` nor `status==9` independently establishes complete arbitrary source bytes. Use matched terminal completion plus revalidation, or validate available file/data length against declared total, native duration and codec metadata; do not accept a merely nonempty growing file as complete.

## Baseline capability and validation limits

At baseline `2aa7bcb8`, RepeatHooks supports menu types1/3/34/43/47/48/49 and contains type42 dispatch too. Text uses logic SendText; video accepts CaptureVideoInfo and attempts multiple AddVideo/AddShortVideo/generic factory/queue paths; emoji uses AddEmoticon; image/card/app use ResendMsg; other types queue a reset wrapper. Gesture repeats broadly mirror these routes with additional emoji object fallback and the same source-ID/media hazards. Existing attempts to enqueue a localID0 message and multi-send fallback chains are not native correctness evidence.

The refactor should preserve useful payload coverage—video CaptureVideoInfo, file attachments, record/note, reply/reference, miniapp/Finder/music/share metadata, image HD/CDN/live data—through supported native payload preparation and type-specific entries. Static evidence alone cannot prove live server acceptance or exact subtype equivalence. No live messaging or runtime media tests were performed. Runtime ABI validation, source immutability checks, fresh local-ID observation and representative subtype acceptance remain required before claiming device support.

## Focused addendum: app payload lookup and source voice completeness

The app-data path API is a **class method on CMessageWrap**, not a CMessageMgr instance method and not an object-returning getter: `+[CMessageWrap GetPathOfAppDataByUserName:andMessageWrap:retStrPath:]`, address `0x104b79258`, encoding `v40@0:8@16@24^@32`. Its arguments are source chat, source wrapper, and an `NSString *__autoreleasing *` output. It reads source attachment ID/file extension and delegates to the longer class path builder. Keep the source lookup identity until this out-path is resolved.

The native ForwardMsg app branch obtains source chat using `+[CMessageWrap getUserNameFromMsgWrap:]` (`0x101c476c0`). It resolves observers of the class path method through MMExtensionCenter, passes source chat/source wrap and `&path` (`0x101c476f0–0x101c4778c`), then tests `IsFileMsg` on the source (`0x101c4784c`). File messages use `AddAppMsg:...DataPath:path Scene:` (`0x101c4787c`); other app messages load `[NSData dataWithContentsOfFile:path]` and pass that object to `AddAppMsg:...Data:Scene:` (`0x101c4789c–0x101c478dc`). Another branch uses a previously resolved existing path with the same DataPath-versus-NSData split (`0x101c47500–0x101c4755c`, `0x101c47910–0x101c47954`). This does not establish a generic `m_dtApp` getter as the native payload source. Record/note handling precedes this split.

`-[CExtendInfoOfVoiceMsg IsDownloadEnded]` exists at `0x104b9a5d4`, encoding `B16@0:8`, but **only tests bit0 of its referenced wrapper's m_uiDownloadStatus**. It provides no independent byte-completeness guarantee. CMessageWrap's forwarding machinery can delegate selectors to type/from/biz extensions; the type extension getter is `m_extendInfoWithMsgType` (`@16@0:8`). Validate the actual extension object if probing extension capabilities.

The expected byte count is available through `+[DownloadVoiceCommon parseVoiceXml:]`, address `0x101174448`, encoding `@24@0:8@16`. The class reference at `0x12017c858` resolves its allocated result to **DownloadVoiceWrap**. Its XML path is `msg/voicemsg`, with attributes:

| Attribute | Result property | Evidence |
|---|---|---|
| `endflag` | `m_uiEndFlag` | `0x10117451c–0x101174560` |
| **`length`** | **`m_uiVoiceLen`**, expected audio bytes | `0x101174564–0x1011745a8` |
| `voicelength` | `m_uiVoiceTime`, milliseconds | `0x1011745ac–0x1011745f0` |
| `cancelflag` | `m_uiCancelFlag` | `0x1011745f4–0x101174638` |

`DownloadVoiceWrap -m_uiVoiceLen` is `I16@0:8` at `0x102055b3c`; `-m_uiVoiceTime` is `I16@0:8` at `0x102055b4c`; `-m_uiEndFlag` is `I16@0:8` at `0x102055b5c`. Both CGI and CDN native sync-download paths call this class parser and read the length, duration, and end flag (`CDownloadVoiceMgr 0x1011751fc, 0x101175258–0x101175298`; `DownloadVoiceCDNMgr 0x10117234c, 0x1011723ac–0x1011723ec`). This distinguishes total bytes from duration without guessing codec or enum values.

For a source with usable XML, independently available audio bytes must be checked against a positive declared `length`, together with valid duration/format and cancellation/end metadata. A missing/zero length is unavailable evidence; it must not be interpreted as complete merely because the file is nonempty. Already downloaded local-source paths without such a declared length require a separately verified completed-source contract or a matched terminal native callback followed by revalidation. The studied IsDownloadEnded method alone does not supply that stronger contract. No live-media acceptance was tested.

## Focused addendum: account lifecycle epoch

MMContextManager exposes these verified instance methods on the studied binary:

| Selector | Address | Encoding |
|---|---|---|
| `loginByContext:` | `0x1175dff4c` | `v24@0:8@16` |
| `logout:` | `0x1175e0228` | `v24@0:8@16` |
| `activeUserContext` | `0x1175e0330` | `@16@0:8` |
| `loginContextTimes` | `0x1175e14ac` | `I16@0:8` |
| `loginNonGuestContextTimes` | `0x1175e14b4` | `I16@0:8` |

`loginByContext:` marks the supplied context's m_userState as1 (`0x1175e00e0–e8`), invokes its service center's `userWillLogin`, writes manager m_activeContext at +0x18 (`0x1175e010c–110`), calls `setContext:atIndex:` with index1 (`0x1175e0124–13c`), then increments unsigned m_loginContextTimes at +0x20 (`0x1175e0140–148`). It conditionally increments m_loginNonGuestContextTimes (+0x24) when the supplied context's m_uin is nonzero (`0x1175e014c–168`). Therefore loginContextTimes changes on same-account relogin even if the username remains identical. The getter is a plain unsigned32 load; account generation comparison must preserve successful zero reads and account for unavailable capabilities separately.

`logout:` calls `removeAllServices`, locks manager m_lock, invokes `userDidLogout`, then sets the supplied context's m_userState to3 (`0x1175e0254–2a4`). Its bounded body **does not clear m_activeContext or increment either login counter**. Thus a snapshot of activeUserContext pointer plus loginContextTimes detects a later relogin but does not, by itself, detect the logged-out interval. Pending asynchronous message actions require immediate invalidation on the verified logout lifecycle or another independently verified active-login predicate. MMContext's inspected methods do not expose a user-state getter; do not invent one from the ivar name. Login/active-context access use the manager's recursive lock; no main-thread assertion or enforced main-thread dispatch was established in these bounded bodies. Serialize plugin lifecycle invalidation with its own send/callback ownership rather than claiming native main-thread ordering from this evidence.

## Reproduction

`PYTHONDONTWRITEBYTECODE=1 python3 docs/evidence/message-actions-native-2026-10-17/ordinary-disassemble.py` reuses the prior immutable inventory and read-only mmap helpers, extracts supplemental class-method metadata, and writes only `ordinary-methods.json` and `ordinary--*.asm`. It does not rerun the previous inventory extraction. `ordinary-voice-time-methods.json`, `ordinary-lookup-methods.json`, and `ordinary-voice-xml-methods.json` record supplemental discovery metadata. `ordinary-manifest.json` hashes only this follow-up's artifacts, leaving `manifest.json` unchanged.
