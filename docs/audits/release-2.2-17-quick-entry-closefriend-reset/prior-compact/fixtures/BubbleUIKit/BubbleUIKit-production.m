#import <UIKit/UIKit.h>
#import "CSBubbleStyleAdapter.h"
NSString *const UIApplicationDidReceiveMemoryWarningNotification=@"BubbleMemoryWarning";
NSString *const NSForegroundColorAttributeName=@"NSColor";
NSString *const NSLinkAttributeName=@"NSLink";
NSString *const NSAttachmentAttributeName=@"NSAttachment";
@implementation UIColor
+ (instancetype)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    UIColor *color=[self new];color.red=r;color.green=g;color.blue=b;color.alpha=a;return color;
}
- (BOOL)isEqual:(id)other {
    return [other isKindOfClass:UIColor.class] && self.red==[other red] && self.green==[other green] && self.blue==[other blue] && self.alpha==[other alpha];
}
- (NSUInteger)hash { return (NSUInteger)(self.red*255)^((NSUInteger)(self.green*255)<<8)^((NSUInteger)(self.blue*255)<<16); }
@end
@implementation UITraitCollection
+ (UITraitCollection *)currentTraitCollection {
    static UITraitCollection *value;static dispatch_once_t once;
    dispatch_once(&once,^{value=[UITraitCollection new];});return value;
}
@end
#ifndef CS_MERGE_BUBBLE_INTEGRATION
@implementation UIView { NSMutableArray *_children; }
- (instancetype)init { if ((self=[super init])) { _traitCollection=[UITraitCollection new]; _traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight; } return self; }
+ (void)performWithoutAnimation:(void (^)(void))block { block(); }
- (NSArray *)subviews { return _children?:@[]; }
- (void)addSubview:(UIView *)view { if (!_children) _children=[NSMutableArray array];[_children addObject:view];view.superview=self; }
- (void)setNeedsDisplay { self.displayRequests++; }
- (BOOL)isDescendantOfView:(UIView *)view { for (UIView *node=self;node;node=node.superview) if (node==view) return YES;return NO; }
@end
#endif
@implementation UILabel
- (void)setTextColor:(UIColor *)color {
    _textColor=color;self.colorAssignments++;
    if (_attributedText.length && color) {
        NSMutableAttributedString *text=[_attributedText mutableCopy];
        [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,text.length)];_attributedText=text;
    }
}
- (void)setAttributedText:(NSAttributedString *)text { _attributedText=[text copy];self.textAssignments++; }
@end
#ifndef CS_MERGE_BUBBLE_INTEGRATION
@implementation UITableView @end
#endif
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
BOOL CSBubbleTestDeferredFactory;
@implementation YYImage
@synthesize originImage=m_originImage;
// Isolated ready-image fixtures represent an earlier completed observation.
// Deferred fixtures below bypass these setters: the real display observer must
// publish their results, including worker/cancellation/reuse/theme validation.
- (void)setOriginImage:(UIImage *)image {
    m_originImage=image;
    
}
- (void)setDecodeImageLM:(UIImage *)image { _decodeImageLM=image; }
- (void)setDecodeImageDM:(UIImage *)image { _decodeImageDM=image; }
+ (instancetype)imageWithUIImage:(UIImage *)image {
    if (CSBubbleTestDeferredFactory) return [self deferredImageWithUIImage:image];
    YYImage *value=[self new]; value.originImage=image; return value;
}
+ (instancetype)deferredImageWithUIImage:(UIImage *)image { YYImage *value=[self new]; value.pendingImage=image; return value; }
- (UIImage *)decodeImage {
    if (!_decodeImageLM) _decodeImageLM=m_originImage?:_pendingImage;
    UIImage *decoded=_decodeImageLM;
    CSBubbleStyleObserveDecodedImage(self,decoded); // Mirrors the native return-value hook.
    return decoded;
}
@end
@implementation YYAsyncLayerDisplayTask @end
@implementation YYAsyncImageView
- (void)setImage:(UIImage *)image { self.assignments++; m_image=CSBubbleStyleImageAssignment(self,image,NO); }
- (void)setHighlightedImage:(UIImage *)image { self.assignments++; m_highlightedImage=CSBubbleStyleImageAssignment(self,image,YES); }
- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    YYAsyncLayerDisplayTask *task=[YYAsyncLayerDisplayTask new];
    __weak YYImage *normal=m_image,*pressed=m_highlightedImage;
    BOOL highlighted=self.highlighted;
    // Match 8.0.78's block ABI and active-state-only native decoding. No setter,
    // dynamic-image notification, or extra layout is emitted on completion.
    task.displayContentsForLayer=^UIImage *(CGSize size, BOOL (^cancelled)(void)) {
        return (highlighted ? [pressed decodeImage] : nil) ?: [normal decodeImage];
    };
    CSBubbleStyleObserveDisplayTask(self,task);return task;
}
@end
