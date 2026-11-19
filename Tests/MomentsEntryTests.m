#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
static NSUInteger Assertions;
#define CHECK(...) do { Assertions++; if(!(__VA_ARGS__)) { \
    fprintf(stderr,"Moments entry FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); \
} } while(0)
@class CSMomentsLayoutAdapter;
@interface UIView : NSObject
@property(nonatomic,strong) UIView *superview;
@property(nonatomic,strong) id window;
@property(nonatomic) BOOL hidden;
@end
@implementation UIView @end
@interface UITableView : UIView @end
@implementation UITableView @end
@interface EntryCell : NSObject
@property(nonatomic) NSUInteger ends;
- (void)endDisplaying;
@end
@implementation EntryCell
- (void)endDisplaying { self.ends++; }
@end
#define CSMomentsCardCell EntryCell
@interface EntryCollection : NSObject
@property(nonatomic) NSUInteger reloads;
@property(nonatomic,copy) NSArray<EntryCell *> *visibleCells;
@property(nonatomic,copy) NSUInteger (^countItems)(void);
@property(nonatomic,strong) NSMutableArray<NSNumber *> *reloadedCounts;
- (void)reloadData;
@end
@implementation EntryCollection
- (void)reloadData { self.reloads++; [self.reloadedCounts addObject:@(self.countItems())]; }
@end
@interface EntryOwner : NSObject
@property(nonatomic) BOOL isViewLoaded;
@property(nonatomic,strong) UIView *view,*expandableHeader;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) CSMomentsLayoutAdapter *adapter;
@end
@implementation EntryOwner @end
@interface EntryItem : NSObject
@property(nonatomic) BOOL hidden,ad;
@property(nonatomic,copy) NSString *username,*nickname;
@end
@implementation EntryItem @end
@interface CSMomentsCardModel : NSObject
@property(nonatomic,strong) EntryItem *item;
@property(nonatomic) NSUInteger epoch,revision;
@property(nonatomic,copy) NSString *username,*nickname;
@end
@implementation CSMomentsCardModel @end
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic) NSUInteger revision;
@property(nonatomic) BOOL blocked;
@end
@implementation CSCloseFriendSnapshot @end
@interface CSMomentsLayoutAdapter : NSObject
@property(nonatomic,weak) EntryOwner *owner;
@property(nonatomic,strong) EntryCollection *collection;
@property(nonatomic,strong) UIView *headerContainer;
@property(nonatomic,weak) UIView *backdropHeader;
@property(nonatomic,copy) NSArray<CSMomentsCardModel *> *cards;
@property(nonatomic) BOOL attached,suspended,current,acceptEmptySource,initialSourcePrepared,positionAwaitingReturn;
@property(nonatomic) NSUInteger epoch,sourceCount,attaches,layouts,restores,footers,playbacks,stops,detaches,queued;
- (void)update;
- (void)scheduleUpdate;
- (void)detach;
- (void)clearPresentation;
- (void)resumePresentation;
- (BOOL)isCurrent;
- (void)attachToTable:(UITableView *)table;
- (void)layoutViews;
- (void)restorePosition;
- (void)updateFooter;
- (void)scheduleVideoPlayback;
- (void)stopVideoPlayback;
@end
static BOOL Enabled,AccountCurrent,FilterAds,CanPrepare,PreparationABIAvailable;
static NSUInteger Epoch,Prepares;
static NSArray<EntryItem *> *Source,*CachedSource;
static NSDictionary<NSString *,NSString *> *EntryRemarks;
static id Facade;
static CSCloseFriendSnapshot *Snapshot;
static NSMutableArray<dispatch_block_t> *Pending;
static NSMutableArray<NSString *> *Events;
static void CSMomentsHeaderBackdropRemove(UIView *header) { (void)header; }
static BOOL CSMomentsLayoutEnabled(void) { return Enabled; }
static BOOL CSCFPageIsCurrent(id owner) { (void)owner; return AccountCurrent; }
static id CurrentFacade(void) { return Facade; }
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return Snapshot; }
enum { CSAdPurificationMoments=1,CSCloseFriendSurfaceTimeline=2 };
static BOOL CSAdPurificationShouldApply(NSInteger surface) { CHECK(surface==CSAdPurificationMoments); return FilterAds; }
static BOOL CSCFSocialHidden(EntryItem *item,NSInteger surface) { CHECK(surface==CSCloseFriendSurfaceTimeline); return item.hidden; }
static CGSize CSMomentsNativeMediaSize(id media) { (void)media; return CGSizeZero; }
static id Read(id object,NSString *key) {
    if(!object)return nil;
    if(object==Facade) { CHECK([key isEqual:@"getTimelineDataItem"]); return Source; }
    EntryOwner *owner=object;
    if([key isEqual:@"expandableHeader"])return owner.expandableHeader;
    CHECK([key isEqual:@"tableView"]); return owner.tableView;
}
static BOOL Matches(id facade,NSString *name,const char *types) {
    CHECK([name isEqual:@"reloadTimelineDataItems"] && strcmp(types,"v@:")==0);
    return facade && PreparationABIAvailable;
}
static BOOL Call0(id facade,NSString *name) {
    CHECK(facade==Facade && [name isEqual:@"reloadTimelineDataItems"]);
    Prepares++; [Events addObject:@"prepare-native-list"];
    if(CanPrepare)Source=CachedSource;
    return CanPrepare;
}
// Projection is a boundary double only; retention, invalidation and lifecycle
// decisions below are extracted from the real production methods and hooks.
static NSArray *CSMomentsBuildCards(NSArray *source,CSCloseFriendSnapshot *snapshot,NSUInteger epoch,BOOL ads,
                                   id(^read)(id,NSString *),CGSize(^size)(id)) {
    (void)read; (void)size;
    [Events addObject:@"project"];
    NSMutableArray *cards=[NSMutableArray new];
    if(snapshot.blocked)return cards;
    for(EntryItem *item in source) {
        if(item.hidden || (ads && item.ad))continue;
        CSMomentsCardModel *card=[CSMomentsCardModel new];
        card.item=item; card.epoch=epoch; card.revision=snapshot.revision;
        card.username=item.username?:@""; card.nickname=item.nickname?:@"微信用户"; [cards addObject:card];
    }
    return cards;
}
static void ApplyContactRemarks(NSArray<CSMomentsCardModel *> *cards) {
    for(CSMomentsCardModel *card in cards)if(EntryRemarks[card.username].length)card.nickname=EntryRemarks[card.username];
}
static BOOL SameCards(NSArray<CSMomentsCardModel *> *a,NSArray<CSMomentsCardModel *> *b) {
    if(a.count!=b.count)return NO;
    for(NSUInteger i=0;i<a.count;i++)if(a[i].item!=b[i].item || a[i].epoch!=b[i].epoch || a[i].revision!=b[i].revision || ![a[i].nickname isEqual:b[i].nickname])return NO;
    return YES;
}
@implementation CSMomentsLayoutAdapter
- (void)scheduleUpdate { self.queued++; }
- (void)detach { self.detaches++; self.attached=NO; [self clearPresentation]; }
- (BOOL)isCurrent { return self.current && Enabled && AccountCurrent && self.epoch==Epoch && !Snapshot.blocked; }
- (void)attachToTable:(UITableView *)table {
    CHECK(table==self.owner.tableView && table.superview==self.owner.view);
    self.attaches++; self.attached=YES; self.epoch=Epoch; [Events addObject:@"attach"];
}
- (void)layoutViews { self.layouts++; }
- (void)restorePosition { self.restores++; }
- (void)updateFooter { self.footers++; }
- (void)scheduleVideoPlayback { self.playbacks++; }
- (void)stopVideoPlayback { self.stops++; }
#include "MomentsEntryLifecycle.h"
#include "MomentsEntryUpdate.h"
@end
static CSMomentsLayoutAdapter *Adapter(EntryOwner *owner,BOOL create) { (void)create; return owner.adapter; }
static IMP LoadHook;
static void NativeViewDidLoad(EntryOwner *owner,SEL selector) {
    CHECK(selector==NSSelectorFromString(@"viewDidLoad"));
    [Events addObject:@"native-load"];
    owner.isViewLoaded=YES; owner.tableView.superview=owner.view;
}
static void NativeViewDidDisappear(EntryOwner *owner,SEL selector,BOOL animated) {
    (void)owner; (void)animated;
    CHECK(selector==NSSelectorFromString(@"viewDidDisappear:")); [Events addObject:@"native-disappear"];
}
static BOOL Install(NSString *className,NSString *name,const char *types,IMP replacement,IMP *original,BOOL classMethod) {
    CHECK([className isEqual:@"WCTimeLineViewController"] && [name isEqual:@"viewDidLoad"] && strcmp(types,"v@:")==0 && !classMethod);
    *original=(IMP)NativeViewDidLoad; LoadHook=replacement; return YES;
}
static void CaptureAsync(dispatch_queue_t queue,dispatch_block_t block) { (void)queue; [Pending addObject:[block copy]]; }
#define dispatch_async CaptureAsync
#include "MomentsEntryHook.h"
#undef dispatch_async
static EntryOwner *Page(void) {
    [Events removeAllObjects]; [Pending removeAllObjects];
    Enabled=AccountCurrent=PreparationABIAvailable=YES; FilterAds=CanPrepare=NO; Epoch=7; Prepares=0;
    Source=@[[EntryItem new],[EntryItem new]]; CachedSource=nil; EntryRemarks=@{};
    Facade=[NSObject new]; Snapshot=[CSCloseFriendSnapshot new]; Snapshot.revision=12;
    EntryOwner *owner=[EntryOwner new]; owner.view=[UIView new]; owner.tableView=[UITableView new];
    owner.adapter=[CSMomentsLayoutAdapter new]; owner.adapter.owner=owner;
    owner.adapter.current=YES; owner.adapter.cards=@[]; owner.adapter.collection=[EntryCollection new];
    owner.adapter.collection.visibleCells=@[[EntryCell new]];
    owner.adapter.collection.reloadedCounts=[NSMutableArray new];
    __weak CSMomentsLayoutAdapter *adapter=owner.adapter;
    owner.adapter.collection.countItems=^NSUInteger { return adapter.cards.count; };
    owner.adapter.headerContainer=[UIView new];
    return owner;
}
static void Load(EntryOwner *owner) {
#include "MomentsEntryRegistration.h"
    ((void(*)(id,SEL))LoadHook)(owner,NSSelectorFromString(@"viewDidLoad"));
    imp_removeBlock(LoadHook); LoadHook=NULL;
}
static void Disappear(EntryOwner *owner) {
    __block IMP disappeared=(IMP)NativeViewDidDisappear;
#include "MomentsEntryDisappear.h"
    ((void(*)(id,SEL,BOOL))disappearedIMP)(owner,NSSelectorFromString(@"viewDidDisappear:"),YES);
    imp_removeBlock(disappearedIMP);
}
static void TestSynchronousPreWindowEntry(void) {
    EntryOwner *owner=Page();
    CHECK(!owner.view.window && !owner.isViewLoaded);
    Load(owner);
    CHECK(owner.isViewLoaded && !owner.view.window && owner.adapter.attached);
    CHECK(owner.adapter.cards.count==2 && owner.adapter.sourceCount==2 && owner.adapter.collection.reloads==1);
    CHECK(owner.adapter.queued==0 && Pending.count==0 && owner.adapter.stops==0 && Prepares==0);
    CHECK([Events isEqualToArray:@[@"native-load",@"attach",@"project"]]);
    CHECK([owner.adapter.collection.reloadedCounts isEqualToArray:@[@2]]);
}
static void TestLocalNativeCompositionBeforeFirstFrame(void) {
    for(NSUInteger empty=0;empty<2;empty++) {
        EntryOwner *owner=Page(); CachedSource=Source; Source=empty?@[]:nil; CanPrepare=YES;
        Load(owner);
        CHECK(Prepares==1 && owner.adapter.cards.count==2 && owner.adapter.collection.reloads==1);
        CHECK([Events isEqualToArray:@[@"native-load",@"prepare-native-list",@"attach",@"project"]]);
        Source=nil; [owner.adapter update]; [owner.adapter resumePresentation];
        CHECK(Prepares==1 && owner.adapter.cards.count==2 && owner.adapter.collection.reloads==1);
    }
}
static void TestDelayedColdSource(void) {
    EntryOwner *owner=Page(); Source=nil;
    Load(owner);
    CHECK(Prepares==1 && owner.adapter.attached && owner.adapter.cards.count==0 && owner.adapter.sourceCount==0 && owner.adapter.restores==0);
    CHECK(owner.adapter.collection.reloads==0);
    Source=@[]; [owner.adapter update];
    CHECK(owner.adapter.cards.count==0 && owner.adapter.collection.reloads==0 && Prepares==1);
    Source=@[[EntryItem new]]; [owner.adapter update];
    CHECK(owner.adapter.attaches==1 && owner.adapter.cards.count==1 && owner.adapter.restores==2);
    CHECK([owner.adapter.collection.reloadedCounts isEqualToArray:@[@1]]);
}
static void TestUnavailableFacadeAndPreparationABIFallback(void) {
    EntryOwner *owner=Page(); CachedSource=Source; Source=nil; Facade=nil; CanPrepare=YES;
    Load(owner);
    CHECK(Prepares==0 && !owner.adapter.initialSourcePrepared && owner.adapter.cards.count==0);
    Facade=[NSObject new]; [owner.adapter update];
    CHECK(Prepares==1 && owner.adapter.initialSourcePrepared && owner.adapter.cards.count==2);
    [owner.adapter update]; CHECK(Prepares==1);
    owner=Page(); CachedSource=Source; Source=@[]; PreparationABIAvailable=NO; CanPrepare=YES;
    Load(owner);
    CHECK(Prepares==0 && !owner.adapter.initialSourcePrepared && owner.adapter.cards.count==0);
    Source=CachedSource; [owner.adapter update];
    CHECK(Prepares==0 && owner.adapter.initialSourcePrepared && owner.adapter.cards.count==2);
}
static void TestPushReturnAndReentryKeepAcceptedCards(void) {
    EntryOwner *owner=Page(); Load(owner);
    CSMomentsLayoutAdapter *adapter=owner.adapter;
    NSArray *accepted=adapter.cards; NSArray *originalSource=Source;
    EntryCell *cell=adapter.collection.visibleCells.firstObject;
    adapter.positionAwaitingReturn=YES;
    Disappear(owner);
    CHECK(adapter.suspended && adapter.cards==accepted && adapter.stops==1);
    CHECK(adapter.collection.reloads==1 && cell.ends==0);
    Source=nil; [adapter update];
    CHECK(adapter.cards==accepted && adapter.sourceCount==2 && adapter.collection.reloads==1);
    Source=@[]; [adapter update];
    CHECK(adapter.cards==accepted && adapter.collection.reloads==1 && cell.ends==0);
    [adapter resumePresentation];
    CHECK(!adapter.suspended && !adapter.positionAwaitingReturn && adapter.cards==accepted);
    CHECK([adapter.collection.reloadedCounts isEqualToArray:@[@2]]);
    Source=[originalSource arrayByAddingObject:[EntryItem new]]; [adapter update];
    CHECK(adapter.cards.count==3 && adapter.sourceCount==3);
    CHECK([adapter.collection.reloadedCounts isEqualToArray:@[@2,@3]]);
    Disappear(owner); Source=nil; [adapter resumePresentation];
    CHECK(adapter.cards.count==3 && adapter.collection.reloads==2 && cell.ends==0);
}
static void TestConfirmedEmptyCanRemoveLastCard(void) {
    EntryOwner *owner=Page(); Load(owner);
    Source=@[]; [owner.adapter update];
    CHECK(owner.adapter.cards.count==2 && owner.adapter.collection.reloads==1);
    // Production completion/delete hooks set this flag; their extraction tests
    // separately check callback ownership, stale serials and delete payloads.
    owner.adapter.acceptEmptySource=YES; Source=nil; [owner.adapter update];
    CHECK(owner.adapter.acceptEmptySource && owner.adapter.cards.count==2);
    Source=@[]; [owner.adapter update];
    CHECK(!owner.adapter.acceptEmptySource && owner.adapter.cards.count==0 && owner.adapter.sourceCount==0);
    CHECK([owner.adapter.collection.reloadedCounts isEqualToArray:@[@2,@0]]);
    [owner.adapter resumePresentation];
    CHECK(owner.adapter.cards.count==0 && owner.adapter.collection.reloads==2);
}
static void TestPrivacyAndAccountInvalidationCannotReuseCards(void) {
    for(NSUInteger reason=0;reason<5;reason++) {
        EntryOwner *owner=Page(); Load(owner); Disappear(owner);
        EntryCell *cell=owner.adapter.collection.visibleCells.firstObject;
        if(reason==0)Snapshot.revision++;
        if(reason==1)Epoch++;
        if(reason==2)Snapshot.blocked=YES;
        if(reason==3)AccountCurrent=NO;
        if(reason==4)Source.firstObject.hidden=YES;
        Source=nil; [owner.adapter update];
        CHECK(owner.adapter.cards.count==0 && cell.ends==1);
        CHECK([owner.adapter.collection.reloadedCounts isEqualToArray:@[@2,@0]]);
        CHECK(!owner.adapter.acceptEmptySource);
    }
    EntryOwner *owner=Page(); Source.firstObject.ad=YES; Load(owner);
    FilterAds=YES; Source=nil; [owner.adapter update];
    CHECK(owner.adapter.cards.count==1 && !owner.adapter.cards.firstObject.item.ad);
}
static void TestPresentationGuards(void) {
    EntryOwner *owner=Page(); owner.isViewLoaded=YES; AccountCurrent=NO;
    [owner.adapter update]; CHECK(!owner.adapter.attached && owner.adapter.cards.count==0);
    owner=Page(); owner.isViewLoaded=YES; Enabled=NO;
    [owner.adapter update]; CHECK(owner.adapter.detaches==1 && owner.adapter.attaches==0);
    owner=Page(); owner.isViewLoaded=YES; owner.expandableHeader=[UIView new]; owner.expandableHeader.superview=owner.view;
    [owner.adapter update]; CHECK(!owner.adapter.attached && owner.adapter.attaches==0);
}
static void TestRemarkChangeReloadsTheSameNativeItem(void) {
    EntryOwner *owner=Page(); EntryItem *item=Source.firstObject;
    item.username=@"author"; item.nickname=@"朋友圈昵称"; EntryRemarks=@{@"author":@"联系人备注"};
    Load(owner);
    CHECK(owner.adapter.cards.firstObject.item==item && [owner.adapter.cards.firstObject.nickname isEqual:@"联系人备注"]);
    CHECK(owner.adapter.collection.reloads==1);
    EntryRemarks=@{@"author":@"新备注"}; [owner.adapter update];
    CHECK(owner.adapter.cards.firstObject.item==item && [owner.adapter.cards.firstObject.nickname isEqual:@"新备注"]);
    CHECK(owner.adapter.collection.reloads==2);
    EntryRemarks=@{}; [owner.adapter update];
    CHECK([owner.adapter.cards.firstObject.nickname isEqual:@"朋友圈昵称"] && owner.adapter.collection.reloads==3);
    CHECK([item.nickname isEqual:@"朋友圈昵称"]);
}
int main(void) { @autoreleasepool {
    Pending=[NSMutableArray new]; Events=[NSMutableArray new];
    TestSynchronousPreWindowEntry(); TestLocalNativeCompositionBeforeFirstFrame(); TestDelayedColdSource();
    TestUnavailableFacadeAndPreparationABIFallback();
    TestPushReturnAndReentryKeepAcceptedCards(); TestConfirmedEmptyCanRemoveLastCard();
    TestPrivacyAndAccountInvalidationCannotReuseCards(); TestPresentationGuards();
    TestRemarkChangeReloadsTheSameNativeItem();
    printf("Moments entry: %lu checks passed (production entry/update/disappearance/resume, initial native local composition, nil/temporary-empty retention, real empty acceptance and privacy/account invalidation).\n",(unsigned long)Assertions);
    return 0;
} }
