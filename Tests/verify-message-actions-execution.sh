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
ui=[]
for name,native in (('bShowSendSuccessView','YES'),('bHiddenSendSuccessToastView','NO')):
    ui.append(re.search(r'- \(BOOL\)'+name+r' \{.*?\n\}',logic,re.S).group().replace('CSMessageActionCoordinator.sharedCoordinator','forwardHookCoordinator').replace('%orig',native))
clear=re.search(r'- \(void\)clearData \{.*?\n\}',logic,re.S).group().replace('CSMessageActionCoordinator.sharedCoordinator','forwardHookCoordinator').replace('%orig;', 'forwardNativeClearCalls++;')
download=source.split('%hook VoiceMsgDownloader',1)[1].split('%end',1)[0]
body=download[download.index('{'):download.rindex('}')+1].replace('%orig;', 'voiceHookNativeCalls++;').replace('CSMessageActionCoordinator.sharedCoordinator','TestVoiceCoordinator()')
(out/'VoiceDownloadHookUnderTest.h').write_text('static NSUInteger voiceHookNativeCalls, voiceHookCoordinatorReads;\nstatic CSMessageActionCoordinator *voiceHookCoordinator;\nstatic CSMessageActionCoordinator *TestVoiceCoordinator(void) { voiceHookCoordinatorReads++; return voiceHookCoordinator; }\nstatic void TestNativeVoiceCallback(NSString *chat, unsigned int localID, long long serverID, unsigned int endFlag, unsigned int error) '+body+'\n')
menu=(root/'Hooks/RepeatHooks.xm').read_text()
classes=('CommonMessageCellView','TextMessageCellView','ImageMessageCellView','EmoticonMessageCellView','VideoMessageCellView','VoiceMessageCellView','AppEmoticonMessageCellView','AppFileMessageCellView','ShareCardMessageCellView','GameMessageCellView')
extracted=['static CSMessageActionMenuAdapter *menuHookAdapter;']
for cls in classes:
    match=re.search(r'%hook '+cls+r'\n(.*?)%end',menu,re.S)
    body=re.search(r'- \(id\)operationMenuItems \{.*?\}',match.group(1),re.S).group() if match else '- (id)operationMenuItems { return %orig; }'
    body=body.replace('CSMessageActionMenuAdapter itemsByAddingActionsForCell','menuHookAdapter itemsByAddingActionsForCell').replace('%orig','self.nativeItems')
    if cls in ('EmoticonMessageCellView','AppEmoticonMessageCellView'):
        body+='\n- (id)getViewController { return [self.nativeDelegate getViewController]; }'
    native='@property(nonatomic,weak) TestMessageCellDelegate *nativeDelegate;\n' if cls in ('EmoticonMessageCellView','AppEmoticonMessageCellView') else ''
    extracted.append('@interface '+cls+' : TestCell\n'+native+'@property(nonatomic,copy) NSArray *nativeItems;\n- (id)operationMenuItems;\n@end\n@implementation '+cls+'\n'+body+'\n@end')
(out/'RepeatMenuHooksUnderTest.h').write_text('\n'.join(extracted))
dedup=menu.split('%hook BaseMessageCellView',1)[1].split('%end',1)[0]
dedup=dedup.replace('[CSMessageActionMenuAdapter itemsBeforeNativeDedupForCell:self items:items]', '[menuHookAdapter itemsBeforeNativeDedupForCell:self items:items]')
dedup=dedup.replace('return %orig(prepared);', 'self.observedInput=prepared; return prepared;')
assert '%orig' not in dedup
(out/'MenuDedupHookUnderTest.h').write_text('''
@interface TestMenuDedupCell : TestCell
@property(nonatomic,strong) id observedInput;
- (id)uniqMenuItems:(id)items;
@end
@implementation TestMenuDedupCell
'''+dedup+'\n@end\n')
(out/'VoiceForwardCleanupHooksUnderTest.h').write_text('static CSMessageActionCoordinator *forwardHookCoordinator;\nstatic NSUInteger forwardNativeClearCalls;\n@interface TestLogic (CleanupHook)\n- (void)clearData;\n- (BOOL)bShowSendSuccessView;\n- (BOOL)bHiddenSendSuccessToastView;\n@end\n@implementation TestLogic (CleanupHook)\n'+clear+'\n'+'\n'.join(ui)+'\n@end\n@interface TestForwardManager : NSObject\n@property(nonatomic, strong) NSMutableArray *originalCalls;\n@end\n@implementation TestForwardManager\n'+'\n'.join(methods)+'\n@end\n')
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
