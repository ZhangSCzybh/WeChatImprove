#import "CSTabBarNativeAdapter.h"

// Keep native navigation, badge content, keyboard handling and visibility decisions intact.
%hook MMTabBar
- (void)layoutSubviews {
    CSTabBarBeginLayout(self);
    %orig;
    CSTabBarEndLayout(self);
}
- (void)relayoutTabBarItems {
    CSTabBarBeginLayout(self);
    %orig;
    CSTabBarEndLayout(self);
}
- (void)setHidden:(BOOL)hidden {
    %orig(hidden);
    CSTabBarVisibilityChanged(self);
}
- (void)didMoveToWindow {
    %orig;
    CSTabBarVisibilityChanged(self);
}
- (void)traitCollectionDidChange:(UITraitCollection *)previous {
    %orig(previous);
    CSTabBarUpdate(self);
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL handled=NO;
    BOOL inside=CSTabBarContainsPoint(self,point,&handled);
    return handled ? inside : %orig(point,event);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL handled=NO;
    UIView *hit=CSTabBarHitTest(self,point,event,&handled);
    return handled ? hit : %orig(point,event);
}
%end

%hook MMTabBarController
- (void)viewWillLayoutSubviews {
    MMTabBar *bar=[self.tabBar isKindOfClass:NSClassFromString(@"MMTabBar")] ? (MMTabBar *)self.tabBar : nil;
    if (bar) CSTabBarBeginLayout(bar);
    %orig;
    if (bar) CSTabBarEndLayout(bar);
}
- (void)viewDidLayoutSubviews {
    MMTabBar *bar=[self.tabBar isKindOfClass:NSClassFromString(@"MMTabBar")] ? (MMTabBar *)self.tabBar : nil;
    if (bar) CSTabBarBeginLayout(bar);
    %orig;
    if (bar) CSTabBarEndLayout(bar);
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

%ctor { CSTabBarInstallPreferencesObserver(); }
