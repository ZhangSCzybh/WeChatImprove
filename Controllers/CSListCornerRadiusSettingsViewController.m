#import "CSListCornerRadiusSettingsViewController.h"
#import <UIKit/UIKit.h>
#import "CSSettingTableViewCell.h"

#import "CSListCornerConfiguration.h"

@interface ListColorPreviewView : UIView
@property (nonatomic, strong) UIColor *previewColor;
@end

@implementation ListColorPreviewView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.previewColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setPreviewColor:(UIColor *)previewColor {
    _previewColor = previewColor;
    self.backgroundColor = previewColor;
}

@end

@interface CSListCornerRadiusSettingsViewController () <UIColorPickerViewControllerDelegate>

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, strong) CSSettingItem *cornerRadiusItem;
@property (nonatomic, strong) CSSettingItem *leftMarginItem;
@property (nonatomic, strong) CSSettingItem *rightMarginItem;
@property (nonatomic, strong) CSSettingItem *topSessionTopMarginItem;
@property (nonatomic, strong) CSSettingItem *normalSessionTopMarginItem;
@property (nonatomic, strong) CSSettingItem *topSessionTopMarginBgColorItem;
@property (nonatomic, strong) CSSettingItem *normalSessionTopMarginBgColorItem;
@property (nonatomic, strong) CSSettingItem *lightModeBgColorItem;
@property (nonatomic, strong) CSSettingItem *darkModeBgColorItem;

@property (nonatomic, strong) ListColorPreviewView *lightModeBgColorPreview;
@property (nonatomic, strong) ListColorPreviewView *darkModeBgColorPreview;
@property (nonatomic, strong) ListColorPreviewView *topSessionTopMarginBgColorPreview;
@property (nonatomic, strong) ListColorPreviewView *normalSessionTopMarginBgColorPreview;

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, assign) CGFloat topSessionTopMargin;
@property (nonatomic, assign) CGFloat normalSessionTopMargin;
@property (nonatomic, strong) UIColor *lightModeBgColor;
@property (nonatomic, strong) UIColor *darkModeBgColor;
@property (nonatomic, strong) UIColor *topSessionTopMarginBgColor;
@property (nonatomic, strong) UIColor *normalSessionTopMarginBgColor;

@property (nonatomic, assign) NSInteger currentColorType;

@end

@implementation CSListCornerRadiusSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"列表圆角";
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);

    [CSSettingTableViewCell registerToTableView:self.tableView];

    self.lightModeBgColorPreview = [[ListColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.darkModeBgColorPreview = [[ListColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.topSessionTopMarginBgColorPreview = [[ListColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    self.normalSessionTopMarginBgColorPreview = [[ListColorPreviewView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];

    [self loadCurrentSettings];
    [self setupData];
}

- (void)loadCurrentSettings {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    self.cornerRadius=configuration.radius;
    self.leftMargin=configuration.leftMargin;
    self.rightMargin=configuration.rightMargin;
    self.topSessionTopMargin=configuration.pinnedGap;
    self.normalSessionTopMargin=configuration.normalGap;
    self.lightModeBgColor=[configuration backgroundForStyle:UIUserInterfaceStyleLight];
    self.darkModeBgColor=[configuration backgroundForStyle:UIUserInterfaceStyleDark];
    UIUserInterfaceStyle style=self.traitCollection.userInterfaceStyle;
    self.topSessionTopMarginBgColor=[configuration pinnedColorForStyle:style];
    self.normalSessionTopMarginBgColor=[configuration normalColorForStyle:style];
    self.lightModeBgColorPreview.previewColor = self.lightModeBgColor;
    self.darkModeBgColorPreview.previewColor = self.darkModeBgColor;
    self.topSessionTopMarginBgColorPreview.previewColor = self.topSessionTopMarginBgColor;
    self.normalSessionTopMarginBgColorPreview.previewColor = self.normalSessionTopMarginBgColor;
}

- (void)saveColor:(UIColor *)color
          redKey:(NSString *)redKey
        greenKey:(NSString *)greenKey
         blueKey:(NSString *)blueKey
        alphaKey:(NSString *)alphaKey {
    [[CSListCornerConfiguration sharedConfiguration] saveColor:color redKey:redKey greenKey:greenKey blueKey:blueKey alphaKey:alphaKey];
}

- (void)showRestartAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"列表圆角设置已保存，需要重启微信才能生效。"
                                                                    preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"稍后重启"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
    [alertController addAction:laterAction];

    UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"立即重启"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
    }];
    [alertController addAction:restartAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setupData {
    __weak typeof(self) weakSelf = self;

    CSSettingItem *listEnabledItem = [CSSettingItem switchItemWithTitle:@"启用列表圆角"
                                                              iconName:@"rectangle.on.rectangle"
                                                             iconColor:[UIColor systemIndigoColor]
                                                           switchValue:[[CSListCornerConfiguration sharedConfiguration] snapshot].enabled
                                                     valueChangedBlock:^(BOOL isOn) {
        [[CSListCornerConfiguration sharedConfiguration] saveEnabled:isOn];


        [weakSelf showRestartAlert];
    }];

    NSString *radiusDetail = [NSString stringWithFormat:@"%.0f", self.cornerRadius];
    self.cornerRadiusItem = [CSSettingItem itemWithTitle:@"圆角半径大小"
                                               iconName:@"slider.horizontal.3"
                                              iconColor:[UIColor systemOrangeColor]
                                                detail:radiusDetail];

    self.cornerRadiusItem.actionBlock = ^{
        [weakSelf showCornerRadiusPicker];
    };

    NSString *leftMarginDetail = [NSString stringWithFormat:@"%.0f", self.leftMargin];
    self.leftMarginItem = [CSSettingItem itemWithTitle:@"距离左侧边距"
                                             iconName:@"arrow.left.to.line"
                                            iconColor:[UIColor systemBlueColor]
                                              detail:leftMarginDetail];
    self.leftMarginItem.actionBlock = ^{
        [weakSelf showLeftMarginPicker];
    };

    NSString *rightMarginDetail = [NSString stringWithFormat:@"%.0f", self.rightMargin];
    self.rightMarginItem = [CSSettingItem itemWithTitle:@"距离右侧边距"
                                              iconName:@"arrow.right.to.line"
                                             iconColor:[UIColor systemBlueColor]
                                               detail:rightMarginDetail];
    self.rightMarginItem.actionBlock = ^{
        [weakSelf showRightMarginPicker];
    };

    NSString *topSessionTopMarginDetail = [NSString stringWithFormat:@"%.0f", self.topSessionTopMargin];
    self.topSessionTopMarginItem = [CSSettingItem itemWithTitle:@"置顶会话距离"
                                                      iconName:@"arrow.up.to.line"
                                                     iconColor:[UIColor systemPurpleColor]
                                                       detail:topSessionTopMarginDetail];
    self.topSessionTopMarginItem.actionBlock = ^{
        [weakSelf showTopSessionTopMarginPicker];
    };

    NSString *normalSessionTopMarginDetail = [NSString stringWithFormat:@"%.0f", self.normalSessionTopMargin];
    self.normalSessionTopMarginItem = [CSSettingItem itemWithTitle:@"普通会话距离"
                                                         iconName:@"arrow.up.to.line.compact"
                                                        iconColor:[UIColor systemTealColor]
                                                          detail:normalSessionTopMarginDetail];
    self.normalSessionTopMarginItem.actionBlock = ^{
        [weakSelf showNormalSessionTopMarginPicker];
    };

    self.topSessionTopMarginBgColorItem = [CSSettingItem itemWithTitle:@"置顶会话颜色"
                                                             iconName:@"paintbrush.fill"
                                                            iconColor:[UIColor systemPinkColor]
                                                              detail:@""];
    self.topSessionTopMarginBgColorItem.actionBlock = ^{
        weakSelf.currentColorType = 2;
        [weakSelf showColorPickerWithTitle:@"置顶会话顶部距离背景色" currentColor:weakSelf.topSessionTopMarginBgColor];
    };

    self.normalSessionTopMarginBgColorItem = [CSSettingItem itemWithTitle:@"普通会话颜色"
                                                               iconName:@"paintbrush.fill"
                                                              iconColor:[UIColor systemCyanColor]
                                                                detail:@""];
    self.normalSessionTopMarginBgColorItem.actionBlock = ^{
        weakSelf.currentColorType = 3;
        [weakSelf showColorPickerWithTitle:@"普通会话顶部距离背景色" currentColor:weakSelf.normalSessionTopMarginBgColor];
    };

    self.lightModeBgColorItem = [CSSettingItem itemWithTitle:@"浅色模式背景"
                                                   iconName:@"paintbrush.fill"
                                                  iconColor:[UIColor systemGrayColor]
                                                    detail:@""];
    self.lightModeBgColorItem.actionBlock = ^{
        weakSelf.currentColorType = 0;
        [weakSelf showColorPickerWithTitle:@"浅色模式 - 背景色" currentColor:weakSelf.lightModeBgColor];
    };

    self.darkModeBgColorItem = [CSSettingItem itemWithTitle:@"深色模式背景"
                                                  iconName:@"paintbrush.fill"
                                                 iconColor:[UIColor systemGrayColor]
                                                   detail:@""];
    self.darkModeBgColorItem.actionBlock = ^{
        weakSelf.currentColorType = 1;
        [weakSelf showColorPickerWithTitle:@"深色模式 - 背景色" currentColor:weakSelf.darkModeBgColor];
    };

    CSSettingItem *resetItem = [CSSettingItem itemWithTitle:@"重置默认设置"
                                                  iconName:@"arrow.counterclockwise"
                                                 iconColor:[UIColor systemRedColor]
                                                   detail:@""];
    resetItem.actionBlock = ^{
        [weakSelf resetToDefaultSettings];
    };

    CSSettingSection *mainSection = [CSSettingSection sectionWithHeader:@"功能设置"
                                                                 items:@[listEnabledItem,
                                                                         self.cornerRadiusItem,
                                                                         self.leftMarginItem,
                                                                         self.rightMarginItem,
                                                                         self.topSessionTopMarginItem,
                                                                         self.topSessionTopMarginBgColorItem,
                                                                         self.normalSessionTopMarginItem,
                                                                         self.normalSessionTopMarginBgColorItem]];

    CSSettingSection *bgColorSection = [CSSettingSection sectionWithHeader:@"背景色设置"
                                                                     items:@[self.lightModeBgColorItem, self.darkModeBgColorItem]];

    CSSettingSection *resetSection = [CSSettingSection sectionWithHeader:@"重置设置"
                                                                  items:@[resetItem]];

    self.sections = @[mainSection, bgColorSection, resetSection];
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

    if (item == self.lightModeBgColorItem) {
        cell.accessoryView = self.lightModeBgColorPreview;
    } else if (item == self.darkModeBgColorItem) {
        cell.accessoryView = self.darkModeBgColorPreview;
    } else if (item == self.topSessionTopMarginBgColorItem) {
        cell.accessoryView = self.topSessionTopMarginBgColorPreview;
    } else if (item == self.normalSessionTopMarginBgColorItem) {
        cell.accessoryView = self.normalSessionTopMarginBgColorPreview;
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"开启后将为微信、发现、我的页面的列表项添加圆角效果，重启后生效。距离背景色默认透明。";
        case 1:
            return @"点击可选择列表项背景颜色，支持自定义透明度。";
        case 2:
            return @"恢复默认的圆角、边距和颜色设置。";
        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    if (item.actionBlock) {
        item.actionBlock();
    }
}

#pragma mark - Corner Radius Picker

- (void)showCornerRadiusPicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"圆角半径"
                                                                   message:@"请输入圆角半径（范围: 5-30）"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = [NSString stringWithFormat:@"当前: %.0f", self.cornerRadius];
        textField.text = [NSString stringWithFormat:@"%.0f", self.cornerRadius];
    }];

    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;

        CGFloat radiusValue = [inputText floatValue];

        if (radiusValue < 5) {
            radiusValue = 5;
        } else if (radiusValue > 30) {
            radiusValue = 30;
        }

        self.cornerRadius = radiusValue;

            [[CSListCornerConfiguration sharedConfiguration] saveNumber:radiusValue forKey:kListCornerRadiusKey];


        [self setupData];
        [self.tableView reloadData];

        [self showRestartAlert];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    [alert addAction:confirmAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Left Margin Picker

- (void)showLeftMarginPicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"左边距"
                                                                   message:@"请输入左边距（范围: 1-30）"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = [NSString stringWithFormat:@"当前: %.0f", self.leftMargin];
        textField.text = [NSString stringWithFormat:@"%.0f", self.leftMargin];
    }];

    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;

        CGFloat marginValue = [inputText floatValue];

        if (marginValue < 1) {
            marginValue = 1;
        } else if (marginValue > 30) {
            marginValue = 30;
        }

        self.leftMargin = marginValue;

            [[CSListCornerConfiguration sharedConfiguration] saveNumber:marginValue forKey:kListLeftMarginKey];


        [self setupData];
        [self.tableView reloadData];

        [self showRestartAlert];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    [alert addAction:confirmAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Right Margin Picker

- (void)showRightMarginPicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"右边距"
                                                                   message:@"请输入右边距（范围: 1-30）"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = [NSString stringWithFormat:@"当前: %.0f", self.rightMargin];
        textField.text = [NSString stringWithFormat:@"%.0f", self.rightMargin];
    }];

    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;

        CGFloat marginValue = [inputText floatValue];

        if (marginValue < 1) {
            marginValue = 1;
        } else if (marginValue > 30) {
            marginValue = 30;
        }

        self.rightMargin = marginValue;

            [[CSListCornerConfiguration sharedConfiguration] saveNumber:marginValue forKey:kListRightMarginKey];


        [self setupData];
        [self.tableView reloadData];

        [self showRestartAlert];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    [alert addAction:confirmAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Top Session Top Margin Picker

- (void)showTopSessionTopMarginPicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"置顶会话顶部距离"
                                                                   message:@"请输入置顶会话距离顶部的距离（范围: 0-50）"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = [NSString stringWithFormat:@"当前: %.0f", self.topSessionTopMargin];
        textField.text = [NSString stringWithFormat:@"%.0f", self.topSessionTopMargin];
    }];

    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;

        CGFloat marginValue = [inputText floatValue];

        if (marginValue < 0) {
            marginValue = 0;
        } else if (marginValue > 50) {
            marginValue = 50;
        }

        self.topSessionTopMargin = marginValue;

            [[CSListCornerConfiguration sharedConfiguration] saveNumber:marginValue forKey:kListTopSessionTopMarginKey];


        [self setupData];
        [self.tableView reloadData];

        [self showRestartAlert];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    [alert addAction:confirmAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Normal Session Top Margin Picker

- (void)showNormalSessionTopMarginPicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"普通会话顶部距离"
                                                                   message:@"请输入普通会话距离置顶会话的距离（范围: 0-50）"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = [NSString stringWithFormat:@"当前: %.0f", self.normalSessionTopMargin];
        textField.text = [NSString stringWithFormat:@"%.0f", self.normalSessionTopMargin];
    }];

    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *inputText = textField.text;

        CGFloat marginValue = [inputText floatValue];

        if (marginValue < 0) {
            marginValue = 0;
        } else if (marginValue > 50) {
            marginValue = 50;
        }

        self.normalSessionTopMargin = marginValue;

            [[CSListCornerConfiguration sharedConfiguration] saveNumber:marginValue forKey:kListNormalSessionTopMarginKey];


        [self setupData];
        [self.tableView reloadData];

        [self showRestartAlert];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    [alert addAction:confirmAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Reset to Default Settings

- (void)resetToDefaultSettings {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重置默认设置"
                                                                   message:@"确定要恢复默认的圆角、边距和颜色设置吗？"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * _Nonnull action) {

        [[CSListCornerConfiguration sharedConfiguration] saveNumber:kDefaultCornerRadius forKey:kListCornerRadiusKey];
        self.cornerRadius = kDefaultCornerRadius;

        [[CSListCornerConfiguration sharedConfiguration] saveNumber:kDefaultLeftMargin forKey:kListLeftMarginKey];
        self.leftMargin = kDefaultLeftMargin;

        [[CSListCornerConfiguration sharedConfiguration] saveNumber:kDefaultRightMargin forKey:kListRightMarginKey];
        self.rightMargin = kDefaultRightMargin;

        [[CSListCornerConfiguration sharedConfiguration] saveNumber:kDefaultTopSessionTopMargin forKey:kListTopSessionTopMarginKey];
        self.topSessionTopMargin = kDefaultTopSessionTopMargin;

        [[CSListCornerConfiguration sharedConfiguration] saveNumber:kDefaultNormalSessionTopMargin forKey:kListNormalSessionTopMarginKey];
        self.normalSessionTopMargin = kDefaultNormalSessionTopMargin;

        UIColor *defaultLightBgColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        UIColor *defaultDarkBgColor = [UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:1.0];

        [self saveColor:defaultLightBgColor
                redKey:kListLightModeBgColorRedKey
              greenKey:kListLightModeBgColorGreenKey
               blueKey:kListLightModeBgColorBlueKey
              alphaKey:kListLightModeBgColorAlphaKey];

        [self saveColor:defaultDarkBgColor
                redKey:kListDarkModeBgColorRedKey
              greenKey:kListDarkModeBgColorGreenKey
               blueKey:kListDarkModeBgColorBlueKey
              alphaKey:kListDarkModeBgColorAlphaKey];


        self.lightModeBgColor = defaultLightBgColor;
        self.darkModeBgColor = defaultDarkBgColor;

        self.lightModeBgColorPreview.previewColor = defaultLightBgColor;
        self.darkModeBgColorPreview.previewColor = defaultDarkBgColor;


        [self setupData];
        [self.tableView reloadData];

        [self showRestartAlert];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    [alert addAction:cancelAction];
    [alert addAction:confirmAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Color Picker

- (void)showColorPickerWithTitle:(NSString *)title currentColor:(UIColor *)currentColor {
    UIColorPickerViewController *colorPicker = [[UIColorPickerViewController alloc] init];
    colorPicker.delegate = self;
    colorPicker.selectedColor = currentColor;
    colorPicker.title = title;
    colorPicker.supportsAlpha = YES;
    [self presentViewController:colorPicker animated:YES completion:nil];
}

#pragma mark - UIColorPickerViewControllerDelegate

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController {
    UIColor *selectedColor = viewController.selectedColor;

    BOOL isDarkMode = NO;
    if (@available(iOS 13.0, *)) {
        isDarkMode = [UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark;
    }

    switch (self.currentColorType) {
        case 0:
            self.lightModeBgColor = selectedColor;
            self.lightModeBgColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kListLightModeBgColorRedKey
                  greenKey:kListLightModeBgColorGreenKey
                   blueKey:kListLightModeBgColorBlueKey
                  alphaKey:kListLightModeBgColorAlphaKey];
            break;
        case 1:
            self.darkModeBgColor = selectedColor;
            self.darkModeBgColorPreview.previewColor = selectedColor;
            [self saveColor:selectedColor
                    redKey:kListDarkModeBgColorRedKey
                  greenKey:kListDarkModeBgColorGreenKey
                   blueKey:kListDarkModeBgColorBlueKey
                  alphaKey:kListDarkModeBgColorAlphaKey];
            break;
        case 2:
            self.topSessionTopMarginBgColor = selectedColor;
            self.topSessionTopMarginBgColorPreview.previewColor = selectedColor;
            if (isDarkMode) {
                [self saveColor:selectedColor
                        redKey:kTopSessionTopMarginDarkBgColorRedKey
                      greenKey:kTopSessionTopMarginDarkBgColorGreenKey
                       blueKey:kTopSessionTopMarginDarkBgColorBlueKey
                      alphaKey:kTopSessionTopMarginDarkBgColorAlphaKey];
            } else {
                [self saveColor:selectedColor
                        redKey:kTopSessionTopMarginLightBgColorRedKey
                      greenKey:kTopSessionTopMarginLightBgColorGreenKey
                       blueKey:kTopSessionTopMarginLightBgColorBlueKey
                      alphaKey:kTopSessionTopMarginLightBgColorAlphaKey];
            }
            break;
        case 3:
            self.normalSessionTopMarginBgColor = selectedColor;
            self.normalSessionTopMarginBgColorPreview.previewColor = selectedColor;
            if (isDarkMode) {
                [self saveColor:selectedColor
                        redKey:kNormalSessionTopMarginDarkBgColorRedKey
                      greenKey:kNormalSessionTopMarginDarkBgColorGreenKey
                       blueKey:kNormalSessionTopMarginDarkBgColorBlueKey
                      alphaKey:kNormalSessionTopMarginDarkBgColorAlphaKey];
            } else {
                [self saveColor:selectedColor
                        redKey:kNormalSessionTopMarginLightBgColorRedKey
                      greenKey:kNormalSessionTopMarginLightBgColorGreenKey
                       blueKey:kNormalSessionTopMarginLightBgColorBlueKey
                      alphaKey:kNormalSessionTopMarginLightBgColorAlphaKey];
            }
            break;
    }


    [self.tableView reloadData];

    [self showRestartAlert];
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController {
    UIColor *selectedColor = viewController.selectedColor;

    switch (self.currentColorType) {
        case 0:
            self.lightModeBgColorPreview.previewColor = selectedColor;
            break;
        case 1:
            self.darkModeBgColorPreview.previewColor = selectedColor;
            break;
        case 2:
            self.topSessionTopMarginBgColorPreview.previewColor = selectedColor;
            break;
        case 3:
            self.normalSessionTopMarginBgColorPreview.previewColor = selectedColor;
            break;
    }
}

@end
