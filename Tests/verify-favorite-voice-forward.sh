#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-favorite-voice-forward.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PYEXTRACT'
from pathlib import Path
import re, sys
root,out=map(Path,sys.argv[1:])
source=(root/'Hooks/VoiceForwardHooks.xm').read_text()
logic=source.split('%hook ForwardMessageLogicController',1)[1].split('%end',1)[0]
manager=source.split('%hook ForwardMessageMgr',1)[1].split('%end',1)[0]
replace={
    'forwardMessage':'self.nativeForwardCalls++; self.messages=@[source];',
    'ForwardMsgList':'[self nativeForwardMsgList:messages target:target batchID:batchID];',
    'ForwardMsg':'[self.fallbackCalls addObject:@[source,target]];',
    'clearData':'self.nativeClearCalls++; self.messages=nil; self.contacts=nil;',
    'bShowSendSuccessView':'YES',
    'bHiddenSendSuccessToastView':'NO',
}
methods=[]
for name,native in replace.items():
    match=re.search(r'- \((?:void|BOOL)\)'+name+r'(?=[: {]).*?\n\}',logic,re.S)
    assert match, name
    body=match.group().replace('CSFavoriteVoiceForwardAdapter.sharedAdapter','favoriteHookAdapter').replace('CSMessageActionCoordinator.sharedCoordinator','favoriteHookChatCoordinator')
    body=body.replace('%orig;' if name not in ('bShowSendSuccessView','bHiddenSendSuccessToastView') else '%orig',native)
    assert '%orig' not in body
    methods.append(body)
manager_methods=[]
for name in ('OnForwardMessageSend','OnForwardMessageCancel'):
    match=re.search(r'- \(void\)'+name+r':\(id\)logic \{.*?\n\}',manager,re.S)
    assert match, name
    body=match.group().replace('CSFavoriteVoiceForwardAdapter.sharedAdapter','favoriteHookAdapter').replace('CSMessageActionCoordinator.sharedCoordinator','favoriteHookChatCoordinator')
    body=body.replace('%orig;', '[self.nativeEvents addObject:@"'+name+'"]; [logic clearData];')
    manager_methods.append(body)
header='''static __weak CSFavoriteVoiceForwardAdapter *favoriteHookAdapter;
static CSMessageActionCoordinator *favoriteHookChatCoordinator;
@interface ForwardLogic (NativeHooks)
- (void)forwardMessage:(id)source;
- (void)ForwardMsgList:(id)messages ToContact:(id)target WithRevokeBatchId:(id)batchID;
- (void)ForwardMsg:(id)source ToContact:(id)target;
- (void)clearData;
- (BOOL)bShowSendSuccessView;
- (BOOL)bHiddenSendSuccessToastView;
@end
@implementation ForwardLogic (NativeHooks)
'''+ '\n'.join(methods)+'''
@end
@interface FavoriteForwardManager : NSObject
@property(nonatomic, strong) NSMutableArray *nativeEvents;
@end
@implementation FavoriteForwardManager
- (instancetype)init { if ((self=[super init])) _nativeEvents=[NSMutableArray array]; return self; }
'''+ '\n'.join(manager_methods)+'\n@end\n'
(out/'FavoriteVoiceHooksUnderTest.h').write_text(header)
favorite_source=(root/'Hooks/FavoriteVoiceForwardHooks.xm').read_text()
favorite_list=favorite_source.split('%hook MyFavoritesViewController',1)[1].split('%end',1)[0]
list_method=re.search(r'- \(void\)forwardData:\(id\)data \{.*?\n\}',favorite_list,re.S)
assert list_method
list_body=list_method.group().replace('CSFavoriteVoiceForwardAdapter.sharedAdapter','favoriteHookAdapter').replace('%orig;', '[self.nativeInputs addObject:data ?: NSNull.null];')
assert '%orig' not in list_body
with (out/'FavoriteVoiceHooksUnderTest.h').open('a') as file:
    file.write('''
@interface MyFavoritesViewController : FavoriteDetail
@property(nonatomic, strong) NSMutableArray *nativeInputs;
- (void)forwardData:(id)data;
@end
@implementation MyFavoritesViewController
- (instancetype)init { if ((self=[super init])) _nativeInputs=[NSMutableArray array]; return self; }
'''+list_body+'\n@end\n')
PYEXTRACT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$test_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSMessageActionPreferences.m" \
  "$project_dir/Controllers/CSMessageActionContext.m" \
  "$project_dir/Controllers/CSMessageActionPolicy.m" \
  "$project_dir/Controllers/CSMessageNativeActionAdapter.m" \
  "$project_dir/Controllers/CSMessageMediaProvider.m" \
  "$project_dir/Controllers/CSMessageImageStickerAdapter.m" \
  "$project_dir/Controllers/CSMessageSendAdapter.m" \
  "$project_dir/Controllers/CSVoiceForwardAdapter.m" \
  "$project_dir/Controllers/CSMessageActionCoordinator.m" \
  "$project_dir/Controllers/CSFavoriteVoiceContext.m" \
  "$project_dir/Controllers/CSFavoriteVoiceMediaProvider.m" \
  "$project_dir/Controllers/CSFavoriteVoiceForwardAdapter.m" \
  "$project_dir/Tests/FavoriteVoiceForwardTests.m" -o "$test_dir/tests"
"$test_dir/tests"
