#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSGroupNativeSessionCoordinator.h"
#import "../Controllers/CSGroupNativeBridge.h"
#import "../Controllers/CSCloseFriendBridge.h"
#import "../Controllers/CSServiceCenter.h"
#import <objc/message.h>
#import <objc/runtime.h>

// Optional private selectors are installed only after their concrete ABI is
// checked. A missing selector is never added as a replacement host capability.
static BOOL CSNativeGroupHook0(NSString *className, NSString *name, void (^body)(id,void (^)(void))) {
    __block IMP original=NULL;SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object) {
        body(object,^{ ((void(*)(id,SEL))original)(object,selector); });
    });
    BOOL installed=CSCloseFriendInstallHook(className,name,replacement,&original,"v@:");
    if (!installed) imp_removeBlock(replacement);
    return installed;
}
static NSArray *CSNativeGroupCopyEnumerator(id enumerator) {
    if (!enumerator) return @[];
    Method method=class_getInstanceMethod(object_getClass(enumerator),@selector(allObjects));
    if (!CSCloseFriendMethodMatches(method,"@@:")) return nil;
    @try {
        id values=((id(*)(id,SEL))objc_msgSend)(enumerator,@selector(allObjects));
        if (![values isKindOfClass:NSArray.class] || [values count]>100000) return nil;
        return [values copy];
    } @catch (__unused NSException *exception) { return nil; }
}
static NSSet *CSNativeGroupChangedNames(id sessions,id notifiedName) {
    if (!NSThread.isMainThread) return nil;
    @try {
        NSArray *values=[sessions isKindOfClass:NSArray.class] ? sessions :
            ([sessions isKindOfClass:NSDictionary.class] ? [sessions allValues] :
            ([sessions isKindOfClass:NSSet.class] ? [sessions allObjects] : nil));
        if (!values || values.count>100000) return nil;
        NSMutableSet *names=[NSMutableSet set];
        for (id object in values) {
            id session=CSGroupReadObject(object,@"mainSession") ?: object;
            id name=[session isKindOfClass:NSString.class] ? session :
                (CSGroupReadObject(session,@"m_nsUserName") ?: CSGroupReadObject(session,@"sessionId"));
            if (![name isKindOfClass:NSString.class] || ![name length]) return nil;
            [names addObject:[name copy]];
        }
        if ([notifiedName isKindOfClass:NSString.class] && [notifiedName length]) [names addObject:[notifiedName copy]];
        return names.count ? [names copy] : nil;
    } @catch (__unused NSException *exception) { return nil; }
}
static void CSNativeGroupUnknownMutation(CSGroupNativeSessionCoordinator *coordinator,id manager,void (^native)(void)) {
    [coordinator performChangeForUserNames:nil kind:CSGroupChangeUnknown original:^{
        [coordinator performNativeMutationForManager:manager original:native];
    }];
}
static void CSNativeGroupInstallHooks(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSGroupNativeSessionCoordinator *coordinator=CSGroupNativeSessionCoordinator.sharedCoordinator;
        {
            __block IMP original=NULL;SEL selector=NSSelectorFromString(@"forwardableSessionEnumerator");
            IMP replacement=imp_implementationWithBlock(^id(id manager) {
                // A selector/forward picker may own a separate manager. Its
                // native source never belongs to the main-list coordinator.
                id mainManager=CSGetService(NSClassFromString(@"MainSessionMgr"));
                if (mainManager && manager!=mainManager)
                    return ((id(*)(id,SEL))original)(manager,selector);
                __block NSArray *sessions=nil;
                BOOL accepted=[coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceForward original:^{
                    sessions=CSNativeGroupCopyEnumerator(((id(*)(id,SEL))original)(manager,selector));
                }];
                // Consume the native enumerator while the complete source is
                // installed. The returned enumerator owns a frozen array and
                // cannot lazily read the restored, selected main-list source.
                return [(accepted && sessions ? sessions : @[]) objectEnumerator];
            });
            if (!CSCloseFriendInstallHook(@"MainSessionMgr",@"forwardableSessionEnumerator",replacement,&original,"@@:")) imp_removeBlock(replacement);
        }
        CSNativeGroupHook0(@"MainSessionMgr",@"rebuildMainSessions",^(id manager,void (^native)(void)) {
            [coordinator performNativeRebuildForManager:manager original:native];
        });
        // Native notifications can synchronously rebuild or enumerate the main
        // manager. Restore the verified full baseline for the outer operation,
        // then capture/apply again before returning to its caller.
        for (NSString *name in @[@"updateMainSessionList",@"onNeedReload"]) {
            CSNativeGroupHook0(@"MainSessionMgr",name,^(id manager,void (^native)(void)) {
                CSNativeGroupUnknownMutation(coordinator,manager,native);
            });
        }
        {
            __block IMP original=NULL;SEL selector=NSSelectorFromString(@"updateMainSessionListNotify:");
            IMP replacement=imp_implementationWithBlock(^(id manager,BOOL notify) {
                CSNativeGroupUnknownMutation(coordinator,manager,^{
                    ((void(*)(id,SEL,BOOL))original)(manager,selector,notify);
                });
            });
            if (!CSCloseFriendInstallHook(@"MainSessionMgr",@"updateMainSessionListNotify:",replacement,&original,"v@:B")) imp_removeBlock(replacement);
        }
        {
            __block IMP original=NULL;SEL selector=NSSelectorFromString(@"removeSessionWithUserName:");
            IMP replacement=imp_implementationWithBlock(^BOOL(id manager,id userName) {
                __block BOOL removed=NO;
                CSNativeGroupUnknownMutation(coordinator,manager,^{
                    removed=((BOOL(*)(id,SEL,id))original)(manager,selector,userName);
                });
                return removed;
            });
            if (!CSCloseFriendInstallHook(@"MainSessionMgr",@"removeSessionWithUserName:",replacement,&original,"B@:@")) imp_removeBlock(replacement);
        }
        for (NSString *name in @[@"checkLoadData",@"resortSessions",@"recountUnReadCount",@"recountUnReadCountAndFireExtension"]) {
            CSNativeGroupHook0(@"MMNewSessionMgr",name,^(id manager,void (^native)(void)) {
                CSNativeGroupUnknownMutation(coordinator,manager,native);
            });
        }
        {
            __block IMP original=NULL;SEL selector=NSSelectorFromString(@"updateSessions:NotifyUsrName:");
            IMP replacement=imp_implementationWithBlock(^(id manager,id sessions,id userName) {
                [coordinator performChangeForUserNames:CSNativeGroupChangedNames(sessions,userName)
                    kind:CSGroupChangeContent|CSGroupChangeStructure original:^{
                    [coordinator performNativeMutationForManager:manager original:^{
                        ((void(*)(id,SEL,id,id))original)(manager,selector,sessions,userName);
                    }];
                }];
            });
            if (!CSCloseFriendInstallHook(@"MMNewSessionMgr",@"updateSessions:NotifyUsrName:",replacement,&original,"v@:@@")) imp_removeBlock(replacement);
        }
        {
            __block IMP original=NULL;SEL selector=NSSelectorFromString(@"foldSessionCount");
            IMP replacement=imp_implementationWithBlock(^long long(id manager) {
                long long native=((long long(*)(id,SEL))original)(manager,selector);
                return [coordinator foldSessionCountWithNativeCount:native];
            });
            if (!CSCloseFriendInstallHook(@"MMNewSessionMgr",@"foldSessionCount",replacement,&original,"q@:")) imp_removeBlock(replacement);
        }
        for (NSString *className in @[@"MainSessionMgr",@"MMNewSessionMgr"]) {
            CSNativeGroupHook0(className,@"onServiceClearData",^(id manager,void (^native)(void)) {
                [coordinator nativeManagerWillClear:manager];native();
            });
            CSNativeGroupHook0(className,@"onServiceInit",^(id manager,void (^native)(void)) {
                (void)manager;@try { native(); } @finally { [coordinator invalidateNativeData]; }
            });
        }
    });
}

%ctor {
    CSBackupWhenReady(^{
        if (NSThread.isMainThread) CSNativeGroupInstallHooks();
        else dispatch_async(dispatch_get_main_queue(), ^{ CSNativeGroupInstallHooks(); });
    });
}
