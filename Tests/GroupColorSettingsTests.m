#import <Foundation/Foundation.h>

enum { UIUserInterfaceStyleLight=1, UIUserInterfaceStyleDark=2 };
@interface UITraitCollection : NSObject
@property(nonatomic) NSInteger userInterfaceStyle;
@end
@implementation UITraitCollection @end

// A secure-codable color double keeps this replay independent of UIKit while
// exercising the production archive/read and explicit trait resolution paths.
@interface UIColor : NSObject <NSSecureCoding>
@property(nonatomic,copy) NSString *token,*darkToken;
+ (instancetype)color:(NSString *)token dark:(NSString *)darkToken;
+ (instancetype)colorWithRed:(double)r green:(double)g blue:(double)b alpha:(double)a;
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)traits;
@end
@implementation UIColor
+ (BOOL)supportsSecureCoding { return YES; }
+ (instancetype)color:(NSString *)token dark:(NSString *)darkToken { UIColor *c=[self new];c.token=token;c.darkToken=darkToken;return c; }
+ (instancetype)colorWithRed:(double)r green:(double)g blue:(double)b alpha:(double)a { (void)r;(void)g;(void)b;(void)a;return [self color:@"default-green" dark:nil]; }
- (instancetype)initWithCoder:(NSCoder *)coder { if ((self=[super init])) { _token=[coder decodeObjectOfClass:NSString.class forKey:@"token"];_darkToken=[coder decodeObjectOfClass:NSString.class forKey:@"dark"]; } return self; }
- (void)encodeWithCoder:(NSCoder *)coder { [coder encodeObject:self.token forKey:@"token"];[coder encodeObject:self.darkToken forKey:@"dark"]; }
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)traits { return [UIColor color:traits.userInterfaceStyle==UIUserInterfaceStyleDark ? self.darkToken ?: self.token : self.token dark:nil]; }
@end

@interface TestTable : NSObject
@property(nonatomic) NSUInteger reloads;
- (void)reloadData;
@end
@implementation TestTable
- (void)reloadData { self.reloads++; }
@end
@interface TestController : NSObject
@property(nonatomic,strong) UITraitCollection *traitCollection;
@property(nonatomic) BOOL isViewLoaded;
@property(nonatomic,strong) id presentedController;
@property(nonatomic) NSUInteger superTraitCalls;
- (void)traitCollectionDidChange:(UITraitCollection *)previous;
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(void (^)(void))completion;
@end
@implementation TestController
- (void)traitCollectionDidChange:(UITraitCollection *)previous { (void)previous;self.superTraitCalls++; }
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(void (^)(void))completion { (void)animated;self.presentedController=controller;if(completion)completion(); }
@end
@interface UIColorPickerViewController : NSObject
@property(nonatomic,weak) id delegate;
@property(nonatomic,strong) UIColor *selectedColor;
@property(nonatomic,copy) NSString *title;
@property(nonatomic) BOOL supportsAlpha;
@end
@implementation UIColorPickerViewController @end
@interface CSGroupColorPicker : UIColorPickerViewController
@property(nonatomic,copy) NSString *preferenceKey;
@property(nonatomic) NSInteger colorType;
@end
@implementation CSGroupColorPicker @end
@interface WEColorPreviewView : NSObject
@property(nonatomic,strong) UIColor *previewColor;
@end
@implementation WEColorPreviewView @end
@interface CSSettingItem : NSObject
@property(nonatomic,strong) UIColor *iconColor;
@property(nonatomic,copy) void (^actionBlock)(void);
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)iconName iconColor:(UIColor *)color detail:(NSString *)detail;
@end
@implementation CSSettingItem
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)iconName iconColor:(UIColor *)color detail:(NSString *)detail { (void)title;(void)iconName;(void)detail;CSSettingItem *item=[self new];item.iconColor=color;return item; }
@end

static NSUserDefaults *colorDefaults;
@interface ColorDefaults : NSUserDefaults @end
@implementation ColorDefaults
+ (NSUserDefaults *)standardUserDefaults { return colorDefaults; }
@end
static NSString *const kIndicatorColorKey=@"com.wechat.enhance.chat_group.indicator_color";
static NSString *const kIndicatorColorDarkKey=@"com.wechat.enhance.chat_group.indicator_color_dark";
static NSString *const kSelectedTextColorKey=@"com.wechat.enhance.chat_group.selected_text_color";
static NSString *const kSelectedTextColorDarkKey=@"com.wechat.enhance.chat_group.selected_text_color_dark";
@interface CSChatGroupSettingsViewController : TestController
@property(nonatomic,strong) id groupPreferences;
@property(nonatomic,strong) TestTable *tableView;
@property(nonatomic,strong) WEColorPreviewView *indicatorColorPreview,*selectedTextColorPreview;
@property(nonatomic,strong) CSSettingItem *indicatorItem,*selectedItem;
@property(nonatomic) NSInteger currentColorType;
@property(nonatomic,weak) CSGroupColorPicker *activeColorPicker;
@property(nonatomic) NSUInteger setups,notifications;
- (void)setupData;
- (void)reloadChatGroupSettings;
- (UIColor *)currentIndicatorColor;
- (UIColor *)currentSelectedTextColor;
- (NSString *)colorPreferenceKeyForType:(NSInteger)type;
- (void)showColorPicker;
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)picker;
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)picker;
- (void)saveColor:(UIColor *)color forKey:(NSString *)key;
@end
@implementation CSChatGroupSettingsViewController
#define NSUserDefaults ColorDefaults
#include "GroupColorSettingsBodies.h"
#undef NSUserDefaults
- (void)setupData {
    self.setups++;
    __weak typeof(self) weakSelf=self;
#include "GroupColorSettingsRows.h"
    self.indicatorItem=indicatorColorItem; self.selectedItem=selectedTextColorItem;
}
- (void)reloadChatGroupSettings { self.notifications++; }
@end

static NSUInteger checks,failures;
static void Check(BOOL ok,NSString *message) { checks++;if(!ok){failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String);} }
static UITraitCollection *Traits(NSInteger style) { UITraitCollection *traits=[UITraitCollection new];traits.userInterfaceStyle=style;return traits; }
static CSChatGroupSettingsViewController *Fixture(NSInteger style) {
    CSChatGroupSettingsViewController *vc=[CSChatGroupSettingsViewController new];vc.traitCollection=Traits(style);vc.isViewLoaded=YES;
    vc.groupPreferences=[NSObject new];vc.tableView=[TestTable new];vc.indicatorColorPreview=[WEColorPreviewView new];vc.selectedTextColorPreview=[WEColorPreviewView new];return vc;
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"com.wechat.improve.tests.group-colors." stringByAppendingString:NSUUID.UUID.UUIDString];
    colorDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    CSChatGroupSettingsViewController *vc=Fixture(UIUserInterfaceStyleLight);
    [vc saveColor:[UIColor color:@"light-text" dark:nil] forKey:kSelectedTextColorKey];
    [vc saveColor:[UIColor color:@"dark-text" dark:nil] forKey:kSelectedTextColorDarkKey];
    [vc saveColor:[UIColor color:@"light-indicator" dark:nil] forKey:kIndicatorColorKey];
    [vc saveColor:[UIColor color:@"dark-indicator" dark:nil] forKey:kIndicatorColorDarkKey];
    [vc setupData];
    Check([vc.selectedItem.iconColor.token isEqual:@"light-text"] && [vc.selectedTextColorPreview.previewColor.token isEqual:@"light-text"],@"light selected-text row uses the saved light color for icon and swatch");
    UITraitCollection *previous=vc.traitCollection;vc.traitCollection=Traits(UIUserInterfaceStyleDark);
    [vc traitCollectionDidChange:previous];
    Check(vc.tableView.reloads==1 && vc.setups==2 && vc.superTraitCalls==1,@"appearance change rebuilds the cached rows and reloads the visible table");
    Check([vc.selectedItem.iconColor.token isEqual:@"dark-text"] && [vc.selectedTextColorPreview.previewColor.token isEqual:@"dark-text"],@"dark selected-text row refreshes both icon and swatch");
    Check([vc.indicatorItem.iconColor.token isEqual:@"dark-indicator"] && [vc.indicatorColorPreview.previewColor.token isEqual:@"dark-indicator"],@"indicator row follows the same mode-specific refresh");
    [vc traitCollectionDidChange:Traits(UIUserInterfaceStyleDark)];
    Check(vc.tableView.reloads==1,@"unrelated trait changes do not rebuild settings");
    [vc saveColor:[UIColor color:@"dynamic-light" dark:@"dynamic-dark"] forKey:kSelectedTextColorDarkKey];
    Check([[vc currentSelectedTextColor].token isEqual:@"dynamic-dark"],@"archived dynamic color is resolved against the settings controller's current dark traits");

    vc.currentColorType=1;[vc showColorPicker];CSGroupColorPicker *picker=vc.presentedController;
    Check([picker isKindOfClass:CSGroupColorPicker.class] && [picker.preferenceKey isEqual:kSelectedTextColorDarkKey] && picker.colorType==1 && [picker.selectedColor.token isEqual:@"dynamic-dark"],@"dark text picker binds its preference key and starts with the actual resolved color");
    picker.selectedColor=[UIColor color:@"chosen-dark" dark:nil];[vc colorPickerViewControllerDidSelectColor:picker];
    Check([vc.selectedTextColorPreview.previewColor.token isEqual:@"chosen-dark"],@"active picker previews its matching appearance");
    previous=vc.traitCollection;vc.traitCollection=Traits(UIUserInterfaceStyleLight);[vc traitCollectionDidChange:previous];
    vc.currentColorType=0;[vc colorPickerViewControllerDidSelectColor:picker];
    Check([vc.selectedTextColorPreview.previewColor.token isEqual:@"light-text"],@"a dark picker callback cannot paint its value onto the light-mode row");
    [vc colorPickerViewControllerDidFinish:picker];
    Check([[vc currentSelectedTextColor].token isEqual:@"light-text"] && [[vc currentIndicatorColor].token isEqual:@"light-indicator"],@"finishing after a mode change preserves existing light values and does not retarget to another color setting");
    vc.traitCollection=Traits(UIUserInterfaceStyleDark);
    Check([[vc currentSelectedTextColor].token isEqual:@"chosen-dark"] && !vc.activeColorPicker,@"picker completion saves the opening dark preference and releases its active context");
    NSUInteger notices=vc.notifications;picker.selectedColor=[UIColor color:@"stale" dark:nil];[vc colorPickerViewControllerDidFinish:picker];
    Check(vc.notifications==notices && [[vc currentSelectedTextColor].token isEqual:@"chosen-dark"],@"late callbacks from a finished picker cannot overwrite saved colors");
    [colorDefaults setObject:@"invalid" forKey:kSelectedTextColorDarkKey];
    Check([[vc currentSelectedTextColor].token isEqual:@"default-green"],@"invalid saved color retains the existing default fallback");
    [colorDefaults removePersistentDomainForName:suite];
    printf("Group color settings: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
