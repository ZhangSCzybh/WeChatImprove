#import <UIKit/UIKit.h>

@class CSMomentsCardModel;

NS_ASSUME_NONNULL_BEGIN

@interface CSMomentsCardCell : UICollectionViewCell
@property(nonatomic, strong, readonly, nullable) CSMomentsCardModel *model;
- (void)configureWithModel:(CSMomentsCardModel *)model;
/// Retains a fresh native sharing view in the responder tree; cover taps use
/// its original action only after the page revalidates the projected item.
- (void)configureSharedPresentationForOwner:(UIViewController *)owner shouldOpen:(BOOL (^)(void))shouldOpen;
- (void)endDisplaying;
+ (CGFloat)heightForModel:(CSMomentsCardModel *)model width:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
