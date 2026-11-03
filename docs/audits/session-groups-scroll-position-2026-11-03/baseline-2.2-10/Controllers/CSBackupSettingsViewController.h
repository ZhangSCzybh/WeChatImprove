#import <UIKit/UIKit.h>
#import "CSSettingTableViewCell.h"

#define kUserDefaultsSuiteName @"com.cyansmoke.wechattweak"

@interface CSBackupSettingsViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<CSSettingSection *> *sections;

@end
