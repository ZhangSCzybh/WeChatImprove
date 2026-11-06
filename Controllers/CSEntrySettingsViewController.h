#import "CSSettingsTableViewController.h"
#import <UIKit/UIKit.h>
#import "CSSettingTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

// 入口显示模式枚举（使用位掩码）
typedef NS_ENUM(NSInteger, CSEntryDisplayMode) {
    CSEntryDisplayModeNone = 0,           // 不显示
    CSEntryDisplayModeMore = 1 << 0,      // 我页面（MoreViewController）- 1
    CSEntryDisplayModePlugin = 1 << 1,    // 插件入口（MinimizeViewController）- 2
    CSEntryDisplayModeSetting = 1 << 2,   // 设置页面（NewSettingViewController）- 4
    // 组合模式
    CSEntryDisplayModeMorePlugin = CSEntryDisplayModeMore | CSEntryDisplayModePlugin,     // 我页面 + 插件入口 - 3
    CSEntryDisplayModeMoreSetting = CSEntryDisplayModeMore | CSEntryDisplayModeSetting,   // 我页面 + 设置页面 - 5
    CSEntryDisplayModePluginSetting = CSEntryDisplayModePlugin | CSEntryDisplayModeSetting, // 插件入口 + 设置页面 - 6
    CSEntryDisplayModeAll = CSEntryDisplayModeMore | CSEntryDisplayModePlugin | CSEntryDisplayModeSetting // 三处都显示 - 7
};

// 入口设置控制器 - 用于配置自定义入口的显示位置
@interface CSEntrySettingsViewController : CSSettingsTableViewController

@end

NS_ASSUME_NONNULL_END 