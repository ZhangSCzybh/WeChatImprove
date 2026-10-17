# Voice repeat / forwarding: constructor ABI mismatch

Date: 2026-10-18 (Asia/Shanghai). Read-only investigation of 1.8-3 at source commit `52e083916af0443fe8976d242d8d40239366643d`.

The user confirmed 1.8-3 was installed and WeChat restarted. Both self-sent and received voices can play normally; repeat and voice forwarding each report `1个目标未提交`. Ordinary text/image repeat works. These are user observations, not a runtime trace collected here.

Target: `/tmp/wechat-8.0.78-inset-analysis/WeChat`, arm64 WeChat 8.0.78.34, cryptid 0, SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. Existing REA-bound native evidence is reused; new metadata and LC_FUNCTION_STARTS-bounded disassembly were read directly from the same artifact. No device install/send, database/account access, runtime launch, or production edit was performed by this investigation.

## Confirmed blocker

`CMessageWrap -initWithMsgType:` has Objective-C encoding **`@24@0:8q16`**, at **`0x104b9c5ac`**. The argument is a signed 64-bit integer. This was independently re-extracted from the binary, not inferred from a repository header. The neighboring `-initWithMsgType:nsFromUsr:` also uses `q16`, encoding `@32@0:8q16@24` at `0x104b9c748`.

1.8-3 `CSMessageSendAdapter.m` declares the initializer with `unsigned int` and `CSFreshWrap` admits only `I` or `i` argument encodings. `CSMessageNativeSupports` correctly compares those concrete encodings with the native `q` and returns false. `CSFreshWrap(34)` therefore returns nil **before the initializer is called**, even with valid ready media.

Both repeat and enhanced forwarding enter this fresh voice route. `prepareChecked` returns nil; `submitTarget:operation:` records `FailedBeforeAcceptance`; `reportIfFinished:` renders the observed `1个目标未提交`. Ordinary text sends do not call this initializer, and image repeat uses its factory/copy path, matching the reported feature split.

The production-path test fixture used the same incorrect `unsigned int` constructor declaration. It proved behavior against a different ABI and systematically hid this blocker.

The disassembly captures x2 in x19 at `0x104b9c5c0` and passes that full argument to `setM_uiMessageType:` at `0x104b9c71c`. The method metadata, rather than the fact that a caller may materialize the small value 34 through w2, determines the Objective-C ABI contract.

## Minimal justified implementation and regression correction

Use the evidenced `q` constructor signature and a matching ARC-aware initializer call, such as declaring `- (instancetype)initWithMsgType:(long long)type`, checking the `q` signature, and calling `[[cls alloc] initWithMsgType:(long long)type]`. Keep the selected concrete uploader route and source/output separation. A generic `NSInvocation` helper has no declaration of the initializer's consumed-self/retained-result ownership; a typed init call keeps ARC's existing ownership convention explicit.

Change the default host `CMessageWrap` fixture to the actual `q` initializer. A baseline negative control with only that fixture correction should fail at fresh voice preparation; the production correction must restore successful preparation/submission. Exercise both repeat and enhanced voice forwarding through the real coordinator, with source IDs/content unchanged and one new wrapper per recipient. Reject a deliberately incompatible initializer ABI before any message insertion. This report does not claim those tests were executed; the parent implementation task owns them.

## Downstream contracts checked

| Entry | Address | Encoding | Finding |
| --- | --- | --- | --- |
| `AudioSender -uploaderForMsgWrap:` | `0x100176448` | `@24@0:8@16` | Chooses ordinary `m_upload` or BYP uploader; no service lookup in this method. |
| `CMessageMgr -AddLocalMsg:MsgWrap:` | `0x104b384f4` | `v32@0:8@16@24` | Valid production ABI; native assigns local identity and owns local persistence. |
| `MMNewUploadVoiceMgr -ResendVoiceMsg:MsgWrap:` | `0x10453be60` | `v32@0:8@16@24` | Valid concrete uploader ABI. |
| `UploadVoiceCDNMgr -ResendVoiceMsg:MsgWrap:` | `0x105f63024` | `v32@0:8@16@24` | Valid concrete uploader ABI. |
| `CMessageWrap -m_extendInfoWithMsgType` | `0x104bb41a4` | `@16@0:8` | Existing narrow payload-forwarding adapter is applicable. |
| `CMessageWrap -forwardingTargetForSelector:` | `0x104b9f110` | `@24@0:8:16` | Type extension is an evidenced native forwarding target. |

Existing `service-entry-report.md` and constructor disassembly establish the uploader instances are directly allocated `UploadVoiceCDNMgr`/`MMNewUploadVoiceMgr`, not unregistered service proxies. Do not bypass proxy account-context handling elsewhere and do not substitute the destructive `AudioSender.ResendVoiceMsg` entry.

`CMessageMgr.AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:` saves type-34 media at `0x104b387c8..0x104b38890` and then calls `ChangeForDisplay`. Its voice save does not erase `m_dtVoice`. More decisively, native `AudioSender.ResendVoiceMsg:MsgWrap:` itself calls `AddLocalMsg` at `0x100179d24`, selects the uploader at `0x100179d38`, and calls uploader `ResendVoiceMsg` at `0x100179d58`. The plugin's independent output uses the same insertion/upload ordering while avoiding that AudioSender method's source deletion behavior.

The native source path selector, native completion/recording status bits, byte headers, and codec calculator signatures remain consistent with the 1.8-2 evidence. No second constructor-like deterministic failure was found in these checked downstream APIs.

## SILK/OPUS duration boundary: real remaining uncertainty

The 20 ms declared-vs-decoded duration equality check in `CSValidatedVoice` is a plugin rule, not a native resend/upload contract. The checked native uploader accepts a positive supplied duration and computes it only when missing; it does not compare two time estimates.

- `AudioSender.silkAudioDuration` (`0x100177be0`, `I16@0:8`) checks the active recorder's format and calls its `audioDuration`.
- `SilkAudioRecorder.audioDuration` (`0x1059fb524`, `I16@0:8`) reads recording-state field `+0xc4`.
- `AudioSender.opusAudioDuration` (`0x100177c38`, same ABI) similarly dispatches to the recorder.
- `OpusAudioRecorder.audioDuration` (`0x1052afe70`, same ABI) reads recording-state field `+0x5e0`.
- Native recorder callback `AudioSender.OnRecorderPart:...Duration:` at `0x10017c66c` receives the unsigned Duration argument and, when present, writes that value to the outgoing voice metadata. Its fallback `AudioUtil.calcVoiceTime:VoiceFormat:` uses the above active-recorder duration for formats 4 and 7.
- `SilkAudioPlayer.calculateVoiceTime:` (`0x1059f7988`, `I24@0:8@16`) decodes frames and unconditionally adds 20 at `0x1059f7a80` before testing whether to iterate again. This includes its exit iteration. `OpusAudioPlayer.calculateVoiceTime:` (`0x1052ad4fc`, same ABI) measures decoded PCM and derives milliseconds.

These are different duration sources. This static pass does not prove a universal maximum difference, nor that the user's playable files exceed 20 ms. Do not replace 20 with another guessed tolerance and claim native equivalence. The existing source completion/cancellation checks, stable read, explicit expected byte length, and rejection of malformed bytes must remain. If diagnostics identify this gate, complete files with a known exact expected length can be distinguished from files lacking a declared length; codec-frame integrity and native terminal recording state are stronger completeness evidence than arbitrary timestamp equality.

The original host media tests use format 0 with constructed bytes and exact duration. Add separate format-4/7 dispatch cases to verify the real NSData calculator ABIs and format detection; label synthetic codec fixtures honestly. Actual native decoding and recipient playback still require device acceptance. A failure reason distinguishing media unavailable/validation from missing native send capability will make subsequent device results actionable instead of repeating a single undifferentiated `未提交`.

## Evidence files and boundary

`methods.json` is fresh selected Objective-C metadata. The `*.asm` files here use exact LC_FUNCTION_STARTS boundaries; their nearest symbol heading is not an Objective-C method identity. `extract.py` reproduces these selected reads without overwriting previous release evidence. `manifest.json` binds the target hash and current scoped files.

Reusable older evidence is under `../../message-actions-native-2026-10-17/` (`service-entry-report.md`, `ordinary-repeat-contracts.md`, `AudioSender--ResendVoiceMsg_MsgWrap_.asm`, concrete uploader/save/codec assembly) and `../../message-actions-1.8-2/` (`native-voice-report.md`, source-path/status/recorder assembly).

The `q` mismatch is a proven source/native-contract defect and necessarily blocks this route on the inspected artifact. Installed phone build identity and execution were not directly sampled, so this report does not claim device-send success after correction.
