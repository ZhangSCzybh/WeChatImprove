#import <Foundation/Foundation.h>
#import "CSMessageSendAdapter.h"
#import "CSGroupChatTemplate.h"

static unsigned checks,failures;
#define CHECK(value) do { checks++; if (!(value)) { failures++; fprintf(stderr,"FAIL %d: %s\n",__LINE__,#value); } } while(0)
static NSUInteger mentionABI;
@interface GroupMentionPayload : NSObject
@property(nonatomic,copy) NSString *m_nsAtUserList;
@end
@implementation GroupMentionPayload
@end
@interface GroupWrongMentionPayload : NSObject
@property(nonatomic) unsigned int m_nsAtUserList;
@end
@implementation GroupWrongMentionPayload
@end
@interface GroupThrowingMentionPayload : NSObject
- (NSString *)m_nsAtUserList;
- (void)setM_nsAtUserList:(NSString *)value;
@end
@implementation GroupThrowingMentionPayload
- (NSString *)m_nsAtUserList {return nil;}
- (void)setM_nsAtUserList:(NSString *)value {(void)value;[NSException raise:@"FixtureMentionSetter" format:@"Injected before send"];}
@end
@interface CMessageWrap : NSObject
@property(nonatomic,copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsClientMsgID;
@property(nonatomic) unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime,m_uiStatus;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic,strong) id m_extendInfoWithMsgType;
@property(nonatomic,copy) NSString *m_nsAtUserList;
- (instancetype)initWithMsgType:(long long)type;
@end
@implementation CMessageWrap
@dynamic m_nsAtUserList;
- (instancetype)initWithMsgType:(long long)type {
    if((self=[super init])){_m_uiMessageType=(unsigned int)type;_m_extendInfoWithMsgType=mentionABI==0?[GroupMentionPayload new]:(mentionABI==1?[GroupWrongMentionPayload new]:(mentionABI==3?[GroupThrowingMentionPayload new]:[NSObject new]));}return self;
}
- (id)forwardingTargetForSelector:(SEL)selector {return [_m_extendInfoWithMsgType respondsToSelector:selector]?_m_extendInfoWithMsgType:[super forwardingTargetForSelector:selector];}
@end
@interface GroupMentionManager : NSObject
@property(nonatomic,strong) NSMutableArray *calls;
@property(nonatomic) BOOL throws;
@end
@implementation GroupMentionManager
- (instancetype)init {if((self=[super init]))_calls=[NSMutableArray array];return self;}
- (void)AddMsg:(NSString *)room MsgWrap:(CMessageWrap *)wrap {
    [_calls addObject:@[room,wrap]];if(self.throws)[NSException raise:@"FixtureNativeSend" format:@"Injected after handoff"];
}
@end
@interface GroupMentionEnvironment : NSObject <CSMessageActionEnvironment>
@property(nonatomic,copy) NSString *account;
@property(nonatomic,strong) id manager;
@end
@implementation GroupMentionEnvironment
- (NSString *)currentAccountID {return _account;}
- (id)serviceNamed:(NSString *)name {return [name isEqual:@"CMessageMgr"]?_manager:nil;}
- (id)controllerForCell:(id)cell {(void)cell;return nil;}
@end

int main(void) {@autoreleasepool {
    CHECK(NSThread.isMainThread);
    GroupMentionManager *manager=[GroupMentionManager new];GroupMentionEnvironment *environment=[GroupMentionEnvironment new];
    environment.account=@"wxid_fixture_self";environment.manager=manager;CSMessageSendAdapter *adapter=[[CSMessageSendAdapter alloc]initWithEnvironment:environment];
    NSString *room=@"90001@chatroom";
    NSDictionary *rendered=CSGroupChatWelcomeText(@"欢迎@昵称加入@群昵称",@[@"wxid_one",@"wxid_two",@"wxid_one"],@{@"wxid_one":@"同名",@"wxid_two":@"同名"},@"夹具群",3,NSDate.date);
    CSMessagePreparedSend *route=[adapter prepareGroupText:rendered[@"text"] mentions:rendered[@"mentions"] targetID:room accountID:environment.account];
    CHECK(route!=nil);CHECK(manager.calls.count==0);CHECK([route.routeName isEqual:@"AddMsg:MsgWrap:"]);
    CMessageWrap *wrap=route.outputWrap;CHECK(wrap.m_uiMessageType==1);CHECK(wrap.m_uiMesLocalID==0);CHECK(wrap.m_n64MesSvrID==0);
    CHECK([wrap.m_nsFromUsr isEqual:environment.account]);CHECK([wrap.m_nsToUsr isEqual:room]);CHECK([wrap.m_nsContent isEqual:rendered[@"text"]]);
    CHECK([wrap.m_nsAtUserList isEqual:@"wxid_one,wxid_two"]);CHECK(wrap.m_nsClientMsgID.length>0);
    route.submissionStillAuthorized=^BOOL{return YES;};CHECK([route submit]==CSMessageActionSubmissionStateUnknown);
    CHECK(route.nativeHandoffReturned);CHECK(manager.calls.count==1);CHECK(manager.calls.firstObject[1]==wrap);
    CHECK([route submit]==CSMessageActionSubmissionStateUnknown);CHECK(manager.calls.count==1);
    CSMessagePreparedSend *deduplicated=[adapter prepareGroupText:@"@同名\u2005" mentions:@[@"wxid_one",@"wxid_one"] targetID:room accountID:environment.account];
    CHECK([CSMessageActionNativeObject(deduplicated.outputWrap,@"m_nsAtUserList") isEqual:@"wxid_one"]);
    for(NSArray *members in @[@[@"notify@all"],@[@""],@[@"wxid_one,wxid_two"],@[@"other@chatroom"],@[@42],@[@"bad\nname"]])
        CHECK(![adapter prepareGroupText:@"text" mentions:members targetID:room accountID:environment.account]);
    CHECK(![adapter prepareGroupText:@"text" mentions:@[] targetID:@"friend" accountID:environment.account]);
    CHECK(![adapter prepareGroupText:@"" mentions:@[] targetID:room accountID:environment.account]);
    CHECK(![adapter prepareGroupText:@"text" mentions:@[] targetID:room accountID:@"wxid_other"]);
    CHECK(![adapter prepareGroupText:[@"x" stringByPaddingToLength:4001 withString:@"x" startingAtIndex:0] mentions:@[] targetID:room accountID:environment.account]);
    CSMessagePreparedSend *blocked=[adapter prepareGroupText:@"text" mentions:@[@"wxid_one"] targetID:room accountID:environment.account];
    __block BOOL allowed=NO;blocked.submissionStillAuthorized=^BOOL{return allowed;};
    CHECK([blocked submit]==CSMessageActionSubmissionStateFailedBeforeAcceptance);CHECK(manager.calls.count==1);
    allowed=YES;CHECK([blocked submit]==CSMessageActionSubmissionStateUnknown);CHECK(manager.calls.count==1);
    CSMessagePreparedSend *switched=[adapter prepareGroupText:@"text" mentions:@[@"wxid_one"] targetID:room accountID:environment.account];
    NSString *boundAccount=environment.account;switched.submissionStillAuthorized=^BOOL{return [environment.account isEqual:boundAccount];};environment.account=@"wxid_switched";
    CHECK([switched submit]==CSMessageActionSubmissionStateFailedBeforeAcceptance);CHECK(manager.calls.count==1);environment.account=boundAccount;
    manager.throws=YES;CSMessagePreparedSend *uncertain=[adapter prepareGroupText:@"text" mentions:@[@"wxid_one"] targetID:room accountID:environment.account];
    CHECK([uncertain submit]==CSMessageActionSubmissionStateUnknown);CHECK(manager.calls.count==2);CHECK(!uncertain.nativeHandoffReturned);
    CHECK([uncertain submit]==CSMessageActionSubmissionStateUnknown);CHECK(manager.calls.count==2);manager.throws=NO;
    mentionABI=1;CHECK(![adapter prepareGroupText:@"text" mentions:@[@"wxid_one"] targetID:room accountID:environment.account]);
    mentionABI=2;CHECK(![adapter prepareGroupText:@"text" mentions:@[@"wxid_one"] targetID:room accountID:environment.account]);
    mentionABI=3;CHECK(![adapter prepareGroupText:@"text" mentions:@[@"wxid_one"] targetID:room accountID:environment.account]);
    // A plain custom template can send without any native mention capability.
    CHECK([adapter prepareGroupText:@"欢迎加入" mentions:@[] targetID:room accountID:environment.account]!=nil);
    CHECK(manager.calls.count==2);
    fprintf(stdout,"Group chat native mentions: %u checks, %u failures (recording fixtures only)\n",checks,failures);
    return failures?1:0;
} }
