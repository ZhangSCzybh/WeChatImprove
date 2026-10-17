# WeChat 8.0.78.34 message action native contracts

Static investigation, 2026-10-17. Scope: local artifact only; no WeChat launch, message send, account/database access, deployment, or production edits. Source baseline supplied by parent: `2aa7bcb8`, plugin `1.7-17`. Worktree: `codex/message-actions-refactor-1.7-17`.

## Identity, evidence and limits

REA `open_binary` returned `/private/tmp/wechat-8.0.78-inset-analysis/WeChat`, Mach-O arm64, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. This matches previous local evidence for the extracted third-party WeChat 8.0.78 / build 8.0.78.34 IPA. The binary encryption command reports cryptid 0. Device-installed image identity is unverified.

`methods.json` contains actual Objective-C selector/type/implementation-address metadata. `ivars.json` binds relevant object fields. The `.asm` files contain bounded Xcode LLVM disassembly, with selector-reference annotations decoded from this artifact. `extract.py` and `disassemble.py` reproduce these files without modifying the binary. Run with `PYTHONDONTWRITEBYTECODE=1` to avoid cache artifacts. The input path in the extraction script is explicit.

Assembly headings such as `Flutter_Image_provideRelativePathByUrl` are nearest exported symbols and are **not** the Objective-C method identity. Use the metadata address and instruction addresses. Ranges can include anonymous block helpers before the next selected method; conclusions below cite actual instruction sites. Selector annotations alone do not establish control flow; the indicated register arguments and branches were inspected. Unreadable class-pointer bytes in a few comments are not semantic evidence.

REA pseudocode was requested once, but did not return within the investigation's useful interval. No conclusion depends on Ghidra output. No retained REA Evidence ID was returned by `open_binary`; its complete identity result is in `manifest.json`.

## Implementation decisions supported by the binary

1. Keep one native picker/confirmation lifecycle. For a bound voice operation, intercept **per-target** `ForwardMessageLogicController -ForwardMsg:ToContact:` before its original implementation. Preserve original forwarding for other messages and for operations that are not explicitly bound. Do not use the manager's `OnForwardMessageSend:` as a second sending opportunity.
2. Construct a fresh type-34 wrap per target. Prepare full media and preflight the actual native uploader before inserting anything. Insert exactly once with `CMessageMgr -AddLocalMsg:MsgWrap:`, then call the selected uploader's `-ResendVoiceMsg:MsgWrap:` exactly once. Never call `AudioSender -ResendVoiceMsg:MsgWrap:` as a generic upload fallback.
3. Treat void send methods as submission attempts. They provide no BOOL acceptance result. A local ID proves local insertion only. Once insertion or uploader invocation has happened, an exception/uncertain result must not trigger another insertion, another uploader, or `%orig` as a fallback.
4. Use the live cell's native revoke capability; `BaseMsgContentViewController -isMsgCanRevoke:` alone does not check individual-message time/ownership. `revokeMsgByNodeView:` accepts the wrap in this version despite its name.

## Picker, confirmation, source and target lifetime

`BaseMessageCellView -onForward:` (`0x1002a5e98`, `v24@0:8@16`) calls the menu extension first and then `doForward`. `-doForward` (`0x1002ad10c`, `v16@0:8`) reads `viewModel.messageWrap`, gets the view controller through its delegate, and calls the forwarding service's `forwardMessage:fromViewController:forwardType:` with forwardType **4** (`0x1002ad1fc`–`0x1002ad210`). This is evidence for the menu's native entry, not a reason to overwrite other callers' forward types.

`ForwardMessageMgr -forwardMessage:fromViewController:toContact:forwardType:` (`0x101c3d8ec`, `v48@0:8@16@24@32q40`) obtains its current logic, sets `fromContactUserName` from the source's `GetChatName`, sets its forward type, and invokes `forwardMessage:` for a picker or `forwardMsgList:toContacts:` when a target is supplied. Do not infer a selected recipient merely because this entry method was called: its target may be nil and selection/confirmation has not completed.

`ForwardMessageLogicController -OnSelectSessions:SessionSelectController:` (`0x101c33c00`, `v32@0:8@16@24`) passes selected sessions to `showConfirmView:` (`0x101c33d90`) and separately notifies `OnForwardMessageSelectSession:`. Selection is therefore not send authorization.

Actual confirmation handler in this artifact is `-OnSharePreConfirmSheetViewSend:` (`0x101c2fa10`, `v24@0:8@16`). The old header's `OnSharePreConfirmViewSend:` implementation is absent from this class's method list. This method notifies `OnForwardMessageDidTapSend:`, handles waiting/failure branches, reads `getInputText`, enumerates `m_toContacts`, and invokes `ForwardMsgList:ToContact:WithRevokeBatchId:` with the logic's `m_msgList` and the current contact (`0x101c30230` caches the selector; `0x101c303ac`–`0x101c303cc` supplies the arguments). The list method dispatches individual `ForwardMsg:ToContact:` calls. The confirmation method separately constructs/sends the user's text comment; retain that native method to preserve the comment behavior.

After this dispatch phase, a completion block notifies `OnForwardMessageBeforeDismiss:`, calls `dismissViewController`, and then notifies `OnForwardMessageSend:` (`0x101c315bc`–`0x101c31680`). The callback argument is the **same logic controller**, loaded from the block capture, not an array of contacts or a sent message. Another `-onForwardMessageSend` helper (`0x101c3b1a0`, `v16@0:8`) schedules a block; that block dismisses and then calls `OnForwardMessageSend:` with `self` (`0x101c3b260`–`0x101c3b2d4`). It is not a delivery acknowledgement.

`ForwardMessageMgr -OnForwardMessageSend:` (`0x101c3dae0`, `v24@0:8@16`) immediately calls **arg1** `getMessages` and `getToContacts` (`0x101c3db30`–`0x101c3db64`) for reporting/lifecycle work. Those getters (`0x101c2d230` and `0x101c2d220`, both `@16@0:8`) return the logic's message list and recipient list. `ivars.json` binds `m_toContacts` at offset-address `0x1201f4900`, and the delegate at `0x1201f4924`. Snapshot/copy targets and retain the exact operation source before native cleanup if needed; avoid scanning all manager logics or a global pending source.

Cancellation differs by stage: picker cancellation notifies `OnForwardMessageCancel:` and then calls `clearData` (`0x101c35ad4`, `0x101c35b28`); confirmation cancellation notifies **`OnForwardMessageConfirmCanceled:`** (`0x101c325cc`). Do not treat confirmation cancellation as a send, and do not discard the picker binding if the native flow returns to selection. Bind context to this exact logic/session and source identity; scope the per-target hook to it, and detach when the native session actually ends.

## Native voice refusal and unsafe factory

`ForwardMessageLogicController -ForwardMsg:ToContact:` (`0x101c377c0`, `v32@0:8@16@24`) calls `checkMessageWrap:toContact:`, then ordinary contacts go through `ForwardMsgUtil +ForwardMsg:ToContact:Scene:forwardType:uiIDKeyScene:editImageAttr:roomTodoFlag:inputText:searchScene:` (`0x101c451f4`, `v68@0:8@16@24I32I36I40@44B52@56I64`). Note the final searchScene is **32-bit unsigned**, unlike the stale header's omission of this overload.

In that utility's message-type switch, type 34 (`0x22`, `0x101c45efc`) enters a branch that logs the exact CFString **`VoiceMsg Cannot Be Forward`** (CFString `0x11e580308`), then jumps to the exit at `0x101c4765c`. It performs no voice send in that branch. Native per-target entry interception can therefore supply voice support without allowing a second native send. Earlier utility preconditions/special contact branches still exist; this is evidence for the inspected ordinary forwarding branch, not all enterprise/bypass scenarios.

`ForwardMsgUtil +GenForwardMsgFromMsgWrap:ToContact:` (`0x101c49210`, `@32@0:8@16@24`) is particularly unsafe for voice: type34 retains the original wrap as its result (`0x101c49288`–`0x101c49298`), then the common path writes its recipient (`0x101c49444`), revoke batch ID and common tail. Do not use this factory to clone voice. For ordinary text/image/app/emoji/video, type-specific conversion branches exist, but equivalence with repeat semantics, downloads and all supported subtype fallbacks was **not** fully verified here. Do not generalize this investigation into a universal repeat replacement.

## Fresh voice insertion and upload ownership

Relevant exact interfaces:

| Receiver / selector | Encoding and interpretation | Implementation |
|---|---|---|
| `AudioSender uploaderForMsgWrap:` | `@24@0:8@16` — object result, wrap argument | `0x100176448` |
| `CMessageMgr AddLocalMsg:MsgWrap:` | `v32@0:8@16@24` — void, chat name, fresh wrap | `0x104b384f4` |
| `CMessageMgr AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:` | `v44@0:8@16@24B32B36B40` | `0x104b3850c` |
| `CMessageMgr SaveMesVoice:MsgWrap:` | `B32@0:8@16@24` — BOOL, chat, wrap | `0x104b2ab74` |
| `AudioSender ResendVoiceMsg:MsgWrap:` | `v32@0:8@16@24` — **void**, chat, old outgoing wrap | `0x10017972c` |
| `MMNewUploadVoiceMgr ResendVoiceMsg:MsgWrap:` | `v32@0:8@16@24` — void, chat, inserted wrap | `0x10453be60` |
| `UploadVoiceCDNMgr ResendVoiceMsg:MsgWrap:` | `v32@0:8@16@24` — void, chat, inserted wrap | `0x105f63024` |

The plain AddLocalMsg wrapper sets fixTime=YES, NewMsgArriveNotify=NO, Unique=NO. Its core calls native storage `AddMsg:MsgWrap:withTimeFixed:`, reads the resulting local ID, and for type34 calls native `SaveMesVoice:MsgWrap:` (`0x104b38784`–`0x104b387d4`). It then dispatches native message/session notifications. This preserves native database and media ownership; no manual message database insertion is needed. Its public return is still void and the internal media-save BOOL is not propagated as an acceptance token.

`uploaderForMsgWrap:` only gets the wrap's `GetChatName`, tests `IsBypMsgUserName:`, and returns `bypUploader` or its established `m_upload`. It **does not read the local ID**, so selecting and validating the uploader can happen on a fresh wrap before insertion. Preflight the current account, target, complete media bytes, supported format/duration, native services, uploader, and exact runtime ABI; retain that uploader for submission. The picker/UI flow must remain on its native UI execution context. This static pass does not prove arbitrary background-thread calls are safe.

Construct the new wrap with current sender, intended target, fresh time/status, type34 and `m_dtVoice`, accurate `m_uiVoiceFormat` and `m_uiVoiceTime`; reset identity fields rather than copying historical local/server IDs. Set forward flags according to existing product behavior, not an invented network protocol. Use one new wrap per target. After insert, require a new nonzero local ID and retain that identity for correlation; then invoke the already selected uploader once with the **target chat name and inserted wrap**. There is no additional SendMessageMgr queue call in the inspected native AudioSender voice resend sequence.

Both concrete uploaders require nonempty `m_dtVoice`. The CGI implementation segments bytes into `AddNewPart:LocalID:n64SvrID:Offset:Len:VoiceTime:CreateTime:EndFlag:CancelFlag:VoiceFormat:ForwardFlag:msgSource:chatName:`; the CDN implementation rejects an existing ready-upload item keyed by chat/local ID, calculates missing duration where possible, then calls the same native queue interface. This native deduplication is not permission for plugin retries or reusing a local ID across recipients. The source byte format must match its voice-format metadata; a nonempty file alone is insufficient.

The **AudioSender** method has different ownership: it requires `isSenderFromMsgWrap:` on arg2, validates chat/from/to fields and old audio path, creates a **new** type34 wrap, copies sender/recipient/source, sets status=1 and downloadStatus=9, reads media, sets duration/format, calls `UpdateContent:nil`, inserts with AddLocalMsg, selects the uploader and invokes it, then conditionally **deletes original arg2** through `DelMsg:MsgWrap:` (`0x100179d74`–`0x100179d88`). It is an outgoing-message replacement/resend workflow. It must not receive the read-only user source or be a fallback after plugin insertion.

`SendMessageMgr -AddMsgToSendTable:MsgWrap:` (`0x105779e00`, `v32@0:8@16@24`) requires nonzero wrap local ID and nonempty chat/recipient, serializes a send record, deletes matching existing queue entries, appends and saves the queue. It does not construct a fresh chat wrap and offers no BOOL. It is not equivalent to voice uploader submission. The binary evidence does not justify cascading it with multiple uploaders after an uncertain result.

If insertion has happened but uploading is unavailable/throws, preserve the inserted record and report an unknown/failed submission tied to that local ID; no second backend and no automatic reinsert. Native eventual message state/callback correlation is required before claiming network success. This investigation does not establish a universal outgoing delivery acknowledgement callback.

## Voice download continuation

`VoiceMsgDownloader -downloadMsg:` (`0x1062924dc`, `v24@0:8@16`) accepts **one source CMessageWrap**, verifies type34, determines the chat from the current account/from/to, selects native CDN/CGI behavior (`canUseCdnDownload`, bypass checks), and passes chat/localID/serverID/time/XML/media into `OnSyncDownload:LocalID:n64SvrID:CreateTime:Xml:Voice:`. It returns void, not media readiness.

The native callback is `VoiceMsgDownloader -OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:` at `0x106292bf8`, encoding **`v68@0:8@16I24q28I36I40I44I48@52I60I64`**: chat object; uint32 localID; int64 serverID; uint32 createTime, voiceTime, offset, length; data object; uint32 endFlag, errNo. Do not cast all these arguments as objects.

`DownloadVoiceCDNMgr -handleDownloadCDNSuccess:` removes the ready item, persists its queue state, and calls this delegate selector with EndFlag=1 and **ErrNo=3** (`0x101173f20`–`0x101173f4c`). Therefore `errNo==0` is **not** the native success predicate for this API. CGI `CDownloadVoiceMgr -MessageReturn:Event:` writes received data through `WriteAudioFile:LocalID:Offset:Len:Data:` and invokes the same selector. It can deliver partial chunks; a callback by itself does not mean a full source file is ready.

VoiceMsgDownloader's callback treats ErrNo=3 as its success branch (`0x106292ea4`), updates native message/download status, re-fetches the stored message and issues native receiver notifications. A safe continuation hook calls original first, correlates account + source chat + localID (and serverID when available), then **revalidates complete native media** before fulfilling waiting operations. Keep a bounded timeout/failure path and share one download among operations for the same source; never send directly from uncorrelated callbacks or use a fixed delay as proof of completion. Broader meanings of error values and every retry branch remain unverified.

## Revoke capability and actual argument

`BaseMsgContentViewController -isMsgCanRevoke:` (`0x100311f44`, `B24@0:8@16`) delegates the same argument to its `m_delegate`. The base logic's implementation (`0x1002b9040`) ignores that argument and checks session contact restrictions (brand/plugin/official accounts). It does **not** establish message ownership or age.

`BaseMessageCellView -canShowRevokeMsgMenuItemForMessage:` (`0x1002a75c8`, `B24@0:8@16`) combines live `viewModel.isSender`, delegate `isMsgCanRevoke:(wrap)`, server current time, wrap creation time + `viewModel.revokeTimeLimitInSecond`, message status, server ID and overwrite ID. Sending-state exceptions also exist. The zero-argument `canShowRevokeMsgMenuItem` gets `viewModel.messageWrap` and calls this method. This is the useful native per-message predicate; retain a matching live cell/view model, and revalidate identity/capability after the confirmation boundary.

`BaseMsgContentViewController -revokeMsgByNodeView:` (`0x1003115a4`, `v24@0:8@16`) passes its argument unchanged to delegate `RevokeMsg:`. `BaseMsgContentLogicController -RevokeMsg:` (`0x1002b930c`, `v24@0:8@16`) immediately reads **m_uiMesLocalID and m_nsToUsr from that argument**, and performs native revoke/batch handling. The expected argument is the **CMessageWrap** in this artifact; replacing it with a visual node based solely on the method name would break it.

`BaseMessageCellView -onRevokeMsg:` opens native customized/batch revoke confirmation sheets from its view model; this can preserve native confirmation semantics if invoked through the correct bound cell. `canPerformAction:withSender:` inspects an existing menu action list and therefore can be stale before menu construction; use the explicit native capability instead. No hardcoded two-minute rule is supported.

## Remaining acceptance work

Static evidence answers selector ABI, primary ownership, normal send/confirmation ordering and per-message revoke checks. It does not prove execution on the user's installed image, all special-contact branches, attachment availability on a real account, successful remote delivery, background-thread safety, every non-voice repeat subtype, or cross-version behavior. Runtime signature guards and a version capability boundary remain necessary. Preserve existing ordinary-message routes until their individual behavior is tested; source and account context must remain stable across asynchronous media/picker callbacks.
