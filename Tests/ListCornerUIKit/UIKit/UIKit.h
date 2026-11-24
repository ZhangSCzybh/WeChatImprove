// Host-only UIKit doubles. Production sources are compiled against this interface.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <dispatch/dispatch.h>
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static const UIEdgeInsets UIEdgeInsetsZero={0,0,0,0};
static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat t,CGFloat l,CGFloat b,CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
static inline BOOL UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsets a,UIEdgeInsets b) { return a.top==b.top && a.left==b.left && a.bottom==b.bottom && a.right==b.right; }
typedef NS_ENUM(NSInteger, UIUserInterfaceStyle) { UIUserInterfaceStyleUnspecified,UIUserInterfaceStyleLight,UIUserInterfaceStyleDark };
typedef NS_OPTIONS(NSUInteger, UIRectCorner) { UIRectCornerTopLeft=1,UIRectCornerTopRight=2,UIRectCornerBottomLeft=4,UIRectCornerBottomRight=8,UIRectCornerAllCorners=15 };
typedef NS_ENUM(NSInteger, UITableViewCellSeparatorStyle) { UITableViewCellSeparatorStyleNone };
typedef NSUInteger UIViewAutoresizing;
static const UIViewAutoresizing UIViewAutoresizingFlexibleWidth=1,UIViewAutoresizingFlexibleHeight=2;
static NSString *const UIFontTextStyleBody=@"body",*const UIFontTextStyleSubheadline=@"subheadline";
@interface UIFont : NSObject
@property(nonatomic) CGFloat pointSize;
+ (instancetype)preferredFontForTextStyle:(NSString *)style;
@end
@class UIGestureRecognizer,UITouch;
@class UIWindow;
static NSString *const UIApplicationWillResignActiveNotification=@"UIApplicationWillResignActiveNotification";
static NSString *const UIApplicationDidEnterBackgroundNotification=@"UIApplicationDidEnterBackgroundNotification";
static NSString *const UIApplicationWillEnterForegroundNotification=@"UIApplicationWillEnterForegroundNotification";
static NSString *const UIApplicationDidBecomeActiveNotification=@"UIApplicationDidBecomeActiveNotification";
static NSString *const UISceneWillDeactivateNotification=@"UISceneWillDeactivateNotification";
static NSString *const UISceneDidEnterBackgroundNotification=@"UISceneDidEnterBackgroundNotification";
static NSString *const UISceneWillEnterForegroundNotification=@"UISceneWillEnterForegroundNotification";
static NSString *const UISceneDidActivateNotification=@"UISceneDidActivateNotification";
@interface UITraitCollection : NSObject
@property(nonatomic) UIUserInterfaceStyle userInterfaceStyle;
@end
@interface UIColor : NSObject
@property(nonatomic) CGFloat red,green,blue,alpha;
+ (instancetype)clearColor;
+ (instancetype)whiteColor;
+ (instancetype)blackColor;
+ (instancetype)systemBackgroundColor;
+ (instancetype)labelColor;
+ (instancetype)secondaryLabelColor;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) CGFloat alpha;
@property(nonatomic) NSInteger tag;
@property(nonatomic) BOOL hidden,userInteractionEnabled,autoresizesSubviews;
@property(nonatomic) BOOL isAccessibilityElement;
@property(nonatomic) UIViewAutoresizing autoresizingMask;
@property(nonatomic,copy) NSString *accessibilityLabel;
@property(nonatomic,strong) id accessibilityElements;
@property(nonatomic,strong) CALayer *layer;
@property(nonatomic,strong) UIColor *backgroundColor;
@property(nonatomic,strong) UITraitCollection *traitCollection;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) id responder;
@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong) NSMutableArray<UIView *> *subviews;
@property(nonatomic) NSUInteger layoutInvalidations;
@property(nonatomic) NSUInteger displayInvalidations;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)removeFromSuperview;
- (void)bringSubviewToFront:(UIView *)view;
- (BOOL)isDescendantOfView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
- (id)nextResponder;
- (void)setNeedsLayout;
- (void)setNeedsDisplay;
- (void)layoutSubviews;
@end
@interface UIWindow : UIView
@property(nonatomic,strong) id windowScene;
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
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic,strong) UIView *backgroundView,*tableHeaderView,*tableFooterView;
@property(nonatomic,strong) UIColor *sectionIndexBackgroundColor,*sectionIndexTrackingBackgroundColor;
@property(nonatomic) BOOL showsVerticalScrollIndicator;
@property(nonatomic) BOOL footerLineVisible;
@property(nonatomic) UITableViewCellSeparatorStyle separatorStyle;
@property(nonatomic) CGFloat sectionHeaderHeight,sectionFooterHeight;
@property(nonatomic,copy) NSArray<NSNumber *> *rows;
@property(nonatomic) BOOL throwsOnQuery;
@property(nonatomic) NSUInteger queries,reloads,originalCalls,visibleCellReads;
@property(nonatomic,strong) id groupAdapter;
@property(nonatomic,copy) void (^onQuery)(void);
@property(nonatomic,readonly) NSInteger numberOfSections;
@property(nonatomic,readonly) NSArray<UITableViewCell *> *visibleCells;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;
- (void)reloadData;
- (void)drawFooterLine:(BOOL)draw;
- (CGFloat)originalHeight;
@end
@interface NSIndexPath (ListCornerUIKit)
@property(nonatomic,readonly) NSInteger section,row;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@interface UIViewController : NSObject @end
@interface UIImageView : UIView
@property(nonatomic,strong) id image;
@end
@interface UITableViewHeaderFooterView : UIView
@property(nonatomic,strong) UIView *contentView,*backgroundView;
@end
typedef NS_ENUM(NSInteger, NSTextAlignment) { NSTextAlignmentLeft, NSTextAlignmentCenter };
typedef NS_ENUM(NSInteger, NSLineBreakMode) { NSLineBreakByClipping=2, NSLineBreakByTruncatingTail=4 };
@interface UILabel : UIView
@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic) NSLineBreakMode lineBreakMode;
@property(nonatomic) BOOL adjustsFontSizeToFitWidth;
@property(nonatomic) CGFloat minimumScaleFactor;
- (CGSize)sizeThatFits:(CGSize)size;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UIColor *highlightedTextColor;
@end
@interface UIBezierPath : NSObject
@property(nonatomic,readonly) CGPathRef CGPath;
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius;
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii;
+ (instancetype)bezierPathWithRect:(CGRect)rect;
@end
