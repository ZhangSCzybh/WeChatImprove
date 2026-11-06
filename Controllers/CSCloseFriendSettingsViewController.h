#import "CSSettingsTableViewController.h"
#import <UIKit/UIKit.h>
@interface CSCloseFriendSettingsViewController : CSSettingsTableViewController
/// In-memory access to this settings visit, separate from WeChat list reveal authority.
@property(nonatomic) BOOL quickEntry;
@property(nonatomic,copy) NSDictionary *quickEntryToken;
@end
