#import "CSNativeSettingsHost.h"
#import "CSNativeRewardPresenter.h"
#import <objc/message.h>
#import <objc/runtime.h>

static Class CSSettingsHostClass;

static void CSSettingsHostViewDidAppear(UIViewController *host, SEL selector, BOOL animated) {
    struct objc_super nativeSuper = { host, class_getSuperclass(CSSettingsHostClass) };
    ((void (*)(struct objc_super *, SEL, BOOL))objc_msgSendSuper)(&nativeSuper, selector, animated);
    CSNativeRewardSourceDidAppear(host);
}

static void CSSettingsHostViewDidLoad(UIViewController *host, SEL selector) {
    struct objc_super nativeSuper = { host, class_getSuperclass(CSSettingsHostClass) };
    ((void (*)(struct objc_super *, SEL))objc_msgSendSuper)(&nativeSuper, selector);
    UIViewController *content = [[NSClassFromString(@"CSCustomViewController") alloc] init];
    if (!content) return;
    // Keep the native view/loading implementation intact. UIKit owns child appearance
    // forwarding, navigation lookup and layout; the existing settings UI fills the host.
    [host addChildViewController:content];
    content.view.frame = host.view.bounds;
    content.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [host.view addSubview:content.view];
    [content didMoveToParentViewController:host];
}

Class CSNativeSettingsControllerClass(void) {
    if (CSSettingsHostClass) return CSSettingsHostClass;
    Class native = NSClassFromString(@"MMUIViewController");
    if (![native isSubclassOfClass:UIViewController.class]) return NSClassFromString(@"CSCustomViewController");
    // All callers are UI entry points on the main thread. Do not change any WeChat class.
    Class host = objc_allocateClassPair(native, "CSNativeSettingsHostController", 0);
    if (!host) return NSClassFromString(@"CSCustomViewController");
    Method viewDidLoad = class_getInstanceMethod(UIViewController.class, @selector(viewDidLoad));
    if (!class_addMethod(host, @selector(viewDidLoad), (IMP)CSSettingsHostViewDidLoad, method_getTypeEncoding(viewDidLoad))) {
        objc_disposeClassPair(host);
        return NSClassFromString(@"CSCustomViewController");
    }
    Method viewDidAppear = class_getInstanceMethod(UIViewController.class, @selector(viewDidAppear:));
    if (!viewDidAppear || !class_addMethod(host, @selector(viewDidAppear:), (IMP)CSSettingsHostViewDidAppear, method_getTypeEncoding(viewDidAppear))) {
        objc_disposeClassPair(host);
        return NSClassFromString(@"CSCustomViewController");
    }
    CSSettingsHostClass = host;
    objc_registerClassPair(host);
    return host;
}

UIViewController *CSNativeSettingsHostForContent(UIViewController *content) {
    UIViewController *parent = content.parentViewController;
    return CSSettingsHostClass && [parent isKindOfClass:CSSettingsHostClass] ? parent : content;
}
