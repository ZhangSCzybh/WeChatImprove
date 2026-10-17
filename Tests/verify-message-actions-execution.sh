#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-message-actions-execution.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PYEXTRACT'
from pathlib import Path
import re, sys
root,out=map(Path,sys.argv[1:])
source=(root/'Hooks/VoiceForwardHooks.xm').read_text()
manager=source.split('%hook ForwardMessageMgr',1)[1].split('%end',1)[0]
methods=[]
for name in ('OnForwardMessageSend','OnForwardMessageCancel'):
    match=re.search(r'- \(void\)'+name+r':\(id\)logic \{.*?\n\}',manager,re.S)
    assert match, name
    methods.append(match.group().replace('CSMessageActionCoordinator.sharedCoordinator','forwardHookCoordinator').replace('%orig;', '[self.originalCalls addObject:@"'+name+'"]; [logic clearData];'))
logic=source.split('%hook ForwardMessageLogicController',1)[1].split('%end',1)[0]
clear=re.search(r'- \(void\)clearData \{.*?\n\}',logic,re.S).group().replace('CSMessageActionCoordinator.sharedCoordinator','forwardHookCoordinator').replace('%orig;', 'forwardNativeClearCalls++;')
(out/'VoiceForwardCleanupHooksUnderTest.h').write_text('static CSMessageActionCoordinator *forwardHookCoordinator;\nstatic NSUInteger forwardNativeClearCalls;\n@interface TestLogic (CleanupHook)\n- (void)clearData;\n@end\n@implementation TestLogic (CleanupHook)\n'+clear+'\n@end\n@interface TestForwardManager : NSObject\n@property(nonatomic, strong) NSMutableArray *originalCalls;\n@end\n@implementation TestForwardManager\n'+'\n'.join(methods)+'\n@end\n')
PYEXTRACT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSMessageActionPreferences.m" \
  "$project_dir/Controllers/CSMessageActionContext.m" \
  "$project_dir/Controllers/CSMessageActionPolicy.m" \
  "$project_dir/Controllers/CSMessageNativeActionAdapter.m" \
  "$project_dir/Controllers/CSMessageMediaProvider.m" \
  "$project_dir/Controllers/CSMessageSendAdapter.m" \
  "$project_dir/Controllers/CSVoiceForwardAdapter.m" \
  "$project_dir/Controllers/CSMessageActionMenuAdapter.m" \
  "$project_dir/Controllers/CSMessageActionCoordinator.m" \
  "$project_dir/Tests/MessageActionExecutionTests.m" -o "$test_dir/tests"
"$test_dir/tests"
