// HOOK 支持作者功能
// 通过Hook扫一扫视图控制器，实现自动扫描图片的功能
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static UIImage *gPreloadedImage = nil;
static UIView *gBlurOverlayViewRef = nil;

%ctor {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:@"com.wechat.tweak.auto_scan_image"
                       object:nil
                        queue:[NSOperationQueue mainQueue]
                   usingBlock:^(NSNotification * _Nonnull note) {
        gPreloadedImage = note.userInfo[@"image"];
        id blurOverlay = note.userInfo[@"blurOverlay"];
        if (blurOverlay && ![blurOverlay isKindOfClass:[NSNull class]]) {
            gBlurOverlayViewRef = (UIView *)blurOverlay;
        }
        NSLog(@"[SupportAuthor] Preloaded image received, size: %@", NSStringFromCGSize(gPreloadedImage.size));
    }];
}

@interface CameraScanViewController : NSObject
- (void)scanPickedImage:(UIImage *)image;
@end

%hook CameraScanViewController

- (void)viewDidLoad {
    %orig;
    
    if (gPreloadedImage) {
        UIImage *imageToScan = gPreloadedImage;
        gPreloadedImage = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[SupportAuthor] Auto scanning preloaded image immediately");
            [self scanPickedImage:imageToScan];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (gBlurOverlayViewRef) {
                    [UIView animateWithDuration:0.2 animations:^{
                        gBlurOverlayViewRef.alpha = 0;
                    } completion:^(BOOL finished) {
                        [gBlurOverlayViewRef removeFromSuperview];
                        gBlurOverlayViewRef = nil;
                    }];
                }
            });
        });
    }
}

%end


