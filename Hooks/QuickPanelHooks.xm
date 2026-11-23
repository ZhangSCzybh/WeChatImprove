#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSQuickPanelCoordinator.h"
#import "../Controllers/CSTabBarNativeAdapter.h"

@interface BaseMsgContentViewController : UIViewController @end

%hook MMTabBar
- (void)layoutSubviews {%orig;[CSQuickPanelCoordinator attachToHomeBar:self];}
- (void)didMoveToWindow {%orig;[CSQuickPanelCoordinator attachToHomeBar:self];}
%end

%hook BaseMsgContentViewController
- (void)viewDidAppear:(BOOL)animated {%orig;[CSQuickPanelCoordinator attachToChatController:self];}
- (void)viewDidLayoutSubviews {%orig;[CSQuickPanelCoordinator attachToChatController:self];}
- (void)viewWillDisappear:(BOOL)animated {[CSQuickPanelCoordinator chatControllerDidDisappear:self];%orig;}
%end

%group CSQuickPanelModernTabBar
%hook WCTabBarView
- (void)layoutSubviews {%orig;[CSQuickPanelCoordinator attachToHomeBar:self];}
- (void)didMoveToWindow {%orig;[CSQuickPanelCoordinator attachToHomeBar:self];}
%end
%end

%ctor {
    CSBackupWhenReady(^{
        [CSQuickPanelCoordinator install];
        %init;
        if (NSClassFromString(@"WCTabBarView")) {%init(CSQuickPanelModernTabBar);}
    });
}
