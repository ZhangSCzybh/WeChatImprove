- Normal publishing completion blocked after weak picker/logic release — ADDRESSED. Controllers/CSCloseFriendAudienceAdapter.m:10 separates editor/account/policy authorization from presentation-object lifetime; NeedsUnlock at line 103 uses that authorization, while live picker access still requires BindingCurrent. FinishEdit at line 106 preserves the native continuation for a current editor after ordinary picker disposal. Explicit revocation, changed epoch/revision and current concealment continue to deny stale operations.
- Focused regression evidence: Tests/CloseFriendSocialTests.m:203 releases both picker and logic, verifies their weak references are nil, executes the production FinishEdit guard, and verifies one native continuation plus unchanged ACL. The following account-change assertion still rejects the retired authorization. Existing revoked-picker checks remain in the fixture.

New breakage in the fix diff: None found.
Out-of-scope observations: None.
Fix round: All findings addressed, no new Critical/Important breakage.
Spec compliance: ✅ Approved within this scoped task review; UI/device acceptance remains pending.
Task quality: Approved.

Checks: Read supplied e459b2ba..3e757d92 fix package once and the appended fix-round report. Reported verify-close-friend-social.sh output includes completed-picker authorization; verify-close-friend-ios.sh --social reports arm64/arm64e compilation; diff check reports clean. No tests, git commands, native research, or production changes performed. Only this requested review report was written.
