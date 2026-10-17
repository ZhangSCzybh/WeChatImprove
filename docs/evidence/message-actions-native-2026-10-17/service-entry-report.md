# Service entry contract: static regression investigation

Target: WeChat 8.0.78.34, arm64, `/tmp/wechat-8.0.78-inset-analysis/WeChat`; SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. Static-only. The installed device build and execution were not observed. No app processes, services, accounts, or data were changed.

## Finding and implication

The current `currentAccountID` implementation uses `CSMessageActionObjectGetter` for `getSelfContact` on the result of `serviceNamed:@"CContactMgr"`. That helper requires a concrete Method on the receiver's actual runtime class. Normal user service lookup returns an `MMServiceWrapper` proxy whose method list has no `getSelfContact`. This makes that account route return nil despite the real `CContactMgr` implementing the method. `CSMessageActionContext` line 90 rejects an empty account before creating any context, explaining a shared gate that can suppress both menu actions and gesture actions. This is a direct source/static-native contract mismatch, with installed-device attribution still requiring runtime verification.

The same mismatch also affects later native service calls: `CSNativeReceiver` admits concrete methods and one specific CMessageWrap forwarding route; it rejects service wrappers before `CSMessageNativeSupports`/`Invoke` reach the real service API. Fixing only account lookup leaves service execution unavailable.

## Native route and ABI evidence

- `MMContext -getService:` at `0x117609d44`, encoding `@24@0:8#16`: root-service classes route through the root service center. User services on root/placeholder context redirect to `activeUserContext`; ordinary context delegates to its service center. Class reference `0x1201b6490` resolves to `MMRootService`.
- `MMServiceCenter -getService:` at `0x11759df30`, same encoding: locks its service dictionary, gets/creates a wrapper, initializes service with context under its init lock, completes init hooks, returns wrapper. Creation at `0x11759e4e4..0x11759e518` uses classref `0x1201b6498` = `MMServiceWrapper` and `initWithServiceObj:`.
- Cached path `0x11759e360..0x11759e3b8` returns raw service only when the service center's context equals the root-context global AND service `returnAsRawService` is true. `CContactMgr` derives from `MMUserService`, which derives from `MMBaseService`, so its normal account-context lookup returns wrapper.
- `CContactMgr -getSelfContact` at `0x100fd9274`, encoding `@16@0:8`, constructs contact data from `getMainSetting` including `m_nsUsrName`. Selector and ABI exist on the service, not wrapper.
- `MMContext +currentContext` at `0x1175c4c64`, encoding `@16@0:8`: respects task/co-context/thread state and falls back to active user context in its fallback branch.
- `MMContext +currentUserName` at `0x1175e4294`, encoding `@16@0:8`: sends `currentContext`, then `userName`. Instance `-userName` at `0x1175e4054`, same encoding: root/placeholder delegates to active-user context, otherwise reads `m_userName`. This is an evidenced concrete account-name route that avoids service proxies.
- No `+[MMServiceCenter defaultCenter]` was found in this build's base class method metadata or category method scan; the repository header is historical and cannot establish its presence. Main route `MMContext currentContext` is present.

## Why proxy dispatch must be preserved

`MMServiceWrapper -forwardingTargetForSelector:` (`0x1175fbff8`) compares the fast current context with underlying service `m_context`: it returns the raw service only when they match, otherwise nil. `-methodSignatureForSelector:` (`0x1175fc03c`) asks the underlying service for its signature and caches it in `m_hookSet` protected by `os_unfair_lock_lock/unlock` (symbols at `0x118329ef0`/`0x118329f08`). `-forwardInvocation:` (`0x1175fc100`) loads the underlying service context, sends `MMContext push:`, invokes the NSInvocation with raw target, then sends `MMContext pop:`. `-respondsToSelector:` forwards to the raw service. `-unsafeUnwrap` (`0x1175fc280`) is only an ivar load and return. `-strongContextObjectWithContext:` checks/logs context mismatch and returns the wrapper itself, not the raw service.

Safe implementation recommendation: register only service wrappers returned by the known `getService:` lookup with their requested service Class. Validate selector argument/return ABI against a concrete Method on that known class; keep the ORIGINAL wrapper as invocation target so the native forwarding and context push/pop remain active. Keep unknown proxies rejected. Do not globally trust arbitrary dynamic signatures, class spoofing, or `unsafeUnwrap`. `CSMessageActionObjectGetter` may stay concrete-only for view/model/context objects; service calls use the narrower service-specific contract.

## Adjacent voice uploader result

`AudioSender -uploaderForMsgWrap:` (`0x100176448`, retained existing `AudioSender--uploaderForMsgWrap_.asm`) checks BYP chat name; BYP returns `bypUploader`, ordinary returns `m_upload`. This function does not call `getService:`. `-bypUploader` (`0x10017a1e0`) is a direct ivar getter.

`-initFacade:` (`0x1001760e4`) constructs managers directly:

- If `IsVoiceUseCdnUpload` is true, `m_upload = UploadVoiceCDNMgr` via allocator call at `0x100176188`; `m_cgiUpload = MMNewUploadVoiceMgr` via `0x1001761ac`.
- Otherwise, `m_upload = MMNewUploadVoiceMgr` via `0x1001762a0`.
- In both paths, `_bypUploader = UploadVoiceCDNMgr` via `0x100176368`, then `setBypUploader:`.
- These calls resolve `0x107c27158 -> 0x10f85b460 -> 0x117475d8c -> 0x118329b90`, whose indirect symbol is `_objc_alloc_init`.

Therefore this build returns a concrete `UploadVoiceCDNMgr` or `MMNewUploadVoiceMgr` uploader, rather than an MMServiceWrapper. It needs no extra binding inherited from AudioSender service registration. Class dump `m_upload` declaration is broad (`BaseUploadVoiceMgr`), but actual constructor branches establish concrete classes. Do not replace selected uploader with AudioSender's destructive resend API.

## Scope and reproducibility

Only `service-entry-*` files were added. Existing extractor scripts were read, not imported, so their top-level writes were not executed. The new extraction copied only read-only Mach-O parsing and bounded llvm-objdump commands to a temporary script, and then saved it under the scoped prefix. Its selected methods and ivars are in `service-entry-methods.json` and `service-entry-ivars.json`; additional base/category scans are in `service-entry-related-methods.json` and `service-entry-category-methods.json`. The category scan is bounded to the target binary; external runtime-added categories remain unknown. Disassembly uses Objective-C IMP metadata and next-known-IMP bounds; helper/category functions can extend beyond their own return when the next IMP boundary is farther away. Statements above use explicit address ranges and visible return points.
