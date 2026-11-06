#import "CSCloseFriendNavigation.h"

static UIViewController *VisiblePage(UIViewController *root) {
    if(root.presentedViewController && ![root.presentedViewController isKindOfClass:UIAlertController.class])
        return VisiblePage(root.presentedViewController);
    if([root isKindOfClass:UINavigationController.class]) return VisiblePage([(UINavigationController *)root topViewController]);
    if([root isKindOfClass:UITabBarController.class]) return VisiblePage([(UITabBarController *)root selectedViewController]);
    if(CSCFIsClass(root,@"BaseMsgContentViewController")) return root;
    for(UIViewController *child in root.childViewControllers.reverseObjectEnumerator)
        if(child.isViewLoaded && child.view.window) return VisiblePage(child);
    return root;
}
static BOOL ProtectedChat(UIViewController *page) {
    if(!CSCFIsClass(page,@"BaseMsgContentViewController")) return NO;
    id contact=CSCloseFriendRead(page,@"GetContact") ?: CSCloseFriendRead(page,@"GetCContact");
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    return snapshot.blocked || (snapshot.enabled && !snapshot.revealed &&
        [snapshot.protectedUserNames containsObject:CSCloseFriendUserName(contact) ?: @""]);
}
static UIViewController *FindHome(UIViewController *root) {
    if(CSCFIsClass(root,@"NewMainFrameViewController")) return root;
    for(UIViewController *child in root.childViewControllers) { UIViewController *home=FindHome(child); if(home) return home; }
    return nil;
}
static void SelectHome(UIViewController *home) {
    UINavigationController *nav=home.navigationController;
    if([nav.viewControllers containsObject:home]) [nav popToViewController:home animated:NO];
    // A chat can have been entered from Contacts, Search or a modal navigation.
    // Select the tab containing the known chat list, without resetting other tabs.
    UIViewController *child=home;
    for(UIViewController *parent=child.parentViewController;parent;child=parent,parent=parent.parentViewController)
        if([parent isKindOfClass:UITabBarController.class]) [(UITabBarController *)parent setSelectedViewController:child];
}
BOOL CSCFReturnProtectedChatToList(UIViewController *root,UIViewController *home) {
    UIViewController *page=VisiblePage(root);
    if(!ProtectedChat(page)) return NO;
    if(!home) home=FindHome(root);
    UINavigationController *nav=page.navigationController;
    // Capture presentation ownership before popping detaches the chat controller.
    UIViewController *presenter=nil;
    for(UIViewController *ancestor=page;ancestor;ancestor=ancestor.parentViewController)
        if(ancestor.presentingViewController) presenter=ancestor.presentingViewController;
    if(page.presentedViewController) [page dismissViewControllerAnimated:NO completion:nil];
    if(home && [nav.viewControllers containsObject:home]) [nav popToViewController:home animated:NO];
    else if(nav.viewControllers.count>1) {
        NSMutableArray *stack=[NSMutableArray array];
        for(UIViewController *controller in nav.viewControllers) if(!ProtectedChat(controller)) [stack addObject:controller];
        if(stack.count) [nav setViewControllers:stack animated:NO];
    }
    if(presenter) [presenter dismissViewControllerAnimated:NO completion:nil];
    if(home) SelectHome(home);
    return YES;
}
