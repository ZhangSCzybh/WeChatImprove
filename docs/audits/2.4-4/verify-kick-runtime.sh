#!/bin/bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../../.." && pwd)"
temp="$(mktemp -d "${TMPDIR:-/tmp}/wechat-244-kick.XXXXXX")"
trap 'rm -rf "$temp"' EXIT
python3 - "$root" "$temp" <<'PY'
from pathlib import Path
import sys
root, temp = map(Path, sys.argv[1:])
source = root / 'Controllers/CSGroupChatRuntime.m'
(temp / 'CSGroupChatRuntime-under-test.inc').write_text('\n'.join(line for line in source.read_text().splitlines() if not line.startswith('#import')))
PY
cat > "$temp/audit.m" <<'OBJC'
#define main ExistingRuntimeFixtureMain
#include "GroupChatRuntimeTests.m"
#undef main

@interface AuditMember : NSObject
@property(nonatomic,copy) NSString *userName,*nickName,*displayName;
@property(nonatomic,strong) RuntimeString *memberName;
@end
@implementation AuditMember
@end
@interface AuditRoomData : NSObject
@property(nonatomic,strong) RuntimeString *chatRoomUserName;
@property(nonatomic,copy) NSArray *chatRoomMember;
@end
@implementation AuditRoomData
@end
@interface AuditRequest : RuntimeRequest
@property(nonatomic,copy) NSString *chatRoomName;
@property(nonatomic) unsigned int memberCount;
@property(nonatomic,copy) NSArray *memberList;
@end
@implementation AuditRequest
@end
@interface AuditResponse : RuntimeResponse
- (AuditRoomData *)newChatroomData __attribute__((objc_method_family(none)));
@property(nonatomic,strong) AuditRoomData *newChatroomData;
@property(nonatomic) unsigned int memberCount;
@property(nonatomic,copy) NSArray *memberList;
@end
@implementation AuditResponse
@end

static RuntimeWrapper *nestedFullResponse;
static NSUInteger originalRemovalCalls;
@interface CGroupMgr (AuditRemoval)
- (void)OnDeleteChatRoomMemberResponse:(id)wrapper;
@end
@implementation CGroupMgr (AuditRemoval)
- (void)OnDeleteChatRoomMemberResponse:(id)wrapper {
    (void)wrapper;originalRemovalCalls++;
    [self onModifyContact:fixtureContact];
    if(nestedFullResponse)[self OnGetChatRoomMemberDetail:nestedFullResponse];
}
@end
static AuditMember *Member(NSString *idText,NSString *nickname,NSString *remark) {
    AuditMember *row=[AuditMember new];row.userName=idText;row.nickName=nickname;row.displayName=remark;
    row.memberName=[RuntimeString new];row.memberName.string=idText;return row;
}

int main(void){@autoreleasepool{
    TestPublish();unsigned existing=checks;CHECK(failures==0);
    unavailable=NO;CSGroupChatSetRuntimeEnabled(YES);CSGroupChatInstallRuntimeHooks();CHECK(hookRegistrations==5);
    CGroupMgr *groups=[CGroupMgr new];fixtureContactManager=[CContactMgr new];
    NSMutableArray *hints=[NSMutableArray array];
    SEL selector=@selector(nativeMemberRemovals:inRoom:epoch:);Class manager=CSGroupChatManager.class;
    Method method=class_getInstanceMethod(manager,selector);
    IMP recording=imp_implementationWithBlock(^(id self,NSArray *ids,NSString *room,NSUInteger epoch){
        (void)self;[hints addObject:@{@"members":ids,@"room":room,@"epoch":@(epoch),@"published":@(Published())}];
    });
    class_replaceMethod(manager,selector,recording,method_getTypeEncoding(method));

    NSString *room=@"90001@chatroom";
    AuditMember *one=Member(@"wxid_one",@"真昵称😺<&>",@"群备注 & 🐱"),*other=Member(@"wxid_other",nil,nil);
    nestedFullResponse=GoodResponse();
    AuditResponse *full=[AuditResponse new];full.chatroomUserName=room;full.baseResponse=[RuntimeBaseResponse new];
    full.allMemberCount=2;full.allMemberUserNameList=@[@"wxid_self",@"wxid_one"];full.serverVersion=10;
    full.newChatroomData=[AuditRoomData new];full.newChatroomData.chatRoomUserName=[RuntimeString new];
    full.newChatroomData.chatRoomUserName.string=room;full.newChatroomData.chatRoomMember=@[one,other];nestedFullResponse.m_pbResponse=full;
    AuditRequest *request=[AuditRequest new];request.chatRoomName=room;request.memberCount=1;request.memberList=@[one];
    AuditResponse *reply=[AuditResponse new];reply.baseResponse=[RuntimeBaseResponse new];reply.memberCount=2;reply.memberList=@[one,other];
    RuntimeWrapper *removal=[RuntimeWrapper new];removal.m_pbRequest=request;removal.m_pbResponse=reply;
    NSUInteger prior=Published(),contacts=CSGroupChatManager.sharedManager.contactChanges.count;
    [groups OnDeleteChatRoomMemberResponse:removal];CHECK(originalRemovalCalls==1);CHECK(hints.count==0);CHECK(MemberResponseDepth==0);
    Pump();CHECK(hints.count==1);CHECK(Published()==prior+1);CHECK(CSGroupChatManager.sharedManager.contactChanges.count==contacts);
    CHECK([hints.lastObject[@"published"] isEqual:@(prior)]);CHECK([hints.lastObject[@"members"] isEqual:@[@"wxid_one"]]);
    CHECK([hints.lastObject[@"room"] isEqual:room]);CHECK([hints.lastObject[@"epoch"] isEqual:@(fixtureEpoch)]);
    NSDictionary *snapshot=CSGroupChatManager.sharedManager.received.lastObject[@"snapshot"];
    CHECK([snapshot[@"names"][@"wxid_one"] isEqual:one.nickName]);CHECK([snapshot[@"remarks"][@"wxid_one"] isEqual:one.displayName]);
    CHECK(snapshot[@"names"][@"wxid_other"]==nil);CHECK(snapshot[@"remarks"][@"wxid_self"]==nil);
    CHECK(snapshot[@"profileFields"]==nil);
    full.newChatroomData.chatRoomUserName.string=@"wrong@chatroom";
    Publish(CaptureResponse(nestedFullResponse),fixtureEpoch,Token());
    snapshot=CSGroupChatManager.sharedManager.received.lastObject[@"snapshot"];
    CHECK([snapshot[@"names"][@"wxid_one"] isEqual:@"成员-wxid_one"]);CHECK(snapshot[@"remarks"][@"wxid_one"]==nil);

    nestedFullResponse=nil;reply.baseResponse.ret=-1;
    [groups OnDeleteChatRoomMemberResponse:removal];Pump();CHECK(originalRemovalCalls==2);CHECK(hints.count==1);
    reply.baseResponse.ret=0;reply.memberCount=3;
    [groups OnDeleteChatRoomMemberResponse:removal];Pump();CHECK(hints.count==2);CHECK([hints.lastObject[@"members"] count]==0);
    reply.memberCount=2;
    [groups OnDeleteChatRoomMemberResponse:removal];fixtureEpoch++;Pump();CHECK(hints.count==2);
    [groups OnDeleteChatRoomMemberResponse:removal];CSGroupChatSetRuntimeEnabled(NO);Pump();CHECK(hints.count==2);
    CHECK(originalRemovalCalls==5);
    printf("2.4-4 removal and profile runtime: %u checks, %u failures (offline fixtures only)\n",checks-existing,failures);
    return failures?1:0;
}}
OBJC
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation \
  -I"$temp" -I"$root/Controllers" -I"$root/Tests" \
  "$root/Controllers/CSMessageActionContext.m" "$root/Controllers/CSMessageNativeActionAdapter.m" \
  "$root/Controllers/CSGroupChatEventPolicy.m" "$temp/audit.m" -o "$temp/audit"
"$temp/audit"
