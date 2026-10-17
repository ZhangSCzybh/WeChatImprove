#import "CSBackgroundBlurManager.h"

%ctor {
    @autoreleasepool {
        if (NSThread.isMainThread) {
            [[CSBackgroundBlurManager sharedManager] start];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[CSBackgroundBlurManager sharedManager] start];
            });
        }
    }
}
