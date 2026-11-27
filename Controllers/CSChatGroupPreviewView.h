#import <UIKit/UIKit.h>
#import "WESessionTabItem.h"

// Uses the production tab renderer with local sample selection and fixed content.
@interface CSChatGroupPreviewView : UIView
- (void)configureWithTabs:(NSArray<WESessionTabItem *> *)tabs;
@end
