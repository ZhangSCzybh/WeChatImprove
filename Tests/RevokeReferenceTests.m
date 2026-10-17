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
    // Group envelope normalization remains strict: no arbitrary embedded XML search.
    NSString *payload=@"<sysmsg type='revokemsg'><revokemsg><session>room@chatroom</session><newmsgid>402</newmsgid></revokemsg></sysmsg>";
    for (NSString *prefix in @[@"member:\n",@"wxid_member-1:\n",@"room@chatroom:\n",@" \nmember:\n \n"])
        CHECK([CSRevokeEvent eventFromXML:[prefix stringByAppendingString:payload]].serverID==402);
    for (NSString *prefix in @[@":\n",@"some ordinary text:\n",@"member:",@"text before ",@"<ordinary>",@"member:\nsecond:\n"])
        CHECK(![CSRevokeEvent eventFromXML:[prefix stringByAppendingString:payload]]);
    CHECK(![CSRevokeEvent eventFromXML:@"member:\n<revokemsg><newmsgid>402</newmsgid><newmsgid>403</newmsgid></revokemsg>"]);
    CHECK(![CSRevokeEvent eventFromXML:@"member:\n<!DOCTYPE a><revokemsg><newmsgid>402</newmsgid></revokemsg>"]);
    CHECK(CSRevokeSessionMatches(@"me",@"room@chatroom",nil,@"member",@"room@chatroom"));
    CHECK(CSRevokeSessionMatches(@"me",@"room@im.chatroom",nil,@"member",@"room@im.chatroom"));
    CHECK(!CSRevokeSessionMatches(@"me",@"room@chatroom",nil,@"member",@"other@chatroom"));
    CHECK(!CSRevokeSessionMatches(@"me",@"room@chatroom",nil,@"room@chatroom",@"other@chatroom"));
    CHECK(!CSRevokeSessionMatches(@"me",@"room@chatroom",@"other@chatroom",@"member",@"room@chatroom"));
    CHECK(!CSRevokeSessionMatches(@"me",@"peer",nil,@"member",@"peer"));
    CHECK([CSRevokeActorName(@"\"喜欢撤回的用户\"撤回了一条消息") isEqual:@"喜欢撤回的用户"]);
    CHECK([CSRevokeActorName(@"“张三”撤回了一条消息") isEqual:@"张三"]);
    CHECK([CSRevokeActorName(@"&#x22;张三&#x22;撤回了一条消息") isEqual:@"张三"]);
    CHECK([CSRevokeActorName(@"\"A \"B\" C\"撤回了一条消息") isEqual:@"A \"B\" C"]);
    CHECK([CSRevokeActorName(@"\"Alice\" recalled a message") isEqual:@"Alice"]);
    CHECK([CSRevokeActorName(@"张三撤回了一条消息") isEqual:@"张三"]);
    CHECK(!CSRevokeActorName(@"普通文本"));CHECK(!CSRevokeActorName(nil));
    CHECK([CSRevokeEscapeText(@"A \"B\" O'Neil & <a>") isEqual:@"A \"B\" O'Neil &amp; &lt;a&gt;"]);
    CHECK([CSRevokeEscapeText(nil) isEqual:@""]);
    printf("PASS: %u persisted revoke reference/event checks\n",checks);
} return 0; }
