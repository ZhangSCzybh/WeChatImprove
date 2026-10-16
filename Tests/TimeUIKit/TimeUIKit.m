#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NSUInteger CSTimeFontCreations;
NSString *const NSFontAttributeName=@"font";
@implementation CSTestLayer @end
@implementation UIColor
+ (instancetype)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha { return [self new]; }
+ (instancetype)clearColor { return [self new]; }
@end
@implementation UIFont
+ (instancetype)systemFontOfSize:(CGFloat)size { CSTimeFontCreations++;return [self new]; }
+ (instancetype)boldSystemFontOfSize:(CGFloat)size { return [self systemFontOfSize:size]; }
@end
static char layerKey,parentKey,gesturesKey,interactionKey;
@implementation UIView (TimeUI)
- (CSTestLayer *)layer {
    id value=objc_getAssociatedObject(self,&layerKey);
    if (!value) { value=[CSTestLayer new];objc_setAssociatedObject(self,&layerKey,value,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }return value;
}
- (BOOL)userInteractionEnabled { return [objc_getAssociatedObject(self,&interactionKey) boolValue]; }
- (void)setUserInteractionEnabled:(BOOL)value { objc_setAssociatedObject(self,&interactionKey,@(value),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (UIView *)superview { return objc_getAssociatedObject(self,&parentKey); }
- (void)addSubview:(UIView *)view {
    if (![self.subviews containsObject:view]) self.subviews=[self.subviews arrayByAddingObject:view];
    objc_setAssociatedObject(view,&parentKey,self,OBJC_ASSOCIATION_ASSIGN);
}
- (void)bringSubviewToFront:(UIView *)view {}
- (BOOL)isDescendantOfView:(UIView *)view { return self.superview==view; }
- (NSArray *)gestureRecognizers { return objc_getAssociatedObject(self,&gesturesKey) ?: @[]; }
- (void)addGestureRecognizer:(id)gesture { objc_setAssociatedObject(self,&gesturesKey,[self.gestureRecognizers arrayByAddingObject:gesture],OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
@implementation UILabel
- (void)setFrame:(CGRect)frame { [super setFrame:frame];self.bounds=CGRectMake(0,0,frame.size.width,frame.size.height); }
@end
@implementation UIGestureRecognizer @end
@implementation UITapGestureRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action { return [super init]; }
- (CGPoint)locationInView:(UIView *)view { return self.testLocation; }
@end
@implementation NSString (TimeDrawing)
- (CGRect)boundingRectWithSize:(CGSize)size options:(NSUInteger)options attributes:(NSDictionary *)attributes context:(id)context {
    return CGRectMake(0,0,MIN(size.width,self.length*5),12);
}
@end
