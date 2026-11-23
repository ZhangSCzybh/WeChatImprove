#import "../Controllers/CSBackupBootstrap.h"
#import "CSTabBarNativeAdapter.h"
#import "CSTabBarSwipeSwitcher.h"

// Keep native navigation, badge content, keyboard handling and visibility decisions intact.
%hook MMTabBar
- (void)layoutSubviews {
    CSTabBarBeginLayout(self);
    %orig;
    CSTabBarEndLayout(self);
    CSTabBarSwipeRefresh(self);
}
- (void)relayoutTabBarItems {
    CSTabBarInvalidateItemGeneration(self);
    CSTabBarBeginLayout(self);
    %orig;
    CSTabBarEndLayout(self);
    CSTabBarSwipeRefresh(self);
}
- (void)setHidden:(BOOL)hidden {
    CSTabBarUpdate(self);
    %orig(hidden);
    CSTabBarUpdate(self);
    CSTabBarSwipeRefresh(self);
}
- (void)setAlpha:(CGFloat)alpha {
    CSTabBarUpdate(self);
    %orig(alpha);
    CSTabBarUpdate(self);
    CSTabBarSwipeRefresh(self);
}
- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates {
    CSTabBarUpdate(self);
    UIView *snapshot=%orig(afterUpdates);
    UIView *result=CSTabBarStyleSnapshot(self,snapshot);
    return result;
}
- (void)didMoveToWindow {
    %orig;
    CSTabBarUpdate(self);
    CSTabBarSwipeRefresh(self);
}
- (void)traitCollectionDidChange:(UITraitCollection *)previous {
    %orig(previous);
    CSTabBarUpdate(self);
    CSTabBarSwipeRefresh(self);
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL handled=NO;
    BOOL inside=CSTabBarContainsPoint(self,point,&handled);
    BOOL result=handled ? inside : %orig(point,event);
    return result;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL handled=NO;
    UIView *hit=CSTabBarHitTest(self,point,event,&handled);
    UIView * result=handled ? hit : %orig(point,event);
    return result;
}
%end

%hook MMTabBarController
- (void)setSelectedIndex:(NSUInteger)index {
    %orig(index);
    CSTabBarSelectionDidChange(self);
}
- (void)viewWillLayoutSubviews {
    CSTabBarBeginControllerLayout(self);
    MMTabBar *bar=CSTabBarForController(self);
    if (bar) CSTabBarBeginLayout(bar);
    @try { %orig; }
    @catch (__unused NSException *exception) { CSTabBarEndControllerLayout(self); @throw; }
    @finally { if (bar) CSTabBarEndLayout(bar); }
}
- (void)viewDidLayoutSubviews {
    MMTabBar *bar=CSTabBarForController(self);
    if (bar) CSTabBarBeginLayout(bar);
    @try { %orig; }
    @finally {
        @try { if (bar) CSTabBarEndLayout(bar); }
        @finally { CSTabBarEndControllerLayout(self); CSTabBarSwipeRefresh(bar); }
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    CSTabBarEndControllerLayout(self);
    %orig;
}
%end

%hook MMTabBarItemView
- (void)layoutSubviews {
    CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
}
- (void)layoutIcon {
    CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
}
- (void)layoutBadgeView {
    CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
}
- (void)reloadIconImage {
    CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
}
- (void)setSelected:(BOOL)selected {
    CSTabBarBeginItemUpdate(self); %orig(selected); CSTabBarEndItemUpdate(self);
}
- (void)setTitle:(NSString *)title {
    CSTabBarBeginItemUpdate(self); %orig(title); CSTabBarEndItemUpdate(self);
}
%end

%group CSModernTabBar
%hook WCTabBarView
- (void)layoutSubviews {
    CSTabBarBeginLayout((id)self);
    @try { %orig; }
    @finally { CSTabBarEndLayout((id)self); CSTabBarSwipeRefresh((id)self); }
}
- (void)reloadItemViews {
    CSTabBarInvalidateItemGeneration((id)self);
    CSTabBarBeginLayout((id)self);
    @try { %orig; }
    @finally { CSTabBarEndLayout((id)self); CSTabBarSwipeRefresh((id)self); }
}
- (void)setHidden:(BOOL)hidden {
    CSTabBarUpdate((id)self); %orig(hidden); CSTabBarUpdate((id)self); CSTabBarSwipeRefresh((id)self);
}
- (void)setAlpha:(CGFloat)alpha {
    CSTabBarUpdate((id)self); %orig(alpha); CSTabBarUpdate((id)self); CSTabBarSwipeRefresh((id)self);
}
- (void)didMoveToWindow {
    %orig; CSTabBarUpdate((id)self); CSTabBarSwipeRefresh((id)self);
}
- (void)traitCollectionDidChange:(UITraitCollection *)previous {
    %orig(previous); CSTabBarUpdate((id)self); CSTabBarSwipeRefresh((id)self);
}
- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates {
    CSTabBarUpdate((id)self);
    UIView *result=CSTabBarStyleSnapshot((id)self,%orig(afterUpdates));
    return result;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL handled=NO;
    BOOL inside=CSTabBarContainsPoint((id)self,point,&handled);
    BOOL result=handled ? inside : %orig(point,event);
    return result;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL handled=NO;
    UIView *hit=CSTabBarHitTest((id)self,point,event,&handled);
    UIView * result=handled ? hit : %orig(point,event);
    return result;
}
%end

%hook WCTabBarController
- (void)setSelectedIndex:(NSUInteger)index {
    %orig(index);
    CSTabBarSelectionDidChange((id)self);
}
- (void)viewWillLayoutSubviews {
    CSTabBarBeginControllerLayout((id)self);
    MMTabBar *bar=CSTabBarForController((id)self);
    if (bar) CSTabBarBeginLayout(bar);
    @try { %orig; }
    @catch (__unused NSException *exception) { CSTabBarEndControllerLayout((id)self); @throw; }
    @finally { if (bar) CSTabBarEndLayout(bar); }
}
- (void)viewDidLayoutSubviews {
    MMTabBar *bar=CSTabBarForController((id)self);
    if (bar) CSTabBarBeginLayout(bar);
    @try { %orig; }
    @finally {
        @try { if (bar) CSTabBarEndLayout(bar); }
        @finally { CSTabBarEndControllerLayout((id)self); CSTabBarSwipeRefresh(bar); }
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    CSTabBarEndControllerLayout((id)self); %orig(animated);
}
%end
%end


%ctor {
    CSBackupWhenReady(^{
        CSTabBarInstallObservers();
        CSTabBarSwipeInstallObservers();
        %init;
        if (NSClassFromString(@"WCTabBarView") && NSClassFromString(@"WCTabBarController")) {
            %init(CSModernTabBar);
        }
    });
}
