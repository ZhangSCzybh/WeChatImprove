#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendNotificationAdapter.h"
#import "CSCloseFriendCallAdapter.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"
static NSUInteger Checks,Epoch=1;
static CSCloseFriendSnapshot *Policy;
#define CHECK(c) do{Checks++;if(!(c)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#c);exit(1);}}while(0)
NSString *const CSCloseFriendPolicyDidChangeNotification=@"test-policy";
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return Policy;}
NSUInteger CSCloseFriendAccountEpoch(void){return Epoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void (^handoff)(void)){if(epoch!=Epoch)return NO;handoff();return YES;}
void CSCloseFriendRecordCapability(NSString *n,BOOL available){}
id CSCloseFriendRead(id o,NSString *key) {if([o isKindOfClass:NSDictionary.class])return o[key];SEL s=NSSelectorFromString(key);return CSCloseFriendMethodMatches(class_getInstanceMethod([o class],s),"@@:")?((id(*)(id,SEL))objc_msgSend)(o,s):nil;}
NSString *CSCloseFriendUserName(id o){return [o isKindOfClass:NSString.class]?o:CSCloseFriendRead(o,@"m_nsUsrName");}
BOOL CSCloseFriendInstallHook(NSString *c,NSString *s,IMP r,IMP *o,const char *e){Method m=class_getInstanceMethod(NSClassFromString(c),NSSelectorFromString(s));if(!CSCloseFriendMethodMatches(m,e))return NO;*o=method_setImplementation(m,r);return YES;}
static NSMutableDictionary *FixtureServices;
id CSGetService(Class c){return c ? FixtureServices[NSStringFromClass(c)] : nil;}
static CSCloseFriendSnapshot *Snapshot(BOOL enabled,BOOL revealed,NSDictionary *options) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@(enabled),@"friends":@[@"friend"],@"groups":@[@"secret@chatroom"],@"options":options?:@{}} revealed:revealed revision:Epoch blocked:NO];
}
@interface Mono : NSObject
@property BOOL cancel,expired;
@property(copy) NSString *msgKey,*m_fromUser;
@property id m_group;
@property unsigned long long roomID;
@end
@implementation Mono
- (BOOL)isCancelMsg{return self.cancel;}
- (BOOL)isOutOfDate{return self.expired;}
@end
@interface Info : NSObject
@property unsigned long long roomID,roomType;
@property long long roomKey;
@property BOOL isFromIlink;
@property unsigned int receiveTime;
@property id contact,monoMsg,inviteInfo;
@end
@implementation Info @end
@interface Invites : NSObject
@property NSUInteger rejects;
@end
@implementation Invites
- (void)rejectInvitationWithInfo:(id)info{self.rejects++;}
@end
@interface Conf : NSObject
@property unsigned long long roomid;
@property NSString *callerUsername;
@end
@implementation Conf @end
@interface VoIPMPSubCallService : NSObject
@property id cache;
+ (instancetype)sharedInstance;
@end
@implementation VoIPMPSubCallService
+ (instancetype)sharedInstance{static VoIPMPSubCallService *service;static dispatch_once_t once;dispatch_once(&once,^{service=[self new];});return service;}
@end
@interface Group : NSObject
@property long long mroomid;
@property(copy) NSString *mWxGroupId;
@end
@implementation Group @end
@interface Multi : NSObject
@property BOOL connected;
@property unsigned long long active,lastRejected;
@property NSUInteger rejects;
@end
@implementation Multi
- (BOOL)isMultiTalkConnected{return self.connected;}
- (unsigned long long)getCurrentRoomID{return self.active;}
- (void)MultiTalkReject:(unsigned long long)room{self.rejects++;self.lastRejected=room;}
@end
#include "CloseFriendCallReplyFixture.h"
#include "CloseFriendIncomingCallFixture.h"
// Only the new public badge accessor is extracted. Its actual projection runs below.
@interface CSGroupListAdapter : NSObject
@property id controller;
@property NSArray *cachedNativeSections;
@property NSNumber *alertBadge;
@property NSArray *alertBadgeKey;
@property NSUInteger changeDepth,snapshotRevision,modelRevision,snapshotEpoch;
@property BOOL dirty;
@property NSString *snapshotAccount;
+ (NSNumber *)closeFriendAlertBadgeCount;
@end
static NSHashTable *Owners;
static NSHashTable *Adapters(void){return Owners;}
static BOOL CSGroupIsFoldedController(id c){return [c isEqual:@"folded"];}
static NSString *CSGroupCurrentAccountID(void){return Policy.accountID;}
typedef NS_ENUM(NSUInteger,CSGroupFoldedPrivacyState){CSGroupFoldedPrivacyUnknown,CSGroupFoldedPrivacyAllHidden,CSGroupFoldedPrivacyNoHidden};
static NSArray *FoldedNames;
static NSArray *CSGroupCopyFoldedUserNames(void){return FoldedNames;}
static CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(id names,id hidden){return CSGroupFoldedPrivacyUnknown;}
@implementation CSGroupListAdapter
#import "AlertBadgeBody.h"
@end
@interface UNMutableNotificationContent : NSObject <NSCopying>
@property NSNumber *badge;
@end
@implementation UNMutableNotificationContent
- (id)copyWithZone:(NSZone *)zone{UNMutableNotificationContent *c=[UNMutableNotificationContent new];c.badge=self.badge;return c;}
- (id)mutableCopyWithZone:(NSZone *)zone{return [self copyWithZone:zone];}
@end
@interface UNNotificationRequest : NSObject
@property NSString *identifier;
@property UNMutableNotificationContent *content;
@property id trigger;
+ (instancetype)requestWithIdentifier:(NSString *)identifier content:(id)content trigger:(id)trigger;
@end
@implementation UNNotificationRequest
+ (instancetype)requestWithIdentifier:(NSString *)identifier content:(id)content trigger:(id)trigger{UNNotificationRequest *r=[self new];r.identifier=identifier;r.content=content;r.trigger=trigger;return r;}
@end
@interface UNUserNotificationCenter : NSObject
@property NSUInteger submissions;
@property NSArray *removedPending,*removedDelivered;
+ (instancetype)currentNotificationCenter;
- (void)removePendingNotificationRequestsWithIdentifiers:(NSArray *)identifiers;
- (void)removeDeliveredNotificationsWithIdentifiers:(NSArray *)identifiers;
- (void)addNotificationRequest:(UNNotificationRequest *)r withCompletionHandler:(void(^)(NSError *))completion;
@end
@implementation UNUserNotificationCenter
+ (instancetype)currentNotificationCenter{static UNUserNotificationCenter *center;static dispatch_once_t once;dispatch_once(&once,^{center=[self new];});return center;}
- (void)removePendingNotificationRequestsWithIdentifiers:(NSArray *)identifiers{self.removedPending=identifiers;}
- (void)removeDeliveredNotificationsWithIdentifiers:(NSArray *)identifiers{self.removedDelivered=identifiers;}
- (void)addNotificationRequest:(UNNotificationRequest *)r withCompletionHandler:(void(^)(NSError *))completion{self.submissions++;if(completion)completion(nil);}
@end
static NSMutableDictionary *Requests;
#import "AlertOutputDecisions.h"
#import "AlertNotificationBody.h"
static CSGroupRow *Row(NSUInteger index,NSString *name,NSUInteger count,CSGroupRowKind kind){NSUInteger path[]={0,index};return [[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:path length:2] userName:name kind:kind category:CSGroupRowCategoryPrivate top:NO unreadCount:count redDot:NO];}
int main(void){@autoreleasepool{
    // Retired values in an existing profile cannot suppress current-account messages.
    Policy=Snapshot(YES,NO,@{@"silenceMessages":@YES,@"rejectVoice":@NO,@"rejectVideo":@NO});
    NSDictionary *message=@{@"m_nsFromUsr":@"ordinary@chatroom",@"m_nsToUsr":@"self",@"m_nsRealChatUsr":@"friend"};
    CSCloseFriendAlertSubject *s=CSCFMessageSubject(message,nil);CHECK(s.isCurrent && !s.shouldDiscardOutput);
    Policy=Snapshot(YES,YES,@{@"showBadges":@YES,@"silenceMessages":@YES});CHECK(s.isCurrent && !s.shouldDiscardOutput);
    CHECK(!CSCFMessageSubject(@{@"m_nsFromUsr":@"friend",@"m_nsToUsr":@"another-account"},nil));
    CHECK(![CSCFMessageSubject(@{@"m_nsFromUsr":@"ordinary",@"m_nsToUsr":@"self"},nil) shouldDiscardOutput]);
    CSCFWithAlert(s,^{CHECK(CSCFCurrentAlert()==s);CSCFWithAlert(nil,^{CHECK(!CSCFCurrentAlert());});CHECK(CSCFCurrentAlert()==s);});CHECK(!CSCFCurrentAlert());
    Epoch++;CHECK(s.shouldDiscardOutput);CHECK(!CSCFMessageSubject(message,nil).isCurrent);
    Policy=Snapshot(YES,YES,nil);CHECK(!CSCFPaymentOutputAllowed(@"self",@"ordinary@chatroom",@"friend"));CHECK(CSCFPaymentOutputAllowed(@"self",@"ordinary",@"ordinary"));CHECK(!CSCFPaymentOutputAllowed(@"other",@"ordinary",@"ordinary"));
    Policy=Snapshot(YES,NO,@{@"silenceMessages":@YES,@"rejectVoice":@NO,@"rejectVideo":@NO});
    CHECK(!CSCFPaymentOutputAllowed(@"self",@"friend",nil));CHECK(!CSCFPaymentOutputAllowed(@"self",@"secret@chatroom",@"ordinary"));
    Requests=[NSMutableDictionary dictionary];InstallNotificationOutput();
    UNUserNotificationCenter *center=[UNUserNotificationCenter new];UNNotificationRequest *request=[UNNotificationRequest requestWithIdentifier:@"bound" content:[UNMutableNotificationContent new] trigger:nil];
    __block NSUInteger completions=0;
    CSCFWithAlert([CSCloseFriendAlertSubject subjectForSession:@"friend" sender:nil],^{[center addNotificationRequest:request withCompletionHandler:^(NSError *error){CHECK(!error);completions++;}];});
    CHECK(completions==1 && center.submissions==1);
    CSCFWithAlert([CSCloseFriendAlertSubject subjectForSession:@"ordinary" sender:nil],^{[center addNotificationRequest:request withCompletionHandler:^(NSError *error){CHECK(!error);completions++;}];});
    CHECK(completions==2 && center.submissions==2);
    // A positively bound old-account request is not an unknown request. Exercise
    // the real UN submission hook after the switch, including its completion.
    CSCloseFriendAlertSubject *oldSubject=[CSCloseFriendAlertSubject subjectForSession:@"ordinary" sender:nil];
    UNNotificationRequest *stale=[UNNotificationRequest requestWithIdentifier:@"stale" content:[UNMutableNotificationContent new] trigger:nil];
    CSCFBindAlert(stale,oldSubject);
    [center addNotificationRequest:stale withCompletionHandler:^(NSError *error){CHECK(!error);completions++;}];
    CHECK(completions==3 && center.submissions==3);
    Epoch++;Policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"new-account" profile:@{@"enabled":@NO} revealed:NO revision:Epoch blocked:NO];
    CHECK(oldSubject.shouldDiscardOutput && !oldSubject.isCurrent);
    [center addNotificationRequest:stale withCompletionHandler:^(NSError *error){CHECK(!error);completions++;}];
    CHECK(completions==4 && center.submissions==3);
    UNNotificationRequest *unknown=[UNNotificationRequest requestWithIdentifier:@"unknown" content:[UNMutableNotificationContent new] trigger:nil];
    CSCFWithAlert(oldSubject,^{[center addNotificationRequest:unknown withCompletionHandler:^(NSError *error){CHECK(!error);completions++;}];});
    CHECK(completions==5 && center.submissions==3);
    [center addNotificationRequest:unknown withCompletionHandler:^(NSError *error){CHECK(!error);completions++;}];
    CHECK(completions==6 && center.submissions==4);
    CHECK(DiscardOutput(oldSubject) && !DiscardOutput(nil));
    // Cleanup matches both the tracked identifier and captured content. A native
    // replacement reusing the identifier, or an untracked request, is untouched.
    UNNotificationRequest *replacement=[UNNotificationRequest requestWithIdentifier:@"bound" content:[UNMutableNotificationContent new] trigger:nil];
    RemoveKnown(@[stale,replacement,unknown],NO);RemoveKnown(@[stale,replacement,unknown],YES);
    CHECK([UNUserNotificationCenter.currentNotificationCenter.removedPending isEqual:@[@"stale"]]);
    CHECK([UNUserNotificationCenter.currentNotificationCenter.removedDelivered isEqual:@[@"stale"]]);
    Policy=Snapshot(YES,YES,nil);

    // Unified invitation: duplicate protection, current ordinary room preserved, ilink unsupported.
    Policy=Snapshot(YES,NO,nil);Mono *mono=[Mono new];mono.msgKey=@"invite-1";Info *info=[Info new];info.roomID=100;info.roomKey=7;info.roomType=1;info.contact=@"friend";info.monoMsg=mono;Invites *service=[Invites new];
    CHECK(CSCFHandleInvitation(service,info,999));CHECK(service.rejects==1);CHECK(CSCFHandleInvitation(service,info,999));CHECK(service.rejects==1);
    info.roomID=101;mono.msgKey=@"invite-2";info.isFromIlink=YES;CHECK(CSCFHandleInvitation(service,info,999));CHECK(service.rejects==1);
    info.contact=@"ordinary";CHECK(!CSCFHandleInvitation(service,info,999));CHECK(service.rejects==1);
    info.contact=@"friend";info.isFromIlink=NO;mono.cancel=YES;CHECK(CSCFHandleInvitation(service,info,999));CHECK(service.rejects==1);mono.cancel=NO;
    Conf *conf=[Conf new];conf.roomid=102;conf.callerUsername=@"friend";VoIPMPSubCallService.sharedInstance.cache=@{@"inviteInfo":conf};info.inviteInfo=conf;info.roomID=102;info.roomKey=0;info.isFromIlink=YES;mono.msgKey=@"cached-ilink";
    CHECK(CSCFHandleInvitation(service,info,999));CHECK(service.rejects==2);CHECK(CSCFHandleInvitation(service,info,999));CHECK(service.rejects==2);
    info.contact=@"ordinary";CHECK(!CSCFHandleInvitation(service,info,999));info.contact=@"friend";
    // Group is its own subject; disabling either unknown-media switch disallows rejection.
    Group *group=[Group new];group.mWxGroupId=@"secret@chatroom";group.mroomid=200;Mono *gm=[Mono new];gm.m_group=group;gm.roomID=200;gm.m_fromUser=@"ordinary";gm.msgKey=@"group-1";
    Multi *multi=[Multi new];multi.connected=YES;multi.active=999;__block NSUInteger lifecycle=0;
    CSCFHandleMultiTalk(multi,gm,^{lifecycle++;CHECK(CSCFCallOutputSuppressed());CHECK(DiscardOutput(CSCFCurrentAlert()));CHECK(CSCFCallBannerSuppressed(group,200));CHECK(!CSCFCallBannerSuppressed(group,999));});CHECK(lifecycle==1 && multi.rejects==1 && multi.lastRejected==200 && multi.active==999);CHECK(!CSCFCallOutputSuppressed());CHECK(!CSCFCallBannerSuppressed(group,200));
    CSCFHandleMultiTalk(multi,gm,^{lifecycle++;});CHECK(multi.rejects==1 && lifecycle==2);
    multi.active=200;CSCFHandleMultiTalk(multi,gm,^{CHECK(!CSCFCallOutputSuppressed());});CHECK(multi.rejects==1);multi.active=999;
    Policy=Snapshot(YES,YES,nil);
    CSCFHandleMultiTalk(multi,gm,^{lifecycle++;CHECK(!CSCFCallOutputSuppressed());CHECK(!CSCFCallBannerSuppressed(group,200));CHECK(!CSCFCurrentAlert());});
    CHECK(lifecycle==3 && multi.rejects==1 && multi.active==999);
    Policy=Snapshot(YES,NO,@{@"rejectVoice":@NO,@"silenceMessages":@YES});CHECK(![CSCFMultiTalkToken(gm) requiresRejection]);CHECK(![CSCFMultiTalkToken(gm) suppressesPresentation]);
    CSCFHandleMultiTalk(multi,gm,^{lifecycle++;CHECK(!CSCFCallOutputSuppressed());CHECK(!CSCFCallBannerSuppressed(group,200));});CHECK(lifecycle==4 && multi.rejects==1);
    group.mWxGroupId=@"ordinary@chatroom";CHECK(![CSCFMultiTalkToken(gm) suppressesPresentation]);CSCFHandleMultiTalk(multi,gm,^{CHECK(!CSCFCallOutputSuppressed());lifecycle++;});CHECK(lifecycle==5 && multi.rejects==1);
    // Badge filtering follows concealed session rows; folded owners never double totals.
    Policy=Snapshot(YES,NO,@{@"showBadges":@YES,@"silenceMessages":@YES});Owners=[NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];CSGroupListAdapter *owner=[CSGroupListAdapter new];owner.controller=@"main";owner.snapshotAccount=@"self";owner.modelRevision=owner.snapshotRevision=1;owner.snapshotEpoch=Epoch;
    owner.cachedNativeSections=@[@[Row(0,@"friend",8,CSGroupRowKindSession),Row(1,@"ordinary",3,CSGroupRowKindSession),Row(2,@"chatroom_session_box",10,CSGroupRowKindAggregate)]];[Owners addObject:owner];
    CSGroupListAdapter *folded=[CSGroupListAdapter new];folded.controller=@"folded";folded.snapshotAccount=@"self";folded.cachedNativeSections=@[@[Row(0,@"ordinary",30,CSGroupRowKindSession)]];[Owners addObject:folded];
    CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@3]);CHECK(((CSGroupRow *)owner.cachedNativeSections[0][0]).unreadCount==8);
    Policy=Snapshot(YES,YES,@{@"silenceMessages":@YES});CHECK(![CSGroupListAdapter closeFriendAlertBadgeCount]);
    Policy=Snapshot(YES,NO,@{@"hideSessions":@NO,@"silenceMessages":@YES});CHECK(![CSGroupListAdapter closeFriendAlertBadgeCount]);
    CHECK(((CSGroupRow *)owner.cachedNativeSections[0][0]).unreadCount==8);
    Policy=Snapshot(YES,NO,@{@"showBadges":@YES,@"silenceMessages":@YES});
    NSArray *badgeKey=owner.alertBadgeKey;NSNumber *badge=owner.alertBadge;
    for(NSUInteger i=0;i<20;i++)CHECK([CSGroupListAdapter closeFriendAlertBadgeCount]==badge);
    CHECK(owner.alertBadgeKey==badgeKey); // Same revision never rebuilds the projection.
    FoldedNames=@[@"group@chatroom"];CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@3]);CHECK(owner.alertBadgeKey!=badgeKey);
    owner.modelRevision++;owner.snapshotRevision=owner.modelRevision;
    owner.cachedNativeSections=@[@[Row(0,@"friend",8,CSGroupRowKindSession),Row(1,@"ordinary",5,CSGroupRowKindSession)]];
    CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@5]);
    owner.snapshotEpoch--;CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@0]);owner.snapshotEpoch=Epoch;
    owner.modelRevision++;CHECK([[CSGroupListAdapter closeFriendAlertBadgeCount] isEqual:@0]);Policy=Snapshot(NO,NO,nil);CHECK(![CSGroupListAdapter closeFriendAlertBadgeCount]);
    IncomingCallChecks();
    CallReplyChecks();
    printf("Close-friend alerts: %lu focused checks passed (identity, calls, reply, badge, payment policy)\n",(unsigned long)Checks);
}return 0;}
