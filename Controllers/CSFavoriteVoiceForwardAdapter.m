#import "CSFavoriteVoiceForwardAdapter.h"
#import "CSVoiceForwardAdapter.h"
#import <objc/runtime.h>
#import <TargetConditionals.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#import "CSCloseFriendBridge.h"
#endif

@interface CSFavoriteVoiceOperation : NSObject
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, strong) CSFavoriteVoiceContext *context;
@property(nonatomic, weak) id controller;
@property(nonatomic, strong) CSMessageVoiceResource *resource;
@property(nonatomic, strong) id previewWrap;
@property(nonatomic, weak) id logic;
@property(nonatomic, strong) CSMessageActionSubmissionLedger *ledger;
@property(nonatomic, copy) NSDictionary<NSString *, id> *targets;
@property(nonatomic, strong) NSMutableArray<CSMessagePreparedSend *> *leases;
@property(nonatomic) BOOL confirmed, cancelled, nativeFinished;
@end
@implementation CSFavoriteVoiceOperation
@end
@interface CSFavoriteVoiceBinding : NSObject
@property(nonatomic, copy) NSString *operationID;
@property(nonatomic, weak) id source;
@property(nonatomic) BOOL closed;
@end
@implementation CSFavoriteVoiceBinding
@end
static char CSFavoriteVoiceBindingKey;

@interface CSFavoriteVoiceForwardAdapter ()
@property(nonatomic, strong) id<CSMessageActionEnvironment> environment;
@property(nonatomic, strong) CSMessageActionPreferences *preferences;
@property(nonatomic, strong) CSMessageActionCoordinator *accounts;
@property(nonatomic, strong) CSFavoriteVoiceMediaProvider *media;
@property(nonatomic, strong) CSMessageSendAdapter *sender;
@property(nonatomic, strong) NSMutableDictionary<NSString *, CSFavoriteVoiceOperation *> *operations;
@property(nonatomic, strong) NSArray *observers;
@property(nonatomic, strong) CSFavoriteVoiceOperation *opening;
@property(nonatomic, weak) id menuController;
#if TARGET_OS_IOS
@property(nonatomic, strong) NSMutableDictionary<NSString *, UIView *> *waitingViews;
#endif
@end

@implementation CSFavoriteVoiceForwardAdapter
+ (instancetype)sharedAdapter {
    static CSFavoriteVoiceForwardAdapter *adapter; static dispatch_once_t once;
    dispatch_once(&once, ^{
        id<CSMessageActionEnvironment> environment=[CSMessageNativeEnvironment new];
        adapter=[[self alloc] initWithEnvironment:environment preferences:CSMessageActionPreferences.sharedPreferences
            accountCoordinator:CSMessageActionCoordinator.sharedCoordinator mediaProvider:[[CSFavoriteVoiceMediaProvider alloc] initWithEnvironment:environment]
            sendAdapter:[[CSMessageSendAdapter alloc] initWithEnvironment:environment]];
    });
    return adapter;
}
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment preferences:(CSMessageActionPreferences *)preferences
    accountCoordinator:(CSMessageActionCoordinator *)accounts mediaProvider:(CSFavoriteVoiceMediaProvider *)media sendAdapter:(CSMessageSendAdapter *)sender {
    if ((self=[super init])) {
        _environment=environment; _preferences=preferences; _accounts=accounts; _media=media; _sender=sender;
        _operations=[NSMutableDictionary dictionary];
#if TARGET_OS_IOS
        _waitingViews=[NSMutableDictionary dictionary];
#endif
        __weak typeof(self) weakSelf=self;
        media.isContextValid=^BOOL(CSFavoriteVoiceContext *context){ return [weakSelf validContext:context]; };
        media.waitingHandler=^(NSString *identifier){ [weakSelf showWaiting:identifier]; };
        NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
        NSMutableArray *observers=[NSMutableArray array];
        [observers addObject:[center addObserverForName:CSMessageActionSettingsDidChangeNotification object:preferences queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
            if (!weakSelf.preferences.snapshot.favoriteVoiceForwardEnabled) [weakSelf cancelAll];
        }]];
        [observers addObject:[center addObserverForName:CSMessageActionAccountStateDidChangeNotification object:accounts queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){ [weakSelf cancelAll]; }]];
#if TARGET_OS_IOS
        for (NSString *name in @[UIApplicationWillResignActiveNotification,CSCloseFriendPolicyDidChangeNotification])
            [observers addObject:[center addObserverForName:name object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){ [weakSelf cancelAll]; }]];
#endif
        _observers=[observers copy];
    }
    return self;
}
- (void)dealloc { for (id observer in _observers) [NSNotificationCenter.defaultCenter removeObserver:observer]; }
- (BOOL)validContext:(CSFavoriteVoiceContext *)context {
    return NSThread.isMainThread && _preferences.snapshot.favoriteVoiceForwardEnabled &&
        [_accounts isCurrentAccountID:context.accountID epoch:context.accountEpoch];
}
- (BOOL)canForwardItem:(id)item {
    if (!NSThread.isMainThread || !_preferences.snapshot.favoriteVoiceForwardEnabled) return NO;
    [_accounts refreshAccountState];
    CSFavoriteVoiceContext *context=[CSFavoriteVoiceContext contextWithItem:item accountID:_accounts.accountID accountEpoch:_accounts.accountEpoch];
    return context && [self validContext:context];
}
- (void)withDetailMenuForController:(id)controller perform:(void (^)(void))perform {
    id previous=_menuController; _menuController=controller;
    @try { perform(); } @finally { _menuController=previous; }
}
- (long long)menuEnableType:(long long)enabled delegate:(id)delegate {
    if (!NSThread.isMainThread || delegate!=_menuController || !delegate || !_preferences.snapshot.favoriteVoiceForwardEnabled) return enabled;
    // This native field belongs to FavBaseDetailViewController; never use arbitrary KVC.
    Ivar ivar=class_getInstanceVariable(object_getClass(delegate),"m_favItem");
    const char *encoding=ivar ? ivar_getTypeEncoding(ivar) : NULL;
    id item=encoding && encoding[0]=='@' ? object_getIvar(delegate,ivar) : nil;
    return [self canForwardItem:item] ? enabled|1LL : enabled;
}
- (BOOL)pageCanPresent:(id)controller {
    if (!controller) return NO;
#if TARGET_OS_IOS
    if (![controller isKindOfClass:UIViewController.class] || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive || CSCloseFriendCurrentSnapshot().blocked) return NO;
    UIViewController *page=controller;
    return page.isViewLoaded && page.view.window && !page.isBeingDismissed && !page.isMovingFromParentViewController && !page.presentedViewController;
#else
    return YES;
#endif
}
- (void)forwardItem:(id)item fromController:(id)controller {
    if (![self canForwardItem:item] || ![self pageCanPresent:controller]) return;
    CSFavoriteVoiceContext *context=[CSFavoriteVoiceContext contextWithItem:item accountID:_accounts.accountID accountEpoch:_accounts.accountEpoch];
    if (!context || ![self validContext:context]) return;
    // Repeated taps share the live action until its picker closes. A later deliberate action gets a fresh ID.
    for (CSFavoriteVoiceOperation *op in _operations.allValues)
        if (!op.cancelled && [op.context.stableIdentity isEqual:context.stableIdentity]) return;
    if (_operations.count>=8) { [self feedback:@"待处理收藏语音较多，请稍后重试" controller:controller]; return; }
    CSFavoriteVoiceOperation *op=[CSFavoriteVoiceOperation new]; op.identifier=NSUUID.UUID.UUIDString; op.context=context; op.controller=controller;
    op.leases=[NSMutableArray array]; _operations[op.identifier]=op;
    NSString *identifier=op.identifier; __weak typeof(self) weakSelf=self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,180*NSEC_PER_SEC),dispatch_get_main_queue(),^{ [weakSelf cancelOperationID:identifier]; });
    [_media prepareContext:context operationID:identifier completion:^(CSMessageVoiceResource *resource, NSString *reason){
        typeof(self) self=weakSelf; CSFavoriteVoiceOperation *live=self.operations[identifier]; if (!self || !live) return;
        [self hideWaiting:identifier];
        if (![self validOperation:live] || ![self pageCanPresent:live.controller]) { [self cancelOperationID:identifier]; return; }
        if (!resource) { [self feedback:reason.length ? reason : @"收藏语音读取失败，请先播放后重试" controller:live.controller]; [self retire:live]; return; }
        live.resource=resource;
        // This is only the native chooser's independent display payload; it is never inserted or uploaded.
        live.previewWrap=[self.sender voiceWrapForResource:resource accountID:context.accountID targetID:context.accountID];
        if (!live.previewWrap || ![self validOperation:live]) { [self feedback:@"收藏语音转发准备失败" controller:live.controller]; [self retire:live]; return; }
        CSFavoriteVoiceOperation *previous=self.opening; self.opening=live; BOOL opened=NO;
        @try {
            if (self.presentVoiceWrap) opened=self.presentVoiceWrap(live.previewWrap,live.controller);
            else {
                id manager=[self.environment serviceNamed:@"ForwardMessageMgr"];
                if ([self validOperation:live] && CSMessageNativeSupports(manager,@"forwardMessage:fromViewController:",@"v",@[@"@",@"@"])) {
                    CSMessageNativeInvoke(manager,@"forwardMessage:fromViewController:",@[live.previewWrap,live.controller]); opened=YES;
                }
            }
        } @catch (__unused NSException *exception) {} @finally { self.opening=previous; }
        if (!opened || !live.logic) { [self feedback:@"无法打开微信转发界面，请重试" controller:live.controller]; [self retire:live]; }
    }];
}
- (BOOL)validOperation:(CSFavoriteVoiceOperation *)op {
    return op && _operations[op.identifier]==op && !op.cancelled && [self validContext:op.context];
}
- (id)singleSource:(id)source {
    if ([source isKindOfClass:NSArray.class]) return [source count]==1 ? [source firstObject] : nil;
    return source;
}
- (CSFavoriteVoiceBinding *)binding:(id)logic { return logic ? objc_getAssociatedObject(logic,&CSFavoriteVoiceBindingKey) : nil; }
- (void)bindLogic:(id)logic source:(id)source {
    if (!NSThread.isMainThread || !logic) return;
    CSFavoriteVoiceOperation *op=_opening; CSFavoriteVoiceBinding *old=[self binding:logic];
    if (!op) { if (old.closed) objc_setAssociatedObject(logic,&CSFavoriteVoiceBindingKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC); return; }
    if ([self singleSource:source]!=op.previewWrap || ![self validOperation:op] || (old && !old.closed)) return;
    CSFavoriteVoiceBinding *binding=[CSFavoriteVoiceBinding new]; binding.operationID=op.identifier; binding.source=op.previewWrap;
    objc_setAssociatedObject(logic,&CSFavoriteVoiceBindingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC); op.logic=logic;
}
- (void)confirmLogic:(id)logic {
    if (!NSThread.isMainThread) return;
    CSFavoriteVoiceBinding *binding=[self binding:logic]; if (!binding || binding.closed) return;
    CSFavoriteVoiceOperation *op=_operations[binding.operationID]; if (![self validOperation:op] || op.confirmed) return;
    id contacts=CSMessageActionNativeObject(logic,@"getToContacts"); if (![contacts isKindOfClass:NSArray.class] || ![contacts count] || [contacts count]>100) return;
    NSMutableDictionary *targets=[NSMutableDictionary dictionary];
    for (id contact in contacts) { NSString *target=CSMessageForwardTargetID(contact); if (!target.length) return; targets[target]=contact; }
    op.targets=[targets copy]; op.ledger=[[CSMessageActionSubmissionLedger alloc] initWithAccountID:op.context.accountID accountEpoch:op.context.accountEpoch];
    [op.ledger registerOperationID:op.identifier targetIDs:targets.allKeys];
    for (NSString *target in targets) [op.ledger transitionOperationID:op.identifier targetID:target toState:CSMessageActionSubmissionStateReady];
    op.confirmed=YES;
}
- (BOOL)handleLogic:(id)logic source:(id)source target:(id)contact {
    CSFavoriteVoiceBinding *binding=[self binding:logic]; if (!binding) return NO;
    id currentSource=[self singleSource:source], boundSource=binding.source;
    if (!boundSource || currentSource!=boundSource) {
        // Native forwardMsgList: entries may reuse this logic without calling
        // forwardMessage:. A completed favorite must not own their dispatch/UI.
        if (NSThread.isMainThread && binding.closed && currentSource)
            objc_setAssociatedObject(logic,&CSFavoriteVoiceBindingKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return NO;
    }
    // Only the bound favorite source owns dispatch after invalidation or cleanup.
    if (!NSThread.isMainThread || binding.closed) return YES;
    CSFavoriteVoiceOperation *op=_operations[binding.operationID];
    if (![self validOperation:op] || [self singleSource:source]!=op.previewWrap || !op.confirmed) return YES;
    NSString *target=CSMessageForwardTargetID(contact); if (!target.length || !op.targets[target]) return YES;
    if ([op.ledger stateForOperationID:op.identifier targetID:target]!=CSMessageActionSubmissionStateReady) return YES;
    if (![_media sourceIsCurrentForContext:op.context] || ![self validOperation:op]) {
        if ([self validOperation:op]) [self feedback:@"收藏语音已变化，请重新打开后转发" controller:op.controller];
        [self cancelOperationID:op.identifier]; return YES;
    }
    CSMessagePreparedSend *route=[_sender prepareVoiceResource:op.resource accountID:op.context.accountID targetID:target];
    if (![self validOperation:op]) return YES;
    if (!route) { [op.ledger transitionOperationID:op.identifier targetID:target toState:CSMessageActionSubmissionStateFailedBeforeAcceptance]; [self feedback:@"收藏语音发送准备失败" controller:op.controller]; return YES; }
    if (![op.ledger beginSubmissionForOperationID:op.identifier targetID:target currentAccountID:_accounts.accountID accountEpoch:_accounts.accountEpoch]) return YES;
    __weak typeof(self) weakSelf=self; __weak CSFavoriteVoiceOperation *weakOperation=op;
    route.submissionStillAuthorized=^BOOL{ return [weakSelf validOperation:weakOperation]; };
    [op.leases addObject:route]; CSMessageActionSubmissionState result=[route submit];
    if (result!=CSMessageActionSubmissionStateAccepted && result!=CSMessageActionSubmissionStateUnknown && result!=CSMessageActionSubmissionStateFailedBeforeAcceptance) result=CSMessageActionSubmissionStateUnknown;
    [op.ledger transitionOperationID:op.identifier targetID:target toState:result];
    if (!route.nativeHandoffReturned) [self feedback:@"收藏语音发送结果暂未确认，请查看聊天中的消息状态" controller:op.controller];
    return YES;
}
- (BOOL)suppressesNativeSuccessForLogic:(id)logic {
    CSFavoriteVoiceBinding *binding=[self binding:logic]; if (!binding || !NSThread.isMainThread) return NO;
    id messages=CSMessageActionNativeObject(logic,@"getMessages");
    // 8.0.80 clearData nils m_msgList before its success getters. Preserve the
    // completed favorite's suppression until a new source is observed.
    if (!messages || ([messages isKindOfClass:NSArray.class] && ![messages count])) return binding.closed;
    if (binding.source && [self singleSource:messages]==binding.source) return YES;
    if (binding.closed) objc_setAssociatedObject(logic,&CSFavoriteVoiceBindingKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return NO;
}
- (void)finishLogic:(id)logic cancelled:(BOOL)cancelled {
    CSFavoriteVoiceBinding *binding=[self binding:logic]; if (!binding || binding.closed) return;
    binding.closed=YES;
    CSFavoriteVoiceOperation *op=_operations[binding.operationID];
    if (op) { op.nativeFinished=YES; if (cancelled) [self cancelOperationID:op.identifier]; else [self retire:op]; }
}
- (void)retire:(CSFavoriteVoiceOperation *)op {
    if (!op || _operations[op.identifier]!=op) return;
    [self hideWaiting:op.identifier]; [_operations removeObjectForKey:op.identifier]; [_media cancelOperationID:op.identifier];
    [self binding:op.logic].closed=YES;
}
- (void)cancelOperationID:(NSString *)identifier {
    CSFavoriteVoiceOperation *op=_operations[identifier]; if (!op) return;
    op.cancelled=YES; [op.ledger cancelUnsubmittedOperations]; [self retire:op];
}
- (void)cancelAll { for (NSString *identifier in _operations.allKeys) [self cancelOperationID:identifier]; }
- (void)downloadFinishedForItem:(id)item error:(int)error {
    if (!NSThread.isMainThread || !_operations.count) return;
    [_accounts refreshAccountState];
    if (_accounts.accountID.length) [_media downloadFinishedForItem:item error:error accountID:_accounts.accountID epoch:_accounts.accountEpoch];
}
- (void)showWaiting:(NSString *)identifier {
    CSFavoriteVoiceOperation *op=_operations[identifier]; if (![self validOperation:op]) return;
    if (_feedbackHandler) { _feedbackHandler(@"正在下载收藏语音，可取消本次操作"); return; }
#if TARGET_OS_IOS
    UIViewController *page=op.controller; if (![self pageCanPresent:page] || _waitingViews[identifier]) return;
    UIView *panel=[[UIView alloc] initWithFrame:CGRectMake(20,MAX(80,page.view.safeAreaInsets.top+16),page.view.bounds.size.width-40,96)];
    panel.backgroundColor=[UIColor colorWithWhite:0 alpha:0.85]; panel.layer.cornerRadius=10;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(12,8,panel.bounds.size.width-24,40)]; label.text=@"正在下载收藏语音，完成后选择转发对象"; label.numberOfLines=2; label.textColor=UIColor.whiteColor; label.font=[UIFont systemFontOfSize:14]; [panel addSubview:label];
    __weak typeof(self) weakSelf=self;
    UIButton *cancel=[UIButton buttonWithType:UIButtonTypeSystem primaryAction:[UIAction actionWithTitle:@"取消本次操作" image:nil identifier:nil handler:^(__unused UIAction *action){ [weakSelf cancelOperationID:identifier]; }]];
    cancel.frame=CGRectMake(12,52,panel.bounds.size.width-24,36); [panel addSubview:cancel]; [page.view addSubview:panel]; _waitingViews[identifier]=panel;
#endif
}
- (void)hideWaiting:(NSString *)identifier {
#if TARGET_OS_IOS
    [_waitingViews[identifier] removeFromSuperview]; [_waitingViews removeObjectForKey:identifier];
#else
    (void)identifier;
#endif
}
- (void)feedback:(NSString *)message controller:(id)controller {
    if (_feedbackHandler) { _feedbackHandler(message); return; }
#if TARGET_OS_IOS
    UIViewController *page=controller; if (![page isKindOfClass:UIViewController.class]) return;
    while (page.presentedViewController) page=page.presentedViewController;
    if (!page.isViewLoaded || !page.view.window) return;
    UILabel *label=[UILabel new]; label.text=message; label.numberOfLines=0; label.font=[UIFont systemFontOfSize:14]; label.textAlignment=NSTextAlignmentCenter;
    label.textColor=UIColor.whiteColor; label.backgroundColor=[UIColor colorWithWhite:0 alpha:0.85]; label.layer.cornerRadius=8; label.clipsToBounds=YES;
    CGFloat width=MIN(page.view.bounds.size.width-40,340); CGSize size=[label sizeThatFits:CGSizeMake(width-24,CGFLOAT_MAX)];
    label.frame=CGRectMake((page.view.bounds.size.width-width)/2,page.view.bounds.size.height/2,width,size.height+24); [page.view addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,4*NSEC_PER_SEC),dispatch_get_main_queue(),^{ [label removeFromSuperview]; });
#else
    (void)controller;
#endif
}
@end
