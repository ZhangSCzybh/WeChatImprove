# Finding Verdicts

- **Failed durable revocation reviving restoration authority — ADDRESSED.** `Controllers/CSCloseFriendMuteAdapter.m:32` records an account/name/transaction tombstone before attempting the fallible journal save. `Controllers/CSCloseFriendMuteAdapter.m:20` requires both the current process session and absence of that tombstone before granting restoration authority; reconciliation checks authority again immediately before restoration. Thus adapter recreation, runtime recovery and epoch changes cannot revive the revoked transaction. `Controllers/CSCloseFriendMuteAdapter.m:8` gives a later process a fresh session, and reconciliation revokes prior-session records rather than converting them into newly owned transactions. This implements the controller's revised contract, including its accepted manual-DND-restoration tradeoff after restart.

# New Breakage in the Fix Diff

- None found. Fresh transactions receive independent session/transaction identifiers, the normal same-process restoration path remains available, and external native setter forwarding is unchanged.

# Out-of-Scope Observations

- None. Task 7's required UI/docs disclosure of the accepted restart limitation remains a controller-owned delivery item (`docs/audits/close-friends-1.8-42/implementation-progress.md`).

# Checks and Limits

- Read the fix diff once and checked the appended report's named RED/GREEN evidence: the failed-revocation/reload/disable fixture fails before the fix and the resulting alert run reports 59 checks passed. The report also supplies successful changed-adapter arm64/arm64e compilation. No suites or compilation were repeated.
- Focused outside-diff compatibility check: new journal fields must survive production persistence. `Controllers/CSCloseFriendStore.m:26` validates mute records as property-list dictionaries and round-trips them without stripping these string fields, so the fixture's preserved session/transaction identifiers match that storage contract.
- Review scope was the original finding and new fix behavior only. No git operations, production edits, device/account changes, native research or subagents; wrote only this review report.

# Verdict

**Fix round: All findings addressed, no new Critical/Important breakage.**

**Spec compliance: Approved against the revised controller contract. Task quality: Approved.** Process-bound restoration is an explicit accepted behavior change, not a claim of restoration ownership surviving process restart.
