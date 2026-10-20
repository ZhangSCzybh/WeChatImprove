# Final implementation decisions

- Original checkout and codex/close-friends preserved; no installation, account/database operations, service switch, clean, push or merge.
- Native evidence is from WeChat 8.0.78 and is not device acceptance. Unknown signatures are not called. Runtime capability checks are interface checks only.
- Keep native message receipt/storage/unread, friendships, tag membership and publishing ACL. Use derived presentation and account/epoch/policy checks.
- Keep ordinary folded-group navigation; neutralize unknown mixed previews. Alert badge computation uses validated main-session source and can undercount ordinary contributions when unknown.
- Message/advanced search and forwarding message-search sections are gated until reveal. Ordinary group member-match snippets become neutral. Protected personal/detail/status routes require verification.
- Publishing visibility editing requires reveal and a new operation. Never replay stale ACL callback arguments; relock covers the active picker. Discovery Moments cues may be neutral even for ordinary activity.
- Main ilink without an exact matching subcall cache and some unified group broadcasts remain rejectionUnsupported. Native lifecycle callbacks continue. Process-terminated APNs, notification extensions, system CallKit first frames and unbound asynchronous output are not claimed protected.
- DND native writes require verified 8.0.78. Restoration ownership is process-bound with transaction tombstones; same-process owned transactions restore, external edits revoke ownership, and restart may leave automatic DND requiring manual change in WeChat.
- Task7 removes the unsupported “显示密友标记” settings row, retaining showBadges schema/default compatibility and silent unread policy. Picker save is now explicitly after dismissal with account/token revalidation, so save errors can be presented.
- All Important findings from Tasks1–6 were resolved and scoped reviews approved. Historical reports/ledger record the fix sequence; pending entries there are historical, not unresolved findings. One combined Task7 and whole-branch review follows this integration.
- Focused validation only: close-friend core suites once, directly affected entry/payment boundary, unchanged group mapping evidence reused. Packaging is the final integration compile; no redundant full isolated-object compile or historical suite rerun.

See [implementation history](implementation-progress.md), [task reports](task-reports/) and [reviews](reviews/). Final build evidence and actual limits are in [README.md](README.md).
