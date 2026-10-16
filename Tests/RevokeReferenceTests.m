#import <Foundation/Foundation.h>
#import "CSRevokeReference.h"
#include <stdlib.h>
static unsigned checks;
#define CHECK(x) do {checks++;if(!(x)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#x);exit(1);}}while(0)
int main(void) { @autoreleasepool {
    for (NSNumber *n in @[@1,@101,@9223372036854775807LL]) {
        CSRevokeReference *original=[CSRevokeReference referenceWithServerID:n.longLongValue localID:42];
        NSString *content=[NSString stringWithFormat:@"原消息<a href=\"%@\">&lt;内容&gt;</a>",original.link];
        NSData *saved=[NSPropertyListSerialization dataWithPropertyList:@{ @"content":content } format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
        NSDictionary *loaded=[NSPropertyListSerialization propertyListWithData:saved options:NSPropertyListImmutable format:nil error:nil];
        CSRevokeReference *restored=CSRevokeResolveReference(nil,loaded[@"content"],nil);
        CHECK(restored.serverID==original.serverID);CHECK(restored.localID==42);
        CHECK(CSRevokeResolveReference(original.link,content,nil).serverID==original.serverID);
        CHECK(CSRevokeResolveReference([NSURL URLWithString:original.link],nil,nil).serverID==original.serverID);
    }
    CHECK(CSRevokeResolveReference(@"revoke_jump_101",@"<a href='revoke_jump_101'>旧提示</a>",nil).serverID==101);
    CHECK(CSRevokeResolveReference(nil,nil,@"revoke_jump_101").serverID==101);
    CHECK(!CSRevokeResolveReference(@"https://example.com",@"<a href='revoke_jump_101'>旧提示</a>",nil));
    CHECK(!CSRevokeResolveReference(@"revoke_jump_101",nil,@"revoke_jump_102"));
    CHECK(!CSRevokeResolveReference(@"revoke_jump_v2_101_3",@"<a href='revoke_jump_v2_101_4'>x</a>",nil));
    for (NSString *bad in @[@"revoke_jump_",@"revoke_jump_-1",@"revoke_jump_0",@"revoke_jump_1x",@"revoke_jump_9223372036854775808",@"revoke_jump_v2_1_4294967296",@"revoke_jump_v2_1_x",@"revoke_jump_v2_1_0_more"])
        CHECK(!CSRevokeResolveReference(bad,nil,nil));
    for (NSString *session in @[@"peer",@"room@chatroom"]) {
        CHECK(CSRevokeSessionMatches(@"me",session,session,session,@"me"));
        CHECK(CSRevokeSessionMatches(@"me",session,session,@"me",session));
        CHECK(CSRevokeSessionMatches(@"me",session,session,session,session));
        CHECK(CSRevokeSessionMatches(@"me",session,session,nil,nil));
        CHECK(!CSRevokeSessionMatches(@"me",session,@"other",session,@"me"));
        CHECK(!CSRevokeSessionMatches(@"me",session,nil,@"other",@"me"));
        CHECK(!CSRevokeSessionMatches(@"me",session,nil,nil,nil));
    }
    CSRevokeEvent *event=[CSRevokeEvent eventFromXML:@"<sysmsg type='revokemsg'><revokemsg><session><![CDATA[room@chatroom]]></session><newmsgid>101</newmsgid><replacemsg><![CDATA[张三撤回了一条消息]]></replacemsg></revokemsg></sysmsg>"];
    CHECK(event.serverID==101);CHECK([event.session isEqual:@"room@chatroom"]);CHECK([event.replacement containsString:@"张三"]);
    CHECK(![CSRevokeEvent eventFromXML:@"普通文字：他撤回了消息"]);
    CHECK(![CSRevokeEvent eventFromXML:@"<revokemsg><newmsgid>101x</newmsgid></revokemsg>"]);
    CHECK(![CSRevokeEvent eventFromXML:@"<revokemsg><newmsgid>1</newmsgid><newmsgid>2</newmsgid></revokemsg>"]);
    CHECK(![CSRevokeEvent eventFromXML:@"<!DOCTYPE a [<!ENTITY x SYSTEM 'file:///etc/passwd'>]><revokemsg><newmsgid>1</newmsgid></revokemsg>"]);
    CHECK(![CSRevokeEvent eventFromXML:@"<sysmsg><revokemsg><newmsgid>1</newmsgid></revokemsg><revokemsg><newmsgid>2</newmsgid></revokemsg></sysmsg>"]);
    CHECK(CSRevokeHasOwnedReference(@"<a href='revoke_jump_bad'>x</a>",nil));
    CHECK(CSRevokeHasOwnedReference(nil,@"revoke_jump_bad"));
    CHECK(!CSRevokeHasOwnedReference(@"revoke_jump_101",nil));
    CHECK(CSRevokeIsSelfReplacement(@"你撤回了一条消息"));
    CHECK(CSRevokeIsSelfReplacement(@"You recalled a message"));
    CHECK(!CSRevokeIsSelfReplacement(@"\"你撤回了一条消息\"撤回了一条消息"));
    CHECK(!CSRevokeIsSelfReplacement(@"\"You recalled a message\" recalled a message"));
    CHECK(![CSRevokeEvent eventFromXML:@"<ordinary><revokemsg><newmsgid>1</newmsgid></revokemsg></ordinary>"]);
    CHECK(![CSRevokeEvent eventFromXML:@"<revokemsg><newmsgid><x>1</x></newmsgid></revokemsg>"]);
    printf("PASS: %u persisted revoke reference/event checks\n",checks);
} return 0; }
