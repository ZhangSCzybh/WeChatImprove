// Host-only UIKit doubles. Production sources are compiled against this interface.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <dispatch/dispatch.h>
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static const UIEdgeInsets UIEdgeInsetsZero={0,0,0,0};
static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat t,CGFloat l,CGFloat b,CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
static inline BOOL UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsets a,UIEdgeInsets b) { return a.top==b.top && a.left==b.left && a.bottom==b.bottom && a.right==b.right; }
typedef NS_ENUM(NSInteger, UIUserInterfaceStyle) { UIUserInterfaceStyleUnspecified,UIUserInterfaceStyleLight,UIUserInterfaceStyleDark };
typedef NS_OPTIONS(NSUInteger, UIRectCorner) { UIRectCornerTopLeft=1,UIRectCornerTopRight=2,UIRectCornerBottomLeft=4,UIRectCornerBottomRight=8,UIRectCornerAllCorners=15 };
typedef NS_ENUM(NSInteger, UITableViewCellSeparatorStyle) { UITableViewCellSeparatorStyleNone };
@class UIGestureRecognizer,UITouch;
@interface UITraitCollection : NSObject
@property(nonatomic) UIUserInterfaceStyle userInterfaceStyle;
@end
@interface UIColor : NSObject
@property(nonatomic) CGFloat red,green,blue,alpha;
+ (instancetype)clearColor;
+ (instancetype)whiteColor;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) BOOL hidden,userInteractionEnabled;
@property(nonatomic,strong) CALayer *layer;
@property(nonatomic,strong) UIColor *backgroundColor;
@property(nonatomic,strong) UITraitCollection *traitCollection;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) id responder;
@property(nonatomic,strong) NSMutableArray<UIView *> *subviews;
@property(nonatomic) NSUInteger layoutInvalidations;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)removeFromSuperview;
- (BOOL)isDescendantOfView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
- (id)nextResponder;
- (void)setNeedsLayout;
@end
@interface UITableViewCell : UIView {
@public UIView *m_subContentView;
}
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic) UIEdgeInsets separatorInset,layoutMargins;
@property(nonatomic) BOOL preservesSuperviewLayoutMargins;
@property(nonatomic,strong) NSIndexPath *path;
@end
@interface UITableView : UIView
@property(nonatomic,strong) UIView *backgroundView,*tableHeaderView;
@property(nonatomic) BOOL showsVerticalScrollIndicator;
@property(nonatomic) UITableViewCellSeparatorStyle separatorStyle;
@property(nonatomic) CGFloat sectionHeaderHeight,sectionFooterHeight;
@property(nonatomic,copy) NSArray<NSNumber *> *rows;
@property(nonatomic) BOOL throwsOnQuery;
@property(nonatomic) NSUInteger queries,reloads,originalCalls;
@property(nonatomic,strong) id groupAdapter;
@property(nonatomic,copy) void (^onQuery)(void);
@property(nonatomic,readonly) NSInteger numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;
- (void)reloadData;
- (CGFloat)originalHeight;
@end
@interface NSIndexPath (ListCornerUIKit)
@property(nonatomic,readonly) NSInteger section,row;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@interface UIViewController : NSObject @end
@interface UIImageView : UIView @end
@interface UILabel : UIView @end
@interface UIBezierPath : NSObject
@property(nonatomic,readonly) CGPathRef CGPath;
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius;
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii;
+ (instancetype)bezierPathWithRect:(CGRect)rect;
@end
