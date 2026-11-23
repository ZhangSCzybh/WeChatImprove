#import "CSMomentsLayoutRuntime.h"
#import "CSMomentsLayoutPreferences.h"
#import "CSMomentsMasonryLayout.h"
#import "CSMomentsCardCell.h"
#import "CSMomentsCardModel.h"
#import "CSMomentsNativeMedia.h"
#import "CSMomentsNativeVideo.h"
#import "CSMomentsHeaderBackdrop.h"
#import "CSMomentsFadeGeometry.h"
#import "CSMomentsVisualSurface.h"
#import "CSCloseFriendSocialAdapter.h"
#import "CSAdPurification.h"
#import "CSServiceCenter.h"
#import <objc/message.h>
#import <substrate.h>
#include <math.h>

// All presentation state belongs to this page. Native facade/model arrays,
// ownership and persisted Moments data are never changed by this renderer.
static char AdapterKey;
static NSHashTable *Adapters;

static BOOL Matches(id object, NSString *name, const char *types) {
    return object && CSCloseFriendMethodMatches(class_getInstanceMethod([object class],NSSelectorFromString(name)),types);
}
static id Read(id object, NSString *name) {
    if(!object)return nil;
    SEL selector=NSSelectorFromString(name);
    @try {
        Method method=class_getInstanceMethod([object class],selector);
        if(CSCloseFriendMethodMatches(method,"B@:"))return @(((BOOL(*)(id,SEL))objc_msgSend)(object,selector));
        if(CSCloseFriendMethodMatches(method,"i@:"))return @(((int(*)(id,SEL))objc_msgSend)(object,selector));
        if(CSCloseFriendMethodMatches(method,"I@:"))return @(((unsigned int(*)(id,SEL))objc_msgSend)(object,selector));
        if(CSCloseFriendMethodMatches(method,"q@:"))return @(((long long(*)(id,SEL))objc_msgSend)(object,selector));
        if(CSCloseFriendMethodMatches(method,"Q@:"))return @(((unsigned long long(*)(id,SEL))objc_msgSend)(object,selector));
        return CSCloseFriendRead(object,name);
    } @catch(__unused NSException *exception) { return nil; }
}
static BOOL Call0(id owner, NSString *name) {
    if(!Matches(owner,name,"v@:"))return NO;
    ((void(*)(id,SEL))objc_msgSend)(owner,NSSelectorFromString(name)); return YES;
}
static BOOL Call1(id owner, NSString *name, id value) {
    if(!Matches(owner,name,"v@:@"))return NO;
    ((void(*)(id,SEL,id))objc_msgSend)(owner,NSSelectorFromString(name),value); return YES;
}
static UIEdgeInsets TimelineInsets(UIEdgeInsets nativeInsets) {
    // The collection replaces the full-screen native table. A navigation-safe
    // top inset would expose a blank strip above the native cover. Keep the
    // remaining native/safe-area insets, with the cover starting at the top.
    nativeInsets.top=0;
    return nativeInsets;
}
static CGFloat NativeHeaderTopInset(id owner, UITableView *table, CGFloat savedTop) {
    CGFloat fallback=isfinite(savedTop) ? MAX(0,savedTop) : 0;
    // MMUIViewController -adjustTableViewInset: uses getContentViewY plus a
    // positive MMTableView topInsetUnderContentViewY. Read those same values
    // even before the first window/layout pass; our embedded table has zero
    // insets, so its adjustedContentInset is no longer a native reference.
    if(!Matches(owner,@"wcautoAdjustsScrollViewInsets","B@:") ||
       ![Read(owner,@"wcautoAdjustsScrollViewInsets") boolValue] ||
       !Matches(owner,@"getContentViewY","d@:"))return fallback;
    @try {
        CGFloat top=((double(*)(id,SEL))objc_msgSend)(owner,NSSelectorFromString(@"getContentViewY"));
        if(Matches(table,@"topInsetUnderContentViewY","d@:")) {
            CGFloat extra=((double(*)(id,SEL))objc_msgSend)(table,NSSelectorFromString(@"topInsetUnderContentViewY"));
            if(!isfinite(extra))return fallback;
            top+=MAX(0,extra);
        }
        if(!isfinite(top) || top<0)return fallback;
        // Synchronizing tables replace the top inset on layout. Other native
        // tables retain a larger configured inset, matching the native branch.
        return [Read(table,@"shouldSynchronizeTopContentInsetWithLayout") boolValue] ? top : MAX(top,fallback);
    } @catch(__unused NSException *exception) { return fallback; }
}
static id CurrentService(Class cls) {
    if(!cls)return nil;
    Class contextClass=NSClassFromString(@"MMContext");
    SEL current=NSSelectorFromString(@"currentContext"),service=NSSelectorFromString(@"getService:");
    @try {
        id center=nil;
        Method accessor=class_getClassMethod(contextClass,current);
        if(accessor) {
            if(!CSCloseFriendMethodMatches(accessor,"@@:"))return nil;
            id context=((id(*)(id,SEL))objc_msgSend)(contextClass,current);
            // An existing currentContext returning nil means logged out. Do not
            // fall back to a previous account's default service center.
            if(!context)return nil;
            center=Matches(context,@"getService:","@@:#") ? context : Read(context,@"serviceCenter");
        } else center=CSGetServiceCenter();
        if(!Matches(center,@"getService:","@@:#"))return nil;
        id instance=((id(*)(id,SEL,Class))objc_msgSend)(center,service,cls);
        return [instance isKindOfClass:cls] ? instance : nil;
    } @catch(__unused NSException *exception) { return nil; }
}
static id CurrentFacade(void) { return CurrentService(NSClassFromString(@"WCFacade")); }
static void ApplyContactRemarks(NSArray<CSMomentsCardModel *> *cards) {
    if(!cards.count)return;
    id manager=CurrentService(NSClassFromString(@"CContactMgr"));
    if(!Matches(manager,@"getContactByName:","@@:@"))return;
    // A page update can contain several posts from the same author. Cache only
    // for this projection, including misses, so edited remarks refresh later.
    NSMutableDictionary<NSString *,NSString *> *remarks=[NSMutableDictionary new];
    for(CSMomentsCardModel *card in cards) {
        NSString *username=card.username;
        if(![username isKindOfClass:NSString.class] || !username.length)continue;
        NSString *remark=remarks[username];
        if(!remark) {
            remark=@"";
            @try {
                id contact=((id(*)(id,SEL,id))objc_msgSend)(manager,NSSelectorFromString(@"getContactByName:"),username);
                id value=Matches(contact,@"m_nsRemark","@@:") ? Read(contact,@"m_nsRemark") : nil;
                if([value isKindOfClass:NSString.class])remark=[value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
            } @catch(__unused NSException *exception) {}
            remarks[username]=remark;
        }
        if(remark.length)card.nickname=remark;
    }
}

static void ApplyMiniAppNames(NSArray<CSMomentsCardModel *> *cards) {
    if(!cards.count)return;
    id manager=nil;
    NSMutableDictionary<NSString *,NSString *> *names=[NSMutableDictionary new];
    for(CSMomentsCardModel *card in cards) {
        if(card.contentKind!=CSMomentsContentMiniApp)continue;
        id rawUserName=Read(Read(card.item,@"weappInfo"),@"appUserName");
        NSString *username=[rawUserName isKindOfClass:NSString.class]
            ? [rawUserName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] : @"";
        if(!username.length)continue;
        if(!manager) {
            manager=CurrentService(NSClassFromString(@"WAContactMgr"));
            // This cache-only selector neither fetches nor updates contacts.
            // Missing entries retain the published source/name fallback.
            if(!Matches(manager,@"getContactFromCache:","@@:@"))return;
        }
        NSString *name=names[username];
        if(!name) {
            name=@"";
            @try {
                id contact=((id(*)(id,SEL,id))objc_msgSend)(manager,NSSelectorFromString(@"getContactFromCache:"),username);
                id value=Matches(contact,@"m_nsNickName","@@:") ? Read(contact,@"m_nsNickName") : nil;
                if([value isKindOfClass:NSString.class])name=[value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
                if([name isEqualToString:@"小程序名称"])name=@"";
            } @catch(__unused NSException *exception) {}
            // Misses also belong only to this projection; a later native
            // contact update or an account switch resolves again.
            names[username]=name;
        }
        if(name.length)card.title=name;
    }
}

@interface CSMomentsSupplement : UICollectionReusableView
@property(nonatomic,strong) UIView *embedded;
@property(nonatomic,strong) UIButton *button;
@end
@implementation CSMomentsSupplement
- (void)setEmbedded:(UIView *)embedded {
    if(_embedded!=embedded) { if(_embedded.superview==self)[_embedded removeFromSuperview]; _embedded=embedded; }
    if(embedded && embedded.superview!=self)[self addSubview:embedded];
    self.clipsToBounds=NO;
    [self layoutSubviews];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    // The header viewport may extend upward while pulling. Keep its bottom at
    // the native header boundary so native table rows stay clipped.
    if(self.embedded.superview==self) {
        CGFloat top=CGRectGetMinY(self.embedded.frame);
        if(!isfinite(top) || top>0)top=0;
        self.embedded.frame=CGRectMake(0,top,CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)-top);
    }
    self.button.frame=CGRectInset(self.bounds,12,8);
}
@end

@interface CSMomentsLayoutAdapter : NSObject <UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak) UIViewController *owner;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,weak) UIView *originalSuperview;
@property(nonatomic) NSUInteger originalIndex,epoch;
@property(atomic) NSUInteger requestSerial;
@property(nonatomic) CGRect originalFrame;
@property(nonatomic) UIEdgeInsets frameInsets,originalInset,originalIndicatorInset;
@property(nonatomic) CGPoint originalOffset;
@property(nonatomic) UIViewAutoresizing originalAutoresizing;
@property(nonatomic) UIScrollViewContentInsetAdjustmentBehavior originalAdjustment;
@property(nonatomic) BOOL originalScrollEnabled,originalScrollsToTop,originalHidden,originalBounces,originalClips;
@property(nonatomic,strong) UIColor *originalTableColor;
@property(nonatomic,strong) UIView *originalTableBackground;
@property(nonatomic,strong) CSMomentsBackdropCollectionView *collection;
@property(nonatomic,strong) CSMomentsMasonryLayout *layout;
@property(nonatomic,strong) UIView *headerContainer;
@property(nonatomic,strong) UIView *backdropContainer;
// Keep the owner until removal even if native UIKit replaces tableHeaderView.
// The independent content background otherwise outlives that retired header.
@property(nonatomic,strong) UIView *backdropHeader;
@property(nonatomic) CGFloat nativeHeaderTop,nativeRestingTop;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,copy) NSArray<CSMomentsCardModel *> *cards;
@property(nonatomic) BOOL attached,refreshQueued,refreshing,loadingMore,noMore,error;
@property(nonatomic) BOOL acceptEmptySource;
@property(nonatomic) BOOL retryRefresh;
@property(nonatomic) BOOL initialSourcePrepared;
@property(nonatomic) NSUInteger sourceCount,lastAutomaticCount;
@property(nonatomic) BOOL suspended,positionPending,positionAwaitingReturn;
@property(nonatomic) NSUInteger positionEpoch;
@property(nonatomic) CGFloat positionOffsetY,positionDelta;
@property(nonatomic,weak) id positionItem;
@property(nonatomic,copy) NSString *positionIdentifier;
@property(nonatomic,weak) UIView *playingVideoCover;
@property(nonatomic) BOOL videoPlaybackQueued;
- (void)update;
- (void)scheduleUpdate;
- (void)layoutViews;
- (void)updateHeaderBackdrop;
- (void)layoutHeaderViewport;
- (void)detach;
- (void)clearPresentation;
- (void)capturePosition;
- (void)restorePosition;
- (void)forgetPosition;
- (void)resumePresentation;
- (void)stopVideoPlayback;
- (void)updateVideoPlayback;
- (void)scheduleVideoPlayback;
- (void)configureSharedCell:(CSMomentsCardCell *)cell card:(CSMomentsCardModel *)card;
- (void)requestFinished:(BOOL)noMore error:(BOOL)error;
@end

static BOOL SameCards(NSArray<CSMomentsCardModel *> *a,NSArray<CSMomentsCardModel *> *b) {
    if(a.count!=b.count)return NO;
    for(NSUInteger i=0;i<a.count;i++) {
        CSMomentsCardModel *x=a[i],*y=b[i];
        if(x.item!=y.item || x.media!=y.media || x.epoch!=y.epoch || x.revision!=y.revision ||
           x.likes!=y.likes || x.comments!=y.comments || x.liked!=y.liked || x.video!=y.video ||
           x.mediaCount!=y.mediaCount || x.timestamp!=y.timestamp || !CGSizeEqualToSize(x.coverSize,y.coverSize) ||
           ![x.title isEqual:y.title] || ![x.nickname isEqual:y.nickname] || ![x.username isEqual:y.username] ||
           ![x.identifier isEqual:y.identifier] || ![x.locationText isEqual:y.locationText])return NO;
        // Compare optional share metadata at the same read boundary as the
        // projection; absent values on older models compare equal to absent.
        for(NSString *key in @[@"contentKind",@"sourceText",@"shareCoverURL"]) {
            id left=Read(x,key),right=Read(y,key);
            if(left!=right && ![left isEqual:right])return NO;
        }
    }
    return YES;
}

@implementation CSMomentsLayoutAdapter
- (instancetype)init { if((self=[super init])) { _cards=@[]; _lastAutomaticCount=NSNotFound; } return self; }
- (void)dealloc { [self detach]; }
- (BOOL)isCurrent {
    return CSMomentsLayoutEnabled() && self.epoch==CSCloseFriendAccountEpoch() && self.owner && CSCFPageIsCurrent(self.owner) && !CSCloseFriendCurrentSnapshot().blocked;
}
- (void)clearPresentation {
    [self stopVideoPlayback];
    CSMomentsHeaderBackdropRemove(self.backdropHeader); self.backdropHeader=nil;
    for(CSMomentsCardCell *cell in self.collection.visibleCells)[cell endDisplaying];
    self.cards=@[]; self.acceptEmptySource=NO;
    if(self.attached && ![self isCurrent])self.headerContainer.hidden=YES;
    [self.collection reloadData];
}
- (void)forgetPosition {
    self.positionPending=NO; self.positionAwaitingReturn=NO; self.positionItem=nil; self.positionIdentifier=nil;
}
- (void)resumePresentation {
    self.suspended=NO; self.positionAwaitingReturn=NO;
    [self update];
}
- (void)stopVideoPlayback {
    CSMomentsSetVideoCoverPlaying(self.playingVideoCover,NO);
    self.playingVideoCover=nil;
}
- (void)scheduleVideoPlayback {
    if(self.videoPlaybackQueued)return;
    self.videoPlaybackQueued=YES;
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(),^{
        CSMomentsLayoutAdapter *adapter=weakSelf;
        adapter.videoPlaybackQueued=NO; [adapter updateVideoPlayback];
    });
}
- (void)updateVideoPlayback {
    if(![self isCurrent] || !self.attached || self.suspended || self.positionAwaitingReturn ||
       !self.collection.window || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive ||
       self.collection.dragging || self.collection.decelerating) { [self stopVideoPlayback]; return; }
    UIView *candidate=nil;
    CGFloat closest=CGFLOAT_MAX;
    NSInteger candidateIndex=NSIntegerMax;
    CGRect viewport=self.collection.bounds;
    id facade=CurrentFacade();
    NSUInteger revision=CSCloseFriendCurrentSnapshot().revision;
    for(NSIndexPath *path in self.collection.indexPathsForVisibleItems) {
        if(path.item<0 || (NSUInteger)path.item>=self.cards.count)continue;
        CSMomentsCardModel *card=self.cards[path.item];
        if(!card.video || card.epoch!=self.epoch || card.revision!=revision)continue;
        CSMomentsCardCell *cell=(id)[self.collection cellForItemAtIndexPath:path];
        if(![cell isKindOfClass:CSMomentsCardCell.class] || cell.model!=card)continue;
        UIView *cover=CSMomentsVideoCoverViewInView(cell.contentView);
        if(!cover || cover.hidden)continue;
        CGRect frame=[cover convertRect:cover.bounds toView:self.collection];
        CGFloat area=CGRectGetWidth(frame)*CGRectGetHeight(frame);
        CGRect intersection=CGRectIntersection(frame,viewport);
        CGFloat visible=CGRectIsNull(intersection)?0:CGRectGetWidth(intersection)*CGRectGetHeight(intersection);
        if(!isfinite(area) || area<=0 || !isfinite(visible) || visible/area<0.6 ||
           !CSMomentsNativeVideoCanAutoPlay(facade,card.item))continue;
        CGFloat distance=fabs(CGRectGetMidY(frame)-CGRectGetMidY(viewport));
        if(distance<closest || (distance==closest && path.item<candidateIndex)) {
            candidate=cover; closest=distance; candidateIndex=path.item;
        }
    }
    if(candidate==self.playingVideoCover)return;
    [self stopVideoPlayback];
    if(candidate && CSMomentsSetVideoCoverPlaying(candidate,YES))self.playingVideoCover=candidate;
}
- (void)capturePosition {
    if(self.positionPending || !self.attached || ![self isCurrent] || !self.cards.count)return;
    self.positionPending=YES; self.positionAwaitingReturn=YES; self.positionEpoch=self.epoch;
    self.positionOffsetY=self.collection.contentOffset.y;
    self.positionItem=nil; self.positionIdentifier=nil; self.positionDelta=0;
    CGFloat top=self.collection.contentOffset.y+self.collection.adjustedContentInset.top;
    CGFloat firstY=CGFLOAT_MAX;
    for(NSIndexPath *path in self.collection.indexPathsForVisibleItems) {
        if(path.item<0 || (NSUInteger)path.item>=self.cards.count)continue;
        UICollectionViewLayoutAttributes *attributes=[self.collection layoutAttributesForItemAtIndexPath:path];
        CGRect frame=attributes.frame;
        if(!attributes || CGRectGetMaxY(frame)<=top || CGRectGetMinY(frame)>=firstY)continue;
        // While the cover is visible, an absolute offset preserves its position;
        // a first-card anchor would incorrectly skip it after a height change.
        if(CGRectGetMinY(frame)>top)continue;
        firstY=CGRectGetMinY(frame);
        CSMomentsCardModel *card=self.cards[path.item];
        self.positionItem=card.item; self.positionIdentifier=card.identifier;
        self.positionDelta=self.positionOffsetY-firstY;
    }
}
- (void)restorePosition {
    // A native reload can run during the push animation. Keep the anchor until
    // viewWillAppear: resumes this page, including when its cards were retained.
    if(!self.positionPending || self.positionAwaitingReturn || !self.attached || ![self isCurrent])return;
    if(self.positionEpoch!=self.epoch) { [self forgetPosition]; return; }
    // Only lay out our collection after its data has returned. Never force the
    // native table's reload/layout from viewDidLayoutSubviews.
    [self.collection layoutIfNeeded];
    CGFloat target=self.positionOffsetY;
    for(NSUInteger index=0;index<self.cards.count;index++) {
        CSMomentsCardModel *card=self.cards[index];
        if((self.positionItem && card.item==self.positionItem) ||
           (self.positionIdentifier.length && [card.identifier isEqualToString:self.positionIdentifier])) {
            UICollectionViewLayoutAttributes *attributes=[self.collection layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
            if(attributes)target=CGRectGetMinY(attributes.frame)+self.positionDelta;
            break;
        }
    }
    UIEdgeInsets insets=self.collection.adjustedContentInset;
    CGFloat minimum=-insets.top;
    CGFloat maximum=MAX(minimum,self.collection.contentSize.height-CGRectGetHeight(self.collection.bounds)+insets.bottom);
    if(!isfinite(target))target=minimum;
    target=MIN(maximum,MAX(minimum,target));
    [self.collection setContentOffset:CGPointMake(self.collection.contentOffset.x,target) animated:NO];
    [self forgetPosition];
}
- (void)attachToTable:(UITableView *)table {
    UIView *parent=table.superview;
    if(!parent)return;
    self.table=table; self.originalSuperview=parent;
    self.originalIndex=[parent.subviews indexOfObjectIdenticalTo:table];
    self.originalFrame=table.frame;
    self.frameInsets=UIEdgeInsetsMake(CGRectGetMinY(table.frame),CGRectGetMinX(table.frame),
        CGRectGetHeight(parent.bounds)-CGRectGetMaxY(table.frame),CGRectGetWidth(parent.bounds)-CGRectGetMaxX(table.frame));
    self.originalAutoresizing=table.autoresizingMask;
    self.originalInset=table.contentInset; self.originalIndicatorInset=table.verticalScrollIndicatorInsets;
    self.originalAdjustment=table.contentInsetAdjustmentBehavior; self.originalOffset=table.contentOffset;
    self.nativeRestingTop=table.adjustedContentInset.top;
    self.originalHidden=table.hidden; self.originalScrollEnabled=table.scrollEnabled;
    self.originalScrollsToTop=table.scrollsToTop; self.originalBounces=table.bounces;
    self.originalClips=table.clipsToBounds;
    self.originalTableColor=table.backgroundColor;
    self.originalTableBackground=table.backgroundView;
    self.epoch=CSCloseFriendAccountEpoch();
    self.layout=[CSMomentsMasonryLayout new];
    __weak typeof(self) weakSelf=self;
    self.layout.heightForItem=^CGFloat(NSIndexPath *path,CGFloat width){
        CSMomentsLayoutAdapter *adapter=weakSelf;
        return path.item>=0 && (NSUInteger)path.item<adapter.cards.count ? [CSMomentsCardCell heightForModel:adapter.cards[path.item] width:width] : 1;
    };
    self.layout.footerHeight=60;
    self.collection=[[CSMomentsBackdropCollectionView alloc]initWithFrame:table.frame collectionViewLayout:self.layout];
    self.collection.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.collection.backgroundColor=CSMomentsPageFill();
    self.collection.alwaysBounceVertical=YES;
    self.collection.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    self.collection.contentInset=TimelineInsets(table.adjustedContentInset);
    self.collection.verticalScrollIndicatorInsets=table.verticalScrollIndicatorInsets;
    self.collection.scrollsToTop=self.originalScrollsToTop;
    self.collection.dataSource=self; self.collection.delegate=self;
    [self.collection registerClass:CSMomentsCardCell.class forCellWithReuseIdentifier:@"card"];
    [self.collection registerClass:CSMomentsSupplement.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collection registerClass:CSMomentsSupplement.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.refreshControl=[UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.collection.refreshControl=self.refreshControl;
    self.headerContainer=[UIView new]; self.headerContainer.clipsToBounds=YES;
    self.headerContainer.backgroundColor=UIColor.clearColor;
    self.backdropContainer=[UIView new];
    self.backdropContainer.backgroundColor=UIColor.clearColor;
    self.backdropContainer.userInteractionEnabled=NO;
    // This is a content subview, so it scrolls with the cards. Keep it below
    // collection-managed cells/supplements even when UIKit reorders/reuses them.
    self.backdropContainer.layer.zPosition=-1;
    [self.collection addSubview:self.backdropContainer];
    self.collection.contentBackground=self.backdropContainer;
    // Embed the complete native table as the supplementary header. Its own
    // tableHeaderView stays intact: native updateHeaderView checks that identity.
    // A non-scrolling viewport clips native content rows below the header.
    [table removeFromSuperview];
    [parent insertSubview:self.collection atIndex:MIN(self.originalIndex,parent.subviews.count)];
    [self.headerContainer addSubview:table];
    // One collection background is visible beneath the alpha-faded cover and
    // through card gaps. A second native table fill would end at headerHeight.
    table.backgroundView=nil; table.backgroundColor=UIColor.clearColor;
    table.scrollEnabled=NO; table.scrollsToTop=NO; table.bounces=NO; table.hidden=NO; table.clipsToBounds=NO;
    table.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    table.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    table.contentInset=UIEdgeInsetsZero; table.verticalScrollIndicatorInsets=UIEdgeInsetsZero;
    self.attached=YES;
    [self layoutViews];
    self.collection.contentOffset=CGPointMake(0,-self.collection.contentInset.top);
}
- (void)detach {
    if(!self.attached)return;
    [self forgetPosition]; self.suspended=NO;
    self.collection.delegate=nil; self.collection.dataSource=nil;
    [self clearPresentation]; self.requestSerial++;
    self.refreshing=NO; self.loadingMore=NO; [self.refreshControl endRefreshing];
    UITableView *table=self.table; UIView *parent=self.originalSuperview;
    [table removeFromSuperview];
    if(parent)[parent insertSubview:table atIndex:MIN(self.originalIndex,parent.subviews.count)];
    table.autoresizingMask=self.originalAutoresizing;
    table.frame=self.originalFrame;
    table.contentInsetAdjustmentBehavior=self.originalAdjustment;
    table.contentInset=self.originalInset; table.verticalScrollIndicatorInsets=self.originalIndicatorInset;
    table.scrollEnabled=self.originalScrollEnabled; table.scrollsToTop=self.originalScrollsToTop;
    table.hidden=self.originalHidden; table.bounces=self.originalBounces; table.clipsToBounds=self.originalClips;
    table.backgroundColor=self.originalTableColor; table.backgroundView=self.originalTableBackground;
    table.contentOffset=self.originalOffset;
    self.collection.delegate=nil; self.collection.dataSource=nil; [self.collection removeFromSuperview];
    [self.backdropContainer removeFromSuperview]; self.backdropContainer=nil;
    self.collection=nil; self.layout=nil; self.headerContainer=nil; self.refreshControl=nil;
    self.table=nil; self.originalSuperview=nil; self.attached=NO;
    self.originalTableColor=nil; self.originalTableBackground=nil;
    self.noMore=NO; self.error=NO; self.lastAutomaticCount=NSNotFound;
}
- (void)layoutViews {
    if(!self.attached)return;
    UIView *parent=self.originalSuperview;
    if(!parent)return;
    CGRect frame=UIEdgeInsetsInsetRect(parent.bounds,self.frameInsets);
    if(CGRectGetWidth(frame)>0 && CGRectGetHeight(frame)>0 && !CGRectEqualToRect(self.collection.frame,frame))self.collection.frame=frame;
    // Native layout may restore its insets/offset. Only this embedded viewport
    // is normalized; the original values are saved and restored on detach.
    if(!UIEdgeInsetsEqualToEdgeInsets(self.table.contentInset,UIEdgeInsetsZero))self.table.contentInset=UIEdgeInsetsZero;
    if(!CGPointEqualToPoint(self.table.contentOffset,CGPointZero))self.table.contentOffset=CGPointZero;
    self.table.scrollEnabled=NO; self.table.scrollsToTop=NO;
    // Native appearance/theme updates may replace these presentation values.
    // Remember the latest native fill for detach, then keep this viewport clear.
    if(self.table.backgroundColor && self.table.backgroundColor!=UIColor.clearColor) {
        self.originalTableColor=self.table.backgroundColor;
    }
    if(self.table.backgroundView)self.originalTableBackground=self.table.backgroundView;
    self.table.backgroundColor=UIColor.clearColor; self.table.backgroundView=nil;
    [self updateHeaderBackdrop];
}
- (void)layoutHeaderViewport {
    if(!self.attached)return;
    CGFloat pull=MAX(0,-self.collection.contentOffset.y);
    if(!isfinite(pull))pull=0;
    CGFloat width=CGRectGetWidth(self.collection.bounds),height=self.layout.headerHeight;
    self.backdropContainer.frame=CGRectMake(0,0,width,self.layout.firstCardTop+CSMomentsBackdropTail);
    // Only expand upward. Its bottom remains headerHeight in collection
    // coordinates, including when UIKit holds a refresh inset after release.
    self.headerContainer.frame=CGRectMake(0,-pull,width,height+pull);
    self.table.frame=CGRectMake(0,pull+self.nativeHeaderTop,width,CGRectGetHeight(self.collection.bounds));
    // Retain the native table's resting content origin. The viewport still clips
    // native rows exactly where the corrected header ends, including on pull.
    self.table.clipsToBounds=NO;
    if([self isCurrent])CSMomentsHeaderBackdropSetPullDistance(self.table.tableHeaderView,pull);
}
- (void)updateHeaderBackdrop {
    UIView *header=self.attached ? self.table.tableHeaderView : nil;
    self.nativeHeaderTop=header ? NativeHeaderTopInset(self.owner,self.table,self.nativeRestingTop) : 0;
    CGFloat height=header ? CGRectGetHeight(header.frame) : 0;
    if(!isfinite(height) || height<0)height=0;
    height+=self.nativeHeaderTop;
    if(fabs(self.layout.headerHeight-height)>0.5)self.layout.headerHeight=height;
    [self layoutHeaderViewport];
    if(self.backdropHeader!=header)CSMomentsHeaderBackdropRemove(self.backdropHeader);
    self.backdropHeader=nil;
    if([self isCurrent] && header && CSMomentsHeaderBackdropApply(header,self.backdropContainer,self.nativeHeaderTop,self.layout.firstCardTop)) {
        self.backdropHeader=header;
        CSMomentsHeaderBackdropSetPullDistance(header,MAX(0,-self.collection.contentOffset.y));
    }
    else CSMomentsHeaderBackdropRemove(header);
}
- (void)scheduleUpdate {
    if(self.refreshQueued)return;
    self.refreshQueued=YES;
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(),^{ CSMomentsLayoutAdapter *adapter=weakSelf; adapter.refreshQueued=NO; [adapter update]; });
}
- (void)update {
    if(!NSThread.isMainThread) { [self scheduleUpdate]; return; }
    if(!self.owner || !self.owner.isViewLoaded)return;
    if(!CSMomentsLayoutEnabled()) { [self detach]; return; }
    // Build and attach before the navigation transition's first visible frame.
    // viewDidLoad/viewWillAppear normally precede attachment to a UIWindow;
    // playback alone needs a window; an offscreen page keeps its valid cards.
    if(!CSCFPageIsCurrent(self.owner)) { [self clearPresentation]; return; }
    UITableView *tableToAttach=nil;
    if(!self.attached) {
        // Existing expandable pages keep their native presentation until the
        // user reenters; do not mutate header mode merely to attach this view.
        id expandable=Read(self.owner,@"expandableHeader");
        id table=Read(self.owner,@"tableView");
        if(![table isKindOfClass:UITableView.class])return;
        if([expandable isKindOfClass:UIView.class] && [expandable superview])return;
        tableToAttach=table;
    }
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    id facade=CurrentFacade();
    id source=Read(facade,@"getTimelineDataItem");
    if(!self.initialSourcePrepared && facade && !snapshot.blocked) {
        // Native numberOfSectionsInTableView: normally prepares this composed
        // list. We replace that table before its first datasource query, so use
        // its same local composition once when the getter is not ready yet.
        if([source isKindOfClass:NSArray.class] && [source count])self.initialSourcePrepared=YES;
        else if(Matches(facade,@"reloadTimelineDataItems","v@:")) {
            self.initialSourcePrepared=YES;
            if(Call0(facade,@"reloadTimelineDataItems"))source=Read(facade,@"getTimelineDataItem");
        }
    }
    if(tableToAttach)[self attachToTable:tableToAttach];
    if(![self isCurrent]) { [self clearPresentation]; self.headerContainer.hidden=YES; return; }
    self.headerContainer.hidden=NO;
    for(CSMomentsCardModel *card in self.cards) {
        if(card.epoch!=self.epoch || card.revision!=snapshot.revision || CSCFSocialHidden(card.item,CSCloseFriendSurfaceTimeline)) {
            [self clearPresentation]; break;
        }
    }
    BOOL sourceReady=[source isKindOfClass:NSArray.class];
    if(!sourceReady)source=@[];
    BOOL keepAccepted=self.cards.count && (!sourceReady || (![source count] && !self.acceptEmptySource));
    if(sourceReady)self.acceptEmptySource=NO;
    if(keepAccepted) {
        // Native begin/reload can briefly publish nil or an empty array. Keep
        // this page's accepted content until a data completion/delete confirms
        // an empty result; never borrow another page/account's presentation.
        NSMutableArray *accepted=[NSMutableArray arrayWithCapacity:self.cards.count];
        for(CSMomentsCardModel *card in self.cards)if(card.item)[accepted addObject:card.item];
        source=accepted;
    } else self.sourceCount=[source count];
    NSArray *cards=CSMomentsBuildCards(source,snapshot,self.epoch,CSAdPurificationShouldApply(CSAdPurificationMoments),
        ^id(id object,NSString *key){ return Read(object,key); },^CGSize(id media){ return CSMomentsNativeMediaSize(media); });
    ApplyContactRemarks(cards);
    ApplyMiniAppNames(cards);
    if(!SameCards(self.cards,cards)) {
        self.cards=cards;
        [self.collection reloadData];
    }
    [self layoutViews];
    if(sourceReady || self.cards.count)[self restorePosition];
    [self updateFooter];
    [self scheduleVideoPlayback];
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section { (void)view; (void)section; return self.cards.count; }
- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)path {
    CSMomentsCardCell *cell=[view dequeueReusableCellWithReuseIdentifier:@"card" forIndexPath:path];
    if([self isCurrent] && path.item>=0 && (NSUInteger)path.item<self.cards.count) {
        [cell configureWithModel:self.cards[path.item]];
        [self configureSharedCell:cell card:self.cards[path.item]];
    }
    else [cell endDisplaying];
    return cell;
}
- (void)collectionView:(UICollectionView *)view willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)path {
    (void)view;
    if(![cell isKindOfClass:CSMomentsCardCell.class])return;
    if([self isCurrent] && path.item>=0 && (NSUInteger)path.item<self.cards.count && ![(CSMomentsCardCell *)cell model]) {
        [(CSMomentsCardCell *)cell configureWithModel:self.cards[path.item]];
        [self configureSharedCell:(CSMomentsCardCell *)cell card:self.cards[path.item]];
    }
    [self scheduleVideoPlayback];
}
- (void)collectionView:(UICollectionView *)view didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)path {
    (void)view; (void)path;
    if([cell isKindOfClass:CSMomentsCardCell.class])[(CSMomentsCardCell *)cell endDisplaying];
    [self scheduleVideoPlayback];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)view viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)path {
    BOOL header=[kind isEqual:UICollectionElementKindSectionHeader];
    CSMomentsSupplement *supplement=[view dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header?@"header":@"footer" forIndexPath:path];
    if(header)supplement.embedded=self.headerContainer;
    else {
        if(!supplement.button) {
            supplement.button=[UIButton buttonWithType:UIButtonTypeSystem];
            supplement.button.titleLabel.font=[UIFont systemFontOfSize:13];
            [supplement.button addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
            [supplement addSubview:supplement.button];
        }
        [self configureFooter:supplement];
    }
    return supplement;
}
- (void)configureFooter:(CSMomentsSupplement *)footer {
    // An empty projection is also the normal first frame before native data
    // arrives. Keep it quiet, including a genuinely empty successful result.
    BOOL visible=self.error || self.cards.count>0;
    NSString *title=!visible?@"":self.loadingMore?@"正在加载…":self.error?@"加载失败，轻点重试":self.noMore?@"没有更多动态":@"加载更多";
    [footer.button setTitle:title forState:UIControlStateNormal];
    footer.button.hidden=!visible;
    footer.button.enabled=visible && !self.loadingMore && !self.refreshing && !self.noMore && [self isCurrent];
}
- (void)updateFooter {
    for(CSMomentsSupplement *footer in [self.collection visibleSupplementaryViewsOfKind:UICollectionElementKindSectionFooter])[self configureFooter:footer];
}
- (BOOL)nativeLoading {
    if(Matches(self.owner,@"egoRefreshTableHeaderDataSourceIsLoading:","B@:@") &&
       ((BOOL(*)(id,SEL,id))objc_msgSend)(self.owner,NSSelectorFromString(@"egoRefreshTableHeaderDataSourceIsLoading:"),Read(self.owner,@"headRefreshView")))return YES;
    // 8.0.80.34's page loading byte is distinct from the data provider's
    // isWorking byte. A busy provider rejects updateDataHead/updateDataTail
    // without creating a request or a new completion notification.
    id provider=Read(Read(CurrentFacade(),@"timelineMgr"),@"dataProvider");
    return Matches(provider,@"isUpdating","B@:") && [Read(provider,@"isUpdating") boolValue];
}
- (void)armTimeout {
    NSUInteger serial=++self.requestSerial;
    __weak typeof(self) weakSelf=self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,25*NSEC_PER_SEC),dispatch_get_main_queue(),^{
        CSMomentsLayoutAdapter *adapter=weakSelf;
        if(adapter.attached && adapter.requestSerial==serial && (adapter.refreshing || adapter.loadingMore))[adapter requestFinished:NO error:YES];
    });
}
- (void)refresh:(UIRefreshControl *)sender {
    if(![self isCurrent] || self.refreshing || self.loadingMore || [self nativeLoading]) { [sender endRefreshing]; return; }
    self.refreshing=YES; self.noMore=NO; self.error=NO; self.retryRefresh=NO; self.lastAutomaticCount=NSNotFound;
    [self updateFooter]; [self armTimeout];
    if(!Call1(self.owner,@"egoRefreshTableHeaderDidTriggerRefresh:",Read(self.owner,@"headRefreshView")))[self requestFinished:NO error:YES];
}
- (void)loadMore:(id)sender {
    BOOL manual=sender!=nil;
    if(manual && self.error && self.retryRefresh) { [self refresh:self.refreshControl]; return; }
    if(![self isCurrent] || self.refreshing || self.loadingMore || self.noMore || [self nativeLoading])return;
    if(!manual && (self.error || !self.sourceCount || self.lastAutomaticCount==self.sourceCount))return;
    self.lastAutomaticCount=self.sourceCount;
    self.loadingMore=YES; self.error=NO; self.retryRefresh=NO;
    [self updateFooter]; [self armTimeout];
    if(!Call0(self.owner,@"onLoadMore"))[self requestFinished:NO error:YES];
}
- (void)requestFinished:(BOOL)noMore error:(BOOL)error {
    if(!self.attached)return;
    self.retryRefresh=error && self.refreshing;
    self.requestSerial++; self.refreshing=NO; self.loadingMore=NO;
    self.noMore=noMore; self.error=error;
    [self.refreshControl endRefreshing]; [self scheduleUpdate]; [self updateFooter];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView!=self.collection)return;
    [self layoutHeaderViewport];
    if(!(scrollView.dragging || scrollView.decelerating)) { [self scheduleVideoPlayback]; return; }
    [self stopVideoPlayback];
    CGFloat bottom=scrollView.contentOffset.y+CGRectGetHeight(scrollView.bounds)-scrollView.adjustedContentInset.bottom;
    if(bottom>scrollView.contentSize.height-240)[self loadMore:nil];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(scrollView==self.collection)[self stopVideoPlayback];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(scrollView==self.collection && !decelerate)[self scheduleVideoPlayback];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(scrollView==self.collection)[self scheduleVideoPlayback];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if(scrollView==self.collection)[self scheduleVideoPlayback];
}
- (void)configureSharedCell:(CSMomentsCardCell *)cell card:(CSMomentsCardModel *)card {
    __weak typeof(self) weakSelf = self;
    [cell configureSharedPresentationForOwner:self.owner shouldOpen:^BOOL {
        CSMomentsLayoutAdapter *adapter = weakSelf;
        if (![adapter isCurrent] || card.epoch != adapter.epoch ||
            card.revision != CSCloseFriendCurrentSnapshot().revision || CSCFSocialHidden(card.item, CSCloseFriendSurfaceTimeline)) return NO;
        id source = Read(CurrentFacade(), @"getTimelineDataItem");
        if (![source isKindOfClass:NSArray.class] || [source indexOfObjectIdenticalTo:card.item] == NSNotFound ||
            (CSAdPurificationShouldApply(CSAdPurificationMoments) && [Read(card.item, @"isAd") boolValue])) {
            [adapter scheduleUpdate]; return NO;
        }
        [adapter stopVideoPlayback]; [adapter capturePosition];
        return YES;
    }];
}

- (void)collectionView:(UICollectionView *)view didSelectItemAtIndexPath:(NSIndexPath *)path {
    [view deselectItemAtIndexPath:path animated:YES];
    if(![self isCurrent] || path.item<0 || (NSUInteger)path.item>=self.cards.count)return;
    CSMomentsCardModel *card=self.cards[path.item];
    CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
    if(card.epoch!=self.epoch || card.revision!=snapshot.revision || CSCFSocialHidden(card.item,CSCloseFriendSurfaceTimeline)) { [self clearPresentation]; [self scheduleUpdate]; return; }
    id source=Read(CurrentFacade(),@"getTimelineDataItem");
    if(![source isKindOfClass:NSArray.class] || [source indexOfObjectIdenticalTo:card.item]==NSNotFound ||
       (CSAdPurificationShouldApply(CSAdPurificationMoments) && [Read(card.item,@"isAd") boolValue])) { [self scheduleUpdate]; return; }
    [self stopVideoPlayback]; [self capturePosition];
    // showDetailView... opens full media/comment detail. onShowDetailView...
    // is the distinct native text-expansion route and omits these sections.
    if(!Call1(self.owner,@"showDetailViewForDataItem:",card.item))[self forgetPosition];
}
@end

static CSMomentsLayoutAdapter *Adapter(id owner,BOOL create) {
    CSMomentsLayoutAdapter *adapter=objc_getAssociatedObject(owner,&AdapterKey);
    if(!adapter && create && [owner isKindOfClass:UIViewController.class]) {
        adapter=[CSMomentsLayoutAdapter new]; adapter.owner=owner;
        objc_setAssociatedObject(owner,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [Adapters addObject:adapter];
    }
    return adapter;
}
static BOOL Install(NSString *className,NSString *name,const char *types,IMP replacement,IMP *original,BOOL classMethod) {
    Class cls=NSClassFromString(className); if(classMethod)cls=object_getClass(cls);
    SEL selector=NSSelectorFromString(name);
    if(!cls || !CSCloseFriendMethodMatches(class_getInstanceMethod(cls,selector),types)) { imp_removeBlock(replacement); return NO; }
    MSHookMessageEx(cls,selector,replacement,original);
    if(!*original)return NO;
    return YES;
}
static BOOL NativeDetailRouteAvailable(void) {
    return CSCloseFriendMethodMatches(class_getClassMethod(NSClassFromString(@"WCTimelineRouterHelper"),
        NSSelectorFromString(@"isFlutterDetailEnabled")),"B@:");
}
static BOOL HookNativeDetailRoute(void) {
    __block IMP original=NULL;
    SEL selector=NSSelectorFromString(@"isFlutterDetailEnabled");
    IMP replacement=imp_implementationWithBlock(^BOOL(id router){
        // Timeline and detail have independent Flutter switches. Keep this
        // renderer on the native detail path with its original facade/delegate.
        if(CSMomentsLayoutEnabled())return NO;
        return ((BOOL(*)(id,SEL))original)(router,selector);
    });
    return Install(@"WCTimelineRouterHelper",@"isFlutterDetailEnabled","B@:",replacement,&original,YES);
}
static void Hook0(NSString *name,void (^after)(id)) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner){
        ((void(*)(id,SEL))original)(owner,selector);
        if(NSThread.isMainThread)after(owner);
        else { __weak id weakOwner=owner; dispatch_async(dispatch_get_main_queue(),^{ if(weakOwner)after(weakOwner); }); }
    });
    Install(@"WCTimeLineViewController",name,"v@:",replacement,&original,NO);
}
static void HookObject(NSString *name,void (^after)(id)) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner,id value){
        ((void(*)(id,SEL,id))original)(owner,selector,value);
        __weak id weakOwner=owner;
        dispatch_async(dispatch_get_main_queue(),^{ if(weakOwner)after(weakOwner); });
    });
    Install(@"WCTimeLineViewController",name,"v@:@",replacement,&original,NO);
}
static void RefreshHeaderBackdrop(id header) {
    for(CSMomentsLayoutAdapter *adapter in Adapters.allObjects) {
        if(adapter.attached && adapter.table.tableHeaderView==header) {
            [adapter updateHeaderBackdrop];
            return;
        }
    }
}
static void HookHeaderBackdrop(NSString *name) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id header){
        ((void(*)(id,SEL))original)(header,selector);
        if(NSThread.isMainThread)RefreshHeaderBackdrop(header);
        else { __weak id weakHeader=header; dispatch_async(dispatch_get_main_queue(),^{ if(weakHeader)RefreshHeaderBackdrop(weakHeader); }); }
    });
    Install(@"WCListHeaderView",name,"v@:",replacement,&original,NO);
}
static void HookCompletion(NSString *name,BOOL noMore,BOOL error,BOOL refreshOnly) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner){
        CSMomentsLayoutAdapter *adapter=Adapter(owner,NO);
        NSUInteger serial=adapter.requestSerial;
        // Native result handlers synchronously stop their refresh UI. Those
        // nested stops belong to the outer result, on whichever thread the
        // native callback arrives; they must not consume its request serial.
        NSMutableDictionary *threadState=NSThread.currentThread.threadDictionary;
        NSString *scopeKey=[NSString stringWithFormat:@"CSMomentsCompletion:%p",(__bridge void *)owner];
        NSUInteger depth=[threadState[scopeKey] unsignedIntegerValue];
        if(!refreshOnly)threadState[scopeKey]=@(depth+1);
        @try { ((void(*)(id,SEL))original)(owner,selector); }
        @finally {
            if(!refreshOnly) {
                if(depth)threadState[scopeKey]=@(depth); else [threadState removeObjectForKey:scopeKey];
            }
        }
        if(depth)return;
        __weak CSMomentsLayoutAdapter *weakAdapter=adapter;
        void (^finish)(void)=^{
            CSMomentsLayoutAdapter *current=weakAdapter;
            if(!current || ![current isCurrent] || current.requestSerial!=serial || (refreshOnly && !current.refreshing))return;
            if(!error && !refreshOnly)current.acceptEmptySource=YES;
            // Native startup/old refresh notifications do not belong to one of
            // this adapter's requests. Reproject their data without flashing a
            // failure/end-of-list footer before the first cards have arrived.
            if(!current.refreshing && !current.loadingMore) { [current scheduleUpdate]; return; }
            [current requestFinished:noMore error:error];
        };
        // stopRefreshHeaderView also runs *inside* error/no-more callbacks.
        // Defer its weaker success so the outer result retains ownership.
        if(NSThread.isMainThread && !refreshOnly)finish(); else dispatch_async(dispatch_get_main_queue(),finish);
    });
    Install(@"WCTimeLineViewController",name,"v@:",replacement,&original,NO);
}
static void HookNativeFooterCompletion(void) {
    __block IMP original=NULL;
    SEL selector=NSSelectorFromString(@"refreshScrollViewDataSourceDidFinishedLoading:");
    IMP replacement=imp_implementationWithBlock(^(id footer,id scrollView){
        CSMomentsLayoutAdapter *adapter=nil;
        if(NSThread.isMainThread)for(CSMomentsLayoutAdapter *candidate in Adapters.allObjects) {
            if(candidate.attached && candidate.loadingMore && candidate.table==scrollView &&
               Read(candidate.owner,@"footerView")==footer) { adapter=candidate; break; }
        }
        NSUInteger serial=adapter.requestSerial;
        ((void(*)(id,SEL,id))original)(footer,selector,scrollView);
        __weak CSMomentsLayoutAdapter *weakAdapter=adapter;
        // A synchronous local page can finish here without any of the page's
        // network result callbacks. Keep error/no-more results authoritative.
        dispatch_async(dispatch_get_main_queue(),^{
            CSMomentsLayoutAdapter *current=weakAdapter;
            if(!current || ![current isCurrent] || !current.attached ||
               !current.loadingMore || current.requestSerial!=serial)return;
            [current requestFinished:NO error:NO];
        });
    });
    Install(@"WCTimeLineFooterView",NSStringFromSelector(selector),"v@:@",replacement,&original,NO);
}
static void HookCachedImagePaths(void) {
    // Native path getters can initialize their cache root. Observe paths only
    // after WeChat itself asks for them; never invoke a getter to discover one.
    for (NSArray *entry in @[@[@"pathForUhdData", @4], @[@"pathForHdData", @3], @[@"pathForData", @2]]) {
        __block IMP original = NULL;
        NSString *name = entry[0];
        NSUInteger quality = [entry[1] unsignedIntegerValue];
        SEL selector = NSSelectorFromString(name);
        IMP replacement = imp_implementationWithBlock(^id(id media) {
            NSUInteger epoch = CSCloseFriendAccountEpoch();
            id path = ((id (*)(id, SEL))original)(media, selector);
            if (![path isKindOfClass:NSString.class] || !CSMomentsLayoutEnabled() ||
                epoch != CSCloseFriendAccountEpoch() || CSCloseFriendCurrentSnapshot().blocked) return path;
            void (^observe)(void) = ^{
                if (CSMomentsLayoutEnabled() && epoch == CSCloseFriendAccountEpoch() &&
                    !CSCloseFriendCurrentSnapshot().blocked)
                    CSMomentsNativeMediaDidResolveLocalPath(media, quality, path);
            };
            if (NSThread.isMainThread) observe(); else dispatch_async(dispatch_get_main_queue(), observe);
            return path;
        });
        Install(@"WCMediaItem", name, "@@:", replacement, &original, NO);
    }
}
static void HookCachedImageObservations(void) {
    // 8.0.80.34: these callbacks receive the original WCMediaItem after
    // native completion; recording only reads already present cache files.
    for (NSString *name in @[@"onCdnDownloadImageFinish:downloadType:", @"onDownloadFinish:downloadType:"]) {
        __block IMP original = NULL;
        SEL selector = NSSelectorFromString(name);
        IMP replacement = imp_implementationWithBlock(^(id facade, id media, NSInteger type) {
            NSUInteger epoch = CSCloseFriendAccountEpoch();
            ((void (*)(id, SEL, id, NSInteger))original)(facade, selector, media, type);
            __weak id weakFacade = facade;
            void (^observe)(void) = ^{
                if (CSMomentsLayoutEnabled() && epoch == CSCloseFriendAccountEpoch() &&
                    !CSCloseFriendCurrentSnapshot().blocked && weakFacade == CurrentFacade())
                    CSMomentsNativeMediaDidDownload(media);
            };
            if (NSThread.isMainThread) observe(); else dispatch_async(dispatch_get_main_queue(), observe);
        });
        Install(@"WCFacade", name, "v@:@q", replacement, &original, NO);
    }
    __block IMP originalDisplay = NULL;
    SEL display = NSSelectorFromString(@"displayViewModel:withImage:frame:");
    IMP replacement = imp_implementationWithBlock(^(id scroll, id model, id image, CGRect frame) {
        NSUInteger epoch = CSCloseFriendAccountEpoch();
        ((void (*)(id, SEL, id, id, CGRect))originalDisplay)(scroll, display, model, image, frame);
        __weak id weakScroll = scroll;
        void (^observe)(void) = ^{
            if (CSMomentsLayoutEnabled() && epoch == CSCloseFriendAccountEpoch() &&
                !CSCloseFriendCurrentSnapshot().blocked)
                CSMomentsNativeMediaDidDisplay(weakScroll, model, image);
        };
        if (NSThread.isMainThread) observe(); else dispatch_async(dispatch_get_main_queue(), observe);
    });
    Install(@"WCMediaImageScrollView", NSStringFromSelector(display),
        "v@:@@{CGRect={CGPoint=dd}{CGSize=dd}}", replacement, &originalDisplay, NO);
    // The classic Moments photo viewer does not call the scroll-view model
    // entry above. Its own container assigns m_container.image directly.
    // Observe both image arrival and actual display/transition completion;
    // NativeMedia still requires current pixels and on-window visibility.
    for (NSString *name in @[@"updateContainerImage", @"didDisplay", @"animationShowDidStop"]) {
        __block IMP original = NULL;
        SEL selector = NSSelectorFromString(name);
        IMP replacement = imp_implementationWithBlock(^(id container) {
            NSUInteger epoch = CSCloseFriendAccountEpoch();
            ((void (*)(id, SEL))original)(container, selector);
            __weak id weakContainer = container;
            void (^observe)(void) = ^{
                id current = weakContainer;
                if (!current || !CSMomentsLayoutEnabled() || epoch != CSCloseFriendAccountEpoch() ||
                    CSCloseFriendCurrentSnapshot().blocked) return;
                id imageView = Read(current, @"m_container");
                id media = Read(current, @"m_mediaData");
                if ([current isKindOfClass:UIView.class] && [imageView isKindOfClass:UIImageView.class])
                    CSMomentsNativeMediaDidDisplay(current, media, ((UIImageView *)imageView).image);
            };
            if (NSThread.isMainThread) observe(); else dispatch_async(dispatch_get_main_queue(), observe);
        });
        Install(@"WCImageFullScreenViewContainer", name, "v@:", replacement, &original, NO);
    }
}

void CSMomentsLayoutRuntimeStart(void) {
    if(!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ CSMomentsLayoutRuntimeStart(); }); return; }
    static dispatch_once_t once;
    dispatch_once(&once,^{
        Adapters=[NSHashTable weakObjectsHashTable];
        NSDictionary *required=@{
            @"WCTimeLineViewController":@{@"tableView":@"@@:",@"showDetailViewForDataItem:":@"v@:@",@"onLoadMore":@"v@:",@"egoRefreshTableHeaderDidTriggerRefresh:":@"v@:@",@"onNormalTimelineData":@"v@:",@"onNoMoreTimelineData":@"v@:",@"onTimelineServerError":@"v@:"},
            @"WCCommentDetailViewControllerFB":@{@"dataItem":@"@@:",@"setDataItem:":@"v@:@",@"setM_delegate:":@"v@:@"},
            @"WCFacade":@{@"getTimelineDataItem":@"@@:",@"timelineMgr":@"@@:"},
            @"WCTimelineMgr":@{@"dataProvider":@"@@:"},
            @"WCTimelineDataProvider":@{@"isUpdating":@"B@:"},
            @"WCTimeLineFooterView":@{@"refreshScrollViewDataSourceDidFinishedLoading:":@"v@:@"}
        };
        for(NSString *className in required)for(NSString *name in required[className])
            if(!CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(className),NSSelectorFromString(name)),[required[className][name] UTF8String]))return;
        if(!NativeDetailRouteAvailable() || !HookNativeDetailRoute())return;
        HookCachedImagePaths();
        HookCachedImageObservations();
        // Select native Timeline before the page is constructed. Disabled
        // behavior delegates through other plugins' existing route decisions.
        for(NSArray *route in @[@[@"WCFacadeDynamicConfig",@"Moments_enableFlutterTimeline"],@[@"WCTimeLineViewController",@"useExpandableHeader"]]) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(route[1]);
            IMP replacement=imp_implementationWithBlock(^BOOL(id object){ return CSMomentsLayoutEnabled()?NO:((BOOL(*)(id,SEL))original)(object,selector); });
            Install(route[0],route[1],"B@:",replacement,&original,NO);
        }
        Hook0(@"viewDidLoad",^(id owner){ [Adapter(owner,CSMomentsLayoutEnabled()) update]; });
        for(NSString *name in @[@"layoutSubviews",@"updateframe",@"reloadBackGround"])
            HookHeaderBackdrop(name);
        for(NSString *name in @[@"viewWillAppear:",@"viewDidAppear:"]) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
            IMP replacement=imp_implementationWithBlock(^(id owner,BOOL animated){
                ((void(*)(id,SEL,BOOL))original)(owner,selector,animated);
                CSMomentsLayoutAdapter *adapter=Adapter(owner,CSMomentsLayoutEnabled());
                [adapter resumePresentation];
            });
            Install(@"WCTimeLineViewController",name,"v@:B",replacement,&original,NO);
        }
        __block IMP disappeared=NULL;
        __block IMP disappearing=NULL;
        IMP disappearingIMP=imp_implementationWithBlock(^(id owner,BOOL animated){
            CSMomentsLayoutAdapter *adapter=Adapter(owner,NO);
            [adapter stopVideoPlayback]; [adapter capturePosition];
            ((void(*)(id,SEL,BOOL))disappearing)(owner,@selector(viewWillDisappear:),animated);
        });
        Install(@"WCTimeLineViewController",@"viewWillDisappear:","v@:B",disappearingIMP,&disappearing,NO);
        IMP disappearedIMP=imp_implementationWithBlock(^(id owner,BOOL animated){
            ((void(*)(id,SEL,BOOL))disappeared)(owner,@selector(viewDidDisappear:),animated);
            CSMomentsLayoutAdapter *adapter=Adapter(owner,NO);
            adapter.suspended=YES; [adapter stopVideoPlayback];
        });
        Install(@"WCTimeLineViewController",@"viewDidDisappear:","v@:B",disappearedIMP,&disappeared,NO);
        // Never reload the native table or force layout from this callback:
        // native viewDidLayoutSubviews already performs its own reload work.
        Hook0(@"viewDidLayoutSubviews",^(id owner){ CSMomentsLayoutAdapter *adapter=Adapter(owner,NO); [adapter layoutViews]; [adapter scheduleVideoPlayback]; });
        Hook0(@"handleAfterReloadTableView",^(id owner){ [Adapter(owner,NO) scheduleUpdate]; });
        HookObject(@"onMediaItemSizeDidChange:",^(id owner){ [Adapter(owner,NO) scheduleUpdate]; });
        HookCompletion(@"onNoMoreTimelineData",YES,NO,NO);
        HookCompletion(@"onTimelineServerError",NO,YES,NO);
        HookCompletion(@"onNormalTimelineData",NO,NO,NO);
        HookCompletion(@"stopRefreshHeaderView",NO,NO,YES);
        HookNativeFooterCompletion();
        SEL changed=NSSelectorFromString(@"onDataChangedWithAdded:andChanged:andDeleted:");
        __block IMP previousChanged=NULL;
        IMP changedIMP=imp_implementationWithBlock(^(id owner,id added,id changedItems,id deleted){
            BOOL removedItems=[deleted isKindOfClass:NSArray.class] && [deleted count]>0;
            ((void(*)(id,SEL,id,id,id))previousChanged)(owner,changed,added,changedItems,deleted);
            __weak id weakOwner=owner;
            dispatch_async(dispatch_get_main_queue(),^{
                CSMomentsLayoutAdapter *adapter=Adapter(weakOwner,NO);
                // Likes, comments and deletes also arrive here. They update
                // cards but cannot complete an unrelated network request.
                if(removedItems)adapter.acceptEmptySource=YES;
                [adapter scheduleUpdate];
            });
        });
        Install(@"WCTimeLineViewController",NSStringFromSelector(changed),"v@:@@@",changedIMP,&previousChanged,NO);
        for(NSString *notification in @[CSMomentsLayoutChangedNotification,CSCloseFriendPolicyDidChangeNotification,@"CSBackupAccountChanged",CSAdPurificationChangedNotification,UIApplicationDidBecomeActiveNotification,UIApplicationWillResignActiveNotification,UIApplicationDidEnterBackgroundNotification,UIContentSizeCategoryDidChangeNotification]) {
            [NSNotificationCenter.defaultCenter addObserverForName:notification object:nil queue:nil usingBlock:^(__unused NSNotification *note){
                if([notification isEqual:UIApplicationWillResignActiveNotification] || [notification isEqual:UIApplicationDidEnterBackgroundNotification]) {
                    void (^pause)(void)=^{ CSMomentsNativeMediaSetActive(NO); for(CSMomentsLayoutAdapter *adapter in Adapters.allObjects)[adapter stopVideoPlayback]; };
                    if(NSThread.isMainThread)pause(); else dispatch_async(dispatch_get_main_queue(),pause);
                    return;
                }
                // Native preference/account notifications can be posted while
                // locks are held. Never synchronously wait on UIKit from them.
                dispatch_async(dispatch_get_main_queue(),^{
                    if([notification isEqual:UIApplicationDidBecomeActiveNotification]) CSMomentsNativeMediaSetActive(YES);
                    if([notification isEqual:CSCloseFriendPolicyDidChangeNotification] || [notification isEqual:@"CSBackupAccountChanged"])
                        CSMomentsResetCachedMedia();
                    for(CSMomentsLayoutAdapter *adapter in Adapters.allObjects) {
                    // Remove existing text/media immediately on relock/account
                    // changes, before asynchronously reading the new projection.
                    if([notification isEqual:CSCloseFriendPolicyDidChangeNotification] || [notification isEqual:@"CSBackupAccountChanged"] || [notification isEqual:CSAdPurificationChangedNotification]) { [adapter forgetPosition]; [adapter clearPresentation]; }
                    if([notification isEqual:UIContentSizeCategoryDidChangeNotification]) { [adapter clearPresentation]; [adapter.layout invalidateLayout]; }
                    if(!CSMomentsLayoutEnabled())[adapter detach]; else [adapter scheduleUpdate];
                }});
            }];
        }
    });
}
