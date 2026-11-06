#import "CSSettingsTableViewController.h"
#import <UIKit/UIKit.h>
#import "CSSettingTableViewCell.h"

#define kUserDefaultsSuiteName @"com.cyansmoke.wechattweak"

@interface CSBackupSettingsViewController : CSSettingsTableViewController

@property (nonatomic, strong) NSMutableArray<CSSettingSection *> *sections;

@end
