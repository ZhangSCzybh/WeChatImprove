#import <UIKit/UIKit.h>
NSString *const UIMenuControllerDidHideMenuNotification = @"UIMenuControllerDidHideMenuNotification";
NSString *const UIApplicationWillResignActiveNotification=@"UIApplicationWillResignActiveNotification";
NSString *const UIApplicationDidEnterBackgroundNotification=@"UIApplicationDidEnterBackgroundNotification";
NSString *const UIApplicationDidBecomeActiveNotification=@"UIApplicationDidBecomeActiveNotification";
NSString *const UISceneWillDeactivateNotification=@"UISceneWillDeactivateNotification";
NSString *const UISceneDidActivateNotification=@"UISceneDidActivateNotification";
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; static dispatch_once_t once; dispatch_once(&once,^{ app=[self new]; }); return app; }
@end
@implementation UIScene @end
@implementation NSIndexPath (MessageUIKit)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section { NSUInteger values[] = {(NSUInteger)section,(NSUInteger)row}; return [self indexPathWithIndexes:values length:2]; }
- (NSInteger)section { return [self indexAtPosition:0]; }
- (NSInteger)row { return [self indexAtPosition:1]; }
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) { _alpha=1; _transform=CGAffineTransformIdentity; _subviews=@[];
#ifdef CS_MERGE_BUBBLE_INTEGRATION
    _traitCollection=[UITraitCollection new];_traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
#endif
 } return self; }
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view {
    for (UIView *node=view;node && node!=self;node=node.superview)
        rect=CGRectOffset(rect,node.frame.origin.x-node.bounds.origin.x,node.frame.origin.y-node.bounds.origin.y);
    return rect;
}
- (void)setNeedsLayout { self.layoutRequests++; }
- (void)layoutIfNeeded {}
+ (void)performWithoutAnimation:(void (^)(void))block { block(); }
@end
@implementation UIWindow @end
@implementation UITableView
- (id)cellForRowAtIndexPath:(NSIndexPath *)path { return self.testCells[path]; }
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)path { return [self rectForSection:path.section]; }
- (CGRect)rectForSection:(NSInteger)section { CGFloat y=0; for (NSInteger i=0;i<section;i++) y += self.testHeights[i].doubleValue; return CGRectMake(0,y,320,self.testHeights[section].doubleValue); }
- (NSInteger)numberOfSections { return self.testHeights.count; }
- (NSInteger)numberOfRowsInSection:(NSInteger)section { return section >= 0 && (NSUInteger)section < self.testHeights.count ? 1 : 0; }
- (void)beginUpdates { self.updateCount++; }
- (void)endUpdates {}
- (void)setContentOffset:(CGPoint)point animated:(BOOL)animated { self.contentOffset=point; }
@end
@implementation UIViewController
- (UIView *)viewIfLoaded { return self.view; }
- (BOOL)isBeingDismissed { return NO; }
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion { self.presentedViewController=controller; if (completion) completion(); }
@end
@implementation UIMenuController
+ (instancetype)sharedMenuController { static id menu; static dispatch_once_t once; dispatch_once(&once,^{menu=[self new];});return menu; }
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler { return [self new]; }
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style { return [self new]; }
- (void)addAction:(UIAlertAction *)action {}
@end

#ifdef CS_MERGE_BUBBLE_INTEGRATION
@implementation UIView (BubbleIntegration)
- (void)addSubview:(UIView *)view { self.subviews=[self.subviews arrayByAddingObject:view];view.superview=self; }
- (void)setNeedsDisplay { self.displayRequests++; }
- (BOOL)isDescendantOfView:(UIView *)view { for (UIView *node=self;node;node=node.superview) if (node==view) return YES;return NO; }
@end
#endif
