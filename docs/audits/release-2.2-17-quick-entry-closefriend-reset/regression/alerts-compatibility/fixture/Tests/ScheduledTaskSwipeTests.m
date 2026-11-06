#import <Foundation/Foundation.h>
#import "CSScheduledTaskStore.h"
#import "CSCloseFriendAutomationProjection.h"

static NSUInteger checks, epoch=1, fixtureNumber, alerts;
static NSString *lastAlert;
static CSCloseFriendSnapshot *privacy;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { NSLog(@"FAIL %d: %s",__LINE__,#__VA_ARGS__);exit(1); } } while (0)
static NSUInteger CSBackupAccountEpoch(void) {return epoch;}
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return privacy;}
static void CSTaskAlert(id controller,NSString *message) {(void)controller;alerts++;lastAlert=message;}

// File-local UIKit stand-ins only; the action bodies below come from production.
@interface UIView : NSObject @end
@implementation UIView @end
@interface UITableView : UIView @end
@implementation UITableView @end
@interface UIColor : NSObject
+ (id)systemGreenColor;
+ (id)systemOrangeColor;
@end
@implementation UIColor
+ (id)systemGreenColor {return @"green";}
+ (id)systemOrangeColor {return @"orange";}
@end
typedef NS_ENUM(NSInteger,UIContextualActionStyle) {UIContextualActionStyleNormal,UIContextualActionStyleDestructive};
typedef NS_ENUM(NSInteger,UITableViewCellEditingStyle) {UITableViewCellEditingStyleNone,UITableViewCellEditingStyleDelete};
@interface UIContextualAction : NSObject
@property UIContextualActionStyle style;
@property(copy) NSString *title;
@property id backgroundColor;
@property(copy) void (^handler)(UIContextualAction *,UIView *,void(^)(BOOL));
+ (instancetype)contextualActionWithStyle:(UIContextualActionStyle)style title:(NSString *)title handler:(void(^)(UIContextualAction *,UIView *,void(^)(BOOL)))handler;
@end
@implementation UIContextualAction
+ (instancetype)contextualActionWithStyle:(UIContextualActionStyle)style title:(NSString *)title handler:(void(^)(UIContextualAction *,UIView *,void(^)(BOOL)))handler {UIContextualAction *action=[self new];action.style=style;action.title=title;action.handler=handler;return action;}
@end
@interface UISwipeActionsConfiguration : NSObject
@property(copy) NSArray<UIContextualAction *> *actions;
@property BOOL performsFirstActionWithFullSwipe;
+ (instancetype)configurationWithActions:(NSArray *)actions;
@end
@implementation UISwipeActionsConfiguration
+ (instancetype)configurationWithActions:(NSArray *)actions {UISwipeActionsConfiguration *configuration=[self new];configuration.actions=actions;configuration.performsFirstActionWithFullSwipe=YES;return configuration;}
@end
@interface NSIndexPath (ScheduledSwipe)
@property(readonly) NSInteger section,row;
@end
@implementation NSIndexPath (ScheduledSwipe)
- (NSInteger)section {return (NSInteger)[self indexAtPosition:0];}
- (NSInteger)row {return (NSInteger)[self indexAtPosition:1];}
@end
@interface TestNavigation : NSObject
@property(weak) id topViewController;
@end
@implementation TestNavigation @end

@interface CSScheduledTaskManager : NSObject
@property CSScheduledTaskStore *store;
@property BOOL savingConfiguration,failSave,failRemove;
@property NSUInteger saves,removes,globalChanges;
@property NSDictionary *lastSaved;
@property NSString *lastAccount,*lastRemoved;
+ (instancetype)sharedManager;
- (void)saveTask:(NSDictionary *)task account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion;
- (void)removeTask:(NSString *)identifier account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion;
- (void)setEnabled:(BOOL)enabled account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion;
@end
static CSScheduledTaskManager *manager;
@implementation CSScheduledTaskManager
+ (instancetype)sharedManager {return manager;}
- (void)saveTask:(NSDictionary *)task account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion {
    self.saves++;self.lastSaved=[task copy];self.lastAccount=account;
    BOOL ok=!self.failSave && [self.store saveTask:task now:NSDate.date];
    completion(ok,ok?nil:self.store.error?:[NSError errorWithDomain:@"swipe-test" code:1 userInfo:@{NSLocalizedDescriptionKey:@"synthetic save failure"}]);
}
- (void)removeTask:(NSString *)identifier account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion {
    self.removes++;self.lastRemoved=identifier;self.lastAccount=account;
    BOOL ok=!self.failRemove && [self.store removeTask:identifier];completion(ok,ok?nil:[NSError errorWithDomain:@"swipe-test" code:2 userInfo:@{NSLocalizedDescriptionKey:@"synthetic remove failure"}]);
}
- (void)setEnabled:(BOOL)enabled account:(NSString *)account completion:(CSScheduledTaskStoreCompletion)completion {(void)enabled;(void)account;self.globalChanges++;completion(YES,nil);}
@end
@interface CSScheduledTaskSettingsViewController : NSObject
@property(copy) NSArray<NSDictionary *> *displayedTasks;
@property(copy) NSString *displayedAccount;
@property NSUInteger displayedEpoch,reloads;
@property TestNavigation *navigationController;
- (void)reload;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)path;
- (NSDictionary *)swipeTaskWithID:(NSString *)identifier account:(NSString *)account epoch:(NSUInteger)epoch;
- (void)performTaskAction:(NSString *)identifier account:(NSString *)account epoch:(NSUInteger)epoch enabled:(BOOL)enabled remove:(BOOL)remove completion:(void(^)(BOOL))completion;
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)style forRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation CSScheduledTaskSettingsViewController
- (void)reload {self.reloads++;}
#import "ScheduledTaskSwipeUnderTest.h"
@end

static NSIndexPath *Path(NSUInteger section,NSUInteger row) {NSUInteger indices[]={section,row};return [NSIndexPath indexPathWithIndexes:indices length:2];}
static NSDictionary *Task(NSString *identifier,BOOL enabled,NSString *target) {return @{@"id":identifier,@"title":identifier,@"target":target,@"text":@"original text",@"enabled":@(enabled),@"catchUp":@NO,@"mode":@"minutes",@"interval":@5,@"anchor":[NSDate dateWithTimeIntervalSinceNow:3600],@"zone":@"Asia/Shanghai",@"weekdays":@[@2],@"hour":@9,@"minute":@0};}
static void Privacy(BOOL hidden,BOOL blocked) {privacy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"alice" profile:@{@"enabled":@YES,@"friends":@[@"hidden"],@"groups":@[],@"options":@{@"hideScheduledTasks":@(hidden)}} revealed:NO revision:1 blocked:blocked];}
static CSScheduledTaskSettingsViewController *Screen(NSURL *root,NSArray *tasks,BOOL global) {
    epoch=1;alerts=0;lastAlert=nil;Privacy(NO,NO);manager=[CSScheduledTaskManager new];
    manager.store=[[CSScheduledTaskStore alloc] initWithURL:[root URLByAppendingPathComponent:[NSString stringWithFormat:@"%lu.plist",(unsigned long)++fixtureNumber]] account:@"alice"];
    CHECK([manager.store load]);for(NSDictionary *task in tasks)CHECK([manager.store saveTask:task now:NSDate.date]);CHECK([manager.store setEnabled:global now:NSDate.date]);
    CSScheduledTaskSettingsViewController *screen=[CSScheduledTaskSettingsViewController new];screen.displayedTasks=manager.store.tasks;screen.displayedAccount=@"alice";screen.displayedEpoch=epoch;screen.navigationController=[TestNavigation new];screen.navigationController.topViewController=screen;return screen;
}
static UISwipeActionsConfiguration *Menu(CSScheduledTaskSettingsViewController *screen,NSUInteger row) {return [screen tableView:nil trailingSwipeActionsConfigurationForRowAtIndexPath:Path(1,row)];}
static UIContextualAction *Action(UISwipeActionsConfiguration *menu,NSString *title) {for(UIContextualAction *action in menu.actions)if([action.title isEqual:title])return action;CHECK(NO);return nil;}
static BOOL Invoke(UIContextualAction *action) {__block NSUInteger callbacks=0;__block BOOL result=NO;action.handler(action,nil,^(BOOL done){callbacks++;result=done;});CHECK(callbacks==1);return result;}
static NSDictionary *Current(NSString *identifier) {for(NSDictionary *task in manager.store.tasks)if([task[@"id"] isEqual:identifier])return task;return nil;}

int main(int argc,const char **argv) {@autoreleasepool {
    CHECK(argc==2);NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
    for(NSNumber *initial in @[@NO,@YES]) {
        CSScheduledTaskSettingsViewController *screen=Screen(root,@[Task(@"first",initial.boolValue,@"friend")],YES);UISwipeActionsConfiguration *menu=Menu(screen,0);
        CHECK(menu.actions.count==2 && menu.performsFirstActionWithFullSwipe);
        CHECK([menu.actions[0].title isEqual:@"删除"] && menu.actions[0].style==UIContextualActionStyleDestructive);
        UIContextualAction *toggle=Action(menu,initial.boolValue?@"停止":@"启用");CHECK(toggle.style==UIContextualActionStyleNormal);
        CHECK([toggle.backgroundColor isEqual:initial.boolValue?UIColor.systemOrangeColor:UIColor.systemGreenColor]);
        CHECK(Invoke(toggle));CHECK(manager.saves==1 && !manager.removes && !manager.globalChanges);
        CHECK([Current(@"first")[@"enabled"] boolValue]!=initial.boolValue);CHECK([manager.lastAccount isEqual:@"alice"]);
        NSDictionary *saved=Current(@"first");CHECK(Invoke(toggle));CHECK(manager.saves==(initial.boolValue?2:1));
        CHECK(initial.boolValue?![Current(@"first")[@"enabled"] boolValue]:[Current(@"first") isEqual:saved]);
        // Repeated Enable is a no-op; explicit Stop still cancels an admitted run.
        screen=Screen(root,@[Task(@"first",initial.boolValue,@"friend")],YES);toggle=Action(Menu(screen,0),initial.boolValue?@"停止":@"启用");
        NSMutableDictionary *updated=[Current(@"first") mutableCopy];updated[@"enabled"]=@(!initial.boolValue);CHECK([manager.store saveTask:updated now:NSDate.date]);saved=Current(@"first");
        CHECK(Invoke(toggle));CHECK(manager.saves==(initial.boolValue?1:0));
        CHECK(initial.boolValue?![manager.lastSaved[@"enabled"] boolValue]:[Current(@"first") isEqual:saved]);
    }
    // Reordering and editing after the menu opens must use the latest task with that ID.
    CSScheduledTaskSettingsViewController *screen=Screen(root,@[Task(@"first",YES,@"friend"),Task(@"second",YES,@"other")],YES);
    UIContextualAction *toggle=Action(Menu(screen,0),@"停止");NSDictionary *first=Current(@"first");CHECK([manager.store removeTask:@"first"]);
    NSMutableDictionary *latest=[first mutableCopy];latest[@"text"]=@"latest edited text";latest[@"title"]=@"latest title";latest[@"interval"]=@17;latest[@"target"]=@"new-visible";CHECK([manager.store saveTask:latest now:NSDate.date]);
    CHECK([manager.store.tasks[0][@"id"] isEqual:@"second"]);CHECK(Invoke(toggle));
    CHECK(![Current(@"first")[@"enabled"] boolValue] && [Current(@"second")[@"enabled"] boolValue]);
    for(NSString *key in @[@"title",@"text",@"interval",@"target",@"anchor"])CHECK([Current(@"first")[key] isEqual:latest[key]]);
    // Changes between showing the menu and tapping never mutate a stale/invisible task.
    for(NSUInteger gate=0;gate<8;gate++) {
        screen=Screen(root,@[Task(@"first",YES,gate==1?@"hidden":@"friend")],YES);toggle=Action(Menu(screen,0),@"停止");
        if(gate==0)CHECK([manager.store removeTask:@"first"]);
        if(gate==1)Privacy(YES,NO);
        if(gate==2){NSMutableDictionary *changed=[Current(@"first") mutableCopy];changed[@"target"]=@"hidden";CHECK([manager.store saveTask:changed now:NSDate.date]);Privacy(YES,NO);}
        if(gate==3){manager.store=[[CSScheduledTaskStore alloc] initWithURL:[root URLByAppendingPathComponent:@"bob.plist"] account:@"bob"];CHECK([manager.store load]);}
        if(gate==4)epoch++;
        if(gate==5)manager.savingConfiguration=YES;
        if(gate==6)[manager.store invalidate];
        if(gate==7)Privacy(NO,YES);
        CHECK(!Invoke(toggle));CHECK(!manager.saves && !manager.removes && !manager.globalChanges && screen.reloads==1);
    }
    // Enabling one definition while the master switch is off leaves it off.
    screen=Screen(root,@[Task(@"first",NO,@"friend")],NO);CHECK(Invoke(Action(Menu(screen,0),@"启用")));
    CHECK([Current(@"first")[@"enabled"] boolValue] && !manager.store.enabled && !manager.globalChanges);
    // A once claim auto-disables before handoff; the old Stop menu still saves NO.
    screen=Screen(root,@[Task(@"once",YES,@"friend")],YES);NSMutableDictionary *once=[Current(@"once") mutableCopy];once[@"mode"]=@"once";CHECK([manager.store saveTask:once now:NSDate.date]);
    screen.displayedTasks=manager.store.tasks;toggle=Action(Menu(screen,0),@"停止");CHECK([manager.store claimTask:@"once" now:once[@"anchor"]]!=nil);
    CHECK(![Current(@"once")[@"enabled"] boolValue]);CHECK(Invoke(toggle));CHECK(manager.saves==1 && ![manager.lastSaved[@"enabled"] boolValue]);
    CHECK([Current(@"once")[@"anchor"] isEqual:once[@"anchor"]] && [Current(@"once")[@"lastOccurrence"] isEqual:once[@"anchor"]]);
    // Store failures reach UIKit as done(NO) and keep the definition/anchor intact.
    screen=Screen(root,@[Task(@"first",NO,@"friend")],YES);toggle=Action(Menu(screen,0),@"启用");manager.failSave=YES;
    CHECK(!Invoke(toggle));CHECK(alerts==1 && [lastAlert containsString:@"save failure"] && ![Current(@"first")[@"enabled"] boolValue]);
    screen=Screen(root,@[Task(@"expired",NO,@"friend")],YES);NSMutableDictionary *expired=[Current(@"expired") mutableCopy];expired[@"mode"]=@"once";expired[@"anchor"]=[NSDate dateWithTimeIntervalSinceNow:-3600];CHECK([manager.store saveTask:expired now:NSDate.date]);
    screen.displayedTasks=manager.store.tasks;NSDictionary *before=Current(@"expired");CHECK(!Invoke(Action(Menu(screen,0),@"启用")));
    CHECK(manager.saves==1 && alerts==1 && [Current(@"expired") isEqual:before]);CHECK([manager.lastSaved[@"anchor"] isEqual:expired[@"anchor"]]);
    // Both the modern Delete action and the original editing callback remain operational.
    screen=Screen(root,@[Task(@"first",YES,@"friend")],YES);CHECK(Invoke(Action(Menu(screen,0),@"删除")));CHECK(manager.removes==1 && !manager.saves && !Current(@"first"));
    screen=Screen(root,@[Task(@"first",YES,@"friend")],YES);[screen tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:Path(1,0)];CHECK(manager.removes==1 && !Current(@"first"));
    screen=Screen(root,@[Task(@"first",YES,@"friend")],YES);manager.failRemove=YES;CHECK(!Invoke(Action(Menu(screen,0),@"删除")));CHECK(alerts==1 && Current(@"first"));
    CHECK(![screen tableView:nil trailingSwipeActionsConfigurationForRowAtIndexPath:Path(0,0)]);CHECK(![screen tableView:nil trailingSwipeActionsConfigurationForRowAtIndexPath:Path(1,1)]);
    manager.savingConfiguration=YES;CHECK(!Menu(screen,0));manager.savingConfiguration=NO;epoch++;CHECK(!Menu(screen,0));
    printf("Scheduled task swipes: %lu checks passed (extracted production UI methods, isolated stores and local UI/manager fakes)\n",(unsigned long)checks);
}return 0;}
