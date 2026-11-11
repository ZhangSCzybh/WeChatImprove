#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CSGroupChatManager.h"
#import "CSGroupChatNativeAdapter.h"
#import "CSGroupChatStore.h"
#import "CSGroupChatRuntime.h"
#import "CSGroupChatLocalNotice.h"
#import "CSGroupNativeBridge.h"
#import "CSMessageSendAdapter.h"
#import "CSBackupBootstrap.h"
#import "CSAuthorizationManager.h"

NSNotificationName const UIApplicationDidBecomeActiveNotification=@"FixtureDidBecomeActive";
NSNotificationName const UIApplicationDidEnterBackgroundNotification=@"FixtureDidEnterBackground";
static unsigned checks,requests,saves,notices,submissions;
static BOOL runtimeEnabled,authorized=YES,backupReady=YES,suspended,member=YES,unavailable;
static BOOL failWriteAfterReplacement;
static BOOL deliverNativeSnapshots,prepareFails,nativeHandoff=YES;
static CSMessageActionSubmissionState fixtureSubmissionState=CSMessageActionSubmissionStateSucceeded;
static NSUInteger submitAttempts;
static NSUInteger rejectNativeRequests;
static CSGroupChatManager *responseManager;
static NSDictionary *nativeJoinTimes;
static NSUInteger epoch=1;
static NSUInteger ingressGeneration,lastRequestGeneration,queuedResponses,acceptedResponses,rejectedResponses;
static NSString *account=@"alice",*room=@"101@chatroom";
static NSDictionary *storedState;
static NSSet *liveMembers;
static NSSet *serverMembers;
static NSNumber *serverVersion;
static NSMutableDictionary *roomData;
static void (^onNativeSave)(void);
static void (^onPrepareSend)(void);
static void (^onNativeNotice)(void);
static NSDictionary *Snapshot(NSArray *members,NSUInteger version,NSDate *date);
static void Check(BOOL value,NSString *detail){checks++;if(!value){fprintf(stderr,"FAIL: %s\n",detail.UTF8String);exit(1);}}
static void Pump(NSTimeInterval duration){NSDate *end=[NSDate.date dateByAddingTimeInterval:duration];do{[NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate.date dateByAddingTimeInterval:0.002]];}while([end timeIntervalSinceNow]>0);}
static void Wait(BOOL (^done)(void),NSString *detail){NSDate *end=[NSDate.date dateByAddingTimeInterval:3];while(!done() && end.timeIntervalSinceNow>0)Pump(0.002);Check(done(),detail);}
@implementation UIViewController @end
@implementation UIApplication
+ (instancetype)sharedApplication{static UIApplication *app;static dispatch_once_t once;dispatch_once(&once,^{app=[self new];});return app;}
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static CSAuthorizationManager *manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (BOOL)isAuthorized{return authorized;}
- (NSString *)officialAccountUserName{return @"fixture";}
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)controller completion:(CSAuthorizationCompletion)completion{(void)controller;if(completion)completion(authorized,@"fixture");}
- (void)openOfficialAccountFromViewController:(UIViewController *)controller{(void)controller;}
@end
@implementation CSMessageNativeEnvironment
- (NSString *)currentAccountID{return account;}
- (id)serviceNamed:(NSString *)name{(void)name;return nil;}
- (id)controllerForCell:(id)cell{(void)cell;return nil;}
@end
@implementation CSGroupChatQuitCoordinator
+ (instancetype)sharedCoordinator{static CSGroupChatQuitCoordinator *coordinator;static dispatch_once_t once;dispatch_once(&once,^{coordinator=[self new];});return coordinator;}
- (BOOL)isQuittingRoom:(NSString *)roomID{(void)roomID;return NO;}
- (BOOL)running{return NO;}
- (NSArray *)results{return @[];}
- (NSString *)statusText{return @"fixture";}
- (BOOL)startRoomIDs:(NSArray *)rooms clearHistory:(BOOL)clear account:(NSString *)owner epoch:(NSUInteger)value error:(NSError **)error{(void)rooms;(void)clear;(void)owner;(void)value;(void)error;return NO;}
- (void)stopFollowingBatches{}
@end
@implementation CSMessagePreparedSend
- (CSMessageActionSubmissionState)submit{submitAttempts++;if(self.submissionStillAuthorized && !self.submissionStillAuthorized())return CSMessageActionSubmissionStateFailedBeforeAcceptance;if(nativeHandoff)submissions++;return fixtureSubmissionState;}
- (id)outputWrap{return nil;}
- (NSString *)routeName{return @"fixture";}
- (BOOL)nativeHandoffReturned{return nativeHandoff;}
- (instancetype)initWithWrap:(id)wrap routeName:(NSString *)name submission:(CSMessageActionSubmissionState (^)(void))submission{(void)wrap;(void)name;(void)submission;return [super init];}
@end
@implementation CSMessageSendAdapter
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment{(void)environment;return [super init];}
- (CSMessagePreparedSend *)prepareGroupText:(NSString *)text mentions:(NSArray *)mentions targetID:(NSString *)target accountID:(NSString *)owner{
    (void)text;(void)mentions;(void)target;(void)owner;if(onPrepareSend)onPrepareSend();return prepareFails?nil:[CSMessagePreparedSend new];
}
@end
BOOL CSBackupIsReady(void){return backupReady;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
NSUInteger CSBackupAccountEpoch(void){return epoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger value,void (^handoff)(void)){if(value!=epoch || suspended || !backupReady)return NO;handoff();return YES;}
NSString *CSGroupCurrentAccountID(void){return account;}
void CSGroupChatSetRuntimeEnabled(BOOL enabled){runtimeEnabled=enabled;ingressGeneration++;}
id CSGroupChatRoomContact(NSString *roomID){return [roomID isEqual:room]?@{@"m_ChatRoomData":roomData}:nil;}
NSString *CSGroupChatRoomName(NSString *roomID){(void)roomID;return @"Fixture group";}
NSSet *CSGroupChatMemberIDs(NSString *roomID){(void)roomID;return liveMembers;}
BOOL CSGroupChatIsMember(NSString *roomID,NSString *owner){(void)roomID;return member && [owner isEqual:account];}
BOOL CSGroupChatRoomUnavailable(NSString *roomID){(void)roomID;return unavailable;}
BOOL CSGroupChatRequestMembers(NSString *roomID){
    (void)roomID;requests++;NSUInteger capturedGeneration=ingressGeneration;BOOL enabledAtCapture=runtimeEnabled;lastRequestGeneration=capturedGeneration;
    if(rejectNativeRequests){rejectNativeRequests--;return NO;}
    NSSet *responseMembers=serverMembers?:liveMembers;NSNumber *responseVersion=serverVersion?:roomData[@"chatRoomVersion"];
    NSDictionary *snapshot=deliverNativeSnapshots?Snapshot([responseMembers.allObjects sortedArrayUsingSelector:@selector(compare:)],responseVersion.unsignedIntegerValue,nil):nil;
    BOOL updatesCache=serverMembers!=nil;
    NSUInteger capturedEpoch=epoch;
    // Model a synchronous native CGI callback captured by the runtime hook,
    // whose immutable result is then queued to main after Manager returns.
    dispatch_async(dispatch_get_main_queue(),^{queuedResponses++;if(enabledAtCapture && runtimeEnabled && capturedGeneration==ingressGeneration){acceptedResponses++;
        // Native OnGetChatRoomMemberDetail updates its contact cache before
        // Runtime.Publish checks the response. No contact callback is emitted
        // in the system-hint scenarios; only the full query reveals the join.
        if(updatesCache && capturedEpoch==epoch){liveMembers=[NSSet setWithArray:snapshot[@"members"]];roomData[@"chatRoomVersion"]=snapshot[@"version"];}
        // Mirror Runtime.Publish's version and complete-identity checks. A
        // native contact change alone never synthesizes an authoritative event.
        if(snapshot && capturedEpoch==epoch && [snapshot[@"version"] isEqual:roomData[@"chatRoomVersion"]] && [[NSSet setWithArray:snapshot[@"members"]] isEqual:liveMembers])[responseManager receiveMemberSnapshot:snapshot epoch:capturedEpoch];
    }else rejectedResponses++;});
    return YES;
}
BOOL CSGroupChatSaveToContacts(NSString *roomID,NSString *owner,NSError **error){(void)roomID;(void)owner;(void)error;saves++;void (^callback)(void)=[onNativeSave copy];if(callback)callback();return YES;}
BOOL CSGroupChatPostDepartureNotice(NSString *owner,NSString *roomID,NSString *memberID,NSDate *date,NSString *eventID,NSString *format,NSDictionary<NSString *,NSString *> *values,BOOL (^stillAuthorized)(void)){(void)owner;(void)roomID;(void)memberID;(void)date;(void)eventID;(void)format;(void)values;void (^callback)(void)=[onNativeNotice copy];if(callback)callback();if(stillAuthorized && !stillAuthorized())return NO;notices++;return YES;}
id CSMessageActionNativeObject(id object,NSString *selector){return [object isKindOfClass:NSDictionary.class]?object[selector]:nil;}
BOOL CSMessageNativeSupports(id object,NSString *selector,NSString *type,NSArray *arguments){(void)type;(void)arguments;return object==roomData && [@[@"hasJoinInfoForUsername:",@"getJoinTimeForUsername:",@"chatRoomVersion"] containsObject:selector];}
id CSMessageNativeInvoke(id object,NSString *selector,NSArray *arguments){(void)arguments;if(object!=roomData)return nil;if([selector isEqual:@"hasJoinInfoForUsername:"])return @([roomData[@"joinTime"] unsignedLongLongValue]>0);if([selector isEqual:@"getJoinTimeForUsername:"])return roomData[@"joinTime"];return roomData[selector];}
unsigned long long CSMessageNativeUnsigned(id object,NSString *selector){return [CSMessageNativeInvoke(object,selector,@[]) unsignedLongLongValue];}
// Persistence is fully in-memory. The Manager's diagnostic .members path is
// redirected to the test directory before any member snapshot can be processed.
NSString *const CSGroupChatBackupDomain=@"group_chat_tools";
NSURL *CSGroupChatFileURL(NSURL *root,NSString *owner){(void)root;(void)owner;return [NSURL fileURLWithPath:@"/nonexistent/group-manager-fixture/config.plist"];}
NSDictionary *CSGroupChatReadState(NSURL *url,NSString *owner,NSError **error){(void)url;(void)owner;if(error)*error=nil;return storedState;}
BOOL CSGroupChatWriteState(NSDictionary *state,NSURL *url,NSString *owner,NSError **error){(void)url;(void)owner;if(error)*error=nil;storedState=[state copy];if(failWriteAfterReplacement){failWriteAfterReplacement=NO;if(error)*error=[NSError errorWithDomain:@"CSGroupChatStore" code:1 userInfo:@{NSLocalizedDescriptionKey:@"群聊配置已替换，但无法确认持久保存"}];return NO;}return YES;}
NSDictionary *CSGroupChatDefaultConfiguration(void){return @{@"schemaVersion":@1,@"welcomeEnabled":@NO,@"welcomeRooms":@[],@"welcomeTemplate":@"欢迎@昵称加入@群昵称",@"welcomeDelay":@0,@"monitorEnabled":@NO,@"monitorRooms":@[],@"departureTemplate":@"@昵称 退出了群聊",@"autoSaveEnabled":@NO};}
BOOL CSGroupChatValidateConfiguration(NSDictionary *configuration){return [configuration isKindOfClass:NSDictionary.class] && configuration.count==CSGroupChatDefaultConfiguration().count;}
static NSDictionary *Snapshot(NSArray *members,NSUInteger version,NSDate *date){return @{@"roomID":room,@"members":members,@"version":@(version),@"observedAt":date?:NSDate.date,@"active":@YES,@"unavailable":@NO,@"roomName":@"Fixture group",@"names":@{@"old":@"Old",@"new":@"New",@"second":@"Second"},@"joinTimes":nativeJoinTimes?:@{}};}
static void Receive(CSGroupChatManager *manager,NSArray *members,NSUInteger version){liveMembers=[NSSet setWithArray:members];roomData[@"chatRoomVersion"]=@(version);[manager receiveMemberSnapshot:Snapshot(members,version,nil) epoch:epoch];}
static void Configure(CSGroupChatManager *manager,NSDictionary *changes){__block BOOL done=NO,success=NO;[manager updateConfiguration:changes completion:^(BOOL value,NSError *error){(void)error;success=value;done=YES;}];Wait(^BOOL{return done;},@"configuration transaction completes");Check(success,@"configuration transaction succeeds");}
static void Background(void){UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];}
static void ActivateOnly(void){UIApplication.sharedApplication.applicationState=UIApplicationStateActive;[NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];}
static void Foreground(void){Background();ActivateOnly();}
static void InactiveBounce(void){UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;ActivateOnly();}
static int WelcomeScenario(NSString *scenario){
    deliverNativeSnapshots=YES;nativeJoinTimes=@{};roomData=[NSMutableDictionary dictionaryWithDictionary:@{@"chatRoomVersion":@1,@"joinTime":@0}];liveMembers=[NSSet setWithArray:@[@"alice",@"old"]];
    storedState=@{@"schema":@1,@"account":account,@"configuration":CSGroupChatDefaultConfiguration()};
    responseManager=[CSGroupChatManager new];[responseManager start];Wait(^BOOL{return responseManager.ready;},@"welcome fixture loads isolated account");
    Configure(responseManager,@{@"welcomeEnabled":@YES,@"welcomeRooms":@[room]});
    Wait(^BOOL{return [[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] isEqual:@1];},@"enable receives first complete baseline through native request");
    NSUInteger requestsBeforeJoin=requests;
    nativeJoinTimes=@{@"new":@((unsigned long long)NSDate.date.timeIntervalSince1970)};
    liveMembers=[NSSet setWithArray:@[@"alice",@"old",@"new"]];roomData[@"chatRoomVersion"]=@2;
    if([scenario isEqual:@"short-gap"]){
        [responseManager nativeContactChanged:room epoch:epoch];Pump(5.2);
        fprintf(stderr,"short-gap evidence: initial requests=%lu, requests after contact+5.2s=%u, welcomes=%u, baselineVersion=%s\n",(unsigned long)requestsBeforeJoin,requests,submissions,[[[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] description] UTF8String]);
        Check(requests>requestsBeforeJoin,@"contact update during cooldown receives a trailing member request");
        Check(submissions==1,@"new member arriving shortly after enable receives one welcome");
    }else if([scenario hasPrefix:@"system-"]){
        // A server-side membership update has not reached the native cache.
        // The hint must force a query even though the baseline still matches.
        serverMembers=liveMembers;serverVersion=@2;liveMembers=[NSSet setWithArray:@[@"alice",@"old"]];roomData[@"chatRoomVersion"]=@1;
        if([scenario hasPrefix:@"system-busy"]){
            [[responseManager valueForKey:@"requests"] removeAllObjects];rejectNativeRequests=[scenario isEqual:@"system-busy-exhausted"]?NSUIntegerMax:1;
            NSUInteger responsesBeforeBusy=queuedResponses;
            [responseManager nativeSystemMessageInRoom:room epoch:epoch];
            Check(requests==requestsBeforeJoin+1 && queuedResponses==responsesBeforeBusy,@"busy native request returns false without scheduling any full response");
            Check([[responseManager valueForKey:@"forcedRefreshRooms"] containsObject:room] && [[responseManager valueForKey:@"retriedRefreshRooms"] containsObject:room] && [[responseManager valueForKey:@"deferredRequests"] count]==1,@"first rejected forced request retains exactly one bounded retry");
            if([scenario isEqual:@"system-busy-background"]){
                Background();Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"retriedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"background clears busy retry budget, forced hint and timer ticket");Pump(5.2);
                Check(requests==requestsBeforeJoin+1 && submissions==0,@"busy retry cannot query or welcome after background");
            }else if([scenario isEqual:@"system-busy-exhausted"]){
                Pump(10.3);Check(requests==requestsBeforeJoin+2 && queuedResponses==responsesBeforeBusy && submissions==0,@"two rejected native requests exhaust the budget without a third query or synthetic response");
                Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"retriedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"exhausted busy retry leaves no forced hint, budget or scheduled ticket");
            }else if([scenario isEqual:@"system-busy"]){
                Pump(5.2);Check(requests==requestsBeforeJoin+2 && submissions==1,@"one delayed retry after native busy obtains full v2 and welcomes once");
                Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"retriedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"accepted retry consumes forced hint, retry budget and trailing ticket");
            }else{fprintf(stderr,"Unknown system busy scenario: %s\n",scenario.UTF8String);return 2;}
        }else if([scenario isEqual:@"system-expired-epoch"]){
            [responseManager nativeSystemMessageInRoom:room epoch:epoch-1];Pump(0.04);
            Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"expired-epoch system hint cannot create a forced task");
            Check(requests==requestsBeforeJoin && submissions==0,@"expired-epoch system hint cannot query or welcome");
        }else{
            NSUInteger hints=[scenario isEqual:@"system-coalescing"]?8:1;
            for(NSUInteger index=0;index<hints;index++)[responseManager nativeSystemMessageInRoom:room epoch:epoch];
            Check(requests==requestsBeforeJoin && [[responseManager valueForKey:@"deferredRequests"] count]==1,@"system hints coalesce behind the existing request cooldown");
            Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==1,@"system hint retains one forced refresh despite an unchanged native cache");
            if([scenario isEqual:@"system-background"]){
                Background();[responseManager nativeSystemMessageInRoom:room epoch:epoch];
                Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"background clears forced tasks and rejects new system hints");Pump(5.2);
                Check(requests==requestsBeforeJoin && submissions==0,@"background system task cannot query or welcome");
            }else if([scenario isEqual:@"system-config"]){
                Configure(responseManager,@{@"welcomeEnabled":@NO});
                Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"configuration transaction clears pending forced tasks");Pump(5.2);
                Check(requests==requestsBeforeJoin && submissions==0,@"old-configuration forced task cannot query or welcome");
            }else if([scenario isEqual:@"system-account"]){
                NSUInteger oldEpoch=epoch;account=@"bob";epoch++;storedState=@{@"schema":@1,@"account":account,@"configuration":CSGroupChatDefaultConfiguration()};[responseManager refresh];
                Wait(^BOOL{return responseManager.ready && [responseManager.accountID isEqual:@"bob"];},@"system task switches to isolated new-account defaults");
                [responseManager nativeSystemMessageInRoom:room epoch:oldEpoch];
                Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"account boundary clears forced tasks and rejects old-epoch hints");Pump(5.2);
                Check(requests==requestsBeforeJoin && submissions==0,@"old-account forced task cannot query or welcome");
            }else if([@[@"system-hint",@"system-coalescing",@"system-covered"] containsObject:scenario]){
                if([scenario isEqual:@"system-covered"]){
                    [responseManager receiveMemberSnapshot:Snapshot(liveMembers.allObjects,1,nil) epoch:epoch];
                    Check([[responseManager valueForKey:@"forcedRefreshRooms"] containsObject:room],@"a snapshot covering only the unchanged cache does not consume the system hint");
                }
                Check([[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] isEqual:@1] && ![liveMembers containsObject:@"new"],@"native cache and baseline remain old until the forced full query");Pump(5.2);
                Check(requests==requestsBeforeJoin+1 && submissions==1,@"system hint forces exactly one full query and one new-member welcome");
                Check([liveMembers containsObject:@"new"] && [[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] isEqual:@2],@"full response updates the native cache and authoritative baseline");
                Check([[responseManager valueForKey:@"forcedRefreshRooms"] count]==0 && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"submitted forced query consumes its hint and trailing ticket");
            }else{fprintf(stderr,"Unknown system scenario: %s\n",scenario.UTF8String);return 2;}
        }
    }else if([scenario hasPrefix:@"deferred-"]){
        for(NSUInteger index=0;index<8;index++)[responseManager nativeContactChanged:room epoch:epoch];
        Check(requests==requestsBeforeJoin,@"repeated contact hooks respect the current request cooldown");
        Check([[responseManager valueForKey:@"deferredRequests"] count]==1,@"repeated contact hooks coalesce into one trailing ticket");
        if([scenario isEqual:@"deferred-coalescing"]){
            Pump(5.2);Check(requests==requestsBeforeJoin+1,@"eight contact hooks produce exactly one trailing native request");
            Check(submissions==1,@"coalesced request welcomes its one new member exactly once");
        }else if([scenario isEqual:@"deferred-background"]){
            Background();Check([[responseManager valueForKey:@"deferredRequests"] count]==0,@"background removes trailing request tickets");Pump(5.2);
            Check(requests==requestsBeforeJoin && submissions==0,@"old-session trailing request never submits in background");
        }else if([scenario isEqual:@"deferred-config"]){
            Configure(responseManager,@{@"welcomeEnabled":@NO});Check([[responseManager valueForKey:@"deferredRequests"] count]==0,@"configuration transaction removes trailing request tickets");Pump(5.2);
            Check(requests==requestsBeforeJoin && submissions==0,@"old-configuration trailing request never queries or welcomes");
        }else if([scenario isEqual:@"deferred-account"]){
            account=@"bob";epoch++;storedState=@{@"schema":@1,@"account":account,@"configuration":CSGroupChatDefaultConfiguration()};[responseManager refresh];
            Wait(^BOOL{return responseManager.ready && [responseManager.accountID isEqual:@"bob"];},@"different account loads its isolated default configuration");
            Check([[responseManager valueForKey:@"deferredRequests"] count]==0,@"account boundary removes trailing request tickets");Pump(5.2);
            Check(requests==requestsBeforeJoin && submissions==0,@"old-account trailing request never enters the new account");
        }else if([scenario isEqual:@"deferred-covered"]){
            [responseManager receiveMemberSnapshot:Snapshot(liveMembers.allObjects,2,nil) epoch:epoch];Pump(0.04);Check(submissions==1,@"independent full snapshot already covers the new member");Pump(5.2);
            Check(requests==requestsBeforeJoin && [[responseManager valueForKey:@"deferredRequests"] count]==0,@"covered native membership cancels an unnecessary trailing query");
        }else{fprintf(stderr,"Unknown deferred scenario: %s\n",scenario.UTF8String);return 2;}
    }else if([scenario isEqual:@"quiet-active"]){
        // Advance only the fixture's observation clocks; no five-minute wait
        // is needed to exercise the actual production freshness predicate.
        NSMutableDictionary *baselines=[responseManager valueForKey:@"baselines"];
        NSMutableDictionary *quiet=[baselines[room] mutableCopy];quiet[@"observedAt"]=[NSDate.date dateByAddingTimeInterval:-300];baselines[room]=quiet;
        [responseManager setValue:[NSDate.date dateByAddingTimeInterval:-600] forKey:@"sessionStarted"];
        [[responseManager valueForKey:@"requests"] removeAllObjects];nativeJoinTimes=@{};
        [responseManager nativeContactChanged:room epoch:epoch];Pump(0.04);
        fprintf(stderr,"quiet-active evidence: native requests=%u, current baselineVersion=%s, welcomes=%u, old observation gap=300s, joinTimes=absent\n",requests,[[[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] description] UTF8String],submissions);
        Check(requests>requestsBeforeJoin,@"quiet active group obtains the changed full snapshot");
        Check(submissions==1,@"new member after five quiet foreground minutes receives a welcome without join-time metadata");
    }else if([scenario hasPrefix:@"inactive-deadline"]){
        Configure(responseManager,@{@"welcomeDelay":@1});
        Wait(^BOOL{return [[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] isEqual:@2];},@"delayed-welcome fixture has a complete baseline");
        Receive(responseManager,@[@"alice",@"old",@"new",@"second"],3);
        Check([[responseManager valueForKey:@"pendingWelcomes"] count]==1,@"valid member delta creates one delayed welcome");
        UIApplication.sharedApplication.applicationState=UIApplicationStateInactive;Pump(1.1);
        Check(submitAttempts==0 && submissions==0,@"welcome never prepares a native handoff while inactive at its due time");
        Check([[responseManager valueForKey:@"pendingWelcomes"] count]==1,@"due welcome remains pending across transient inactive state");
        if([scenario isEqual:@"inactive-deadline-background"]){
            Background();Check([[responseManager valueForKey:@"pendingWelcomes"] count]==0,@"real background clears the inactive overdue welcome");
        }else if([scenario isEqual:@"inactive-deadline-config"]){
            Configure(responseManager,@{@"welcomeTemplate":@"新的欢迎@昵称"});
            Check([[responseManager valueForKey:@"pendingWelcomes"] count]==0,@"configuration change invalidates inactive overdue welcome even with feature enabled");
        }else if([scenario isEqual:@"inactive-deadline-account"]){
            NSDictionary *aliceState=[storedState copy];account=@"bob";epoch++;storedState=@{@"schema":@1,@"account":account,@"configuration":CSGroupChatDefaultConfiguration()};[responseManager refresh];
            Wait(^BOOL{return responseManager.ready && [responseManager.accountID isEqual:@"bob"];},@"inactive pending welcome crosses to isolated bob account");
            Check([[responseManager valueForKey:@"pendingWelcomes"] count]==0,@"account change clears inactive overdue welcome");
            account=@"alice";epoch++;storedState=aliceState;[responseManager refresh];
            Wait(^BOOL{return responseManager.ready && [responseManager.accountID isEqual:@"alice"];},@"same account returns with a new epoch before reactivation");
        }else if([scenario isEqual:@"inactive-deadline-expired"]){
            NSMutableDictionary *queue=[responseManager valueForKey:@"pendingWelcomes"];NSString *identifier=queue.allKeys.firstObject;
            NSMutableDictionary *expired=[queue[identifier] mutableCopy];expired[@"deadline"]=[NSDate.date dateByAddingTimeInterval:-1];queue[identifier]=expired;
        }else if(![scenario isEqual:@"inactive-deadline"]){fprintf(stderr,"Unknown inactive deadline scenario: %s\n",scenario.UTF8String);return 2;}
        ActivateOnly();Pump(0.04);ActivateOnly();Pump(0.04);
        BOOL resumes=[scenario isEqual:@"inactive-deadline"];
        Check(submissions==(resumes?1u:0u) && submitAttempts==(resumes?1u:0u),resumes?@"reactivation submits due welcome exactly once despite repeated active notifications":@"background, configuration, account or expiry boundary never revives old welcome");
        Check([[responseManager valueForKey:@"pendingWelcomes"] count]==0,@"reactivation consumes or invalidates the inactive overdue task");
    }else if([scenario isEqual:@"inactive-bounce"]){
        // DidBecomeActive also follows transient inactive UI, without any
        // DidEnterBackground notification. A known baseline already exists and
        // native metadata proves that this one member joined seconds ago.
        [[responseManager valueForKey:@"requests"] removeAllObjects];InactiveBounce();
        Check([[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] isEqual:@1],@"transient inactive does not erase the active member baseline");
        [responseManager nativeContactChanged:room epoch:epoch];Pump(0.04);
        fprintf(stderr,"inactive-bounce evidence: requests=%u, welcomes=%u, baselineVersion=%s, freshJoinMetadata=YES\n",requests,submissions,[[[[responseManager valueForKey:@"baselines"] objectForKey:room][@"version"] description] UTF8String]);
        Check(submissions==1,@"transient inactive-to-active retains enough baseline to welcome a proven fresh join");
    }else if([scenario isEqual:@"submit-failure"] || [scenario isEqual:@"prepare-failure"]){
        [[responseManager valueForKey:@"requests"] removeAllObjects];
        if([scenario isEqual:@"submit-failure"]){fixtureSubmissionState=CSMessageActionSubmissionStateFailedBeforeAcceptance;nativeHandoff=NO;}else prepareFails=YES;
        [responseManager nativeContactChanged:room epoch:epoch];Pump(0.04);
        fprintf(stderr,"%s evidence: prepareFails=%d, submitAttempts=%lu, nativeHandoffs=%u, status=%s\n",scenario.UTF8String,prepareFails,(unsigned long)submitAttempts,submissions,responseManager.statusText.UTF8String);
        Check(submissions==0,@"failed welcome never reports a native handoff");
        Check([responseManager.statusText containsString:prepareFails?@"无法发送":@"未提交"],@"failed welcome route presents the actual failure instead of stale pending/baseline status");
    }else{fprintf(stderr,"Unknown welcome scenario: %s\n",scenario.UTF8String);return 2;}
    printf("Group chat welcome %s: %u checks passed\n",scenario.UTF8String,checks);return 0;
}
int main(int argc,char **argv){@autoreleasepool{
    if(argc==2)return WelcomeScenario(@(argv[1]));
    roomData=[NSMutableDictionary dictionaryWithDictionary:@{@"chatRoomVersion":@1,@"joinTime":@0}];liveMembers=[NSSet setWithArray:@[@"alice",@"old"]];
    storedState=@{@"schema":@1,@"account":account,@"configuration":CSGroupChatDefaultConfiguration()};
    CSGroupChatManager *manager=[CSGroupChatManager new];[manager start];Wait(^BOOL{return manager.ready;},@"manager loads isolated configuration");
    Check(!runtimeEnabled,@"default disabled features do not admit runtime ingress");
    Configure(manager,@{@"welcomeEnabled":@YES,@"welcomeRooms":@[room],@"monitorEnabled":@YES,@"monitorRooms":@[room]});
    Check(runtimeEnabled && requests>0,@"configuration completion enables runtime and requests native baseline");
    Wait(^BOOL{return queuedResponses==requests;},@"configuration baseline callback reaches deferred main handoff");
    Check(lastRequestGeneration==ingressGeneration && acceptedResponses==requests && rejectedResponses==0,@"configuration baseline request keeps its ingress generation through function return");
    Receive(manager,@[@"alice",@"old"],1);Receive(manager,@[@"alice"],2);Check(notices==1,@"member departure inserts one local notice");
    Receive(manager,@[@"alice"],2);Receive(manager,@[@"alice"],2);Check(notices==1,@"repeated same-version responses do not duplicate notice");
    Receive(manager,@[@"alice",@"new"],3);Check([[manager valueForKey:@"pendingWelcomes"] count]==1,@"join schedules pending welcome");
    Background();Check(!runtimeEnabled && [[manager valueForKey:@"pendingWelcomes"] count]==0,@"background disables ingress and clears pending welcome");Pump(0.03);Check(submissions==0,@"cancelled background welcome never submits");
    NSDictionary *oldPacket=Snapshot(@[@"alice",@"new",@"second"],4,NSDate.date);Pump(0.01);Foreground();Check(runtimeEnabled,@"foreground re-enables configured ingress");
    [manager receiveMemberSnapshot:oldPacket epoch:epoch];Check([[manager valueForKey:@"baselines"] count]==0 && submissions==0,@"packet observed before foreground is rejected");
    Receive(manager,@[@"alice",@"new"],4);Receive(manager,@[@"alice",@"new",@"second"],5);Configure(manager,@{@"welcomeTemplate":@"另一文案@昵称"});Pump(0.03);Check(submissions==0,@"configuration change cancels welcome from prior generation");
    Configure(manager,@{@"autoSaveEnabled":@YES});roomData[@"joinTime"]=@0;[manager nativeContactChanged:room epoch:epoch];Check(saves==0,@"initial missing join metadata does not auto-save historical group");
    roomData[@"joinTime"]=@((unsigned long long)NSDate.date.timeIntervalSince1970);[manager nativeContactChanged:room epoch:epoch];Check(saves==1,@"later fresh native join metadata can auto-save");
    [manager nativeContactChanged:room epoch:epoch];Check(saves==1,@"repeat contact updates do not duplicate native save");
    Receive(manager,@[@"old"],10);NSDictionary *absent=[manager valueForKey:@"baselines"][room];Check([absent[@"version"] isEqual:@10],@"complete self-absent snapshot keeps version watermark");
    NSUInteger priorNotices=notices,priorSaves=saves;Receive(manager,@[@"alice",@"new"],9);Pump(0.02);Check(notices==priorNotices && saves==priorSaves && submissions==0,@"older self-present response cannot resurrect departed group");
    Check([[[manager valueForKey:@"baselines"] objectForKey:room][@"version"] isEqual:@10],@"stale response preserves self-absent version watermark");
    Foreground();roomData[@"joinTime"]=@0;Receive(manager,@[@"alice",@"old"],20);Receive(manager,@[@"alice",@"old",@"new"],21);
    onPrepareSend=^{liveMembers=[NSSet setWithArray:@[@"alice",@"old"]];};Pump(0.03);onPrepareSend=nil;Check(submissions==0,@"member departure during preparation invalidates final welcome handoff");
    Foreground();Receive(manager,@[@"alice",@"old"],30);Receive(manager,@[@"alice",@"old",@"new"],31);Pump(0.03);Check(submissions==1,@"valid current welcome submits exactly once");
    Receive(manager,@[@"alice",@"old",@"new"],31);Pump(0.02);Check(submissions==1,@"repeated join version does not send another welcome");
    // Native save can synchronously re-enter the settings transaction through
    // contact hooks. The outer old snapshot must keep its original generation.
    Configure(manager,@{@"welcomeDelay":@1});Foreground();roomData[@"joinTime"]=@0;Receive(manager,@[@"alice",@"old"],40);
    __block BOOL reentrantDone=NO;roomData[@"joinTime"]=@((unsigned long long)NSDate.date.timeIntervalSince1970);
    onNativeSave=^{onNativeSave=nil;[manager updateConfiguration:@{@"welcomeTemplate":@"重入后@昵称"} completion:^(BOOL success,NSError *error){(void)error;reentrantDone=success;}];};
    Receive(manager,@[@"alice",@"old",@"new"],41);Wait(^BOOL{return reentrantDone;},@"reentrant native save configuration completes");Pump(1.1);
    Check(submissions==1,@"native save reentrancy cannot rebind old event to new configuration generation");
    Configure(manager,@{@"welcomeDelay":@0});Foreground();roomData[@"joinTime"]=@0;Receive(manager,@[@"alice",@"old"],50);Receive(manager,@[@"alice",@"old",@"new"],51);
    onPrepareSend=^{Foreground();};Pump(0.03);onPrepareSend=nil;
    Check(submissions==1,@"foreground reentrancy during sender preparation rejects old-session handoff");
    Check([[manager valueForKey:@"pendingWelcomes"] count]==0 && [[manager valueForKey:@"baselines"] count]==0,@"foreground during preparation rebuilds baseline and queue");
    Receive(manager,@[@"alice",@"old"],60);NSUInteger noticesBeforeBoundary=notices;
    onNativeNotice=^{Foreground();};Receive(manager,@[@"alice"],61);onNativeNotice=nil;
    Check(notices==noticesBeforeBoundary,@"local notice checks stillAuthorized after native preparation reenters foreground");
    Check([[manager valueForKey:@"baselines"] count]==0,@"local notice cannot restore pre-foreground baseline");
    Configure(manager,@{@"welcomeDelay":@1});Foreground();roomData[@"joinTime"]=@0;
    Receive(manager,@[@"alice",@"old"],70);NSUInteger sendsBeforeRejoin=submissions;
    Receive(manager,@[@"alice",@"old",@"new"],71);Receive(manager,@[@"alice",@"old"],72);Receive(manager,@[@"alice",@"old",@"new"],73);Pump(1.1);
    Check(submissions==sendsBeforeRejoin+1,@"leaving cancels old member-cycle welcome before same username rejoins");
    Receive(manager,@[@"alice",@"old",@"new",@"second"],80);NSUInteger sendsBeforeUncertainWrite=submissions;
    Check([[manager valueForKey:@"pendingWelcomes"] count]==1,@"pending welcome exists before uncertain disable write");
    failWriteAfterReplacement=YES;__block BOOL failedWriteDone=NO,failedWriteSuccess=YES;
    [manager updateConfiguration:@{@"welcomeEnabled":@NO} completion:^(BOOL success,NSError *error){failedWriteSuccess=success;failedWriteDone=YES;Check(error!=nil,@"uncertain commit surfaces storage error");}];
    Wait(^BOOL{return failedWriteDone;},@"uncertain commit completion arrives");Check(!failedWriteSuccess,@"uncertain durable commit is not reported as success");
    Wait(^BOOL{return manager.ready;},@"uncertain commit reloads actual stored configuration");
    Check(![storedState[@"configuration"][@"welcomeEnabled"] boolValue] && ![manager.configuration[@"welcomeEnabled"] boolValue],@"disabled welcome from replaced file becomes actual runtime configuration");
    Pump(1.1);Receive(manager,@[@"alice",@"old",@"new",@"second",@"third"],81);Pump(0.02);
    Check(submissions==sendsBeforeUncertainWrite && [[manager valueForKey:@"pendingWelcomes"] count]==0,@"uncertain disable write never resumes old pending or new welcome automation");
    printf("Group chat manager lifecycle: %u checks passed\n",checks);return 0;
}}
