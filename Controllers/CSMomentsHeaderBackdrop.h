#import <UIKit/UIKit.h>

// UIKit inserts/reorders cells during layout. Keep the content background
// behind them in both subview order and Core Animation's z ordering.
@interface CSMomentsBackdropCollectionView : UICollectionView
@property(nonatomic,weak) UIView *contentBackground;
@end

// Main-thread only. Reapply after native header/image/layout updates. The
// original header, cover, foreground views and interaction stay in place.
// contentBackground lives in collection content coordinates, behind both the
// native header viewport and cards. headerTop is the native table's resting
// content origin, supplied by the adapter; it is independent of photo cropping.
FOUNDATION_EXPORT BOOL CSMomentsHeaderBackdropApply(UIView *nativeHeader,
    UIView *contentBackground, CGFloat headerTop, CGFloat firstCardTop);
// Stretch only the already sampled native cover when pulling beyond its top.
FOUNDATION_EXPORT void CSMomentsHeaderBackdropSetPullDistance(UIView *nativeHeader, CGFloat distance);
FOUNDATION_EXPORT void CSMomentsHeaderBackdropRemove(UIView *nativeHeader);
