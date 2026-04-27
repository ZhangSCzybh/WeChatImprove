//
// CSMessageGestureSettingsViewController.m
// 消息手势设置界面实现
//

#import "CSMessageGestureSettingsViewController.h"
#import "CSSettingTableViewCell.h"

static NSString * const kMessageGestureEnabledKey = @"com.wechat.enhance.message_gesture.enabled";
static NSString * const kLeftSwipeOtherActionKey = @"com.wechat.enhance.left_swipe_other.action";
static NSString * const kLeftSwipeSelfActionKey = @"com.wechat.enhance.left_swipe_self.action";
static NSString * const kRightSwipeOtherActionKey = @"com.wechat.enhance.right_swipe_other.action";
static NSString * const kRightSwipeSelfActionKey = @"com.wechat.enhance.right_swipe_self.action";

typedef NS_ENUM(NSInteger, WCSwipeAction) {
    WCSwipeActionDisabled = 0,
    WCSwipeActionQuote = 1,
    WCSwipeActionDelete = 2,
    WCSwipeActionForward = 3,
    WCSwipeActionFavorite = 4,
    WCSwipeActionRevoke = 5,
    WCSwipeActionRepeat = 6
};

static NSString *actionToString(WCSwipeAction action) {
    switch (action) {
        case WCSwipeActionDisabled:
            return @"禁用";
        case WCSwipeActionQuote:
            return @"引用";
        case WCSwipeActionDelete:
            return @"删除";
        case WCSwipeActionForward:
            return @"转发";
        case WCSwipeActionFavorite:
            return @"收藏";
        case WCSwipeActionRevoke:
            return @"撤回";
        case WCSwipeActionRepeat:
            return @"复读";
        default:
            return @"禁用";
    }
}

static WCSwipeAction getActionForKey(NSString *key) {
    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    return (WCSwipeAction)value;
}

static void setActionForKey(WCSwipeAction action, NSString *key) {
    [[NSUserDefaults standardUserDefaults] setInteger:action forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    CFNotificationCenterPostNotification(
        CFNotificationCenterGetDarwinNotifyCenter(),
        CFSTR("com.wechat.enhance.message_gesture.settings_changed"),
        NULL,
        NULL,
        true
    );
}

@interface CSMessageGestureSettingsViewController ()

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;

@end

@implementation CSMessageGestureSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息手势";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self setupData];
}

- (void)setupData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    CSSettingItem *gestureEnabledItem = [CSSettingItem switchItemWithTitle:@"消息手势"
                                                                iconName:@"hand.draw.fill"
                                                               iconColor:[UIColor systemBlueColor]
                                                             switchValue:[defaults boolForKey:kMessageGestureEnabledKey]
                                                       valueChangedBlock:^(BOOL isOn) {
        [defaults setBool:isOn forKey:kMessageGestureEnabledKey];
        [defaults synchronize];
        
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFSTR("com.wechat.enhance.message_gesture.settings_changed"),
            NULL,
            NULL,
            true
        );
    }];
    
    __weak typeof(self) weakSelf = self;
    
    WCSwipeAction leftSwipeOtherAction = getActionForKey(kLeftSwipeOtherActionKey);
    CSSettingItem *leftSwipeOtherItem = [CSSettingItem itemWithTitle:@"左滑对方消息"
                                                           iconName:@"arrow.left"
                                                          iconColor:[UIColor systemOrangeColor]
                                                            detail:actionToString(leftSwipeOtherAction)];
    leftSwipeOtherItem.actionBlock = ^{
        [weakSelf showActionPickerForTitle:@"左滑对方消息" currentAction:leftSwipeOtherAction key:kLeftSwipeOtherActionKey];
    };
    
    WCSwipeAction leftSwipeSelfAction = getActionForKey(kLeftSwipeSelfActionKey);
    CSSettingItem *leftSwipeSelfItem = [CSSettingItem itemWithTitle:@"左滑己方消息"
                                                          iconName:@"arrow.left"
                                                         iconColor:[UIColor systemPurpleColor]
                                                           detail:actionToString(leftSwipeSelfAction)];
    leftSwipeSelfItem.actionBlock = ^{
        [weakSelf showActionPickerForTitle:@"左滑己方消息" currentAction:leftSwipeSelfAction key:kLeftSwipeSelfActionKey];
    };
    
    WCSwipeAction rightSwipeOtherAction = getActionForKey(kRightSwipeOtherActionKey);
    CSSettingItem *rightSwipeOtherItem = [CSSettingItem itemWithTitle:@"右滑对方消息"
                                                            iconName:@"arrow.right"
                                                           iconColor:[UIColor systemCyanColor]
                                                             detail:actionToString(rightSwipeOtherAction)];
    rightSwipeOtherItem.actionBlock = ^{
        [weakSelf showActionPickerForTitle:@"右滑对方消息" currentAction:rightSwipeOtherAction key:kRightSwipeOtherActionKey];
    };
    
    WCSwipeAction rightSwipeSelfAction = getActionForKey(kRightSwipeSelfActionKey);
    CSSettingItem *rightSwipeSelfItem = [CSSettingItem itemWithTitle:@"右滑己方消息"
                                                           iconName:@"arrow.right"
                                                          iconColor:[UIColor systemPinkColor]
                                                            detail:actionToString(rightSwipeSelfAction)];
    rightSwipeSelfItem.actionBlock = ^{
        [weakSelf showActionPickerForTitle:@"右滑己方消息" currentAction:rightSwipeSelfAction key:kRightSwipeSelfActionKey];
    };
    
    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"功能设置"
                                                                 items:@[gestureEnabledItem]];
    
    CSSettingSection *leftSwipeSection = [CSSettingSection sectionWithHeader:@"左滑操作"
                                                                       items:@[leftSwipeOtherItem, leftSwipeSelfItem]];
    
    CSSettingSection *rightSwipeSection = [CSSettingSection sectionWithHeader:@"右滑操作"
                                                                        items:@[rightSwipeOtherItem, rightSwipeSelfItem]];
    
    CSSettingItem *descItem = [CSSettingItem itemWithTitle:@"使用说明"
                                                 iconName:@"info.circle.fill"
                                                iconColor:[UIColor systemGrayColor]
                                                  detail:@"左滑或右滑消息气泡可执行相应操作"];
    
    CSSettingSection *descSection = [CSSettingSection sectionWithHeader:@"说明"
                                                                 items:@[descItem]];
    
    self.sections = @[mainSection, leftSwipeSection, rightSwipeSection, descSection];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell configureWithItem:item];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    if (item.actionBlock) {
        item.actionBlock();
    }
}

#pragma mark - Action Picker

- (void)showActionPickerForTitle:(NSString *)title currentAction:(WCSwipeAction)currentAction key:(NSString *)key {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:@"请选择操作类型"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableArray *actions = [NSMutableArray arrayWithArray:@[
        @{@"title": @"禁用", @"action": @(WCSwipeActionDisabled)},
        @{@"title": @"引用", @"action": @(WCSwipeActionQuote)},
        @{@"title": @"删除", @"action": @(WCSwipeActionDelete)},
        @{@"title": @"转发", @"action": @(WCSwipeActionForward)},
        @{@"title": @"收藏", @"action": @(WCSwipeActionFavorite)},
        @{@"title": @"复读", @"action": @(WCSwipeActionRepeat)}
    ]];
    
    // 如果是己方消息，添加撤回选项
    if ([key containsString:@"self"]) {
        [actions addObject:@{@"title": @"撤回", @"action": @(WCSwipeActionRevoke)}];
    }
    
    for (NSDictionary *actionDict in actions) {
        NSString *actionTitle = actionDict[@"title"];
        WCSwipeAction action = [actionDict[@"action"] integerValue];
        
        UIAlertAction *actionItem = [UIAlertAction actionWithTitle:actionTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull alertAction) {
            setActionForKey(action, key);
            [self setupData];
            [self.tableView reloadData];
        }];
        
        if (action == currentAction) {
            [actionItem setValue:@YES forKey:@"checked"];
        }
        
        [alert addAction:actionItem];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
