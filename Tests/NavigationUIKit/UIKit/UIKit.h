#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dispatch/dispatch.h>
typedef NS_ENUM(NSInteger, UIImageOrientation) { UIImageOrientationUp };
@interface UIImage : NSObject
@property(nonatomic,readonly) CGImageRef CGImage;
+ (instancetype)imageWithCGImage:(CGImageRef)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
+ (instancetype)imageNamed:(NSString *)name;
@end
@interface UIImageView : NSObject
@property(nonatomic,strong) UIImage *image;
@end
@interface UIScreen : NSObject
@property(class,nonatomic,readonly) UIScreen *mainScreen;
@property(nonatomic,readonly) CGFloat scale;
@end
extern NSString *const UIApplicationDidReceiveMemoryWarningNotification;
