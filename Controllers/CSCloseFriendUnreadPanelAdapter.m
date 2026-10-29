#import "CSCloseFriendUnreadPanelAdapter.h"
#import "CSCloseFriendBridge.h"
#import "CSCloseFriendContactAdapter.h"
#import <objc/message.h>

@interface CSCFUnreadPanelRow : NSObject
@property(nonatomic, strong) id session;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *accountID;
@property(nonatomic) NSUInteger epoch, revision, serial;
@end
@implementation CSCFUnreadPanelRow @end

@interface CSCFUnreadPanelState : NSObject
@property(nonatomic, copy) NSString *accountID;
@property(nonatomic, copy) NSString *sourceAccountID;
@property(nonatomic) NSUInteger epoch, revision, serial, sourceDepth, sourceRevision, sourceEpoch;
@property(nonatomic) BOOL refreshing, refreshAgain, needsRebuild, followupScheduled, maskActive, maskWasHidden, safelyPublished;
@property(nonatomic, weak) UIView *maskedView;
@property(nonatomic, strong) NSMutableDictionary<NSNumber *, CSCFUnreadPanelRow *> *rows;
@property(nonatomic, strong) CSCFUnreadPanelRow *actionRow;
@end
@implementation CSCFUnreadPanelState @end
static char CSCFUnreadPanelStateKey, CSCFUnreadPanelStaleCellKey;
static BOOL PanelFilteringAvailable;
void CSCFUnreadPanelSetFilteringAvailable(BOOL available) { PanelFilteringAvailable=available; }

static CSCFUnreadPanelState *PanelState(id owner) {
    if(!owner)return nil;
    @synchronized(owner) {
        CSCFUnreadPanelState *state=objc_getAssociatedObject(owner,&CSCFUnreadPanelStateKey);
        if(!state) {
            CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
            state=[CSCFUnreadPanelState new]; state.accountID=snapshot.accountID;
            state.epoch=CSCloseFriendAccountEpoch(); state.revision=NSNotFound; state.sourceRevision=NSNotFound;
            state.rows=[NSMutableDictionary dictionary];
            objc_setAssociatedObject(owner,&CSCFUnreadPanelStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return state;
    }
}
void CSCFUnreadPanelBind(id owner) { PanelState(owner); }
static BOOL PanelCurrent(id owner,CSCloseFriendSnapshot *snapshot) {
    CSCFUnreadPanelState *state=PanelState(owner);
    return state && !snapshot.blocked && snapshot.accountID.length && state.epoch==CSCloseFriendAccountEpoch() &&
        [state.accountID isEqual:snapshot.accountID];
}
BOOL CSCFUnreadPanelIsCurrent(id owner) { return PanelCurrent(owner,CSCloseFriendCurrentSnapshot()); }
static BOOL Allowed(id owner,id session,CSCloseFriendSnapshot *snapshot) {
    if(!session || !PanelCurrent(owner,snapshot))return NO;
    if(![snapshot concealsSurface:CSCloseFriendSurfaceSession])return YES;
    if(!PanelFilteringAvailable)return NO;
    NSString *name=CSCloseFriendUserName(session);
    return name.length && ![snapshot hidesUserName:name surface:CSCloseFriendSurfaceSession];
}
BOOL CSCFUnreadPanelAllowsSession(id owner,id session) { return Allowed(owner,session,CSCloseFriendCurrentSnapshot()); }
static id PanelLogic(id controller) { return CSCloseFriendRead(controller,@"dataLogic"); }
static BOOL ReadBool(id object,NSString *name,BOOL *value) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"B@:"))return NO;
    *value=((BOOL(*)(id,SEL))objc_msgSend)(object,selector); return YES;
}
static BOOL SetBool(id object,NSString *name,BOOL value) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:B"))return NO;
    ((void(*)(id,SEL,BOOL))objc_msgSend)(object,selector,value); return YES;
}
static id SessionAtIndex(id logic,NSInteger index) {
    if(index<0)return nil;
    NSArray *sessions=CSCloseFriendRead(logic,@"currentSessionList");
    return [sessions isKindOfClass:NSArray.class] && (NSUInteger)index<sessions.count ? sessions[(NSUInteger)index] : nil;
}
NSInteger CSCFUnreadPanelNotifyCount(id logic,NSInteger nativeCount) {
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(!PanelCurrent(logic,snapshot))return 0;
    if(![snapshot concealsSurface:CSCloseFriendSurfaceSession])return nativeCount;
    if(!PanelFilteringAvailable)return 0;
    CSCFUnreadPanelState *state=PanelState(logic); NSUInteger serial=state.serial;
    NSArray *sessions=CSCloseFriendRead(logic,@"currentSessionList");
    if(![sessions isKindOfClass:NSArray.class] || sessions.count>100000)return 0;
    NSInteger count=0;
    for(id session in sessions) {
        if(!Allowed(logic,session,snapshot))continue;
        NSString *name=CSCloseFriendUserName(session);
        if([name isEqual:@"chatroom_session_box"])continue;
        BOOL excluded=NO;
        for(NSString *key in @[@"isHidden",@"isInChatBox",@"isInBrandServiceBox",@"m_isFolding",@"m_bShowUnReadAsRedDot"]) {
            BOOL flag=NO; if(!ReadBool(session,key,&flag))return 0;
            if(flag) { excluded=YES; break; }
        }
        if(excluded)continue;
        SEL unread=NSSelectorFromString(@"m_uUnReadCount");
        if(!CSCloseFriendMethodMatches(class_getInstanceMethod([session class],unread),"I@:"))return 0;
        if(((unsigned int(*)(id,SEL))objc_msgSend)(session,unread)>0)count++;
    }
    CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
    return PanelCurrent(logic,current) && current.revision==snapshot.revision && state.serial==serial ? count : 0;
}

static UIView *LoadedView(id controller) {
    BOOL loaded=NO;
    if(!ReadBool(controller,@"isViewLoaded",&loaded) || !loaded)return nil;
    id view=CSCloseFriendRead(controller,@"view");
    return [view isKindOfClass:UIView.class] ? view : nil;
}
static UIView *MaskPanel(id controller) {
    CSCFUnreadPanelState *state=PanelState(controller);
    UIView *container=state.maskedView;
    if(!state.maskActive) {
        id candidate=CSCloseFriendRead(controller,@"tableContainerView");
        container=[candidate isKindOfClass:UIView.class] ? candidate : LoadedView(controller);
        if(container) {
            state.maskWasHidden=container.hidden; state.maskedView=container; state.maskActive=YES;
        }
    }
    container.hidden=YES; return container;
}
void CSCFUnreadPanelInvalidatePresentation(id controller) {
    if(!NSThread.isMainThread)return;
    // This is a retained IMAGE of the old main list, outside the live table.
    // Clearing its payload also survives native code setting hidden=NO on return.
    id transition=CSCFIsClass(controller,@"MainFrameAggregationTransition") ? controller : CSCloseFriendRead(controller,@"_transition");
    id snapshot=CSCloseFriendRead(transition,@"fromSnapshtoView");
    if([snapshot isKindOfClass:UIView.class]) {
        CSCFSetObject(snapshot,@"setImage:",nil);
        for(UIView *child in [[snapshot subviews] copy]) [child removeFromSuperview];
        [snapshot setHidden:YES]; [snapshot removeFromSuperview];
    }
}
static NSHashTable *PanelControllers(void) {
    static NSHashTable *controllers; static dispatch_once_t once;
    dispatch_once(&once,^{
        controllers=[NSHashTable weakObjectsHashTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
            for(id controller in controllers.allObjects) {
                CSCFUnreadPanelInvalidatePresentation(controller);
                CSCFUnreadPanelRefresh(controller);
            }
        }];
    });
    return controllers;
}
void CSCFUnreadPanelTrackController(id controller) {
    if(!controller || !NSThread.isMainThread)return;
    CSCFUnreadPanelBind(controller); CSCFUnreadPanelBind(PanelLogic(controller));
    [PanelControllers() addObject:controller];
}
void CSCFUnreadPanelSourceWillChange(id logic) {
    CSCFUnreadPanelState *state=PanelState(logic);
    if(!state.sourceDepth) {
        CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
        state.sourceRevision=snapshot.revision; state.sourceAccountID=snapshot.accountID;
        state.sourceEpoch=CSCloseFriendAccountEpoch();
    }
    state.sourceDepth++; state.serial++;
}
void CSCFUnreadPanelSourceDidChange(id logic) {
    CSCFUnreadPanelState *state=PanelState(logic);
    if(state.sourceDepth)state.sourceDepth--;
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(!state.sourceDepth && (state.sourceRevision!=snapshot.revision || state.sourceEpoch!=CSCloseFriendAccountEpoch() ||
       ![state.sourceAccountID isEqual:snapshot.accountID]))state.needsRebuild=YES;
    if(!state.sourceDepth && state.needsRebuild && NSThread.isMainThread) {
        state.needsRebuild=NO;
        id controller=CSCloseFriendRead(logic,@"delegate");
        if(CSCFIsClass(controller,@"MainFrameAggregationViewController"))CSCFUnreadPanelRefresh(controller);
    }
}
static void SchedulePanelRefresh(id controller) {
    CSCFUnreadPanelState *state=PanelState(controller);
    if(!state || state.followupScheduled)return;
    state.followupScheduled=YES; __weak id page=controller;
    dispatch_async(dispatch_get_main_queue(),^{
        id current=page; if(!current)return;
        PanelState(current).followupScheduled=NO;
        CSCFUnreadPanelRefresh(current);
    });
}
void CSCFUnreadPanelRefresh(id controller) {
    if(!controller || !NSThread.isMainThread)return;
    CSCFUnreadPanelTrackController(controller);
    CSCFUnreadPanelState *state=PanelState(controller); state.refreshAgain=YES;
    if(state.refreshing)return;
    id logic=PanelLogic(controller); CSCFUnreadPanelState *source=PanelState(logic);
    UIView *view=LoadedView(controller);
    UIView *container=MaskPanel(controller);
    if(source.sourceDepth) { source.needsRebuild=YES; return; }
    state.refreshing=YES;
    NSUInteger passes=0;
    @try {
        do {
            state.refreshAgain=NO; source.needsRebuild=NO;
            CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
            [state.rows removeAllObjects];
            if(state.revision!=NSNotFound && state.revision!=snapshot.revision)CSCFUnreadPanelInvalidatePresentation(controller);
            // The native rebuild enumerates the full MainSessionMgr source. Its
            // canShowSession hook rejects hidden entries before sessionSet reuse.
            BOOL rebuilt=CSCFCallVoid(logic,@"rebuildSessionList");
            state.safelyPublished=rebuilt && PanelFilteringAvailable;
            if(![snapshot concealsSurface:CSCloseFriendSurfaceSession])state.safelyPublished=YES;
            if(view && rebuilt) {
                CSCFCallVoid(controller,@"updateContent");
                SetBool(controller,@"setNeedReloadAfterTransition:",NO);
                [view layoutIfNeeded];
            }
            CSCloseFriendSnapshot *current=CSCloseFriendCurrentSnapshot();
            if(current.revision!=snapshot.revision || ![current.accountID isEqual:snapshot.accountID] || source.needsRebuild)state.refreshAgain=YES;
            state.revision=current.revision;
        } while(state.refreshAgain && ++passes<2);
    } @finally {
        state.refreshing=NO;
        // An old-account page remains blank; its binding is never adopted by a
        // later account. A current page can show the rebuilt native content.
        if(!state.refreshAgain && state.safelyPublished) {
            container.hidden=state.maskWasHidden || !CSCFUnreadPanelIsCurrent(controller) || !CSCFUnreadPanelIsCurrent(logic);
            state.maskActive=NO; state.maskedView=nil;
        } else if(state.refreshAgain) {
            // Reentrant native callbacks get a bounded synchronous retry. Keep
            // the old surface masked until the queued request can finish.
            SchedulePanelRefresh(controller);
        }
    }
}
void CSCFUnreadPanelPreparePresentation(id controller) {
    if(!NSThread.isMainThread)return;
    CSCFUnreadPanelTrackController(controller);
    CSCFUnreadPanelState *state=PanelState(controller);
    if(state.refreshing)return; // reloadData may ask for rows inside this publication.
    if(state.revision!=CSCloseFriendCurrentSnapshot().revision || state.refreshAgain ||
       !state.safelyPublished || !CSCFUnreadPanelIsCurrent(controller) || !CSCFUnreadPanelIsCurrent(PanelLogic(controller)))CSCFUnreadPanelRefresh(controller);
}
id CSCFUnreadPanelCaptureRow(id controller,NSInteger index) {
    if(!NSThread.isMainThread)return nil;
    id logic=PanelLogic(controller), session=SessionAtIndex(logic,index);
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(!Allowed(controller,session,snapshot) || !Allowed(logic,session,snapshot))return nil;
    CSCFUnreadPanelRow *row=[CSCFUnreadPanelRow new]; row.session=session; row.userName=CSCloseFriendUserName(session);
    row.accountID=snapshot.accountID; row.epoch=CSCloseFriendAccountEpoch();
    row.revision=snapshot.revision; row.serial=PanelState(logic).serial; return row;
}
BOOL CSCFUnreadPanelFinishRow(id controller,NSInteger index,id ticket,id cell) {
    id logic=PanelLogic(controller); CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    CSCFUnreadPanelRow *row=[ticket isKindOfClass:CSCFUnreadPanelRow.class] ? ticket : nil;
    NSString *currentName=CSCloseFriendUserName(row.session);
    BOOL valid=row && row.session==SessionAtIndex(logic,index) && row.epoch==CSCloseFriendAccountEpoch() &&
        [row.accountID isEqual:snapshot.accountID] && row.revision==snapshot.revision && row.serial==PanelState(logic).serial &&
        (row.userName==currentName || [row.userName isEqual:currentName]) &&
        Allowed(controller,row.session,snapshot) && Allowed(logic,row.session,snapshot);
    if(valid) {
        PanelState(controller).rows[@(index)]=row;
        NSNumber *hidden=objc_getAssociatedObject(cell,&CSCFUnreadPanelStaleCellKey);
        if(hidden && [cell isKindOfClass:UIView.class]) {
            [cell setHidden:hidden.boolValue];
            objc_setAssociatedObject(cell,&CSCFUnreadPanelStaleCellKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [PanelState(controller).rows removeObjectForKey:@(index)];
        if([cell isKindOfClass:UIView.class]) {
            if(!objc_getAssociatedObject(cell,&CSCFUnreadPanelStaleCellKey))
                objc_setAssociatedObject(cell,&CSCFUnreadPanelStaleCellKey,@([cell isHidden]),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [cell setHidden:YES];
        }
        // A late native cell can still be returned after an inner reload. Mask
        // its whole presentation synchronously until the next stable publish.
        MaskPanel(controller);
        PanelState(controller).refreshAgain=YES; SchedulePanelRefresh(controller);
    }
    return valid;
}
void CSCFUnreadPanelRecordRow(id controller,NSInteger index) {
    id ticket=CSCFUnreadPanelCaptureRow(controller,index);
    CSCFUnreadPanelFinishRow(controller,index,ticket,nil);
}
BOOL CSCFUnreadPanelAllowsOpen(id controller,id session) {
    if(!NSThread.isMainThread || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive)return NO;
    id logic=PanelLogic(controller); CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(!Allowed(controller,session,snapshot) || !Allowed(logic,session,snapshot) || PanelState(logic).sourceDepth)return NO;
    if(PanelState(controller).revision!=snapshot.revision) { CSCFUnreadPanelRefresh(controller); return NO; }
    CSCFUnreadPanelRow *expected=PanelState(controller).actionRow;
    NSString *name=CSCloseFriendUserName(session);
    if(expected && (expected.session!=session || expected.revision!=snapshot.revision || expected.epoch!=CSCloseFriendAccountEpoch() ||
       expected.serial!=PanelState(logic).serial || ![expected.accountID isEqual:snapshot.accountID] ||
       !(expected.userName==name || [expected.userName isEqual:name])))return NO;
    NSArray *sessions=CSCloseFriendRead(logic,@"currentSessionList");
    return [sessions isKindOfClass:NSArray.class] && [sessions indexOfObjectIdenticalTo:session]!=NSNotFound;
}
BOOL CSCFUnreadPanelAllowsRowAction(id controller,NSInteger index) {
    if(index<0)return NO;
    CSCFUnreadPanelRow *row=PanelState(controller).rows[@(index)];
    id logic=PanelLogic(controller), session=SessionAtIndex(logic,index);
    NSString *name=CSCloseFriendUserName(session);
    if(!row || row.session!=session || !(row.userName==name || [row.userName isEqual:name]) ||
       row.revision!=CSCloseFriendCurrentSnapshot().revision || row.serial!=PanelState(logic).serial)return NO;
    return CSCFUnreadPanelAllowsOpen(controller,session);
}
void CSCFUnreadPanelPerformRowAction(id controller,NSInteger index,void (^action)(void)) {
    if(!action || !CSCFUnreadPanelAllowsRowAction(controller,index))return;
    CSCFUnreadPanelState *state=PanelState(controller);
    CSCFUnreadPanelRow *previous=state.actionRow; state.actionRow=state.rows[@(index)];
    @try { action(); } @finally { state.actionRow=previous; }
}
