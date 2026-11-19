#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>

static NSUInteger Assertions;
#define CHECK(...) do { Assertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr,"Moments playback FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); \
} } while(0)

@interface NSIndexPath (PlaybackUIKitBoundary)
@property(nonatomic,readonly) NSInteger item;
+ (instancetype)indexPathForItem:(NSInteger)item inSection:(NSInteger)section;
@end
@implementation NSIndexPath (PlaybackUIKitBoundary)
- (NSInteger)item { return (NSInteger)[self indexAtPosition:1]; }
+ (instancetype)indexPathForItem:(NSInteger)item inSection:(NSInteger)section {
    NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)item};
    return [self indexPathWithIndexes:indexes length:2];
}
@end
static NSIndexPath *Path(NSInteger item) { return [NSIndexPath indexPathForItem:item inSection:0]; }

// UIKit/native-player boundaries only. Selection, eligibility, pause and resume
// decisions below are extracted directly from the production runtime.
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) BOOL hidden,supported,playing,startsAllowed;
@property(nonatomic) NSUInteger starts,stops;
@property(nonatomic,strong) UIView *cover;
- (CGRect)convertRect:(CGRect)rect toView:(id)view;
@end
@implementation UIView
- (CGRect)convertRect:(CGRect)rect toView:(id)view { (void)rect; (void)view; return self.frame; }
@end
static void CSMomentsHeaderBackdropRemove(UIView *header) { (void)header; }
@interface PlaybackItem : NSObject
@property(nonatomic) BOOL allowed;
@end
@implementation PlaybackItem @end
@interface CSMomentsCardModel : NSObject
@property(nonatomic,strong) PlaybackItem *item;
@property(nonatomic) BOOL video;
@property(nonatomic) NSUInteger epoch,revision;
@end
@implementation CSMomentsCardModel @end
@interface CSMomentsCardCell : NSObject
@property(nonatomic,strong) CSMomentsCardModel *model;
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic) NSUInteger ends;
- (void)endDisplaying;
@end
@implementation CSMomentsCardCell
- (void)endDisplaying { self.ends++; self.contentView.cover=nil; }
@end
@interface PlaybackCollection : NSObject
@property(nonatomic) CGRect bounds;
@property(nonatomic,strong) id window;
@property(nonatomic) BOOL dragging,decelerating;
@property(nonatomic,copy) NSArray<NSIndexPath *> *indexPathsForVisibleItems;
@property(nonatomic,strong) NSMutableDictionary<NSIndexPath *,CSMomentsCardCell *> *cells;
@property(nonatomic,readonly) NSArray<CSMomentsCardCell *> *visibleCells;
@property(nonatomic) NSUInteger reloads;
- (CSMomentsCardCell *)cellForItemAtIndexPath:(NSIndexPath *)path;
- (void)reloadData;
@end
@implementation PlaybackCollection
- (NSArray *)visibleCells { return self.cells.allValues; }
- (CSMomentsCardCell *)cellForItemAtIndexPath:(NSIndexPath *)path { return self.cells[path]; }
- (void)reloadData { self.reloads++; [self.cells removeAllObjects]; }
@end
#define UIScrollView PlaybackCollection
enum { UIApplicationStateActive=0 };
@interface UIApplication : NSObject
@property(nonatomic) NSInteger applicationState;
+ (instancetype)sharedApplication;
@end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if(!app)app=[self new]; return app; }
@end
@interface PlaybackSnapshot : NSObject
@property(nonatomic) NSUInteger revision;
@end
@implementation PlaybackSnapshot @end
static PlaybackSnapshot *Snapshot;
static id Facade;
static NSMutableArray<dispatch_block_t> *Pending;
static id CurrentFacade(void) { return Facade; }
static PlaybackSnapshot *CSCloseFriendCurrentSnapshot(void) { return Snapshot; }
static UIView *CSMomentsVideoCoverViewInView(UIView *view) { return view.cover; }
static BOOL CSMomentsNativeVideoCanAutoPlay(id facade, PlaybackItem *item) {
    CHECK(facade==Facade); return item.allowed;
}
static BOOL CSMomentsSetVideoCoverPlaying(UIView *cover, BOOL playing) {
    if(!cover.supported)return NO;
    if(playing && !cover.startsAllowed)return NO;
    if(playing) { cover.starts++; cover.playing=YES; }
    else { cover.stops++; cover.playing=NO; }
    return YES;
}
static void CaptureAsync(dispatch_queue_t queue,dispatch_block_t block) { (void)queue; [Pending addObject:[block copy]]; }
static void Drain(void) { while(Pending.count) { dispatch_block_t b=Pending.firstObject; [Pending removeObjectAtIndex:0]; b(); } }

@interface CSMomentsLayoutAdapter : NSObject
@property(nonatomic) BOOL current,attached,suspended,positionAwaitingReturn,videoPlaybackQueued;
@property(nonatomic) BOOL acceptEmptySource;
@property(nonatomic) NSUInteger epoch,updates;
@property(nonatomic,strong) PlaybackCollection *collection;
@property(nonatomic,strong) UIView *headerContainer;
@property(nonatomic,strong) UIView *backdropHeader;
@property(nonatomic,copy) NSArray<CSMomentsCardModel *> *cards;
@property(nonatomic,weak) UIView *playingVideoCover;
- (BOOL)isCurrent;
- (void)update;
- (void)stopVideoPlayback;
- (void)scheduleVideoPlayback;
- (void)updateVideoPlayback;
- (void)clearPresentation;
- (void)resumePresentation;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
@end
#define dispatch_async CaptureAsync
@implementation CSMomentsLayoutAdapter
- (BOOL)isCurrent { return self.current; }
- (void)update { self.updates++; [self scheduleVideoPlayback]; }
#include "MomentsPlaybackBodies.h"
@end
#undef dispatch_async

static CSMomentsLayoutAdapter *Page(void) {
    [Pending removeAllObjects];
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    Snapshot=[PlaybackSnapshot new]; Snapshot.revision=12; Facade=[NSObject new];
    CSMomentsLayoutAdapter *page=[CSMomentsLayoutAdapter new];
    page.current=page.attached=YES; page.epoch=7;
    page.headerContainer=[UIView new];
    page.collection=[PlaybackCollection new]; page.collection.window=[NSObject new];
    page.collection.bounds=CGRectMake(0,0,390,600); page.collection.cells=[NSMutableDictionary new];
    NSMutableArray *cards=[NSMutableArray new];
    const CGFloat positions[]={-100,150,400};
    for(NSUInteger index=0;index<3;index++) {
        CSMomentsCardModel *card=[CSMomentsCardModel new];
        card.video=YES; card.epoch=7; card.revision=12;
        card.item=[PlaybackItem new]; card.item.allowed=YES; [cards addObject:card];
        CSMomentsCardCell *cell=[CSMomentsCardCell new]; cell.model=card;
        cell.contentView=[UIView new]; UIView *cover=[UIView new];
        cover.frame=CGRectMake(index%2?200:0,positions[index],180,200); cover.bounds=CGRectMake(0,0,180,200);
        cover.supported=cover.startsAllowed=YES; cell.contentView.cover=cover;
        page.collection.cells[Path((NSInteger)index)]=cell;
    }
    page.cards=cards; page.collection.indexPathsForVisibleItems=@[Path(2),Path(0),Path(1)];
    return page;
}
static UIView *Cover(CSMomentsLayoutAdapter *page,NSInteger index) { return page.collection.cells[Path(index)].contentView.cover; }
static NSUInteger PlayingCount(CSMomentsLayoutAdapter *page) {
    NSUInteger count=0; for(CSMomentsCardCell *cell in page.collection.visibleCells)count+=cell.contentView.cover.playing;
    return count;
}
static void TestSingleCandidateAndStableSelection(void) {
    CSMomentsLayoutAdapter *page=Page(); UIView *first=Cover(page,1),*other=Cover(page,2);
    [page updateVideoPlayback];
    CHECK(page.playingVideoCover==first && first.starts==1 && PlayingCount(page)==1);
    [page updateVideoPlayback]; CHECK(first.starts==1 && first.stops==0);
    first.frame=CGRectMake(200,0,180,200); other.frame=CGRectMake(0,400,180,200);
    // Equal distance is resolved by source index, independent of UIKit's order.
    [page updateVideoPlayback]; CHECK(page.playingVideoCover==first && first.starts==1);
    first.frame=CGRectMake(200,-100,180,200);
    [page updateVideoPlayback]; CHECK(!first.playing && first.stops==1 && page.playingVideoCover==other && PlayingCount(page)==1);
    page.cards[2].item.allowed=NO;
    [page updateVideoPlayback]; CHECK(!other.playing && !page.playingVideoCover && PlayingCount(page)==0);
}
static void TestEligibilityAndFailedStarts(void) {
    for(NSUInteger condition=0;condition<8;condition++) {
        CSMomentsLayoutAdapter *page=Page(); UIView *cover=Cover(page,1);
        page.collection.indexPathsForVisibleItems=@[Path(-1),Path(99),Path(1)];
        if(condition==0)page.cards[1].video=NO;
        if(condition==1)page.cards[1].epoch++;
        if(condition==2)page.cards[1].revision++;
        if(condition==3)page.collection.cells[Path(1)].model=page.cards[0];
        if(condition==4)cover.hidden=YES;
        if(condition==5)cover.frame=CGRectMake(0,NAN,180,200);
        if(condition==6)page.cards[1].item.allowed=NO;
        if(condition==7)cover.startsAllowed=NO;
        [page updateVideoPlayback];
        CHECK(!page.playingVideoCover && !cover.playing && cover.starts==0);
    }
}
static void TestVisibilityAndLifecyclePause(void) {
    for(NSUInteger condition=0;condition<8;condition++) {
        CSMomentsLayoutAdapter *page=Page(); UIView *cover=Cover(page,1);
        [page updateVideoPlayback]; CHECK(cover.playing);
        if(condition==0)page.current=NO;
        if(condition==1)page.attached=NO;
        if(condition==2)page.suspended=YES;
        if(condition==3)page.positionAwaitingReturn=YES;
        if(condition==4)page.collection.window=nil;
        if(condition==5)UIApplication.sharedApplication.applicationState=1;
        if(condition==6)page.collection.dragging=YES;
        if(condition==7)page.collection.decelerating=YES;
        [page updateVideoPlayback];
        CHECK(!cover.playing && !page.playingVideoCover && cover.stops==1);
    }
    CSMomentsLayoutAdapter *page=Page(); UIView *cover=Cover(page,1);
    [page updateVideoPlayback]; page.current=NO; [page clearPresentation];
    CHECK(!cover.playing && !page.playingVideoCover && page.cards.count==0 && page.headerContainer.hidden);
    CHECK(page.collection.reloads==1 && cover.stops==1);
}
static void TestDeferredResumeAndScrollEvents(void) {
    CSMomentsLayoutAdapter *page=Page(); UIView *cover=Cover(page,1);
    [page scheduleVideoPlayback]; [page scheduleVideoPlayback];
    CHECK(Pending.count==1 && page.videoPlaybackQueued && !cover.playing);
    UIApplication.sharedApplication.applicationState=1; Drain();
    CHECK(!cover.playing && !page.videoPlaybackQueued);
    UIApplication.sharedApplication.applicationState=UIApplicationStateActive;
    page.suspended=page.positionAwaitingReturn=YES;
    [page resumePresentation];
    CHECK(!page.suspended && !page.positionAwaitingReturn && page.updates==1 && Pending.count==1);
    Drain(); CHECK(cover.playing);
    [page scrollViewWillBeginDragging:page.collection]; CHECK(!cover.playing);
    [page scrollViewDidEndDragging:page.collection willDecelerate:YES]; CHECK(Pending.count==0);
    [page scrollViewDidEndDecelerating:page.collection]; Drain(); CHECK(cover.playing);
    [page scrollViewWillBeginDragging:page.collection];
    [page scrollViewDidEndDragging:page.collection willDecelerate:NO]; Drain(); CHECK(cover.playing);
    [page stopVideoPlayback]; [page scrollViewDidEndScrollingAnimation:page.collection]; Drain(); CHECK(cover.playing);
    [page scheduleVideoPlayback]; page.suspended=YES; [page stopVideoPlayback]; Drain();
    CHECK(!cover.playing && !page.playingVideoCover);
    [page scrollViewDidEndDecelerating:[PlaybackCollection new]]; CHECK(Pending.count==0);
}
int main(void) { @autoreleasepool {
    Pending=[NSMutableArray new];
    TestSingleCandidateAndStableSelection();
    TestEligibilityAndFailedStarts();
    TestVisibilityAndLifecyclePause();
    TestDeferredResumeAndScrollEvents();
    printf("Moments playback: %lu checks passed (production selection, single native candidate gate, visibility, scroll, background, policy/clear and resume boundaries).\n",(unsigned long)Assertions);
    return 0;
} }
