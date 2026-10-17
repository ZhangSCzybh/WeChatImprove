#import <UIKit/UIKit.h>
@implementation UITraitCollection @end
@implementation UIColor
+ (instancetype)clearColor { return [self colorWithRed:0 green:0 blue:0 alpha:0]; }
+ (instancetype)whiteColor { return [self colorWithRed:1 green:1 blue:1 alpha:1]; }
+ (instancetype)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a { UIColor *c=[self new];c.red=r;c.green=g;c.blue=b;c.alpha=a;return c; }
- (BOOL)getRed:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a { *r=self.red;*g=self.green;*b=self.blue;*a=self.alpha;return YES; }
- (BOOL)isEqual:(id)other { return [other isKindOfClass:UIColor.class] && self.red==[other red] && self.green==[other green] && self.blue==[other blue] && self.alpha==[other alpha]; }
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) { _alpha=1;_userInteractionEnabled=YES;_layer=[CALayer layer];_subviews=[NSMutableArray array];_traitCollection=[UITraitCollection new]; } return self; }
- (instancetype)initWithFrame:(CGRect)frame { if ((self=[self init])) self.frame=frame;return self; }
- (void)setFrame:(CGRect)frame { _frame=frame;_bounds.size=frame.size; }
- (void)addSubview:(UIView *)view { [self insertSubview:view atIndex:self.subviews.count]; }
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index { [view removeFromSuperview];view.superview=self;[self.subviews insertObject:view atIndex:index]; }
- (void)removeFromSuperview { [self.superview.subviews removeObjectIdenticalTo:self];self.superview=nil; }
- (BOOL)isDescendantOfView:(UIView *)view { for(UIView *p=self;p;p=p.superview) if(p==view)return YES;return NO; }
- (CGPoint)origin { CGPoint p=CGPointZero;for(UIView *v=self;v;v=v.superview) {p.x+=v.frame.origin.x-v.bounds.origin.x;p.y+=v.frame.origin.y-v.bounds.origin.y;}return p; }
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view { CGPoint a=self.origin,b=view.origin;rect.origin.x+=a.x-b.x;rect.origin.y+=a.y-b.y;return rect; }
- (id)nextResponder { return self.responder ?: self.superview; }
- (void)setNeedsLayout { self.layoutInvalidations++; }
@end
@implementation UITableViewCell
- (instancetype)init { if ((self=[super init])) { _contentView=[UIView new];[self addSubview:_contentView]; }return self; }
@end
@implementation UITableView
- (void)query { self.queries++;if(self.onQuery)self.onQuery();if(self.throwsOnQuery)[NSException raise:@"query" format:@"height callback queried/refreshed table"]; }
- (NSInteger)numberOfSections { [self query];return self.rows.count; }
- (NSInteger)numberOfRowsInSection:(NSInteger)section { [self query];if(section<0 || section>=(NSInteger)self.rows.count)[NSException raise:@"bounds" format:@"section out of bounds"];return self.rows[section].integerValue; }
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell { [self query];return cell.path; }
- (void)reloadData { [self query];self.reloads++; }
- (CGFloat)originalHeight { self.originalCalls++;return 7; }
@end
@implementation NSIndexPath (ListCornerUIKit)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section { NSUInteger values[]={(NSUInteger)section,(NSUInteger)row};return [NSIndexPath indexPathWithIndexes:values length:2]; }
- (NSInteger)section { return [self indexAtPosition:0]; }
- (NSInteger)row { return [self indexAtPosition:1]; }
@end
@implementation UIViewController @end
@implementation UIImageView @end
@implementation UILabel @end
@implementation UIBezierPath { CGPathRef _path; }
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius { UIBezierPath *p=[self new];p->_path=CGPathCreateWithRoundedRect(rect,radius,radius,NULL);return p; }
+ (instancetype)bezierPathWithRect:(CGRect)rect { UIBezierPath *p=[self new];p->_path=CGPathCreateWithRect(rect,NULL);return p; }
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii {
    UIBezierPath *p=[self new];CGMutablePathRef path=CGPathCreateMutable();
    CGFloat r=MIN(radii.width,MIN(rect.size.width,rect.size.height)/2),w=rect.size.width,h=rect.size.height;
    CGFloat tl=(corners&UIRectCornerTopLeft)?r:0,tr=(corners&UIRectCornerTopRight)?r:0,bl=(corners&UIRectCornerBottomLeft)?r:0,br=(corners&UIRectCornerBottomRight)?r:0;
    CGPathMoveToPoint(path,NULL,tl,0);CGPathAddLineToPoint(path,NULL,w-tr,0);CGPathAddQuadCurveToPoint(path,NULL,w,0,w,tr);
    CGPathAddLineToPoint(path,NULL,w,h-br);CGPathAddQuadCurveToPoint(path,NULL,w,h,w-br,h);
    CGPathAddLineToPoint(path,NULL,bl,h);CGPathAddQuadCurveToPoint(path,NULL,0,h,0,h-bl);
    CGPathAddLineToPoint(path,NULL,0,tl);CGPathAddQuadCurveToPoint(path,NULL,0,0,tl,0);CGPathCloseSubpath(path);p->_path=path;return p;
}
- (CGPathRef)CGPath { return _path; }
- (void)dealloc { if(_path)CGPathRelease(_path); }
@end
