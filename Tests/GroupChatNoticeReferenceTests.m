#import <Foundation/Foundation.h>
#import "CSGroupChatNoticeReference.h"
static unsigned checks,failures;
#define CHECK(value) do { checks++; if (!(value)) { failures++; fprintf(stderr,"FAIL %d: %s\n",__LINE__,#value); } } while(0)
int main(void) { @autoreleasepool {
    NSString *link=CSGroupChatNoticeLink(@"wxid_account",@"100@chatroom",@"wxid_member",@"leave|v:12|wxid_member");
    CHECK(link.length>0);
    NSDictionary *reference=CSGroupChatParseNoticeLink(link);
    CHECK([reference[@"account"] isEqual:@"wxid_account"]);
    CHECK([reference[@"room"] isEqual:@"100@chatroom"]);
    CHECK([reference[@"member"] isEqual:@"wxid_member"]);
    CHECK([reference[@"event"] isEqual:@"leave|v:12|wxid_member"]);
    CHECK([link isEqual:CSGroupChatNoticeLink(@"wxid_account",@"100@chatroom",@"wxid_member",@"leave|v:12|wxid_member")]);
    CHECK(!CSGroupChatParseNoticeLink(@"revoke_jump_v2_2_1"));
    CHECK(!CSGroupChatParseNoticeLink(@"https://example.com"));
    CHECK(!CSGroupChatParseNoticeLink(@"csgroupmember_v2.eA.eQ.eg.ZQ"));
    CHECK(!CSGroupChatParseNoticeLink([link stringByAppendingString:@".extra"]));
    CHECK(!CSGroupChatParseNoticeLink([link stringByAppendingString:@"="]));
    CHECK(!CSGroupChatParseNoticeLink(@"csgroupmember_v1.eA.eQ.eg.A"));
    CHECK(!CSGroupChatParseNoticeLink(@"csgroupmember_v1.eB.eQ.eg.ZQ"));
    CHECK(!CSGroupChatParseNoticeLink(@42));
    CHECK(!CSGroupChatNoticeLink(@"",@"100@chatroom",@"member",@"event"));
    CHECK(!CSGroupChatNoticeLink(@"user",@"not_a_room",@"member",@"event"));
    CHECK(!CSGroupChatNoticeLink(@"user",@"100@chatroom",@"200@chatroom",@"event"));
    CHECK(!CSGroupChatNoticeLink(@"user",@"100@chatroom",@"wrong<member>",@"event"));
    CHECK(!CSGroupChatNoticeLink(@"user",@"100@chatroom",@"member",@"line\nbreak"));
    CHECK(!CSGroupChatNoticeLink([@"x" stringByPaddingToLength:257 withString:@"x" startingAtIndex:0],@"100@chatroom",@"member",@"event"));
    NSString *unicode=CSGroupChatNoticeLink(@"user",@"100@chatroom",@"member",@"事件：<>&\"@昵称");
    CHECK([CSGroupChatParseNoticeLink(unicode)[@"event"] isEqual:@"事件：<>&\"@昵称"]);
    NSString *content=[NSString stringWithFormat:@"<a href=\"%@\">&lt;@昵称&gt;</a> 退出了群聊",link];
    CHECK([CSGroupChatResolveNoticeLink(link,content,link)[@"link"] isEqual:link]);
    CHECK([CSGroupChatResolveNoticeLink(nil,content,link)[@"link"] isEqual:link]);
    CHECK([CSGroupChatResolveNoticeLink(link,content,nil)[@"link"] isEqual:link]);
    CHECK(!CSGroupChatResolveNoticeLink(@"https://example.com",content,link));
    CHECK(!CSGroupChatResolveNoticeLink(link,@"ordinary message",link));
    CHECK(!CSGroupChatResolveNoticeLink(link,content,@"revoke_jump_1"));
    NSString *other=CSGroupChatNoticeLink(@"wxid_other",@"100@chatroom",@"wxid_member",@"leave|v:12|wxid_member");
    CHECK(!CSGroupChatResolveNoticeLink(other,content,link));
    NSString *ambiguous=[content stringByAppendingFormat:@"<a href='%@'>wrong account</a>",other];
    CHECK(!CSGroupChatResolveNoticeLink(link,ambiguous,nil));
    CHECK(!CSGroupChatResolveNoticeLink(nil,ambiguous,nil));
    NSString *repeated=[content stringByAppendingString:content];
    CHECK([CSGroupChatResolveNoticeLink(link,repeated,link)[@"link"] isEqual:link]);
    NSString *external=[content stringByAppendingString:@"<a href='https://example.com'>native web link</a>"];
    CHECK([CSGroupChatResolveNoticeLink(link,external,link)[@"link"] isEqual:link]);
    CHECK(!CSGroupChatResolveNoticeLink(@"https://example.com",external,link));
    CHECK(!CSGroupChatResolveNoticeLink(link,[content stringByPaddingToLength:65537 withString:@"x" startingAtIndex:0],link));
    // A relogin changes no durable identity: an epoch is deliberately absent.
    CHECK([CSGroupChatParseNoticeLink(link)[@"account"] isEqual:@"wxid_account"]);
    fprintf(stdout,"Group notice references: %u checks, %u failures\n",checks,failures);
    return failures?1:0;
} }
