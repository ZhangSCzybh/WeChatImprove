- Publishing picker retains revealed candidates after relock — ADDRESSED. Controllers/CSCloseFriendAudienceAdapter.m:26 tracks and revokes the actual picker on policy changes; lines 18 and 78 discard the presentation snapshot, shield the picker, and reject stale row reads. Epoch/revision-bound actions and retired-editor guards prevent revival after another reveal. Tests/CloseFriendSocialTests.m:193 exercises the tracked refresh callback and row reads without a new keys request.
- Interaction rendering trusts stale source coordinates — ADDRESSED. Controllers/CSCloseFriendInteractionAdapter.m:31 checks live bounds, object identity, and current concealment before invoking native rendering; stale trailing boundaries also return nil. Tests/CloseFriendSocialTests.m:180 verifies both native cell and height hooks reject the in-place protected replacement without invoking the original renderer.

New breakage in the fix diff
- Important: Controllers/CSCloseFriendAudienceAdapter.m:96 — Normal picker completion can leave the publishing editor unable to finish. The editor strongly retains AudiencePendingKey (line 38), but the binding's picker and logic are weak, and BindingCurrent requires both to remain alive (line 11). No successful completion callback clears or transitions the pending binding. After the user selects contacts normally and the dismissed picker/logic is released, NeedsUnlock returns YES even with unchanged account, policy and reveal authorization; onDone/onSaveAsNewTag and other editor operations silently stop. Separate a completed operation's authorization freshness from picker liveness, or transition/clear the pending binding on successful native completion while preserving the revoked-editor protection for stale callbacks. Add one focused normal-completion → picker release → onDone-allowed regression alongside the relock regression.

Out-of-scope observations: None.

Fix round: Original findings addressed, but new Important breakage remains (normal publishing completion after picker release).
Spec compliance: ❌ New publishing workflow regression remains.
Task quality: Needs fixes.

Checks: Read supplied ffaccc52..e459b2ba fix package and appended report; recovered the truncated middle in bounded chunks. The report names successful verify-close-friend-social.sh, verify-close-friend-ios.sh --social, and clean diff-check results. No tests, git commands, native research, or production changes performed. UI/device evidence remains explicitly pending.
