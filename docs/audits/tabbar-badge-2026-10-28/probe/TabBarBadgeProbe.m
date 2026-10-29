// Isolated analysis probe, compiled against the production 2.1-6 adapter.
// Native geometry is transcribed from the bounded 8.0.78 disassembly in ../native.
// FlexibleLeftMargin can be modeled explicitly. Other UIKit autoresizing,
// rendering and the complete WeChat app are outside this probe.
#import "CSTabBarNativeAdapter.h"
#import "CSTabBarPreferences.h"
#import <objc/runtime.h>
#include <stdio.h>
#include <math.h>

static NSUserDefaults *ProbeDefaults;
static CGFloat ProbePixelScale=3;
static BOOL ProbeFlexibleLeftMargin;
static NSUInteger IconCalls,BadgeCalls,ReloadCalls;
static id IsolatedDefaults(id object,SEL selector) { return ProbeDefaults; }
static CGFloat RoundPixel(CGFloat value) { return nearbyint(value*ProbePixelScale)/ProbePixelScale; }
static CGFloat CeilPixel(CGFloat value) { return ceil(value*ProbePixelScale)/ProbePixelScale; }
static NSArray *RectValues(CGRect r) { return @[@(r.origin.x),@(r.origin.y),@(r.size.width),@(r.size.height)]; }
static BOOL SameRect(CGRect a,CGRect b) {
    return fabs(a.origin.x-b.origin.x)<.001 && fabs(a.origin.y-b.origin.y)<.001 &&
        fabs(a.size.width-b.size.width)<.001 && fabs(a.size.height-b.size.height)<.001;
}
@interface ProbeBadge : UIView
- (void)updateWithSize:(CGSize)size;
- (void)setNativeSize:(CGSize)size;
@end
@implementation ProbeBadge
- (void)setFrame:(CGRect)r {
    // MMBadgeView.setFrame: rounds origin to screen pixels and ceils size.
    r.origin.x=RoundPixel(r.origin.x);r.origin.y=RoundPixel(r.origin.y);
    r.size.width=CeilPixel(r.size.width);r.size.height=CeilPixel(r.size.height);
    [super setFrame:r];
}
- (void)setNativeSize:(CGSize)size { CGRect r=self.frame;r.size=size;self.frame=r; }
- (void)updateWithSize:(CGSize)size {
    // Native updateWithSize: preserves center across its setSize:/setCenter: calls.
    CGRect before=self.frame;
    CGPoint center=CGPointMake(CGRectGetMidX(before),CGRectGetMidY(before));
    [self setNativeSize:size];
    CGRect r=self.frame;
    r.origin=CGPointMake(RoundPixel(center.x-r.size.width/2),RoundPixel(center.y-r.size.height/2));
    self.frame=r;
}
@end
@implementation MMTabbarItem @end
@interface MMTabBarItemView ()
@property(nonatomic,strong) UIView *customIconView;
@property(nonatomic,strong) UIImage *probeNativeImage;
@property(nonatomic) NSInteger probeUnread;
@property(nonatomic,copy) NSString *probeString;
- (void)probeRelayout;
- (void)probeLayoutSubviews;
- (void)probeSetValue:(NSInteger)value;
- (void)probeSetString:(NSString *)string;
- (void)probeShowDot;
@end
@implementation MMTabBarItemView
- (void)setFrame:(CGRect)frame {
    CGFloat oldWidth=CGRectGetWidth(self.bounds);
    [super setFrame:frame];
    if (ProbeFlexibleLeftMargin && self.imageView && oldWidth!=CGRectGetWidth(frame)) {
        // Only the native imageView's confirmed UIViewAutoresizingFlexibleLeftMargin
        // is modeled here; the general UIKit autoresizing engine is not simulated.
        CGRect image=self.imageView.frame;image.origin.x+=CGRectGetWidth(frame)-oldWidth;self.imageView.frame=image;
    }
}
- (void)reloadIconImage {
    CSTabBarBeginItemUpdate(self);
    ReloadCalls++;
    self.imageView.image=self.probeNativeImage;
    CSTabBarEndItemUpdate(self);
}
- (void)layoutIcon {
    CSTabBarBeginItemUpdate(self);
    IconCalls++;
    // Native non-customSize path: dynamicLength(28) assumed 28 at default font.
    self.imageView.hidden=NO;
    self.imageView.frame=CGRectMake((CGRectGetWidth(self.bounds)-28)/2,8,28,28);
    CSTabBarEndItemUpdate(self);
}
- (void)layoutBadgeView {
    CSTabBarBeginItemUpdate(self);
    BadgeCalls++;
    CGRect r=self.badgeView.frame;
    if (self.probeUnread>0 || self.probeString.length) {
        // Native digits/string: setY(4), setX(getBadgeViewRightMarginPortrait).
        r.origin=CGPointMake(CGRectGetWidth(self.bounds)/2+3,4);
    } else {
        // Native dot: setY(imageView.y), setRight(imageView.right).
        r.origin=CGPointMake(CGRectGetMaxX(self.imageView.frame)-r.size.width,CGRectGetMinY(self.imageView.frame));
    }
    self.badgeView.frame=r;
    CSTabBarEndItemUpdate(self);
}
- (void)probeRelayout { [self reloadIconImage];[self layoutIcon];[self layoutBadgeView]; }
- (void)probeLayoutSubviews {
    CSTabBarBeginItemUpdate(self);
    CGRect label=self.textLabel.frame;label.size.width=CGRectGetWidth(self.bounds);label.origin.y=38;self.textLabel.frame=label;
    [self probeRelayout];
    CSTabBarEndItemUpdate(self);
}
- (void)probeSetValue:(NSInteger)value {
    // Target setTabBarBadgeValue: is not itself hooked; it changes shape then calls
    // the hooked layoutBadgeView. Widths are representative inputs, not measured text.
    self.probeUnread=value;self.probeString=nil;self.badgeView.hidden=value<=0;
    if (value>0) [(ProbeBadge *)self.badgeView updateWithSize:CGSizeMake(value<10 ? 16 : value<100 ? 24 : 30,16)];
    [self layoutBadgeView];
}
- (void)probeSetString:(NSString *)string {
    self.probeUnread=0;self.probeString=string;self.badgeView.hidden=!string.length;
    if (string.length) [(ProbeBadge *)self.badgeView updateWithSize:CGSizeMake(string.length<2 ? 16 : string.length<3 ? 24 : 30,16)];
    [self probeRelayout];
}
- (void)probeShowDot {
    // setAsSmallDot uses setSize rather than updateWithSize; shape block is telemetry.
    self.probeUnread=0;self.probeString=nil;
    [(ProbeBadge *)self.badgeView setNativeSize:CGSizeMake(8,8)];
    self.badgeView.hidden=NO;
    // showSmallRedDot ends in layoutIcon, not layoutBadgeView in this target.
    [self layoutIcon];
}
@end
@implementation MMTabBar
- (void)relayoutTabBarItems {}
@end
@implementation MMTabBarController
- (id)getTabBarBtnForIndex:(unsigned long long)i { return nil; }
- (void)onTabBarItemViewsRelayout {}
@end
@interface MainTabBarViewController : MMTabBarController
@property(nonatomic,strong) NSArray *buttons;
@end
@implementation MainTabBarViewController
- (id)getTabBarBtnForIndex:(unsigned long long)i { return i<self.buttons.count ? self.buttons[i] : nil; }
@end
@interface Fixture : NSObject
@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong) UIView *root;
@property(nonatomic,strong) MMTabBar *bar;
@property(nonatomic,strong) MainTabBarViewController *owner;
@property(nonatomic,strong) NSArray<MMTabBarItemView *> *items;
@property(nonatomic,strong) NSArray *buttons;
- (void)barLayout;
@end
@implementation Fixture
- (instancetype)init {
    if ((self=[super init])) {
        self.window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];
        self.root=[[UIView alloc] initWithFrame:self.window.bounds];[self.window addSubview:self.root];
        self.bar=[[MMTabBar alloc] initWithFrame:CGRectMake(0,761,390,83)];[self.root addSubview:self.bar];
        self.bar.backgroundView=[[UIView alloc] initWithFrame:self.bar.bounds];[self.bar addSubview:self.bar.backgroundView];
        self.bar.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        self.owner=[MainTabBarViewController new];self.owner.view=self.root;self.owner.tabBar=self.bar;self.bar.customDelegate=self.owner;
        NSMutableArray *items=[NSMutableArray array],*models=[NSMutableArray array],*buttons=[NSMutableArray array];
        for (NSUInteger i=0;i<4;i++) {
            MMTabbarItem *model=[MMTabbarItem new];model.index=i;[models addObject:model];
            MMTabBarItemView *item=[[MMTabBarItemView alloc] initWithFrame:CGRectMake(97.5*i,0,97.5,49)];item.item=model;
            item.probeNativeImage=[UIImage new];
            item.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(34.75,8,28,28)];item.imageView.image=item.probeNativeImage;[item addSubview:item.imageView];
            item.textLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,38,97.5,12)];item.textLabel.text=@"Native";[item addSubview:item.textLabel];
            item.badgeView=[[ProbeBadge alloc] initWithFrame:CGRectMake(0,0,8,8)];[item addSubview:item.badgeView];
            [self.bar addSubview:item];[items addObject:item];
            UIControl *button=[[UIControl alloc] initWithFrame:item.frame];[self.bar addSubview:button];[buttons addObject:button];
        }
        self.items=items;self.buttons=buttons;self.owner.buttons=buttons;self.bar.tabBarItemViews=(id)items;self.bar.items=models;
    }
    return self;
}
- (void)barLayout {
    CSTabBarBeginLayout(self.bar);
    // Native item frames stay in the untouched bar; native UIKit layout may be queued.
    // This explicit synchronous composition checks the nested Hook depth path only.
    for (NSUInteger i=0;i<self.items.count;i++) {
        self.items[i].frame=CGRectMake(i*97.5,0,97.5,49);[self.buttons[i] setFrame:self.items[i].frame];
        [self.items[i] probeLayoutSubviews];
    }
    CSTabBarEndLayout(self.bar);
}
@end

static NSUInteger ObservationCount,NonzeroFailures,HiddenFailures,IntersectionFailures,AncestorFailures,IdentityFailures,DriftFailures,RestoreFailures,OutsideCount;
static NSMutableArray *Examples,*Rows,*Trace;
static NSMutableDictionary *StageCounts,*StageMatrix;
static NSString *Context;
static NSNumber *CurrentWidth,*CurrentInitial;
static CGFloat MaxRepeatedOriginError,MaxRestoreOriginError,CombinationMaxRepeatedError;
static NSDictionary *WorstRepeated,*WorstRestore;
static void SampleFailure(NSString *kind,MMTabBarItemView *item,NSString *stage) {
    NSString *key=[NSString stringWithFormat:@"%@:%@",stage,kind];
    StageCounts[key]=@([StageCounts[key] unsignedIntegerValue]+1);
    if (Examples.count>=32) return;
    [Examples addObject:@{@"kind":kind,@"context":Context,@"stage":stage,@"badge":RectValues(item.badgeView.frame),@"image":RectValues(item.imageView.frame),@"item":RectValues(item.frame)}];
}
static void RecordTrace(Fixture *f,NSString *stage) {
    MMTabBarItemView *item=f.items[0];
    [Trace addObject:@{@"context":Context,@"stage":stage,@"badge":RectValues(item.badgeView.frame),@"image":RectValues(item.imageView.frame),@"item":RectValues(item.frame)}];
}
static void Observe(Fixture *f,NSString *stage,NSArray *identities,BOOL expectedHidden) {
    NSString *groupName=[NSString stringWithFormat:@"width=%@ %@%@",CurrentWidth,stage,([stage isEqual:@"firstEnable"] || [stage isEqual:@"100PlainUpdates"]) ? [NSString stringWithFormat:@" initial=%@",CurrentInitial] : @""];
    NSMutableDictionary *group=StageMatrix[groupName];if (!group) {group=[@{@"observations":@0,@"emptyIntersections":@0,@"notContained":@0} mutableCopy];StageMatrix[groupName]=group;}
    for (NSUInteger i=0;i<f.items.count;i++) {
        MMTabBarItemView *item=f.items[i];UIView *badge=item.badgeView;ObservationCount++;
        group[@"observations"]=@([group[@"observations"] unsignedIntegerValue]+1);
        if (badge!=identities[i]) {IdentityFailures++;SampleFailure(@"identity",item,stage);}
        if (badge.hidden!=expectedHidden) {HiddenFailures++;SampleFailure(@"hidden",item,stage);}
        if (CGRectIsEmpty(badge.frame) || !isfinite(badge.frame.origin.x) || !isfinite(badge.frame.origin.y)) {NonzeroFailures++;SampleFailure(@"zeroOrNonfinite",item,stage);}
        CGRect visible=CGRectIntersection(item.bounds,badge.frame);
        if (!expectedHidden && CGRectIsEmpty(visible)) {IntersectionFailures++;group[@"emptyIntersections"]=@([group[@"emptyIntersections"] unsignedIntegerValue]+1);SampleFailure(@"noItemIntersection",item,stage);}
        if (!CGRectContainsRect(item.bounds,badge.frame)) {OutsideCount++;group[@"notContained"]=@([group[@"notContained"] unsignedIntegerValue]+1);}
        for (UIView *v=badge.superview;v;v=v.superview) if (v.hidden || v.alpha<.01) {AncestorFailures++;SampleFailure(@"hiddenAncestor",item,stage);break;}
    }
}
static NSArray *Frames(Fixture *f) { NSMutableArray *frames=[NSMutableArray array];for (MMTabBarItemView *i in f.items)[frames addObject:[NSValue valueWithBytes:&(CGRect){i.badgeView.frame.origin,i.badgeView.frame.size} objCType:@encode(CGRect)]];return frames; }
static CGRect ValueRect(NSValue *value) { CGRect r;[value getValue:&r];return r; }
static void MeasureRepeated(Fixture *f,NSArray *expected,NSString *stage) {
    for (NSUInteger i=0;i<f.items.count;i++) {
        CGRect actual=f.items[i].badgeView.frame,before=ValueRect(expected[i]);
        CGFloat error=MAX(fabs(actual.origin.x-before.origin.x),fabs(actual.origin.y-before.origin.y));
        CombinationMaxRepeatedError=MAX(CombinationMaxRepeatedError,error);
        if (error>MaxRepeatedOriginError) {MaxRepeatedOriginError=error;WorstRepeated=@{@"context":Context,@"stage":stage,@"expected":RectValues(before),@"actual":RectValues(actual)};}
    }
}
static void CheckRepeated(Fixture *f,NSArray *expected,NSString *stage,BOOL restore) {
    for (NSUInteger i=0;i<f.items.count;i++) {
        if (restore) {
            CGRect actual=f.items[i].badgeView.frame,before=ValueRect(expected[i]);
            CGFloat error=MAX(fabs(actual.origin.x-before.origin.x),fabs(actual.origin.y-before.origin.y));
            if (error>MaxRestoreOriginError) {MaxRestoreOriginError=error;WorstRestore=@{@"context":Context,@"stage":stage,@"expected":RectValues(before),@"actual":RectValues(actual)};}
        }
        if (!SameRect(f.items[i].badgeView.frame,ValueRect(expected[i]))) {
            if (restore) RestoreFailures++;else DriftFailures++;
            SampleFailure(restore ? @"restoreDifference" : @"repeatedDrift",f.items[i],stage);
        }
    }
}
int main(int argc,const char *argv[]) { @autoreleasepool {
    NSString *suite=[@"com.wechatimprove.test.badgeprobe." stringByAppendingString:NSUUID.UUID.UUIDString];
    ProbeDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Method method=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));IMP previous=method_setImplementation(method,(IMP)IsolatedDefaults);
    Examples=[NSMutableArray array];Rows=[NSMutableArray array];Trace=[NSMutableArray array];StageCounts=[NSMutableDictionary dictionary];StageMatrix=[NSMutableDictionary dictionary];NSString *iconPath=[NSString stringWithUTF8String:argv[1]];
    ProbeFlexibleLeftMargin=argc>2 && strcmp(argv[2],"flexible-left-margin")==0;
    [@"probe image" writeToFile:iconPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSUInteger combinations=0;
    @try {
        for (NSNumber *pixelScale in @[@2,@3]) for (NSNumber *scale in @[@.6,@.7,@.8,@.9,@1]) for (NSNumber *height in @[@44,@52,@80]) for (NSNumber *hide in @[@NO,@YES]) for (NSNumber *custom in @[@NO,@YES]) for (NSNumber *initial in @[@0,@1,@12,@100]) {
            @autoreleasepool {
                combinations++;ProbePixelScale=pixelScale.doubleValue;CurrentWidth=scale;CurrentInitial=initial;
                Context=[NSString stringWithFormat:@"pixel=%@ width=%@ height=%@ hide=%@ imported=%@ initial=%@",pixelScale,scale,height,hide,custom,initial];
                NSUInteger beginIntersection=IntersectionFailures,beginOutside=OutsideCount,beginDrift=DriftFailures,beginRestore=RestoreFailures;
                CombinationMaxRepeatedError=0;
                BOOL trace=scale.doubleValue==.6 && height.integerValue==44 && !hide.boolValue && !custom.boolValue && initial.integerValue==0;
                [ProbeDefaults removePersistentDomainForName:suite];
                [ProbeDefaults setDouble:scale.doubleValue forKey:kTabBarScaleKey];[ProbeDefaults setDouble:height.doubleValue forKey:kTabBarContentHeightKey];[ProbeDefaults setBool:hide.boolValue forKey:kTabBarHideTextKey];
                if (custom.boolValue) for (NSString *key in @[kTabBarIconChatKey,kTabBarIconContactsKey,kTabBarIconDiscoverKey,kTabBarIconMeKey]) [ProbeDefaults setObject:iconPath forKey:key];
                [CSTabBarPreferences reload];Fixture *f=[Fixture new];
                for (MMTabBarItemView *item in f.items) {if (initial.integerValue) [item probeSetValue:initial.integerValue];else {[item probeShowDot];[item layoutBadgeView];}}
                NSArray *identities=[f.items valueForKey:@"badgeView"],*native=Frames(f);
                if (trace) RecordTrace(f,@"nativeBeforeEnable");
                [ProbeDefaults setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);
                Observe(f,@"firstEnable",identities,NO);
                NSUInteger firstIntersection=IntersectionFailures-beginIntersection,firstOutside=OutsideCount-beginOutside;
                if (trace) RecordTrace(f,@"firstEnable");
                NSArray *first=Frames(f);
                for (int n=0;n<100;n++) {CSTabBarUpdate(f.bar);MeasureRepeated(f,first,[NSString stringWithFormat:@"plainUpdate%d",n+1]);if (trace && (n<5 || n==99))RecordTrace(f,[NSString stringWithFormat:@"plainUpdate%d",n+1]);}
                Observe(f,@"100PlainUpdates",identities,NO);CheckRepeated(f,first,@"100PlainUpdates",NO);
                [ProbeDefaults setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);CheckRepeated(f,native,@"firstRestore",YES);
                if (trace)RecordTrace(f,@"firstRestore");
                [ProbeDefaults setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);
                for (NSString *mode in @[@"value1",@"value12",@"value100",@"string99+",@"dot",@"hidden",@"dot"]) {
                    for (MMTabBarItemView *item in f.items) {
                        if ([mode isEqual:@"dot"]) [item probeShowDot];
                        else if ([mode isEqual:@"hidden"]) [item probeSetValue:0];
                        else if ([mode hasPrefix:@"string"]) [item probeSetString:@"99+"];
                        else [item probeSetValue:[[mode substringFromIndex:5] integerValue]];
                    }
                    BOOL hidden=[mode isEqual:@"hidden"];
                    Observe(f,[mode stringByAppendingString:@"AfterNativeUpdate"],identities,hidden);
                    if (trace)RecordTrace(f,[mode stringByAppendingString:@"AfterNativeUpdate"]);
                    for (MMTabBarItemView *item in f.items) [item probeLayoutSubviews];
                    NSArray *steady=Frames(f);
                    for (int n=0;n<100;n++) {for (MMTabBarItemView *item in f.items) [item probeLayoutSubviews];MeasureRepeated(f,steady,[NSString stringWithFormat:@"%@ItemLayout%d",mode,n+1]);}
                    Observe(f,[mode stringByAppendingString:@"100ItemLayouts"],identities,hidden);CheckRepeated(f,steady,[mode stringByAppendingString:@"100ItemLayouts"],NO);
                    if (trace)RecordTrace(f,[mode stringByAppendingString:@"100ItemLayouts"]);
                    [f barLayout];NSArray *barSteady=Frames(f);
                    for (int n=0;n<100;n++) {[f barLayout];MeasureRepeated(f,barSteady,[NSString stringWithFormat:@"%@BarLayout%d",mode,n+1]);}
                    Observe(f,[mode stringByAppendingString:@"100BarLayouts"],identities,hidden);CheckRepeated(f,barSteady,[mode stringByAppendingString:@"100BarLayouts"],NO);
                    if (trace)RecordTrace(f,[mode stringByAppendingString:@"100BarLayouts"]);
                    // Confirm one disable/enable cycle is idempotent after native activity.
                    [ProbeDefaults setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);NSArray *restored=Frames(f);
                    [ProbeDefaults setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);
                    [ProbeDefaults setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);CheckRepeated(f,restored,[mode stringByAppendingString:@"ToggleRestore"],YES);
                    [ProbeDefaults setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);
                }
                [Rows addObject:@{@"context":Context,@"pixelScale":pixelScale,@"widthScale":scale,@"height":height,@"hideText":hide,@"importedIcon":custom,@"initialBadge":initial,@"firstEnableEmptyIntersections":@(firstIntersection),@"firstEnableNotContained":@(firstOutside),@"emptyIntersections":@(IntersectionFailures-beginIntersection),@"notContained":@(OutsideCount-beginOutside),@"repeatedDriftFailures":@(DriftFailures-beginDrift),@"restoreFailures":@(RestoreFailures-beginRestore),@"maxRepeatedOriginError":@(CombinationMaxRepeatedError)}];
            }
        }
        NSDictionary *result=@{@"flexibleLeftMarginModeled":@(ProbeFlexibleLeftMargin),@"combinations":@(combinations),@"observations":@(ObservationCount),@"nonzeroFailures":@(NonzeroFailures),@"hiddenFailures":@(HiddenFailures),@"emptyIntersectionFailures":@(IntersectionFailures),@"hiddenAncestorFailures":@(AncestorFailures),@"identityFailures":@(IdentityFailures),@"repeatedDriftFailures":@(DriftFailures),@"restoreFailures":@(RestoreFailures),@"maxRepeatedOriginError":@(MaxRepeatedOriginError),@"maxRestoreOriginError":@(MaxRestoreOriginError),@"worstRepeated":WorstRepeated ?: (id)NSNull.null,@"worstRestore":WorstRestore ?: (id)NSNull.null,@"notFullyContainedObservations":@(OutsideCount),@"nativeIconCalls":@(IconCalls),@"nativeBadgeCalls":@(BadgeCalls),@"nativeReloadCalls":@(ReloadCalls),@"examples":Examples,@"stageCounts":StageCounts,@"stageMatrix":StageMatrix,@"matrix":Rows,@"trace":Trace};
        NSData *json=[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:nil];fwrite(json.bytes,1,json.length,stdout);fputc('\n',stdout);
    } @finally {[ProbeDefaults removePersistentDomainForName:suite];method_setImplementation(method,previous);}
}return 0;}
