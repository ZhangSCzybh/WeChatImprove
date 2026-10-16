// Host-only test doubles: exercise adapter ownership/dispatch; no UIKit rendering claims.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreFoundation/CoreFoundation.h>
#import <dispatch/dispatch.h>
typedef struct { CGFloat top,left,bottom,right; } UIEdgeInsets;
static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat t,CGFloat l,CGFloat b,CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
typedef NS_ENUM(NSInteger, UIImageOrientation) { UIImageOrientationUp, UIImageOrientationDown };
typedef NS_ENUM(NSInteger, UIImageResizingMode) { UIImageResizingModeTile, UIImageResizingModeStretch };
typedef NS_ENUM(NSInteger, UIUserInterfaceStyle) { UIUserInterfaceStyleUnspecified, UIUserInterfaceStyleLight, UIUserInterfaceStyleDark };
@interface UITraitCollection : NSObject
@property(class,nonatomic,readonly) UITraitCollection *currentTraitCollection;
@property(nonatomic) UIUserInterfaceStyle userInterfaceStyle;
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame;
@property(nonatomic, strong) UITraitCollection *traitCollection;
@property(nonatomic, weak) UIView *window;
+ (void)performWithoutAnimation:(void (^)(void))block;
@end
@interface UITableView : UIView @end
@interface UIImage : NSObject
@property(nonatomic, readonly) CGImageRef CGImage;
@property(nonatomic) CGFloat scale;
@property(nonatomic) UIImageOrientation imageOrientation;
@property(nonatomic) UIImageResizingMode resizingMode;
@property(nonatomic) UIEdgeInsets capInsets;
@property(nonatomic, strong) NSArray *images;
@property(nonatomic, readonly) CGSize size;
+ (instancetype)imageWithCGImage:(CGImageRef)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode;
@end
@interface UIImageView : UIView
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *highlightedImage;
@end
@interface YYImage : UIImage
@property(nonatomic, strong) UIImage *originImage;
+ (instancetype)imageWithUIImage:(UIImage *)image;
@end
@interface YYAsyncImageView : UIImageView {
@public id m_image; id m_highlightedImage;
}
@property(nonatomic) NSUInteger assignments;
@end
extern NSString *const UIApplicationDidReceiveMemoryWarningNotification;
