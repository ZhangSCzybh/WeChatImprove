#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>

static NSUInteger Assertions;
#define CHECK(...) do { Assertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "Moments position FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)
static BOOL Near(CGFloat a, CGFloat b) { return fabs(a-b)<0.000001; }

typedef struct { CGFloat top, left, bottom, right; } UIEdgeInsets;
static UIEdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    return (UIEdgeInsets){top,left,bottom,right};
}

@interface NSIndexPath (MomentsUIKitBoundary)
@property(nonatomic, readonly) NSInteger item;
+ (instancetype)indexPathForItem:(NSInteger)item inSection:(NSInteger)section;
@end
@implementation NSIndexPath (MomentsUIKitBoundary)
- (NSInteger)item { return (NSInteger)[self indexAtPosition:1]; }
+ (instancetype)indexPathForItem:(NSInteger)item inSection:(NSInteger)section {
    NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)item};
    return [self indexPathWithIndexes:indexes length:2];
}
@end
static NSIndexPath *Path(NSInteger index) { return [NSIndexPath indexPathForItem:index inSection:0]; }

@interface MomentsAttributesDouble : NSObject
@property(nonatomic) CGRect frame;
@end
@implementation MomentsAttributesDouble @end
#define UICollectionViewLayoutAttributes MomentsAttributesDouble

@interface CSMomentsCardCell : NSObject
@property(nonatomic) NSUInteger ends;
- (void)endDisplaying;
@end
@implementation CSMomentsCardCell
- (void)endDisplaying { self.ends++; }
@end
@interface MomentsHeaderDouble : NSObject
@property(nonatomic) BOOL hidden;
@end
@implementation MomentsHeaderDouble @end

// UIKit boundary only: tests provide layout frames. No anchor selection or
// restoration is implemented here; those decisions come from production below.
@interface MomentsCollectionDouble : NSObject
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic) CGSize contentSize, pendingContentSize;
@property(nonatomic) CGRect bounds;
@property(nonatomic) UIEdgeInsets adjustedContentInset;
@property(nonatomic, copy) NSArray<NSIndexPath *> *indexPathsForVisibleItems;
@property(nonatomic, copy) NSArray<CSMomentsCardCell *> *visibleCells;
@property(nonatomic, copy) NSDictionary<NSIndexPath *,MomentsAttributesDouble *> *attributes, *pendingAttributes;
@property(nonatomic) NSUInteger layouts, offsetSets, reloads, deselections;
@property(nonatomic) BOOL lastAnimated;
- (MomentsAttributesDouble *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path;
- (void)layoutIfNeeded;
- (void)reloadData;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (void)deselectItemAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated;
@end
@implementation MomentsCollectionDouble
- (MomentsAttributesDouble *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path { return self.attributes[path]; }
- (void)layoutIfNeeded {
    self.layouts++;
    if (self.pendingAttributes) {
        self.attributes=self.pendingAttributes;
        self.contentSize=self.pendingContentSize;
        self.pendingAttributes=nil;
    }
}
- (void)reloadData {
    self.reloads++;
    self.attributes=@{}; self.pendingAttributes=nil;
    self.indexPathsForVisibleItems=@[]; self.visibleCells=@[];
    self.contentSize=CGSizeZero;
    // UIKit can clamp an emptied collection to its top before data returns.
    self.contentOffset=CGPointMake(self.contentOffset.x,-self.adjustedContentInset.top);
}
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated {
    self.offsetSets++; self.lastAnimated=animated; self.contentOffset=offset;
}
- (void)deselectItemAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated {
    (void)path; (void)animated; self.deselections++;
}
@end
#define UICollectionView MomentsCollectionDouble

@interface MomentsNativeItem : NSObject
@property(nonatomic, copy) NSArray *mediaItems;
@property(nonatomic) BOOL video, hidden, ad;
@end
@implementation MomentsNativeItem @end
@interface CSMomentsCardModel : NSObject
@property(nonatomic, strong) MomentsNativeItem *item;
@property(nonatomic, strong) id media;
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic) NSUInteger epoch, revision;
@end
@implementation CSMomentsCardModel @end
@interface CSCloseFriendSnapshot : NSObject
@property(nonatomic) NSUInteger revision;
@end
@implementation CSCloseFriendSnapshot @end
@interface MomentsOwnerDouble : NSObject
@property(nonatomic) NSUInteger detailCalls;
@property(nonatomic) BOOL allowsDetails;
@property(nonatomic, copy) NSString *selector;
@property(nonatomic, strong) id item;
@end
@implementation MomentsOwnerDouble @end
@interface MomentsFacadeDouble : NSObject
@property(nonatomic, strong) id source;
@end
@implementation MomentsFacadeDouble @end

enum { CSCloseFriendSurfaceTimeline=1, CSAdPurificationMoments=2 };
static CSCloseFriendSnapshot *Snapshot;
static MomentsFacadeDouble *Facade;
static BOOL FilterAds;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return Snapshot; }
static BOOL CSCFSocialHidden(MomentsNativeItem *item, NSInteger surface) {
    CHECK(surface==CSCloseFriendSurfaceTimeline); return item.hidden;
}
static BOOL CSAdPurificationShouldApply(NSInteger surface) {
    CHECK(surface==CSAdPurificationMoments); return FilterAds;
}
static id CurrentFacade(void) { return Facade; }
static id Read(id object, NSString *key) {
    if ([key isEqual:@"getTimelineDataItem"]) return ((MomentsFacadeDouble *)object).source;
    CHECK([key isEqual:@"isAd"]);
    return @(((MomentsNativeItem *)object).ad);
}
static BOOL Call1(MomentsOwnerDouble *owner, NSString *selector, id item) {
    if(!owner.allowsDetails)return NO;
    owner.detailCalls++; owner.selector=selector; owner.item=item; return YES;
}

@interface CSMomentsLayoutAdapter : NSObject
@property(nonatomic, strong) MomentsOwnerDouble *owner;
@property(nonatomic, strong) MomentsCollectionDouble *collection;
@property(nonatomic, strong) MomentsHeaderDouble *headerContainer;
@property(nonatomic, weak) MomentsHeaderDouble *backdropHeader;
@property(nonatomic, copy) NSArray<CSMomentsCardModel *> *cards;
@property(nonatomic) BOOL attached, current, suspended, positionPending, positionAwaitingReturn;
@property(nonatomic) BOOL acceptEmptySource;
@property(nonatomic) NSUInteger epoch, positionEpoch, updates;
@property(nonatomic) CGFloat positionOffsetY, positionDelta;
@property(nonatomic, weak) id positionItem;
@property(nonatomic, copy) NSString *positionIdentifier;
- (BOOL)isCurrent;
- (void)scheduleUpdate;
- (void)update;
- (void)resumePresentation;
- (void)stopVideoPlayback;
- (void)clearPresentation;
- (void)capturePosition;
- (void)restorePosition;
- (void)forgetPosition;
- (void)collectionView:(UICollectionView *)view didSelectItemAtIndexPath:(NSIndexPath *)path;
@end

static void CSMomentsHeaderBackdropRemove(MomentsHeaderDouble *header) { (void)header; }
#include "MomentsPositionInsets.h"
@implementation CSMomentsLayoutAdapter
- (BOOL)isCurrent { return self.current; }
- (void)scheduleUpdate { self.updates++; }
- (void)stopVideoPlayback {}
// Data/layout are supplied by UIKit boundary doubles; update reaches the real
// restoration method after the real resume method releases its lifecycle gate.
- (void)update { self.updates++; [self restorePosition]; }
#include "MomentsPositionBodies.h"
@end

static NSDictionary *Frames(NSArray<NSValue *> *frames) {
    NSMutableDictionary *attributes=[NSMutableDictionary new];
    [frames enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger index, BOOL *stop) {
        (void)stop;
        MomentsAttributesDouble *item=[MomentsAttributesDouble new];
        CGRect frame;
        [value getValue:&frame size:sizeof(frame)];
        item.frame=frame;
        attributes[Path((NSInteger)index)]=item;
    }];
    return attributes;
}
static NSValue *Frame(CGFloat y, CGFloat height) {
    CGRect frame=CGRectMake(8,y,183,height);
    return [NSValue valueWithBytes:&frame objCType:@encode(CGRect)];
}
static CSMomentsCardModel *Card(NSString *identifier) {
    CSMomentsCardModel *card=[CSMomentsCardModel new];
    card.identifier=identifier; card.epoch=7; card.revision=12;
    card.item=[MomentsNativeItem new];
    card.item.mediaItems=@[[NSObject new],[NSObject new],[NSObject new]];
    card.media=card.item.mediaItems.firstObject;
    return card;
}
static CSMomentsLayoutAdapter *Page(void) {
    Snapshot=[CSCloseFriendSnapshot new]; Snapshot.revision=12;
    Facade=[MomentsFacadeDouble new]; FilterAds=YES;
    CSMomentsLayoutAdapter *page=[CSMomentsLayoutAdapter new];
    page.owner=[MomentsOwnerDouble new];
    page.owner.allowsDetails=YES;
    page.headerContainer=[MomentsHeaderDouble new];
    page.attached=page.current=YES; page.epoch=7;
    page.cards=@[Card(@"A"),Card(@"B"),Card(@"C"),Card(@"D")];
    Facade.source=[page.cards valueForKey:@"item"];
    page.collection=[MomentsCollectionDouble new];
    page.collection.bounds=CGRectMake(0,0,390,600);
    page.collection.adjustedContentInset=UIEdgeInsetsMake(0,8,34,9);
    page.collection.contentSize=CGSizeMake(390,2000);
    page.collection.contentOffset=CGPointMake(7,700);
    page.collection.attributes=Frames(@[Frame(300,300),Frame(620,260),Frame(640,350),Frame(900,200)]);
    // Unsorted visible paths include a fully scrolled-out card, an item below
    // the viewport top and invalid paths, as a defensive UIKit boundary case.
    page.collection.indexPathsForVisibleItems=@[Path(3),Path(0),Path(2),Path(1),Path(99),Path(-1)];
    page.collection.visibleCells=@[[CSMomentsCardCell new]];
    return page;
}
static void Rebuild(CSMomentsLayoutAdapter *page, NSArray *cards, NSArray *frames, CGFloat contentHeight) {
    page.cards=cards;
    // Publish the new attributes only when production restore forces layout.
    page.collection.pendingAttributes=Frames(frames);
    page.collection.pendingContentSize=CGSizeMake(390,contentHeight);
}
static void CheckRestored(CSMomentsLayoutAdapter *page, CGFloat expectedY) {
    CHECK(Near(page.collection.contentOffset.y,expectedY));
    CHECK(page.collection.contentOffset.x==7 && !page.collection.lastAnimated);
    CHECK(!page.positionPending && !page.positionAwaitingReturn && !page.positionItem && !page.positionIdentifier);
    CHECK(page.collection.layouts==1 && page.collection.offsetSets==1);
}

static void TestCaptureClearAndRestore(void) {
    CSMomentsLayoutAdapter *page=Page();
    NSArray *cards=page.cards;
    CSMomentsCardCell *visible=page.collection.visibleCells.firstObject;
    [page capturePosition];
    CHECK(page.positionPending && page.positionEpoch==7 && page.positionOffsetY==700);
    CHECK(page.positionItem==((CSMomentsCardModel *)cards[1]).item);
    CHECK([page.positionIdentifier isEqual:@"B"] && page.positionDelta==80);
    [page clearPresentation];
    CHECK(visible.ends==1 && page.cards.count==0 && page.collection.reloads==1);
    CHECK(page.collection.contentSize.height==0 && page.collection.contentOffset.y==0);
    [page capturePosition];
    CHECK(page.positionOffsetY==700 && page.positionDelta==80);
    Rebuild(page,cards,@[Frame(300,300),Frame(620,260),Frame(640,350),Frame(900,200)],2000);
    [page resumePresentation];
    CheckRestored(page,700);
    [page resumePresentation];
    CHECK(page.collection.offsetSets==1);
}

static void TestPushReloadCannotConsumeAnchor(void) {
    CSMomentsLayoutAdapter *page=Page();
    NSArray *cards=page.cards;
    [page capturePosition];
    CHECK(page.positionPending && page.positionAwaitingReturn);
    // Native reload callbacks can reach update while the push transition is
    // still showing this page. They must not spend its eventual return anchor.
    [page update];
    CHECK(page.positionPending && page.positionAwaitingReturn);
    CHECK(page.collection.layouts==0 && page.collection.offsetSets==0);
    page.suspended=YES;
    [page clearPresentation];
    [page restorePosition];
    CHECK(page.positionPending && page.positionAwaitingReturn && page.collection.contentOffset.y==0);
    Rebuild(page,cards,@[Frame(300,300),Frame(620,260),Frame(640,350),Frame(900,200)],2000);
    [page resumePresentation];
    CHECK(!page.suspended);
    CheckRestored(page,700);
}
static void TestRetainedPresentationRestoresWithoutEmptyReload(void) {
    CSMomentsLayoutAdapter *page=Page();
    NSArray *cards=page.cards;
    CSMomentsCardCell *visible=page.collection.visibleCells.firstObject;
    [page capturePosition]; [page update];
    CHECK(page.positionPending && page.positionAwaitingReturn && page.collection.offsetSets==0);
    page.suspended=YES;
    CHECK(page.cards==cards && page.collection.contentOffset.y==700 && page.collection.reloads==0);
    [page resumePresentation];
    CheckRestored(page,700);
    CHECK(page.cards==cards && page.collection.reloads==0 && visible.ends==0);
}

static void TestInsertDeleteAndMediaHeightChanges(void) {
    for (NSUInteger scenario=0;scenario<3;scenario++) {
        CSMomentsLayoutAdapter *page=Page();
        NSArray *old=page.cards;
        [page capturePosition]; [page clearPresentation];
        if (scenario==0) {
            Rebuild(page,@[Card(@"new"),old[0],old[1],old[2],old[3]],
                @[Frame(300,180),Frame(490,300),Frame(810,260),Frame(830,350),Frame(1090,200)],2300);
            [page resumePresentation]; CheckRestored(page,890);
        } else if (scenario==1) {
            Rebuild(page,@[old[1],old[2],old[3]],@[Frame(320,260),Frame(340,350),Frame(600,200)],1600);
            [page resumePresentation]; CheckRestored(page,400);
        } else {
            Rebuild(page,old,@[Frame(300,500),Frame(820,260),Frame(840,350),Frame(1100,200)],2200);
            [page resumePresentation]; CheckRestored(page,900);
        }
    }
}

static void TestStableIdentifierAndDeletedAnchor(void) {
    CSMomentsLayoutAdapter *page=Page();
    MomentsNativeItem *original=page.cards[1].item;
    [page capturePosition]; [page clearPresentation];
    CSMomentsCardModel *replacement=Card(@"B");
    CHECK(replacement.item!=original && page.positionItem==original);
    Rebuild(page,@[Card(@"X"),replacement],@[Frame(300,500),Frame(820,400)],2000);
    [page resumePresentation]; CheckRestored(page,900);
    for (NSUInteger scenario=0;scenario<2;scenario++) {
        page=Page();
        [page capturePosition]; [page clearPresentation];
        Rebuild(page,@[Card(@"X")],@[Frame(300,100)],scenario ? 800 : 1800);
        [page resumePresentation]; CheckRestored(page,scenario ? 234 : 700);
    }
}

static void TestCoverAbsoluteAndInsetBounds(void) {
    CSMomentsLayoutAdapter *page=Page();
    NSArray *cards=page.cards;
    page.collection.contentOffset=CGPointMake(7,100);
    [page capturePosition];
    CHECK(page.positionPending && !page.positionItem && !page.positionIdentifier && page.positionDelta==0);
    [page clearPresentation];
    Rebuild(page,cards,@[Frame(500,300),Frame(820,260),Frame(840,350),Frame(1100,200)],2200);
    [page resumePresentation]; CheckRestored(page,100);

    page=Page(); cards=page.cards;
    page.collection.adjustedContentInset=UIEdgeInsetsMake(44,8,34,9);
    page.collection.contentOffset=CGPointMake(7,-40);
    [page capturePosition]; [page clearPresentation];
    Rebuild(page,cards,@[Frame(300,300),Frame(620,260),Frame(640,350),Frame(900,200)],2000);
    [page resumePresentation]; CheckRestored(page,-40);

    page=Page();
    page.collection.adjustedContentInset=UIEdgeInsetsMake(44,8,34,9);
    page.collection.contentOffset=CGPointMake(7,-80);
    [page capturePosition]; [page clearPresentation];
    Rebuild(page,@[],@[],0);
    [page resumePresentation]; CheckRestored(page,-44);
}

static void TestEmptyShortAndUnavailableAttributes(void) {
    CSMomentsLayoutAdapter *page=Page();
    page.cards=@[];
    [page capturePosition]; CHECK(!page.positionPending);
    [page resumePresentation]; CHECK(page.collection.offsetSets==0);

    page=Page();
    [page capturePosition]; [page clearPresentation];
    Rebuild(page,@[],@[],0);
    [page resumePresentation]; CheckRestored(page,0);

    page=Page();
    page.cards=@[Card(@"short")];
    page.collection.contentOffset=CGPointMake(7,20);
    page.collection.contentSize=CGSizeMake(390,150);
    page.collection.attributes=Frames(@[Frame(0,100)]);
    page.collection.indexPathsForVisibleItems=@[Path(0)];
    NSArray *cards=page.cards;
    [page capturePosition]; [page clearPresentation];
    Rebuild(page,cards,@[Frame(0,100)],150);
    [page resumePresentation]; CheckRestored(page,0);

    page=Page(); cards=page.cards;
    page.collection.attributes=@{};
    [page capturePosition];
    CHECK(page.positionPending && !page.positionItem);
    [page clearPresentation];
    Rebuild(page,cards,@[],2000);
    [page resumePresentation]; CheckRestored(page,700);

    page=Page(); cards=page.cards;
    [page capturePosition]; [page clearPresentation];
    Rebuild(page,cards,@[],2000);
    [page resumePresentation]; CheckRestored(page,700);
}

static void TestPositionGuardsAndForget(void) {
    CSMomentsLayoutAdapter *page=Page();
    page.current=NO; [page capturePosition]; CHECK(!page.positionPending);
    page.current=YES; page.attached=NO; [page capturePosition]; CHECK(!page.positionPending);
    page.attached=YES; [page capturePosition];
    [page clearPresentation];
    page.current=NO; [page resumePresentation];
    CHECK(page.positionPending && page.collection.offsetSets==0 && page.collection.layouts==0);
    page.current=YES; page.attached=NO; [page resumePresentation];
    CHECK(page.positionPending && page.collection.offsetSets==0);
    page.attached=YES; page.epoch++;
    [page resumePresentation];
    CHECK(!page.positionPending && !page.positionAwaitingReturn && !page.positionItem && !page.positionIdentifier);
    CHECK(page.collection.offsetSets==0 && page.collection.contentOffset.y==0);

    page=Page();
    [page capturePosition]; [page forgetPosition];
    CHECK(!page.positionPending && !page.positionAwaitingReturn && !page.positionItem && !page.positionIdentifier);
    CHECK(page.collection.offsetSets==0 && page.collection.contentOffset.y==700);

    page=Page();
    page.positionPending=YES; page.positionEpoch=page.epoch; page.positionOffsetY=NAN;
    page.collection.adjustedContentInset=UIEdgeInsetsMake(20,0,0,0);
    [page resumePresentation]; CheckRestored(page,-20);
}

static void TestDetailPassesOriginalMediaItem(void) {
    for (NSUInteger video=0;video<2;video++) {
        CSMomentsLayoutAdapter *page=Page();
        MomentsNativeItem *original=page.cards[1].item;
        original.video=video;
        NSArray *allMedia=original.mediaItems;
        [page collectionView:page.collection didSelectItemAtIndexPath:Path(1)];
        CHECK(page.collection.deselections==1 && page.owner.detailCalls==1);
        CHECK([page.owner.selector isEqual:@"showDetailViewForDataItem:"]);
        CHECK(page.owner.item==original && original.mediaItems==allMedia && original.mediaItems.count==3);
        CHECK(page.positionPending && page.positionOffsetY==700 && page.positionItem==original);
        CHECK(page.cards.count==4 && page.collection.reloads==0 && page.updates==0);
    }
    CSMomentsLayoutAdapter *page=Page();
    page.owner.allowsDetails=NO;
    [page collectionView:page.collection didSelectItemAtIndexPath:Path(1)];
    CHECK(page.owner.detailCalls==0 && !page.positionPending && !page.positionAwaitingReturn);
    CHECK(!page.positionItem && !page.positionIdentifier && page.cards.count==4);
}

static void TestDetailRejectsStaleHiddenAndAds(void) {
    for (NSUInteger reason=0;reason<8;reason++) {
        CSMomentsLayoutAdapter *page=Page();
        CSMomentsCardModel *card=page.cards[1];
        NSIndexPath *path=Path(1);
        if (reason==0) page.current=NO;
        if (reason==1) path=Path(-1);
        if (reason==2) path=Path(99);
        if (reason==3) card.epoch++;
        if (reason==4) card.revision++;
        if (reason==5) card.item.hidden=YES;
        if (reason==6) Facade.source=@[page.cards[0].item];
        if (reason==7) card.item.ad=YES;
        [page collectionView:page.collection didSelectItemAtIndexPath:path];
        CHECK(page.collection.deselections==1 && page.owner.detailCalls==0 && !page.positionPending);
        if (reason>=3 && reason<=5) {
            CHECK(page.collection.reloads==1 && page.cards.count==0 && page.updates==1);
        } else if (reason>=6) {
            CHECK(page.collection.reloads==0 && page.cards.count==4 && page.updates==1);
        } else CHECK(page.updates==0 && page.collection.reloads==0);
    }
    CSMomentsLayoutAdapter *page=Page();
    Facade.source=@"unavailable native source";
    [page collectionView:page.collection didSelectItemAtIndexPath:Path(1)];
    CHECK(page.owner.detailCalls==0 && page.updates==1 && !page.positionPending);
    page=Page(); FilterAds=NO; page.cards[1].item.ad=YES;
    [page collectionView:page.collection didSelectItemAtIndexPath:Path(1)];
    CHECK(page.owner.detailCalls==1 && page.owner.item==page.cards[1].item);
}

static void TestTimelineInsets(void) {
    const UIEdgeInsets input[]={{88,7,34,9},{0,0,0,0},{-20,12,0,13},{44,-3,21,-4}};
    for (NSUInteger i=0;i<sizeof(input)/sizeof(*input);i++) {
        UIEdgeInsets output=TimelineInsets(input[i]);
        CHECK(output.top==0 && output.left==input[i].left && output.bottom==input[i].bottom && output.right==input[i].right);
    }
}

int main(void) {
    @autoreleasepool {
        TestCaptureClearAndRestore();
        TestPushReloadCannotConsumeAnchor();
        TestRetainedPresentationRestoresWithoutEmptyReload();
        TestInsertDeleteAndMediaHeightChanges();
        TestStableIdentifierAndDeletedAnchor();
        TestCoverAbsoluteAndInsetBounds();
        TestEmptyShortAndUnavailableAttributes();
        TestPositionGuardsAndForget();
        TestDetailPassesOriginalMediaItem();
        TestDetailRejectsStaleHiddenAndAds();
        TestTimelineInsets();
        printf("Moments position: %lu checks passed (production capture/clear/restore/forget, push/return lifecycle, anchors, cover offset, bounds, insets, full native detail guards).\n", (unsigned long)Assertions);
    }
    return 0;
}
