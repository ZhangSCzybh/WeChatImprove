#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 - "$work" <<'PY'
from pathlib import Path
import sys
out=Path(sys.argv[1])
def extract(source, signature):
    start=source.index(signature); opening=source.index('{',start); depth=1; pos=opening+1
    while depth:
        depth += (source[pos]=='{')-(source[pos]=='}');pos+=1
    return source[start:pos]
entry=Path('Hooks/CustomEntryHooks.xm').read_text()
functions=[extract(entry,s) for s in ('static CSEntryDisplayMode getEntryDisplayMode()', 'static NSString *getCustomEntryTitle()', 'static void loadEntrySettings()', 'static void CSRemoveHiddenPluginEntryFromHost(id host)')]
methods=[extract(entry,s) for s in ('- (void)onCustomEntryClick {','- (void)openCustomViewController {','- (void)onCustomEntryClickInSetting:', '- (void)openCustomViewControllerFromSetting {')]
(out/'EntryUnderTest.h').write_text(('\n'.join(functions)+'\n@implementation TestEntry\n'+'\n'.join(methods)+'\n@end\n').replace('[NSUserDefaults standardUserDefaults]','testDefaults'))
manager=Path('Controllers/CSBackupManager.m').read_text()
methods=[extract(manager,s) for s in ('- (NSString *)lastRestoreFailure', '- (NSError *)restoreError:', '- (void)clearRestoreFailure', '- (void)performRestore:', '- (void)create:', '- (void)cancelPending:', '- (void)retryPendingWork:', '- (void)resolveStartup:')]
(out/'ManagerUnderTest.h').write_text('\n'.join(methods).replace('NSUserDefaults.standardUserDefaults','self.testDefaults'))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-function \
 -framework Foundation -I"$work" Tests/PluginEntryTests.m -o "$work/entry"
"$work/entry"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
 -framework Foundation -I"$work" -IHeaders -IControllers Tests/BackupStartupIntegrationTests.m -o "$work/startup"
"$work/startup"
