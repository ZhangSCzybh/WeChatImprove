#import "../Controllers/CSCloseFriendNotificationAdapter.h"
#import "../Controllers/CSCloseFriendCallAdapter.h"
#import "../Controllers/CSCloseFriendBridge.h"
#import "../Controllers/CSGroupListAdapter.h"
#import "../Controllers/CSGroupProjection.h"
#import "../Controllers/CSGroupNativeBridge.h"
#import <UserNotifications/UserNotifications.h>
#import <substrate.h>
#import <objc/message.h>
static NSMutableDictionary<NSString *,NSDictionary *> *Requests;
static NSHashTable *TabOwners;
static BOOL DiscardOutput(CSCloseFriendAlertSubject *subject) { return [subject shouldDiscardOutput] || CSCFCallOutputSuppressed(); }
static CSCloseFriendAlertSubject *ItemSubject(id item) {
    return CSCFBoundAlert(item) ?: CSCFMessageSubject(CSCloseFriendRead(item,@"message"),CSCloseFriendRead(item,@"contact") ?: CSCloseFriendRead(item,@"username"));
}
static void RemoveKnown(NSArray<UNNotificationRequest *> *requests,BOOL delivered) {
    NSMutableArray *ids=[NSMutableArray array];
    @synchronized(Requests) {
        for(UNNotificationRequest *request in requests) {
            NSDictionary *entry=Requests[request.identifier];
            CSCloseFriendAlertSubject *subject=entry[@"subject"];
            if([subject shouldDiscardOutput] && [entry[@"content"] isEqual:request.content])[ids addObject:request.identifier];
        }
        if(!ids.count)return;
        if(delivered)[UNUserNotificationCenter.currentNotificationCenter removeDeliveredNotificationsWithIdentifiers:ids];
        else [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers:ids];
    }
}
static BOOL ChatTab(id controller,NSUInteger index) {
    id views=CSCloseFriendRead(controller,@"viewControllers");if(![views isKindOfClass:NSArray.class] || index>=[views count])return NO;
    id root=views[index];if([root isKindOfClass:UINavigationController.class])root=[root viewControllers].firstObject;
    Class cls=NSClassFromString(@"NewMainFrameViewController");BOOL matches=cls && [root isKindOfClass:cls];
    if(matches && NSThread.isMainThread)[TabOwners addObject:controller];return matches;
}
// BEGIN Chat tab badge output
@interface CSChatTabBadgeDisplay : NSObject
@property (nonatomic, weak) id root, item, badge;
@property (nonatomic, copy) NSArray *token;
@property (nonatomic) BOOL needsNativeRestore;
@property (nonatomic) NSUInteger kind, count;
@end
@implementation CSChatTabBadgeDisplay @end
@interface CSChatTabBadgeNativePass : NSObject
@property (nonatomic, strong) CSGroupTabBadgeDecision *decision;
@property (nonatomic, copy) NSArray *views;
@property (nonatomic, strong) CSChatTabBadgeDisplay *display;
@end
@implementation CSChatTabBadgeNativePass @end
static char ChatTabBadgeDisplayKey;
static __unsafe_unretained id TabBadgeWriteOwner;
static NSUInteger TabBadgeWriteIndex;
static SEL TabBadgeWriteSelector;
static BOOL TabBadgeWriteConsumed, PublishingChatTabBadges, ChatTabBadgesPublishAgain, ChatTabBadgesPublishScheduled;
static NSUInteger ApplyingChatTabBadges;
static void CSPublishChatTabBadges(void);
static void CSDeferChatTabBadgePublication(void) {
    if (ChatTabBadgesPublishScheduled) return;
    ChatTabBadgesPublishScheduled=YES;
    dispatch_async(dispatch_get_main_queue(),^{
        ChatTabBadgesPublishScheduled=NO;
        CSPublishChatTabBadges();
    });
}
static BOOL CSNativeTabBadgePublication(id owner,NSUInteger index,SEL selector) {
    if (!NSThread.isMainThread || TabBadgeWriteConsumed || owner!=TabBadgeWriteOwner ||
        index!=TabBadgeWriteIndex || selector!=TabBadgeWriteSelector) return NO;
    TabBadgeWriteConsumed=YES;
    return YES;
}
static id CSChatTabBadgeRoot(id owner,NSUInteger index) {
    NSArray *controllers=CSCloseFriendRead(owner,@"viewControllers");
    if (![controllers isKindOfClass:NSArray.class] || index>=controllers.count) return nil;
    id root=controllers[index];
    if ([root isKindOfClass:UINavigationController.class]) root=[root viewControllers].firstObject;
    return root;
}
static CSGroupTabBadgeDecision *CSChatTabBadgeDecision(id owner,NSUInteger index,BOOL includeNative) {
    id root=CSChatTabBadgeRoot(owner,index);
    return [CSGroupListAdapter closeFriendTabBadgeDecisionForController:root includeNative:includeNative];
}
static NSArray *CSChatTabBadgeViews(id owner,NSUInteger index) {
    id root=CSChatTabBadgeRoot(owner,index);
    // Follow the same custom tab bar that receives the native badge setters.
    id bar=CSCloseFriendRead(owner,@"customTabBar") ?: CSCloseFriendRead(owner,@"tabBar");
    SEL atIndex=NSSelectorFromString(@"tabBarItemViewAtIndex:");
    id item=nil;
    if (CSCloseFriendMethodMatches(class_getInstanceMethod([bar class],atIndex),"@@:Q"))
        item=((id(*)(id,SEL,unsigned long long))objc_msgSend)(bar,atIndex,(unsigned long long)index);
    if (!item) {
        NSArray *items=CSCloseFriendRead(bar,@"tabBarItemViews");
        if ([items isKindOfClass:NSArray.class] && index<items.count) item=items[index];
    }
    id badge=CSCloseFriendRead(item,@"badgeView");
    return root && item && badge ? @[root,item,badge] : nil;
}
static NSArray *CSChatTabBadgeToken(CSGroupTabBadgeDecision *decision) {
    return @[decision.accountID,@(decision.epoch),@(decision.policyRevision)];
}
static BOOL CSChatTabBadgeCurrent(CSGroupTabBadgeDecision *decision) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    return !decision.boundary && !policy.blocked && decision.epoch==CSCloseFriendAccountEpoch() &&
        decision.policyRevision==policy.revision && [decision.accountID isEqual:policy.accountID] &&
        [policy.accountID isEqual:CSGroupCurrentAccountID()];
}
static BOOL CSChatTabBadgeSameTarget(CSChatTabBadgeDisplay *display,NSArray *views) {
    return views && display.root==views[0] && display.item==views[1] && display.badge==views[2];
}
static void CSRememberChatTabBadgeWrite(NSMutableDictionary *displays,NSUInteger index,NSArray *views,NSArray *token,NSUInteger kind,NSUInteger count) {
    if (!views) return;
    CSChatTabBadgeDisplay *display=[CSChatTabBadgeDisplay new];
    display.root=views[0]; display.item=views[1]; display.badge=views[2];
    display.token=token; display.kind=kind; display.count=count;
    display.needsNativeRestore=YES; displays[@(index)]=display;
}
// kind: number, pure dot, or boundary invalidation via native string-nil hiding.
static BOOL CSWriteChatTabBadge(id owner,NSUInteger index,NSUInteger kind,NSUInteger count) {
    SEL selector=NSSelectorFromString(kind==0 ? @"setTabBarBadgeValue:forIndex:" :
        kind==1 ? @"showRedDotOnTabBarItemAtIndex:" : @"setTabBarBadgeString:forIndex:");
    const char *encoding=kind==0 ? "v@:QQ" : kind==1 ? "v@:Q" : "v@:@Q";
    if (!CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],selector),encoding)) return NO;
    id previousOwner=TabBadgeWriteOwner; NSUInteger previousIndex=TabBadgeWriteIndex;
    SEL previousSelector=TabBadgeWriteSelector; BOOL previousConsumed=TabBadgeWriteConsumed;
    TabBadgeWriteOwner=owner; TabBadgeWriteIndex=index; TabBadgeWriteSelector=selector; TabBadgeWriteConsumed=NO;
    @try {
        if (kind==0) ((void(*)(id,SEL,unsigned long long,unsigned long long))objc_msgSend)(owner,selector,(unsigned long long)count,(unsigned long long)index);
        else if (kind==1) ((void(*)(id,SEL,unsigned long long))objc_msgSend)(owner,selector,(unsigned long long)index);
        else ((void(*)(id,SEL,id,unsigned long long))objc_msgSend)(owner,selector,nil,(unsigned long long)index);
    } @finally {
        TabBadgeWriteOwner=previousOwner; TabBadgeWriteIndex=previousIndex;
        TabBadgeWriteSelector=previousSelector; TabBadgeWriteConsumed=previousConsumed;
    }
    return YES;
}
static void CSInvalidateChatTabBadge(id owner,NSUInteger index,NSMutableDictionary *displays) {
    // Losing the safe token must not lose the obligation to undo our UI write.
    // The marker alone never permits Pending to reuse an old account's display.
    CSChatTabBadgeDisplay *previous=displays[@(index)]; previous.token=nil;
    NSArray *views=CSChatTabBadgeViews(owner,index);
    if (views && ChatTab(owner,index) && CSWriteChatTabBadge(owner,index,2,0) &&
        [CSChatTabBadgeViews(owner,index) isEqual:views])
        CSRememberChatTabBadgeWrite(displays,index,views,nil,2,0);
}
static void CSApplyTabBadgeDecision(id owner,NSUInteger index,CSGroupTabBadgeDecision *decision) {
    if (!NSThread.isMainThread || !decision || !ChatTab(owner,index)) return;
    ApplyingChatTabBadges++;
    @try {
    NSMutableDictionary *displays=objc_getAssociatedObject(owner,&ChatTabBadgeDisplayKey);
    if (!displays) { displays=[NSMutableDictionary dictionary]; objc_setAssociatedObject(owner,&ChatTabBadgeDisplayKey,displays,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    CSChatTabBadgeDisplay *previous=displays[@(index)];
    NSArray *views=CSChatTabBadgeViews(owner,index), *token=CSChatTabBadgeToken(decision);
    BOOL current=CSChatTabBadgeCurrent(decision) && (!decision.badge || (views && decision.sourceController==views[0]));
    BOOL sameTarget=CSChatTabBadgeSameTarget(previous,views);
    if (!decision.badge && current && sameTarget && [previous.token isEqual:token]) return;
    // Unknown data never becomes a fabricated numeric zero. An untrusted old
    // display is hidden through the native nil-string path, without reusing it.
    NSUInteger kind=(!current || !decision.badge) ? 2 : decision.badge.count ? 0 : decision.badge.redDot ? 1 : 0;
    // Source observers may run synchronously from a native setter. An unchanged
    // result must not write again and create an endless publication cycle.
    if (sameTarget && previous.kind==kind && previous.count==(kind==0 ? decision.badge.count : 0) &&
        ((kind==2 && !previous.token) || (current && [previous.token isEqual:token]))) return;
    if (!CSWriteChatTabBadge(owner,index,kind,decision.badge.count)) return;
    NSArray *after=CSChatTabBadgeViews(owner,index);
    if (!current || !CSChatTabBadgeCurrent(decision) || !views || ![after isEqual:views]) {
        // A native setter may synchronously change policy/targets before its
        // final UI write. Revoke that stale write, then publish the new state.
        CSInvalidateChatTabBadge(owner,index,displays);
        if (current && views) ChatTabBadgesPublishAgain=YES;
        return;
    }
    CSRememberChatTabBadgeWrite(displays,index,views,decision.badge ? token : nil,kind,kind==0 ? decision.badge.count : 0);
    if (decision.badge) {
        // A nested native setter can publish newer rows without posting the
        // source observer until after this outer setter returns.
        CSGroupTabBadgeDecision *latest=CSChatTabBadgeDecision(owner,index,NO);
        if (!CSChatTabBadgeCurrent(decision)) {
            CSInvalidateChatTabBadge(owner,index,displays);
            ChatTabBadgesPublishAgain=YES;
        } else if (latest.badge && (latest.sourceController!=decision.sourceController ||
            latest.sourceRevision!=decision.sourceRevision || latest.badge.count!=decision.badge.count ||
            latest.badge.redDot!=decision.badge.redDot)) ChatTabBadgesPublishAgain=YES;
    }
    } @finally {
        ApplyingChatTabBadges--;
        if (!ApplyingChatTabBadges && !PublishingChatTabBadges && ChatTabBadgesPublishAgain) CSPublishChatTabBadges();
    }
}
static void CSDispatchTabBadgeWrite(id owner,NSUInteger index,dispatch_block_t write) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    CSGroupTabBadgeDecision *identity=[CSGroupTabBadgeDecision decisionWithPolicy:policy epoch:CSCloseFriendAccountEpoch()
        boundary:policy.blocked badge:nil];
    dispatch_async(dispatch_get_main_queue(),^{
        if (!ChatTab(owner,index) || CSChatTabBadgeCurrent(identity)) { write(); return; }
        // Queued values from a previous account/policy must never become new
        // native output after their original caller's context has disappeared.
        if (ChatTab(owner,index)) {
            CSGroupTabBadgeDecision *decision=CSChatTabBadgeDecision(owner,index,NO);
            if (!decision) decision=[CSGroupTabBadgeDecision decisionWithPolicy:CSCloseFriendCurrentSnapshot()
                epoch:CSCloseFriendAccountEpoch() boundary:YES badge:nil];
            CSApplyTabBadgeDecision(owner,index,decision);
            CSPublishChatTabBadges();
        }
    });
}
static CSChatTabBadgeNativePass *CSCaptureNativeTabBadge(id owner,NSUInteger index) {
    if (!NSThread.isMainThread || !ChatTab(owner,index)) return nil;
    NSMutableDictionary *displays=objc_getAssociatedObject(owner,&ChatTabBadgeDisplayKey);
    CSChatTabBadgeDisplay *previous=displays[@(index)];
    CSChatTabBadgeNativePass *pass=[CSChatTabBadgeNativePass new];
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    // Even a never-owned native target can cross an account/policy boundary
    // inside its original setter. Capturing identity requires no row projection.
    pass.decision=[CSGroupTabBadgeDecision decisionWithPolicy:policy epoch:CSCloseFriendAccountEpoch()
        boundary:policy.blocked badge:nil];
    pass.views=CSChatTabBadgeViews(owner,index);
    pass.display=previous;
    return pass;
}
static void CSFinishNativeTabBadge(id owner,NSUInteger index,CSChatTabBadgeNativePass *pass) {
    CSGroupTabBadgeDecision *decision=ChatTab(owner,index) ? CSChatTabBadgeDecision(owner,index,NO) : nil;
    if (decision) {
        // The original setter may have written after an inner source/policy
        // observer. Its final output invalidates the observer's display marker.
        NSMutableDictionary *displays=objc_getAssociatedObject(owner,&ChatTabBadgeDisplayKey);
        CSChatTabBadgeDisplay *previous=displays[@(index)];
        previous.token=nil; previous.kind=NSUIntegerMax;
        CSApplyTabBadgeDecision(owner,index,decision);
        return;
    }
    if (!pass) return;
    NSMutableDictionary *displays=objc_getAssociatedObject(owner,&ChatTabBadgeDisplayKey);
    if (!pass.decision || !CSChatTabBadgeCurrent(pass.decision) || !ChatTab(owner,index) ||
        (pass.views && ![CSChatTabBadgeViews(owner,index) isEqual:pass.views])) {
        if (!displays) { displays=[NSMutableDictionary dictionary]; objc_setAssociatedObject(owner,&ChatTabBadgeDisplayKey,displays,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
        CSInvalidateChatTabBadge(owner,index,displays);
        ChatTabBadgesPublishAgain=YES;
        if (!ApplyingChatTabBadges && !PublishingChatTabBadges) CSPublishChatTabBadges();
    } else if (pass.display && displays[@(index)]==pass.display && CSChatTabBadgeSameTarget(pass.display,pass.views)) {
        if (TabBadgeWriteOwner==owner && TabBadgeWriteIndex==index) return;
        // A successful natural native update already restored ownership. A later
        // source event must not replace its arbitrary native string/dot/number.
        [displays removeObjectForKey:@(index)];
    }
}
static void CSPublishChatTabBadges(void) {
    if (!NSThread.isMainThread) return;
    if (PublishingChatTabBadges || ApplyingChatTabBadges) { ChatTabBadgesPublishAgain=YES; return; }
    PublishingChatTabBadges=YES;
    @try {
        // One pass plus one reentrant reconciliation. Stable repeated source
        // notifications are deduplicated by the display state above.
        for (NSUInteger pass=0;pass<2;pass++) {
            ChatTabBadgesPublishAgain=NO;
            for (id owner in TabOwners.allObjects) {
                NSArray *controllers=CSCloseFriendRead(owner,@"viewControllers");
                if (![controllers isKindOfClass:NSArray.class]) continue;
                for (NSUInteger index=0;index<controllers.count;index++) if (ChatTab(owner,index)) {
                    CSGroupTabBadgeDecision *decision=CSChatTabBadgeDecision(owner,index,NO);
                    if (decision) CSApplyTabBadgeDecision(owner,index,decision);
                    else {
                        NSMutableDictionary *displays=objc_getAssociatedObject(owner,&ChatTabBadgeDisplayKey);
                        CSChatTabBadgeDisplay *previous=displays[@(index)];
                        NSArray *views=CSChatTabBadgeViews(owner,index);
                        if (!previous.needsNativeRestore || !CSChatTabBadgeSameTarget(previous,views)) continue;
                        // Native ownership only restores a target we wrote. Capture
                        // the account/epoch and actual UI identities before reading
                        // a count; nil policy alone cannot identify its account.
                        CSGroupTabBadgeDecision *native=CSChatTabBadgeDecision(owner,index,YES);
                        if (!native || !CSChatTabBadgeCurrent(native)) { CSInvalidateChatTabBadge(owner,index,displays); continue; }
                        NSArray *token=CSChatTabBadgeToken(native);
                        if (!native.badge || native.sourceController!=views[0]) {
                            if (previous.token && ![previous.token isEqual:token]) CSInvalidateChatTabBadge(owner,index,displays);
                            continue;
                        }
                        // Read the native total, but address the actual owner and
                        // index. updateUnReadCount itself hardcodes the global tab 0.
                        id logic=CSCloseFriendRead(views[0],@"m_mainFrameLogicController");
                        SEL total=NSSelectorFromString(@"getTotalUnreadCount");
                        if (!CSCloseFriendMethodMatches(class_getInstanceMethod([logic class],total),"I@:")) continue;
                        unsigned int count=((unsigned int(*)(id,SEL))objc_msgSend)(logic,total);
                        decision=CSChatTabBadgeDecision(owner,index,NO);
                        if (decision) { CSApplyTabBadgeDecision(owner,index,decision); continue; }
                        CSGroupTabBadgeDecision *afterRead=CSChatTabBadgeDecision(owner,index,YES);
                        if (!CSChatTabBadgeCurrent(native) || !afterRead || !CSChatTabBadgeCurrent(afterRead) ||
                            ![CSChatTabBadgeToken(afterRead) isEqual:token] || !ChatTab(owner,index) ||
                            ![CSChatTabBadgeViews(owner,index) isEqual:views] ||
                            !afterRead.badge || afterRead.sourceController!=views[0] ||
                            afterRead.sourceRevision!=native.sourceRevision ||
                            CSCloseFriendRead(views[0],@"m_mainFrameLogicController")!=logic) {
                            CSInvalidateChatTabBadge(owner,index,displays); ChatTabBadgesPublishAgain=YES; continue;
                        }
                        // A validated source must belong to this actual root;
                        // an old display token alone cannot validate native totals.
                        {
                            BOOL dot=!count && afterRead.badge.redDot;
                            // Keep restoration ownership through this write. A
                            // synchronous newer source must reconcile before we
                            // release the marker, even when the policy is unchanged.
                            if (ChatTab(owner,index) && CSWriteChatTabBadge(owner,index,dot ? 1 : 0,count)) {
                                decision=CSChatTabBadgeDecision(owner,index,NO);
                                if (decision) { CSFinishNativeTabBadge(owner,index,nil); continue; }
                                if (!CSChatTabBadgeCurrent(native) || !ChatTab(owner,index) ||
                                    ![CSChatTabBadgeViews(owner,index) isEqual:views] ||
                                    CSCloseFriendRead(views[0],@"m_mainFrameLogicController")!=logic) {
                                    CSInvalidateChatTabBadge(owner,index,displays); ChatTabBadgesPublishAgain=YES;
                                } else {
                                    CSGroupTabBadgeDecision *afterWrite=CSChatTabBadgeDecision(owner,index,YES);
                                    if (!afterWrite.badge || !CSChatTabBadgeCurrent(afterWrite) ||
                                        afterWrite.sourceController!=views[0] || afterWrite.sourceRevision!=afterRead.sourceRevision)
                                        ChatTabBadgesPublishAgain=YES;
                                    else if (displays[@(index)]==previous) [displays removeObjectForKey:@(index)];
                                }
                            }
                        }
                    }
                }
            }
            if (!ChatTabBadgesPublishAgain) break;
        }
    } @finally {
        BOOL again=ChatTabBadgesPublishAgain;
        PublishingChatTabBadges=NO; ChatTabBadgesPublishAgain=NO;
        // Preserve a genuinely newer event without an unbounded synchronous
        // drain. This is event driven; an unchanged Pending state never queues it.
        if (again) CSDeferChatTabBadgePublication();
    }
}
// END Chat tab badge output
%ctor { dispatch_async(dispatch_get_main_queue(),^{
    Requests=[NSMutableDictionary dictionary]; TabOwners=[NSHashTable weakObjectsHashTable];
    for(NSString *name in @[@"showQuickReplyItem:",@"showQuickReplyItem:timeout:"]) {
        __block IMP orig=NULL;SEL sel=NSSelectorFromString(name);BOOL timed=[name hasSuffix:@"timeout:"];
        IMP imp=timed?imp_implementationWithBlock(^(id owner,id item,double timeout){CSCloseFriendAlertSubject *s=ItemSubject(item);if(DiscardOutput(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id,double))orig)(owner,sel,item,timeout);});}):imp_implementationWithBlock(^(id owner,id item){CSCloseFriendAlertSubject *s=ItemSubject(item);if(DiscardOutput(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id))orig)(owner,sel,item);});});
        if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",name,imp,&orig,timed?"v@:@d":"v@:@"))imp_removeBlock(imp);
    }
    __block IMP quick=NULL;
    IMP imp=imp_implementationWithBlock(^(id owner,id contact,id message,double timeout){CSCloseFriendAlertSubject *s=CSCFMessageSubject(message,contact);if(DiscardOutput(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id,id,double))quick)(owner,NSSelectorFromString(@"showQuickReplyMsg:message:timeout:"),contact,message,timeout);});});
    if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",@"showQuickReplyMsg:message:timeout:",imp,&quick,"v@:@@d"))imp_removeBlock(imp);
    __block IMP canShow=NULL;
    imp=imp_implementationWithBlock(^BOOL(id owner,id contact,id message){if([CSCFMessageSubject(message,contact) shouldDiscardOutput])return NO;return ((BOOL(*)(id,SEL,id,id))canShow)(owner,NSSelectorFromString(@"canShowPushForContact:msgWrap:"),contact,message);});
    if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",@"canShowPushForContact:msgWrap:",imp,&canShow,"B@:@@"))imp_removeBlock(imp);
    __block IMP arriving=NULL;
    imp=imp_implementationWithBlock(^(id owner,id message,long long flags){CSCFWithAlert(CSCFMessageSubject(message,nil),^{((void(*)(id,SEL,id,long long))arriving)(owner,NSSelectorFromString(@"onNewMsgArriving:NotifyFlag:"),message,flags);});});
    if(!CSCloseFriendInstallHook(@"QuickReplyMsgMgr",@"onNewMsgArriving:NotifyFlag:",imp,&arriving,"v@:@q"))imp_removeBlock(imp);
    // Never globally disable audio/haptics. These native output functions are
    // gated only within an identity-bearing incoming alert scope, including stale
    // scopes whose old-account output must be discarded.
    Class audio=NSClassFromString(@"AudioHelper");SEL vibration=NSSelectorFromString(@"playVibration");
    if(CSCloseFriendMethodMatches(class_getClassMethod(audio,vibration),"v@:")) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id owner){if(!DiscardOutput(CSCFCurrentAlert()))((void(*)(id,SEL))original)(owner,vibration);});
        MSHookMessageEx(object_getClass(audio),vibration,replacement,&original);
        CSCloseFriendRecordCapability(@"notifications.boundVibration",original!=NULL);
    } else CSCloseFriendRecordCapability(@"notifications.boundVibration",NO);
    SEL sound=NSSelectorFromString(@"playSound:fileType:volume:ambient:");
    if(CSCloseFriendMethodMatches(class_getClassMethod(audio,sound),"v@:@@fB")) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id owner,id file,id type,float volume,BOOL ambient){if(!DiscardOutput(CSCFCurrentAlert()))((void(*)(id,SEL,id,id,float,BOOL))original)(owner,sound,file,type,volume,ambient);});
        MSHookMessageEx(object_getClass(audio),sound,replacement,&original);
        CSCloseFriendRecordCapability(@"notifications.boundSound",original!=NULL);
    } else CSCloseFriendRecordCapability(@"notifications.boundSound",NO);
    __block IMP push=NULL;
    imp=imp_implementationWithBlock(^(id owner,id message,id identifier,id date,BOOL voip,BOOL silent){CSCFWithAlert(CSCFMessageSubject(message,nil),^{((void(*)(id,SEL,id,id,id,BOOL,BOOL))push)(owner,NSSelectorFromString(@"showPushWithMessageWrap:identifier:fireDate:isFromVoipPush:shouldSilent:"),message,identifier,date,voip,silent);});});
    if(!CSCloseFriendInstallHook(@"MMLocalNotificationMgr",@"showPushWithMessageWrap:identifier:fireDate:isFromVoipPush:shouldSilent:",imp,&push,"v@:@@@BB"))imp_removeBlock(imp);
    __block IMP info=NULL;
    imp=imp_implementationWithBlock(^id(id owner,id message,id settings,BOOL voip){id result=((id(*)(id,SEL,id,id,BOOL))info)(owner,NSSelectorFromString(@"notificationInfoForMessage:withEnabledNotificationSettings:isFromVoipPush:"),message,settings,voip);CSCFBindAlert(result,CSCFMessageSubject(message,nil));return result;});
    if(!CSCloseFriendInstallHook(@"MMLocalNotificationMgr",@"notificationInfoForMessage:withEnabledNotificationSettings:isFromVoipPush:",imp,&info,"@@:@@B"))imp_removeBlock(imp);
    // Class-method boundary: full ABI gate, then hook its metaclass. Never inspect
    // unverified notification dictionary keys as account/session identity.
    Class utility=NSClassFromString(@"MMLocalNotificationUtil");SEL local=NSSelectorFromString(@"showLocalNotificationWithInfo:");
    if(CSCloseFriendMethodMatches(class_getClassMethod(utility,local),"v@:@")) {
        __block IMP original=NULL;
        IMP replacement=imp_implementationWithBlock(^(id owner,id value){CSCloseFriendAlertSubject *s=CSCFBoundAlert(value)?:CSCFCurrentAlert();if(DiscardOutput(s))return;CSCFWithAlert(s,^{((void(*)(id,SEL,id))original)(owner,local,value);});});
        // The installer takes class names for instance methods; install this
        // metaclass method through the same signature predicate and substrate.
        MSHookMessageEx(object_getClass(utility),local,replacement,&original);
        CSCloseFriendRecordCapability(@"notifications.localInfo",original!=NULL);
    } else CSCloseFriendRecordCapability(@"notifications.localInfo",NO);
    __block IMP add=NULL;
    imp=imp_implementationWithBlock(^(UNUserNotificationCenter *center,UNNotificationRequest *request,void (^completion)(NSError *)){
        CSCloseFriendAlertSubject *s=CSCFBoundAlert(request)?:CSCFCurrentAlert();
        if(DiscardOutput(s)) {if(completion)completion(nil);return;}
        NSNumber *badge=[CSGroupListAdapter closeFriendAlertBadgeCount];
        if(badge && request.content.badge) {UNMutableNotificationContent *content=[request.content mutableCopy];content.badge=badge;request=[UNNotificationRequest requestWithIdentifier:request.identifier content:content trigger:request.trigger];}
        if([s isCurrent]) { @synchronized(Requests){
            if(Requests.count>=512)[Requests removeAllObjects];
            Requests[request.identifier]=@{@"subject":s,@"content":request.content};
        }}
        ((void(*)(id,SEL,id,id))add)(center,@selector(addNotificationRequest:withCompletionHandler:),request,completion);
    });
    if(!CSCloseFriendInstallHook(@"UNUserNotificationCenter",@"addNotificationRequest:withCompletionHandler:",imp,&add,"v@:@@?"))imp_removeBlock(imp);
    for(NSString *name in @[@"presentLocalNotificationNow:",@"scheduleLocalNotification:"]) {
        __block IMP original=NULL;SEL sel=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id app,UILocalNotification *notification){CSCloseFriendAlertSubject *s=CSCFBoundAlert(notification)?:CSCFCurrentAlert();if(DiscardOutput(s))return;NSNumber *badge=[CSGroupListAdapter closeFriendAlertBadgeCount];if(badge){notification=[notification copy];notification.applicationIconBadgeNumber=badge.integerValue;}((void(*)(id,SEL,id))original)(app,sel,notification);});
        if(!CSCloseFriendInstallHook(@"UIApplication",name,replacement,&original,"v@:@"))imp_removeBlock(replacement);
    }
    __block IMP badge=NULL;
    imp=imp_implementationWithBlock(^(id app,NSInteger count){NSNumber *value=[CSGroupListAdapter closeFriendAlertBadgeCount];((void(*)(id,SEL,NSInteger))badge)(app,@selector(setApplicationIconBadgeNumber:),value?value.integerValue:count);});
    if(!CSCloseFriendInstallHook(@"UIApplication",@"setApplicationIconBadgeNumber:",imp,&badge,"v@:q"))imp_removeBlock(imp);
    __block IMP tab=NULL;
    imp=imp_implementationWithBlock(^(id owner,unsigned long long count,unsigned long long index){
        SEL selector=NSSelectorFromString(@"setTabBarBadgeValue:forIndex:");
        if (!NSThread.isMainThread) {
            CSDispatchTabBadgeWrite(owner,(NSUInteger)index,^{ ((void(*)(id,SEL,unsigned long long,unsigned long long))objc_msgSend)(owner,selector,count,index); }); return;
        }
        if (CSNativeTabBadgePublication(owner,(NSUInteger)index,selector)) { ((void(*)(id,SEL,unsigned long long,unsigned long long))tab)(owner,selector,count,index); return; }
        CSGroupTabBadgeDecision *decision=ChatTab(owner,(NSUInteger)index) ? CSChatTabBadgeDecision(owner,(NSUInteger)index,NO) : nil;
        if (decision) { CSApplyTabBadgeDecision(owner,(NSUInteger)index,decision); return; }
        CSChatTabBadgeNativePass *pass=CSCaptureNativeTabBadge(owner,(NSUInteger)index);
        ((void(*)(id,SEL,unsigned long long,unsigned long long))tab)(owner,selector,count,index);
        CSFinishNativeTabBadge(owner,(NSUInteger)index,pass);
    });
    if(!CSCloseFriendInstallHook(@"MMTabBarController",@"setTabBarBadgeValue:forIndex:",imp,&tab,"v@:QQ"))imp_removeBlock(imp);
    __block IMP tabString=NULL;
    imp=imp_implementationWithBlock(^(id owner,id string,unsigned long long index){
        SEL selector=NSSelectorFromString(@"setTabBarBadgeString:forIndex:");
        if (!NSThread.isMainThread) {
            CSDispatchTabBadgeWrite(owner,(NSUInteger)index,^{ ((void(*)(id,SEL,id,unsigned long long))objc_msgSend)(owner,selector,string,index); }); return;
        }
        if (CSNativeTabBadgePublication(owner,(NSUInteger)index,selector)) { ((void(*)(id,SEL,id,unsigned long long))tabString)(owner,selector,string,index); return; }
        CSGroupTabBadgeDecision *decision=ChatTab(owner,(NSUInteger)index) ? CSChatTabBadgeDecision(owner,(NSUInteger)index,NO) : nil;
        if (decision) { CSApplyTabBadgeDecision(owner,(NSUInteger)index,decision); return; }
        CSChatTabBadgeNativePass *pass=CSCaptureNativeTabBadge(owner,(NSUInteger)index);
        ((void(*)(id,SEL,id,unsigned long long))tabString)(owner,selector,string,index);
        CSFinishNativeTabBadge(owner,(NSUInteger)index,pass);
    });
    if(!CSCloseFriendInstallHook(@"MMTabBarController",@"setTabBarBadgeString:forIndex:",imp,&tabString,"v@:@Q"))imp_removeBlock(imp);
    __block IMP dot=NULL;
    imp=imp_implementationWithBlock(^(id owner,unsigned long long index){
        SEL selector=NSSelectorFromString(@"showRedDotOnTabBarItemAtIndex:");
        if (!NSThread.isMainThread) {
            CSDispatchTabBadgeWrite(owner,(NSUInteger)index,^{ ((void(*)(id,SEL,unsigned long long))objc_msgSend)(owner,selector,index); }); return;
        }
        if (CSNativeTabBadgePublication(owner,(NSUInteger)index,selector)) { ((void(*)(id,SEL,unsigned long long))dot)(owner,selector,index); return; }
        CSGroupTabBadgeDecision *decision=ChatTab(owner,(NSUInteger)index) ? CSChatTabBadgeDecision(owner,(NSUInteger)index,NO) : nil;
        if (decision) { CSApplyTabBadgeDecision(owner,(NSUInteger)index,decision); return; }
        CSChatTabBadgeNativePass *pass=CSCaptureNativeTabBadge(owner,(NSUInteger)index);
        ((void(*)(id,SEL,unsigned long long))dot)(owner,selector,index);
        CSFinishNativeTabBadge(owner,(NSUInteger)index,pass);
    });
    if(!CSCloseFriendInstallHook(@"MMTabBarController",@"showRedDotOnTabBarItemAtIndex:",imp,&dot,"v@:Q"))imp_removeBlock(imp);
    [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
        [UNUserNotificationCenter.currentNotificationCenter getPendingNotificationRequestsWithCompletionHandler:^(NSArray *requests){dispatch_async(dispatch_get_main_queue(),^{RemoveKnown(requests,NO);});}];
        [UNUserNotificationCenter.currentNotificationCenter getDeliveredNotificationsWithCompletionHandler:^(NSArray *notifications){NSMutableArray *requests=[NSMutableArray array];for(UNNotification *n in notifications)[requests addObject:n.request];dispatch_async(dispatch_get_main_queue(),^{RemoveKnown(requests,YES);});}];
        NSNumber *value=[CSGroupListAdapter closeFriendAlertBadgeCount];if(value)UIApplication.sharedApplication.applicationIconBadgeNumber=value.integerValue;
        CSPublishChatTabBadges();
    }];
    [NSNotificationCenter.defaultCenter addObserverForName:CSGroupTabBadgeSourceDidRefreshNotification object:nil queue:NSOperationQueue.mainQueue
        usingBlock:^(__unused NSNotification *note){ CSPublishChatTabBadges(); }];
}); }
