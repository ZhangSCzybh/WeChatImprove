// Records drawing choices, not UIKit pixels. Used with extracted, unmodified hook bodies.
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#include <stdatomic.h>
#include <math.h>
static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat t,CGFloat l,CGFloat b,CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
typedef NS_OPTIONS(NSUInteger, UIRectCorner) { UIRectCornerTopLeft=1,UIRectCornerTopRight=2,UIRectCornerBottomLeft=4,UIRectCornerBottomRight=8,UIRectCornerAllCorners=15 };
typedef NS_ENUM(NSInteger, UIImageResizingMode) { UIImageResizingModeStretch };
@interface UIColor : NSObject
@property(nonatomic) CGFloat red,green,blue,alpha;
+ (instancetype)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;
- (void)setFill;
@end
@interface UIImage : NSObject
@property(nonatomic) CGSize size;
@property(nonatomic) CGFloat scale;
@property(nonatomic,strong) UIColor *fill;
@property(nonatomic) NSUInteger corners;
@property(nonatomic) CGFloat radius;
@property(nonatomic) UIEdgeInsets capInsets;
@property(nonatomic,readonly) CGImageRef CGImage;
- (id)resizableImageWithCapInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode;
@end
@interface UIBezierPath : NSObject
@property(nonatomic) NSUInteger corners;
@property(nonatomic) CGFloat radius;
+ (id)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)radii;
+ (id)bezierPathWithRect:(CGRect)rect;
- (void)fill;
@end
void UIGraphicsBeginImageContextWithOptions(CGSize size,BOOL opaque,CGFloat scale);
CGContextRef UIGraphicsGetCurrentContext(void);
UIImage *UIGraphicsGetImageFromCurrentImageContext(void);
void UIGraphicsEndImageContext(void);
@class WCPayInfoItem;
@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType,m_uiCreateTime;
@property(nonatomic,copy) NSString *m_nsContent;
@property(nonatomic,strong) WCPayInfoItem *m_oWCPayInfoItem;
@end
@interface CSFeatureContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName;
@end
@interface CommonMessageViewModel : NSObject
@property(nonatomic,strong) CMessageWrap *messageWrap;
@property(nonatomic,strong) CSFeatureContact *chatContact;
@property(nonatomic) BOOL isSender;
@end
