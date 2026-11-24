#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSInputTextGesture.h"

@interface BaseMsgContentViewController : UIViewController @end

%hook BaseMsgContentViewController
- (void)viewDidAppear:(BOOL)animated { %orig; CSInputTextGestureChatVisibility(self, YES); }
- (void)viewDidLayoutSubviews { %orig; CSInputTextGestureChatDidLayout(self); }
- (void)viewWillDisappear:(BOOL)animated { CSInputTextGestureChatVisibility(self, NO); %orig; }
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other {
    // If a chat pan uses WeChat 8.0.80's default YES branch, it makes our input
    // recognizer wait for that pan. Remove this reverse edge before giving the
    // input priority, so the two delegates cannot request mutual failure.
    if (CSInputTextGesturePrioritizesRecognizer(other, gesture)) return NO;
    return %orig;
}
%end

%ctor {
    CSBackupWhenReady(^{
        CSInputTextGestureInstall();
        %init;
    });
}
