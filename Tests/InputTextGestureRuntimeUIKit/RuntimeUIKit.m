#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

@implementation UIGestureRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super init])) { _enabled = YES; _testTarget = target; _testAction = action; }
    return self;
}
- (void)setState:(UIGestureRecognizerState)state {
    if (state == UIGestureRecognizerStateRecognized &&
        [self.delegate respondsToSelector:@selector(gestureRecognizerShouldBegin:)] &&
        ![self.delegate gestureRecognizerShouldBegin:self]) state = UIGestureRecognizerStateFailed;
    _state = state;
    if (state == UIGestureRecognizerStateRecognized && self.enabled && self.testTarget)
        ((void (*)(id, SEL, id))objc_msgSend)(self.testTarget, self.testAction, self);
}
- (void)setEnabled:(BOOL)enabled {
    if (_enabled == enabled) return;
    _enabled = enabled;
    if (!enabled) _state = UIGestureRecognizerStateFailed;
    else [self reset];
}
- (void)reset { _state = UIGestureRecognizerStatePossible; }
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}
@end
@implementation UIPanGestureRecognizer @end
@implementation UIScreenEdgePanGestureRecognizer @end
@implementation UILongPressGestureRecognizer @end

static char recognizersKey, keyWindowKey, timestampKey, dismissedKey, presentedKey,
    transitionKey, modalKey, navigationKey, visibleKey, popKey;
@implementation UIView (InputGestureRuntime)
- (NSArray *)gestureRecognizers { return objc_getAssociatedObject(self, &recognizersKey) ?: @[]; }
- (void)addGestureRecognizer:(UIGestureRecognizer *)recognizer {
    [recognizer.view removeGestureRecognizer:recognizer];
    NSMutableArray *items = [self.gestureRecognizers mutableCopy];
    [items addObject:recognizer];
    objc_setAssociatedObject(self, &recognizersKey, items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    recognizer.view = self;
}
- (void)removeGestureRecognizer:(UIGestureRecognizer *)recognizer {
    if (!recognizer) return;
    NSMutableArray *items = [self.gestureRecognizers mutableCopy];
    [items removeObjectIdenticalTo:recognizer];
    objc_setAssociatedObject(self, &recognizersKey, items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (recognizer.view == self) recognizer.view = nil;
}
@end
@implementation UIWindow (InputGestureRuntime)
- (BOOL)isKeyWindow { return [objc_getAssociatedObject(self, &keyWindowKey) boolValue]; }
- (void)setIsKeyWindow:(BOOL)value { objc_setAssociatedObject(self, &keyWindowKey, @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
@implementation UITouch (InputGestureRuntime)
- (NSTimeInterval)timestamp { return [objc_getAssociatedObject(self, &timestampKey) doubleValue]; }
- (void)setTimestamp:(NSTimeInterval)value { objc_setAssociatedObject(self, &timestampKey, @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (UIView *)view { return self.testView; }
@end
@implementation UIViewController (InputGestureRuntime)
- (BOOL)isBeingDismissed { return [objc_getAssociatedObject(self, &dismissedKey) boolValue]; }
- (void)setIsBeingDismissed:(BOOL)value { objc_setAssociatedObject(self, &dismissedKey, @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (BOOL)isBeingPresented { return [objc_getAssociatedObject(self, &presentedKey) boolValue]; }
- (void)setIsBeingPresented:(BOOL)value { objc_setAssociatedObject(self, &presentedKey, @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (id)transitionCoordinator { return objc_getAssociatedObject(self, &transitionKey); }
- (void)setTransitionCoordinator:(id)value { objc_setAssociatedObject(self, &transitionKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (UIViewController *)presentedViewController { return objc_getAssociatedObject(self, &modalKey); }
- (void)setPresentedViewController:(UIViewController *)value { objc_setAssociatedObject(self, &modalKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (UINavigationController *)navigationController { return objc_getAssociatedObject(self, &navigationKey); }
- (void)setNavigationController:(UINavigationController *)value { objc_setAssociatedObject(self, &navigationKey, value, OBJC_ASSOCIATION_ASSIGN); }
@end
@implementation UINavigationController (InputGestureRuntime)
- (UIViewController *)visibleViewController { return objc_getAssociatedObject(self, &visibleKey); }
- (void)setVisibleViewController:(UIViewController *)value { objc_setAssociatedObject(self, &visibleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (UIGestureRecognizer *)interactivePopGestureRecognizer { return objc_getAssociatedObject(self, &popKey); }
- (void)setInteractivePopGestureRecognizer:(UIGestureRecognizer *)value { objc_setAssociatedObject(self, &popKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
@implementation UITextView
- (instancetype)init { if ((self = [super init])) { _editable = YES; _selectable = YES; _text = @"draft"; } return self; }
- (id)beginningOfDocument { return @0; }
- (id)endOfDocument { return @(self.text.length); }
- (id)textRangeFromPosition:(id)fromPosition toPosition:(id)toPosition {
    return [NSValue valueWithRange:NSMakeRange([fromPosition unsignedIntegerValue], [toPosition unsignedIntegerValue] - [fromPosition unsignedIntegerValue])];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender { return YES; }
- (void)copy:(id)sender {}
- (void)cut:(id)sender { self.text = @""; }
- (void)paste:(id)sender { self.testPastes++; }
- (void)deleteBackward { self.testDeletes++; self.text = @""; }
@end
