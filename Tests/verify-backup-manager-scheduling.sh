#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
# Run production manager methods against a fake clock/engine, without UIKit or live defaults.
python3 - "$work" <<'PY'
from pathlib import Path
import sys
source = Path('Controllers/CSBackupManager.m').read_text()
selectors = (
    '- (void)create:', '- (void)cancelPending:', '- (BOOL)isAutoBackupEnabled',
    '- (void)enableAutoBackup:', '- (void)foreground:', '- (void)background:',
    '- (void)resumeScheduledWork', '- (void)noteChange:', '- (void)changed:',
    '- (void)resourceChanged:', '- (void)reconcileChangesAt:',
    '- (void)processScheduledWork', '- (void)tick', '- (BOOL)attemptUpgradeBackup:',
)
methods = []
for selector in selectors:
    start = source.index(selector)
    opening = source.index('{', start)
    depth, end = 1, opening + 1
    while depth:
        if source[end] == '{': depth += 1
        elif source[end] == '}': depth -= 1
        end += 1
    methods.append(source[start:end])
Path(sys.argv[1], 'BackupSchedulingUnderTest.h').write_text(
    '\n'.join(methods).replace('NSUserDefaults.standardUserDefaults', 'self.testDefaults'))
assert 'CSBackupWhenReady(^{[weakSelf resumeScheduledWork];});' in source, 'ready callback must explicitly reschedule'
assert 'dispatch_source_set_event_handler(_timer,^{[weakSelf processScheduledWork];})' in source
timer_method = source[source.index('- (void)armTimerForDeadline:'):source.index('- (void)reconcileChangesAt:')]
assert 'dispatch_source_set_timer(self.timer,when,DISPATCH_TIME_FOREVER,' in timer_method, 'timer must be one-shot'
assert '10*NSEC_PER_SEC' not in source, 'idle repeating timer must not return'
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -IControllers -I"$work" -framework Foundation Controllers/CSBackupScheduler.m \
    Controllers/CSBackupMutation.m Tests/BackupManagerSchedulingTests.m -o "$work/tests"
"$work/tests"
