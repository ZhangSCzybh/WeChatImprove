#import "CSMessageActionCoordinator.h"
#import "CSMessageSendAdapter.h"
#import "CSVoiceForwardAdapter.h"
#import <TargetConditionals.h>
#include <stdatomic.h>
@interface CSMessageActionCoordinator (CSAccountBoundary)
- (void)synchronizeAccountBoundary;
@end
static atomic_uint_fast64_t CSActionAccountBoundary=0;
static void CSMarkAccountBoundary(BOOL suspended) {
    uint_fast64_t old=atomic_load_explicit(&CSActionAccountBoundary,memory_order_acquire), next;
    do { next=((old+2)&~(uint_fast64_t)1) | (suspended ? 1 : 0); } while (!atomic_compare_exchange_weak_explicit(&CSActionAccountBoundary,&old,next,memory_order_acq_rel,memory_order_acquire));
    dispatch_async(dispatch_get_main_queue(),^{ [CSMessageActionCoordinator.sharedCoordinator synchronizeAccountBoundary]; });
}
void CSMessageActionAccountWillChangeAtNativeBoundary(void) { CSMarkAccountBoundary(YES); }
void CSMessageActionAccountDidChangeAtNativeBoundary(void) { CSMarkAccountBoundary(NO); }
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#endif
@interface CSMessageActionOperation : NSObject
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, strong) CSMessageActionContext *context;
@property(nonatomic) CSMessageAction action;
@property(nonatomic) CSMessageActionEntry entry;
@property(nonatomic, strong) CSMessageActionSubmissionLedger *ledger;
@property(nonatomic, copy) NSArray<NSString *> *targets;
@property(nonatomic, strong) NSMutableSet<NSString *> *requestedTargets;
@property(nonatomic, strong) NSMutableSet<NSString *> *normalNativeHandoffs;
@property(nonatomic, strong) NSMutableArray<CSMessagePreparedSend *> *leases;
@property(nonatomic, strong) CSMessageVoiceResource *voice;
@property(nonatomic, weak) id logic;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL mediaFailed;
@property(nonatomic, copy) NSString *failureDetail;
@property(nonatomic, copy) NSData *appData;
@property(nonatomic, copy) NSString *appPath;
@property(nonatomic) BOOL nativeFinished;
@property(nonatomic) BOOL enhanced;
@property(nonatomic) BOOL feedbackShown;
@end
@implementation CSMessageActionOperation
@end
// Only plugin confirmation UI needs a cancellable native-action context. This
// does not own media, recipients, a submission ledger or an expiry callback.
@interface CSMessageActionConfirmation : NSObject
@property(nonatomic, strong) CSMessageActionContext *context;
@property(nonatomic) CSMessageAction action;
@property(nonatomic) CSMessageActionEntry entry;
@property(nonatomic) BOOL finished;
@end
@implementation CSMessageActionConfirmation
@end
@interface CSMessageActionCoordinator ()
@property(nonatomic, strong) id<CSMessageActionEnvironment> environment;
@property(nonatomic, strong) CSMessageActionPreferences *preferences;
@property(nonatomic, strong) CSMessageMediaProvider *media;
@property(nonatomic, strong) CSMessageSendAdapter *sender;
@property(nonatomic, strong) CSMessageNativeActionAdapter *native;
@property(nonatomic, strong) CSVoiceForwardAdapter *forward;
@property(nonatomic, strong) NSMutableDictionary<NSString *, CSMessageActionOperation *> *operations;
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSDictionary *> *completed;
@property(nonatomic, strong) NSMutableArray<NSString *> *completedOrder;
@property(nonatomic, strong) NSMutableArray<NSDictionary *> *pendingFeedback;
@property(nonatomic, copy) NSString *accountID;
@property(nonatomic) NSUInteger accountEpoch;
@property(nonatomic) BOOL accountSuspended;
@property(nonatomic) uint_fast64_t boundaryToken;
@property(nonatomic, strong) CSMessageActionOperation *openingForwardOperation;
@property(nonatomic, strong) NSHashTable<CSMessageActionConfirmation *> *confirmations;
@property(nonatomic, strong) id settingsObserver;
#if TARGET_OS_IOS
@property(nonatomic, strong) NSMutableDictionary<NSString *, UIView *> *waitingViews;
#endif
@end
@implementation CSMessageActionCoordinator
+ (instancetype)sharedCoordinator { static CSMessageActionCoordinator *coordinator; static dispatch_once_t once; dispatch_once(&once,^{ coordinator=[[self alloc] initWithEnvironment:[CSMessageNativeEnvironment new] preferences:CSMessageActionPreferences.sharedPreferences mediaProvider:[CSMessageMediaProvider new]]; }); return coordinator; }
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment preferences:(CSMessageActionPreferences *)preferences mediaProvider:(CSMessageMediaProvider *)provider {
    return [self initWithEnvironment:environment preferences:preferences mediaProvider:provider sendAdapter:[[CSMessageSendAdapter alloc] initWithEnvironment:environment] nativeAdapter:[CSMessageNativeActionAdapter new]];
}
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment preferences:(CSMessageActionPreferences *)preferences mediaProvider:(CSMessageMediaProvider *)provider sendAdapter:(CSMessageSendAdapter *)sender nativeAdapter:(CSMessageNativeActionAdapter *)native {
    if ((self=[super init])) {
        _environment=environment;
#if TARGET_OS_IOS
        _waitingViews=[NSMutableDictionary dictionary];
#endif
        _preferences=preferences; _media=provider; _sender=sender; _native=native; _forward=[CSVoiceForwardAdapter new];
        _operations=[NSMutableDictionary dictionary]; _completed=[NSMutableDictionary dictionary]; _completedOrder=[NSMutableArray array]; _pendingFeedback=[NSMutableArray array]; _accountEpoch=1; _boundaryToken=atomic_load_explicit(&CSActionAccountBoundary,memory_order_acquire); _accountSuspended=(_boundaryToken&1)!=0; _accountID=_accountSuspended ? nil : [environment.currentAccountID copy];
        __weak typeof(self) weakSelf=self;
        provider.waitingHandler=^(NSString *identifier){ [weakSelf showWaiting:identifier]; };
        provider.failureHandler=^(NSString *identifier, NSString *reason){ weakSelf.operations[identifier].failureDetail=[@"语音读取或校验失败：" stringByAppendingString:reason]; };
        provider.recordingState=^NSNumber *(CSMessageActionContext *context){
            typeof(self) self=weakSelf; if (!self || ![self validAccount:context]) return nil;
            id audio=[self.environment serviceNamed:@"AudioSender"];
            @try { if (CSMessageNativeSupports(audio,@"isRecording",@"B",@[])) return CSMessageNativeInvoke(audio,@"isRecording",@[]); }
            @catch (__unused NSException *exception) {}
            return nil;
        };
        provider.requestDownload=^(CSMessageActionContext *context){ typeof(self) self=weakSelf; if (!self || ![self validAccount:context]) return NO;
            id downloader=[self.environment serviceNamed:@"VoiceMsgDownloader"];
            @try { if (CSMessageNativeSupports(downloader,@"downloadMsg:",@"v",@[@"@"])) { CSMessageNativeInvoke(downloader,@"downloadMsg:",@[context.sourceWrap]); return YES; } } @catch (__unused NSException *exception) {}
            return NO;
        };
        provider.refreshSource=^id(CSMessageActionContext *context){
            typeof(self) self=weakSelf; if (!self || ![self validAccount:context]) return nil;
            id manager=[self.environment serviceNamed:@"CMessageMgr"];
            @try { if (CSMessageNativeSupports(manager,@"GetMsg:LocalID:",@"@",@[@"@",@"I"])) return CSMessageNativeInvoke(manager,@"GetMsg:LocalID:",@[context.sourceConversationID,@(context.localID)]); } @catch (__unused NSException *exception) {}
            return nil;
        };
        _settingsObserver=[NSNotificationCenter.defaultCenter addObserverForName:CSMessageActionSettingsDidChangeNotification object:preferences queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){ [weakSelf settingsChanged]; }];
    } return self;
}
- (void)dealloc { if (_settingsObserver) [NSNotificationCenter.defaultCenter removeObserver:_settingsObserver]; }
- (CSMessageActionSettings *)settings { return _preferences.snapshot; }
- (void)synchronizeAccountBoundary {
    uint_fast64_t token=atomic_load_explicit(&CSActionAccountBoundary,memory_order_acquire);
    if (token==_boundaryToken) return;
    _boundaryToken=token; _accountSuspended=(token&1)!=0; _accountEpoch++; [_pendingFeedback removeAllObjects]; _accountID=_accountSuspended ? nil : [[_environment currentAccountID] copy];
    [self cancelAllUnsubmittedOperations];
}
- (void)refreshAccount {
    [self synchronizeAccountBoundary];
    if (_accountSuspended) return;
    NSString *account=[_environment currentAccountID]; if (![_accountID isEqualToString:account] && (_accountID || account)) [self accountDidChange];
}
- (void)accountWillChange { NSAssert(NSThread.isMainThread,@"Account lifecycle is main owned"); _accountSuspended=YES; _accountEpoch++; [_pendingFeedback removeAllObjects]; _accountID=nil; [self cancelAllUnsubmittedOperations]; }
- (void)accountDidChange { _accountSuspended=NO; NSAssert(NSThread.isMainThread,@"Account lifecycle is main owned"); [self cancelAllUnsubmittedOperations]; _accountEpoch++; [_pendingFeedback removeAllObjects]; _accountID=[[_environment currentAccountID] copy]; }
- (BOOL)validAccount:(CSMessageActionContext *)context { [self refreshAccount]; return !_accountSuspended && !(atomic_load_explicit(&CSActionAccountBoundary,memory_order_acquire)&1) && [context isValidForAccountID:_accountID epoch:_accountEpoch]; }
- (CSMessageActionContext *)captureContextForCell:(id)cell controller:(id)controller bindingGeneration:(NSUInteger)generation {
    if (!NSThread.isMainThread) return nil; [self refreshAccount];
    CSMessageActionContext *context=[CSMessageActionContext contextWithCell:cell controller:controller ?: [_environment controllerForCell:cell] accountID:_accountID accountEpoch:_accountEpoch conversationID:nil bindingGeneration:generation];
#if TARGET_OS_IOS
    UIViewController *page=context.controller;
    if (page.isViewLoaded && page.view.window && !page.presentedViewController) {
        for (NSDictionary *item in _pendingFeedback.copy) {
            if ([item[@"account"] isEqual:context.accountID] && [item[@"epoch"] unsignedIntegerValue]==context.accountEpoch && [item[@"chat"] isEqual:context.sourceConversationID]) { [_pendingFeedback removeObject:item]; [self feedback:item[@"message"] context:context]; }
        }
    }
#endif
    return context;
}
- (BOOL)validateContext:(CSMessageActionContext *)context {
    if (!NSThread.isMainThread || ![self validAccount:context] || !context.cell || !context.controller) return NO;
    CSMessageActionContext *current=[CSMessageActionContext contextWithCell:context.cell controller:context.controller accountID:_accountID accountEpoch:_accountEpoch conversationID:context.sourceConversationID bindingGeneration:context.bindingGeneration];
    return current && [context matchesSourceContext:current];
}
- (BOOL)canExecuteContext:(CSMessageActionContext *)context action:(CSMessageAction)action entry:(CSMessageActionEntry)entry {
    if (![self validateContext:context] || !CSMessageActionEntryAllows(self.settings,entry,action)) return NO;
    if (action==CSMessageActionRepeat) {
        if (context.messageType==10000 || context.messageType==10002) return NO;
        if (entry==CSMessageActionEntryMenuRepeat && !CSMessageActionSupportsRepeatMenuType(context.messageType)) return NO;
        return YES; // Capability preparation is deferred; no media/service lookup in gesture admission.
    }
    return [_native canPerformAction:action context:context];
}
- (void)showWaiting:(NSString *)identifier {
    CSMessageActionOperation *op=_operations[identifier]; if (!op || op.cancelled) return;
    if (_feedbackHandler) { _feedbackHandler(@"正在下载语音，完成后继续；可取消本次操作。"); return; }
#if TARGET_OS_IOS
    if (_waitingViews[identifier]) return;
    UIViewController *controller=op.context.controller;
    while (controller.presentedViewController) controller=controller.presentedViewController;
    if (!controller.isViewLoaded || !controller.view.window) return;
    UIView *panel=[[UIView alloc] initWithFrame:CGRectMake(20,MAX(80,controller.view.safeAreaInsets.top+16),controller.view.bounds.size.width-40,96)]; panel.backgroundColor=[UIColor colorWithWhite:0 alpha:0.85]; panel.layer.cornerRadius=10;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(12,8,panel.bounds.size.width-24,40)]; label.text=@"正在下载语音，完成后继续本次操作"; label.textColor=UIColor.whiteColor; label.font=[UIFont systemFontOfSize:14]; label.numberOfLines=2; [panel addSubview:label];
    __weak typeof(self) weakSelf=self;
    UIButton *cancel=[UIButton buttonWithType:UIButtonTypeSystem primaryAction:[UIAction actionWithTitle:@"取消本次操作" image:nil identifier:nil handler:^(__unused UIAction *action){ [weakSelf cancelOperationID:identifier]; }]]; cancel.frame=CGRectMake(12,52,panel.bounds.size.width-24,36); [panel addSubview:cancel]; [controller.view addSubview:panel]; _waitingViews[identifier]=panel;
#endif
}
- (void)hideWaiting:(NSString *)identifier {
#if TARGET_OS_IOS
    [_waitingViews[identifier] removeFromSuperview]; [_waitingViews removeObjectForKey:identifier];
#else
    (void)identifier;
#endif
}
- (void)feedback:(NSString *)message context:(CSMessageActionContext *)context {
    if (_feedbackHandler) { _feedbackHandler(message); return; }
#if TARGET_OS_IOS
    UIViewController *controller=context.controller;
    while (controller.presentedViewController) controller=controller.presentedViewController;
    if (![controller isKindOfClass:UIViewController.class] || !controller.isViewLoaded || !controller.view.window) {
        [_pendingFeedback addObject:@{@"account":context.accountID ?: @"",@"epoch":@(context.accountEpoch),@"chat":context.sourceConversationID ?: @"",@"message":message}];
        while (_pendingFeedback.count>32) [_pendingFeedback removeObjectAtIndex:0];
        return;
    }
    UILabel *label=[UILabel new]; label.text=message; label.numberOfLines=0; label.textAlignment=NSTextAlignmentCenter; label.font=[UIFont systemFontOfSize:14]; label.textColor=UIColor.whiteColor; label.backgroundColor=[UIColor colorWithWhite:0 alpha:0.8]; label.layer.cornerRadius=8; label.clipsToBounds=YES;
    CGFloat width=MIN(controller.view.bounds.size.width-40,340); CGSize size=[label sizeThatFits:CGSizeMake(width-24,CGFLOAT_MAX)]; label.frame=CGRectMake((controller.view.bounds.size.width-width)/2,controller.view.bounds.size.height/2,width,size.height+24); [controller.view addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,4*NSEC_PER_SEC),dispatch_get_main_queue(),^{ [label removeFromSuperview]; });
#else
    (void)message; (void)context;
#endif
}
- (CSMessageActionOperation *)createOperation:(CSMessageActionContext *)context action:(CSMessageAction)action entry:(CSMessageActionEntry)entry {
    if (_operations.count>=32) { [self feedback:@"待处理操作较多，请稍后再试。" context:context]; return nil; }
    CSMessageActionOperation *op=[CSMessageActionOperation new]; op.identifier=NSUUID.UUID.UUIDString; op.context=context; op.action=action; op.entry=entry; op.requestedTargets=[NSMutableSet set]; op.normalNativeHandoffs=[NSMutableSet set]; op.leases=[NSMutableArray array]; _operations[op.identifier]=op;
    __weak typeof(self) weakSelf=self; NSString *identifier=op.identifier;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,180*NSEC_PER_SEC),dispatch_get_main_queue(),^{ typeof(self) self=weakSelf; CSMessageActionOperation *live=self.operations[identifier]; if (live) { [self cancelOperationID:identifier]; [self.forward detachLogic:live.logic]; [self retire:live]; } });
    return op;
}
- (void)registerTargets:(NSArray<NSString *> *)targets operation:(CSMessageActionOperation *)op {
    if (op.ledger) return; op.targets=[targets copy]; op.ledger=[[CSMessageActionSubmissionLedger alloc] initWithAccountID:op.context.accountID accountEpoch:op.context.accountEpoch]; [op.ledger registerOperationID:op.identifier targetIDs:targets];
    for (NSString *target in targets) [op.ledger transitionOperationID:op.identifier targetID:target toState:op.context.messageType==34 ? CSMessageActionSubmissionStateWaitingForMedia : CSMessageActionSubmissionStateReady];
}
- (void)performNativeAction:(CSMessageAction)action context:(CSMessageActionContext *)context entry:(CSMessageActionEntry)entry {
    CSMessageActionConfirmation *confirmation=nil;
    if (action==CSMessageActionDelete || action==CSMessageActionRevoke) {
        confirmation=[CSMessageActionConfirmation new]; confirmation.context=context; confirmation.action=action; confirmation.entry=entry;
        if (!_confirmations) _confirmations=[NSHashTable weakObjectsHashTable];
        [_confirmations addObject:confirmation];
    }
    __weak typeof(self) weakSelf=self;
    [_native performAction:action context:context valid:^BOOL{
        return !confirmation.finished && CSMessageActionEntryAllows(weakSelf.settings,entry,action) && [weakSelf validateContext:context];
    } completion:^(__unused CSMessageActionSubmissionState state){
        if (confirmation) { confirmation.finished=YES; [weakSelf.confirmations removeObject:confirmation]; }
    }];
}
- (NSString *)executeContext:(CSMessageActionContext *)context action:(CSMessageAction)action entry:(CSMessageActionEntry)entry {
    if (![self canExecuteContext:context action:action entry:entry]) { [self feedback:@"消息或当前操作已失效，未执行。" context:context]; return nil; }
    BOOL enhancedForward=CSMessageActionUsesVoiceEnhancement(self.settings,entry,action,context.messageType);
    if (action!=CSMessageActionRepeat && !enhancedForward) {
        [self performNativeAction:action context:context entry:entry];
        return nil; // Native owns the action; no plugin send operation was created.
    }
    CSMessageActionOperation *op=[self createOperation:context action:action entry:entry]; if (!op) return nil;
    if (action==CSMessageActionRepeat) {
        [self registerTargets:@[context.sourceConversationID] operation:op]; [op.requestedTargets addObject:context.sourceConversationID];
        if (context.messageType==34) [self prepareVoice:op];
        else if (context.messageType==49) {
            __weak typeof(self) weakSelf=self; NSString *identifier=op.identifier;
            [_media prepareAppDataForContext:context operationID:identifier completion:^(NSData *data, NSString *path){ typeof(self) self=weakSelf; CSMessageActionOperation *live=self.operations[identifier]; if (!live || live.cancelled || ![self validAccount:live.context]) return; live.appData=data; live.appPath=path; [self submitTarget:context.sourceConversationID operation:live]; }];
        } else dispatch_async(dispatch_get_main_queue(),^{ [self submitTarget:context.sourceConversationID operation:op]; });
    } else if (action==CSMessageActionForward) {
        CSMessageActionOperation *previous=_openingForwardOperation; _openingForwardOperation=op;
        __weak typeof(self) weakSelf=self;
        @try { [_native performAction:action context:context valid:^BOOL{ return [weakSelf validateContext:context] && !op.cancelled; } completion:^(__unused CSMessageActionSubmissionState state){}]; }
        @finally { _openingForwardOperation=previous; }
        if (!op.logic) [self retire:op];
    }
    return op.identifier;
}
- (void)prepareVoice:(CSMessageActionOperation *)op {

    __weak typeof(self) weakSelf=self; NSString *identifier=op.identifier;
    [_media prepareVoiceForContext:op.context operationID:identifier completion:^(CSMessageVoiceResource *resource){
        typeof(self) self=weakSelf; CSMessageActionOperation *live=self.operations[identifier];
        if (!live || live.cancelled || ![self validAccount:live.context]) return;
        [self hideWaiting:identifier]; live.voice=resource; live.mediaFailed=!resource;
        for (NSString *target in live.requestedTargets.allObjects) [self submitTarget:target operation:live];
    }];
}
- (void)submitTarget:(NSString *)target operation:(CSMessageActionOperation *)op {
    if (_operations[op.identifier]!=op || op.cancelled || ![self validAccount:op.context] || ![op.targets containsObject:target]) return;
    CSMessageActionSubmissionState state=[op.ledger stateForOperationID:op.identifier targetID:target];
    if (state!=CSMessageActionSubmissionStateWaitingForMedia && state!=CSMessageActionSubmissionStateReady && state!=CSMessageActionSubmissionStatePreparing) return;
    if (op.context.messageType==34 && !op.voice && !op.mediaFailed) return;
    if (op.mediaFailed) { if (!op.failureDetail.length) op.failureDetail=@"语音读取或校验失败"; [op.ledger transitionOperationID:op.identifier targetID:target toState:CSMessageActionSubmissionStateFailedBeforeAcceptance]; [self reportIfFinished:op]; return; }
    CSMessagePreparedSend *route=op.context.messageType==49 ? [_sender prepareContext:op.context targetID:target voice:op.voice appData:op.appData appDataPath:op.appPath] : [_sender prepareContext:op.context targetID:target voice:op.voice];
    if (!route) { if (op.context.messageType==34) op.failureDetail=@"语音发送准备失败"; [op.ledger transitionOperationID:op.identifier targetID:target toState:CSMessageActionSubmissionStateFailedBeforeAcceptance]; [self reportIfFinished:op]; return; }
    [op.ledger transitionOperationID:op.identifier targetID:target toState:CSMessageActionSubmissionStateReady];
    if (![self validAccount:op.context]) return;
    if (![op.ledger beginSubmissionForOperationID:op.identifier targetID:target currentAccountID:_accountID accountEpoch:_accountEpoch]) return;
    __weak typeof(self) weakSelf=self; __weak CSMessageActionOperation *weakOperation=op; CSMessageActionContext *captured=op.context;
    route.submissionStillAuthorized=^BOOL{ CSMessageActionOperation *live=weakOperation; return live && [weakSelf validAccount:captured] && !live.cancelled; };
    [op.leases addObject:route]; CSMessageActionSubmissionState result=[route submit];
    if (route.nativeHandoffReturned) [op.normalNativeHandoffs addObject:target];
    if (result!=CSMessageActionSubmissionStateAccepted && result!=CSMessageActionSubmissionStateFailedBeforeAcceptance && result!=CSMessageActionSubmissionStateUnknown) result=CSMessageActionSubmissionStateUnknown;
    [op.ledger transitionOperationID:op.identifier targetID:target toState:result]; [self reportIfFinished:op];
}
- (void)rememberResults:(NSDictionary *)results operationID:(NSString *)identifier {
    if (!_completed[identifier]) [_completedOrder addObject:identifier]; _completed[identifier]=results;
    while (_completedOrder.count>32) { [_completed removeObjectForKey:_completedOrder.firstObject]; [_completedOrder removeObjectAtIndex:0]; }
}
- (NSDictionary<NSString *,NSNumber *> *)resultsForOperationID:(NSString *)operationID {
    if (!operationID.length) return @{};
    CSMessageActionOperation *op=_operations[operationID]; if (!op) return _completed[operationID] ?: @{};
    NSMutableDictionary *results=[NSMutableDictionary dictionary]; for (NSString *target in op.targets) results[target]=@([op.ledger stateForOperationID:operationID targetID:target]); return results;
}
- (void)reportIfFinished:(CSMessageActionOperation *)op {
    NSUInteger accepted=0,unknown=0,failed=0,cancelled=0;
    NSDictionary *results=[self resultsForOperationID:op.identifier];
    for (NSString *target in results) {
        NSNumber *state=results[target];
        switch (state.integerValue) {
            case CSMessageActionSubmissionStateAccepted: case CSMessageActionSubmissionStateSucceeded: accepted++; break;
            case CSMessageActionSubmissionStateUnknown: if (![op.normalNativeHandoffs containsObject:target]) unknown++; break;
            case CSMessageActionSubmissionStateCancelled: cancelled++; break;
            case CSMessageActionSubmissionStateFailedBeforeAcceptance: case CSMessageActionSubmissionStateFailedAfterAcceptance: failed++; break;
            default: return;
        }
    }
    if (!op.targets.count || op.feedbackShown) return; op.feedbackShown=YES;
    NSMutableArray *parts=[NSMutableArray array]; if (accepted) [parts addObject:[NSString stringWithFormat:@"%lu个目标已受理",(unsigned long)accepted]]; if (unknown) [parts addObject:[NSString stringWithFormat:@"%lu个目标暂未确认发送结果，请查看微信消息状态",(unsigned long)unknown]]; if (failed) [parts addObject:[NSString stringWithFormat:@"%lu个目标未提交%@",(unsigned long)failed,op.failureDetail.length ? [NSString stringWithFormat:@"（%@）",op.failureDetail] : @""]]; if (cancelled) [parts addObject:[NSString stringWithFormat:@"%lu个目标已取消",(unsigned long)cancelled]];
    if (parts.count) [self feedback:[parts componentsJoinedByString:@"；"] context:op.context];
    // Preserve a live native binding until cleanup. Its ledger is the duplicate callback tombstone.
    if (!op.logic || op.nativeFinished) [self retire:op];
}
- (void)retire:(CSMessageActionOperation *)op { [self hideWaiting:op.identifier]; if (_operations[op.identifier]!=op) return; [self rememberResults:[self resultsForOperationID:op.identifier] operationID:op.identifier]; [_media cancelOperationID:op.identifier]; [_operations removeObjectForKey:op.identifier]; }
- (void)cancelOperationID:(NSString *)operationID { if (!operationID.length) return; CSMessageActionOperation *op=_operations[operationID]; if (!op) return; [self hideWaiting:operationID]; op.cancelled=YES; [op.ledger cancelUnsubmittedOperations]; [_media cancelOperationID:operationID]; CSMessageForwardBinding *binding=[_forward bindingForLogic:op.logic]; binding.cancelled=YES; [self reportIfFinished:op]; if (!op.logic) [self retire:op]; }
- (void)cancelOperationsForCell:(id)cell {
    for (CSMessageActionConfirmation *confirmation in _confirmations) if (confirmation.context.cell==cell) confirmation.finished=YES;
    for (CSMessageActionOperation *op in _operations.allValues) if (op.context.cell==cell && op.action!=CSMessageActionRepeat && !(op.action==CSMessageActionForward && op.logic)) [self cancelOperationID:op.identifier];
}
- (void)cancelAllUnsubmittedOperations {
    for (CSMessageActionConfirmation *confirmation in _confirmations) confirmation.finished=YES;
    for (NSString *identifier in _operations.allKeys) [self cancelOperationID:identifier];
}
- (void)settingsChanged {
    for (CSMessageActionConfirmation *confirmation in _confirmations) if (!CSMessageActionEntryAllows(self.settings,confirmation.entry,confirmation.action)) confirmation.finished=YES;
    for (CSMessageActionOperation *op in _operations.allValues) if (!CSMessageActionEntryAllows(self.settings,op.entry,op.action) || (op.enhanced && !self.settings.voiceForwardEnabled)) [self cancelOperationID:op.identifier];
}
- (void)withForwardContext:(CSMessageActionContext *)context entry:(CSMessageActionEntry)entry perform:(void (^)(void))perform {
    if (_openingForwardOperation) { perform(); return; }
    if (!CSMessageActionUsesVoiceEnhancement(self.settings,entry,CSMessageActionForward,context.messageType)) { perform(); return; }
    if (![self validateContext:context]) { perform(); return; }
    CSMessageActionOperation *op=[self createOperation:context action:CSMessageActionForward entry:entry]; if (!op) { perform(); return; }
    _openingForwardOperation=op; @try { perform(); } @finally { _openingForwardOperation=nil; if (!op.logic) [self retire:op]; }
}
- (void)bindForwardLogic:(id)logic source:(id)source {
    CSMessageActionOperation *op=_openingForwardOperation;
    if (!op) { [_forward resetClosedBindingForLogic:logic]; return; }
    if (![_forward source:source matchesContext:op.context] || ![self validAccount:op.context] || ![_forward bindLogic:logic operationID:op.identifier context:op.context]) return;
    op.logic=logic; op.enhanced=CSMessageActionUsesVoiceEnhancement(self.settings,op.entry,op.action,op.context.messageType);
    [_forward bindingForLogic:logic].enhanced=op.enhanced;
    if (op.enhanced) [self prepareVoice:op];
}
- (BOOL)shouldSuppressNativeSuccessForLogic:(id)logic {
    // The compact binding survives native clearData until the next forwardMessage:
    // invocation, including the two success-UI getters that follow native cleanup.
    return [_forward bindingForLogic:logic].enhanced;
}
- (void)confirmForwardLogic:(id)logic {
    CSMessageForwardBinding *binding=[_forward bindingForLogic:logic]; CSMessageActionOperation *op=_operations[binding.operationID];
    if (!op || op.cancelled || ![self validAccount:op.context] || !op.context.controller || ![_forward confirmLogic:logic]) return;
    if (op.enhanced) [self registerTargets:binding.targets.allKeys operation:op];
}
- (BOOL)handleForwardLogic:(id)logic source:(id)source target:(id)target {
    CSMessageForwardBinding *binding=[_forward bindingForLogic:logic];
    if (!binding || ![_forward source:source matchesBinding:binding]) return NO;
    CSMessageActionOperation *op=_operations[binding.operationID];
    if (!op) return binding.enhanced && binding.closed; // Never recreate an operation after its cleanup.
    if (!op.enhanced) return NO;
    // A bound voice route has exactly one owner, even after disable/cancel/expired authorization.
    if (op.cancelled || binding.cancelled || ![self validAccount:op.context]) return YES;
    NSString *identifier=CSMessageForwardTargetID(target);
    if (!binding.confirmed || !identifier || !binding.targets[identifier]) return YES;
    [op.requestedTargets addObject:identifier]; [self submitTarget:identifier operation:op]; return YES;
}
- (void)finishForwardLogic:(id)logic cancelled:(BOOL)cancelled {
    CSMessageForwardBinding *binding=[_forward bindingForLogic:logic];
    // The first native completion/cancel owns the session outcome. Later clearData
    // is cleanup and must not cancel confirmed targets still waiting for media.
    if (!binding || binding.closed) return;
    CSMessageActionOperation *op=_operations[binding.operationID];
    if (op) { op.nativeFinished=YES; if (cancelled) [self cancelOperationID:op.identifier]; if (!op.enhanced || op.cancelled || op.feedbackShown) [self retire:op]; }
    [_forward detachLogic:logic];
}
- (void)voiceDownloadCompletedForChat:(NSString *)chat localID:(unsigned int)localID serverID:(long long)serverID endFlag:(unsigned int)endFlag error:(unsigned int)error {
    if (endFlag!=1 || ![_media hasPendingVoiceForChat:chat localID:localID serverID:serverID]) return;
    [self refreshAccount]; if (!_accountID.length) return;
    if (error==3) [_media downloadCompletedForAccount:_accountID epoch:_accountEpoch chat:chat localID:localID serverID:serverID];
    else [_media downloadFailedForAccount:_accountID epoch:_accountEpoch chat:chat localID:localID serverID:serverID];
}
@end
