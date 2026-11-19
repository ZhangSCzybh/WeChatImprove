#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Two equal columns; each new card goes into the shorter column.
@interface CSMomentsMasonryLayout : UICollectionViewLayout
@property(nonatomic, copy, nullable) CGFloat (^heightForItem)(NSIndexPath *indexPath, CGFloat width);
@property(nonatomic) CGFloat headerHeight;
@property(nonatomic) CGFloat footerHeight;
@property(nonatomic, readonly) CGFloat cardWidth;
@property(nonatomic, readonly) CGFloat firstCardTop;
@end

NS_ASSUME_NONNULL_END
