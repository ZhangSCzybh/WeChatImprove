#import <UIKit/UIKit.h>

@class CSListCornerSnapshot;

// A read-only sample: no host cells, accounts or conversation data are accessed.
@interface CSListCornerPreviewView : UIView
- (void)configureWithSnapshot:(CSListCornerSnapshot *)snapshot;
// Color-picker changes are illustrative only until its existing save callback runs.
- (void)previewColor:(UIColor *)color component:(NSInteger)component style:(UIUserInterfaceStyle)style;
@end
