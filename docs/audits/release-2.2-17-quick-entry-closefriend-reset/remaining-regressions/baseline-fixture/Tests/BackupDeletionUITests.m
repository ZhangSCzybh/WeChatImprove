#import <Foundation/Foundation.h>

static NSUInteger checks;
#define CHECK(...) do {checks++;if(!(__VA_ARGS__)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__);exit(1);}}while(0)

// Only presentation values and action handlers are modeled. The methods under
// test below are extracted unchanged from the production settings controller.
typedef NS_ENUM(NSInteger,UIAlertActionStyle){UIAlertActionStyleDefault,UIAlertActionStyleCancel,UIAlertActionStyleDestructive};
typedef NS_ENUM(NSInteger,UIAlertControllerStyle){UIAlertControllerStyleActionSheet,UIAlertControllerStyleAlert};
@interface UIView : NSObject
@property NSRect bounds;
@end
@implementation UIView @end
@interface UIPopoverPresentationController : NSObject
@property UIView *sourceView;
@property NSRect sourceRect;
@end
@implementation UIPopoverPresentationController @end
@interface UINavigationController : NSObject
@property id pushedController;
- (void)pushViewController:(id)controller animated:(BOOL)animated;
@end
@implementation UINavigationController
- (void)pushViewController:(id)controller animated:(BOOL)animated{(void)animated;self.pushedController=controller;}
@end
@interface UITableView : UIView
@property UIView *anchor;
@property NSUInteger reloads;
- (UIView *)cellForRowAtIndexPath:(NSIndexPath *)path;
- (void)reloadData;
@end
@implementation UITableView
- (UIView *)cellForRowAtIndexPath:(NSIndexPath *)path{CHECK(path.length==2);return self.anchor;}
- (void)reloadData{self.reloads++;}
@end
@interface NSIndexPath (BackupDeletionUI)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (BackupDeletionUI)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section{NSUInteger values[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:values length:2];}
@end
@interface UIViewController : NSObject
@property NSString *title;
@property UIView *view;
@property UITableView *tableView;
@property UINavigationController *navigationController;
@property id presentedViewController;
@property NSUInteger presentations;
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(dispatch_block_t)completion;
@end
@implementation UIViewController
- (instancetype)init{if((self=[super init])){_view=[UIView new];_tableView=[UITableView new];_tableView.anchor=[UIView new];_navigationController=[UINavigationController new];}return self;}
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(dispatch_block_t)completion{(void)animated;CHECK(NSThread.isMainThread);self.presentedViewController=controller;self.presentations++;if(completion)completion();}
@end
@interface UIAlertAction : NSObject
@property NSString *title;
@property UIAlertActionStyle style;
@property(copy) void (^handler)(UIAlertAction *);
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler;
- (void)activate;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler{UIAlertAction *action=[self new];action.title=title;action.style=style;action.handler=handler;return action;}
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
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style{UIAlertController *alert=[self new];alert.title=title;alert.message=message;alert.preferredStyle=style;alert.actions=[NSMutableArray array];alert.popoverPresentationController=[UIPopoverPresentationController new];return alert;}
- (void)addAction:(UIAlertAction *)action{[self.actions addObject:action];}
@end
@interface CSBackupPreviewViewController : UIViewController
- (instancetype)initWithSnapshot:(NSDictionary *)snapshot;
@end
@implementation CSBackupPreviewViewController
- (instancetype)initWithSnapshot:(NSDictionary *)snapshot{(void)snapshot;return [super init];}
@end

typedef void (^CSBackupCompletion)(id,NSError *);
@interface DeletionStore : NSObject
@property NSUInteger removals;
@property NSString *removedFilename;
@property NSError *failure;
- (BOOL)removeFile:(NSString *)filename error:(NSError **)error;
@end
@implementation DeletionStore
- (BOOL)removeFile:(NSString *)filename error:(NSError **)error{self.removals++;self.removedFilename=filename;if(error)*error=self.failure;return !self.failure;}
@end
@interface DeletionEngine : NSObject
@property DeletionStore *store;
@end
@implementation DeletionEngine @end
@interface CSBackupManager : NSObject
@property NSUInteger loads,removals,exports,metadataUpdates,recoveryRetries;
@property NSDictionary *loadedRecord;
@property DeletionEngine *engine;
@property(copy) CSBackupCompletion pendingLoad,pendingRemove;
@property(copy) CSBackupCompletion pendingRetry;
@property(copy) id (^pendingWork)(NSError **);
+ (instancetype)sharedManager;
- (void)load:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)remove:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)exportOriginal:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)exportSnapshot:(NSDictionary *)snapshot completion:(CSBackupCompletion)completion;
- (void)updateMetadata:(NSDictionary *)metadata record:(NSDictionary *)record completion:(CSBackupCompletion)completion;
- (void)retryPendingWork:(CSBackupCompletion)completion;
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion;
@end
static CSBackupManager *manager;
@implementation CSBackupManager
+ (instancetype)sharedManager{return manager;}
- (instancetype)init{if((self=[super init])){_engine=[DeletionEngine new];_engine.store=[DeletionStore new];}return self;}
- (void)load:(NSDictionary *)record completion:(CSBackupCompletion)completion{self.loads++;self.loadedRecord=record;self.pendingLoad=completion;}
- (void)perform:(id (^)(NSError **))work completion:(CSBackupCompletion)completion{self.removals++;self.pendingWork=work;self.pendingRemove=completion;}
#include "BackupDeletionManagerUnderTest.h"
- (void)exportOriginal:(NSDictionary *)record completion:(CSBackupCompletion)completion{(void)record;(void)completion;self.exports++;}
- (void)exportSnapshot:(NSDictionary *)snapshot completion:(CSBackupCompletion)completion{(void)snapshot;(void)completion;self.exports++;}
- (void)updateMetadata:(NSDictionary *)metadata record:(NSDictionary *)record completion:(CSBackupCompletion)completion{(void)metadata;(void)record;(void)completion;self.metadataUpdates++;}
- (void)retryPendingWork:(CSBackupCompletion)completion{self.recoveryRetries++;self.pendingRetry=completion;}
@end

@interface CSBackupSettingsViewController : UIViewController
@property NSArray *records;
@property BOOL busy;
@property NSUInteger reloads;
@property NSString *messageTitle,*messageDetail;
- (void)setWorking:(BOOL)working;
- (void)reload;
- (void)message:(NSString *)title detail:(NSString *)detail;
- (void)shareURL:(NSURL *)url;
- (void)confirmMetadata:(NSDictionary *)record;
- (void)renameRecord:(NSDictionary *)record;
- (void)openRecord:(NSDictionary *)record;
- (void)showUnavailableRecord:(NSDictionary *)record;
- (void)showRecord:(NSDictionary *)record snapshot:(NSDictionary *)snapshot anchor:(UIView *)anchor;
- (void)deleteRecord:(NSDictionary *)record;
- (void)retryRestore;
@end
@implementation CSBackupSettingsViewController
- (void)setWorking:(BOOL)working{self.busy=working;}
- (void)reload{self.reloads++;}
- (void)message:(NSString *)title detail:(NSString *)detail{self.messageTitle=title;self.messageDetail=detail;}
- (void)shareURL:(NSURL *)url{(void)url;}
- (void)confirmMetadata:(NSDictionary *)record{(void)record;}
- (void)renameRecord:(NSDictionary *)record{(void)record;}
#include "BackupDeletionUIUnderTest.h"
@end

static NSDictionary *Snapshot(void){return @{@"name":@"snapshot",@"kind":@"manual",@"createdAt":[NSDate dateWithTimeIntervalSince1970:1000],@"source":@{@"pluginVersion":@"fixture"},@"fields":@{},@"assets":@[],@"warnings":@[]};}
static NSDictionary *Record(BOOL unavailable,BOOL favorite,BOOL warning){
    NSMutableDictionary *record=[@{@"name":@"display-name",@"filename":@"selected-file.wcbak",@"id":@"different-snapshot-uuid",@"url":[NSURL fileURLWithPath:@"/fixture/selected.wcbak"],@"metadata":@{@"name":@"selected",@"favorite":@(favorite)}} mutableCopy];
    if(unavailable){record[@"unavailable"]=@YES;record[@"issue"]=@"synthetic checksum failure";}
    if(warning)record[@"metadataWarning"]=@"synthetic metadata warning";
    return [record copy];
}
static UIAlertAction *Action(UIAlertController *alert,NSString *title){
    CHECK([alert isKindOfClass:UIAlertController.class]);UIAlertAction *found=nil;
    for(UIAlertAction *action in alert.actions)if([action.title isEqual:title]){CHECK(!found);found=action;}
    CHECK(found);return found;
}
static CSBackupSettingsViewController *Controller(NSDictionary *record){manager=[CSBackupManager new];CSBackupSettingsViewController *controller=[CSBackupSettingsViewController new];controller.records=@[record];return controller;}
static void FinishRemoval(NSError *error){
    CHECK(manager.pendingWork && manager.pendingRemove);id (^work)(NSError **)=manager.pendingWork;CSBackupCompletion completion=manager.pendingRemove;
    manager.pendingWork=nil;manager.pendingRemove=nil;manager.engine.store.failure=error;
    NSError *storeError=nil;id result=work(&storeError);CHECK((result!=nil)==(error==nil));completion(result,storeError);
}
static void Show(CSBackupSettingsViewController *controller,NSDictionary *record,BOOL unavailable){
    if(unavailable)[controller showUnavailableRecord:record];else [controller showRecord:record snapshot:Snapshot() anchor:controller.tableView.anchor];
}
static UIAlertController *Confirmation(CSBackupSettingsViewController *controller){
    UIAlertController *menu=controller.presentedViewController;CHECK(menu.preferredStyle==UIAlertControllerStyleActionSheet);
    UIAlertAction *remove=Action(menu,@"删除备份");CHECK(remove.style==UIAlertActionStyleDestructive);
    CHECK(!manager.removals && !controller.busy);[remove activate];
    UIAlertController *confirmation=controller.presentedViewController;
    CHECK(confirmation!=menu && confirmation.preferredStyle==UIAlertControllerStyleAlert);
    CHECK(!manager.removals && !controller.busy);CHECK(Action(confirmation,@"删除").style==UIAlertActionStyleDestructive);
    return confirmation;
}
static void MenuAndConfirmation(void){
    for(NSNumber *unavailable in @[@NO,@YES])for(NSNumber *favorite in @[@NO,@YES])for(NSNumber *warning in @[@NO,@YES]){
        NSDictionary *record=Record(unavailable.boolValue,favorite.boolValue,warning.boolValue);
        CSBackupSettingsViewController *controller=Controller(record);Show(controller,record,unavailable.boolValue);
        UIAlertController *menu=controller.presentedViewController;
        CHECK(menu.popoverPresentationController.sourceView==(unavailable.boolValue?controller.view:controller.tableView.anchor));
        [Action(menu,@"取消") activate];CHECK(!manager.removals && !manager.loads && !manager.exports && !manager.metadataUpdates);
        Show(controller,record,unavailable.boolValue);UIAlertController *confirmation=Confirmation(controller);
        CHECK([confirmation.title isEqual:favorite.boolValue?@"删除这份收藏备份？":@"删除这份备份？"]);
        CHECK(Action(confirmation,@"取消").style==UIAlertActionStyleCancel);[Action(confirmation,@"取消") activate];
        CHECK(!manager.removals && !controller.busy && !controller.reloads);
        Show(controller,record,unavailable.boolValue);confirmation=Confirmation(controller);[Action(confirmation,@"删除") activate];
        CHECK(manager.removals==1 && !manager.engine.store.removals && controller.busy && !controller.reloads);
        CHECK(!manager.loads && !manager.exports && !manager.metadataUpdates);
        FinishRemoval(nil);CHECK(manager.engine.store.removals==1 && [manager.engine.store.removedFilename isEqual:record[@"filename"]]);
        CHECK(!controller.busy && controller.reloads==1 && !controller.messageTitle);
    }
}
static void DeleteFailure(void){
    NSDictionary *record=Record(YES,YES,NO);CSBackupSettingsViewController *controller=Controller(record);
    [controller deleteRecord:record];CHECK(!manager.removals && !controller.busy);
    [Action(controller.presentedViewController,@"删除") activate];CHECK(manager.removals==1 && controller.busy);
    FinishRemoval([NSError errorWithDomain:@"fixture" code:1 userInfo:@{NSLocalizedDescriptionKey:@"pending plan protects this file"}]);
    CHECK(manager.engine.store.removals==1 && [manager.engine.store.removedFilename isEqual:record[@"filename"]]);
    CHECK(!controller.busy && !controller.reloads && [controller.messageTitle isEqual:@"删除失败"] && controller.messageDetail.length);
}
static void OpenRecords(void){
    NSDictionary *unavailable=Record(YES,NO,NO);CSBackupSettingsViewController *controller=Controller(unavailable);
    [controller openRecord:unavailable];CHECK(!manager.loads && !controller.busy);(void)Action(controller.presentedViewController,@"删除备份");
    NSDictionary *record=Record(NO,NO,NO);controller=Controller(record);[controller openRecord:record];
    CHECK(manager.loads==1 && manager.loadedRecord==record && controller.busy && !controller.presentedViewController);
    CSBackupCompletion completion=manager.pendingLoad;manager.pendingLoad=nil;completion(Snapshot(),nil);
    CHECK(!controller.busy);(void)Action(controller.presentedViewController,@"预览恢复");(void)Action(controller.presentedViewController,@"删除备份");
    // A record can become unreadable after listing. Its failed load must still
    // offer explicit management rather than leave the user at a dead-end error.
    controller=Controller(record);[controller openRecord:record];completion=manager.pendingLoad;manager.pendingLoad=nil;
    completion(nil,[NSError errorWithDomain:@"fixture" code:2 userInfo:@{NSLocalizedDescriptionKey:@"synthetic read failed"}]);
    CHECK(!controller.busy && !controller.messageTitle);UIAlertController *menu=controller.presentedViewController;
    CHECK(menu.preferredStyle==UIAlertControllerStyleActionSheet);(void)Action(menu,@"导出原件 / 分享");(void)Action(menu,@"重新检查");
    for(UIAlertAction *action in menu.actions)CHECK(![action.title isEqual:@"预览恢复"]);
    UIAlertController *confirmation=Confirmation(controller);[Action(confirmation,@"删除") activate];
    CHECK(manager.removals==1);FinishRemoval(nil);
    CHECK(manager.engine.store.removals==1 && [manager.engine.store.removedFilename isEqual:record[@"filename"]]);CHECK(!controller.busy && controller.reloads==1);
    // Treat an empty successful load as unreadable as well.
    controller=Controller(record);[controller openRecord:record];completion=manager.pendingLoad;manager.pendingLoad=nil;completion(nil,nil);
    CHECK(!controller.busy && !controller.messageTitle);(void)Action(controller.presentedViewController,@"删除备份");
}
static void LegacySnapshotManagement(void){
    NSDictionary *record=Record(NO,NO,NO);
    for(NSString *kind in @[@"automatic",@"upgrade",@"protection"]){
        CSBackupSettingsViewController *controller=Controller(record);NSMutableDictionary *snapshot=[Snapshot() mutableCopy];snapshot[@"kind"]=kind;
        [controller showRecord:record snapshot:snapshot anchor:controller.tableView.anchor];
        UIAlertController *menu=controller.presentedViewController;CHECK([menu.message containsString:@"历史"]);
        (void)Action(menu,@"预览恢复");(void)Action(menu,@"导出到文件 / 分享");(void)Action(menu,@"重命名");
        [Action(menu,@"收藏") activate];CHECK(manager.metadataUpdates==1 && !manager.removals);
        [controller setWorking:NO];[controller deleteRecord:record];[Action(controller.presentedViewController,@"删除") activate];FinishRemoval(nil);
        CHECK(manager.removals==1 && controller.reloads==1);
    }
    CSBackupSettingsViewController *controller=Controller(Record(NO,NO,YES));
    [controller showRecord:controller.records.firstObject snapshot:Snapshot() anchor:controller.tableView.anchor];
    UIAlertController *menu=controller.presentedViewController;(void)Action(menu,@"确认名称与收藏信息");
    for(UIAlertAction *action in menu.actions)CHECK(![action.title containsString:@"保护状态"]);
}
static void RecoveryRetry(void){
    for(NSNumber *failure in @[@NO,@YES]){
        CSBackupSettingsViewController *controller=Controller(Record(NO,NO,NO));[controller retryRestore];
        CHECK(controller.busy && manager.recoveryRetries==1 && manager.pendingRetry);
        CHECK(!manager.loads && !manager.removals && !manager.exports && !manager.metadataUpdates);
        CSBackupCompletion completion=manager.pendingRetry;manager.pendingRetry=nil;
        NSError *error=failure.boolValue?[NSError errorWithDomain:@"fixture" code:3 userInfo:@{NSLocalizedDescriptionKey:@"recovery remains pending"}]:nil;
        completion(nil,error);CHECK(!controller.busy && controller.tableView.reloads==1);
        if(error)CHECK([controller.messageTitle isEqual:@"恢复仍待处理"] && [controller.messageDetail isEqual:error.localizedDescription]);
        else CHECK([controller.messageTitle isEqual:@"恢复检查已完成"] && [controller.messageDetail containsString:@"不会创建备份"]);
        CHECK(manager.recoveryRetries==1 && !manager.loads && !manager.removals && !manager.exports && !manager.metadataUpdates);
    }
}
int main(void){@autoreleasepool{
    MenuAndConfirmation();DeleteFailure();OpenRecords();LegacySnapshotManagement();RecoveryRetry();
    printf("Backup deletion UI: %lu checks passed (real menus/load/confirmation/manager removal; in-memory Store)\n",(unsigned long)checks);
}return 0;}
