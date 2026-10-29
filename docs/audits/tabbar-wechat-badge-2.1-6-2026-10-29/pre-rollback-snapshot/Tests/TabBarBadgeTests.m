// Behavioral contract for the production tab bar adapter, using native geometry
// verified in docs/audits/tabbar-badge-2026-10-28/native. This host model covers
// FlexibleLeftMargin, not general UIKit rendering or WeChat runtime transitions.
#import "CSTabBarNativeAdapter.h"
#import "CSTabBarPreferences.h"
#import "TabBarBadgeHookConfiguration.h"
#import <objc/runtime.h>
#include <stdio.h>
#include <math.h>

static NSUserDefaults *ProbeDefaults;
static CGFloat ProbePixelScale=3;
static BOOL ProbeFlexibleLeftMargin=YES;
static BOOL SuppressNativeCounts;
static NSUInteger IconCalls,BadgeCalls,ReloadCalls;
static id IsolatedDefaults(id object,SEL selector) { return ProbeDefaults; }
static CGFloat RoundPixel(CGFloat value) { return nearbyint(value*ProbePixelScale)/ProbePixelScale; }
static CGFloat CeilPixel(CGFloat value) { return ceil(value*ProbePixelScale)/ProbePixelScale; }
static BOOL SameRect(CGRect a,CGRect b) {
    return fabs(a.origin.x-b.origin.x)<.001 && fabs(a.origin.y-b.origin.y)<.001 &&
        fabs(a.size.width-b.size.width)<.001 && fabs(a.size.height-b.size.height)<.001;
}
@interface CSTestNativeBadge : UIView
@property(nonatomic) CGSize requestedNativeSize;
- (void)updateWithSize:(CGSize)size;
- (void)setNativeSize:(CGSize)size;
@end
@implementation CSTestNativeBadge
- (void)setFrame:(CGRect)r {
    // MMBadgeView.setFrame: rounds origin to screen pixels and ceils size.
    r.origin.x=RoundPixel(r.origin.x);r.origin.y=RoundPixel(r.origin.y);
    r.size.width=CeilPixel(r.size.width);r.size.height=CeilPixel(r.size.height);
    [super setFrame:r];
}
- (void)setNativeSize:(CGSize)size { self.requestedNativeSize=size;CGRect r=self.frame;r.size=size;self.frame=r; }
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
@property(nonatomic) CGSize probeNativeIconSize;
@property(nonatomic) BOOL probeHasNativeCustomSize;
@property(nonatomic) NSUInteger probeIconCalls,probeBadgeCalls,probeReloadCalls;
@property(nonatomic) NSInteger probeUnread;
@property(nonatomic,copy) NSString *probeString;
- (void)relayoutIconAndBadge;
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
    if (!SuppressNativeCounts) {ReloadCalls++;self.probeReloadCalls++;}
    self.imageView.image=self.probeNativeImage;
    CSTabBarEndItemUpdate(self);
}
- (void)layoutIcon {
    CSTabBarBeginItemUpdate(self);
    if (!SuppressNativeCounts) {IconCalls++;self.probeIconCalls++;}
    // Native customSize uses its dimensions and bottom=dynamicLength(28)+8.
    // The ordinary path is a dynamicLength(28) square at y=8.
    self.imageView.hidden=NO;
    CGSize size=self.probeHasNativeCustomSize ? self.probeNativeIconSize : CGSizeMake(28,28);
    self.imageView.frame=CGRectMake((CGRectGetWidth(self.bounds)-size.width)/2,self.probeHasNativeCustomSize ? 36-size.height : 8,size.width,size.height);
    CSTabBarEndItemUpdate(self);
}
- (void)layoutBadgeView {
    CSTabBarBeginItemUpdate(self);
    if (!SuppressNativeCounts) {BadgeCalls++;self.probeBadgeCalls++;}
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
- (void)relayoutIconAndBadge {
#if CS_TEST_SOURCE_RELAYOUT_HOOK && !CS_BADGE_DISABLE_RELAYOUT_HOOK
    CSTabBarBeginItemUpdate(self);
#endif
    [self reloadIconImage];[self layoutIcon];[self layoutBadgeView];
#if CS_TEST_SOURCE_RELAYOUT_HOOK && !CS_BADGE_DISABLE_RELAYOUT_HOOK
    CSTabBarEndItemUpdate(self);
#endif
}
- (void)probeLayoutSubviews {
    CSTabBarBeginItemUpdate(self);
    CGRect label=self.textLabel.frame;label.size.width=CGRectGetWidth(self.bounds);label.origin.y=38;self.textLabel.frame=label;
    [self relayoutIconAndBadge];
    CSTabBarEndItemUpdate(self);
}
- (void)probeSetValue:(NSInteger)value {
    // Target setTabBarBadgeValue: is not itself hooked; it changes shape then calls
    // the hooked layoutBadgeView. Widths are representative inputs, not measured text.
    self.probeUnread=value;self.probeString=nil;self.badgeView.hidden=value<=0;
    if (value>0) [(CSTestNativeBadge *)self.badgeView updateWithSize:CGSizeMake(value<10 ? 16 : value<100 ? 24 : 30,16)];
    [self layoutBadgeView];
}
- (void)probeSetString:(NSString *)string {
    self.probeUnread=0;self.probeString=string;self.badgeView.hidden=!string.length;
    if (string.length) [(CSTestNativeBadge *)self.badgeView updateWithSize:CGSizeMake(string.length<2 ? 16 : string.length<3 ? 24 : 30,16)];
    [self relayoutIconAndBadge];
}
- (void)probeShowDot {
    // setAsSmallDot uses setSize rather than updateWithSize; shape block is telemetry.
    self.probeUnread=0;self.probeString=nil;
    [(CSTestNativeBadge *)self.badgeView setNativeSize:CGSizeMake(8,8)];
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
@interface CSTestBadgeFixture : NSObject
@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong) UIView *root;
@property(nonatomic,strong) MMTabBar *bar;
@property(nonatomic,strong) MainTabBarViewController *owner;
@property(nonatomic,strong) NSArray<MMTabBarItemView *> *items;
@property(nonatomic,strong) NSArray *buttons;
- (void)barLayout;
@end
@implementation CSTestBadgeFixture
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
            item.badgeView=[[CSTestNativeBadge alloc] initWithFrame:CGRectMake(0,0,8,8)];[item addSubview:item.badgeView];
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

static NSUInteger Checks,Failures,Combinations,NativeReferenceSamples,NativePartialSamples;
static NSString *Context,*Stage;
static void Check(BOOL condition,const char *expression,int line) {
    Checks++;
    if (condition) return;
    Failures++;
    if (Failures<=12) fprintf(stderr,"badge FAIL line %d [%s / %s]: %s\n",line,Context.UTF8String,Stage.UTF8String,expression);
}
#define BadgeCheck(c) Check((c),#c,__LINE__)
static CGRect NativeReference(MMTabBarItemView *styled,CGFloat width) {
    BOOL previous=SuppressNativeCounts;SuppressNativeCounts=YES;
    MMTabBarItemView *reference=[[MMTabBarItemView alloc] initWithFrame:CGRectMake(0,0,width,49)];
    reference.probeNativeImage=styled.probeNativeImage;
    reference.probeHasNativeCustomSize=styled.probeHasNativeCustomSize;reference.probeNativeIconSize=styled.probeNativeIconSize;
    reference.probeUnread=styled.probeUnread;reference.probeString=styled.probeString;
    reference.imageView=[UIImageView new];reference.textLabel=[UILabel new];
    reference.badgeView=[[CSTestNativeBadge alloc] initWithFrame:(CGRect){CGPointZero,[(CSTestNativeBadge *)styled.badgeView requestedNativeSize]}];
    [reference addSubview:reference.imageView];[reference addSubview:reference.badgeView];
    [reference relayoutIconAndBadge];
    CGRect result=reference.badgeView.frame;
    SuppressNativeCounts=previous;NativeReferenceSamples++;
    if (!CGRectContainsRect(reference.bounds,result)) NativePartialSamples++;
    return result;
}
static CGFloat LeftOverflow(CGRect r) {return MAX(0,-CGRectGetMinX(r));}
static CGFloat TopOverflow(CGRect r) {return MAX(0,-CGRectGetMinY(r));}
static CGFloat RightOverflow(CGRect r,CGFloat width) {return MAX(0,CGRectGetMaxX(r)-width);}
static CGFloat BottomOverflow(CGRect r,CGFloat height) {return MAX(0,CGRectGetMaxY(r)-height);}
static void Observe(CSTestBadgeFixture *fixture,NSArray *identities,BOOL styled,NSArray *steady) {
    for (NSUInteger i=0;i<fixture.items.count;i++) {
        MMTabBarItemView *item=fixture.items[i];CSTestNativeBadge *badge=(id)item.badgeView;
        BadgeCheck(badge==identities[i]);BadgeCheck(badge.superview==item);
        BadgeCheck(!badge.hidden);BadgeCheck(fabs(badge.alpha-.75)<.001);
        BadgeCheck(!CGRectIsEmpty(badge.frame));
        BadgeCheck(isfinite(badge.frame.origin.x) && isfinite(badge.frame.origin.y));
        BadgeCheck(fabs(badge.frame.size.width-CeilPixel(badge.requestedNativeSize.width))<.001);
        BadgeCheck(fabs(badge.frame.size.height-CeilPixel(badge.requestedNativeSize.height))<.001);
        for (UIView *ancestor=badge.superview;ancestor;ancestor=ancestor.superview) BadgeCheck(!ancestor.hidden && ancestor.alpha>.01);
        CGFloat width=CGRectGetWidth(item.bounds),height=CGRectGetHeight(item.bounds);
        CGRect native=NativeReference(item,width);
        if (styled) {
            BadgeCheck(!CGRectIsEmpty(CGRectIntersection(item.bounds,badge.frame)));
            // Permit overflow already owned by native layout at this very item width.
            // Only additional overflow caused by styling is a failure. Pixel alignment
            // is included in both the getter-based reference and the actual frame.
            BadgeCheck(LeftOverflow(badge.frame)<=LeftOverflow(native)+.001);
            BadgeCheck(RightOverflow(badge.frame,width)<=RightOverflow(native,width)+.001);
            BadgeCheck(TopOverflow(badge.frame)<=TopOverflow(native)+.001);
            BadgeCheck(BottomOverflow(badge.frame,height)<=BottomOverflow(native,height)+.001);
            NSUInteger itemIndex=[fixture.bar.subviews indexOfObjectIdenticalTo:item];
            BadgeCheck(itemIndex!=NSNotFound && itemIndex>0);
            UIView *surface=fixture.bar.subviews[0];
            BadgeCheck(surface!=item && !surface.hidden && surface.layer.zPosition<=item.layer.zPosition);
            BadgeCheck([item.subviews indexOfObjectIdenticalTo:badge]>[item.subviews indexOfObjectIdenticalTo:item.imageView]);
        } else {
            BadgeCheck(SameRect(badge.frame,native));
        }
        if (steady) {CGRect expected;[steady[i] getValue:&expected];BadgeCheck(SameRect(badge.frame,expected));}
    }
}
static NSArray *Frames(CSTestBadgeFixture *f) {
    NSMutableArray *result=[NSMutableArray array];
    for (MMTabBarItemView *item in f.items) {CGRect frame=item.badgeView.frame;[result addObject:[NSValue valueWithBytes:&frame objCType:@encode(CGRect)]];}
    return result;
}
static void SetContent(CSTestBadgeFixture *f,NSUInteger type) {
    for (MMTabBarItemView *item in f.items) {
        if (type==0) [item probeShowDot];
        else if (type==1) [item probeSetValue:1];
        else if (type==2) [item probeSetValue:12];
        else [item probeSetString:@"99+"];
    }
}
static void Enable(CSTestBadgeFixture *f,BOOL enabled) {
    [ProbeDefaults setBool:enabled forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(f.bar);
}
static NSDictionary *NativeCounts(MMTabBarItemView *item) {
    return @{@"reloadIconImage":@(item.probeReloadCalls),@"layoutIcon":@(item.probeIconCalls),@"layoutBadgeView":@(item.probeBadgeCalls)};
}
static NSDictionary *CountDifference(NSDictionary *after,NSDictionary *before,NSUInteger repeats) {
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    for (NSString *key in @[@"reloadIconImage",@"layoutIcon",@"layoutBadgeView"]) result[key]=@(([after[key] doubleValue]-[before[key] doubleValue])/repeats);
    result[@"geometryCalls"]=@([result[@"layoutIcon"] doubleValue]+[result[@"layoutBadgeView"] doubleValue]);
    return result;
}
static void MeasureEvents(CSTestBadgeFixture *f,NSMutableArray *measurements) {
    for (NSNumber *styled in @[@NO,@YES]) {
        Enable(f,styled.boolValue);
        for (NSString *event in @[@"ordinaryUpdate",@"layoutIcon",@"layoutBadgeView",@"relayoutIconAndBadge",@"item.layoutSubviews",@"bar.layout"]) {
            NSMutableArray *before=[NSMutableArray array];for (MMTabBarItemView *item in f.items)[before addObject:NativeCounts(item)];
            NSDictionary *totalBefore=@{@"reloadIconImage":@(ReloadCalls),@"layoutIcon":@(IconCalls),@"layoutBadgeView":@(BadgeCalls)};
            for (NSUInteger n=0;n<100;n++) {
                if ([event isEqual:@"ordinaryUpdate"]) CSTabBarUpdate(f.bar);
                else if ([event isEqual:@"layoutIcon"]) [f.items[0] layoutIcon];
                else if ([event isEqual:@"layoutBadgeView"]) [f.items[0] layoutBadgeView];
                else if ([event isEqual:@"relayoutIconAndBadge"]) [f.items[0] relayoutIconAndBadge];
                else if ([event isEqual:@"item.layoutSubviews"]) [f.items[0] probeLayoutSubviews];
                else [f barLayout];
            }
            NSMutableArray *perItem=[NSMutableArray array];for (NSUInteger i=0;i<f.items.count;i++)[perItem addObject:CountDifference(NativeCounts(f.items[i]),before[i],100)];
            NSDictionary *totalAfter=@{@"reloadIconImage":@(ReloadCalls),@"layoutIcon":@(IconCalls),@"layoutBadgeView":@(BadgeCalls)};
            [measurements addObject:@{@"styleEnabled":styled,@"event":event,@"repetitions":@100,@"perEventTotal":CountDifference(totalAfter,totalBefore,100),@"perEventEachItem":perItem}];
        }
    }
    Enable(f,YES);
}
static void Exercise(CSTestBadgeFixture *f,NSArray *identities) {
    Stage=@"first native relayout while styled";
    for (MMTabBarItemView *item in f.items) [item relayoutIconAndBadge];
    Observe(f,identities,YES,nil);
    NSArray *steady=Frames(f);
    for (NSUInteger n=0;n<100;n++) {
        Stage=@"100 ordinary Updates";CSTabBarUpdate(f.bar);Observe(f,identities,YES,steady);
    }
    for (MMTabBarItemView *item in f.items) [item probeLayoutSubviews];
    steady=Frames(f);
    for (NSUInteger n=0;n<100;n++) {
        Stage=@"100 nested item layouts";for (MMTabBarItemView *item in f.items) [item probeLayoutSubviews];Observe(f,identities,YES,steady);
    }
    [f barLayout];steady=Frames(f);
    for (NSUInteger n=0;n<100;n++) {
        Stage=@"100 nested bar layouts";[f barLayout];Observe(f,identities,YES,steady);
    }
    Stage=@"selection and light/dark changes";
    for (NSUInteger state=0;state<2;state++) {
        f.owner.selectedIndex=state;
        f.bar.traitCollection.userInterfaceStyle=state ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        for (MMTabBarItemView *item in f.items) {item.isSelected=state;[item relayoutIconAndBadge];}
        CSTabBarUpdate(f.bar);Observe(f,identities,YES,nil);
    }
    Stage=@"detach and reattach";
    [f.bar removeFromSuperview];CSTabBarUpdate(f.bar);[f.root addSubview:f.bar];CSTabBarUpdate(f.bar);Observe(f,identities,YES,nil);
    for (NSUInteger toggle=0;toggle<20;toggle++) {
        Stage=@"repeated disable restores native frame";Enable(f,NO);Observe(f,identities,NO,nil);
        Stage=@"repeated enable";Enable(f,YES);Observe(f,identities,YES,nil);
    }
}
int main(int argc,const char *argv[]) { @autoreleasepool {
    NSString *suite=[@"com.wechatimprove.test.badge." stringByAppendingString:NSUUID.UUID.UUIDString];
    ProbeDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Method method=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));IMP previous=method_setImplementation(method,(IMP)IsolatedDefaults);
    NSString *iconPath=[NSString stringWithUTF8String:argv[1]];[@"test image" writeToFile:iconPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSUInteger measuredIconCalls=0,measuredBadgeCalls=0,measuredReloadCalls=0;
    NSMutableArray *eventMeasurements=[NSMutableArray array];
    @try {
        for (NSNumber *pixel in @[@2,@3]) for (NSNumber *scale in @[@.6,@.7,@.8,@.9,@1]) for (NSNumber *height in @[@44,@52,@80]) for (NSNumber *hide in @[@NO,@YES]) for (NSNumber *custom in @[@NO,@YES]) for (NSUInteger type=0;type<4;type++) {
            @autoreleasepool {
                Combinations++;ProbePixelScale=pixel.doubleValue;UIScreen.mainScreen.scale=ProbePixelScale;
                Context=[NSString stringWithFormat:@"pixel=%@ scale=%@ height=%@ hide=%@ imported=%@ badge=%lu",pixel,scale,height,hide,custom,(unsigned long)type];
                [ProbeDefaults removePersistentDomainForName:suite];[ProbeDefaults setDouble:scale.doubleValue forKey:kTabBarScaleKey];[ProbeDefaults setDouble:height.doubleValue forKey:kTabBarContentHeightKey];[ProbeDefaults setBool:hide.boolValue forKey:kTabBarHideTextKey];
                if (custom.boolValue) for (NSString *key in @[kTabBarIconChatKey,kTabBarIconContactsKey,kTabBarIconDiscoverKey,kTabBarIconMeKey]) [ProbeDefaults setObject:iconPath forKey:key];
                [CSTabBarPreferences reload];CSTestBadgeFixture *f=[CSTestBadgeFixture new];SetContent(f,type);
                for (MMTabBarItemView *item in f.items) {item.badgeView.alpha=.75;[item relayoutIconAndBadge];}
                NSArray *identities=[f.items valueForKey:@"badgeView"];
                Stage=@"first enable with existing badge";Enable(f,YES);Observe(f,identities,YES,nil);
                Exercise(f,identities);
                for (NSUInteger changed=0;changed<4;changed++) {Stage=@"native value/string/dot update";SetContent(f,changed);CSTabBarUpdate(f.bar);Observe(f,identities,YES,nil);}
                // Zero-value hide is owned by WeChat; styling must preserve it and size.
                Stage=@"native hidden badge";
                for (MMTabBarItemView *item in f.items) [item probeSetValue:0];
                CSTabBarUpdate(f.bar);for (MMTabBarItemView *item in f.items) {BadgeCheck(item.badgeView.hidden);BadgeCheck(item.badgeView==identities[[f.items indexOfObjectIdenticalTo:item]]);}
                SetContent(f,type);CSTabBarUpdate(f.bar);
                if (pixel.integerValue==3 && scale.doubleValue==.9 && height.integerValue==52 && !hide.boolValue && !custom.boolValue && type==2) {
                    NSUInteger icons=IconCalls,badges=BadgeCalls,reloads=ReloadCalls;
                    for (NSUInteger n=0;n<100;n++) [f.items[0] relayoutIconAndBadge];
                    measuredIconCalls=IconCalls-icons;measuredBadgeCalls=BadgeCalls-badges;measuredReloadCalls=ReloadCalls-reloads;
                    MeasureEvents(f,eventMeasurements);
                }
                Stage=@"final restore";Enable(f,NO);Observe(f,identities,NO,nil);
            }
        }
        // Native customSize and larger label lineHeight are statically supported
        // boundaries. Styling may not add overflow beyond same-width native layout.
        for (NSNumber *pixel in @[@2,@3]) for (NSNumber *scale in @[@.6,@.7,@.8,@.9,@1]) for (NSUInteger edge=0;edge<2;edge++) for (NSUInteger type=0;type<4;type++) {
            @autoreleasepool {
                Combinations++;ProbePixelScale=pixel.doubleValue;UIScreen.mainScreen.scale=ProbePixelScale;
                Context=[NSString stringWithFormat:@"edge=%lu pixel=%@ scale=%@ badge=%lu",(unsigned long)edge,pixel,scale,(unsigned long)type];
                [ProbeDefaults removePersistentDomainForName:suite];[ProbeDefaults setDouble:scale.doubleValue forKey:kTabBarScaleKey];[ProbeDefaults setDouble:edge==0 ? 44 : 52 forKey:kTabBarContentHeightKey];[CSTabBarPreferences reload];
                CSTestBadgeFixture *f=[CSTestBadgeFixture new];
                for (MMTabBarItemView *item in f.items) {if (edge==0) item.textLabel.font.lineHeight=20;else {item.probeHasNativeCustomSize=YES;item.probeNativeIconSize=CGSizeMake(20,20);}}
                SetContent(f,type);for (MMTabBarItemView *item in f.items) {item.badgeView.alpha=.75;[item relayoutIconAndBadge];}
                NSArray *identities=[f.items valueForKey:@"badgeView"];
                Stage=@"edge first enable";Enable(f,YES);Observe(f,identities,YES,nil);
                Exercise(f,identities);Stage=@"edge restore";Enable(f,NO);Observe(f,identities,NO,nil);
            }
        }
        printf("tabbar native badges: %lu combinations, %lu checks, %lu failures; source relayout hook=%d, disabled=%d\n",(unsigned long)Combinations,(unsigned long)Checks,(unsigned long)Failures,CS_TEST_SOURCE_RELAYOUT_HOOK,CS_BADGE_DISABLE_RELAYOUT_HOOK);
        printf("native same-width counterfactual: %lu getter samples, %lu naturally partial\n",(unsigned long)NativeReferenceSamples,(unsigned long)NativePartialSamples);
        printf("100 compound native relayouts: reloadIconImage=%lu layoutIcon=%lu layoutBadgeView=%lu\n",(unsigned long)measuredReloadCalls,(unsigned long)measuredIconCalls,(unsigned long)measuredBadgeCalls);
        NSDictionary *measurement=@{@"sourceRelayoutHook":@(CS_TEST_SOURCE_RELAYOUT_HOOK),@"disabledRelayoutHook":@(CS_BADGE_DISABLE_RELAYOUT_HOOK),@"events":eventMeasurements};
        NSData *measurementData=[NSJSONSerialization dataWithJSONObject:measurement options:NSJSONWritingSortedKeys error:nil];
        printf("native event counts: %s\n",[[[NSString alloc] initWithData:measurementData encoding:NSUTF8StringEncoding] UTF8String]);
    } @finally {[ProbeDefaults removePersistentDomainForName:suite];method_setImplementation(method,previous);}
    return Failures ? 1 : 0;
}}
