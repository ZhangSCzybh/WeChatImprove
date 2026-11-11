#import "CSGroupChatNativeAdapter.h"
#import "CSMessageNativeActionAdapter.h"
#import "CSGroupNativeBridge.h"
#import "CSBackupBootstrap.h"
#import "CSAuthorizationManager.h"
#import <objc/runtime.h>
#include <string.h>

NSNotificationName const CSGroupChatQuitDidChange=@"CSGroupChatQuitDidChange";
static const NSTimeInterval CSGCQuitBatchTimeout=120;
static NSError *CSGCQuitError(NSInteger code, NSString *message) { return [NSError errorWithDomain:@"CSGroupChatQuit" code:code userInfo:@{NSLocalizedDescriptionKey:message}]; }
@class CSGCQuitBatchDelegate;
@interface CSGroupChatQuitCoordinator ()
@property(nonatomic,readwrite) BOOL running;
@property(nonatomic,copy,readwrite) NSArray<NSDictionary *> *results;
@property(nonatomic,copy,readwrite) NSString *statusText;
@property(nonatomic,strong) CSMessageNativeEnvironment *environment;
@property(nonatomic,strong) NSMutableArray<NSMutableDictionary *> *rows;
@property(nonatomic,copy) NSString *account;
@property(nonatomic) NSUInteger epoch, generation;
@property(nonatomic) BOOL clearHistory, stopRequested, batchSubmitted;
@property(nonatomic,strong) id engine;
@property(nonatomic,strong) CSGCQuitBatchDelegate *batchDelegate;
@property(nonatomic,copy) NSSet<NSString *> *batchNames;
@property(nonatomic,strong) dispatch_source_t gateTimer;
@property(nonatomic) NSTimeInterval deadline;
- (void)acceptSuccess:(id)engine room:(NSString *)room token:(CSGCQuitBatchDelegate *)token;
- (void)acceptFailure:(id)engine room:(NSString *)room message:(NSString *)message token:(CSGCQuitBatchDelegate *)token;
- (void)acceptComplete:(id)engine successes:(NSArray *)successes failures:(NSDictionary *)failures message:(NSString *)message networkError:(BOOL)networkError token:(CSGCQuitBatchDelegate *)token;
@end

// ABI verified against the supplied 8.0.80 BatchQuitChatRoomLogicDelegate:
// v32@0:8@16@24, v40@0:8@16@24@32, v52@0:8@16@24@32@40B48.
// A new delegate per batch also prevents an old callback borrowing a later run.
@interface CSGCQuitBatchDelegate : NSObject
@property(nonatomic,weak) CSGroupChatQuitCoordinator *owner;
@property(nonatomic) NSUInteger generation;
@end
@implementation CSGCQuitBatchDelegate
- (void)batchQuitChatRoomLogic:(id)logic didSucceedRoom:(NSString *)room {
    NSString *copied=[room isKindOfClass:NSString.class] ? [room copy] : nil;
    if (NSThread.isMainThread) [self.owner acceptSuccess:logic room:copied token:self];
    else dispatch_async(dispatch_get_main_queue(),^{ [self.owner acceptSuccess:logic room:copied token:self]; });
}
- (void)batchQuitChatRoomLogic:(id)logic didFailRoom:(NSString *)room errorMessage:(NSString *)message {
    NSString *copied=[room isKindOfClass:NSString.class] ? [room copy] : nil, *detail=[message isKindOfClass:NSString.class] ? [message copy] : nil;
    if (NSThread.isMainThread) [self.owner acceptFailure:logic room:copied message:detail token:self];
    else dispatch_async(dispatch_get_main_queue(),^{ [self.owner acceptFailure:logic room:copied message:detail token:self]; });
}
- (void)batchQuitChatRoomLogic:(id)logic didCompleteWithSuccessRooms:(NSArray *)successes failures:(NSDictionary *)failures errorMessage:(NSString *)message isNetworkError:(BOOL)networkError {
    NSArray *copied=[successes isKindOfClass:NSArray.class] ? [successes copy] : nil;
    NSDictionary *errors=[failures isKindOfClass:NSDictionary.class] ? [failures copy] : nil;
    NSString *detail=[message isKindOfClass:NSString.class] ? [message copy] : nil;
    if (NSThread.isMainThread) [self.owner acceptComplete:logic successes:copied failures:errors message:detail networkError:networkError token:self];
    else dispatch_async(dispatch_get_main_queue(),^{ [self.owner acceptComplete:logic successes:copied failures:errors message:detail networkError:networkError token:self]; });
}
@end

static BOOL CSGCProtocolMethod(Protocol *protocol, NSString *selector, NSArray<NSString *> *arguments) {
    struct objc_method_description description=protocol_getMethodDescription(protocol,NSSelectorFromString(selector),YES,YES);
    if (!description.name || !description.types) return NO;
    NSMethodSignature *signature=[NSMethodSignature signatureWithObjCTypes:description.types];
    if (!signature || signature.numberOfArguments!=arguments.count+2 || strcmp(signature.methodReturnType,"v")) return NO;
    for (NSUInteger i=0;i<arguments.count;i++) {
        const char *type=[signature getArgumentTypeAtIndex:i+2];
        if ([arguments[i] isEqual:@"B"]) { if (*type!='B' && *type!='c') return NO; }
        else if (strcmp(type,arguments[i].UTF8String)) return NO;
    }
    return YES;
}
static BOOL CSGCDelegateABIAvailable(void) {
    Protocol *protocol=NSProtocolFromString(@"BatchQuitChatRoomLogicDelegate");
    if (!protocol || !CSGCProtocolMethod(protocol,@"batchQuitChatRoomLogic:didSucceedRoom:",@[@"@",@"@"]) ||
        !CSGCProtocolMethod(protocol,@"batchQuitChatRoomLogic:didFailRoom:errorMessage:",@[@"@",@"@",@"@"]) ||
        !CSGCProtocolMethod(protocol,@"batchQuitChatRoomLogic:didCompleteWithSuccessRooms:failures:errorMessage:isNetworkError:",@[@"@",@"@",@"@",@"@",@"B"])) return NO;
    class_addProtocol(CSGCQuitBatchDelegate.class,protocol); return YES;
}

@implementation CSGroupChatQuitCoordinator
+ (instancetype)sharedCoordinator { static CSGroupChatQuitCoordinator *coordinator; static dispatch_once_t once; dispatch_once(&once,^{ coordinator=[self new]; }); return coordinator; }
- (instancetype)init {
    if ((self=[super init])) {
        _environment=[CSMessageNativeEnvironment new]; _rows=[NSMutableArray array]; _results=@[]; _statusText=@"尚未开始"; _batchNames=[NSSet set];
        for (NSString *name in @[@"CSBackupAccountChanged",UIApplicationDidBecomeActiveNotification]) [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(environmentChanged:) name:name object:nil];
    } return self;
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; if(_gateTimer)dispatch_source_cancel(_gateTimer); }
- (BOOL)resultsVisible {
    if (!self.account.length) return YES;
    if (!NSThread.isMainThread || !CSBackupIsReady() || CSBackupAccountIsSuspended() || self.epoch!=CSBackupAccountEpoch()) return NO;
    NSString *actual=[self.environment currentAccountID];
    return [actual isEqual:self.account] && self.epoch==CSBackupAccountEpoch() && !CSBackupAccountIsSuspended();
}
- (NSArray<NSDictionary *> *)results { return [self resultsVisible] ? _results : @[]; }
- (NSString *)statusText { return [self resultsVisible] ? _statusText : @"当前账号尚无退群结果"; }
- (BOOL)gateValid {
    if (!NSThread.isMainThread || !self.running || !self.account.length || !CSBackupIsReady() || CSBackupAccountIsSuspended() || self.epoch!=CSBackupAccountEpoch() || !CSAuthorizationManager.sharedManager.isAuthorized) return NO;
    NSString *actual=[self.environment currentAccountID];
    return self.running && [actual isEqual:self.account] && self.epoch==CSBackupAccountEpoch() && !CSBackupAccountIsSuspended() && CSBackupIsReady() && CSAuthorizationManager.sharedManager.isAuthorized;
}
- (void)notify {
    NSAssert(NSThread.isMainThread,@"Group quit state belongs to main");
    NSMutableArray *snapshot=[NSMutableArray arrayWithCapacity:self.rows.count];
    NSUInteger pending=0, succeeded=0, failed=0, needs=0, unknown=0, skipped=0;
    for (NSDictionary *row in self.rows) {
        [snapshot addObject:[row copy]]; NSString *status=row[@"status"];
        if ([status isEqual:@"waiting"] || [status isEqual:@"processing"]) pending++;
        else if ([status isEqual:@"succeeded"]) succeeded++;
        else if ([status isEqual:@"failed"]) failed++;
        else if ([status isEqual:@"needsAction"]) needs++;
        else if ([status isEqual:@"unknown"]) unknown++;
        else if ([status isEqual:@"skipped"]) skipped++;
    }
    self.results=[snapshot copy];
    NSString *prefix=self.running ? (self.stopRequested ? @"正等待当前批次结束，后续已停止" : @"正在退出") : @"处理结束";
    self.statusText=[NSString stringWithFormat:@"%@：成功%lu，失败%lu，需处理%lu，结果未知%lu，跳过%lu，待处理%lu",prefix,(unsigned long)succeeded,(unsigned long)failed,(unsigned long)needs,(unsigned long)unknown,(unsigned long)skipped,(unsigned long)pending];
    [NSNotificationCenter.defaultCenter postNotificationName:CSGroupChatQuitDidChange object:self];
}
- (NSMutableDictionary *)rowForRoom:(NSString *)room {
    if (![room isKindOfClass:NSString.class]) return nil;
    for (NSMutableDictionary *row in self.rows) if ([row[@"roomID"] isEqual:room]) return row; return nil;
}
- (void)setRoom:(NSString *)room status:(NSString *)status detail:(NSString *)detail {
    NSMutableDictionary *row=[self rowForRoom:room]; if (!row) return;
    detail=detail ?: @""; if ([row[@"status"] isEqual:status] && [row[@"detail"] isEqual:detail]) return;
    row[@"status"]=status; row[@"detail"]=detail; [self notify];
}
- (void)stopTimer { if (self.gateTimer) { dispatch_source_cancel(self.gateTimer); self.gateTimer=nil; } }
- (void)cancelOwnedEngine {
    id engine=self.engine; self.engine=nil; self.batchDelegate.owner=nil; self.batchDelegate=nil; self.batchNames=[NSSet set];
    @try { if (CSMessageNativeSupports(engine,@"cancel",@"v",@[])) CSMessageNativeInvoke(engine,@"cancel",@[]); } @catch (__unused NSException *exception) {}
}
- (void)finish {
    [self stopTimer]; self.running=NO; self.engine=nil; self.batchDelegate.owner=nil; self.batchDelegate=nil; self.batchNames=[NSSet set]; [self notify];
}
- (void)haltWithDetail:(NSString *)detail {
    if (!self.running) return;
    [self cancelOwnedEngine]; self.stopRequested=YES;
    for (NSMutableDictionary *row in [self.rows copy]) {
        if ([row[@"status"] isEqual:@"processing"]) [self setRoom:row[@"roomID"] status:self.batchSubmitted?@"unknown":@"skipped" detail:self.batchSubmitted?detail:@"运行状态已改变，本批未提交退出。"]; 
        else if ([row[@"status"] isEqual:@"waiting"]) [self setRoom:row[@"roomID"] status:@"skipped" detail:@"后续批次已停止，未提交退出。"]; 
    }
    [self finish];
}
- (void)environmentChanged:(NSNotification *)note {
    (void)note;
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self checkEnvironment]; }); return; }
    [self checkEnvironment];
}
- (void)checkEnvironment {
    if (!self.running) return;
    if (![self gateValid]) { [self haltWithDetail:@"账号、授权或数据恢复状态已改变，当前批次结果未确认；请在原账号检查，不会自动重试。"]; return; }
    if (self.engine && NSProcessInfo.processInfo.systemUptime>=self.deadline) [self haltWithDetail:@"等待微信响应超时，退出结果未知；不会自动重试，请在微信群资料页检查。"]; 
}
- (void)startTimer {
    [self stopTimer]; self.gateTimer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,dispatch_get_main_queue());
    dispatch_source_set_timer(self.gateTimer,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC/2),NSEC_PER_SEC/2,50*NSEC_PER_MSEC);
    __weak typeof(self) weakSelf=self; dispatch_source_set_event_handler(self.gateTimer,^{ [weakSelf checkEnvironment]; }); dispatch_resume(self.gateTimer);
}
- (id)newNativeEngine {
    if (!CSGCDelegateABIAvailable()) return nil;
    Class cls=NSClassFromString(@"BatchQuitChatRoomLogic"); if (!cls || ![cls isSubclassOfClass:NSObject.class]) return nil;
    id allocated=[cls alloc]; if (!CSMessageNativeSupports(allocated,@"init",@"@",@[])) return nil;
    id engine=CSMessageNativeInvoke(allocated,@"init",@[]);
    if (![engine isKindOfClass:cls] || !CSMessageNativeSupports(engine,@"setDelegate:",@"v",@[@"@"]) ||
        !CSMessageNativeSupports(engine,@"startWithRoomNames:clearHistory:",@"v",@[@"@",@"B"]) ||
        !CSMessageNativeSupports(engine,@"cancel",@"v",@[]) || !CSMessageNativeSupports(engine,@"running",@"B",@[])) return nil;
    return engine;
}
- (BOOL)startRoomIDs:(NSArray<NSString *> *)roomIDs clearHistory:(BOOL)clearHistory account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    if (!NSThread.isMainThread) { if(error)*error=CSGCQuitError(1,@"请在主线程开始批量退群。"); return NO; }
    if (self.running) { if(error)*error=CSGCQuitError(2,@"已有退群批次正在处理，请等待其结束。"); return NO; }
    if (![roomIDs isKindOfClass:NSArray.class] || ![account isKindOfClass:NSString.class] || !account.length) { if(error)*error=CSGCQuitError(3,@"请选择需要退出的群聊。"); return NO; }
    NSMutableOrderedSet *unique=[NSMutableOrderedSet orderedSet];
    for (id room in roomIDs) {
        if (![room isKindOfClass:NSString.class] || ![room length]) { if(error)*error=CSGCQuitError(4,@"群聊名单包含无法识别的项目，请重新选择。"); return NO; }
        [unique addObject:[room copy]];
    }
    if (!unique.count) { if(error)*error=CSGCQuitError(3,@"请选择需要退出的群聊。"); return NO; }
    // Do not discard a previous result screen until every non-destructive
    // prerequisite for starting a new run has been validated.
    if (!CSBackupIsReady() || CSBackupAccountIsSuspended() || epoch!=CSBackupAccountEpoch() || !CSAuthorizationManager.sharedManager.isAuthorized || ![[self.environment currentAccountID] isEqual:account] || epoch!=CSBackupAccountEpoch()) {
        if(error)*error=CSGCQuitError(5,@"账号、授权或数据恢复状态已改变，请重新进入批量退群页面。"); return NO;
    }
    id probe=nil; @try { probe=[self newNativeEngine]; } @catch (__unused NSException *exception) {}
    if (!probe) { if(error)*error=CSGCQuitError(6,@"当前微信缺少已验证的批量退群接口，请使用微信群资料页退出。"); return NO; }
    self.generation++; self.account=[account copy]; self.epoch=epoch; self.clearHistory=clearHistory; self.stopRequested=NO; self.running=YES; self.rows=[NSMutableArray array];
    for (NSString *room in unique) [self.rows addObject:[@{@"roomID":room,@"name":CSGroupChatRoomName(room),@"status":@"waiting",@"detail":@"等待退出前检查"} mutableCopy]];
    [self notify]; if (!self.running) return YES; [self startTimer];
    NSUInteger generation=self.generation;
    // Give the UI its initial immutable result snapshot before native work.
    dispatch_async(dispatch_get_main_queue(),^{ if(self.running && self.generation==generation)[self beginNextBatch]; });
    return YES;
}
- (void)beginNextBatch {
    if (!self.running || self.engine) return;
    if (![self gateValid]) { [self haltWithDetail:@"账号、授权或数据恢复状态已改变，当前批次结果未确认。"]; return; }
    if (self.stopRequested) { [self finish]; return; }
    NSMutableArray<NSString *> *batch=[NSMutableArray arrayWithCapacity:20];
    for (NSDictionary *row in [self.rows copy]) {
        if (![row[@"status"] isEqual:@"waiting"]) continue;
        NSString *room=row[@"roomID"], *reason=CSGroupChatQuitPreflight(room,self.account);
        if (![self gateValid]) { [self haltWithDetail:@"账号、授权或数据恢复状态已改变，未继续提交。"]; return; }
        if (self.stopRequested) { [self finish]; return; }
        if (reason.length) [self setRoom:room status:@"needsAction" detail:reason];
        else [batch addObject:room];
        if (batch.count==20) break;
    }
    if (!self.running) return;
    if (![self gateValid]) { [self haltWithDetail:@"账号、授权或数据恢复状态已改变，未继续提交。"]; return; }
    if (self.stopRequested) { [self finish]; return; }
    if (!batch.count) { [self finish]; return; }
    id engine=nil; @try { engine=[self newNativeEngine]; } @catch (__unused NSException *exception) {}
    if (!engine) {
        for (NSString *room in batch) [self setRoom:room status:@"needsAction" detail:@"当前微信的原生批量退出接口不可用，请在群资料页处理。"];
        [self stopFollowingBatches]; [self finish]; return;
    }
    CSGCQuitBatchDelegate *token=[CSGCQuitBatchDelegate new]; token.owner=self; token.generation=self.generation;
    self.engine=engine; self.batchDelegate=token; self.batchNames=[NSSet setWithArray:batch]; self.batchSubmitted=NO; self.deadline=NSProcessInfo.processInfo.systemUptime+CSGCQuitBatchTimeout;
    for (NSString *room in batch) [self setRoom:room status:@"processing" detail:@"正在提交微信原生退出流程，等待逐群结果。"];
    __block BOOL handedOff=NO;
    @try {
        CSBackupPerformAtAccountEpoch(self.epoch,^{
            if (![self gateValid] || self.engine!=engine || self.batchDelegate!=token || token.generation!=self.generation) return;
            CSMessageNativeInvoke(engine,@"setDelegate:",@[token]);
            if (![self gateValid] || self.engine!=engine || self.batchDelegate!=token) return;
            // No wrapper retries: the native engine owns its bounded retries.
            if (self.stopRequested) return;
            handedOff=YES; self.batchSubmitted=YES; CSMessageNativeInvoke(engine,@"startWithRoomNames:clearHistory:",@[batch,@(self.clearHistory)]);
        });
        if (!handedOff) { [self haltWithDetail:@"账号或运行状态已改变，本批未确认提交；请在群资料页检查。"]; return; }
        // A synchronous completion may already have retired this engine.
        if (self.engine==engine && ![CSMessageNativeInvoke(engine,@"running",@[]) boolValue]) [self haltWithDetail:@"原生退出流程未返回完整结果；不会自动重试，请在群资料页检查。"]; 
    } @catch (__unused NSException *exception) { [self haltWithDetail:@"微信原生退出流程异常，当前批次结果未知；不会自动重试，请在群资料页检查。"]; }
}
- (void)stopFollowingBatches {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self stopFollowingBatches]; }); return; }
    if (!self.running) return;
    self.stopRequested=YES;
    for (NSDictionary *row in [self.rows copy]) if ([row[@"status"] isEqual:@"waiting"]) [self setRoom:row[@"roomID"] status:@"skipped" detail:@"已停止后续批次，未提交退出。"];
    // Already submitted native requests cannot be undone. Let this batch settle.
    [self notify]; if(!self.engine)[self finish];
}
- (BOOL)isQuittingRoom:(NSString *)roomID {
    if (!NSThread.isMainThread || !self.running || ![self gateValid]) return NO;
    NSDictionary *row=[self rowForRoom:roomID]; return [row[@"status"] isEqual:@"waiting"] || [row[@"status"] isEqual:@"processing"];
}
- (BOOL)acceptsEngine:(id)engine token:(CSGCQuitBatchDelegate *)token {
    if (!self.running || !engine || self.engine!=engine || self.batchDelegate!=token || token.generation!=self.generation) return NO;
    if (![self gateValid]) { [self haltWithDetail:@"账号、授权或数据恢复状态已改变，当前批次结果未确认；不会自动重试。"]; return NO; }
    return self.engine==engine && self.batchDelegate==token && self.running;
}
- (void)acceptSuccess:(id)engine room:(NSString *)room token:(CSGCQuitBatchDelegate *)token {
    if (!room.length || ![self acceptsEngine:engine token:token] || ![self.batchNames containsObject:room]) return;
    NSDictionary *row=[self rowForRoom:room];
    if (![@[@"processing",@"succeeded",@"unknown"] containsObject:row[@"status"]]) return;
    @try {
        id groups=[self.environment serviceNamed:@"CGroupMgr"];
        if (!CSMessageNativeSupports(groups,@"IsUsrInChatRoom:Usr:",@"B",@[@"@",@"@"])) { [self setRoom:room status:@"unknown" detail:@"微信返回成功，但无法验证本地成员状态；请在群资料页检查，不会重试。"]; return; }
        BOOL stillMember=[CSMessageNativeInvoke(groups,@"IsUsrInChatRoom:Usr:",@[room,self.account]) boolValue];
        if (![self acceptsEngine:engine token:token]) return;
        [self setRoom:room status:stillMember?@"unknown":@"succeeded" detail:stillMember?@"微信返回成功，但本地仍显示在群中；请检查，不会自动重试。":(self.clearHistory?@"微信已确认退出；清理聊天记录已交由原生流程处理。":@"微信已确认退出，保留聊天记录。")];
    } @catch (__unused NSException *exception) { [self setRoom:room status:@"unknown" detail:@"微信返回成功，但本地状态未确认；请检查，不会自动重试。"]; }
}
- (void)acceptFailure:(id)engine room:(NSString *)room message:(NSString *)message token:(CSGCQuitBatchDelegate *)token {
    if (!room.length || ![self acceptsEngine:engine token:token] || ![self.batchNames containsObject:room]) return;
    NSDictionary *row=[self rowForRoom:room]; if(![row[@"status"] isEqual:@"processing"])return;
    [self setRoom:room status:@"failed" detail:message.length?message:@"微信返回退出失败；请在群资料页处理。"];
}
- (void)acceptComplete:(id)engine successes:(NSArray *)successes failures:(NSDictionary *)failures message:(NSString *)message networkError:(BOOL)networkError token:(CSGCQuitBatchDelegate *)token {
    if (![self acceptsEngine:engine token:token]) return;
    NSSet *requested=[self.batchNames copy];
    NSMutableSet *successSet=[NSMutableSet set];
    for (id room in successes) if ([room isKindOfClass:NSString.class] && [requested containsObject:room]) [successSet addObject:room];
    for (NSString *room in requested) {
        if (![self acceptsEngine:engine token:token]) return;
        NSDictionary *row=[self rowForRoom:room];
        if ([successSet containsObject:room] && !failures[room]) {
            if ([row[@"status"] isEqual:@"failed"]) [self setRoom:room status:@"unknown" detail:@"微信逐群回调与最终结果不一致；不会自动重试，请在群资料页检查。"];
            else [self acceptSuccess:engine room:room token:token];
        }
        else if (failures[room] && ![successSet containsObject:room]) {
            id value=failures[room]; NSString *reason=[value isKindOfClass:NSString.class] ? value : message;
            if ([row[@"status"] isEqual:@"succeeded"] || [row[@"status"] isEqual:@"unknown"]) [self setRoom:room status:@"unknown" detail:@"微信逐群回调与最终结果不一致；不会自动重试，请在群资料页检查。"];
            else if (networkError) [self setRoom:room status:@"unknown" detail:@"网络响应未确认，退出结果未知；不会自动重试，请在群资料页检查。"];
            else [self setRoom:room status:@"failed" detail:reason.length?reason:@"微信返回退出失败；请在群资料页处理。"];
        } else if ([row[@"status"] isEqual:@"processing"] || ([successSet containsObject:room] && failures[room])) {
            [self setRoom:room status:@"unknown" detail:@"微信未返回一致的逐群结果；不会自动重试，请在群资料页检查。"];
        } else if (networkError && [row[@"status"] isEqual:@"failed"]) [self setRoom:room status:@"unknown" detail:@"网络响应未确认，退出结果未知；不会自动重试，请在群资料页检查。"];
    }
    if (![self acceptsEngine:engine token:token]) return;
    self.engine=nil; self.batchDelegate.owner=nil; self.batchDelegate=nil; self.batchNames=[NSSet set];
    // An ambiguous or network outcome ends the run. Re-submitting could quit a
    // room that the server has already processed, including after a rejoin.
    BOOL ambiguous=networkError;
    for (NSString *room in requested) if ([[self rowForRoom:room][@"status"] isEqual:@"unknown"]) ambiguous=YES;
    if (ambiguous) self.stopRequested=YES;
    if (self.stopRequested) { [self stopFollowingBatches]; if(self.running)[self finish]; return; }
    NSUInteger generation=self.generation;
    dispatch_async(dispatch_get_main_queue(),^{ if(self.running && self.generation==generation)[self beginNextBatch]; });
}
@end
