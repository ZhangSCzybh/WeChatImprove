#import "CSQuickPanelSettingsViewController.h"
#import "CSQuickPanelPreferences.h"
#import "CSQuickPanelContentView.h"
#import "CSQuickPanelCoordinator.h"
#import "CSQuickPanelBackgroundView.h"
#import "CSQuickPanelBackgroundImageStore.h"
#import "CSQuickPanelAppearance.h"
#import "CSSettingsHomeTheme.h"
#import "CSBackupBootstrap.h"
#import "CSBackupMutation.h"
#import "CSSettingTableViewCell.h"
#import <PhotosUI/PhotosUI.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import <math.h>

typedef NS_ENUM(NSInteger, CSQuickPanelSettingsSection) {
    CSQuickPanelSettingsSectionEnabled,
    CSQuickPanelSettingsSectionPreview,
    CSQuickPanelSettingsSectionBackground,
    CSQuickPanelSettingsSectionColors,
    CSQuickPanelSettingsSectionLocations,
    CSQuickPanelSettingsSectionSelected,
    CSQuickPanelSettingsSectionAvailable,
    CSQuickPanelSettingsSectionCount,
};

typedef NS_ENUM(NSInteger, CSQuickPanelColorTarget) {
    CSQuickPanelColorTargetBackground,
    CSQuickPanelColorTargetText,
    CSQuickPanelColorTargetIcon,
};

@interface CSQuickPanelColorPicker : UIColorPickerViewController
@property(nonatomic) CSQuickPanelColorTarget colorTarget;
@end
@implementation CSQuickPanelColorPicker
@end

@interface CSQuickPanelSettingsViewController () <UIColorPickerViewControllerDelegate,PHPickerViewControllerDelegate>
@property(nonatomic, copy) NSArray<NSString *> *selectedIdentifiers;
@property(nonatomic, copy) NSArray<NSString *> *availableIdentifiers;
@property(nonatomic, strong) CSQuickPanelContentView *previewContent;
@property(nonatomic, strong) UITableViewCell *previewCell;
@property(nonatomic, strong) CSQuickPanelBackgroundView *previewBackground;
@property(nonatomic, strong) UITableViewCell *opacityCell;
@property(nonatomic, strong) UISlider *opacitySlider;
@property(nonatomic, strong) UILabel *opacityValueLabel;
@property(nonatomic) NSUInteger imageSelectionGeneration;
@property(nonatomic) BOOL imageImporting;
@property(nonatomic, weak) CSQuickPanelColorPicker *activeColorPicker;
@end

@implementation CSQuickPanelSettingsViewController

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleInsetGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    (void)style;
    return [super initWithStyle:UITableViewStyleInsetGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷面板";
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    self.tableView.allowsSelectionDuringEditing = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"排序"
        style:UIBarButtonItemStylePlain target:self action:@selector(toggleReordering)];
    [CSSettingTableViewCell registerToTableView:self.tableView];

    self.previewContent = [[CSQuickPanelContentView alloc] initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf = self;
    self.previewContent.actionHandler = ^(NSString *identifier) {
        (void)identifier;
        [weakSelf presentFullPreview];
    };
    self.previewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    self.previewCell.backgroundConfiguration = UIBackgroundConfiguration.clearConfiguration;
    self.previewCell.backgroundColor = UIColor.clearColor;
    self.previewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.previewCell.contentView.clipsToBounds = YES;
    self.previewBackground = [[CSQuickPanelBackgroundView alloc] initWithFrame:CGRectZero];
    self.previewBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.previewCell.contentView addSubview:self.previewBackground];
    self.previewBackground.appearanceChanged = ^(BOOL lightContent) {
        weakSelf.previewContent.backgroundUsesLightContent = lightContent;
    };
    [self.previewBackground reloadAppearance];
    self.previewContent.translatesAutoresizingMaskIntoConstraints = NO;
    [self.previewCell.contentView addSubview:self.previewContent];
    [NSLayoutConstraint activateConstraints:@[
        [self.previewBackground.topAnchor constraintEqualToAnchor:self.previewCell.contentView.topAnchor],
        [self.previewBackground.bottomAnchor constraintEqualToAnchor:self.previewCell.contentView.bottomAnchor],
        [self.previewBackground.leadingAnchor constraintEqualToAnchor:self.previewCell.contentView.leadingAnchor],
        [self.previewBackground.trailingAnchor constraintEqualToAnchor:self.previewCell.contentView.trailingAnchor],
        [self.previewContent.topAnchor constraintEqualToAnchor:self.previewCell.contentView.topAnchor],
        [self.previewContent.bottomAnchor constraintEqualToAnchor:self.previewCell.contentView.bottomAnchor],
        [self.previewContent.leadingAnchor constraintEqualToAnchor:self.previewCell.contentView.leadingAnchor],
        [self.previewContent.trailingAnchor constraintEqualToAnchor:self.previewCell.contentView.trailingAnchor],
    ]];
    [self prepareOpacityCell];

    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(preferencesChanged:)
        name:CSQuickPanelPreferencesDidChangeNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(preferencesChanged:)
        name:CSSettingsHomeThemeDidChangeNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(contentSizeChanged:)
        name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self reloadSettings];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadSettings];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        (void)context;
        [weakSelf.tableView reloadData];
    }];
}

- (void)reloadSettings {
    self.selectedIdentifiers = CSQuickPanelPreferences.selectedActionIdentifiers;
    NSMutableArray<NSString *> *available = [NSMutableArray array];
    for (NSString *identifier in CSQuickPanelPreferences.allActionIdentifiers) {
        if (![self.selectedIdentifiers containsObject:identifier]) [available addObject:identifier];
    }
    self.availableIdentifiers = available.copy;
    [self.previewContent reloadContent];
    [self.tableView reloadData];
}

- (void)preferencesChanged:(NSNotification *)notification {
    (void)notification;
    // UIKit owns an in-progress reorder. The local list already reflects our
    // writes; defer external list refresh until editing ends.
    if (self.tableView.isEditing || self.opacitySlider.isTracking) {
        [self.previewContent reloadContent];
        return;
    }
    [self reloadSettings];
}

- (void)contentSizeChanged:(NSNotification *)notification {
    (void)notification;
    [self.previewContent reloadContent];
    [self.tableView reloadData];
}

- (void)toggleReordering {
    BOOL editing = !self.tableView.isEditing;
    [self.tableView setEditing:editing animated:YES];
    self.navigationItem.rightBarButtonItem.title = editing ? @"完成" : @"排序";
    if (!editing) [self reloadSettings];
}

- (void)presentFullPreview {
    [CSQuickPanelCoordinator presentPreviewFromViewController:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return CSQuickPanelSettingsSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    switch (section) {
        case CSQuickPanelSettingsSectionEnabled: return 1;
        case CSQuickPanelSettingsSectionPreview: return 2;
        case CSQuickPanelSettingsSectionBackground: return 5;
        case CSQuickPanelSettingsSectionColors: return 3;
        case CSQuickPanelSettingsSectionLocations: return 2;
        case CSQuickPanelSettingsSectionSelected: return MAX((NSUInteger)1, self.selectedIdentifiers.count);
        case CSQuickPanelSettingsSectionAvailable: return self.availableIdentifiers.count;
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    switch (section) {
        case CSQuickPanelSettingsSectionPreview: return @"面板预览";
        case CSQuickPanelSettingsSectionBackground: return @"面板背景";
        case CSQuickPanelSettingsSectionColors: return @"面板配色";
        case CSQuickPanelSettingsSectionLocations: return @"打开位置";
        case CSQuickPanelSettingsSectionSelected: return [NSString stringWithFormat:@"已添加入口 · %lu", (unsigned long)self.selectedIdentifiers.count];
        case CSQuickPanelSettingsSectionAvailable: return self.availableIdentifiers.count ? @"可添加入口" : nil;
        default: return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    switch (section) {
        case CSQuickPanelSettingsSectionEnabled: return @"关闭时仍可预览和调整面板，开启后在选定页面使用快捷入口。";
        case CSQuickPanelSettingsSectionPreview: return @"点击预览可查看完整面板，预览中的入口不会打开微信页面。";
        case CSQuickPanelSettingsSectionBackground: return @"可使用默认背景、自选颜色或相册图片。透明度只影响背景，文字和入口保持清晰；图片按面板比例居中裁切。";
        case CSQuickPanelSettingsSectionColors: return @"字体默认随背景调整深浅，图标默认跟随界面调色。两项均可独立自定义，恢复默认配色仅重置字体和图标颜色。";
        case CSQuickPanelSettingsSectionLocations: return @"可同时选择两种打开位置，至少保留一个打开位置。";
        case CSQuickPanelSettingsSectionSelected: return @"按列表顺序显示。点击入口可移除，点击右上角“排序”后拖动调整顺序。";
        case CSQuickPanelSettingsSectionAvailable: return self.availableIdentifiers.count ? @"点击添加到面板末尾。" : @"已添加全部入口。";
        default: return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CSQuickPanelSettingsSectionBackground && indexPath.row == 3)
        return MAX(94, [UIFont preferredFontForTextStyle:UIFontTextStyleBody].lineHeight + 68);
    if (indexPath.section == CSQuickPanelSettingsSectionPreview && indexPath.row == 0) {
        CGFloat width = MAX(1, CGRectGetWidth(tableView.bounds) - tableView.adjustedContentInset.left -
            tableView.adjustedContentInset.right - tableView.layoutMargins.left - tableView.layoutMargins.right);
        return [self.previewContent preferredHeightForWidth:width];
    }
    return MAX(52, [UIFont preferredFontForTextStyle:UIFontTextStyleBody].lineHeight + 24);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CSQuickPanelSettingsSectionPreview && indexPath.row == 0) return self.previewCell;
    if (indexPath.section == CSQuickPanelSettingsSectionBackground && indexPath.row == 3) {
        if (!self.opacitySlider.isTracking) self.opacitySlider.value = (float)((1-CSQuickPanelPreferences.backgroundOpacity)*100);
        [self updateOpacityValue];
        return self.opacityCell;
    }
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier forIndexPath:indexPath];
    CSSettingItem *item;
    UIColor *color = UIColor.systemBlueColor;
    if (indexPath.section == CSQuickPanelSettingsSectionEnabled) {
        item = [CSSettingItem switchItemWithTitle:@"启用快捷面板" iconName:@"square.grid.2x2.fill" iconColor:color
            switchValue:CSQuickPanelPreferences.enabled valueChangedBlock:^(BOOL enabled) {
                [CSQuickPanelPreferences setEnabled:enabled];
            }];
    } else if (indexPath.section == CSQuickPanelSettingsSectionPreview) {
        item = [CSSettingItem itemWithTitle:@"查看完整预览" iconName:@"rectangle.expand.vertical" iconColor:color detail:nil];
    } else if (indexPath.section == CSQuickPanelSettingsSectionLocations) {
        item = [CSSettingItem itemWithTitle:indexPath.row == 0 ? @"微信主页底栏上滑" : @"聊天输入框上滑"
            iconName:indexPath.row == 0 ? @"house.fill" : @"bubble.left.and.bubble.right.fill" iconColor:color detail:nil];
    } else if (indexPath.section == CSQuickPanelSettingsSectionBackground) {
        NSArray *titles = @[@"背景样式", @"背景颜色", @"背景图片", @"背景透明度", @"恢复默认背景"];
        NSArray *symbols = @[@"rectangle.3.group", @"paintpalette.fill", @"photo.fill", @"circle.lefthalf.filled", @"arrow.counterclockwise"];
        NSString *detail = nil;
        if (indexPath.row == 0) detail = [self backgroundStyleTitle];
        if (indexPath.row == 1) detail = CSQuickPanelPreferences.backgroundColorHex;
        if (indexPath.row == 2) detail = self.imageImporting ? @"正在处理…" : (CSQuickPanelPreferences.backgroundImagePath.length ? @"已选择 · 点击更换" : @"从相册选择");
        item = [CSSettingItem itemWithTitle:titles[indexPath.row] iconName:symbols[indexPath.row]
            iconColor:indexPath.row == 4 ? UIColor.systemOrangeColor : color detail:detail];
    } else if (indexPath.section == CSQuickPanelSettingsSectionColors) {
        NSArray *titles = @[@"字体颜色", @"图标颜色", @"恢复默认配色"];
        NSArray *symbols = @[@"textformat", @"square.grid.2x2.fill", @"arrow.counterclockwise"];
        NSString *detail = nil;
        if (indexPath.row == 0) detail = CSQuickPanelPreferences.textColorHex ?: @"自动适配背景";
        if (indexPath.row == 1) detail = CSQuickPanelPreferences.iconColorHex ?: @"跟随界面调色";
        item = [CSSettingItem itemWithTitle:titles[indexPath.row] iconName:symbols[indexPath.row]
            iconColor:indexPath.row == 2 ? UIColor.systemOrangeColor : color detail:detail];
    } else {
        NSArray<NSString *> *identifiers = indexPath.section == CSQuickPanelSettingsSectionSelected ? self.selectedIdentifiers : self.availableIdentifiers;
        NSString *identifier = indexPath.row < (NSInteger)identifiers.count ? identifiers[indexPath.row] : nil;
        item = [CSSettingItem itemWithTitle:identifier ? [CSQuickPanelPreferences titleForActionIdentifier:identifier] : @"尚未添加入口"
            iconName:identifier ? [CSQuickPanelPreferences symbolNameForActionIdentifier:identifier] : @"square.dashed"
            iconColor:identifier ? color : UIColor.secondaryLabelColor detail:nil];
    }
    [cell configureWithItem:item];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.showsReorderControl = indexPath.section == CSQuickPanelSettingsSectionSelected && self.selectedIdentifiers.count > 0;
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.textLabel.adjustsFontForContentSizeCategory = YES;
    cell.textLabel.numberOfLines = 1;
    cell.accessibilityValue = nil;
    cell.accessibilityHint = nil;
    cell.accessibilityTraits = UIAccessibilityTraitButton;
    if (indexPath.section == CSQuickPanelSettingsSectionEnabled) {
        cell.accessibilityTraits = UIAccessibilityTraitNone;
    } else if (indexPath.section == CSQuickPanelSettingsSectionLocations) {
        CSQuickPanelTriggerLocations location = indexPath.row == 0 ? CSQuickPanelTriggerHome : CSQuickPanelTriggerChat;
        BOOL selected = (CSQuickPanelPreferences.triggerLocations & location) != 0;
        cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        cell.accessibilityValue = selected ? @"已选择" : @"未选择";
        if (selected) cell.accessibilityTraits |= UIAccessibilityTraitSelected;
    } else if (indexPath.section == CSQuickPanelSettingsSectionPreview) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == CSQuickPanelSettingsSectionBackground) {
        cell.accessoryType = indexPath.row == 4 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 1) {
            UIView *swatch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
            swatch.layer.cornerRadius = 8;
            swatch.layer.borderWidth = 1;
            swatch.layer.borderColor = UIColor.separatorColor.CGColor;
            swatch.backgroundColor = [self selectedBackgroundColor];
            cell.accessoryView = swatch;
            cell.accessibilityValue = CSQuickPanelPreferences.backgroundColorHex;
        }
    } else if (indexPath.section == CSQuickPanelSettingsSectionColors) {
        if (indexPath.row < 2) {
            UIView *swatch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
            swatch.layer.cornerRadius = 8;
            swatch.layer.borderWidth = 1;
            swatch.layer.borderColor = UIColor.separatorColor.CGColor;
            swatch.backgroundColor = indexPath.row == 0 ?
                [CSQuickPanelAppearance primaryTextColorForLightContent:self.previewContent.backgroundUsesLightContent] : CSQuickPanelAppearance.iconColor;
            cell.accessoryView = swatch;
            cell.accessibilityValue = indexPath.row == 0 ?
                (CSQuickPanelPreferences.textColorHex ?: @"自动适配背景") : (CSQuickPanelPreferences.iconColorHex ?: @"跟随界面调色");
            cell.accessibilityHint = @"选择自定义颜色或恢复默认";
        }
    } else if (indexPath.section == CSQuickPanelSettingsSectionAvailable) {
        cell.accessibilityHint = @"添加到快捷面板";
    } else if (!self.selectedIdentifiers.count) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessibilityTraits = UIAccessibilityTraitStaticText;
    } else {
        cell.accessibilityHint = @"从快捷面板移除";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == CSQuickPanelSettingsSectionPreview) {
        [self presentFullPreview];
    } else if (indexPath.section == CSQuickPanelSettingsSectionBackground) {
        if (indexPath.row == 0) [self showBackgroundStylePicker:indexPath];
        if (indexPath.row == 1) [self showBackgroundColorPicker];
        if (indexPath.row == 2) [self showBackgroundImageOptions:indexPath];
        if (indexPath.row == 4) [self restoreDefaultBackground];
    } else if (indexPath.section == CSQuickPanelSettingsSectionColors) {
        if (indexPath.row < 2) [self showForegroundColorOptions:indexPath];
        else [self restoreDefaultForegroundColors];
    } else if (indexPath.section == CSQuickPanelSettingsSectionLocations) {
        CSQuickPanelTriggerLocations current = CSQuickPanelPreferences.triggerLocations;
        CSQuickPanelTriggerLocations location = indexPath.row == 0 ? CSQuickPanelTriggerHome : CSQuickPanelTriggerChat;
        CSQuickPanelTriggerLocations next = current ^ location;
        if (next) [CSQuickPanelPreferences setTriggerLocations:next];
        else UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"至少保留一个打开位置");
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:CSQuickPanelSettingsSectionLocations] withRowAnimation:UITableViewRowAnimationNone];
    } else if (indexPath.section == CSQuickPanelSettingsSectionSelected && indexPath.row < (NSInteger)self.selectedIdentifiers.count) {
        NSMutableArray<NSString *> *identifiers = self.selectedIdentifiers.mutableCopy;
        [identifiers removeObjectAtIndex:indexPath.row];
        [CSQuickPanelPreferences setSelectedActionIdentifiers:identifiers];
        [self reloadSettings];
    } else if (indexPath.section == CSQuickPanelSettingsSectionAvailable && indexPath.row < (NSInteger)self.availableIdentifiers.count) {
        NSMutableArray<NSString *> *identifiers = self.selectedIdentifiers.mutableCopy;
        [identifiers addObject:self.availableIdentifiers[indexPath.row]];
        [CSQuickPanelPreferences setSelectedActionIdentifiers:identifiers];
        [self reloadSettings];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)tableView;
    return (indexPath.section == CSQuickPanelSettingsSectionSelected && self.selectedIdentifiers.count > 0) ||
        indexPath.section == CSQuickPanelSettingsSectionAvailable;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)tableView;
    if (indexPath.section == CSQuickPanelSettingsSectionSelected && self.selectedIdentifiers.count > 0) return UITableViewCellEditingStyleDelete;
    if (indexPath.section == CSQuickPanelSettingsSectionAvailable) return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete || editingStyle == UITableViewCellEditingStyleInsert) {
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)tableView;
    return indexPath.section == CSQuickPanelSettingsSectionSelected && self.selectedIdentifiers.count > 1;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)source proposedIndexPath:(NSIndexPath *)proposed {
    (void)tableView;
    if (proposed.section < CSQuickPanelSettingsSectionSelected) return [NSIndexPath indexPathForRow:0 inSection:CSQuickPanelSettingsSectionSelected];
    if (proposed.section > CSQuickPanelSettingsSectionSelected) return [NSIndexPath indexPathForRow:MAX((NSInteger)0, (NSInteger)self.selectedIdentifiers.count - 1) inSection:CSQuickPanelSettingsSectionSelected];
    return source.section == proposed.section ? proposed : source;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)source toIndexPath:(NSIndexPath *)destination {
    (void)tableView;
    if (source.section != CSQuickPanelSettingsSectionSelected || destination.section != source.section ||
        source.row >= (NSInteger)self.selectedIdentifiers.count || destination.row >= (NSInteger)self.selectedIdentifiers.count) return;
    NSMutableArray<NSString *> *identifiers = self.selectedIdentifiers.mutableCopy;
    NSString *identifier = identifiers[source.row];
    [identifiers removeObjectAtIndex:source.row];
    [identifiers insertObject:identifier atIndex:destination.row];
    self.selectedIdentifiers = identifiers.copy;
    [CSQuickPanelPreferences setSelectedActionIdentifiers:self.selectedIdentifiers];
    [self.previewContent reloadContent];
}

- (void)prepareOpacityCell {
    self.opacityCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    self.opacityCell.backgroundColor = UIColor.secondarySystemGroupedBackgroundColor;
    self.opacityCell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *title = [UILabel new];
    title.text = @"背景透明度";
    title.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    title.adjustsFontForContentSizeCategory = YES;
    self.opacityValueLabel = [UILabel new];
    self.opacityValueLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.opacityValueLabel.textColor = UIColor.secondaryLabelColor;
    self.opacityValueLabel.textAlignment = NSTextAlignmentRight;
    [self.opacityValueLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"circle.lefthalf.filled"]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.tintColor = UIColor.systemBlueColor;
    [icon.widthAnchor constraintEqualToConstant:26].active = YES;
    [icon.heightAnchor constraintEqualToConstant:26].active = YES;
    UIStackView *heading = [[UIStackView alloc] initWithArrangedSubviews:@[icon, title, self.opacityValueLabel]];
    heading.spacing = 12;
    heading.alignment = UIStackViewAlignmentCenter;
    self.opacitySlider = [UISlider new];
    self.opacitySlider.minimumValue = 0;
    self.opacitySlider.maximumValue = 100;
    self.opacitySlider.continuous = YES;
    self.opacitySlider.accessibilityLabel = @"背景透明度";
    self.opacitySlider.accessibilityHint = @"百分之零为不透明，百分之百为完全透明";
    [self.opacitySlider addTarget:self action:@selector(opacityChanged:) forControlEvents:UIControlEventValueChanged];
    [self.opacitySlider addTarget:self action:@selector(opacityEditingEnded:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel];
    UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[heading, self.opacitySlider]];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.spacing = 8;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.opacityCell.contentView addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [stack.topAnchor constraintEqualToAnchor:self.opacityCell.contentView.topAnchor constant:12],
        [stack.bottomAnchor constraintEqualToAnchor:self.opacityCell.contentView.bottomAnchor constant:-10],
        [stack.leadingAnchor constraintEqualToAnchor:self.opacityCell.contentView.leadingAnchor constant:16],
        [stack.trailingAnchor constraintEqualToAnchor:self.opacityCell.contentView.trailingAnchor constant:-16],
    ]];
}

- (void)updateOpacityValue {
    NSString *value = [NSString stringWithFormat:@"%.0f%%", self.opacitySlider.value];
    self.opacityValueLabel.text = value;
    self.opacitySlider.accessibilityValue = value;
}

- (void)opacityChanged:(UISlider *)slider {
    [self updateOpacityValue];
    [CSQuickPanelPreferences setBackgroundOpacity:1-slider.value/100.0];
}

- (void)opacityEditingEnded:(UISlider *)slider {
    [self opacityChanged:slider];
    [self reloadSettings];
}

- (NSString *)backgroundStyleTitle {
    NSString *style = CSQuickPanelPreferences.backgroundStyle;
    if ([style isEqual:CSQuickPanelBackgroundStyleColor]) return @"自选颜色";
    if ([style isEqual:CSQuickPanelBackgroundStyleImage]) return @"背景图片";
    return @"默认背景";
}

- (UIColor *)selectedBackgroundColor {
    NSString *hex = CSQuickPanelPreferences.backgroundColorHex;
    unsigned int value = 0;
    [[NSScanner scannerWithString:[hex substringFromIndex:1]] scanHexInt:&value];
    return [UIColor colorWithRed:((value>>16)&255)/255.0 green:((value>>8)&255)/255.0 blue:(value&255)/255.0 alpha:1];
}

- (void)anchorSheet:(UIAlertController *)sheet atIndexPath:(NSIndexPath *)path {
    UIPopoverPresentationController *popover = sheet.popoverPresentationController;
    popover.sourceView = self.tableView;
    popover.sourceRect = [self.tableView rectForRowAtIndexPath:path];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)showBackgroundStylePicker:(NSIndexPath *)path {
    self.activeColorPicker = nil;
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"背景样式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *styles = @[CSQuickPanelBackgroundStyleDefault, CSQuickPanelBackgroundStyleColor, CSQuickPanelBackgroundStyleImage];
    NSArray *titles = @[@"默认背景", @"自选颜色", @"背景图片"];
    __weak typeof(self) weakSelf = self;
    [styles enumerateObjectsUsingBlock:^(NSString *style, NSUInteger index, BOOL *stop) {
        (void)stop;
        NSString *title = [titles[index] stringByAppendingString:[CSQuickPanelPreferences.backgroundStyle isEqual:style] ? @" ✓" : @""];
        [sheet addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            CSQuickPanelSettingsViewController *live = weakSelf;
            if (!live) return;
            live.imageSelectionGeneration++;
            live.imageImporting = NO;
            if ([style isEqual:CSQuickPanelBackgroundStyleImage] && !CSQuickPanelPreferences.backgroundImagePath.length) {
                [live showBackgroundPhotoPicker];
            } else {
                [CSQuickPanelPreferences setBackgroundStyle:style];
                [live reloadSettings];
            }
        }]];
    }];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self anchorSheet:sheet atIndexPath:path];
}

- (void)showBackgroundColorPicker {
    self.activeColorPicker = nil;
    [self showColorPickerForTarget:CSQuickPanelColorTargetBackground];
}

- (void)showForegroundColorOptions:(NSIndexPath *)path {
    self.activeColorPicker = nil;
    CSQuickPanelColorTarget target = path.row == 0 ? CSQuickPanelColorTargetText : CSQuickPanelColorTargetIcon;
    NSString *defaultTitle = target == CSQuickPanelColorTargetText ? @"自动适配背景" : @"跟随界面调色";
    NSString *current = target == CSQuickPanelColorTargetText ? CSQuickPanelPreferences.textColorHex : CSQuickPanelPreferences.iconColorHex;
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:target == CSQuickPanelColorTargetText ? @"字体颜色" : @"图标颜色"
        message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    [sheet addAction:[UIAlertAction actionWithTitle:[defaultTitle stringByAppendingString:current ? @"" : @" ✓"]
        style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            weakSelf.activeColorPicker = nil;
            if (target == CSQuickPanelColorTargetText) [CSQuickPanelPreferences setTextColorHex:nil];
            else [CSQuickPanelPreferences setIconColorHex:nil];
            [weakSelf reloadSettings];
        }]];
    [sheet addAction:[UIAlertAction actionWithTitle:current ? @"更换自定义颜色" : @"自定义颜色"
        style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            [weakSelf showColorPickerForTarget:target];
        }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self anchorSheet:sheet atIndexPath:path];
}

- (void)showColorPickerForTarget:(CSQuickPanelColorTarget)target {
    if (!self.viewIfLoaded.window || self.navigationController.topViewController != self ||
        UIApplication.sharedApplication.applicationState != UIApplicationStateActive) return;
    UIViewController *presented = self.presentedViewController;
    if (presented) {
        if (![presented isKindOfClass:UIAlertController.class]) return;
        __weak typeof(self) weakSelf = self;
        id<UIViewControllerTransitionCoordinator> transition = presented.transitionCoordinator;
        if (transition && [transition animateAlongsideTransition:nil completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
            [weakSelf showColorPickerForTarget:target];
        }]) return;
        [presented dismissViewControllerAnimated:YES completion:^{ [weakSelf showColorPickerForTarget:target]; }];
        return;
    }
    if (target == CSQuickPanelColorTargetBackground) {
        self.imageSelectionGeneration++;
        self.imageImporting = NO;
    }
    CSQuickPanelColorPicker *picker = [CSQuickPanelColorPicker new];
    picker.colorTarget = target;
    picker.delegate = self;
    picker.title = target == CSQuickPanelColorTargetBackground ? @"面板背景颜色" :
        (target == CSQuickPanelColorTargetText ? @"面板字体颜色" : @"面板图标颜色");
    picker.supportsAlpha = NO;
    UIColor *selected = target == CSQuickPanelColorTargetBackground ? [self selectedBackgroundColor] :
        (target == CSQuickPanelColorTargetText ? [CSQuickPanelAppearance primaryTextColorForLightContent:self.previewContent.backgroundUsesLightContent] : CSQuickPanelAppearance.iconColor);
    picker.selectedColor = [selected resolvedColorWithTraitCollection:self.traitCollection];
    self.activeColorPicker = picker;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)saveColorFromPicker:(UIColorPickerViewController *)picker {
    // Every picker carries its own target; a late callback from a replaced
    // picker must never overwrite another foreground or background setting.
    if (picker != self.activeColorPicker || ![picker isKindOfClass:CSQuickPanelColorPicker.class]) return;
    CGFloat r = 0, g = 0, b = 0, a = 1;
    if (![picker.selectedColor getRed:&r green:&g blue:&b alpha:&a] || !isfinite(r) || !isfinite(g) || !isfinite(b)) return;
    NSString *hex = [NSString stringWithFormat:@"#%02X%02X%02X", (unsigned int)lround(fmin(1,fmax(0,r))*255),
        (unsigned int)lround(fmin(1,fmax(0,g))*255), (unsigned int)lround(fmin(1,fmax(0,b))*255)];
    switch (((CSQuickPanelColorPicker *)picker).colorTarget) {
        case CSQuickPanelColorTargetBackground:
            [CSQuickPanelPreferences setBackgroundColorHex:hex];
            [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleColor];
            break;
        case CSQuickPanelColorTargetText: [CSQuickPanelPreferences setTextColorHex:hex]; break;
        case CSQuickPanelColorTargetIcon: [CSQuickPanelPreferences setIconColorHex:hex]; break;
    }
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)picker {
    [self saveColorFromPicker:picker];
}

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)picker {
    [self saveColorFromPicker:picker];
    if (picker == self.activeColorPicker) self.activeColorPicker = nil;
}

- (void)restoreDefaultForegroundColors {
    self.activeColorPicker = nil;
    [CSQuickPanelPreferences resetForegroundColors];
    [self reloadSettings];
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"已恢复默认面板配色");
}

- (void)showBackgroundImageOptions:(NSIndexPath *)path {
    self.activeColorPicker = nil;
    if (!CSQuickPanelPreferences.backgroundImagePath.length) { [self showBackgroundPhotoPicker]; return; }
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"面板背景图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    [sheet addAction:[UIAlertAction actionWithTitle:@"从相册更换" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) { [weakSelf showBackgroundPhotoPicker]; }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"使用这张图片" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        weakSelf.imageSelectionGeneration++;
        weakSelf.imageImporting = NO;
        [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleImage];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"移除背景图片" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action) { [weakSelf removeBackgroundImage]; }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self anchorSheet:sheet atIndexPath:path];
}

- (void)showBackgroundPhotoPicker {
    self.activeColorPicker = nil;
    UIViewController *presented = self.presentedViewController;
    if (presented) {
        if (![presented isKindOfClass:UIAlertController.class]) return;
        __weak typeof(self) weakSelf = self;
        id<UIViewControllerTransitionCoordinator> transition = presented.transitionCoordinator;
        if (transition) {
            [transition animateAlongsideTransition:nil completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
                [weakSelf showBackgroundPhotoPicker];
            }];
        } else {
            [presented dismissViewControllerAnimated:YES completion:^{ [weakSelf showBackgroundPhotoPicker]; }];
        }
        return;
    }
    self.imageSelectionGeneration++;
    self.imageImporting = NO;
    PHPickerConfiguration *configuration = [PHPickerConfiguration new];
    configuration.selectionLimit = 1;
    configuration.filter = PHPickerFilter.imagesFilter;
    PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results {
    NSItemProvider *provider = results.firstObject.itemProvider;
    NSUInteger generation = ++self.imageSelectionGeneration;
    NSUInteger epoch = CSBackupAccountEpoch();
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        CSQuickPanelSettingsViewController *live = weakSelf;
        if (!live || generation != live.imageSelectionGeneration || !provider) return;
        if (![provider hasItemConformingToTypeIdentifier:UTTypeImage.identifier]) {
            [live showBackgroundError:@"无法读取所选图片，请选择静态照片。"];
            return;
        }
        live.imageImporting = YES;
        [live reloadSettings];
        // The provider's file is valid only for the duration of its background callback.
        [provider loadFileRepresentationForTypeIdentifier:UTTypeImage.identifier completionHandler:^(NSURL *url, NSError *providerError) {
            NSError *error = providerError;
            NSString *path = url && !error ? [CSQuickPanelBackgroundImageStore storeImageAtURL:url error:&error] : nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                CSQuickPanelSettingsViewController *current = weakSelf;
                BOOL valid = current && generation == current.imageSelectionGeneration && CSBackupIsReady() &&
                    !CSBackupAccountIsSuspended() && epoch == CSBackupAccountEpoch() && current.viewIfLoaded.window &&
                    current.navigationController.topViewController == current &&
                    UIApplication.sharedApplication.applicationState == UIApplicationStateActive;
                if (!valid) {
                    if (path.length && ![path isEqual:CSQuickPanelPreferences.backgroundImagePath])
                        [CSQuickPanelBackgroundImageStore removeImageAtPath:path error:NULL];
                    if (current && generation == current.imageSelectionGeneration) {
                        current.imageImporting = NO;
                        [current reloadSettings];
                    }
                    return;
                }
                current.imageImporting = NO;
                if (!path.length) {
                    [current reloadSettings];
                    [current showBackgroundError:error.localizedDescription ?: @"图片读取失败，原背景已保留。"];
                    return;
                }
                CSBackupResourceMutationScope();
                NSString *previous = CSQuickPanelPreferences.backgroundImagePath;
                [CSQuickPanelPreferences setBackgroundImagePath:path];
                [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleImage];
                if (previous.length && ![previous isEqual:path]) [CSQuickPanelBackgroundImageStore removeImageAtPath:previous error:NULL];
                [current reloadSettings];
            });
        }];
    }];
}

- (void)removeBackgroundImage {
    self.activeColorPicker = nil;
    self.imageSelectionGeneration++;
    self.imageImporting = NO;
    CSBackupResourceMutationScope();
    NSString *path = CSQuickPanelPreferences.backgroundImagePath;
    NSError *error = nil;
    if (path.length && ![CSQuickPanelBackgroundImageStore removeImageAtPath:path error:&error]) {
        [self showBackgroundError:error.localizedDescription];
        return;
    }
    [CSQuickPanelPreferences setBackgroundImagePath:nil];
    if ([CSQuickPanelPreferences.backgroundStyle isEqual:CSQuickPanelBackgroundStyleImage])
        [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleDefault];
    [self reloadSettings];
}

- (void)restoreDefaultBackground {
    self.activeColorPicker = nil;
    self.imageSelectionGeneration++;
    self.imageImporting = NO;
    NSError *error = nil;
    if (![CSQuickPanelPreferences resetBackgroundWithError:&error]) {
        [self showBackgroundError:error.localizedDescription];
        return;
    }
    [self reloadSettings];
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"已恢复默认面板背景");
}

- (void)showBackgroundError:(NSString *)message {
    if (!self.viewIfLoaded.window || self.presentedViewController) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"背景设置" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
