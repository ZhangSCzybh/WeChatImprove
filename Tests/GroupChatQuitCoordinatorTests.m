// Host lifecycle fixture for the actual production coordinator.
// All native services and account state are fake; this performs no WeChat actions.
// Run with Tests/verify-group-chat-quit.sh on macOS.

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#include <string.h>
static NSString *const UIApplicationDidBecomeActiveNotification=@"Active";
static NSString *activeAccount=@"me";
static NSUInteger accountEpoch=1;
static BOOL backupReady=YES, suspended=NO, authAllowed=YES, nativeABI=YES;
static NSMutableArray *submitted;
static NSMutableSet *departed;
static NSMutableDictionary *preflight;
BOOL CSBackupIsReady(void){return backupReady;}
BOOL CSBackupAccountIsSuspended(void){return suspended;}
NSUInteger CSBackupAccountEpoch(void){return accountEpoch;}
BOOL CSBackupPerformAtAccountEpoch(NSUInteger epoch,void(^block)(void)){if(epoch!=accountEpoch)return NO;block();return YES;}
@interface CSAuthorizationManager:NSObject
+ (instancetype)sharedManager;
@property(readonly) BOOL isAuthorized;
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager{static id a;static dispatch_once_t once;dispatch_once(&once,^{a=[self new];});return a;}
- (BOOL)isAuthorized{return authAllowed;}
@end
@interface FakeGroupService:NSObject
- (BOOL)IsUsrInChatRoom:(NSString*)room Usr:(NSString*)user;
@end
@implementation FakeGroupService
- (BOOL)IsUsrInChatRoom:(NSString*)room Usr:(NSString*)user{return ![departed containsObject:room];}
@end
@interface CSMessageNativeEnvironment:NSObject
- (NSString*)currentAccountID;
- (id)serviceNamed:(NSString*)name;
@end
@implementation CSMessageNativeEnvironment
- (NSString*)currentAccountID{return activeAccount;}
- (id)serviceNamed:(NSString*)name{return [FakeGroupService new];}
@end
BOOL CSMessageNativeSupports(id receiver,NSString*selector,NSString*result,NSArray*arguments){
 if(!nativeABI)return NO;Method m=class_getInstanceMethod(object_getClass(receiver),NSSelectorFromString(selector));if(!m || method_getNumberOfArguments(m)!=arguments.count+2)return NO;
 char t[128];method_getReturnType(m,t,sizeof(t));if(*t!=[result UTF8String][0] && !([result isEqual:@"B"] && *t=='c'))return NO;
 for(NSUInteger i=0;i<arguments.count;i++){method_getArgumentType(m,(unsigned)i+2,t,sizeof(t));if(*t!=[arguments[i] UTF8String][0] && !([arguments[i] isEqual:@"B"] && *t=='c'))return NO;}return YES;
}
id CSMessageNativeInvoke(id receiver,NSString*selector,NSArray*arguments){
 SEL sel=NSSelectorFromString(selector);NSMethodSignature *sig=[receiver methodSignatureForSelector:sel];NSInvocation *inv=[NSInvocation invocationWithMethodSignature:sig];inv.target=receiver;inv.selector=sel;
 for(NSUInteger i=0;i<arguments.count;i++){id v=arguments[i]==NSNull.null?nil:arguments[i];const char*t=[sig getArgumentTypeAtIndex:i+2];if(*t=='B' || *t=='c'){BOOL b=[v boolValue];[inv setArgument:&b atIndex:i+2];}else [inv setArgument:&v atIndex:i+2];}
 [inv invoke];if(*sig.methodReturnType=='B' || *sig.methodReturnType=='c'){BOOL b=NO;[inv getReturnValue:&b];return @(b);}if(*sig.methodReturnType=='@'){__unsafe_unretained id v=nil;[inv getReturnValue:&v];return v;}return nil;
}
NSString *CSGroupChatRoomName(NSString *room){return room;}
NSString *CSGroupChatQuitPreflight(NSString *room,NSString *account){return preflight[room];}
@protocol BatchQuitChatRoomLogicDelegate<NSObject>
- (void)batchQuitChatRoomLogic:(id)logic didSucceedRoom:(NSString*)room;
- (void)batchQuitChatRoomLogic:(id)logic didFailRoom:(NSString*)room errorMessage:(NSString*)message;
- (void)batchQuitChatRoomLogic:(id)logic didCompleteWithSuccessRooms:(NSArray*)successes failures:(NSDictionary*)failures errorMessage:(NSString*)message isNetworkError:(BOOL)network;
@end
@interface BatchQuitChatRoomLogic:NSObject
@property(nonatomic,weak)id<BatchQuitChatRoomLogicDelegate> delegate;
@property(nonatomic)BOOL running,cancelled,clearHistory;
@property(nonatomic,copy)NSArray *rooms;
- (void)startWithRoomNames:(NSArray*)rooms clearHistory:(BOOL)clear;
- (void)cancel;
- (void)completeSuccess;
@end
@implementation BatchQuitChatRoomLogic
- (void)startWithRoomNames:(NSArray*)rooms clearHistory:(BOOL)clear{self.rooms=[rooms copy];self.running=YES;self.clearHistory=clear;[submitted addObject:self];}
- (void)cancel{self.cancelled=YES;self.running=NO;self.delegate=nil;}
- (void)completeSuccess{for(NSString*r in self.rooms){[departed addObject:r];[self.delegate batchQuitChatRoomLogic:self didSucceedRoom:r];}self.running=NO;[self.delegate batchQuitChatRoomLogic:self didCompleteWithSuccessRooms:self.rooms failures:@{} errorMessage:nil isNetworkError:NO];}
@end
@interface CSGroupChatQuitCoordinator:NSObject
@property(nonatomic,readonly)BOOL running;
@property(nonatomic,copy,readonly)NSArray<NSDictionary*>*results;
@property(nonatomic,copy,readonly)NSString*statusText;
+ (instancetype)sharedCoordinator;
- (BOOL)startRoomIDs:(NSArray*)rooms clearHistory:(BOOL)clear account:(NSString*)account epoch:(NSUInteger)epoch error:(NSError**)error;
- (void)stopFollowingBatches;
- (BOOL)isQuittingRoom:(NSString*)room;
@end
#include "CSGroupChatQuitCoordinator-under-test.inc"
static void check(BOOL condition,NSString*name){if(!condition){fprintf(stderr,"FAIL %s\n",name.UTF8String);exit(1);}}
static void reset(void){activeAccount=@"me";accountEpoch++;backupReady=YES;suspended=NO;authAllowed=YES;nativeABI=YES;submitted=[NSMutableArray array];departed=[NSMutableSet set];preflight=[NSMutableDictionary dictionary];}
static NSArray *rooms(NSUInteger count){NSMutableArray*a=[NSMutableArray array];for(NSUInteger i=0;i<count;i++)[a addObject:[NSString stringWithFormat:@"%lu@chatroom",(unsigned long)i]];return a;}
static CSGroupChatQuitCoordinator *begin(NSUInteger count){CSGroupChatQuitCoordinator*c=[CSGroupChatQuitCoordinator new];NSError*e=nil;check([c startRoomIDs:rooms(count) clearHistory:NO account:activeAccount epoch:accountEpoch error:&e],e.localizedDescription?:@"start");return c;}
static NSUInteger countStatus(CSGroupChatQuitCoordinator*c,NSString*s){NSUInteger n=0;for(NSDictionary*r in c.results)if([r[@"status"]isEqual:s])n++;return n;}
int main(void){@autoreleasepool{
 check(@protocol(BatchQuitChatRoomLogicDelegate)!=nil,@"registered native protocol");
 reset();CSGroupChatQuitCoordinator*c=begin(45);NSArray *initial=c.results;[c beginNextBatch];check(submitted.count==1 && [submitted[0] rooms].count==20,@"first max20");check(countStatus(c,@"processing")==20 && countStatus(c,@"waiting")==25,@"first row states");check([initial[0][@"status"]isEqual:@"waiting"],@"immutable snapshots");[(BatchQuitChatRoomLogic*)submitted.lastObject completeSuccess];[c beginNextBatch];check(submitted.count==2 && [submitted[1] rooms].count==20,@"second20");[(BatchQuitChatRoomLogic*)submitted.lastObject completeSuccess];[c beginNextBatch];check(submitted.count==3 && [submitted[2] rooms].count==5,@"third5");[(BatchQuitChatRoomLogic*)submitted.lastObject completeSuccess];[c beginNextBatch];check(!c.running && countStatus(c,@"succeeded")==45,@"all45 succeeded");
 reset();preflight[@"0@chatroom"]=@"pending funds";c=begin(25);[c beginNextBatch];check(countStatus(c,@"needsAction")==1 && submitted.count==1,@"preflight blocked");[c stopFollowingBatches];check(c.running && countStatus(c,@"skipped")==4,@"stop waits active batch");[(BatchQuitChatRoomLogic*)submitted.lastObject completeSuccess];[c beginNextBatch];check(!c.running && submitted.count==1 && countStatus(c,@"succeeded")==20,@"stop forbids next batch");
 reset();c=begin(25);[c beginNextBatch];BatchQuitChatRoomLogic*engine=submitted.lastObject;NSMutableDictionary*failures=[NSMutableDictionary dictionary];for(NSString*r in engine.rooms)failures[r]=@"network";engine.running=NO;[engine.delegate batchQuitChatRoomLogic:engine didCompleteWithSuccessRooms:@[] failures:failures errorMessage:@"network" isNetworkError:YES];[c beginNextBatch];check(!c.running && countStatus(c,@"unknown")==20 && countStatus(c,@"skipped")==5 && submitted.count==1,@"network stops no retry");
 reset();c=begin(21);[c beginNextBatch];engine=submitted.lastObject;id oldDelegate=engine.delegate;activeAccount=@"other";accountEpoch++;[c checkEnvironment];check(!c.running && engine.cancelled && c.results.count==0,@"account switch cancels and hides");check([c.statusText isEqual:@"当前账号尚无退群结果"],@"account status hidden");[oldDelegate batchQuitChatRoomLogic:engine didSucceedRoom:@"0@chatroom"];check(c.results.count==0,@"stale callback cannot revive");
 reset();c=begin(21);[c beginNextBatch];engine=submitted.lastObject;c.deadline=0;[c checkEnvironment];[c beginNextBatch];check(!c.running && engine.cancelled && countStatus(c,@"unknown")==20 && countStatus(c,@"skipped")==1 && submitted.count==1,@"timeout unknown no retry");
 reset();c=begin(21);[c beginNextBatch];engine=submitted.lastObject;engine.running=NO;[engine.delegate batchQuitChatRoomLogic:engine didCompleteWithSuccessRooms:@[@"not-requested@chatroom"] failures:@{} errorMessage:nil isNetworkError:NO];[c beginNextBatch];check(countStatus(c,@"unknown")==20 && submitted.count==1,@"missing outcomes not successes");
 reset();c=begin(1);[c beginNextBatch];engine=submitted.lastObject;[engine.delegate batchQuitChatRoomLogic:engine didFailRoom:@"0@chatroom" errorMessage:@"denied"];engine.running=NO;[engine.delegate batchQuitChatRoomLogic:engine didCompleteWithSuccessRooms:engine.rooms failures:@{@"0@chatroom":@"denied"} errorMessage:nil isNetworkError:NO];check(!c.running && countStatus(c,@"unknown")==1,@"conflicting outcomes unknown");
 reset();c=begin(21);[c beginNextBatch];engine=submitted.lastObject;[departed addObject:@"0@chatroom"];[engine.delegate batchQuitChatRoomLogic:engine didSucceedRoom:@"0@chatroom"];check(countStatus(c,@"succeeded")==1,@"per-room success received");engine.running=NO;failures=[NSMutableDictionary dictionary];for(NSString*r in engine.rooms)failures[r]=@"denied";[engine.delegate batchQuitChatRoomLogic:engine didCompleteWithSuccessRooms:@[] failures:failures errorMessage:nil isNetworkError:NO];[c beginNextBatch];check(!c.running && countStatus(c,@"unknown")==1 && countStatus(c,@"skipped")==1 && submitted.count==1,@"earlier success final failure is unknown and stops");
 reset();c=begin(1);[c beginNextBatch];engine=submitted.lastObject;[engine.delegate batchQuitChatRoomLogic:engine didFailRoom:@"0@chatroom" errorMessage:@"denied"];engine.running=NO;[engine.delegate batchQuitChatRoomLogic:engine didCompleteWithSuccessRooms:engine.rooms failures:@{} errorMessage:nil isNetworkError:NO];check(!c.running && countStatus(c,@"unknown")==1,@"earlier failure final success is unknown");
 reset();c=begin(21);[c stopFollowingBatches];[c beginNextBatch];check(!c.running && submitted.count==0 && countStatus(c,@"skipped")==21,@"stop before submission");
 reset();c=[CSGroupChatQuitCoordinator new];nativeABI=NO;NSError*error=nil;check(![c startRoomIDs:rooms(1) clearHistory:NO account:activeAccount epoch:accountEpoch error:&error] && error && submitted.count==0,@"ABI missing fails closed");
 reset();c=begin(2);__block BOOL stopped=NO;id obs=[NSNotificationCenter.defaultCenter addObserverForName:CSGroupChatQuitDidChange object:c queue:nil usingBlock:^(NSNotification*n){if(!stopped && countStatus(c,@"processing")){stopped=YES;[c stopFollowingBatches];}}];[c beginNextBatch];check(!c.running && submitted.count==0 && countStatus(c,@"skipped")==2,@"synchronous stop notification prevents submit");[NSNotificationCenter.defaultCenter removeObserver:obs];
 fprintf(stdout,"PASS 12 coordinator scenarios; fake services only.\n");
}return 0;}
