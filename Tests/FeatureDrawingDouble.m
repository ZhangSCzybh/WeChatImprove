#import "FeatureDrawingDouble.h"
static NSString *const contextKey=@"CSFeatureDrawingContext";
@implementation UIColor
+ (instancetype)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    UIColor *c=[self new];c.red=r;c.green=g;c.blue=b;c.alpha=a;return c;
}
- (void)setFill { ((UIImage *)NSThread.currentThread.threadDictionary[contextKey]).fill=self; }
@end
@implementation UIImage
- (CGImageRef)CGImage { return NULL; }
- (id)resizableImageWithCapInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode { self.capInsets=insets;return self; }
@end
@implementation UIBezierPath
+ (id)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii {
    UIBezierPath *p=[self new];p.corners=corners;p.radius=radii.width;return p;
}
+ (id)bezierPathWithRect:(CGRect)rect { return [self new]; }
- (void)fill { UIImage *i=NSThread.currentThread.threadDictionary[contextKey];i.corners=self.corners;i.radius=self.radius; }
@end
void UIGraphicsBeginImageContextWithOptions(CGSize size,BOOL opaque,CGFloat scale) {
    UIImage *i=[UIImage new];i.size=size;i.scale=scale;NSThread.currentThread.threadDictionary[contextKey]=i;
}
CGContextRef UIGraphicsGetCurrentContext(void) { return (CGContextRef)1; }
UIImage *UIGraphicsGetImageFromCurrentImageContext(void) { return NSThread.currentThread.threadDictionary[contextKey]; }
void UIGraphicsEndImageContext(void) { [NSThread.currentThread.threadDictionary removeObjectForKey:contextKey]; }
@implementation CMessageWrap @end
@implementation CSFeatureContact @end
@implementation CommonMessageViewModel @end
