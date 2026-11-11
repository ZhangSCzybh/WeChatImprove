#!/bin/bash
# 2.4-4 release audit only; not used by the default regression suite.
set -euo pipefail
cd "$(dirname "$0")/../../.."
audit_tmp="$(mktemp -d "${TMPDIR:-/tmp}/wechat-244-settings.XXXXXX")"
trap 'rm -rf "$audit_tmp"' EXIT
cat > "$audit_tmp/settings.m" <<'OBJC'
#define main GroupChatExistingBackupMain
#include "GroupChatBackupTests.m"
#undef main
#import "CSGroupChatTemplate.h"
int main(int argc,char **argv){@autoreleasepool{
    if(argc!=2)return 2;
    NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    NSString *suite=[@"group.backup.244." stringByAppendingString:NSUUID.UUID.UUIDString];
    CSBackupEngine *engine=Engine(root,suite);
    NSURL *url=CSGroupChatFileURL(engine.resourceRoot,@"alice");
    NSMutableDictionary *legacy=[CSGroupChatDefaultConfiguration() mutableCopy];
    Check(![legacy[@"departureSendToRoom"] boolValue],@"new opt-in defaults off");
    Check([legacy[@"departureRoomTemplate"] isEqual:CSGroupChatDefaultRoomDeparture()],@"default room template stored independently");
    [legacy removeObjectsForKeys:@[@"departureSendToRoom",@"departureRoomTemplate"]];
    legacy[@"departureTemplate"]=@"原本的本地通知：@昵称";
    NSDictionary *oldState=@{@"schema":@1,@"account":@"alice",@"configuration":[legacy copy]};
    NSError *error=nil;
    Check(CSGroupChatWriteState(oldState,url,@"alice",&error),error.description?:@"save legacy input");
    Check([CSGroupChatReadState(url,@"alice",&error) isEqual:oldState],@"legacy shape remains readable and exact");
    NSDictionary *legacySnapshot=[engine save:@"legacy" error:&error];Check(legacySnapshot!=nil,error.description?:@"capture legacy");
    NSMutableDictionary *modern=[legacy mutableCopy];
    modern[@"departureSendToRoom"]=@YES;modern[@"departureRoomTemplate"]=@"@昵称：@离群类型\n备注 @备注 🐦 &<>";
    NSDictionary *newState=@{@"schema":@1,@"account":@"alice",@"configuration":[modern copy]};
    Check(CSGroupChatWriteState(newState,url,@"alice",&error),error.description?:@"save enabled multiline template");
    Check([CSGroupChatReadState(url,@"alice",&error) isEqual:newState],@"new switches and multiline template roundtrip without touching original notice text");
    NSDictionary *newSnapshot=[engine save:@"new" error:&error];Check(newSnapshot!=nil,error.description?:@"capture enabled config");
    Check([Field(newSnapshot)[@"value"] isEqual:newState],@"backup retains both independent templates and opt-in");
    NSMutableDictionary *invalid=[modern mutableCopy];invalid[@"departureSendToRoom"]=@"yes";
    Check(!CSGroupChatValidateConfiguration(invalid),@"invalid switch value rejected");
    invalid=[modern mutableCopy];invalid[@"departureRoomTemplate"]=@" \n";
    Check(!CSGroupChatValidateConfiguration(invalid),@"blank room text rejected");
    invalid=[modern mutableCopy];[invalid removeObjectForKey:@"departureTemplate"];
    Check(!CSGroupChatValidateConfiguration(invalid),@"old required fields cannot be omitted");
    NSSet *modules=[NSSet setWithObject:@"group_chat_tools"],*accounts=[NSSet setWithObject:@"alice"];
    NSDictionary *preview=[engine preview:legacySnapshot modules:modules accounts:accounts error:&error];
    Check([preview[@"fields"][0][@"value"] isEqual:oldState],@"legacy preview retains its original configuration shape");
    Check([engine prepare:preview error:&error],error.description?:@"prepare legacy restore");Complete(engine);
    Check([CSGroupChatReadState(url,@"alice",&error) isEqual:oldState],@"legacy backup restores with room sending absent");
    preview=[engine preview:newSnapshot modules:modules accounts:accounts error:&error];
    Check([preview[@"fields"][0][@"value"] isEqual:newState],@"new preview retains enabled switch and multiline template");
    Check([engine prepare:preview error:&error],error.description?:@"prepare current restore");Complete(engine);
    Check([CSGroupChatReadState(url,@"alice",&error) isEqual:newState],@"modern backup restores independent fields");
    NSString *rendered=CSGroupChatRenderTemplate(modern[@"departureRoomTemplate"],@{@"@昵称":@"小&<🐦>",@"@离群类型":@"被移出",@"@备注":@"@时间",@"@时间":@"12:00"});
    Check([rendered isEqual:@"小&<🐦>：被移出\n备注 @时间 🐦 &<>"],@"preview values replace once, preserving special characters");
    [[[NSUserDefaults alloc] initWithSuiteName:suite] removePersistentDomainForName:suite];
    printf("2.4-4 settings compatibility: %u checks passed\n",checks);
    return 0;
}}
OBJC
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers -ITests \
 -framework Foundation -framework CoreFoundation -framework ImageIO -framework CoreGraphics \
 Controllers/CSScheduledTaskStore.m Controllers/CSAIReplyStore.m Controllers/CSGroupChatStore.m Controllers/CSGroupChatTemplate.m \
 Controllers/CSBackupRegistry.m Controllers/CSBackupCodec.m Controllers/CSBackupAssets.m Controllers/CSPluginStorage.m \
 Controllers/CSBackupStore.m Controllers/CSManagedImageFile.m Controllers/CSBackupEngine.m Controllers/CSBackupMutation.m \
 "$audit_tmp/settings.m" -o "$audit_tmp/settings"
"$audit_tmp/settings" "$audit_tmp/fixture"
