# 1.8-3 release result

Completed first-batch simplification and missing sticker/game repeat menus on `codex/message-actions-refactor-1.7-17`.

- Source commit: `f0b97a3e20e00cdcb080452992e916af721fcc6b`.
- Source baseline: `2c343db2f21ec04267d7390c578871ff6b080e9b`.
- Delivery checkout: `/Users/zhangshichao/.codex/worktrees/message-actions-refactor/WeChatImprove`.
- Package: `packages/com.wechat.improve_1.8-3_iphoneos-arm64.deb` (760,268 bytes).
- Package SHA-256: `f7146f8ea13e42825c81395a4f0dc323b28a47dae1ec962a4df23ea19410b58b`.
- Debian metadata: `1.8-3` / `iphoneos-arm64`; actual dylib slices: `arm64`, `arm64e`.
- Fresh build directory: `/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-message-actions-1.8-3.jpvt0edf`.
- Build exited 0, using SDK `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS27.1.sdk` and minimum iOS 15.0.

Changes: ordinary native actions no longer allocate generic send operations; deletion/revoke retain cancellable UI-lived confirmation state; ordinary forwards avoid enhanced-voice bindings; menus return the original array when unchanged and skip irrelevant account/page queries. Sticker cells now use their validated native page getter with responder fallback. The independent dice/rock-paper-scissors menu builder is hooked explicitly. Native send/media behavior and existing optional game assistance are preserved.

Validation: four isolated baseline behavior failures reproduced before final success. Five final host suites passed 58,370 checks, including 522 execution/native/media checks. No host test sends native messages. The artifact verifier found 16 required classes, 12 exports and 45 required Hook pairs in each packaged slice, including 10 menu builders. All 20 native-evidence entries matched their manifest. The build produced 26 warning occurrences in unrelated unchanged source/linker flags; details are retained in `build-warnings.json` and the full build log.

Preservation: all 7 earlier packages and 777 tracked `.theos` files matched their pre-build hashes. Main checkout Git HEAD/status fingerprints were unchanged before/after this build. Work was performed only in the established branch worktree; no shared service, database, account, main-checkout source, or phone installation was switched. No push or merge occurred.

Limits: phone installation, actual native-menu visibility, recipient delivery/animation/game result and measured performance remain unverified. Static WeChat 8.0.78.34 evidence and host doubles support the implementation and package; they do not establish the exact running phone build or replace device acceptance. See `docs/message-actions-1.8-3.md` for the targeted acceptance workflow.
