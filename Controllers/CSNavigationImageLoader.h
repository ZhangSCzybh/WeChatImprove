#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CSNavigationImageRequest : NSObject
- (void)cancel;
@end

// Bounded memory-only images. File reads, metadata checks and thumbnail decoding run off the main thread.
@interface CSNavigationImageLoader : NSObject
+ (instancetype)sharedLoader;
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;
// Retain the returned request while interested; releasing/cancelling it removes this subscriber only.
// Completion is asynchronous on main. A missing local file may use fallbackFileURL.
- (CSNavigationImageRequest *)loadURL:(nullable NSURL *)url
                     fallbackFileURL:(nullable NSURL *)fallbackFileURL
                               scope:(NSString *)scope
                        maxPixelSize:(NSUInteger)maxPixelSize
                          completion:(void (^)(UIImage * _Nullable image, NSURL * _Nullable resolvedURL))completion;
@end

// Owns one image-view subscription. The caller revalidates its account, model and visible target.
@interface CSNavigationImageBinding : NSObject
- (void)displayURL:(nullable NSURL *)url scope:(NSString *)scope identity:(NSArray *)identity
     maxPixelSize:(NSUInteger)maxPixelSize inImageView:(UIImageView *)imageView
        ifCurrent:(BOOL (^)(void))ifCurrent;
- (void)cancel;
@end
NS_ASSUME_NONNULL_END
