// Executes extracted production controller methods. UIKit presentation and the
// preference boundary are fixtures; preference persistence has its own suite.
#import <Foundation/Foundation.h>
#import <math.h>

static NSUInteger checks;
static void Check(BOOL condition, NSString *message) {
    checks++;
    if (!condition) { NSLog(@"FAIL: %@", message); exit(1); }
}

@interface UIColor : NSObject
@property(nonatomic) CGFloat red, green, blue, alpha;
@property(nonatomic) BOOL readable;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
- (UIColor *)resolvedColorWithTraitCollection:(id)traits;
@end
@implementation UIColor
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *color=[self new]; color.red=red; color.green=green; color.blue=blue; color.alpha=alpha; color.readable=YES; return color;
}
- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    if (!self.readable) return NO;
    if (red) *red=self.red; if (green) *green=self.green; if (blue) *blue=self.blue; if (alpha) *alpha=self.alpha;
    return YES;
}
- (UIColor *)resolvedColorWithTraitCollection:(id)traits { return self; }
@end

typedef NS_ENUM(NSInteger, UIApplicationState) { UIApplicationStateActive, UIApplicationStateInactive, UIApplicationStateBackground };
@interface UIApplication : NSObject
@property(nonatomic) UIApplicationState applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; static dispatch_once_t once; dispatch_once(&once, ^{ app=[self new]; }); return app; }
@end

@interface UIView : NSObject
@property(nonatomic,strong) id window;
@end
@implementation UIView @end

@protocol UIViewControllerTransitionCoordinatorContext <NSObject> @end
@protocol UIViewControllerTransitionCoordinator <NSObject>
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion;
@end
@interface ColorTransition : NSObject <UIViewControllerTransitionCoordinator>
@property(nonatomic) BOOL accepts;
@property(nonatomic) NSUInteger attempts;
@property(nonatomic,copy) void (^completion)(id<UIViewControllerTransitionCoordinatorContext>);
@end
@implementation ColorTransition
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext>))completion {
    self.attempts++; if (self.accepts) self.completion=completion; return self.accepts;
}
@end

@class UINavigationController;
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *viewIfLoaded;
@property(nonatomic,strong) UINavigationController *navigationController;
@property(nonatomic,strong) UIViewController *presentedViewController;
@property(nonatomic,weak) UIViewController *presentingViewController;
@property(nonatomic,strong) id<UIViewControllerTransitionCoordinator> transitionCoordinator;
@property(nonatomic,strong) id traitCollection;
@property(nonatomic,copy) NSString *title;
@property(nonatomic) NSUInteger presentations, dismissals;
@property(nonatomic) BOOL deferDismiss;
@property(nonatomic,copy) void (^dismissCompletion)(void);
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)completeDismiss;
@end
@interface UINavigationController : UIViewController
@property(nonatomic,weak) UIViewController *topViewController;
@end
@implementation UINavigationController @end
@implementation UIViewController
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion {
    self.presentations++; self.presentedViewController=controller; controller.presentingViewController=self; if (completion) completion();
}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    self.dismissals++; self.dismissCompletion=completion; if (!self.deferDismiss) [self completeDismiss];
}
- (void)completeDismiss {
    if (self.presentingViewController.presentedViewController==self) self.presentingViewController.presentedViewController=nil;
    void (^completion)(void)=self.dismissCompletion; self.dismissCompletion=nil; if (completion) completion();
}
@end

typedef NS_ENUM(NSInteger, UIAlertActionStyle) { UIAlertActionStyleDefault, UIAlertActionStyleCancel, UIAlertActionStyleDestructive };
typedef NS_ENUM(NSInteger, UIAlertControllerStyle) { UIAlertControllerStyleActionSheet, UIAlertControllerStyleAlert };
@interface UIAlertAction : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic) UIAlertActionStyle style;
@property(nonatomic,copy) void (^handler)(UIAlertAction *action);
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler {
    UIAlertAction *action=[self new]; action.title=title; action.style=style; action.handler=handler; return action;
}
@end
@interface UIAlertController : UIViewController
@property(nonatomic,strong) NSMutableArray<UIAlertAction *> *actions;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
- (void)addAction:(UIAlertAction *)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style {
    UIAlertController *sheet=[self new]; sheet.title=title; sheet.actions=[NSMutableArray new]; return sheet;
}
- (void)addAction:(UIAlertAction *)action { [self.actions addObject:action]; }
@end

@interface UIColorPickerViewController : UIViewController
@property(nonatomic,weak) id delegate;
@property(nonatomic) BOOL supportsAlpha;
@property(nonatomic,strong) UIColor *selectedColor;
@end
@implementation UIColorPickerViewController @end

@interface NSIndexPath (ColorRows)
@property(nonatomic,readonly) NSInteger row;
@end
@implementation NSIndexPath (ColorRows)
- (NSInteger)row { return (NSInteger)[self indexAtPosition:0]; }
@end

static NSString *backgroundHex, *textHex, *iconHex, *backgroundStyle;
static NSString *backgroundImage;
static double backgroundOpacity;
static NSUInteger backgroundWrites, textWrites, iconWrites;
static NSString * const CSQuickPanelBackgroundStyleColor=@"color";
@interface CSQuickPanelPreferences : NSObject
+ (NSString *)backgroundColorHex;
+ (NSString *)textColorHex;
+ (NSString *)iconColorHex;
+ (void)setBackgroundColorHex:(NSString *)value;
+ (void)setBackgroundStyle:(NSString *)value;
+ (void)setTextColorHex:(NSString *)value;
+ (void)setIconColorHex:(NSString *)value;
+ (void)resetForegroundColors;
@end
@implementation CSQuickPanelPreferences
+ (NSString *)backgroundColorHex { return backgroundHex; }
+ (NSString *)textColorHex { return textHex; }
+ (NSString *)iconColorHex { return iconHex; }
+ (void)setBackgroundColorHex:(NSString *)value { backgroundHex=[value copy]; backgroundWrites++; }
+ (void)setBackgroundStyle:(NSString *)value { backgroundStyle=[value copy]; backgroundWrites++; }
+ (void)setTextColorHex:(NSString *)value { textHex=[value copy]; textWrites++; }
+ (void)setIconColorHex:(NSString *)value { iconHex=[value copy]; iconWrites++; }
+ (void)resetForegroundColors { [self setTextColorHex:nil]; [self setIconColorHex:nil]; }
@end

static UIColor *ColorFromHex(NSString *hex) {
    unsigned int rgb=0; [[NSScanner scannerWithString:[hex substringFromIndex:1]] scanHexInt:&rgb];
    return [UIColor colorWithRed:((rgb>>16)&255)/255.0 green:((rgb>>8)&255)/255.0 blue:(rgb&255)/255.0 alpha:1];
}
@interface CSQuickPanelAppearance : NSObject
+ (UIColor *)primaryTextColorForLightContent:(BOOL)light;
+ (UIColor *)iconColor;
@end
@implementation CSQuickPanelAppearance
+ (UIColor *)primaryTextColorForLightContent:(BOOL)light { return ColorFromHex(textHex ?: (light ? @"#FFFFFF" : @"#000000")); }
+ (UIColor *)iconColor { return ColorFromHex(iconHex ?: @"#05944A"); }
@end
@interface CSQuickPanelContentView : NSObject
@property(nonatomic) BOOL backgroundUsesLightContent;
@end
@implementation CSQuickPanelContentView @end

static NSString *lastAnnouncement;
static const NSUInteger UIAccessibilityAnnouncementNotification=1;
static void UIAccessibilityPostNotification(NSUInteger notification, NSString *value) { lastAnnouncement=value; }

#import "QuickPanelColorSettingsDeclarations.h"

@interface CSQuickPanelSettingsViewController : UIViewController
@property(nonatomic,strong) CSQuickPanelContentView *previewContent;
@property(nonatomic) NSUInteger imageSelectionGeneration, reloads;
@property(nonatomic) BOOL imageImporting;
@property(nonatomic,weak) CSQuickPanelColorPicker *activeColorPicker;
- (void)reloadSettings;
- (void)anchorSheet:(UIAlertController *)sheet atIndexPath:(NSIndexPath *)path;
@end
@implementation CSQuickPanelSettingsViewController
- (void)reloadSettings { self.reloads++; }
- (void)anchorSheet:(UIAlertController *)sheet atIndexPath:(NSIndexPath *)path { [self presentViewController:sheet animated:YES completion:nil]; }
#import "QuickPanelColorSettingsUnderTest.h"
@end

static CSQuickPanelSettingsViewController *Controller(void) {
    CSQuickPanelSettingsViewController *controller=[CSQuickPanelSettingsViewController new];
    controller.navigationController=[UINavigationController new]; controller.navigationController.topViewController=controller;
    controller.viewIfLoaded=[UIView new]; controller.viewIfLoaded.window=[NSObject new];
    controller.previewContent=[CSQuickPanelContentView new];
    controller.imageSelectionGeneration=37; controller.imageImporting=YES;
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    return controller;
}
static void ResetPreferences(void) {
    backgroundHex=@"#123456"; backgroundStyle=@"image"; backgroundImage=@"owned-image"; backgroundOpacity=.37;
    textHex=@"#AABBCC"; iconHex=@"#112233"; backgroundWrites=0; textWrites=0; iconWrites=0;
}
static void CheckBackgroundPreserved(NSString *message) {
    Check([backgroundHex isEqual:@"#123456"] && [backgroundStyle isEqual:@"image"] &&
          [backgroundImage isEqual:@"owned-image"] && backgroundOpacity==.37 && backgroundWrites==0,message);
}
static CSQuickPanelColorPicker *Open(CSQuickPanelSettingsViewController *controller, CSQuickPanelColorTarget target) {
    controller.presentedViewController=nil;
    [controller showColorPickerForTarget:target];
    return (CSQuickPanelColorPicker *)controller.presentedViewController;
}
static BOOL SameRGB(UIColor *a, UIColor *b) {
    return fabs(a.red-b.red)<.00001 && fabs(a.green-b.green)<.00001 && fabs(a.blue-b.blue)<.00001;
}

int main(void) {
    @autoreleasepool {
        ResetPreferences();
        CSQuickPanelSettingsViewController *controller=Controller();
        CSQuickPanelColorPicker *text=Open(controller,CSQuickPanelColorTargetText);
        Check(text.colorTarget==CSQuickPanelColorTargetText && controller.activeColorPicker==text,@"text picker owns its target and active identity");
        Check([text.title isEqual:@"面板字体颜色"] && !text.supportsAlpha && text.delegate==controller,@"text picker title/delegate/no-alpha");
        Check(SameRGB(text.selectedColor,ColorFromHex(@"#AABBCC")),@"text picker seeds custom text color");
        Check(controller.imageSelectionGeneration==37 && controller.imageImporting,@"text picker preserves pending background import");
        text.selectedColor=ColorFromHex(@"#2050D0"); [controller colorPickerViewControllerDidSelectColor:text];
        Check([textHex isEqual:@"#2050D0"] && [iconHex isEqual:@"#112233"] && textWrites==1 && iconWrites==0,@"text select writes only text");
        CheckBackgroundPreserved(@"text color leaves all background values untouched");

        CSQuickPanelColorPicker *icon=Open(controller,CSQuickPanelColorTargetIcon);
        Check(icon.colorTarget==CSQuickPanelColorTargetIcon && [icon.title isEqual:@"面板图标颜色"],@"icon picker has independent target/title");
        Check(SameRGB(icon.selectedColor,ColorFromHex(@"#112233")) && !icon.supportsAlpha,@"icon picker seeds custom icon and disallows alpha");
        Check(controller.imageSelectionGeneration==37 && controller.imageImporting,@"icon picker preserves pending background import");
        icon.selectedColor=ColorFromHex(@"#F0A025"); [controller colorPickerViewControllerDidSelectColor:icon];
        Check([iconHex isEqual:@"#F0A025"] && [textHex isEqual:@"#2050D0"] && iconWrites==1,@"icon select writes only icon");
        CheckBackgroundPreserved(@"icon color leaves all background values untouched");

        text.selectedColor=ColorFromHex(@"#FFFFFF"); [controller colorPickerViewControllerDidSelectColor:text];
        Check([textHex isEqual:@"#2050D0"] && [iconHex isEqual:@"#F0A025"],@"late replaced text callback is ignored");
        [controller colorPickerViewControllerDidFinish:text];
        Check(controller.activeColorPicker==icon && [textHex isEqual:@"#2050D0"],@"late text finish cannot clear active icon or write");
        UIColorPickerViewController *foreign=[UIColorPickerViewController new]; foreign.selectedColor=ColorFromHex(@"#FFFFFF");
        [controller colorPickerViewControllerDidSelectColor:foreign]; [controller colorPickerViewControllerDidFinish:foreign];
        Check(controller.activeColorPicker==icon && iconWrites==1 && textWrites==1,@"foreign picker callbacks have no effect");
        controller.activeColorPicker=(CSQuickPanelColorPicker *)foreign;
        [controller colorPickerViewControllerDidSelectColor:foreign];
        Check(iconWrites==1 && textWrites==1 && backgroundWrites==0,@"even an identity-matching foreign picker cannot bypass target type check");
        controller.activeColorPicker=icon;
        icon.selectedColor=ColorFromHex(@"#332211"); [controller colorPickerViewControllerDidFinish:icon];
        Check([iconHex isEqual:@"#332211"] && !controller.activeColorPicker,@"finish commits correct target then clears active identity");
        icon.selectedColor=ColorFromHex(@"#FFFFFF"); [controller colorPickerViewControllerDidSelectColor:icon];
        Check([iconHex isEqual:@"#332211"],@"post-finish callback is ignored");

        CSQuickPanelColorPicker *background=Open(controller,CSQuickPanelColorTargetBackground);
        Check(background.colorTarget==CSQuickPanelColorTargetBackground && [background.title isEqual:@"面板背景颜色"],@"background target remains independent");
        Check(SameRGB(background.selectedColor,ColorFromHex(@"#123456")),@"background picker seeds existing background");
        Check(controller.imageSelectionGeneration==38 && !controller.imageImporting,@"only background color picker cancels pending background import");
        background.selectedColor=ColorFromHex(@"#71C20A"); [controller colorPickerViewControllerDidSelectColor:background];
        Check([backgroundHex isEqual:@"#71C20A"] && [backgroundStyle isEqual:@"color"] && backgroundWrites==2,@"background picker still sets background color and mode");
        Check([textHex isEqual:@"#2050D0"] && [iconHex isEqual:@"#332211"],@"background picker leaves both foreground colors alone");
        text=Open(controller,CSQuickPanelColorTargetText);
        background.selectedColor=ColorFromHex(@"#FFFFFF"); [controller colorPickerViewControllerDidSelectColor:background];
        [controller colorPickerViewControllerDidFinish:background];
        Check([backgroundHex isEqual:@"#71C20A"] && [backgroundStyle isEqual:@"color"] && backgroundWrites==2,@"replaced background picker cannot rewrite background during foreground edit");
        Check(controller.activeColorPicker==text,@"stale background finish does not clear active foreground picker");

        ResetPreferences(); controller=Controller();
        textHex=nil; iconHex=nil;
        text=Open(controller,CSQuickPanelColorTargetText);
        Check(SameRGB(text.selectedColor,ColorFromHex(@"#000000")),@"default text initial color follows light background");
        controller.previewContent.backgroundUsesLightContent=YES;
        text=Open(controller,CSQuickPanelColorTargetText);
        Check(SameRGB(text.selectedColor,ColorFromHex(@"#FFFFFF")),@"default text initial color follows dark background");
        icon=Open(controller,CSQuickPanelColorTargetIcon);
        Check(SameRGB(icon.selectedColor,ColorFromHex(@"#05944A")),@"default icon initial color comes from effective accent");
        icon.selectedColor=[UIColor colorWithRed:2 green:-1 blue:.5 alpha:1]; [controller colorPickerViewControllerDidSelectColor:icon];
        Check([iconHex isEqual:@"#FF0080"],@"picker RGB clamps and rounds to canonical hex");
        NSUInteger writes=iconWrites;
        icon.selectedColor=[UIColor colorWithRed:NAN green:0 blue:0 alpha:1]; [controller colorPickerViewControllerDidSelectColor:icon];
        Check(iconWrites==writes,@"non-finite RGB is rejected");
        icon.selectedColor=[UIColor new]; [controller colorPickerViewControllerDidSelectColor:icon];
        Check(iconWrites==writes,@"unconvertible color is rejected");

        ResetPreferences(); controller=Controller();
        [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:0]];
        UIAlertController *sheet=(UIAlertController *)controller.presentedViewController;
        Check([sheet.title isEqual:@"字体颜色"] && sheet.actions.count==3,@"text action sheet exposes default/custom/cancel");
        Check([sheet.actions[0].title isEqual:@"自动适配背景"] && [sheet.actions[1].title isEqual:@"更换自定义颜色"],@"custom text state uses correct choices");
        sheet.actions[0].handler(sheet.actions[0]);
        Check(!textHex && [iconHex isEqual:@"#112233"] && controller.reloads==1,@"text default resets text only and refreshes");
        CheckBackgroundPreserved(@"single text default preserves background");
        Check(controller.imageSelectionGeneration==37 && controller.imageImporting,@"single text default preserves pending import");
        controller.presentedViewController=nil;
        [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:0]];
        sheet=(UIAlertController *)controller.presentedViewController;
        Check([sheet.actions[0].title isEqual:@"自动适配背景 ✓"] && [sheet.actions[1].title isEqual:@"自定义颜色"],@"default text action sheet marks current default");
        sheet.actions[2].handler ? sheet.actions[2].handler(sheet.actions[2]) : (void)0;
        Check(!textHex && [iconHex isEqual:@"#112233"],@"cancel does not mutate preferences");
        controller.presentedViewController=nil;
        [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:1]];
        sheet=(UIAlertController *)controller.presentedViewController;
        Check([sheet.title isEqual:@"图标颜色"] && [sheet.actions[0].title isEqual:@"跟随界面调色"],@"icon sheet identifies theme following default");
        sheet.actions[0].handler(sheet.actions[0]);
        Check(!iconHex && !textHex && controller.reloads==2,@"icon default resets only icon and refreshes");
        CheckBackgroundPreserved(@"single icon default preserves background");

        ResetPreferences(); controller=Controller(); [controller restoreDefaultForegroundColors];
        Check(!textHex && !iconHex && controller.reloads==1,@"restore defaults clears exactly both foreground colors");
        CheckBackgroundPreserved(@"restore foreground defaults preserves background mode/color/image/opacity");
        Check(controller.imageSelectionGeneration==37 && controller.imageImporting,@"restore foreground defaults preserves pending image import");
        Check([lastAnnouncement isEqual:@"已恢复默认面板配色"],@"restore publishes accessibility announcement");

        // UIKit may retain an interactively dismissed picker briefly. A new
        // default/reset intent must invalidate its identity before callbacks.
        ResetPreferences(); controller=Controller(); text=Open(controller,CSQuickPanelColorTargetText);
        controller.presentedViewController=nil;
        [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:0]];
        sheet=(UIAlertController *)controller.presentedViewController;
        Check(!controller.activeColorPicker,@"opening new foreground options invalidates retained old picker");
        sheet.actions[0].handler(sheet.actions[0]);
        text.selectedColor=ColorFromHex(@"#FF0000"); [controller colorPickerViewControllerDidSelectColor:text];
        [controller colorPickerViewControllerDidFinish:text];
        Check(!textHex && [iconHex isEqual:@"#112233"],@"late text picker callbacks cannot undo single text default");
        CheckBackgroundPreserved(@"single default with late picker callbacks preserves background");
        ResetPreferences(); controller=Controller(); icon=Open(controller,CSQuickPanelColorTargetIcon);
        controller.presentedViewController=nil;
        [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:1]];
        sheet=(UIAlertController *)controller.presentedViewController; sheet.actions[0].handler(sheet.actions[0]);
        icon.selectedColor=ColorFromHex(@"#FF0000"); [controller colorPickerViewControllerDidSelectColor:icon];
        [controller colorPickerViewControllerDidFinish:icon];
        Check(!iconHex && [textHex isEqual:@"#AABBCC"],@"late icon picker callbacks cannot undo theme-following default");
        ResetPreferences(); controller=Controller(); text=Open(controller,CSQuickPanelColorTargetText);
        controller.presentedViewController=nil; [controller restoreDefaultForegroundColors];
        Check(!controller.activeColorPicker,@"restoring defaults invalidates retained picker identity");
        text.selectedColor=ColorFromHex(@"#FF0000"); [controller colorPickerViewControllerDidSelectColor:text];
        [controller colorPickerViewControllerDidFinish:text];
        Check(!textHex && !iconHex,@"late picker callbacks cannot undo foreground reset");
        CheckBackgroundPreserved(@"foreground reset with late picker callbacks preserves background");

        // A picker must wait for the action sheet to finish dismissing.
        ResetPreferences(); controller=Controller();
        [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:1]];
        sheet=(UIAlertController *)controller.presentedViewController; sheet.deferDismiss=YES;
        sheet.actions[1].handler(sheet.actions[1]);
        Check(controller.presentedViewController==sheet && !controller.activeColorPicker && sheet.dismissals==1,@"custom action waits for sheet dismissal");
        [sheet completeDismiss];
        icon=(CSQuickPanelColorPicker *)controller.presentedViewController;
        Check([icon isKindOfClass:CSQuickPanelColorPicker.class] && icon.colorTarget==CSQuickPanelColorTargetIcon,@"dismiss completion presents correct target");
        Check(controller.imageSelectionGeneration==37 && controller.imageImporting,@"delayed foreground presentation preserves import");

        controller=Controller(); [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:0]];
        sheet=(UIAlertController *)controller.presentedViewController;
        ColorTransition *transition=[ColorTransition new]; transition.accepts=YES; sheet.transitionCoordinator=transition;
        sheet.actions[1].handler(sheet.actions[1]);
        Check(transition.attempts==1 && transition.completion && !controller.activeColorPicker && !sheet.dismissals,@"active sheet transition is observed before presenting picker");
        controller.presentedViewController=nil;
        transition.completion(nil);
        Check(controller.activeColorPicker.colorTarget==CSQuickPanelColorTargetText,@"transition completion continues correct picker target");

        controller=Controller(); [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:1]];
        sheet=(UIAlertController *)controller.presentedViewController;
        transition=[ColorTransition new]; sheet.transitionCoordinator=transition;
        sheet.actions[1].handler(sheet.actions[1]);
        Check(transition.attempts==1 && sheet.dismissals==1 && controller.activeColorPicker.colorTarget==CSQuickPanelColorTargetIcon,@"rejected transition registration falls back to dismissal completion");

        controller=Controller(); controller.viewIfLoaded.window=nil;
        [controller showColorPickerForTarget:CSQuickPanelColorTargetText];
        Check(!controller.presentations && !controller.activeColorPicker,@"off-window controller cannot present picker");
        controller=Controller(); UIViewController *otherTop=[UIViewController new]; controller.navigationController.topViewController=otherTop;
        [controller showColorPickerForTarget:CSQuickPanelColorTargetIcon];
        Check(!controller.presentations && !controller.activeColorPicker,@"non-top controller cannot present picker");
        controller=Controller(); UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;
        [controller showColorPickerForTarget:CSQuickPanelColorTargetIcon];
        Check(!controller.presentations && !controller.activeColorPicker,@"inactive application cannot present picker");
        controller=Controller(); UIViewController *foreignModal=[UIViewController new]; controller.presentedViewController=foreignModal;
        [controller showColorPickerForTarget:CSQuickPanelColorTargetText];
        Check(controller.presentedViewController==foreignModal && !controller.activeColorPicker && !foreignModal.dismissals,@"foreign modal is preserved and blocks picker");
        controller=Controller(); [controller showForegroundColorOptions:[NSIndexPath indexPathWithIndex:0]];
        sheet=(UIAlertController *)controller.presentedViewController; sheet.deferDismiss=YES;
        sheet.actions[1].handler(sheet.actions[1]); controller.viewIfLoaded.window=nil; [sheet completeDismiss];
        Check(!controller.activeColorPicker && !controller.presentedViewController,@"deferred presentation rechecks source visibility");

        ResetPreferences(); controller=Controller(); [controller showBackgroundColorPicker];
        Check(controller.activeColorPicker.colorTarget==CSQuickPanelColorTargetBackground && controller.imageSelectionGeneration==38,@"existing background entry delegates to unified target-safe presenter");
        printf("Quick panel color settings: %lu checks passed (real controller methods).\n",(unsigned long)checks);
    }
    return 0;
}
