#import "../../MessageUIKit/UIKit/UIKit.h"
// Host-only test doubles: exercise adapter ownership/dispatch; no UIKit rendering claims.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreFoundation/CoreFoundation.h>
#import <dispatch/dispatch.h>
static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat t,CGFloat l,CGFloat b,CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
typedef NS_ENUM(NSInteger, UIImageOrientation) { UIImageOrientationUp, UIImageOrientationDown };
typedef NS_ENUM(NSInteger, UIImageResizingMode) { UIImageResizingModeTile, UIImageResizingModeStretch };
typedef NS_ENUM(NSInteger, UIUserInterfaceStyle) { UIUserInterfaceStyleUnspecified, UIUserInterfaceStyleLight, UIUserInterfaceStyleDark };
typedef NS_ENUM(NSInteger, UIViewContentMode) { UIViewContentModeScaleToFill, UIViewContentModeScaleAspectFit };
extern NSString *const NSForegroundColorAttributeName;
extern NSString *const NSLinkAttributeName;
extern NSString *const NSAttachmentAttributeName;
@interface UIColor : NSObject
@property(nonatomic) CGFloat red,green,blue,alpha;
+ (instancetype)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;
@end
@interface UITraitCollection : NSObject
@property(class,nonatomic,readonly) UITraitCollection *currentTraitCollection;
@property(nonatomic) UIUserInterfaceStyle userInterfaceStyle;
@end
@interface UIView ()
@property(nonatomic) UIViewContentMode contentMode;
@property(nonatomic, strong) UITraitCollection *traitCollection;
@property(nonatomic) NSUInteger displayRequests;
@end
@interface UIView (BubbleIntegration)
- (void)addSubview:(UIView *)view;
- (void)setNeedsDisplay;
- (BOOL)isDescendantOfView:(UIView *)view;
@end
@interface UILabel : UIView
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, copy) NSAttributedString *attributedText;
@property(nonatomic) NSUInteger colorAssignments, textAssignments;
@end
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
@interface YYImage : UIImage {
@public UIImage *m_originImage;
}
@property(nonatomic, strong) UIImage *originImage;
@property(nonatomic, strong) UIImage *decodeImageLM, *decodeImageDM;
@property(nonatomic, strong) UIImage *pendingImage;
+ (instancetype)imageWithUIImage:(UIImage *)image;
+ (instancetype)deferredImageWithUIImage:(UIImage *)image;
- (UIImage *)decodeImage;
@end
extern BOOL CSBubbleTestDeferredFactory;
@interface YYAsyncLayerDisplayTask : NSObject
@property(nonatomic, copy) UIImage *(^displayContentsForLayer)(CGSize, BOOL (^)(void));
@end
@interface YYAsyncImageView : UIImageView {
@public id m_image; id m_highlightedImage;
}
@property(nonatomic) NSUInteger assignments;
@property(nonatomic) BOOL highlighted;
- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end
extern NSString *const UIApplicationDidReceiveMemoryWarningNotification;
