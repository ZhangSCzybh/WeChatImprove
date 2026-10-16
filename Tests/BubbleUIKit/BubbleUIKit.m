#import <UIKit/UIKit.h>
#import "CSBubbleStyleAdapter.h"
NSString *const UIApplicationDidReceiveMemoryWarningNotification=@"BubbleMemoryWarning";
@implementation UITraitCollection
+ (UITraitCollection *)currentTraitCollection {
    static UITraitCollection *value;static dispatch_once_t once;
    dispatch_once(&once,^{value=[UITraitCollection new];});return value;
}
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) { _traitCollection=[UITraitCollection new]; _traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight; } return self; }
+ (void)performWithoutAnimation:(void (^)(void))block { block(); }
@end
@implementation UITableView @end
@implementation UIImage { CGImageRef _image; }
+ (instancetype)imageWithCGImage:(CGImageRef)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation {
    UIImage *value=[self new]; value->_image=CGImageRetain(image); value.scale=scale; value.imageOrientation=orientation; return value;
}
- (CGImageRef)CGImage { return _image; }
- (CGSize)size { return CGSizeMake(CGImageGetWidth(_image)/self.scale,CGImageGetHeight(_image)/self.scale); }
- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode { self.capInsets=insets; self.resizingMode=mode; return self; }
- (void)dealloc { if (_image) CGImageRelease(_image); }
@end
@implementation UIImageView @end
@implementation YYImage
+ (instancetype)imageWithUIImage:(UIImage *)image { YYImage *value=[self new]; value.originImage=image; return value; }
@end
@implementation YYAsyncImageView
- (void)setImage:(UIImage *)image { self.assignments++; m_image=CSBubbleStyleImageAssignment(self,image,NO); }
- (void)setHighlightedImage:(UIImage *)image { self.assignments++; m_highlightedImage=CSBubbleStyleImageAssignment(self,image,YES); }
@end
