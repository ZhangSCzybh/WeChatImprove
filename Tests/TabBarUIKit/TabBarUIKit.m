#import <UIKit/UIKit.h>
NSString *const UIAccessibilityReduceMotionStatusDidChangeNotification=@"reduceMotion";
NSString *const UIApplicationDidBecomeActiveNotification=@"applicationActive";
NSString *const UISceneDidActivateNotification=@"sceneActive";
NSString *const UIApplicationWillResignActiveNotification=@"applicationInactive";
NSString *const UISceneWillDeactivateNotification=@"sceneInactive";
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if (!app) app=[self new]; return app; }
@end
@implementation UIWindowScene @end
BOOL CSTestReduceMotionEnabled=NO;
NSUInteger CSTestHapticCount=0;
BOOL UIAccessibilityIsReduceMotionEnabled(void) { return CSTestReduceMotionEnabled; }
@implementation UITraitCollection @end
@implementation CSTestViewAnimation @end
NSMutableArray<CSTestViewAnimation *> *CSTestViewAnimations;
NSMutableArray<NSNumber *> *CSTestIndicatorFrameWrites;
static NSUInteger CSTestAnimationKind;
@implementation UIColor { CGColorRef _color; }
+ (instancetype)clearColor { static UIColor *c; if (!c) c=[self colorWithRed:0 green:0 blue:0 alpha:0]; return c; }
+ (instancetype)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    UIColor *c=[self new]; c.red=r;c.green=g;c.blue=b;c.alpha=a;
    c->_color=CGColorCreateGenericRGB(r,g,b,a); return c;
}
- (CGColorRef)CGColor { return _color; }
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)trait { return self; }
- (void)dealloc { if (_color) CGColorRelease(_color); }
@end
@implementation UIView
+ (void)performWithoutAnimation:(void (^)(void))actions { NSUInteger previous=CSTestAnimationKind;CSTestAnimationKind=0;actions();CSTestAnimationKind=previous; }
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    if (!CSTestViewAnimations) CSTestViewAnimations=[NSMutableArray array];
    CSTestViewAnimation *record=[CSTestViewAnimation new];record.duration=duration;record.delay=delay;record.options=options;
    [CSTestViewAnimations addObject:record];NSUInteger previous=CSTestAnimationKind;CSTestAnimationKind=1;if (animations) animations();CSTestAnimationKind=previous;if(completion)completion(YES);
}
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    if (!CSTestViewAnimations) CSTestViewAnimations=[NSMutableArray array];
    CSTestViewAnimation *record=[CSTestViewAnimation new];record.duration=duration;record.delay=delay;record.options=options;record.spring=YES;record.damping=damping;record.velocity=velocity;
    [CSTestViewAnimations addObject:record];NSUInteger previous=CSTestAnimationKind;CSTestAnimationKind=2;if (animations) animations();CSTestAnimationKind=previous;if(completion)completion(YES);
}
- (instancetype)init { if ((self=[super init])) { _alpha=1;_userInteractionEnabled=YES;_transform=CGAffineTransformIdentity;_layer=[CALayer layer];_subviews=[NSMutableArray array];_traitCollection=[UITraitCollection new]; } return self; }
- (instancetype)initWithFrame:(CGRect)frame { if ((self=[self init])) self.frame=frame; return self; }
- (void)setFrame:(CGRect)frame { _frame=frame; _bounds.size=frame.size;if([self.layer.name isEqualToString:@"cs.tabbar.indicator"]){if(!CSTestIndicatorFrameWrites)CSTestIndicatorFrameWrites=[NSMutableArray array];[CSTestIndicatorFrameWrites addObject:@(CSTestAnimationKind)];} }
- (CGPoint)center { return CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)); }
- (void)setCenter:(CGPoint)center { CGRect frame=self.frame;frame.origin=CGPointMake(center.x-frame.size.width/2,center.y-frame.size.height/2);self.frame=frame; }
- (UIWindow *)window { if ([self isKindOfClass:UIWindow.class]) return (id)self; return self.superview.window; }
- (void)addSubview:(UIView *)view { [self insertSubview:view atIndex:self.subviews.count]; }
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index { [view removeFromSuperview];view.superview=self;[self.subviews insertObject:view atIndex:index]; }
- (void)removeFromSuperview { [self.superview.subviews removeObjectIdenticalTo:self];self.superview=nil; }
- (BOOL)isDescendantOfView:(UIView *)view { for (UIView *v=self;v;v=v.superview) if(v==view)return YES;return NO; }
- (CGPoint)absoluteOrigin { CGPoint p=CGPointZero; for(UIView *v=self;v;v=v.superview){p.x+=v.frame.origin.x-v.bounds.origin.x;p.y+=v.frame.origin.y-v.bounds.origin.y;}return p; }
- (CGPoint)convertPoint:(CGPoint)p toView:(UIView *)view { CGPoint a=[self absoluteOrigin],b=[view absoluteOrigin];return CGPointMake(p.x+a.x-b.x,p.y+a.y-b.y); }
- (CGRect)convertRect:(CGRect)r toView:(UIView *)view { r.origin=[self convertPoint:r.origin toView:view];return r; }
- (CGPoint)convertPoint:(CGPoint)p fromView:(UIView *)view { if(view)return [view convertPoint:p toView:self];CGPoint own=[self absoluteOrigin];return CGPointMake(p.x-own.x,p.y-own.y); }
- (CGRect)convertRect:(CGRect)r fromView:(UIView *)view { r.origin=[self convertPoint:r.origin fromView:view];return r; }
- (UIView *)hitTest:(CGPoint)p withEvent:(id)event { return !self.hidden && self.alpha>.01 && self.userInteractionEnabled && CGRectContainsPoint(self.bounds,p) ? self : nil; }
- (void)setNeedsLayout {}
- (void)layoutIfNeeded {}
@end
@implementation UIWindow @end
@implementation UITouch
- (CGPoint)locationInView:(UIView *)view { return [self.testView convertPoint:self.testLocation toView:view]; }
@end
@implementation UIEvent
- (NSSet<UITouch *> *)touchesForView:(UIView *)view { return self.allTouches; }
@end
@implementation UIImage
+ (instancetype)imageWithContentsOfFile:(NSString *)path { if (![NSFileManager.defaultManager fileExistsAtPath:path]) return nil;UIImage *image=[self new];image.path=path;return image; }
@end
@implementation UIImageView @end
@implementation UIFont
- (instancetype)init { if((self=[super init]))_lineHeight=12;return self; }
@end
@implementation UILabel
- (instancetype)init { if((self=[super init]))_font=[UIFont new];return self; }
@end
@interface CSTestAction : NSObject
@property(nonatomic,weak) id target;
@property(nonatomic) SEL action;
@property(nonatomic) UIControlEvents events;
@end
@implementation CSTestAction @end
@implementation UIControl
- (instancetype)init { if((self=[super init])){_actions=[NSMutableArray array];_enabled=YES;}return self; }
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events { CSTestAction *a=[CSTestAction new];a.target=target;a.action=action;a.events=events;[self.actions addObject:a]; }
- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events { for(CSTestAction *a in self.actions.copy)if((!target || a.target==target) && (!action || a.action==action) && (a.events&events)){a.events&=~events;if(!a.events)[self.actions removeObject:a];} }
- (void)sendActionsForControlEvents:(UIControlEvents)events { [self sendActionsForControlEvents:events withEvent:nil]; }
- (void)sendActionsForControlEvents:(UIControlEvents)events withEvent:(UIEvent *)event { for(CSTestAction *a in self.actions.copy)if((a.events&events) && a.target)[self sendAction:a.action to:a.target forEvent:event]; }
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSMethodSignature *signature=[target methodSignatureForSelector:action];
    NSUInteger count=signature.numberOfArguments;
    if(count==2)((void(*)(id,SEL))[target methodForSelector:action])(target,action);
    else if(count==3)((void(*)(id,SEL,id))[target methodForSelector:action])(target,action,self);
    else if(count==4)((void(*)(id,SEL,id,id))[target methodForSelector:action])(target,action,self,event);
    else [NSException raise:NSInvalidArgumentException format:@"Unsupported host control action %@",NSStringFromSelector(action)];
}
- (void)cancelTrackingWithEvent:(UIEvent *)event {}
@end
@implementation UITabBarItem @end
@implementation UITabBar @end
@implementation UIViewController
- (UIView *)viewIfLoaded { return self.view; }
@end
@implementation UITabBarController @end
@implementation UINavigationController @end
@implementation UIScrollView
- (UIEdgeInsets)adjustedContentInset { UIEdgeInsets i=self.contentInset;i.bottom+=self.systemBottom;return i; }
@end
@implementation UITableView @end
@implementation UIBlurEffect
+ (instancetype)effectWithStyle:(UIBlurEffectStyle)style { return [self new]; }
@end
@implementation UIVisualEffectView
- (instancetype)initWithEffect:(UIBlurEffect *)effect { return [super init]; }
@end
@implementation UIBezierPath { CGPathRef _path; }
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius { UIBezierPath *p=[self new];p->_path=CGPathCreateWithRoundedRect(rect,radius,radius,NULL);return p; }
- (CGPathRef)CGPath { return _path; }
- (BOOL)containsPoint:(CGPoint)p { return CGPathContainsPoint(_path,NULL,p,NO); }
- (void)dealloc { if(_path)CGPathRelease(_path); }
@end
@implementation UIImpactFeedbackGenerator
- (instancetype)initWithStyle:(UIImpactFeedbackStyle)style { return [super init]; }
- (void)impactOccurred { CSTestHapticCount++; }
@end
