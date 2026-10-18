#import "../../TabBarUIKit/UIKit/UIKit.h"
@compatibility_alias UIResponder NSObject;
@interface NSObject (StyleResponder)
- (id)nextResponder;
@end
@interface UIView (StyleTest)
@property(nonatomic) NSInteger tag;
@property(nonatomic, weak) id testOwner;
- (void)layoutSubviews;
- (void)didMoveToWindow;
- (void)didMoveToSuperview;
- (void)traitCollectionDidChange:(UITraitCollection *)previous;
@end
@interface UIViewController (StyleTest)
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
@end
@interface UIColor (StyleTest) <NSSecureCoding>
+ (instancetype)systemGrayColor;
+ (instancetype)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (instancetype)colorWithCGColor:(CGColorRef)color;
- (instancetype)colorWithAlphaComponent:(CGFloat)alpha;
@end
@interface UIFont (StyleTest)
+ (instancetype)systemFontOfSize:(CGFloat)size;
+ (instancetype)boldSystemFontOfSize:(CGFloat)size;
@end
@interface UITraitCollection (StyleTest)
- (BOOL)hasDifferentColorAppearanceComparedToTraitCollection:(UITraitCollection *)other;
@end
typedef NS_ENUM(NSInteger, NSTextAlignment) { NSTextAlignmentLeft };
@interface NSMutableParagraphStyle : NSObject <NSCopying>
@property(nonatomic) NSTextAlignment alignment;
@end
extern NSString *const NSFontAttributeName;
extern NSString *const NSForegroundColorAttributeName;
extern NSString *const NSParagraphStyleAttributeName;
extern NSUInteger CSStyleTestFonts;
extern NSUInteger CSStyleTestColorResolutions;
