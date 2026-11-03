#import "CSGroupNativeSessionCoordinator.h"
#import "CSGroupNativeModel.h"
#import "CSGroupNativeBridge.h"
#import "CSGroupPreferences.h"
#import "CSCloseFriendBridge.h"
#import "CSBackupBootstrap.h"
#import "CSServiceCenter.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
#include <limits.h>

NSNotificationName const CSGroupNativeSessionModelDidChangeNotification=@"CSGroupNativeSessionModelDidChangeNotification";

static BOOL CSNativeMethod(id object, NSString *name, const char *encoding) {
    return object && CSCloseFriendMethodMatches(class_getInstanceMethod(object_getClass(object),NSSelectorFromString(name)),encoding);
}
static BOOL CSNativeManagerSupported(id manager) {
    Class cls=NSClassFromString(@"MainSessionMgr");
    if (!cls || ![manager isKindOfClass:cls]) return NO;
    for (NSString *name in @[@"topSessions",@"normalSessions",@"allTopSessions"])
        if (!CSNativeMethod(manager,name,"@@:")) return NO;
    for (NSString *name in @[@"setTopSessions:",@"setNormalSessions:",@"setAllTopSessions:"])
        if (!CSNativeMethod(manager,name,"v@:@")) return NO;
    return CSNativeMethod(manager,@"totalTopSessionCount","q@:") &&
        CSNativeMethod(manager,@"setTotalTopSessionCount:","v@:q") &&
        CSNativeMethod(manager,@"rebuildMainSessions","v@:");
}
static NSArray *CSNativeArray(id value, BOOL allowNil) {
    if (!value) return allowNil ? nil : @[];
    if (![value isKindOfClass:NSArray.class] || [value count]>100000) return nil;
    return [value copy];
}
static BOOL CSNativeSameObjects(NSArray *left, NSArray *right) {
    if (left==right) return YES;
    if (![left isKindOfClass:NSArray.class] || ![right isKindOfClass:NSArray.class] || left.count!=right.count) return NO;
    for (NSUInteger i=0;i<left.count;i++) if (left[i]!=right[i]) return NO;
    return YES;
}
static BOOL CSNativeGroupEnabled(void) {
    return [NSUserDefaults.standardUserDefaults boolForKey:@"com.wechat.enhance.chat_group.enabled"];
}
static NSIndexPath *CSNativeIdentityPath(void) {
    NSUInteger indexes[]={0,0};return [NSIndexPath indexPathWithIndexes:indexes length:2];
}
static id CSNativeService(NSString *name) {
    Class cls=NSClassFromString(name);
    if (!cls) return nil;
    @try { return CSGetService(cls); } @catch (__unused NSException *exception) { return nil; }
}
static BOOL CSNativeRegisteredManager(id manager) {
    for (NSString *name in @[@"MainSessionMgr",@"MMNewSessionMgr"]) {
        Class cls=NSClassFromString(name);
        if (cls && [manager isKindOfClass:cls]) return CSNativeService(name)==manager;
    }
    return NO;
}
static UIViewController *CSNativeFrontController(UIViewController *controller) {
    for (NSUInteger depth=0;controller && depth<16;depth++) {
        UIViewController *next=controller.presentedViewController;
        if (!next && [controller isKindOfClass:UINavigationController.class]) next=[(UINavigationController *)controller topViewController];
        if (!next && [controller isKindOfClass:UITabBarController.class]) next=[(UITabBarController *)controller selectedViewController];
        if (!next || next==controller) break;
        controller=next;
    }
    return controller;
}
static BOOL CSNativeSelectionController(id controller) {
    for (Class cls=object_getClass(controller);cls;cls=class_getSuperclass(cls)) {
        NSString *name=NSStringFromClass(cls);
        if ([name containsString:@"SessionSelect"] || [name containsString:@"SelectContact"] ||
            [name containsString:@"ContactSelect"] || [name containsString:@"ForwardSelect"]) return YES;
    }
    return NO;
}

/// The host objects are retained only here, on main, for native restoration.
/// Their copied names/classes prove that an in-place host mutation did not turn
/// a saved slot into a different conversation between capture and publication.
@interface CSNativeSessionBaseline : NSObject
@property(nonatomic,copy) NSArray *top, *normal, *allTop, *allSessions, *statisticsSessions;
@property(nonatomic,strong) NSMapTable<id,NSDictionary *> *identities;
@property(nonatomic,copy) NSString *accountID;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) long long totalTopCount, chatBoxMinIndex;
@property(nonatomic) BOOL hasChatBoxMinIndex;
@property(nonatomic,copy) NSDictionary<NSString *,NSArray *> *displayObjectsByName, *rawObjectsByName;
@property(nonatomic,copy) NSDictionary<NSString *,NSNumber *> *statisticsIndexes;
@property(nonatomic,weak) CSNativeSessionBaseline *incrementalOrigin;
@end
@implementation CSNativeSessionBaseline @end

@interface CSGroupNativeSessionCoordinator ()
@property(nonatomic,weak) id mainController, manager;
@property(nonatomic,strong) CSNativeSessionBaseline *baseline;
@property(nonatomic,strong) CSGroupPreferences *preferences;
@property(nonatomic,strong,readwrite) CSGroupNativeModelResult *model;
@property(nonatomic,readwrite) BOOL applied, boundary;
@property(nonatomic,readwrite) BOOL compatibilityFallback;
@property(nonatomic) BOOL restoringCompatibilityFallback, captureCompatibilityFailure;
@property(nonatomic) BOOL nativeArraysTouched;
@property(nonatomic) NSUInteger compatibilityMutationRevision;
@property(nonatomic,readwrite) NSUInteger revision, epoch;
@property(nonatomic,copy,readwrite) NSString *accountID;
@property(nonatomic) NSUInteger depth, notifiedRevision, privacyRevision;
@property(nonatomic) NSUInteger completeSourceDepth, completeSourceEpoch, completeSourcePrivacyRevision;
@property(nonatomic) CSCloseFriendSurface completeSourceSurface;
@property(nonatomic,copy) NSString *completeSourceAccount;
@property(nonatomic) BOOL completeSourceReady, restoringCompleteSource;
@property(nonatomic) NSUInteger publicationDepth, publicationMutationRevision, publicationRecoveryAttempts;
@property(nonatomic) BOOL publicationRecoveryPending, publicationRecoveryQueued, publicationRecoveryRunning;
@property(nonatomic,copy) NSString *publicationRecoveryAccount;
@property(nonatomic) NSUInteger publicationRecoveryEpoch;
@property(nonatomic,weak) id publicationRecoveryManager;
@property(nonatomic) BOOL dirty, refreshQueued, refreshing, sourceChanged;
@property(nonatomic,weak) id nativePresentationOwner;
@property(nonatomic,copy) NSString *nativePresentationAccount;
@property(nonatomic) NSUInteger nativePresentationEpoch;
@property(nonatomic,strong) CSGroupNativeModelResult *cachedModel;
@property(nonatomic,strong) CSNativeSessionBaseline *cachedModelBaseline;
@property(nonatomic,copy) NSArray *cachedModelKey;
@property(nonatomic,strong) NSMutableSet<NSString *> *pendingNativeNames;
@property(nonatomic) CSGroupChangeKind pendingNativeKind;
@property(nonatomic) BOOL pendingNativeChanges, pendingNativeChangesKnown;
@property(nonatomic) NSUInteger changeScopeDepth;
- (void)applyBaseline;
- (void)queueRefresh;
- (void)notifySourceRevision;
- (void)applyBaselineCandidate;
- (void)performPublication:(void (^)(void))publication;
- (void)queuePublicationRecovery;
@end

@implementation CSGroupNativeSessionCoordinator
@synthesize nativePresentation=_nativePresentation;
+ (instancetype)sharedCoordinator {
    static CSGroupNativeSessionCoordinator *coordinator; static dispatch_once_t once;
    dispatch_once(&once, ^{ coordinator=[self new]; }); return coordinator;
}
- (instancetype)init {
    if ((self=[super init])) {
        _boundary=YES; _dirty=YES;
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(privacyChanged:)
            name:CSCloseFriendPolicyDidChangeNotification object:nil];
    }
    return self;
}
- (void)setMainController:(id)controller {
    if (!NSThread.isMainThread) return;
    Class cls=NSClassFromString(@"NewMainFrameViewController");
    if (!controller || (cls && [controller isKindOfClass:cls])) {
        if (_mainController!=controller) self.nativePresentation=NO;
        _mainController=controller;
    }
}
- (void)setNativePresentation:(BOOL)value {
    if (!NSThread.isMainThread) return;
    _nativePresentation=value && self.mainController!=nil;
    self.nativePresentationOwner=_nativePresentation ? self.mainController : nil;
    self.nativePresentationAccount=_nativePresentation ? CSGroupCurrentAccountID() : nil;
    self.nativePresentationEpoch=CSCloseFriendAccountEpoch();
}
- (BOOL)nativePresentation {
    return _nativePresentation && self.nativePresentationOwner==self.mainController &&
        self.nativePresentationEpoch==CSCloseFriendAccountEpoch() &&
        [self.nativePresentationAccount isEqual:CSGroupCurrentAccountID()];
}
- (BOOL)permitsSelectedGroup {
    if (self.nativePresentation || !self.mainController) return NO;
    // NewMainFrameViewController is an NSObject owner in supported WeChat
    // versions; curViewController is its authoritative UI bridge. Never infer
    // this owner from an unrelated foreground window or controller instance.
    id owner=self.mainController;
    id currentUI=[owner isKindOfClass:UIViewController.class] ? owner : CSGroupReadObject(owner,@"curViewController");
    if ([currentUI isKindOfClass:UIViewController.class]) {
        UIViewController *main=currentUI;
        UIViewController *front=CSNativeFrontController(main.navigationController ?: main);
        if (CSNativeSelectionController(front)) return NO;
        // A selection sheet may be owned by the window's root rather than by
        // the main chat controller's navigation stack.
        UIViewController *root=main.viewIfLoaded.window.rootViewController;
        if (CSNativeSelectionController(CSNativeFrontController(root))) return NO;
    }
    return YES;
}
- (BOOL)accountMatchesBaseline:(CSNativeSessionBaseline *)baseline {
    return baseline && !CSBackupAccountIsSuspended() && baseline.epoch==CSCloseFriendAccountEpoch() &&
        [baseline.accountID isEqual:CSGroupCurrentAccountID()];
}
- (BOOL)identitiesMatch:(CSNativeSessionBaseline *)baseline {
    for (id session in baseline.identities) {
        NSDictionary *identity=[baseline.identities objectForKey:session];
        id underlying=CSGroupReadObject(session,@"mainSession") ?: session;
        id name=CSGroupReadObject(underlying,@"m_nsUserName") ?: CSGroupReadObject(underlying,@"sessionId");
        if ((name && ![name isKindOfClass:NSString.class]) ||
            ![identity[@"class"] isEqual:NSStringFromClass(object_getClass(session))] ||
            ![identity[@"name"] isEqual:name ?: @""]) return NO;
    }
    return YES;
}
- (void)recordChangeNames:(NSSet *)names kind:(CSGroupChangeKind)kind {
    BOOL known=[names isKindOfClass:NSSet.class] && names.count && !(kind&CSGroupChangeUnknown);
    if ([names isKindOfClass:NSSet.class]) for (id name in names)
        if (![name isKindOfClass:NSString.class] || ![name length]) known=NO;
    if (!self.pendingNativeChanges) {
        self.pendingNativeChanges=YES;self.pendingNativeChangesKnown=known;
        self.pendingNativeNames=[NSMutableSet set];self.pendingNativeKind=0;
    } else self.pendingNativeChangesKnown&=known;
    self.pendingNativeKind|=kind;
    if (known) [self.pendingNativeNames unionSet:names];
}
- (void)performChangeForUserNames:(NSSet *)names kind:(CSGroupChangeKind)kind original:(void (^)(void))original {
    if (!NSThread.isMainThread || self.compatibilityFallback) { original();return; }
    // A native total-unread callback nested in a named source operation adds
    // no new identity. An independent unscoped total callback remains unknown.
    if (!names && self.changeScopeDepth && kind==CSGroupChangeUnread) self.pendingNativeKind|=kind;
    else [self recordChangeNames:names kind:kind];
    self.changeScopeDepth++;
    @try { original(); } @finally { self.changeScopeDepth--; }
}
- (BOOL)compatibilityPolicy:(CSCloseFriendSnapshot *)policy account:(NSString *)account epoch:(NSUInteger)epoch {
    return account.length && !CSBackupAccountIsSuspended() && epoch==CSCloseFriendAccountEpoch() &&
        [account isEqual:CSGroupCurrentAccountID()] && !policy.blocked &&
        [policy.accountID isEqual:account] && [policy.options[@"hideSessions"] isKindOfClass:NSNumber.class];
}
- (BOOL)recordCompatibilityNativeChange {
    @synchronized (self) {
        if (!self.restoringCompatibilityFallback) return NO;
        self.compatibilityMutationRevision++;
        return YES;
    }
}
- (NSUInteger)compatibilitySourceRevision {
    @synchronized (self) { return self.compatibilityMutationRevision; }
}
- (void)useCompatibilityFallback {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self useCompatibilityFallback]; });return; }
    if (self.compatibilityFallback || self.restoringCompatibilityFallback) return;
    NSString *account=CSGroupCurrentAccountID();NSUInteger epoch=CSCloseFriendAccountEpoch();
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (![self compatibilityPolicy:policy account:account epoch:epoch]) {
        [self closeNativePublication];return;
    }
    @synchronized (self) { self.restoringCompatibilityFallback=YES; }
    self.depth++;
    self.model=nil;self.boundary=YES;
    // A failed setter/readback can leave a partially filtered source even when
    // applied is NO. Remember every attempted write until handoff is complete.
    BOOL restored=!self.applied && !self.nativeArraysTouched,accepted=NO;
    NSUInteger restoreRevision=[self compatibilitySourceRevision];
    id handoffManager=CSNativeService(@"MainSessionMgr") ?: self.manager;
    @try {
        if (!restored) restored=[self restoreBaselineForNativeMutation];
        if (CSNativeMethod(handoffManager,@"rebuildMainSessions","v@:")) {
            restored=NO;
            for (NSUInteger attempt=0;attempt<3;attempt++) {
                // Restoring several old fields may synchronously trigger a real
                // native mutation. Always finish with an original-first rebuild;
                // no plugin field is written after it. Calls inside that native
                // rebuild obey the host's own contract and may change revision.
                ((void(*)(id,SEL))objc_msgSend)(handoffManager,NSSelectorFromString(@"rebuildMainSessions"));
                NSUInteger rebuiltRevision=[self compatibilitySourceRevision];
                CSCloseFriendSnapshot *after=CSCloseFriendCurrentSnapshot();
                id currentManager=CSNativeService(@"MainSessionMgr") ?: self.manager;
                BOOL policyStable=after.revision==policy.revision && [self compatibilityPolicy:after account:account epoch:epoch];
                if (!policyStable || currentManager!=handoffManager) break;
                // Reads in the postcondition can themselves synchronously call
                // native code. Rebuild again within a finite budget if they do.
                if (rebuiltRevision==[self compatibilitySourceRevision]) { restored=YES;accepted=YES;break; }
            }
        } else {
            CSCloseFriendSnapshot *after=CSCloseFriendCurrentSnapshot();
            id currentManager=CSNativeService(@"MainSessionMgr") ?: self.manager;
            accepted=restored && currentManager==handoffManager && after.revision==policy.revision &&
                [self compatibilityPolicy:after account:account epoch:epoch] &&
                restoreRevision==[self compatibilitySourceRevision];
        }
        if (accepted) {
            self.compatibilityFallback=YES;self.applied=NO;self.boundary=NO;self.dirty=NO;self.nativeArraysTouched=NO;
            self.baseline=nil;self.cachedModel=nil;self.cachedModelBaseline=nil;self.cachedModelKey=nil;
            self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0;
            self.accountID=account;self.epoch=epoch;self.privacyRevision=policy.revision;
            self.revision++;self.sourceChanged=YES;
        }
    } @catch (__unused NSException *exception) { accepted=NO; }
    @finally {
        self.depth--;
        @synchronized (self) { self.restoringCompatibilityFallback=NO; }
    }
    if (!accepted) { [self closeNativePublication];return; }
    [self notifySourceRevision];
}
- (NSArray *)statisticsSessionsForBaseline:(CSNativeSessionBaseline *)baseline {
    // The complete host presentation proves eligibility. Raw storage can load
    // later, contain hidden/container children, or expose a different wrapper;
    // it improves unread values only when one readable record agrees with a
    // displayed identity and kind/category. Optional statistics never determine
    // whether the entire chat list is publishable.
    NSMutableDictionary<NSString *,id> *rawByName=[NSMutableDictionary dictionary];
    NSMutableDictionary<NSString *,NSMutableArray *> *rawObjects=[NSMutableDictionary dictionary];
    NSMutableSet<NSString *> *ambiguous=[NSMutableSet set];
    @try {
        for (id object in baseline.allSessions) {
            CSGroupRow *row=CSGroupRowForNativeSession(object,CSNativeIdentityPath(),NO);
            if (!row.userName.length) continue;
            if (!rawObjects[row.userName]) rawObjects[row.userName]=[NSMutableArray array];
            [rawObjects[row.userName] addObject:object];
            id session=CSGroupReadObject(object,@"mainSession") ?: object;
            if (CSNativeMethod(session,@"isHidden","B@:")) {
                BOOL hidden=NO;
                @try { hidden=((BOOL(*)(id,SEL))objc_msgSend)(session,NSSelectorFromString(@"isHidden")); }
                @catch (__unused NSException *exception) { continue; }
                if (hidden) continue;
            }
            if (rawByName[row.userName] || [ambiguous containsObject:row.userName]) {
                [rawByName removeObjectForKey:row.userName];[ambiguous addObject:row.userName];
            } else rawByName[row.userName]=object;
        }
    } @catch (__unused NSException *exception) { [rawByName removeAllObjects];[rawObjects removeAllObjects]; }
    NSMutableDictionary *rawIndex=[NSMutableDictionary dictionary];
    [rawObjects enumerateKeysAndObjectsUsingBlock:^(NSString *name,NSArray *objects,BOOL *stop) {
        (void)stop;rawIndex[name]=[objects copy];
    }];
    baseline.rawObjectsByName=[rawIndex copy];
    NSHashTable *seenObjects=[NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality];
    NSMutableSet<NSString *> *seenNames=[NSMutableSet set];
    NSMutableArray *statistics=[NSMutableArray array];
    NSMutableDictionary *statisticsIndexes=[NSMutableDictionary dictionary];
    for (NSArray *source in @[baseline.top,baseline.normal,baseline.allTop ?: @[]]) for (id object in source) {
        CSGroupRow *display=CSGroupRowForNativeSession(object,CSNativeIdentityPath(),NO);
        if (!display) return nil;
        if ([seenObjects containsObject:object] || (display.userName.length && [seenNames containsObject:display.userName])) continue;
        [seenObjects addObject:object];if (display.userName.length) [seenNames addObject:display.userName];
        id preferred=display.userName.length ? rawByName[display.userName] : nil;
        CSGroupRow *raw=preferred ? CSGroupRowForNativeSession(preferred,CSNativeIdentityPath(),NO) : nil;
        BOOL compatible=raw && [raw.userName isEqual:display.userName] && raw.kind==display.kind && raw.category==display.category;
        if (display.userName.length) statisticsIndexes[display.userName]=@(statistics.count);
        [statistics addObject:compatible ? preferred : object];
    }
    baseline.statisticsIndexes=[statisticsIndexes copy];
    return [statistics copy];
}
- (BOOL)canReuseStatisticsFrom:(CSNativeSessionBaseline *)previous forBaseline:(CSNativeSessionBaseline *)current {
    if (!previous || !self.pendingNativeChangesKnown || !self.pendingNativeNames.count ||
        ![self accountMatchesBaseline:previous] || ![self identitiesMatch:previous] ||
        previous.totalTopCount!=current.totalTopCount || previous.chatBoxMinIndex!=current.chatBoxMinIndex ||
        previous.hasChatBoxMinIndex!=current.hasChatBoxMinIndex ||
        !CSNativeSameObjects(previous.top,current.top) || !CSNativeSameObjects(previous.normal,current.normal) ||
        !CSNativeSameObjects(previous.allTop,current.allTop) || !CSNativeSameObjects(previous.allSessions,current.allSessions)) return NO;
    for (NSString *name in self.pendingNativeNames) {
        NSArray *displayObjects=previous.displayObjectsByName[name];
        NSNumber *index=previous.statisticsIndexes[name];
        if (!displayObjects.count || !index || index.unsignedIntegerValue>=previous.statisticsSessions.count) return NO;
        CSGroupRow *display=CSGroupRowForNativeSession(displayObjects[0],CSNativeIdentityPath(),NO);
        if (display.kind!=CSGroupRowKindSession || ![display.userName isEqual:name]) return NO;
        id preferred=nil;BOOL ambiguous=NO;
        for (id object in previous.rawObjectsByName[name]) {
            CSGroupRow *row=CSGroupRowForNativeSession(object,CSNativeIdentityPath(),NO);
            if (![row.userName isEqual:name]) return NO;
            id session=CSGroupReadObject(object,@"mainSession") ?: object;
            if (CSNativeMethod(session,@"isHidden","B@:") && ((BOOL(*)(id,SEL))objc_msgSend)(session,NSSelectorFromString(@"isHidden"))) continue;
            if (preferred) { ambiguous=YES;break; }
            preferred=object;
        }
        CSGroupRow *raw=preferred && !ambiguous ? CSGroupRowForNativeSession(preferred,CSNativeIdentityPath(),NO) : nil;
        BOOL compatible=raw && raw.kind==display.kind && raw.category==display.category;
        id selected=compatible ? preferred : displayObjects[0];
        if (previous.statisticsSessions[index.unsignedIntegerValue]!=selected) return NO;
    }
    current.identities=previous.identities;current.displayObjectsByName=previous.displayObjectsByName;
    current.rawObjectsByName=previous.rawObjectsByName;current.statisticsIndexes=previous.statisticsIndexes;
    current.statisticsSessions=previous.statisticsSessions;current.incrementalOrigin=previous;
    return YES;
}
- (CSNativeSessionBaseline *)captureBaseline:(id)manager account:(NSString *)account epoch:(NSUInteger)epoch {
    self.captureCompatibilityFailure=NO;
    if (!CSNativeManagerSupported(manager) || !account.length) return nil;
    id rawTop=CSGroupReadObject(manager,@"topSessions"),rawNormal=CSGroupReadObject(manager,@"normalSessions");
    id rawAllTop=CSGroupReadObject(manager,@"allTopSessions");
    // Empty native partitions may be nil. Both absent still means loading;
    // one real array plus the verified scalar is a usable complete presentation.
    if (!rawTop && !rawNormal) return nil;
    NSArray *top=CSNativeArray(rawTop,NO),*normal=CSNativeArray(rawNormal,NO),*allTop=CSNativeArray(rawAllTop,YES);
    if (!top || !normal || (rawAllTop && !allTop)) { self.captureCompatibilityFailure=YES;return nil; }
    id sessionManager=CSNativeService(@"MMNewSessionMgr");
    id rawAll=CSGroupReadObject(sessionManager,@"m_arrSession");
    NSArray *all=nil;
    @try { all=CSNativeArray(rawAll,YES); }
    @catch (__unused NSException *exception) { /* Optional raw source stays unavailable. */ }
    CSNativeSessionBaseline *result=[CSNativeSessionBaseline new];
    result.top=top;result.normal=normal;result.allTop=allTop;result.allSessions=all;
    result.accountID=account;result.epoch=epoch;
    result.totalTopCount=CSGroupReadInteger(manager,@"totalTopSessionCount",-1);
    if (result.totalTopCount<0) { self.captureCompatibilityFailure=YES;return nil; }
    result.hasChatBoxMinIndex=CSNativeMethod(manager,@"chatBoxMinIndex","q@:") && CSNativeMethod(manager,@"setChatBoxMinIndex:","v@:q");
    result.chatBoxMinIndex=result.hasChatBoxMinIndex ? CSGroupReadInteger(manager,@"chatBoxMinIndex",0) : 0;
    BOOL reused=NO;
    @try { reused=[self canReuseStatisticsFrom:self.baseline forBaseline:result]; }
    @catch (__unused NSException *exception) { reused=NO; }
    if (!reused) {
        result.identities=[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality valueOptions:NSPointerFunctionsStrongMemory];
        result.statisticsSessions=[self statisticsSessionsForBaseline:result];
        if (!result.statisticsSessions) { self.captureCompatibilityFailure=YES;return nil; }
        NSMutableDictionary<NSString *,NSMutableArray *> *displayObjects=[NSMutableDictionary dictionary];
        for (NSArray *array in @[top,normal,allTop ?: @[]]) for (id session in array) {
            CSGroupRow *row=CSGroupRowForNativeSession(session,CSNativeIdentityPath(),NO);
            if (!row) { self.captureCompatibilityFailure=YES;return nil; }
            [result.identities setObject:@{@"name":row.userName ?: @"",@"class":NSStringFromClass(object_getClass(session))} forKey:session];
            if (row.userName.length) {
                if (!displayObjects[row.userName]) displayObjects[row.userName]=[NSMutableArray array];
                if ([displayObjects[row.userName] indexOfObjectIdenticalTo:session]==NSNotFound) [displayObjects[row.userName] addObject:session];
            }
        }
        NSMutableDictionary *displayIndex=[NSMutableDictionary dictionary];
        [displayObjects enumerateKeysAndObjectsUsingBlock:^(NSString *name,NSArray *objects,BOOL *stop) {
            (void)stop;displayIndex[name]=[objects copy];
        }];
        result.displayObjectsByName=[displayIndex copy];
    }
    if (![self identitiesMatch:result]) return nil;
    // Detect host list replacement/reordering during the synchronous snapshot.
    if (!CSNativeSameObjects(top,CSGroupReadObject(manager,@"topSessions") ?: @[]) ||
        !CSNativeSameObjects(normal,CSGroupReadObject(manager,@"normalSessions") ?: @[]) ||
        !CSNativeSameObjects(allTop,CSGroupReadObject(manager,@"allTopSessions"))) return nil;
    return [self accountMatchesBaseline:result] ? result : nil;
}
- (BOOL)writeTop:(NSArray *)top normal:(NSArray *)normal allTop:(NSArray *)allTop total:(long long)total restoreGeometry:(BOOL)restore {
    id manager=self.manager;
    if (!CSNativeManagerSupported(manager)) return NO;
    self.nativeArraysTouched=YES;
    BOOL wrote=YES;
    // Attempt each field independently. If one setter throws, the remaining
    // fields can still be closed instead of leaving a half-restored private list.
    for (NSArray *field in @[@[@"setTopSessions:",top ?: NSNull.null],
                              @[@"setNormalSessions:",normal ?: NSNull.null],
                              @[@"setAllTopSessions:",allTop ?: NSNull.null]]) {
        @try {
            id array=field[1]==NSNull.null ? nil : [field[1] mutableCopy];
            ((void(*)(id,SEL,id))objc_msgSend)(manager,NSSelectorFromString(field[0]),array);
        } @catch (__unused NSException *exception) { wrote=NO; }
    }
    @try { ((void(*)(id,SEL,long long))objc_msgSend)(manager,NSSelectorFromString(@"setTotalTopSessionCount:"),total); }
    @catch (__unused NSException *exception) { wrote=NO; }
    if (restore && self.baseline.hasChatBoxMinIndex) {
        @try { ((void(*)(id,SEL,long long))objc_msgSend)(manager,NSSelectorFromString(@"setChatBoxMinIndex:"),self.baseline.chatBoxMinIndex); }
        @catch (__unused NSException *exception) { wrote=NO; }
    }
    wrote=wrote && CSNativeSameObjects(top,CSGroupReadObject(manager,@"topSessions")) &&
        CSNativeSameObjects(normal,CSGroupReadObject(manager,@"normalSessions")) &&
        CSNativeSameObjects(allTop,CSGroupReadObject(manager,@"allTopSessions")) &&
        total==CSGroupReadInteger(manager,@"totalTopSessionCount",-1);
    if (restore && self.baseline.hasChatBoxMinIndex)
        wrote=wrote && self.baseline.chatBoxMinIndex==CSGroupReadInteger(manager,@"chatBoxMinIndex",LLONG_MIN);
    if (!wrote) return NO;
    return YES;
}
- (void)closeNativePublication {
    self.model=nil;self.boundary=YES;
    self.cachedModel=nil;self.cachedModelBaseline=nil;self.cachedModelKey=nil;
    if (self.compatibilityFallback || self.restoringCompatibilityFallback) return;
    // Never substitute an unfiltered list when the identity/policy boundary is
    // uncertain. Clearing these derived arrays does not touch host account data.
    if (CSNativeManagerSupported(self.manager)) {
        self.applied=[self writeTop:@[] normal:@[] allTop:@[] total:0 restoreGeometry:NO];
    } else self.applied=NO;
}
- (BOOL)restoreBaselineForNativeMutation {
    if (![self identitiesMatch:self.baseline] || ![self accountMatchesBaseline:self.baseline]) return NO;
    if (![self writeTop:self.baseline.top normal:self.baseline.normal allTop:self.baseline.allTop
        total:self.baseline.totalTopCount restoreGeometry:YES]) return NO;
    self.applied=NO;
    return YES;
}
- (void)queuePublicationRecovery {
    if (self.publicationRecoveryQueued || self.publicationRecoveryAttempts>=3) return;
    self.publicationRecoveryAttempts++;self.publicationRecoveryQueued=YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.publicationRecoveryQueued=NO;
        if (self.publicationRecoveryPending && self.dirty) {
            self.publicationRecoveryRunning=YES;
            @try { [self refreshFromPreferences]; }
            @finally { self.publicationRecoveryRunning=NO; }
        }
    });
}
- (void)performPublication:(void (^)(void))publication {
    BOOL outer=self.publicationDepth==0;
    NSUInteger version=self.publicationMutationRevision;
    self.publicationDepth++;
    @try { publication(); }
    @finally {
        self.publicationDepth--;
        if (outer && version!=self.publicationMutationRevision) {
            // A native callback changed the source after capture or while the
            // derived arrays were being written. Never publish copied metadata
            // from before that callback, or clear its pending invalidation.
            if (!self.publicationRecoveryPending) {
                self.publicationRecoveryAccount=CSGroupCurrentAccountID();
                self.publicationRecoveryEpoch=CSCloseFriendAccountEpoch();
                self.publicationRecoveryManager=self.manager;
            }
            self.dirty=YES;self.publicationRecoveryPending=YES;
            self.revision++;self.sourceChanged=YES;
            self.publicationDepth++;
            @try { [self closeNativePublication]; }
            @finally { self.publicationDepth--; }
            [self queuePublicationRecovery];
        } else if (outer && !self.boundary && !self.dirty) {
            self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0;
        }
    }
}
- (void)applyBaseline {
    [self performPublication:^{ [self applyBaselineCandidate]; }];
}
- (NSArray *)modelKeyForPolicy:(CSCloseFriendSnapshot *)policy grouping:(BOOL)grouping {
    NSMutableArray *definitions=[NSMutableArray array];
    for (WESessionTabItem *tab in self.preferences.tabs)
        [definitions addObject:@[[tab.tabId copy] ?: @"",@(tab.type),[tab.tabName copy] ?: @"",[tab.sessionUserNames copy] ?: @[]]];
    return @[self.baseline.accountID ?: @"",@(self.baseline.epoch),@(policy.revision),@(grouping),
        @(self.preferences.filterDuplicates),[definitions copy],
        [policy.protectedUserNames copy] ?: [NSSet set],@([policy concealsSurface:CSCloseFriendSurfaceSession])];
}
- (void)applyBaselineCandidate {
    if (self.compatibilityFallback || self.restoringCompatibilityFallback) return;
    CSNativeSessionBaseline *baseline=self.baseline;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    NSString *account=CSGroupCurrentAccountID();NSUInteger epoch=CSCloseFriendAccountEpoch();
    if (!baseline || ![self accountMatchesBaseline:baseline] || policy.blocked ||
        ![policy.options[@"hideSessions"] isKindOfClass:NSNumber.class] || ![policy.accountID isEqual:account]) {
        [self closeNativePublication];return;
    }
    if (!self.preferences || ![self.preferences.accountID isEqual:account])
        self.preferences=[[CSGroupPreferences alloc] initWithDefaults:NSUserDefaults.standardUserDefaults accountID:account];
    else [self.preferences reload];
    BOOL grouping=CSNativeGroupEnabled() && [self permitsSelectedGroup];
    NSSet *hidden=[policy concealsSurface:CSCloseFriendSurfaceSession] ? policy.protectedUserNames : [NSSet set];
    NSArray *key=[self modelKeyForPolicy:policy grouping:grouping];
    BOOL sameConfiguration=self.cachedModel.isValid && [key isEqual:self.cachedModelKey];
    CSGroupNativeModelResult *model=nil;
    BOOL selectionChanged=grouping && ![self.cachedModel.selectedTabID isEqual:self.preferences.selectedTabID];
    NSArray *folded=nil;BOOL copiedFolded=NO;
    if (sameConfiguration && self.cachedModelBaseline==baseline && !selectionChanged) model=self.cachedModel;
    else if (sameConfiguration) {
        // ChatBox has an independent native source. A stable main baseline does
        // not prove that its child membership/unread/order snapshot is current.
        // Re-copy only these children before selection or delta reuse; any
        // mismatch returns to the complete-source model path below.
        folded=CSGroupCopyFoldedRowsSelectingSummary(^CSGroupRow *(NSArray *rows) { (void)rows;return nil; });
        copiedFolded=YES;
        CSGroupNativeModelResult *candidate=nil;
        if (self.cachedModelBaseline==baseline) candidate=self.cachedModel;
        else if (baseline.incrementalOrigin==self.cachedModelBaseline && self.pendingNativeChangesKnown) {
            candidate=[CSGroupNativeModel modelBySelectingTabID:self.cachedModel.selectedTabID fromResult:self.cachedModel foldedRows:folded];
            if (candidate) candidate=[CSGroupNativeModel modelByUpdatingResult:candidate changedUserNames:self.pendingNativeNames
                rowProvider:^CSGroupRow *(id session,NSIndexPath *path,BOOL top) { return CSGroupRowForNativeSession(session,path,top); }];
        }
        if (candidate) model=[CSGroupNativeModel modelBySelectingTabID:self.preferences.selectedTabID fromResult:candidate foldedRows:folded];
        // The delta API has verified unchanged identities, membership and native
        // partitions. A source event's speculative Structure hint is resolved.
        if (model && self.cachedModelBaseline!=baseline) self.pendingNativeKind&=~CSGroupChangeStructure;
    }
    if (!model) {
        // Membership/counts only; the list adapter formats the selected digest.
        if (!copiedFolded) folded=CSGroupCopyFoldedRowsSelectingSummary(^CSGroupRow *(NSArray *rows) { (void)rows;return nil; });
        model=[CSGroupNativeModel buildWithTopSessions:baseline.top normalSessions:baseline.normal
            allTopSessions:baseline.allTop allSessions:baseline.statisticsSessions tabs:self.preferences.tabs
            selectedTabID:self.preferences.selectedTabID groupingEnabled:grouping filterDuplicates:self.preferences.filterDuplicates
            accountID:account hiddenUserNames:hidden privacyRevision:policy.revision scopeFoldedEntry:grouping foldedRows:folded
            rowProvider:^CSGroupRow *(id session,NSIndexPath *path,BOOL top) { return CSGroupRowForNativeSession(session,path,top); }];
    }
    if (![self completeSourcePolicy:policy matchesBaseline:baseline surface:CSCloseFriendSurfaceSession] ||
        epoch!=CSCloseFriendAccountEpoch() || self.dirty) {
        [self closeNativePublication];return;
    }
    if (!model.isValid) { [self useCompatibilityFallback];return; }
    BOOL originalArrays=(!grouping || [model.selectedTabID isEqual:@"preset_0"]) && !hidden.count;
    NSArray *top=originalArrays ? baseline.top : model.topSessions;
    NSArray *normal=originalArrays ? baseline.normal : model.normalSessions;
    NSArray *allTop=originalArrays ? baseline.allTop : model.allTopSessions;
    long long total=originalArrays ? baseline.totalTopCount : (long long)MIN(model.totalTopSessionCount,(NSUInteger)LLONG_MAX);
    // Reapplying a stable group does not replace host mutable arrays or generate
    // notifications. Native updates still get their own original-first capture.
    BOOL needsWrite=!CSNativeSameObjects(top,CSGroupReadObject(self.manager,@"topSessions")) ||
        !CSNativeSameObjects(normal,CSGroupReadObject(self.manager,@"normalSessions")) ||
        !CSNativeSameObjects(allTop,CSGroupReadObject(self.manager,@"allTopSessions")) ||
        total!=CSGroupReadInteger(self.manager,@"totalTopSessionCount",-1) ||
        (originalArrays && baseline.hasChatBoxMinIndex && baseline.chatBoxMinIndex!=CSGroupReadInteger(self.manager,@"chatBoxMinIndex",LLONG_MIN));
    if (needsWrite) {
        // A preference-only group switch also replaces several native fields.
        // Synchronous observers must not publish the old model halfway through.
        self.boundary=YES;self.model=nil;
        if (![self writeTop:top normal:normal allTop:allTop total:total restoreGeometry:originalArrays]) {
            [self closeNativePublication];return;
        }
    }
    // Getters and setters above may synchronously relock privacy or mutate the
    // source, including when no arrays needed writing. Authorize publication
    // only after the final native identity read has completed.
    if (![self completeSourcePolicy:policy matchesBaseline:baseline surface:CSCloseFriendSurfaceSession] ||
        self.dirty || self.baseline!=baseline || epoch!=CSCloseFriendAccountEpoch()) {
        [self closeNativePublication];return;
    }
    self.model=model;self.boundary=NO;self.applied=!originalArrays;
    self.accountID=account;self.epoch=epoch;self.privacyRevision=policy.revision;
    self.cachedModel=model;self.cachedModelBaseline=baseline;self.cachedModelKey=key;
}
- (void)performNativeRebuildForManager:(id)manager original:(void (^)(void))original {
    if (self.compatibilityFallback || [self recordCompatibilityNativeChange]) { original();return; }
    if (!NSThread.isMainThread) {
        // Keep the host's threading contract. No private getter is read here;
        // the next main-thread rebuild captures a coherent native baseline.
        @try { original(); } @finally {
            dispatch_async(dispatch_get_main_queue(), ^{ if (CSNativeRegisteredManager(manager)) [self invalidateNativeData]; });
        }
        return;
    }
    id service=CSNativeService(@"MainSessionMgr");
    // A selection page may construct its own manager. Only the registered main
    // account service owns the arrays published by the main-list adapter.
    if (service && service!=manager) { original();return; }
    if (!CSNativeManagerSupported(manager)) {
        original();
        // The host just rebuilt its own complete source; no selected result is
        // retained when the installed ABI cannot be used on this version.
        self.applied=NO;self.baseline=nil;
        [self useCompatibilityFallback];return;
    }
    if (self.depth || self.publicationDepth) {
        // A source read may synchronously trigger a real native change. Its
        // result cannot then be accepted as a stable complete-source read.
        if (self.completeSourceDepth || self.publicationDepth) {
            self.dirty=YES;
            if (self.publicationDepth) self.publicationMutationRevision++;
        }
        original();return;
    }
    if (!self.refreshing) { self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0; }
    if (!self.pendingNativeChanges || (!self.changeScopeDepth && !self.refreshing)) [self recordChangeNames:nil kind:CSGroupChangeUnknown];
    if (self.manager!=manager) { self.manager=manager;self.baseline=nil;self.model=nil;self.applied=NO; }
    NSString *account=CSGroupCurrentAccountID();NSUInteger epoch=CSCloseFriendAccountEpoch();
    self.depth++;BOOL succeeded=NO;
    self.boundary=YES;self.model=nil;
    @try {
        // A rebuild must never consume this coordinator's previous filtered
        // output as the full source. Restore only within the verified account.
        BOOL restored=!(self.applied && self.baseline) || [self restoreBaselineForNativeMutation];
        original();
        // Host exceptions retain their native behavior. Exceptions in optional
        // plugin reads/formatting are contained and invalidate publication.
        @try {
            [self performPublication:^{
                BOOL sameAccount=restored && [account isEqual:CSGroupCurrentAccountID()] && epoch==CSCloseFriendAccountEpoch();
                self.captureCompatibilityFailure=NO;
                self.baseline=sameAccount ?
                    [self captureBaseline:manager account:account epoch:epoch] : nil;
                self.dirty=NO;self.revision++;self.sourceChanged=YES;
                if (!self.baseline && sameAccount && self.captureCompatibilityFailure) [self useCompatibilityFallback];
                else [self applyBaseline];
            }];
        } @catch (__unused NSException *exception) { self.baseline=nil;[self closeNativePublication]; }
        succeeded=YES;
    } @finally {
        if (!succeeded) { self.baseline=nil;self.dirty=YES;[self closeNativePublication]; }
        self.depth--;
        if (!self.depth) [self notifySourceRevision];
    }
}
- (void)performNativeMutationForManager:(id)manager original:(void (^)(void))original {
    if (self.compatibilityFallback || [self recordCompatibilityNativeChange]) { original();return; }
    if (!NSThread.isMainThread) {
        @try { original(); } @finally {
            dispatch_async(dispatch_get_main_queue(), ^{ if (CSNativeRegisteredManager(manager)) [self invalidateNativeData]; });
        }
        return;
    }
    if (!CSNativeRegisteredManager(manager)) { original();return; }
    if (!self.pendingNativeChanges || !self.changeScopeDepth) [self recordChangeNames:nil kind:CSGroupChangeUnknown];
    if (self.depth || self.publicationDepth) {
        if (self.completeSourceDepth || self.publicationDepth) {
            self.dirty=YES;
            if (self.publicationDepth) self.publicationMutationRevision++;
        }
        original();return;
    }
    self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0;
    self.depth++;
    self.boundary=YES;self.model=nil;
    BOOL restored=YES;
    @try {
        if (self.applied && self.baseline) restored=[self restoreBaselineForNativeMutation];
        original();
    } @finally {
        self.depth--;self.dirty=YES;
        if (!restored) { self.baseline=nil;[self closeNativePublication]; }
        // Rebuild before returning to the caller. An async restore/apply would
        // leave unfiltered private rows observable for a run-loop iteration.
        [self refreshFromPreferences];
    }
}
- (BOOL)completeSourcePolicy:(CSCloseFriendSnapshot *)policy matchesBaseline:(CSNativeSessionBaseline *)baseline surface:(CSCloseFriendSurface)surface {
    NSString *option=surface==CSCloseFriendSurfaceSession ? @"hideSessions" :
        (surface==CSCloseFriendSurfaceForward ? @"hideForwarding" : nil);
    if (!option || !policy || !baseline || ![self identitiesMatch:baseline]) return NO;
    // Identity getters are host code and may synchronously change policy.
    // Take the authorization snapshot after them, then compare pure state.
    CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
    return !current.blocked && current.revision==policy.revision &&
        [current.options[option] isKindOfClass:NSNumber.class] &&
        [current.accountID isEqual:baseline.accountID] && [policy.accountID isEqual:baseline.accountID] &&
        [self accountMatchesBaseline:baseline];
}
- (BOOL)performWithCompleteSourceForSurface:(CSCloseFriendSurface)surface original:(void (^)(void))original {
    if (!NSThread.isMainThread || !original || self.restoringCompleteSource ||
        (surface!=CSCloseFriendSurfaceSession && surface!=CSCloseFriendSurfaceForward)) return NO;
    if (self.completeSourceDepth) {
        // Nested readers share one verified view; changing privacy surfaces in
        // that scope could expose a candidate rejected by the outer reader.
        CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
        if (![self completeSourcePolicy:policy matchesBaseline:self.baseline surface:surface] ||
            !self.completeSourceReady || surface!=self.completeSourceSurface || self.dirty ||
            self.completeSourceEpoch!=CSCloseFriendAccountEpoch() ||
            ![self.completeSourceAccount isEqual:CSGroupCurrentAccountID()] ||
            self.completeSourcePrivacyRevision!=policy.revision) return NO;
        original();
        CSCloseFriendSnapshot *after=CSCloseFriendCurrentSnapshot();
        return [self completeSourcePolicy:after matchesBaseline:self.baseline surface:surface] &&
            !self.dirty && self.completeSourceEpoch==CSCloseFriendAccountEpoch() &&
            self.completeSourcePrivacyRevision==after.revision;
    }
    if (self.depth || self.refreshing) return NO;
    id registeredManager=CSNativeService(@"MainSessionMgr");
    if (self.compatibilityFallback || (!CSNativeManagerSupported(registeredManager) && !CSNativeManagerSupported(self.manager) &&
        !self.baseline && !self.applied)) {
        // No arrays have been taken over on this host/version. Preserve native
        // consumers rather than disabling them merely because grouping's ABI
        // is unavailable. Their established canShowSession/privacy hooks still
        // perform surface filtering; never take this path for a managed source
        // whose baseline has become unavailable or unsafe.
        CSCloseFriendSnapshot *before=CSCloseFriendCurrentSnapshot();
        NSString *account=CSGroupCurrentAccountID();NSUInteger epoch=CSCloseFriendAccountEpoch();
        NSString *option=surface==CSCloseFriendSurfaceSession ? @"hideSessions" : @"hideForwarding";
        if (!account.length || CSBackupAccountIsSuspended() || before.blocked ||
            ![before.accountID isEqual:account] || ![before.options[option] isKindOfClass:NSNumber.class]) return NO;
        original();
        CSCloseFriendSnapshot *after=CSCloseFriendCurrentSnapshot();
        return !CSBackupAccountIsSuspended() && epoch==CSCloseFriendAccountEpoch() &&
            [account isEqual:CSGroupCurrentAccountID()] && [after.accountID isEqual:account] &&
            !after.blocked && before.revision==after.revision && [after.options[option] isKindOfClass:NSNumber.class];
    }
    [self refreshFromPreferences];
    CSNativeSessionBaseline *baseline=self.baseline;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (![self completeSourcePolicy:policy matchesBaseline:baseline surface:surface] ||
        self.depth || self.refreshing || self.dirty || self.boundary) return NO;

    self.completeSourceDepth=1;self.completeSourceReady=NO;self.completeSourceSurface=surface;
    self.completeSourceAccount=baseline.accountID;self.completeSourceEpoch=baseline.epoch;
    self.completeSourcePrivacyRevision=policy.revision;
    self.depth++;self.boundary=YES;self.model=nil;
    BOOL prepared=NO,accepted=NO;
    @try {
        // Optional plugin reads are contained. The caller's host implementation
        // below deliberately keeps its original exception behavior.
        @try {
            NSSet *hidden=[policy concealsSurface:surface] ? policy.protectedUserNames : [NSSet set];
            NSArray *folded=CSGroupCopyFoldedRowsSelectingSummary(^CSGroupRow *(NSArray *rows) { (void)rows;return nil; });
            CSGroupNativeModelResult *model=[CSGroupNativeModel buildWithTopSessions:baseline.top normalSessions:baseline.normal
                allTopSessions:baseline.allTop allSessions:baseline.statisticsSessions tabs:self.preferences.tabs
                selectedTabID:self.preferences.selectedTabID groupingEnabled:NO filterDuplicates:self.preferences.filterDuplicates
                accountID:baseline.accountID hiddenUserNames:hidden privacyRevision:policy.revision scopeFoldedEntry:NO foldedRows:folded
                rowProvider:^CSGroupRow *(id session,NSIndexPath *path,BOOL top) { return CSGroupRowForNativeSession(session,path,top); }];
            CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
            if (model.isValid && [self completeSourcePolicy:current matchesBaseline:baseline surface:surface] &&
                !self.dirty && current.revision==policy.revision) {
                // Mark the temporary presentation before invoking setters so a
                // nested native event cannot later treat it as a new baseline.
                self.applied=YES;
                prepared=[self writeTop:hidden.count ? model.topSessions : baseline.top
                    normal:hidden.count ? model.normalSessions : baseline.normal
                    allTop:hidden.count ? model.allTopSessions : baseline.allTop
                    total:hidden.count ? (long long)MIN(model.totalTopSessionCount,(NSUInteger)LLONG_MAX) : baseline.totalTopCount
                    restoreGeometry:!hidden.count];
                current=CSCloseFriendCurrentSnapshot();
                prepared=prepared && [self completeSourcePolicy:current matchesBaseline:baseline surface:surface] &&
                    !self.dirty && current.revision==policy.revision;
            }
        } @catch (__unused NSException *exception) { prepared=NO; }
        if (prepared) {
            self.completeSourceReady=YES;
            original();
            CSCloseFriendSnapshot *after=CSCloseFriendCurrentSnapshot();
            accepted=[self completeSourcePolicy:after matchesBaseline:baseline surface:surface] &&
                !self.dirty && self.baseline==baseline && after.revision==policy.revision;
        }
    } @finally {
        self.completeSourceReady=NO;self.completeSourceDepth=0;self.completeSourceAccount=nil;self.depth--;
        self.restoringCompleteSource=YES;
        // No run-loop iteration or UI notification can occur with the temporary
        // All presentation. A genuine nested source change requires a guarded
        // original-first rebuild before the selected group can be restored.
        @try {
            if (self.dirty || ![self accountMatchesBaseline:baseline]) [self refreshFromPreferences];
            else {
                @try { [self applyBaseline]; }
                @catch (__unused NSException *exception) { self.baseline=nil;[self closeNativePublication]; }
            }
        } @finally {
            self.restoringCompleteSource=NO;
            // A synchronous main-list callback may have installed a privacy
            // shield while the temporary view was active. Publish one boundary
            // revision so that surface can release it after safe restoration.
            self.revision++;self.sourceChanged=YES;
            [self notifySourceRevision];
        }
    }
    CSCloseFriendSnapshot *finalPolicy=CSCloseFriendCurrentSnapshot();
    return accepted && [self completeSourcePolicy:finalPolicy matchesBaseline:baseline surface:surface] &&
        !self.boundary && !self.dirty && self.baseline==baseline && finalPolicy.revision==policy.revision;
}
- (void)refreshFromPreferences {
    if (!NSThread.isMainThread) { [self queueRefresh];return; }
    if (self.compatibilityFallback || self.restoringCompatibilityFallback) return;
    if (self.depth || self.publicationDepth || self.refreshing) return;
    NSString *currentAccount=CSGroupCurrentAccountID();
    id currentManager=CSNativeService(@"MainSessionMgr");
    BOOL sameRecoveryAccount=currentAccount==self.publicationRecoveryAccount ||
        [currentAccount isEqual:self.publicationRecoveryAccount];
    if (self.publicationRecoveryPending && (!sameRecoveryAccount ||
        self.publicationRecoveryEpoch!=CSCloseFriendAccountEpoch() ||
        (currentManager && currentManager!=self.publicationRecoveryManager))) {
        // Recovery exhaustion belongs to one account/service boundary. Detect a
        // new boundary even if the host omitted its usual clear/policy callback.
        self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0;
    }
    // Repeated setter notifications must not keep the run loop rebuilding
    // indefinitely. A genuine native event/invalidation starts a fresh budget.
    if (self.publicationRecoveryPending && self.publicationRecoveryAttempts>=3 &&
        !self.publicationRecoveryQueued && !self.publicationRecoveryRunning) return;
    self.refreshing=YES;
    @try {
        id manager=CSNativeService(@"MainSessionMgr");
        if (!manager && [self accountMatchesBaseline:self.baseline]) manager=self.manager;
        if (!CSNativeManagerSupported(manager)) { [self useCompatibilityFallback];return; }
        if (self.manager!=manager) { self.manager=manager;self.baseline=nil;self.dirty=YES; }
        if (![self accountMatchesBaseline:self.baseline]) { self.baseline=nil;self.model=nil;self.dirty=YES; }
        if (self.dirty || !self.baseline) {
            // This call must enter the guarded rebuild hook; it is the sole
            // place allowed to promote host arrays into a complete baseline.
            ((void(*)(id,SEL))objc_msgSend)(manager,NSSelectorFromString(@"rebuildMainSessions"));
            if (!self.baseline) [self closeNativePublication];
        } else [self applyBaseline];
    } @catch (__unused NSException *exception) { self.baseline=nil;[self closeNativePublication]; }
    @finally { self.refreshing=NO;[self notifySourceRevision]; }
}
- (void)queueRefresh {
    @synchronized (self) { if (self.refreshQueued) return;self.refreshQueued=YES; }
    dispatch_async(dispatch_get_main_queue(), ^{
        @synchronized (self) { self.refreshQueued=NO; }
        [self refreshFromPreferences];
    });
}
- (void)invalidateNativeData {
    if ([self recordCompatibilityNativeChange]) return;
    if (NSThread.isMainThread) {
        if (!self.changeScopeDepth) [self recordChangeNames:nil kind:CSGroupChangeUnknown];
        self.dirty=YES;
        if (self.publicationDepth) self.publicationMutationRevision++;
        else if (!self.depth) { self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0; }
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{ [self invalidateNativeData]; });
        return;
    }
    if (!self.depth) [self queueRefresh];
}
- (void)privacyChanged:(NSNotification *)notification {
    (void)notification;
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self privacyChanged:nil]; });return; }
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (!policy.blocked && [policy.options[@"hideSessions"] isKindOfClass:NSNumber.class] &&
        policy.revision==self.privacyRevision && [policy.accountID isEqual:self.accountID] && self.epoch==CSCloseFriendAccountEpoch()) return;
    if (!self.depth && !self.publicationDepth) { self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0; }
    self.revision++;self.sourceChanged=YES;
    if (self.publicationDepth) {
        self.dirty=YES;self.publicationMutationRevision++;
        self.boundary=YES;self.model=nil;
        return;
    }
    // Source arrays remain complete; relocking is synchronous and independent
    // of whether the main chat page is currently visible.
    if (!self.depth) [self refreshFromPreferences];
    else [self closeNativePublication];
}
- (void)nativeManagerWillClear:(id)manager {
    [self recordCompatibilityNativeChange];
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self nativeManagerWillClear:manager]; });return; }
    if (manager) {
        for (NSString *name in @[@"MainSessionMgr",@"MMNewSessionMgr"]) {
            Class cls=NSClassFromString(name);
            if (!cls || ![manager isKindOfClass:cls]) continue;
            id service=CSNativeService(name);
            if (service && service!=manager) return;
        }
    }
    [self closeNativePublication];
    self.publicationRecoveryPending=NO;self.publicationRecoveryAttempts=0;
    self.baseline=nil;self.preferences=nil;self.accountID=nil;self.epoch=CSCloseFriendAccountEpoch();
    self.cachedModel=nil;self.cachedModelBaseline=nil;self.cachedModelKey=nil;
    [self recordChangeNames:nil kind:CSGroupChangeUnknown];
    self.nativePresentation=NO;
    self.dirty=YES;self.revision++;self.sourceChanged=YES;
    [self notifySourceRevision];
}
- (void)notifySourceRevision {
    if (self.depth || self.publicationDepth || self.refreshing || self.restoringCompleteSource ||
        !self.sourceChanged || self.notifiedRevision==self.revision) return;
    self.sourceChanged=NO;self.notifiedRevision=self.revision;
    NSDictionary *info=@{@"revision":@(self.revision),@"boundary":@(self.boundary),
        @"changes":@(self.pendingNativeChanges ? self.pendingNativeKind : CSGroupChangeUnknown),
        @"changedUserNames":[self.pendingNativeNames copy] ?: [NSSet set],
        @"allChangesKnown":@(self.pendingNativeChanges && self.pendingNativeChangesKnown)};
    self.pendingNativeChanges=NO;self.pendingNativeChangesKnown=NO;self.pendingNativeNames=nil;self.pendingNativeKind=0;
    [NSNotificationCenter.defaultCenter postNotificationName:CSGroupNativeSessionModelDidChangeNotification object:self
        userInfo:info];
}
- (long long)foldSessionCountWithNativeCount:(long long)nativeCount {
    if (self.compatibilityFallback || self.restoringCompatibilityFallback) return nativeCount;
    if (!NSThread.isMainThread || self.depth) return nativeCount;
    if (self.boundary) return 0;
    if (![self accountMatchesBaseline:self.baseline]) return 0;
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (policy.blocked || policy.revision!=self.privacyRevision || ![policy.accountID isEqual:self.accountID] ||
        ![policy.options[@"hideSessions"] isKindOfClass:NSNumber.class]) return 0;
    if (!self.applied) return nativeCount;
    return (long long)MIN(self.model.totalTopSessionCount,(NSUInteger)LLONG_MAX);
}
- (CSGroupRow *)rowForSession:(id)session path:(NSIndexPath *)path {
    if (!NSThread.isMainThread || self.depth || self.boundary || !self.model.isValid ||
        ![path isKindOfClass:NSIndexPath.class] || path.length!=2 || ![self accountMatchesBaseline:self.baseline]) return nil;
    CSGroupRow *current=CSGroupRowForNativeSession(session,path,NO),*row=[self.model rowForSession:session];
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if (!current || !row || ![(current.userName ?: @"") isEqual:(row.userName ?: @"")] ||
        policy.blocked || policy.revision!=self.privacyRevision || ![policy.accountID isEqual:self.accountID] ||
        ![policy.options[@"hideSessions"] isKindOfClass:NSNumber.class]) return nil;
    // model coordinates are synthetic; callers use this row only as immutable
    // presentation metadata and keep the table's actual native indexPath.
    return row;
}
@end
