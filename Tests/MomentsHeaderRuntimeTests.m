#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>
#import "CSMomentsFadeGeometry.h"
#import "CSCloseFriendSignatures.h"

static NSUInteger Checks;
#define CHECK(...) do { Checks++; if(!(__VA_ARGS__)) { \
    fprintf(stderr,"Moments header runtime FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); \
} } while(0)

// Native views and image availability are boundary doubles; adapter ownership,
// account admission, native callback routing and hook chaining are production.
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic) BOOL clipsToBounds;
- (void)layoutSubviews;
@property(nonatomic) CGFloat pullDistance,appliedTop;
@property(nonatomic) BOOL imageReady;
@property(nonatomic) NSUInteger applies,removes;
@end
@implementation UIView
- (void)layoutSubviews {}
@end
@interface UITableView : UIView
@property(nonatomic,strong) UIView *tableHeaderView;
@property(nonatomic) double topInsetUnderContentViewY;
@property(nonatomic) BOOL shouldSynchronizeTopContentInsetWithLayout;
@end
@implementation UITableView @end
@interface NativeOwner : NSObject
@property(nonatomic) BOOL wcautoAdjustsScrollViewInsets,throwsOnRead;
@property(nonatomic) double contentViewY;
@end
@implementation NativeOwner
- (double)getContentViewY {
    if(self.throwsOnRead)[NSException raise:@"fixture" format:@"unavailable native geometry"];
    return self.contentViewY;
}
@end
@interface UICollectionView : UIView
@property(nonatomic) CGPoint contentOffset;
@end
@implementation UICollectionView @end
@interface CSMomentsMasonryLayout : NSObject
@property(nonatomic) CGFloat headerHeight;
@property(nonatomic,readonly) CGFloat firstCardTop;
@end
@implementation CSMomentsMasonryLayout
- (CGFloat)firstCardTop { return self.headerHeight+8; }
@end
@interface CSMomentsSupplement : UIView
@property(nonatomic,strong) UIView *embedded,*button;
@end
@implementation CSMomentsSupplement
#include "MomentsHeaderSupplementMethod.h"
@end
@interface CSMomentsLayoutAdapter : NSObject
@property(nonatomic,strong) id owner;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) UICollectionView *collection;
@property(nonatomic,strong) UIView *headerContainer;
@property(nonatomic,strong) UIView *backdropContainer;
@property(nonatomic,strong) CSMomentsMasonryLayout *layout;
- (void)layoutHeaderViewport;
@property(nonatomic,strong) UIView *backdropHeader;
@property(nonatomic) CGFloat nativeHeaderTop,nativeRestingTop;
@property(nonatomic) BOOL attached,current;
- (BOOL)isCurrent;
- (void)updateHeaderBackdrop;
@end
static BOOL Enabled=YES,AccountCurrent=YES;
static NSMutableArray<NSString *> *Events;
static BOOL Matches(id object,NSString *name,const char *types) {
    return object && CSCloseFriendMethodMatches(class_getInstanceMethod([object class],NSSelectorFromString(name)),types);
}
static id Read(id object,NSString *name) {
    return Matches(object,name,"B@:") ? @(((BOOL(*)(id,SEL))objc_msgSend)(object,NSSelectorFromString(name))) : nil;
}
#include "MomentsNativeHeaderInset.h"
static BOOL CSMomentsHeaderBackdropApply(UIView *header,UIView *contentBackground,CGFloat headerTop,CGFloat firstCardTop) {
    CHECK(NSThread.isMainThread);
    CHECK(contentBackground!=nil && isfinite(firstCardTop));
    header.applies++;
    header.appliedTop=headerTop;
    [Events addObject:@"apply"];
    return header.imageReady;
}
static void CSMomentsHeaderBackdropSetPullDistance(UIView *header,CGFloat distance) {
    if(header)header.pullDistance=distance;
}
static void CSMomentsHeaderBackdropRemove(UIView *header) {
    CHECK(NSThread.isMainThread);
    if(header)header.removes++;
    if(header)[Events addObject:@"remove"];
}
@implementation CSMomentsLayoutAdapter
- (BOOL)isCurrent { return self.current && Enabled && AccountCurrent; }
#include "MomentsHeaderRuntimeMethod.h"
@end

static NSHashTable<CSMomentsLayoutAdapter *> *Adapters;
static NSMutableArray<dispatch_block_t> *Pending;
static IMP HeaderHook;
static NSUInteger OriginalCalls;
static SEL LastOriginalSelector;
static void NativeHeaderUpdate(id header,SEL selector) {
    CHECK([header isKindOfClass:UIView.class]);
    OriginalCalls++; LastOriginalSelector=selector;
    [Events addObject:@"native"];
}
static BOOL Install(NSString *className,NSString *name,const char *types,IMP replacement,IMP *original,BOOL meta) {
    CHECK([className isEqual:@"WCListHeaderView"] && name.length && strcmp(types,"v@:")==0 && !meta);
    HeaderHook=replacement; *original=(IMP)NativeHeaderUpdate; return YES;
}
static void CaptureAsync(dispatch_queue_t queue,dispatch_block_t block) {
    CHECK(queue==dispatch_get_main_queue());
    [Pending addObject:[block copy]];
}
#define dispatch_async CaptureAsync
#include "MomentsHeaderRuntimeHooks.h"
#undef dispatch_async

static CSMomentsLayoutAdapter *Adapter(void) {
    CSMomentsLayoutAdapter *adapter=[CSMomentsLayoutAdapter new];
    adapter.attached=adapter.current=YES;
    adapter.table=[UITableView new];
    adapter.table.tableHeaderView=[UIView new];
    adapter.table.tableHeaderView.imageReady=YES;
    adapter.backdropContainer=[UIView new];
    adapter.layout=[CSMomentsMasonryLayout new];
    return adapter;
}
static void Reset(void) {
    Enabled=AccountCurrent=YES;
    Adapters=[NSHashTable weakObjectsHashTable];
    Events=[NSMutableArray new]; Pending=[NSMutableArray new];
    OriginalCalls=0; LastOriginalSelector=NULL;
}
static void TestHeaderOwnershipAndAdmission(void) {
    Reset();
    CSMomentsLayoutAdapter *adapter=Adapter();
    UIView *first=adapter.table.tableHeaderView;
    [adapter updateHeaderBackdrop];
    CHECK(adapter.backdropHeader==first && first.applies==1 && first.removes==0);
    [adapter updateHeaderBackdrop];
    CHECK(adapter.backdropHeader==first && first.applies==2 && first.removes==0);

    UIView *next=[UIView new]; next.imageReady=YES;
    adapter.table.tableHeaderView=next;
    [adapter updateHeaderBackdrop];
    CHECK(first.removes==1 && next.applies==1 && adapter.backdropHeader==next);
    Enabled=NO; [adapter updateHeaderBackdrop];
    CHECK(next.applies==1 && next.removes==1 && !adapter.backdropHeader);
    Enabled=YES; [adapter updateHeaderBackdrop];
    CHECK(next.applies==2 && adapter.backdropHeader==next);
    AccountCurrent=NO; [adapter updateHeaderBackdrop];
    CHECK(next.applies==2 && next.removes==2 && !adapter.backdropHeader);
    AccountCurrent=YES; [adapter updateHeaderBackdrop];
    adapter.current=NO; [adapter updateHeaderBackdrop];
    CHECK(next.applies==3 && next.removes==3 && !adapter.backdropHeader);
    adapter.current=YES; [adapter updateHeaderBackdrop];
    adapter.attached=NO; [adapter updateHeaderBackdrop];
    CHECK(next.removes==4 && !adapter.backdropHeader);
    adapter.attached=YES; [adapter updateHeaderBackdrop];
    adapter.table.tableHeaderView=nil; [adapter updateHeaderBackdrop];
    CHECK(next.removes==5 && !adapter.backdropHeader);
}
static void TestDelayedImageAndCallbackIsolation(void) {
    Reset();
    CSMomentsLayoutAdapter *adapter=Adapter(),*other=Adapter(),*detached=Adapter();
    [Adapters addObject:adapter]; [Adapters addObject:other]; [Adapters addObject:detached];
    UIView *header=adapter.table.tableHeaderView;
    header.imageReady=NO;
    RefreshHeaderBackdrop(header);
    CHECK(header.applies==1 && header.removes==1 && !adapter.backdropHeader);
    header.imageReady=YES;
    RefreshHeaderBackdrop(header);
    CHECK(header.applies==2 && adapter.backdropHeader==header);
    CHECK(other.table.tableHeaderView.applies==0 && detached.table.tableHeaderView.applies==0);
    RefreshHeaderBackdrop([UIView new]); RefreshHeaderBackdrop(nil);
    CHECK(header.applies==2 && other.table.tableHeaderView.applies==0);
    detached.attached=NO;
    RefreshHeaderBackdrop(detached.table.tableHeaderView);
    CHECK(detached.table.tableHeaderView.applies==0);

    // A callback for a retired header must never apply its image to a new one.
    UIView *replacement=[UIView new]; replacement.imageReady=YES;
    adapter.table.tableHeaderView=replacement;
    RefreshHeaderBackdrop(header);
    CHECK(replacement.applies==0 && header.applies==2);
    RefreshHeaderBackdrop(replacement);
    CHECK(header.removes==2 && replacement.applies==1 && adapter.backdropHeader==replacement);
}
static void TestNativeHookOrderAndMainQueueDelivery(void) {
    Reset();
    CSMomentsLayoutAdapter *adapter=Adapter(); [Adapters addObject:adapter];
    UIView *header=adapter.table.tableHeaderView;
    HookHeaderBackdrop(@"reloadBackGround");
    ((void(*)(id,SEL))HeaderHook)(header,@selector(reloadBackGround));
    CHECK(OriginalCalls==1 && LastOriginalSelector==@selector(reloadBackGround));
    CHECK([Events.firstObject isEqual:@"native"] && [Events.lastObject isEqual:@"apply"]);
    CHECK(header.applies==1 && Pending.count==0);
    [Events removeAllObjects];
    HookHeaderBackdrop(@"updateframe");
    dispatch_semaphore_t done=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        ((void(*)(id,SEL))HeaderHook)(header,@selector(updateframe));
        dispatch_semaphore_signal(done);
    });
    dispatch_semaphore_wait(done,DISPATCH_TIME_FOREVER);
    CHECK(OriginalCalls==2 && LastOriginalSelector==@selector(updateframe));
    CHECK(header.applies==1 && Pending.count==1 && [Events isEqual:@[@"native"]]);
    dispatch_block_t queued=Pending.firstObject; [Pending removeAllObjects]; queued();
    CHECK(header.applies==2 && [Events.lastObject isEqual:@"apply"]);

    // Admission is rechecked when a delayed native callback reaches the main queue.
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        ((void(*)(id,SEL))HeaderHook)(header,@selector(updateframe));
        dispatch_semaphore_signal(done);
    });
    dispatch_semaphore_wait(done,DISPATCH_TIME_FOREVER);
    AccountCurrent=NO;
    queued=Pending.firstObject; [Pending removeAllObjects]; queued();
    CHECK(header.applies==2 && header.removes==1 && !adapter.backdropHeader);
}
static void TestPullDownViewport(void) {
    CSMomentsLayoutAdapter *adapter=Adapter();
    adapter.collection=[UICollectionView new];
    adapter.headerContainer=[UIView new];
    adapter.headerContainer.clipsToBounds=YES;
    adapter.layout=[CSMomentsMasonryLayout new];
    adapter.layout.headerHeight=335;
    adapter.collection.bounds=CGRectMake(0,0,430,932);
    CSMomentsSupplement *supplement=[CSMomentsSupplement new];
    supplement.bounds=CGRectMake(0,0,430,335);
    supplement.embedded=adapter.headerContainer;
    adapter.headerContainer.superview=supplement;
    for(NSNumber *offset in @[@120,@0,@-22,@-88,@-180,@-400,@-60,@0]) {
        CGFloat pull=MAX(0,-offset.doubleValue);
        adapter.collection.contentOffset=CGPointMake(0,offset.doubleValue);
        [adapter layoutHeaderViewport];
        CHECK(CGRectGetMinY(adapter.headerContainer.frame)==-pull);
        CHECK(adapter.table.tableHeaderView.pullDistance==pull);
        CHECK(CGRectGetMaxY(adapter.headerContainer.frame)==335);
        CHECK(CGRectEqualToRect(adapter.backdropContainer.frame,CGRectMake(0,0,430,387)));
        CHECK(CGRectGetMinY(adapter.table.frame)==pull && CGRectGetHeight(adapter.table.frame)==932);
        CHECK(!adapter.table.clipsToBounds && adapter.headerContainer.clipsToBounds);
        // A negative native top is revealed as the collection moves downward,
        // while the native rows' first y remains exactly at the clipping edge.
        CGRect visibleCover=CGRectIntersection(CGRectMake(0,0,430,335+pull),CGRectMake(0,pull-88,430,374));
        CHECK(CGRectGetHeight(visibleCover)==MIN(374,286+pull));
        CHECK(CGRectGetMinY(adapter.table.frame)+335==CGRectGetHeight(adapter.headerContainer.frame));
        [supplement layoutSubviews];
        CHECK(CGRectGetMinY(adapter.headerContainer.frame)==-pull && CGRectGetMaxY(adapter.headerContainer.frame)==335);
    }
    UIView *newOwner=[UIView new];
    adapter.headerContainer.superview=newOwner;
    CGRect transferred=adapter.headerContainer.frame;
    supplement.bounds=CGRectMake(0,0,100,100);
    [supplement layoutSubviews];
    CHECK(CGRectEqualToRect(transferred,adapter.headerContainer.frame));
    adapter.collection.contentOffset=CGPointMake(0,NAN);
    [adapter layoutHeaderViewport];
    CHECK(isfinite(CGRectGetMinY(adapter.headerContainer.frame)));
    adapter.attached=NO;
    CGRect saved=adapter.table.frame;
    [adapter layoutHeaderViewport];
    CHECK(CGRectEqualToRect(saved,adapter.table.frame));
}
static void TestRetiredHeaderLifetime(void) {
    Reset(); CSMomentsLayoutAdapter *adapter=Adapter();
    __weak UIView *retired=adapter.table.tableHeaderView;
    [adapter updateHeaderBackdrop]; adapter.table.tableHeaderView=[UIView new];
    CHECK(retired!=nil); // Owner survives until its independent photo is removed.
    [adapter updateHeaderBackdrop]; CHECK(retired==nil);
}
static void TestNativeCoverHeightAndReflow(void) {
    Reset(); CSMomentsLayoutAdapter *adapter=Adapter();
    adapter.collection=[UICollectionView new]; adapter.collection.bounds=CGRectMake(0,0,430,932);
    adapter.headerContainer=[UIView new];
    UIView *header=adapter.table.tableHeaderView;
    header.frame=CGRectMake(0,0,430,335);
    NativeOwner *owner=[NativeOwner new]; owner.wcautoAdjustsScrollViewInsets=YES; owner.contentViewY=103;
    adapter.owner=owner; adapter.table.shouldSynchronizeTopContentInsetWithLayout=YES;
    [Adapters addObject:adapter];
    for(NSNumber *offset in @[@0,@-44,@-180,@100,@0]) {
        adapter.collection.contentOffset=CGPointMake(0,offset.doubleValue);
        [adapter updateHeaderBackdrop];
        CGFloat pull=MAX(0,-offset.doubleValue);
        CHECK(adapter.nativeHeaderTop==103 && adapter.layout.headerHeight==438);
        CHECK(header.appliedTop==103);
        CHECK(adapter.layout.firstCardTop==446);
        CHECK(CGRectGetMinY(adapter.table.frame)==pull+103);
        CHECK(CGRectGetMinY(adapter.headerContainer.frame)+CGRectGetMinY(adapter.table.frame)==103);
        CHECK(CGRectGetMaxY(adapter.headerContainer.frame)==438);
        CHECK(CGRectGetMinY(adapter.table.frame)+335==CGRectGetHeight(adapter.headerContainer.frame));
    }
    // Native layout and image-ready callbacks refresh dimensions together.
    header.frame=CGRectMake(0,0,844,315); owner.contentViewY=44; header.imageReady=NO;
    RefreshHeaderBackdrop(header);
    CHECK(adapter.layout.headerHeight==359 && adapter.nativeHeaderTop==44 && adapter.layout.firstCardTop==367);
    header.imageReady=YES; RefreshHeaderBackdrop(header);
    CHECK(adapter.layout.headerHeight==359 && adapter.backdropHeader==header);
    UIView *replacement=[UIView new]; replacement.frame=CGRectMake(0,0,430,335);
    adapter.table.tableHeaderView=replacement; RefreshHeaderBackdrop(replacement);
    CHECK(adapter.nativeHeaderTop==44 && adapter.layout.headerHeight==379);
    CHECK(CGRectGetMinY(adapter.table.frame)==44);
}
static void TestNativeInsetSourceAndFallback(void) {
    NativeOwner *owner=[NativeOwner new]; UITableView *table=[UITableView new];
    owner.wcautoAdjustsScrollViewInsets=YES; owner.contentViewY=103;
    table.shouldSynchronizeTopContentInsetWithLayout=YES;
    CHECK(NativeHeaderTopInset(owner,table,0)==103); // Before first window/layout.
    table.topInsetUnderContentViewY=12;
    CHECK(NativeHeaderTopInset(owner,table,0)==115);
    table.topInsetUnderContentViewY=-12;
    CHECK(NativeHeaderTopInset(owner,table,0)==103);
    CHECK(NativeHeaderTopInset(owner,table,180)==103);
    table.shouldSynchronizeTopContentInsetWithLayout=NO;
    CHECK(NativeHeaderTopInset(owner,table,180)==180);
    owner.wcautoAdjustsScrollViewInsets=NO;
    CHECK(NativeHeaderTopInset(owner,table,88)==88);
    owner.wcautoAdjustsScrollViewInsets=YES; owner.contentViewY=NAN;
    CHECK(NativeHeaderTopInset(owner,table,88)==88);
    owner.contentViewY=103; table.topInsetUnderContentViewY=NAN;
    CHECK(NativeHeaderTopInset(owner,table,88)==88);
    table.topInsetUnderContentViewY=0; owner.throwsOnRead=YES;
    CHECK(NativeHeaderTopInset(owner,table,88)==88);
    CHECK(NativeHeaderTopInset([NSObject new],table,88)==88);
    CHECK(NativeHeaderTopInset(nil,table,NAN)==0);
    CHECK(NativeHeaderTopInset(nil,table,-10)==0);
}
int main(void) { @autoreleasepool {
    TestNativeInsetSourceAndFallback();
    TestNativeCoverHeightAndReflow();
    TestRetiredHeaderLifetime();
    TestPullDownViewport();
    TestHeaderOwnershipAndAdmission();
    TestDelayedImageAndCallbackIsolation();
    TestNativeHookOrderAndMainQueueDelivery();
    printf("Moments header runtime: %lu checks passed (production ownership, replacement, image readiness, account/setting admission, callback isolation and native hook chaining).\n",(unsigned long)Checks);
    return 0;
} }
