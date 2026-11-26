#import <UIKit/UIKit.h>
@class CSTabBarPreferences;

/// A local appearance preview. Selecting a tab changes only the sample selection.
@interface CSTabBarPreviewView : UIView
- (void)updateWithPreferences:(CSTabBarPreferences *)preferences;
@end
