#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static NSUInteger checks;
#define CHECK(...) do {checks++;if(!(__VA_ARGS__)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__);exit(1);}}while(0)

typedef NS_ENUM(NSInteger,UIAlertActionStyle){UIAlertActionStyleDefault,UIAlertActionStyleCancel};
typedef NS_ENUM(NSInteger,UIAlertControllerStyle){UIAlertControllerStyleActionSheet,UIAlertControllerStyleAlert};
enum {UITableViewCellSeparatorStyleSingleLine,UITableViewCellStyleDefault,UITableViewCellSelectionStyleNone,UITableViewStyleInsetGrouped,UIDatePickerModeTime,UIDatePickerStyleCompact,UIControlEventValueChanged,UIBarButtonItemStylePlain,UIBarButtonItemStyleDone,UIModalPresentationPageSheet};
typedef struct {double top,left,bottom,right;} UIEdgeInsets;
static UIEdgeInsets UIEdgeInsetsMake(double t,double l,double b,double r){return (UIEdgeInsets){t,l,b,r};}

@interface UIColor : NSObject
+ (instancetype)systemGreenColor;
+ (instancetype)systemBlueColor;
+ (instancetype)systemOrangeColor;
+ (instancetype)systemGroupedBackgroundColor;
@end
@implementation UIColor
+ (instancetype)systemGreenColor{return [self new];}
+ (instancetype)systemBlueColor{return [self new];}
+ (instancetype)systemOrangeColor{return [self new];}
+ (instancetype)systemGroupedBackgroundColor{return [self new];}
@end
@interface UIView : NSObject
@property NSRect bounds;
@property double alpha;
@end
@implementation UIView @end
@interface UILabel : UIView
@property NSString *text;
@end
@implementation UILabel @end
@interface UIControl : UIView
@property BOOL enabled;
@property NSString *accessibilityLabel;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(NSInteger)events;
@end
@implementation UIControl
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(NSInteger)events{(void)target;(void)action;(void)events;}
@end
@interface UISwitch : UIControl
@property BOOL on;
@end
@implementation UISwitch @end
@interface UIDatePicker : UIControl
@property NSDate *date;
@property NSCalendar *calendar;
@property NSTimeZone *timeZone;
@property NSInteger datePickerMode,preferredDatePickerStyle,minuteInterval;
@end
@implementation UIDatePicker @end
@interface UIBarButtonItem : NSObject
@property NSString *title;
- (instancetype)initWithTitle:(NSString *)title style:(NSInteger)style target:(id)target action:(SEL)action;
@end
@implementation UIBarButtonItem
- (instancetype)initWithTitle:(NSString *)title style:(NSInteger)style target:(id)target action:(SEL)action{(void)style;(void)target;(void)action;if((self=[super init]))_title=title;return self;}
@end
@interface UINavigationItem : NSObject
@property UIBarButtonItem *leftBarButtonItem,*rightBarButtonItem;
@end
@implementation UINavigationItem @end
@interface UIPopoverPresentationController : NSObject
@property UIView *sourceView;
@property NSRect sourceRect;
@end
@implementation UIPopoverPresentationController @end
@interface UISheetPresentationControllerDetent : NSObject
+ (instancetype)mediumDetent;
+ (instancetype)largeDetent;
@end
@implementation UISheetPresentationControllerDetent
+ (instancetype)mediumDetent{return [self new];}
+ (instancetype)largeDetent{return [self new];}
@end
@interface UISheetPresentationController : NSObject
@property NSArray *detents;
@property BOOL prefersGrabberVisible;
@end
@implementation UISheetPresentationController @end
@interface UITableViewCell : UIView
@property UILabel *textLabel;
@property UIView *accessoryView;
@property NSInteger selectionStyle;
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier;
@end
@implementation UITableViewCell
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier{(void)style;(void)identifier;if((self=[super init]))_textLabel=[UILabel new];return self;}
@end
@interface UITableView : UIView
@property NSInteger separatorStyle;
@property UIEdgeInsets separatorInset;
@property UIColor *backgroundColor;
@property NSUInteger reloads,deselections;
@property UITableViewCell *anchor;
- (void)reloadData;
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)path;
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated;
@end
@implementation UITableView
- (void)reloadData{CHECK(NSThread.isMainThread);self.reloads++;}
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier{(void)identifier;return nil;}
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)path{CHECK(path.length==2);return self.anchor;}
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated{(void)path;(void)animated;self.deselections++;}
@end
@interface NSIndexPath (SettingsUI)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@property(readonly) NSInteger section,row;
@end
@implementation NSIndexPath (SettingsUI)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section{NSUInteger values[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:values length:2];}
- (NSInteger)section{return [self indexAtPosition:0];}
- (NSInteger)row{return [self indexAtPosition:1];}
@end
@interface UIViewController : NSObject
@property NSString *title;
@property UIView *view;
@property UINavigationItem *navigationItem;
@property UISheetPresentationController *sheetPresentationController;
@property NSInteger modalPresentationStyle;
@property id presentedViewController;
@property NSUInteger presentations,dismissals;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(dispatch_block_t)completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(dispatch_block_t)completion;
@end
@implementation UIViewController
- (instancetype)init{if((self=[super init])){_view=[UIView new];_navigationItem=[UINavigationItem new];_sheetPresentationController=[UISheetPresentationController new];}return self;}
- (void)viewDidLoad{}
- (void)viewWillAppear:(BOOL)animated{(void)animated;}
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(dispatch_block_t)completion{(void)animated;CHECK(NSThread.isMainThread);self.presentedViewController=controller;self.presentations++;if(completion)completion();}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(dispatch_block_t)completion{(void)animated;CHECK(NSThread.isMainThread);self.dismissals++;if(completion)completion();}
@end
@interface UITableViewController : UIViewController
@property UITableView *tableView;
- (instancetype)initWithStyle:(NSInteger)style;
@end
@implementation UITableViewController
- (instancetype)init{if((self=[super init])){_tableView=[UITableView new];_tableView.anchor=[UITableViewCell new];}return self;}
- (instancetype)initWithStyle:(NSInteger)style{(void)style;return [self init];}
@end
@interface UINavigationController : UIViewController
@property UIViewController *rootViewController;
- (instancetype)initWithRootViewController:(UIViewController *)controller;
@end
@implementation UINavigationController
- (instancetype)initWithRootViewController:(UIViewController *)controller{if((self=[super init]))_rootViewController=controller;return self;}
@end
@interface UIAlertAction : NSObject
@property NSString *title;
@property UIAlertActionStyle style;
@property(copy) void (^handler)(UIAlertAction *);
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler;
- (void)activate;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler{UIAlertAction *a=[self new];a.title=title;a.style=style;a.handler=handler;return a;}
- (void)activate{if(self.handler)self.handler(self);}
@end
@interface UIAlertController : UIViewController
@property NSString *message;
@property UIAlertControllerStyle preferredStyle;
@property NSMutableArray<UIAlertAction *> *actions;
@property UIPopoverPresentationController *popoverPresentationController;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
- (void)addAction:(UIAlertAction *)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style{UIAlertController *a=[self new];a.title=title;a.message=message;a.preferredStyle=style;a.actions=[NSMutableArray array];a.popoverPresentationController=[UIPopoverPresentationController new];return a;}
- (void)addAction:(UIAlertAction *)action{[self.actions addObject:action];}
@end
@interface CSSettingItem : NSObject
@property NSString *title,*detail;
@property BOOL switchValue;
@property(copy) void (^switchValueChanged)(BOOL);
@property(copy) void (^actionBlock)(void);
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)icon iconColor:(UIColor *)color detail:(NSString *)detail;
+ (instancetype)actionItemWithTitle:(NSString *)title iconName:(NSString *)icon iconColor:(UIColor *)color;
+ (instancetype)switchItemWithTitle:(NSString *)title iconName:(NSString *)icon iconColor:(UIColor *)color switchValue:(BOOL)value valueChangedBlock:(void (^)(BOOL))block;
@end
@implementation CSSettingItem
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)icon iconColor:(UIColor *)color detail:(NSString *)detail{(void)icon;(void)color;CSSettingItem *i=[self new];i.title=title;i.detail=detail;return i;}
+ (instancetype)actionItemWithTitle:(NSString *)title iconName:(NSString *)icon iconColor:(UIColor *)color{return [self itemWithTitle:title iconName:icon iconColor:color detail:nil];}
+ (instancetype)switchItemWithTitle:(NSString *)title iconName:(NSString *)icon iconColor:(UIColor *)color switchValue:(BOOL)value valueChangedBlock:(void (^)(BOOL))block{CSSettingItem *i=[self itemWithTitle:title iconName:icon iconColor:color detail:nil];i.switchValue=value;i.switchValueChanged=block;return i;}
@end
@interface CSSettingSection : NSObject
@property NSString *header;
@property NSArray<CSSettingItem *> *items;
+ (instancetype)sectionWithHeader:(NSString *)header items:(NSArray *)items;
@end
@implementation CSSettingSection
+ (instancetype)sectionWithHeader:(NSString *)header items:(NSArray *)items{CSSettingSection *s=[self new];s.header=header;s.items=items;return s;}
@end
@interface CSSettingTableViewCell : UITableViewCell
+ (NSString *)reuseIdentifier;
+ (void)registerToTableView:(UITableView *)table;
- (void)configureWithItem:(CSSettingItem *)item;
@end
@implementation CSSettingTableViewCell
+ (NSString *)reuseIdentifier{return @"settings";}
+ (void)registerToTableView:(UITableView *)table{(void)table;}
- (void)configureWithItem:(CSSettingItem *)item{(void)item;}
@end

static NSNotificationName const CSBackgroundRunStateChangedNotification=@"RecordingBackgroundRunStateChanged";
@interface CSBackgroundRunManager : NSObject
@property(nonatomic) BOOL enabled,usesLegacyPolicy,supportsBackgroundAudio;
@property NSTimeInterval remainingDuration;
@property(copy) NSDictionary *policy;
@property NSString *statusText,*lastBackgroundResult;
@property NSUInteger saves,enabledWrites,starts,reloads;
@property NSError *saveFailure;
@property NSDictionary *attemptedPolicy;
+ (instancetype)sharedManager;
- (void)start;
- (void)reloadSettings;
- (BOOL)savePolicy:(NSDictionary *)policy error:(NSError **)error;
@end
static CSBackgroundRunManager *manager;
@implementation CSBackgroundRunManager
+ (instancetype)sharedManager{return manager;}
- (void)setEnabled:(BOOL)enabled{self.enabledWrites++;_enabled=enabled;}
- (void)start{self.starts++;}
- (void)reloadSettings{self.reloads++;}
- (BOOL)savePolicy:(NSDictionary *)policy error:(NSError **)error{CHECK(NSThread.isMainThread);self.saves++;self.attemptedPolicy=[policy copy];if(self.saveFailure){if(error)*error=self.saveFailure;return NO;}self.policy=policy;self.usesLegacyPolicy=NO;return YES;}
@end
static NSUInteger descriptions;
static NSString *CSBackgroundRunPolicyWindowDescription(NSDictionary *policy){CHECK(policy==manager.policy);descriptions++;return @"recorded policy window";}
@interface CSBackgroundRunViewController : UITableViewController @end
#include "BackgroundRunSettingsUIUnderTest.h"

static NSDictionary *Policy(BOOL legacy){return @{@"version":@1,@"allDay":@YES,@"startMinute":@480,@"endMinute":@1380,@"maxMinutes":legacy?@0:@30,@"energySaving":legacy?@NO:@YES};}
static CSBackgroundRunViewController *Controller(BOOL legacy){
    manager=[CSBackgroundRunManager new];manager.policy=Policy(legacy);manager.usesLegacyPolicy=legacy;manager.remainingDuration=-1;manager.supportsBackgroundAudio=YES;manager.statusText=@"recorded current state";manager.lastBackgroundResult=@"recorded prior result";
    CSBackgroundRunViewController *c=[CSBackgroundRunViewController new];[c viewDidLoad];[c viewWillAppear:NO];return c;
}
static CSSettingItem *Item(CSBackgroundRunViewController *c,NSInteger section,NSInteger row){return c.sections[section].items[row];}
static UIAlertAction *Action(UIAlertController *alert,NSString *title){for(UIAlertAction *a in alert.actions)if([a.title isEqual:title])return a;CHECK(NO);return nil;}
static NSDate *Time(NSInteger minute){return [NSDate dateWithTimeIntervalSinceReferenceDate:minute*60];}
static CSBackgroundRunWindowEditor *OpenEditor(CSBackgroundRunViewController *c){
    Item(c,1,0).actionBlock();UINavigationController *nav=c.presentedViewController;
    CHECK([nav isKindOfClass:UINavigationController.class] && nav.modalPresentationStyle==UIModalPresentationPageSheet);
    CHECK(nav.sheetPresentationController.detents.count==2 && nav.sheetPresentationController.prefersGrabberVisible);
    CSBackgroundRunWindowEditor *e=(id)nav.rootViewController;CHECK([e isKindOfClass:CSBackgroundRunWindowEditor.class]);[e viewDidLoad];return e;
}
static void LegacyAndLifecycle(void){
    for(NSNumber *legacy in @[@YES,@NO]){
        CSBackgroundRunViewController *c=Controller(legacy.boolValue);NSDictionary *original=manager.policy;
        CHECK(!manager.saves && !manager.enabledWrites && manager.starts==1 && manager.reloads==1);
        CHECK(c.sections.count==4 && [c numberOfSectionsInTableView:c.tableView]==4);
        CHECK([c tableView:c.tableView numberOfRowsInSection:1]==3 && [c tableView:c.tableView numberOfRowsInSection:2]==4);
        CHECK([Item(c,1,0).detail isEqual:@"recorded policy window"] && descriptions>0);
        CHECK([Item(c,2,0).detail isEqual:manager.statusText] && [Item(c,2,2).detail isEqual:manager.lastBackgroundResult]);
        CHECK([Item(c,1,1).detail isEqual:legacy.boolValue?@"不限":@"30 分钟"]);
        CHECK(Item(c,1,2).switchValue==!legacy.boolValue);
        NSString *footer=[c tableView:c.tableView titleForFooterInSection:1];CHECK([footer containsString:legacy.boolValue?@"沿用原设置":@"不会重置起点"]);
        Item(c,0,0).switchValueChanged(YES);CHECK(manager.enabledWrites==1 && manager.enabled && !manager.saves);
        Item(c,0,0).switchValueChanged(NO);CHECK(manager.enabledWrites==2 && !manager.enabled && !manager.saves);
        CHECK(manager.policy==original && manager.usesLegacyPolicy==legacy.boolValue);
        NSUInteger reloads=c.tableView.reloads;[NSNotificationCenter.defaultCenter postNotificationName:CSBackgroundRunStateChangedNotification object:manager];CHECK(c.tableView.reloads==reloads+1);
    }
}
static void AtomicWindowDraft(void){
    CSBackgroundRunViewController *c=Controller(YES);NSDictionary *original=manager.policy;
    CSBackgroundRunWindowEditor *e=OpenEditor(c);CHECK(!manager.saves && manager.policy==original && manager.usesLegacyPolicy);
    CHECK(e.allDaySwitch.on && !e.startPicker.enabled && !e.endPicker.enabled && e.startPicker.minuteInterval==1);
    CHECK([e tableView:e.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryView==e.allDaySwitch);
    CHECK([e tableView:e.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].accessoryView==e.startPicker);
    CHECK([e tableView:e.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]].accessoryView==e.endPicker);
    e.allDaySwitch.on=NO;[e allDayChanged:e.allDaySwitch];CHECK(e.startPicker.enabled && e.endPicker.enabled && e.startPicker.alpha==1 && !manager.saves);
    e.startPicker.date=Time(1320);e.endPicker.date=Time(420);[e cancel];CHECK(e.dismissals==1 && !manager.saves && manager.policy==original);
    e=OpenEditor(c);e.allDaySwitch.on=NO;e.startPicker.date=Time(480);e.endPicker.date=Time(480);[e save];
    CHECK(!manager.saves && !e.dismissals && [e.presentedViewController isKindOfClass:UIAlertController.class]);
    CHECK([[(UIAlertController *)e.presentedViewController message] containsString:@"不能相同"] && manager.policy==original);
    // Both edited values reach the manager in one call; unrelated latest fields survive an open sheet.
    NSMutableDictionary *latest=[manager.policy mutableCopy];latest[@"maxMinutes"]=@60;latest[@"energySaving"]=@YES;manager.policy=latest;
    e.startPicker.date=Time(1320);e.endPicker.date=Time(420);[e save];
    CHECK(manager.saves==1 && e.dismissals==1 && !manager.usesLegacyPolicy);
    CHECK([manager.policy[@"allDay"] isEqual:@NO] && [manager.policy[@"startMinute"] isEqual:@1320] && [manager.policy[@"endMinute"] isEqual:@420]);
    CHECK([manager.policy[@"maxMinutes"] isEqual:@60] && [manager.policy[@"energySaving"] isEqual:@YES] && [manager.policy[@"version"] isEqual:@1]);
    // All-day permits equal draft picker values; it uses an explicit flag.
    e=OpenEditor(c);e.allDaySwitch.on=YES;e.startPicker.date=e.endPicker.date=Time(0);[e save];CHECK(manager.saves==2 && e.dismissals==1 && [manager.policy[@"allDay"] boolValue]);
}
static void SaveFailures(void){
    CSBackgroundRunViewController *c=Controller(NO);NSDictionary *original=manager.policy;
    manager.saveFailure=[NSError errorWithDomain:@"fixture" code:1 userInfo:@{NSLocalizedDescriptionKey:@"recorded persistence failure"}];
    Item(c,1,2).switchValueChanged(NO);CHECK(manager.saves==1 && manager.policy==original && Item(c,1,2).switchValue);
    CHECK([[(UIAlertController *)c.presentedViewController message] isEqual:@"recorded persistence failure"]);
    CSBackgroundRunWindowEditor *e=OpenEditor(c);e.allDaySwitch.on=NO;e.startPicker.date=Time(60);e.endPicker.date=Time(120);[e save];
    CHECK(manager.saves==2 && !e.dismissals && manager.policy==original);
    CHECK([[(UIAlertController *)e.presentedViewController message] isEqual:@"recorded persistence failure"]);
    manager.saveFailure=nil;[e save];CHECK(manager.saves==3 && e.dismissals==1 && [manager.policy[@"startMinute"] isEqual:@60]);
    e=[CSBackgroundRunWindowEditor new];e.startPicker=[UIDatePicker new];e.endPicker=[UIDatePicker new];e.allDaySwitch=[UISwitch new];e.startPicker.date=e.endPicker.date=Time(0);[e save];
    CHECK(!e.dismissals && [e.presentedViewController isKindOfClass:UIAlertController.class]);
}
static void DurationAndEnergy(void){
    for(NSNumber *minutes in @[@5,@15,@30,@60,@120,@0]){
        CSBackgroundRunViewController *c=Controller(YES);Item(c,1,1).actionBlock();UIAlertController *menu=c.presentedViewController;
        CHECK(menu.preferredStyle==UIAlertControllerStyleActionSheet && menu.actions.count==7);
        CHECK(menu.popoverPresentationController.sourceView==c.tableView.anchor);
        [Action(menu,@"取消") activate];CHECK(!manager.saves && manager.usesLegacyPolicy);
        NSMutableDictionary *latest=[manager.policy mutableCopy];latest[@"startMinute"]=@60;latest[@"endMinute"]=@120;manager.policy=latest;
        NSString *title=minutes.integerValue?[NSString stringWithFormat:@"%ld 分钟",(long)minutes.integerValue]:@"不限";
        [Action(menu,title) activate];CHECK(manager.saves==1 && !manager.usesLegacyPolicy && [manager.policy[@"maxMinutes"] isEqual:minutes]);
        CHECK([manager.policy[@"startMinute"] isEqual:@60] && [manager.policy[@"endMinute"] isEqual:@120] && ![manager.policy[@"energySaving"] boolValue]);
        Item(c,1,2).switchValueChanged(YES);CHECK(manager.saves==2 && [manager.policy[@"energySaving"] boolValue] && [manager.policy[@"maxMinutes"] isEqual:minutes]);
    }
    CSBackgroundRunViewController *c=Controller(NO);c.tableView.anchor=nil;[c chooseDuration];CHECK(((UIAlertController *)c.presentedViewController).popoverPresentationController.sourceView==c.view);
}
static void RemainingAndHelp(void){
    CSBackgroundRunViewController *c=Controller(NO);
    NSArray *values=@[@(-1),@0,@1,@60,@61,@1799];NSArray *texts=@[@"首次成功启动后计时",@"本次时长已用完",@"约 1 分钟",@"约 1 分钟",@"约 2 分钟",@"约 30 分钟"];
    for(NSUInteger i=0;i<values.count;i++){manager.remainingDuration=[values[i] doubleValue];[c rebuildSections];CHECK([Item(c,2,1).detail isEqual:texts[i]]);}
    manager.policy=Policy(YES);manager.remainingDuration=20;[c rebuildSections];CHECK([Item(c,2,1).detail isEqual:@"不限"]);
    manager.supportsBackgroundAudio=NO;[c rebuildSections];CHECK([Item(c,2,3).detail containsString:@"未声明"]);
    NSUInteger writes=manager.saves;[c tableView:c.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    UIAlertController *help=c.presentedViewController;CHECK(c.tableView.deselections==1 && help.preferredStyle==UIAlertControllerStyleAlert);
    CHECK([help.message containsString:@"不能定时唤醒"] && [help.message containsString:@"AI 自动回复和定时任务"] && [help.message containsString:@"不会关闭它们"]);
    CHECK(manager.saves==writes && !manager.enabledWrites);
    NSUInteger reloads=c.tableView.reloads;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{[c stateChanged:nil];});
    for(NSUInteger i=0;i<100 && c.tableView.reloads==reloads;i++)[NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.001]];
    CHECK(c.tableView.reloads==reloads+1);
}
static NSDate *fixedSettingsDate;
@interface NSDate (BackgroundSettingsClock)
+ (instancetype)backgroundSettingsDate;
@end
@implementation NSDate (BackgroundSettingsClock)
+ (instancetype)backgroundSettingsDate{return fixedSettingsDate?:[self backgroundSettingsDate];}
@end
static void DailyMinutesSurviveDST(void){
    NSTimeZone *originalZone=NSTimeZone.defaultTimeZone;
    Method realDate=class_getClassMethod(NSDate.class,@selector(date));
    Method testDate=class_getClassMethod(NSDate.class,@selector(backgroundSettingsDate));
    method_exchangeImplementations(realDate,testDate);
    @try {
        for(NSDictionary *fixture in @[
            @{@"zone":@"America/New_York",@"month":@3,@"day":@8},
            @{@"zone":@"Europe/Berlin",@"month":@3,@"day":@29}
        ])for(NSNumber *crossMidnight in @[@NO,@YES])for(NSNumber *changeZone in @[@NO,@YES]){
            NSTimeZone *zone=[NSTimeZone timeZoneWithName:fixture[@"zone"]];CHECK(zone);
            [NSTimeZone setDefaultTimeZone:zone];
            NSCalendar *local=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];local.timeZone=zone;
            NSDateComponents *day=[NSDateComponents new];day.year=2026;day.month=[fixture[@"month"] integerValue];day.day=[fixture[@"day"] integerValue];day.hour=12;
            fixedSettingsDate=[local dateFromComponents:day];CHECK(fixedSettingsDate);
            CHECK([NSCalendar.currentCalendar.timeZone.name isEqual:zone.name]);
            // 02:30 does not exist on either local date. The editor must retain
            // the stored daily minute, whether it is the start or the end.
            NSNumber *start=crossMidnight.boolValue?@1320:@150,*end=crossMidnight.boolValue?@150:@240;
            CSBackgroundRunViewController *c=Controller(NO);NSMutableDictionary *policy=[manager.policy mutableCopy];
            policy[@"allDay"]=@NO;policy[@"startMinute"]=start;policy[@"endMinute"]=end;manager.policy=policy;
            CSBackgroundRunWindowEditor *editor=OpenEditor(c);CHECK(!manager.saves);
            if(changeZone.boolValue)[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Pacific/Auckland"]];
            [editor save];
            CHECK(manager.saves==1 && editor.dismissals==1);
            CHECK([manager.policy[@"startMinute"] isEqual:start] && [manager.policy[@"endMinute"] isEqual:end]);
            CHECK([editor.startPicker.calendar.calendarIdentifier isEqual:NSCalendarIdentifierGregorian]);
            CHECK([editor.startPicker.timeZone secondsFromGMTForDate:editor.startPicker.date]==0);
            CHECK([editor.endPicker.timeZone secondsFromGMTForDate:editor.endPicker.date]==0);
            CHECK([editor.startPicker.calendar.timeZone secondsFromGMTForDate:editor.startPicker.date]==0);
            NSCalendar *utc=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];utc.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:0];
            NSDateComponents *reference=[utc components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:editor.startPicker.date];
            CHECK(reference.year==2001 && reference.month==1 && reference.day==1);
        }
    } @finally {
        fixedSettingsDate=nil;
        [NSTimeZone setDefaultTimeZone:originalZone];
        method_exchangeImplementations(realDate,testDate);
    }
}
int main(void){@autoreleasepool{
    LegacyAndLifecycle();AtomicWindowDraft();SaveFailures();DurationAndEnergy();RemainingAndHelp();DailyMinutesSurviveDST();
    printf("Background settings UI: %lu checks passed (entire real controllers; recording UI and Manager)\n",(unsigned long)checks);
}return 0;}
