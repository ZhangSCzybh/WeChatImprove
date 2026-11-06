#import "CSBubbleStyleSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSBubbleStylePolicy.h"
#import "CSBubbleStylePreview.h"
#import "CSMessageMergePolicy.h"
#include <math.h>

static NSString *const CSEnabledKey=@"com.wechat.enhance.bubble_style.enabled";
static NSString *const CSRadiusKey=@"com.wechat.enhance.bubble_style.corner_radius";
static NSArray<NSString *> *CSPaletteNames(void) {
    return @[@"sender_light_color",@"receiver_light_color",@"sender_dark_color",@"receiver_dark_color"];
}
static NSString *CSColorKey(NSInteger palette, NSString *component) {
    return [NSString stringWithFormat:@"com.wechat.enhance.bubble_style.%@.%@",CSPaletteNames()[palette],component];
}
static UIColor *CSUIColor(CSBubbleRGBA c) { return [UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha]; }

@interface CSBubbleStyleSettingsViewController () <UIColorPickerViewControllerDelegate>
@property(nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property(nonatomic, strong) NSArray<NSString *> *footers;
@property(nonatomic, strong) NSArray<CSSettingItem *> *colorItems;
@property(nonatomic, strong) NSArray<CSSettingItem *> *textColorItems;
@property(nonatomic, strong) CSBubbleStyleConfiguration *style;
@property(nonatomic, strong) CSBubbleStylePreview *preview;
@property(nonatomic) NSInteger currentColorType;
@property(nonatomic) BOOL currentColorIsText;
@end

@implementation CSBubbleStyleSettingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];self.title=@"气泡样式";
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    self.tableView.separatorInset=UIEdgeInsetsMake(0,54,0,0);
    [CSSettingTableViewCell registerToTableView:self.tableView];
    self.preview=[[CSBubbleStylePreview alloc] initWithFrame:CGRectMake(0,0,self.tableView.bounds.size.width,274)];
    [self setupData];
}
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated];[self setupData];[self.tableView reloadData]; }
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.tableView.tableHeaderView && self.preview.frame.size.width!=self.tableView.bounds.size.width) {
        self.preview.frame=CGRectMake(0,0,self.tableView.bounds.size.width,274);self.tableView.tableHeaderView=self.preview;
    }
}
- (void)publishChanges {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
        (__bridge CFStringRef)CSMessageMergeSettingsNotification,NULL,NULL,true);
    [self setupData];[self.tableView reloadData];
}
- (void)setupData {
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    self.style=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:0];
    CSMessageMergeConfiguration *merge=[[CSMessageMergeConfiguration alloc] initWithDefaults:defaults];
    self.preview.configuration=self.style;self.preview.mergesMessages=merge.enabled;[self.preview refresh];
    self.tableView.tableHeaderView=self.style.enabled ? self.preview : nil;
    NSMutableArray *sections=[NSMutableArray array],*footers=[NSMutableArray array];
    __weak typeof(self) weakSelf=self;
    CSSettingItem *enabled=[CSSettingItem switchItemWithTitle:@"启用气泡样式" iconName:@"bubble.left.and.bubble.right.fill"
        iconColor:UIColor.systemBlueColor switchValue:self.style.enabled valueChangedBlock:^(BOOL on) {
            [defaults setBool:on forKey:CSEnabledKey];[weakSelf publishChanges];
        }];
    NSMutableArray *appearance=[NSMutableArray arrayWithObject:enabled];
    if (self.style.enabled) {
        CSSettingItem *kind=[CSSettingItem itemWithTitle:@"选择气泡样式" iconName:@"rectangle.stack" iconColor:UIColor.systemPurpleColor detail:CSBubbleStyleKindTitle(self.style.kind)];
        kind.actionBlock=^{ [weakSelf showChoice:@"选择气泡样式" message:@"经典圆角保持四角圆润；连续圆角在合并消息的连接处使用直角，发送方在右侧、接收方在左侧，单条保持四角圆角。" titles:@[@"经典圆角",@"连续圆角"] values:@[@0,@1] key:CSBubbleStyleKindKey selected:weakSelf.style.kind]; };
        CSSettingItem *radius=[CSSettingItem itemWithTitle:@"圆角大小设置" iconName:@"slider.horizontal.3" iconColor:UIColor.systemOrangeColor detail:[NSString stringWithFormat:@"%.0f",self.style.radius]];
        radius.actionBlock=^{ [weakSelf showCornerRadiusPicker]; };
        [appearance addObjectsFromArray:@[kind,radius]];
    }
    [sections addObject:[CSSettingSection sectionWithHeader:@"气泡外观" items:appearance]];
    [footers addObject:self.style.enabled ? @"应用于普通文本、引用文本、语音及语音/视频通话记录。连续圆角的连接处为直角，其余圆角跟随圆角大小设置。" : @"开启后可选择样式、圆角和颜色。下方连续消息合并可独立使用。"];
    NSMutableArray *colors=[NSMutableArray array];
    if (self.style.enabled) {
        NSArray *titles=@[@"浅色 · 发送方",@"浅色 · 接收方",@"深色 · 发送方",@"深色 · 接收方"];
        for (NSInteger i=0;i<4;i++) {
            CSSettingItem *item=[CSSettingItem itemWithTitle:titles[i] iconName:@"paintpalette.fill" iconColor:UIColor.systemTealColor detail:nil];
            item.actionBlock=^{ [weakSelf showColorPicker:i title:titles[i] text:NO]; };[colors addObject:item];
        }
        [sections addObject:[CSSettingSection sectionWithHeader:@"气泡背景色" items:colors]];
        [footers addObject:@"点击色块设置底色和透明度。顶部浅色/深色切换仅用于预览。"];
    }
    self.colorItems=colors;
    NSMutableArray *textColors=[NSMutableArray array];
    if (self.style.enabled) {
        NSArray *titles=@[@"浅色 · 发送方字体",@"浅色 · 接收方字体",@"深色 · 发送方字体",@"深色 · 接收方字体"];
        for (NSInteger i=0;i<4;i++) {
            BOOL custom=[self.style textColorForOutgoing:i%2==0 dark:i>=2 color:NULL];
            CSSettingItem *item=[CSSettingItem itemWithTitle:titles[i] iconName:@"textformat" iconColor:UIColor.systemIndigoColor detail:custom ? @"自定义" : @"跟随微信"];
            item.actionBlock=^{ [weakSelf showTextColorOptions:i title:titles[i]]; };[textColors addObject:item];
        }
        [sections addObject:[CSSettingSection sectionWithHeader:@"字体颜色" items:textColors]];
        [footers addObject:@"分别设置发送方和接收方的文字颜色，或恢复跟随微信。适用于气泡正文、引用正文、语音时长和通话文字；链接保留原生样式。"];
    }
    self.textColorItems=textColors;
    CSSettingItem *mergeEnabled=[CSSettingItem switchItemWithTitle:@"连续消息合并" iconName:@"rectangle.3.group" iconColor:UIColor.systemPurpleColor
        switchValue:merge.enabled valueChangedBlock:^(BOOL on) { [defaults setBool:on forKey:CSMessageMergeEnabledKey];[weakSelf publishChanges]; }];
    NSMutableArray *mergeItems=[NSMutableArray arrayWithObject:mergeEnabled];
    if (merge.enabled) {
        NSArray *scopes=@[@"群聊",@"私聊",@"全部会话"];
        CSSettingItem *scope=[CSSettingItem itemWithTitle:@"合并生效范围" iconName:@"scope" iconColor:UIColor.systemTealColor detail:scopes[merge.scope-1]];
        scope.actionBlock=^{ [weakSelf showChoice:@"合并生效范围" message:nil titles:scopes values:@[@1,@2,@3] key:CSMessageMergeScopeKey selected:merge.scope]; };
        CSSettingItem *spacing=[CSSettingItem itemWithTitle:@"组内间距设置" iconName:@"arrow.up.and.down" iconColor:UIColor.systemOrangeColor detail:CSMessageSpacingModeTitle(merge.spacingMode)];
        spacing.actionBlock=^{ [weakSelf showChoice:@"组内间距" message:@"正常保留原生间距；紧密以组内 2pt（逻辑点）为目标，头像、昵称及附加内容仍保留必要空间。连续圆角在两种间距下均可使用。" titles:@[@"正常",@"紧密"] values:@[@0,@1] key:CSMessageMergeSpacingModeKey selected:merge.spacingMode]; };
        CSSettingItem *avatar=[CSSettingItem itemWithTitle:@"头像保留位置" iconName:@"person.crop.circle" iconColor:UIColor.systemIndigoColor detail:merge.avatarPosition==2 ? @"首条消息" : @"末条消息"];
        avatar.actionBlock=^{ [weakSelf showChoice:@"头像保留位置" message:@"选择一组连续消息保留哪一条的头像。连续圆角的首条和末条按消息顺序确定。" titles:@[@"首条消息",@"末条消息"] values:@[@2,@1] key:CSMessageMergeAvatarKey selected:merge.avatarPosition]; };
        [mergeItems addObjectsFromArray:@[scope,spacing,avatar]];
    }
    [sections addObject:[CSSettingSection sectionWithHeader:@"连续消息" items:mergeItems]];
    [footers addObject:merge.enabled ? @"同一个人的连续消息保留一处头像。选择连续圆角后，连接处的圆角随组内位置变化；通话记录保持独立气泡。" : @"关闭时每条消息独立显示。开启后可设置范围、间距和头像位置，并启用连续圆角的连接效果。"];
    if (self.style.enabled) {
        CSSettingItem *reset=[CSSettingItem actionItemWithTitle:@"恢复气泡颜色" iconName:@"arrow.counterclockwise" iconColor:UIColor.systemRedColor];
        reset.actionBlock=^{ [weakSelf resetToDefaultColors]; };
        CSSettingItem *resetText=[CSSettingItem actionItemWithTitle:@"恢复字体颜色" iconName:@"textformat" iconColor:UIColor.systemRedColor];
        resetText.actionBlock=^{ [weakSelf resetTextColors]; };
        [sections addObject:[CSSettingSection sectionWithHeader:@"恢复默认" items:@[reset,resetText]]];
        [footers addObject:@"背景色与字体颜色分别恢复，保留样式、圆角和合并设置。"];
    }
    self.sections=sections;self.footers=footers;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.sections.count; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.sections[section].items.count; }
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { return self.sections[section].header; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section { return self.footers[section]; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    CSSettingItem *item=self.sections[path.section].items[path.row];
    CSSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CSSettingTableViewCell.reuseIdentifier forIndexPath:path];
    [cell configureWithItem:item];
    NSUInteger palette=[self.colorItems indexOfObjectIdenticalTo:item];
    NSUInteger textPalette=[self.textColorItems indexOfObjectIdenticalTo:item];
    CSBubbleRGBA textColor;
    BOOL hasText=textPalette!=NSNotFound && [self.style textColorForOutgoing:textPalette%2==0 dark:textPalette>=2 color:&textColor];
    if (palette!=NSNotFound || hasText) {
        UIView *swatch=[[UIView alloc] initWithFrame:CGRectMake(0,0,28,28)];swatch.layer.cornerRadius=14;
        swatch.layer.borderWidth=1;swatch.layer.borderColor=UIColor.separatorColor.CGColor;
        swatch.backgroundColor=CSUIColor(hasText ? textColor : [self.style colorForOutgoing:palette%2==0 dark:palette>=2]);
        cell.accessoryView=swatch;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];CSSettingItem *item=self.sections[path.section].items[path.row];
    if (item.actionBlock) item.actionBlock();
}
- (void)showChoice:(NSString *)title message:(NSString *)message titles:(NSArray<NSString *> *)titles values:(NSArray<NSNumber *> *)values key:(NSString *)key selected:(NSInteger)selected {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf=self;
    for (NSUInteger i=0;i<titles.count;i++) {
        NSInteger value=values[i].integerValue;NSString *label=[titles[i] stringByAppendingString:value==selected ? @" ✓" : @""];
        [alert addAction:[UIAlertAction actionWithTitle:label style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
            [NSUserDefaults.standardUserDefaults setInteger:value forKey:key];[weakSelf publishChanges];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)showCornerRadiusPicker {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"圆角大小设置" message:@"范围 1–30，默认 16。较短的气泡会自动限制圆角，保证内容完整。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) { field.keyboardType=UIKeyboardTypeDecimalPad;field.text=[NSString stringWithFormat:@"%.0f",self.style.radius]; }];
    __weak typeof(self) weakSelf=self;
    __weak UIAlertController *weakAlert=alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        double radius=weakAlert.textFields.firstObject.text.doubleValue;radius=isfinite(radius) ? MAX(1,MIN(30,radius)) : 16;
        [NSUserDefaults.standardUserDefaults setDouble:radius forKey:CSRadiusKey];[weakSelf publishChanges];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)showTextColorOptions:(NSInteger)palette title:(NSString *)title {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:@"选择自定义颜色，或使用微信原生文字颜色。" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf=self;
    [alert addAction:[UIAlertAction actionWithTitle:@"自定义颜色" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        [weakSelf showColorPicker:palette title:title text:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"跟随微信" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        for (NSString *component in @[@"red",@"green",@"blue"]) [NSUserDefaults.standardUserDefaults removeObjectForKey:CSBubbleTextColorPreferenceKey(palette,component)];
        [weakSelf publishChanges];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)showColorPicker:(NSInteger)palette title:(NSString *)title text:(BOOL)isText {
    self.currentColorType=palette;self.currentColorIsText=isText;
    UIColorPickerViewController *picker=[UIColorPickerViewController new];picker.delegate=self;picker.title=title;picker.supportsAlpha=!isText;
    CSBubbleRGBA color;
    if (!isText) color=[self.style colorForOutgoing:palette%2==0 dark:palette>=2];
    else if (![self.style textColorForOutgoing:palette%2==0 dark:palette>=2 color:&color])
        color=palette==3 ? (CSBubbleRGBA){1,1,1,1} : (CSBubbleRGBA){0,0,0,1};
    picker.selectedColor=CSUIColor(color);
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)picker {
    self.preview.draftPalette=self.currentColorType;self.preview.draftIsText=self.currentColorIsText;
    self.preview.draftColor=picker.selectedColor;[self.preview refresh];
}
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)picker {
    CGFloat r=0,g=0,b=0,a=0;
    if ([picker.selectedColor getRed:&r green:&g blue:&b alpha:&a]) {
        NSArray *names=@[@"red",@"green",@"blue",@"alpha"],*values=@[@(r),@(g),@(b),@(a)];
        NSUInteger count=self.currentColorIsText ? 3 : 4;
        for (NSUInteger i=0;i<count;i++) [NSUserDefaults.standardUserDefaults setDouble:[values[i] doubleValue]
            forKey:self.currentColorIsText ? CSBubbleTextColorPreferenceKey(self.currentColorType,names[i]) : CSColorKey(self.currentColorType,names[i])];
    }
    self.preview.draftColor=nil;[self publishChanges];
}
- (void)resetToDefaultColors {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"恢复默认背景色" message:@"恢复四组气泡背景色，保留字体颜色、所选样式、圆角和合并设置。" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf=self;
    [alert addAction:[UIAlertAction actionWithTitle:@"恢复" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action) {
        for (NSInteger i=0;i<4;i++) for (NSString *component in @[@"red",@"green",@"blue",@"alpha"]) [NSUserDefaults.standardUserDefaults removeObjectForKey:CSColorKey(i,component)];
        [weakSelf publishChanges];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)resetTextColors {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"字体恢复跟随微信" message:@"清除四组自定义字体颜色，恢复微信原生文字颜色。" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf=self;
    [alert addAction:[UIAlertAction actionWithTitle:@"恢复" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action) {
        for (NSUInteger i=0;i<4;i++) for (NSString *component in @[@"red",@"green",@"blue"])
            [NSUserDefaults.standardUserDefaults removeObjectForKey:CSBubbleTextColorPreferenceKey(i,component)];
        [weakSelf publishChanges];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
