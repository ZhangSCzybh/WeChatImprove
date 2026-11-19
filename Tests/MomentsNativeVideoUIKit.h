#import <UIKit/UIKit.h>
// The shared host double omits UIKit's layout callback. Declare it only for
// these adapter boundary tests, without expanding other suites' UIKit surface.
@interface UIView (CSMomentsVideoTestLayout)
- (void)layoutSubviews;
@end
