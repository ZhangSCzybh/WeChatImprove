#import <UIKit/UIKit.h>

@implementation CSVoiceTestLayer @end
@implementation CSVoiceTestShapeLayer
+ (instancetype)layer { return [self new]; }
@end
@implementation UIBezierPath {
    CGPathRef _testPath;
}
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius {
    UIBezierPath *path=[self new];path->_testPath=CGPathCreateWithRoundedRect(rect,radius,radius,NULL);return path;
}
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii {
    return [self bezierPathWithRoundedRect:rect cornerRadius:MIN(radii.width,radii.height)];
}
- (CGPathRef)CGPath { return _testPath; }
- (void)dealloc { if (_testPath) CGPathRelease(_testPath); }
@end
@implementation UIColor
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *color=[self new];color.testRed=red;color.testGreen=green;color.testBlue=blue;color.testAlpha=alpha;return color;
}
+ (instancetype)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha { return [self colorWithRed:white green:white blue:white alpha:alpha]; }
+ (instancetype)clearColor { return [self colorWithWhite:0 alpha:0]; }
+ (instancetype)systemBlueColor { return [self colorWithRed:0 green:.4 blue:1 alpha:1]; }
+ (instancetype)labelColor { return [self colorWithWhite:.1 alpha:1]; }
+ (instancetype)secondarySystemBackgroundColor { return [self colorWithWhite:.95 alpha:1]; }
- (instancetype)colorWithAlphaComponent:(CGFloat)alpha { return [UIColor colorWithRed:_testRed green:_testGreen blue:_testBlue alpha:alpha]; }
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    if (red) *red=_testRed;if (green) *green=_testGreen;if (blue) *blue=_testBlue;if (alpha) *alpha=_testAlpha;return YES;
}
- (BOOL)getWhite:(CGFloat *)white alpha:(CGFloat *)alpha { if (white) *white=_testRed;if (alpha) *alpha=_testAlpha;return YES; }
@end
@implementation UIFont
+ (instancetype)systemFontOfSize:(CGFloat)size { return [self new]; }
+ (instancetype)monospacedDigitSystemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight { return [self new]; }
@end
@implementation UITraitCollection @end
@implementation UIResponder @end
@implementation UIView {
    NSMutableArray<UIGestureRecognizer *> *_testGestures;
    CSVoiceTestLayer *_layer;
    __weak UIWindow *_testWindow;
}
- (instancetype)init { return [self initWithFrame:CGRectZero]; }
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super init])) {
        _frame=frame;_bounds=(CGRect){CGPointZero,frame.size};_alpha=1;_transform=CGAffineTransformIdentity;
        _subviews=@[];_testGestures=[NSMutableArray array];_userInteractionEnabled=YES;_layer=[CSVoiceTestLayer new];
        _traitCollection=[UITraitCollection new];_traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
    } return self;
}
- (void)setFrame:(CGRect)frame { _frame=frame;_bounds.size=frame.size; }
- (CGPoint)center { return CGPointMake(CGRectGetMidX(_frame),CGRectGetMidY(_frame)); }
- (void)setCenter:(CGPoint)center { _frame.origin=CGPointMake(center.x-_frame.size.width/2,center.y-_frame.size.height/2); }
- (UIWindow *)window { return [self isKindOfClass:UIWindow.class] ? (UIWindow *)self : (_testWindow ?: _superview.window); }
- (void)setWindow:(UIWindow *)window { _testWindow=window; }
- (CSVoiceTestLayer *)layer { return _layer; }
- (NSArray *)gestureRecognizers { return [_testGestures copy]; }
- (void)addSubview:(UIView *)view {
    if (view.superview!=self) { [view removeFromSuperview];view.superview=self; }
    if (![_subviews containsObject:view]) _subviews=[_subviews arrayByAddingObject:view];
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)sibling {
    [self addSubview:view];NSMutableArray *items=[_subviews mutableCopy];[items removeObject:view];
    NSUInteger index=[items indexOfObject:sibling];[items insertObject:view atIndex:index==NSNotFound ? items.count : index+1];_subviews=items;
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)sibling {
    [self addSubview:view];NSMutableArray *items=[_subviews mutableCopy];[items removeObject:view];
    NSUInteger index=[items indexOfObject:sibling];[items insertObject:view atIndex:index==NSNotFound ? 0 : index];_subviews=items;
}
- (void)bringSubviewToFront:(UIView *)view { if ([_subviews containsObject:view]) { NSMutableArray *items=[_subviews mutableCopy];[items removeObject:view];[items addObject:view];_subviews=items; } }
- (void)removeFromSuperview { UIView *parent=_superview;if (parent) { NSMutableArray *items=[parent.subviews mutableCopy];[items removeObject:self];parent.subviews=items; }_superview=nil; }
- (BOOL)isDescendantOfView:(UIView *)view { for (UIView *node=self;node;node=node.superview) if (node==view) return YES;return NO; }
- (CGPoint)testAbsoluteOrigin {
    CGPoint origin=CGPointZero;for (UIView *node=self;node;node=node.superview) { origin.x+=node.frame.origin.x-node.bounds.origin.x;origin.y+=node.frame.origin.y-node.bounds.origin.y; }return origin;
}
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view {
    CGPoint from=[view testAbsoluteOrigin],to=[self testAbsoluteOrigin];return CGPointMake(point.x+from.x-to.x,point.y+from.y-to.y);
}
- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view { return [view convertPoint:point fromView:self]; }
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view { return (CGRect){[self convertPoint:rect.origin fromView:view],rect.size}; }
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view { return [view convertRect:rect fromView:self]; }
- (void)setNeedsLayout { _layoutRequests++; }
- (void)layoutIfNeeded { [self layoutSubviews];for (UIView *child in self.subviews) [child layoutIfNeeded]; }
- (void)layoutSubviews {}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event { return CGRectContainsPoint(_bounds,point); }
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture { [gesture.view removeGestureRecognizer:gesture];gesture.view=self;[_testGestures addObject:gesture]; }
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gesture { [_testGestures removeObject:gesture];if (gesture.view==self) gesture.view=nil; }
@end
@implementation UIWindow @end
@implementation UIImage @end
@implementation UIImageView @end
@implementation UILabel
- (CGSize)sizeThatFits:(CGSize)size { return CGSizeMake(MIN(size.width,_text.length*7),MIN(size.height,16)); }
@end
@implementation UIControl @end
@implementation UIEvent @end
@implementation UIGestureRecognizer {
    NSMutableArray *_testRequirements;
}
- (instancetype)init { return [self initWithTarget:nil action:NULL]; }
- (instancetype)initWithTarget:(id)target action:(SEL)action { if ((self=[super init])) { _enabled=YES;_testRequirements=[NSMutableArray array]; }return self; }
- (CGPoint)locationInView:(UIView *)view { return [view convertPoint:_testLocation fromView:_view]; }
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)other { if (other) [_testRequirements addObject:other]; }
- (NSArray *)testFailureRequirements { return [_testRequirements copy]; }
@end
@implementation UIPanGestureRecognizer
- (CGPoint)translationInView:(UIView *)view { return _testTranslation; }
- (CGPoint)velocityInView:(UIView *)view { return _testVelocity; }
@end
@implementation UITapGestureRecognizer @end
@implementation UILongPressGestureRecognizer @end
@implementation UIScreenEdgePanGestureRecognizer @end
@implementation UITouch
- (CGPoint)locationInView:(UIView *)view { return [view convertPoint:_testLocation fromView:_view]; }
@end
@implementation UIScrollView @end
@implementation UIViewController @end
@implementation UINavigationController @end
