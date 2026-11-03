#import <UIKit/UIKit.h>

// A pushed settings page must still own the visible navigation top and have no
// competing modal, including one attached to its containing navigation controller.
static inline BOOL CSSettingsCanPresentFrom(UIViewController *presenter) {
    if (!presenter || !NSThread.isMainThread || !presenter.isViewLoaded || !presenter.view.window) return NO;
    if (presenter.navigationController && presenter.navigationController.topViewController!=presenter) return NO;
    for (UIViewController *owner=presenter; owner; owner=owner.parentViewController)
        if (owner.isBeingDismissed || owner.isMovingFromParentViewController || owner.presentedViewController) return NO;
    return YES;
}

static inline void CSSettingsAfterDismissingSheet(UIAlertController *sheet, void (^completion)(void)) {
    // UIKit may call the action before, during or after automatic dismissal.
    // Never dismiss the pushed caller: UIKit would dismiss its whole plugin modal.
    id<UIViewControllerTransitionCoordinator> transition=sheet.transitionCoordinator;
    if (sheet.isBeingDismissed && transition && [transition animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if (!context.isCancelled && completion) completion();
    }]) return;
    if (sheet.presentingViewController) [sheet dismissViewControllerAnimated:YES completion:completion];
    else if (completion) completion();
}
