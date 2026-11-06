#import <Foundation/Foundation.h>
#import "CSGroupNativeBridge.h"
#import "WESessionTabItem.h"

// Native models and view storage are fixtures; bridge, projection, publication
// and both badge update methods execute production code without replacement.
id CSGetService(Class cls) { (void)cls; return nil; }
static BOOL hideAll, hideGroups;
static BOOL Option(NSString *key) { return [key isEqual:@"hide_all_badge"] ? hideAll : hideGroups; }
@interface BadgeNativeSession : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic) NSUInteger m_uUnReadCount;
@property(nonatomic) BOOL m_bShowUnReadAsRedDot;
@end
@implementation BadgeNativeSession
- (BOOL)isSingleChatSession { return self.m_nsUserName.length>0; }
@end
@interface BadgeNativeLogic : NSObject
@property(nonatomic,copy) NSArray<BadgeNativeSession *> *sessions;
@property(nonatomic) NSInteger getTotalUnreadCount;
@end
@implementation BadgeNativeLogic
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path { return self.sessions[[path indexAtPosition:1]]; }
@end
@interface BadgeNativeHost : NSObject
@property(nonatomic,strong) BadgeNativeLogic *m_mainFrameLogicController;
@end
@implementation BadgeNativeHost
- (NSInteger)numberOfSectionsInTableView:(id)table { (void)table; return 1; }
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section {
    (void)table; (void)section; return (NSInteger)self.m_mainFrameLogicController.sessions.count;
}
@end
@interface BadgeLabel : NSObject
@property(nonatomic) BOOL hidden;
@property(nonatomic,copy) NSString *text;
@end
@implementation BadgeLabel @end
@interface WETabButton : NSObject
@property(nonatomic) NSInteger unreadCount;
@property(nonatomic) BOOL hasRedDot;
@property(nonatomic,strong) BadgeLabel *unreadBadge;
@property(nonatomic,copy) NSString *accessibilityValue;
@property(nonatomic) NSUInteger layouts;
@end
@implementation WETabButton
- (void)setNeedsLayout { self.layouts++; }
#include "BadgeBody.h"
@end
@interface BadgeChrome : NSObject
@property(nonatomic,copy) NSArray<WETabButton *> *tabButtons;
@property(nonatomic) NSUInteger layouts;
@end
@implementation BadgeChrome
- (void)setNeedsLayout { self.layouts++; }
#include "ContainerBody.h"
@end
@interface BadgePublisher : NSObject
@property(nonatomic,strong) BadgeNativeHost *controller;
@property(nonatomic,strong) BadgeChrome *chrome;
@end
@implementation BadgePublisher
#include "PublicationBody.h"
@end
static NSUInteger checks, failures;
static void Check(BOOL ok, NSString *reason) {
    checks++; if (!ok) { failures++; fprintf(stderr,"FAIL: %s\n",reason.UTF8String); }
}
static CSGroupProjection *Build(NSArray *sections, NSArray *tabs, CSGroupProjection *previous, NSSet *hidden) {
    return [[CSGroupProjection alloc] initWithSections:sections tabs:tabs selectedTabID:@"custom"
        filterDuplicates:NO accountID:@"badge-account" hiddenUserNames:hidden privacyRevision:1 previousProjection:previous];
}
static BadgePublisher *Publisher(NSArray *tabs) {
    BadgePublisher *p=[BadgePublisher new]; p.controller=[BadgeNativeHost new];
    p.controller.m_mainFrameLogicController=[BadgeNativeLogic new]; p.chrome=[BadgeChrome new];
    NSMutableArray *buttons=[NSMutableArray array];
    for (__unused id tab in tabs) {
        WETabButton *b=[WETabButton new]; b.unreadBadge=[BadgeLabel new]; b.unreadBadge.hidden=YES; [buttons addObject:b];
    }
    p.chrome.tabButtons=buttons; return p;
}
int main(void) { @autoreleasepool {
    // Session, folded group, two service containers, anonymous business row,
    // and ordinary service session all pass through the real native bridge.
    for (NSString *name in @[@"friend",@"group@chatroom",@"chatroom_session_box",@"brandsessionholder",@"brandservicesessionholder",@"",@"gh_service"]) {
        NSMutableArray *tabs=[NSMutableArray array];
        for (NSUInteger type=0;type<4;type++) [tabs addObject:[WESessionTabItem tabWithType:(WETabType)type]];
        WESessionTabItem *custom=[WESessionTabItem customTabWithName:@"工作" sessionUserNames:name.length ? @[name] : @[]];
        custom.tabId=@"custom"; [tabs addObject:custom];
        BadgePublisher *p=Publisher(tabs); BadgeNativeLogic *logic=p.controller.m_mainFrameLogicController;
        BadgeNativeSession *s=[BadgeNativeSession new]; s.m_nsUserName=name; s.m_uUnReadCount=7; s.m_bShowUnReadAsRedDot=YES; logic.sessions=@[s];
        NSArray *before=CSGroupBuildNativeSections(p.controller,p,p.controller);
        CSGroupProjection *unread=Build(before,tabs,nil,[NSSet set]);
        [p publish:unread tabs:tabs privacy:NO];
        Check(unread.valid && [unread badgeForTabID:custom.tabId].redDot && p.chrome.tabButtons.lastObject.hasRedDot,
              [name stringByAppendingString:@": positive unread in dot mode publishes a real dot even when native numeric total is zero"]);
        s.m_uUnReadCount=0; // Native presentation style can remain set after reading.
        NSArray *after=CSGroupBuildNativeSectionsReusing(p.controller,p,p.controller,before);
        CSGroupProjection *cleared=Build(after,tabs,unread,[NSSet set]);
        [p publish:cleared tabs:tabs privacy:NO];
        Check([after[0][0] redDot] && ![after[0][0] unreadCount] && [before[0][0] unreadCount]==7,
              @"native values remain immutable and the style flag is preserved");
        Check(cleared!=unread && [cleared changedUnreadPathsFrom:unread].count==1,@"clearing unread invalidates the cached projection and displayed row");
        for (NSUInteger i=0;i<tabs.count;i++) {
            WETabButton *b=p.chrome.tabButtons[i];
            Check(![cleared badgeForTabID:[tabs[i] tabId]].redDot && !b.hasRedDot && b.unreadBadge.hidden && !b.accessibilityValue,
                  [NSString stringWithFormat:@"%@ tab %lu: zero unread must publish hasRedDot=NO and hide the badge",name,(unsigned long)i]);
        }
        CSGroupProjection *cold=Build(after,tabs,nil,[NSSet set]);
        Check(![cold badgeForTabID:custom.tabId].redDot && Build(after,tabs,cleared,[NSSet set])==cleared,
              @"cold reconstruction and unchanged cached refresh cannot resurrect a cleared dot");
        s.m_uUnReadCount=9; s.m_bShowUnReadAsRedDot=NO;
        NSArray *residual=CSGroupBuildNativeSectionsReusing(p.controller,p,p.controller,after);
        CSGroupProjection *noDot=Build(residual,tabs,cleared,[NSSet set]);
        logic.getTotalUnreadCount=0; [p publish:noDot tabs:tabs privacy:NO];
        Check(![noDot badgeForTabID:custom.tabId].redDot && !p.chrome.tabButtons[0].hasRedDot,
              [name stringByAppendingString:@": positive count without native dot indication cannot manufacture a dot"]);
        CSGroupRow *row=residual[0][0];
        BOOL aggregate=row.kind==CSGroupRowKindAggregate || row.kind==CSGroupRowKindBusiness;
        Check([noDot badgeForTabID:custom.tabId].count==(aggregate ? 0U : 9U),@"aggregate totals stay excluded; normal numeric unread stays unchanged");
        Check(!aggregate || p.chrome.tabButtons.lastObject.unreadBadge.hidden,@"aggregate/business residual counts leave the custom tab badge hidden");
        s.m_bShowUnReadAsRedDot=YES;
        NSArray *dotOnly=CSGroupBuildNativeSectionsReusing(p.controller,p,p.controller,residual);
        CSGroupProjection *restored=Build(dotOnly,tabs,noDot,[NSSet set]);
        Check(restored!=noDot && [restored changedUnreadPathsFrom:noDot].count==1 && [restored badgeForTabID:custom.tabId].redDot,
              @"a flag-only change at the same unread count invalidates reuse and restores a genuine dot");
        s.m_bShowUnReadAsRedDot=NO;
        NSArray *flagCleared=CSGroupBuildNativeSectionsReusing(p.controller,p,p.controller,dotOnly);
        CSGroupProjection *flagOff=Build(flagCleared,tabs,restored,[NSSet set]);
        [p publish:flagOff tabs:tabs privacy:NO];
        Check([flagOff changedUnreadPathsFrom:restored].count==1 && !p.chrome.tabButtons.lastObject.hasRedDot,
              @"clearing only the flag republishes hasRedDot=NO even while the native count is unchanged");
        s.m_bShowUnReadAsRedDot=YES;
        if (name.length) {
            CSGroupProjection *private=Build(dotOnly,tabs,restored,[NSSet setWithObject:name]);
            [p publish:private tabs:tabs privacy:YES];
            Check(!p.chrome.tabButtons[0].hasRedDot && !p.chrome.tabButtons.lastObject.hasRedDot,@"hidden rows cannot contribute a dot through privacy publication");
        }
        hideAll=YES; hideGroups=YES; [p publish:restored tabs:tabs privacy:NO];
        Check(p.chrome.tabButtons[0].unreadBadge.hidden && p.chrome.tabButtons.lastObject.unreadBadge.hidden,@"hide-badge settings clear both outputs");
        hideAll=NO; hideGroups=NO; [p publish:restored tabs:tabs privacy:NO];
        Check(p.chrome.tabButtons.lastObject.hasRedDot,@"reenabling badges restores only genuine unread");
        logic.getTotalUnreadCount=42; [p publish:restored tabs:tabs privacy:NO];
        Check([p.chrome.tabButtons[0].unreadBadge.text isEqual:@"42"],@"All retains native numeric total and numeric display priority");
        [p publish:restored tabs:tabs privacy:YES];
        Check(!p.chrome.tabButtons[0].unreadCount && p.chrome.tabButtons[0].hasRedDot,@"privacy uses the projected total instead of the unfiltered native total");
    }
    // Clearing one member must retain another member's real dot; clearing the
    // last member must remove it even while a service container keeps a count.
    WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];
    WESessionTabItem *mixed=[WESessionTabItem customTabWithName:@"混合" sessionUserNames:@[@"a",@"b",@"brandsessionholder"]]; mixed.tabId=@"custom";
    NSArray *tabs=@[all,mixed]; BadgePublisher *p=Publisher(tabs);
    NSMutableArray *sessions=[NSMutableArray array];
    for (NSString *name in mixed.sessionUserNames) {
        BadgeNativeSession *s=[BadgeNativeSession new]; s.m_nsUserName=name; s.m_uUnReadCount=3;
        s.m_bShowUnReadAsRedDot=![name isEqual:@"brandsessionholder"]; [sessions addObject:s];
    }
    p.controller.m_mainFrameLogicController.sessions=sessions;
    NSArray *sections=CSGroupBuildNativeSections(p.controller,p,p.controller);
    CSGroupProjection *projection=Build(sections,tabs,nil,[NSSet set]);
    [p publish:projection tabs:tabs privacy:NO];
    Check(p.chrome.tabButtons.lastObject.hasRedDot,@"multiple real unread members produce one group dot");
    for (NSUInteger i=0;i<2;i++) {
        ((BadgeNativeSession *)sessions[i]).m_uUnReadCount=0;
        sections=CSGroupBuildNativeSectionsReusing(p.controller,p,p.controller,sections);
        projection=Build(sections,tabs,projection,[NSSet set]);
        [p publish:projection tabs:tabs privacy:NO];
        Check(p.chrome.tabButtons.lastObject.hasRedDot==(i==0),@"only clearing the last real unread member clears the group dot despite residual container count");
    }
    Check(p.chrome.tabButtons.lastObject.unreadBadge.hidden,@"mixed group has no residual dot or number after the final unread clears");
    printf("Group badges: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
