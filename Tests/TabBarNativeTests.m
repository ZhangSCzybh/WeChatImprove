#import "CSTabBarNativeAdapter.h"
#import "CSTabBarSwipeSwitcher.h"
#import "CSTabBarPreferences.h"
#import <objc/runtime.h>
#import <assert.h>

// Headless macOS discards CA animations at transaction commit. Record the submitted
// copies while forwarding to QuartzCore; geometry and masks still use real CG/CA objects.
static char SubmittedAnimationsKey;
static char AnimationRemovalCountKey;
static IMP originalAddAnimation, originalRemoveAnimation, originalLookupAnimation, originalRemoveAllAnimations;
static NSUInteger submittedAnimationCount;
static void RecordAnimation(CALayer *layer,SEL selector,CAAnimation *animation,NSString *key) {
    NSMutableDictionary *submitted=objc_getAssociatedObject(layer,&SubmittedAnimationsKey);
    if (!submitted) {
        submitted=[NSMutableDictionary dictionary];
        objc_setAssociatedObject(layer,&SubmittedAnimationsKey,submitted,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (key) { submitted[key]=[animation copy]; if ([key hasPrefix:@"cs.tabbar."]) submittedAnimationCount++; }
    ((void(*)(id,SEL,id,id))originalAddAnimation)(layer,selector,animation,key);
}
static void RecordRemoval(CALayer *layer,SEL selector,NSString *key) {
    [objc_getAssociatedObject(layer,&SubmittedAnimationsKey) removeObjectForKey:key];
    ((void(*)(id,SEL,id))originalRemoveAnimation)(layer,selector,key);
}
static CAAnimation *SubmittedAnimation(CALayer *layer,NSString *key) {
    return [objc_getAssociatedObject(layer,&SubmittedAnimationsKey) objectForKey:key];
}
static CAAnimation *LookupAnimation(CALayer *layer,SEL selector,NSString *key) {
    if ([key hasPrefix:@"cs.tabbar."]) return SubmittedAnimation(layer,key);
    return ((id(*)(id,SEL,id))originalLookupAnimation)(layer,selector,key);
}
static void RemoveAllAnimations(CALayer *layer,SEL selector) {
    NSUInteger removals=[objc_getAssociatedObject(layer,&AnimationRemovalCountKey) unsignedIntegerValue];
    objc_setAssociatedObject(layer,&AnimationRemovalCountKey,@(removals+1),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [objc_getAssociatedObject(layer,&SubmittedAnimationsKey) removeAllObjects];
    ((void(*)(id,SEL))originalRemoveAllAnimations)(layer,selector);
}
static NSUserDefaults *isolated;
static NSUserDefaults *TestDefaults(id self,SEL selector) { return isolated; }
@implementation MMTabbarItem @end
@interface MMTabBarItemView ()
@property(nonatomic,strong) UIView *customIconView;
@end
@implementation MMTabBarItemView
- (void)layoutIcon {} - (void)layoutBadgeView {} - (void)reloadIconImage {}
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
@property(nonatomic) NSInteger nativeClicks;
@property(nonatomic,strong) NSMutableArray<NSNumber *> *selectionRequests;
@property(nonatomic) BOOL nativeSelectionUnavailable;
- (void)nativeClick:(UIControl *)button;
- (void)handleUserSelectionAtIndex:(unsigned long long)index;
@end
@implementation MainTabBarViewController
- (BOOL)respondsToSelector:(SEL)selector { return selector==@selector(handleUserSelectionAtIndex:) && self.nativeSelectionUnavailable ? NO : [super respondsToSelector:selector]; }
- (id)getTabBarBtnForIndex:(unsigned long long)i { return i<self.buttons.count ? self.buttons[i] : nil; }
- (void)nativeClick:(UIControl *)button { self.nativeClicks++;self.selectedIndex=[self.buttons indexOfObjectIdenticalTo:button];CSTabBarSelectionDidChange(self); }
- (void)handleUserSelectionAtIndex:(unsigned long long)index {
    if (!self.selectionRequests) self.selectionRequests=[NSMutableArray array];
    [self.selectionRequests addObject:@(index)];self.selectedIndex=index;CSTabBarSelectionDidChange(self);
}
@end
@implementation WCTabBarView @end
@implementation WCTabBarItemView @end
@interface MMMainTabBarItemView ()
@property(nonatomic,strong) MMTabBarItemView *itemView;
@property(nonatomic,strong) MMTabbarItem *legacyItem;
@end
@implementation MMMainTabBarItemView @end
@interface WCTabBarController ()
@property(nonatomic,strong) WCTabBarView *tabBarView;
@end
@implementation WCTabBarController @end
@interface NewMainTabBarViewController : WCTabBarController
@property(nonatomic) NSUInteger selectedIndex,nativeClicks,doubleClicks;
@property(nonatomic,strong) UIViewController *selectedViewController;
@property(nonatomic,strong) NSMutableArray<NSNumber *> *selectionRequests;
- (void)handleUserSelectionAtIndex:(NSUInteger)index;
- (void)nativeClick:(UIControl *)button;
- (void)OnMainFrameDoubleClicked:(id)sender;
@end
@implementation NewMainTabBarViewController
- (void)handleUserSelectionAtIndex:(NSUInteger)index {
    if(!self.selectionRequests)self.selectionRequests=[NSMutableArray array];
    [self.selectionRequests addObject:@(index)];self.selectedIndex=index;CSTabBarSelectionDidChange((id)self);
}
- (void)nativeClick:(UIControl *)button {self.nativeClicks++;self.selectedIndex=[self.tabBarView.itemViews indexOfObjectIdenticalTo:button];CSTabBarSelectionDidChange((id)self);}
- (void)OnMainFrameDoubleClicked:(id)sender {self.doubleClicks++;}
@end
@interface CountingPageView : UIView
@property(nonatomic) NSUInteger treeReads;
@end
@implementation CountingPageView
- (NSMutableArray *)subviews { self.treeReads++; return [super subviews]; }
@end
static BOOL equal(CGFloat a,CGFloat b) { return fabs(a-b)<.001; }
static NSProcessInfoThermalState testThermalState=NSProcessInfoThermalStateNominal;
@interface NSProcessInfo (CSThermalTest)
- (NSProcessInfoThermalState)cs_testThermalState;
@end
@implementation NSProcessInfo (CSThermalTest)
- (NSProcessInfoThermalState)cs_testThermalState { return testThermalState; }
@end
#import "TabBarClickEffectTests.h"
#import "TabBarSelectedIconColorTests.h"
int main(int argc,const char *argv[]) { @autoreleasepool {
    NSString *suite=[@"com.wechatimprove.test.tabbar." stringByAppendingString:NSUUID.UUID.UUIDString];
    isolated=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Method m=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));
    IMP original=method_setImplementation(m,(IMP)TestDefaults);
    Method add=class_getInstanceMethod(CALayer.class,@selector(addAnimation:forKey:));
    Method remove=class_getInstanceMethod(CALayer.class,@selector(removeAnimationForKey:));
    originalAddAnimation=method_setImplementation(add,(IMP)RecordAnimation);
    originalRemoveAnimation=method_setImplementation(remove,(IMP)RecordRemoval);
    Method lookup=class_getInstanceMethod(CALayer.class,@selector(animationForKey:));
    Method removeAll=class_getInstanceMethod(CALayer.class,@selector(removeAllAnimations));
    originalLookupAnimation=method_setImplementation(lookup,(IMP)LookupAnimation);
    originalRemoveAllAnimations=method_setImplementation(removeAll,(IMP)RemoveAllAnimations);
    @try {
        CSTabBarInstallObservers();
        CSTabBarInstallObservers(); // Registration is idempotent.
        [CSTabBarPreferences reload];
        assert(!CSTabBarPreferences.current.enabled && equal(CSTabBarPreferences.current.contentHeight,52));
        assert(CSTabBarPreferences.current.backgroundColor==nil && CSTabBarPreferences.current.borderColor==nil);
        [isolated setDouble:0 forKey:kTabBarBgColorAlphaKey]; [isolated setDouble:0 forKey:kTabBarBgColorRedKey];
        [isolated setDouble:500 forKey:kTabBarHapticFeedbackKey]; [isolated setDouble:500 forKey:kTabBarBorderAnimationKey];
        [CSTabBarPreferences reload];
        assert(CSTabBarPreferences.current.backgroundColor && CSTabBarPreferences.current.backgroundColor.alpha==0);
        assert(CSTabBarPreferences.current.haptic<=4 && CSTabBarPreferences.current.animation==CSTabBarBorderAnimationClassicHeartbeat);
        [isolated setInteger:0 forKey:kTabBarHapticFeedbackKey];
        [isolated setBool:NO forKey:kTabBarSwipeSwitchKey];
        [isolated removeObjectForKey:kTabBarBgColorAlphaKey];
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey]; [isolated setBool:YES forKey:kTabBarHideTextKey];
        [isolated setObject:@"Renamed" forKey:kTabBarTextChatKey];
        NSString *imagePath=[NSString stringWithUTF8String:argv[1]];
        [@"image" writeToFile:imagePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [isolated setObject:imagePath forKey:kTabBarIconChatKey]; [CSTabBarPreferences reload];
        UIImage *loaded=[CSTabBarPreferences.current iconAtIndex:0 selected:NO];
        assert(loaded && loaded==[CSTabBarPreferences.current iconAtIndex:0 selected:YES]);
        assert(loaded==[CSTabBarPreferences.current iconAtIndex:0 selected:NO]);

        class_replaceMethod(NSProcessInfo.processInfo.class,@selector(thermalState),method_getImplementation(class_getInstanceMethod(NSProcessInfo.class,@selector(cs_testThermalState))),method_getTypeEncoding(class_getInstanceMethod(NSProcessInfo.class,@selector(cs_testThermalState))));
        UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];window.safeAreaInsets=(UIEdgeInsets){0,0,34,0};
        UIView *root=[[UIView alloc] initWithFrame:window.bounds];[window addSubview:root];
        MMTabBar *bar=[[MMTabBar alloc] initWithFrame:CGRectMake(0,761,390,83)];[root addSubview:bar];
        bar.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];bar.clipsToBounds=YES;
        UIColor *nativeColor=bar.backgroundColor;
        bar.backgroundView=[[UIView alloc] initWithFrame:bar.bounds];[bar addSubview:bar.backgroundView];
        MainTabBarViewController *controller=[MainTabBarViewController new];controller.view=root;controller.tabBar=bar;bar.customDelegate=controller;
        UIViewController *page=[UIViewController new]; page.view=[[CountingPageView alloc] initWithFrame:CGRectMake(0,0,390,761)];[root addSubview:page.view];controller.selectedViewController=page;
        UITableView *table=[[UITableView alloc] initWithFrame:page.view.bounds];[page.view addSubview:table];
        table.contentInset=(UIEdgeInsets){7,3,2,4};table.verticalScrollIndicatorInsets=(UIEdgeInsets){8,1,5,2};
        NSMutableArray *models=[NSMutableArray array],*items=[NSMutableArray array],*buttons=[NSMutableArray array];
        UIImage *nativeImage=[UIImage new];
        for(NSUInteger i=0;i<4;i++) {
            MMTabbarItem *model=[MMTabbarItem new];model.index=100+i;[models addObject:model];
            MMTabBarItemView *item=[[MMTabBarItemView alloc] initWithFrame:CGRectMake(i*97.5,0,97.5,49)];item.item=model;
            item.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(36,4,25,25)];item.imageView.image=nativeImage;[item addSubview:item.imageView];
            item.textLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,32,97.5,12)];item.textLabel.text=@"Native";[item addSubview:item.textLabel];
            item.badgeView=[[UIView alloc] initWithFrame:CGRectMake(57,1,16,16)];[item addSubview:item.badgeView];[bar addSubview:item];[items addObject:item];
            UIControl *button=[[UIControl alloc] initWithFrame:item.frame];[button addTarget:controller action:@selector(nativeClick:) forControlEvents:UIControlEventTouchUpInside];[bar addSubview:button];[buttons addObject:button];
        }
        bar.items=models;bar.tabBarItemViews=items;controller.buttons=buttons;
        MMTabBarItemView *first=items[0];UIView *badge=first.badgeView;
        CGRect originalItem=first.frame, originalButton=[buttons[0] frame], originalImage=first.imageView.frame, originalBar=bar.frame;
        CSTabBarUpdate(bar);
        assert(CGRectEqualToRect(bar.frame,originalBar) && bar.backgroundView.hidden);
        assert(first.textLabel.hidden && first.imageView.image==loaded && first.item.index==100);
        assert(first.badgeView==badge && !badge.hidden);
        assert(CGRectEqualToRect(first.frame,[buttons[0] frame]));
        assert(equal(first.frame.origin.y,31) && first.frame.size.height==52);
        assert(equal(table.contentInset.bottom,2) && equal(table.contentInset.top,7));
        CGRect floating=first.frame, badgeFrame=badge.frame;
        NSUInteger buttonActionCount=[buttons[0] actions].count;
        for(int i=0;i<100;i++) CSTabBarUpdate(bar);
        assert(CGRectEqualToRect(first.frame,floating) && CGRectEqualToRect(badge.frame,badgeFrame));
        assert(equal(table.contentInset.bottom,2));
        assert(buttonActionCount>=1 && [buttons[0] actions].count==buttonActionCount);
        BOOL handled=NO;
        CGPoint center=CGPointMake(CGRectGetMidX(first.frame),CGRectGetMidY(first.frame));
        assert(CSTabBarHitTest(bar,center,nil,&handled)==buttons[0] && handled);
        assert(!CSTabBarContainsPoint(bar,CGPointMake(0,80),&handled) && handled);
        [(UIControl *)buttons[1] sendActionsForControlEvents:UIControlEventTouchDown];
        [(UIControl *)buttons[1] sendActionsForControlEvents:UIControlEventTouchUpInside];
        assert(controller.nativeClicks==1 && controller.selectedIndex==1);
        // Host relayout must receive native geometry, then restore the same floating geometry.
        CSTabBarBeginLayout(bar);
        assert(CGRectEqualToRect(first.frame,originalItem) && CGRectEqualToRect([buttons[0] frame],originalButton));
        CSTabBarEndLayout(bar);
        assert(CGRectEqualToRect(first.frame,floating));
        // One controller layout can synchronously update geometry several times.
        // Discover the largest visible table only after its final native boundary.
        CountingPageView *pageTree=(id)page.view;
        NSUInteger reads=pageTree.treeReads;
        CSTabBarBeginControllerLayout(controller);
        for (NSUInteger pass=0;pass<3;pass++) {
            CSTabBarBeginLayout(bar);CSTabBarEndLayout(bar);
            assert(CGRectEqualToRect(first.frame,floating));
        }
        assert(pageTree.treeReads==reads);
        UIView *scopeRaw=[[UIView alloc] initWithFrame:bar.frame];
        for (MMTabBarItemView *item in items) {
            UIImageView *image=[[UIImageView alloc] initWithFrame:item.frame];image.image=[UIImage new];[scopeRaw addSubview:image];
        }
        UIView *scopeSnapshot=CSTabBarStyleSnapshot(bar,scopeRaw);
        assert(scopeSnapshot!=scopeRaw && scopeSnapshot.subviews.count==5);
        assert(CGRectEqualToRect(scopeSnapshot.subviews[1].frame,first.frame));
        UITableView *larger=[[UITableView alloc] initWithFrame:CGRectMake(0,0,390,850)];[page.view addSubview:larger];
        reads=pageTree.treeReads;CSTabBarUpdate(bar);CSTabBarEndControllerLayout(controller);
        assert(pageTree.treeReads==reads+1 && larger.contentInset.bottom>0 && equal(table.contentInset.bottom,2));
        reads=pageTree.treeReads;CSTabBarEndControllerLayout(controller);assert(pageTree.treeReads==reads);
        // No discovery cache survives into the next generation or a visibility change.
        larger.hidden=YES;CSTabBarBeginControllerLayout(controller);CSTabBarUpdate(bar);CSTabBarEndControllerLayout(controller);
        assert(pageTree.treeReads==reads+1 && equal(larger.contentInset.bottom,0));
        larger.hidden=NO;[larger removeFromSuperview];
        // A missing did-layout callback is bounded to the current main-queue turn.
        CSTabBarBeginControllerLayout(controller);CSTabBarUpdate(bar);reads=pageTree.treeReads;
        for (NSUInteger turn=0;turn<3;turn++) CFRunLoopRunInMode(kCFRunLoopDefaultMode,.005,false);
        assert(pageTree.treeReads==reads+1);
        CSTabBarUpdate(bar);assert(pageTree.treeReads==reads+2);
        // Hidden or detached bars release inset ownership immediately inside a scope.
        CSTabBarBeginControllerLayout(controller);CSTabBarUpdate(bar);bar.hidden=YES;CSTabBarUpdate(bar);
        reads=pageTree.treeReads;CSTabBarEndControllerLayout(controller);assert(pageTree.treeReads==reads);
        bar.hidden=NO;CSTabBarUpdate(bar);
        // A native badge update may change width before calling layoutBadgeView.
        CGRect newBadge=badge.frame;newBadge.size.width=30;badge.frame=newBadge;
        CSTabBarBeginItemUpdate(first);CSTabBarEndItemUpdate(first);
        assert(equal(badge.frame.size.width,30) && first.badgeView==badge);
        // A host change to bottom inset is retained when ownership is released.
        UIEdgeInsets external=table.contentInset;external.bottom=41;table.contentInset=external;
        bar.hidden=YES;CSTabBarUpdate(bar);
        assert(equal(table.contentInset.bottom,41) && equal(table.verticalScrollIndicatorInsets.bottom,5));
        assert(CGRectEqualToRect(first.frame,floating) && first.textLabel.hidden && first.imageView.image==loaded);
        assert(bar.hidden && !bar.clipsToBounds && bar.backgroundView.hidden);
        assert([buttons[0] actions].count==buttonActionCount);
        assert(!CSTabBarContainsPoint(bar,center,&handled) && handled);
        // Native navigation snapshots must include the capsule even while the real bar is hidden.
        UIView *raw=[[UIView alloc] initWithFrame:bar.frame];
        UIView *blur=[[UIView alloc] initWithFrame:bar.bounds];[raw addSubview:blur];
        NSMutableArray *nativeImages=[NSMutableArray array];
        for (MMTabBarItemView *item in items) {
            UIImageView *image=[[UIImageView alloc] initWithFrame:item.frame];image.image=[UIImage new];
            [nativeImages addObject:image];[raw addSubview:image];
        }
        UIView *hairline=[[UIView alloc] initWithFrame:CGRectMake(0,0,390,.5)];[raw addSubview:hairline];
        UIView *snapshot=CSTabBarStyleSnapshot(bar,raw);
        assert(snapshot!=raw && CGRectEqualToRect(snapshot.frame,raw.frame));
        assert(snapshot.subviews.count==5 && !snapshot.userInteractionEnabled && !snapshot.clipsToBounds);
        assert(CGRectEqualToRect(snapshot.subviews[0].frame,CGRectMake(19.5,31,351,52)));
        assert(blur.superview==raw && hairline.superview==raw);
        for (NSUInteger i=0;i<4;i++) {
            assert(snapshot.subviews[i+1]==nativeImages[i]);
            assert([items[i] superview]==bar && [buttons[i] superview]==bar);
        }
        assert(first.badgeView==badge && bar.hidden && bar.backgroundView.hidden);
        UIView *unknown=[UIView new];assert(CSTabBarStyleSnapshot(bar,unknown)==unknown);
        // Alpha-based fades, detachment and cancelled returns retain the same styled geometry.
        bar.hidden=NO;bar.alpha=0;CSTabBarUpdate(bar);
        assert(bar.backgroundView.hidden && first.textLabel.hidden && bar.alpha==0);
        assert(!CSTabBarContainsPoint(bar,center,&handled));
        [bar removeFromSuperview];CSTabBarUpdate(bar);
        assert(bar.backgroundView.hidden && CGRectEqualToRect(first.frame,floating));
        [root addSubview:bar];bar.alpha=1;CSTabBarUpdate(bar);
        assert(bar.backgroundView.hidden && CGRectEqualToRect(first.frame,floating));
        bar.hidden=YES;CSTabBarUpdate(bar);
        [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        assert(CGRectEqualToRect(first.frame,originalItem) && CGRectEqualToRect(first.imageView.frame,originalImage));
        assert(!first.textLabel.hidden && [first.textLabel.text isEqual:@"Native"] && first.imageView.image==nativeImage);
        assert(bar.hidden && bar.clipsToBounds && !bar.backgroundView.hidden && bar.backgroundColor==nativeColor);
        assert([buttons[0] actions].count==1);
        assert(CSTabBarStyleSnapshot(bar,raw)==raw);
        bar.hidden=NO;CSTabBarUpdate(bar);
        [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        assert(!bar.hidden && !first.textLabel.hidden && first.imageView.image==nativeImage);
        assert(CGRectEqualToRect(first.frame,originalItem) && equal(table.contentInset.bottom,41));
        assert(!CSTabBarContainsPoint(bar,center,&handled) && !handled);
        // Removing only the custom image/hidden-text option restores native presentation while enabled.
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey];
        [isolated setBool:NO forKey:kTabBarHideTextKey];
        [isolated removeObjectForKey:kTabBarIconChatKey];[isolated removeObjectForKey:kTabBarTextChatKey];
        [CSTabBarPreferences reload];CSTabBarUpdate(bar);
        assert(first.imageView.image==nativeImage && !first.textLabel.hidden && [first.textLabel.text isEqual:@"Native"]);
        TestSelectedIconColor(bar,items,imagePath);
        TestClickEffects(controller,bar,items,buttons,suite,imagePath);
        TestModernTouchHierarchy(suite);
        // Border pulses must never tint a transparent bar interior or animate its background.
        [isolated setDouble:0 forKey:kTabBarBgColorAlphaKey];
        [isolated setDouble:1 forKey:kTabBarBorderColorAlphaKey];
        [isolated setDouble:1 forKey:kTabBarBorderColorGreenKey];
        for (NSNumber *mode in @[@1,@2]) {
            [isolated setInteger:mode.integerValue forKey:kTabBarBorderAnimationKey];
            [CSTabBarPreferences reload];CSTabBarUpdate(bar);
            UIView *surface=bar.subviews[0];
            assert(surface.backgroundColor.alpha==0 && surface.layer.shadowOpacity==0 && !surface.layer.shadowPath);
            assert(surface.layer.animationKeys.count==0 && !SubmittedAnimation(surface.layer,@"cs.tabbar.pulse"));
            CALayer *glow=nil;
            for (CALayer *layer in surface.layer.sublayers) if (layer.mask) glow=layer;
            assert(glow && !glow.hidden);
            CAShapeLayer *mask=(CAShapeLayer *)glow.mask;
            assert([mask.fillRule isEqual:kCAFillRuleEvenOdd]);
            CGPoint inside=CGPointMake(CGRectGetMidX(glow.bounds),CGRectGetMidY(glow.bounds));
            CGPoint outside=CGPointMake(CGRectGetMidX(glow.bounds),5);
            assert(!CGPathContainsPoint(mask.path,NULL,inside,YES));
            assert(CGPathContainsPoint(mask.path,NULL,outside,YES));
            CAShapeLayer *ring=(CAShapeLayer *)glow.sublayers[0];
            assert(CGColorGetAlpha(ring.fillColor)==0 && !ring.shadowPath && ring.opacity==0);
            CAAnimationGroup *pulse=(CAAnimationGroup *)SubmittedAnimation(ring,@"cs.tabbar.outwardPulse");
            assert(pulse && equal(pulse.duration,mode.integerValue==1 ? 3 : 1.2));
            CAKeyframeAnimation *path=pulse.animations[0], *fade=pulse.animations[1];
            CGRect from=CGPathGetBoundingBox((__bridge CGPathRef)path.values.firstObject);
            CGRect to=CGPathGetBoundingBox((__bridge CGPathRef)path.values.lastObject);
            assert(equal(to.size.width-from.size.width,20) && equal(to.size.height-from.size.height,20));
            assert([fade.values.firstObject doubleValue]==0 && [fade.values.lastObject doubleValue]==0);
        }
        // Classic modes keep their original whole-surface shadow and never run the outward ring.
        for (NSNumber *mode in @[@3,@4,@1,@3,@0]) {
            [isolated setInteger:mode.integerValue forKey:kTabBarBorderAnimationKey];
            [CSTabBarPreferences reload];assert(CSTabBarPreferences.current.animation==mode.integerValue);
            CSTabBarUpdate(bar);
            UIView *surface=bar.subviews[0];
            CALayer *glow=nil;
            for (CALayer *layer in surface.layer.sublayers) if (layer.mask) glow=layer;
            CAKeyframeAnimation *classic=(id)SubmittedAnimation(surface.layer,@"cs.tabbar.pulse");
            CAAnimation *outward=SubmittedAnimation(glow.sublayers[0],@"cs.tabbar.outwardPulse");
            if (mode.integerValue>=3) {
                assert(classic && [classic.keyPath isEqual:@"shadowOpacity"] && glow.hidden && !outward);
                assert(equal(classic.duration,mode.integerValue==3 ? 3 : 1.2));
                NSArray *expected=mode.integerValue==3 ? @[@.15,@.8,@.15] : @[@.15,@.8,@.2,@.55,@.15];
                assert([classic.values isEqual:expected] && equal(surface.layer.shadowRadius,6));
                CGPoint center=CGPointMake(CGRectGetMidX(surface.bounds),CGRectGetMidY(surface.bounds));
                assert(CGPathContainsPoint(surface.layer.shadowPath,NULL,center,NO));
            } else {
                assert(!classic && !surface.layer.shadowPath && surface.layer.shadowOpacity==0);
                assert(mode.integerValue==1 ? (!glow.hidden && outward!=nil) : (glow.hidden && outward==nil));
            }
        }
        [isolated setInteger:0 forKey:kTabBarBorderAnimationKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        for (CALayer *layer in [bar.subviews[0] layer].sublayers) if (layer.mask) {
            assert(layer.hidden && !SubmittedAnimation(layer.sublayers[0],@"cs.tabbar.outwardPulse"));
        }
        // Simulate iOS discarding animations while the app is away, without changing
        // preferences or bounds. Activation must recover all four modes without a layout.
        for (NSNumber *mode in @[@1,@2,@3,@4]) {
            [isolated setInteger:mode.integerValue forKey:kTabBarBorderAnimationKey];
            [CSTabBarPreferences reload];CSTabBarUpdate(bar);
            UIView *surface=bar.subviews[0];
            CALayer *ring=nil;
            for (CALayer *layer in surface.layer.sublayers) if (layer.mask) ring=layer.sublayers[0];
            CALayer *animated=mode.integerValue>=3 ? surface.layer : ring;
            NSString *key=mode.integerValue>=3 ? @"cs.tabbar.pulse" : @"cs.tabbar.outwardPulse";
            assert(SubmittedAnimation(animated,key));
            CGRect itemBefore=first.frame; UIView *badgeBefore=first.badgeView;
            for (NSString *notification in @[UIApplicationDidBecomeActiveNotification,UISceneDidActivateNotification]) {
                [animated removeAllAnimations]; assert(!SubmittedAnimation(animated,key));
                [NSNotificationCenter.defaultCenter postNotificationName:notification object:nil];
                CAAnimation *resumed=SubmittedAnimation(animated,key);assert(resumed);
                NSUInteger submissions=submittedAnimationCount;
                [NSNotificationCenter.defaultCenter postNotificationName:notification object:nil];
                for (int n=0;n<20;n++) CSTabBarUpdate(bar);
                assert(SubmittedAnimation(animated,key)==resumed && submittedAnimationCount==submissions);
                assert(CGRectEqualToRect(first.frame,itemBefore) && first.badgeView==badgeBefore);
            }
            // Inactive, hot, hidden-parent and detached scenes stop existing animations,
            // then recover once without changing native geometry or preference values.
            [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillResignActiveNotification object:nil];
            assert(!SubmittedAnimation(animated,key));
            CSTabBarUpdate(bar); assert(!SubmittedAnimation(animated,key));
            [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
            assert(SubmittedAnimation(animated,key));
            testThermalState=NSProcessInfoThermalStateSerious;
            [NSNotificationCenter.defaultCenter postNotificationName:NSProcessInfoThermalStateDidChangeNotification object:nil];
            assert(!SubmittedAnimation(animated,key));
            testThermalState=NSProcessInfoThermalStateNominal;
            [NSNotificationCenter.defaultCenter postNotificationName:NSProcessInfoThermalStateDidChangeNotification object:nil];
            assert(SubmittedAnimation(animated,key));
            root.hidden=YES; CSTabBarUpdate(bar); assert(!SubmittedAnimation(animated,key));
            root.hidden=NO; CSTabBarUpdate(bar); assert(SubmittedAnimation(animated,key));
            window.windowScene=[UIWindowScene new]; window.windowScene.activationState=UISceneActivationStateForegroundActive; // Will-deactivate can precede the state change.
            [NSNotificationCenter.defaultCenter postNotificationName:UISceneWillDeactivateNotification object:window.windowScene];
            assert(!SubmittedAnimation(animated,key));
            window.windowScene.activationState=UISceneActivationStateForegroundActive;
            [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidActivateNotification object:window.windowScene];
            assert(SubmittedAnimation(animated,key));
            // Ordinary cached layout is a fallback if removal happens after activation.
            [animated removeAllAnimations];CSTabBarUpdate(bar);assert(SubmittedAnimation(animated,key));
            // A return into a chat must not unhide/rebuild the root bar; showing it later repairs it.
            bar.hidden=YES;[animated removeAllAnimations];
            [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
            assert(bar.hidden && !SubmittedAnimation(animated,key));
            bar.hidden=NO;CSTabBarUpdate(bar);assert(SubmittedAnimation(animated,key));
            CSTestReduceMotionEnabled=YES;
            [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
            assert(!SubmittedAnimation(animated,key));
            CSTestReduceMotionEnabled=NO;
            [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidActivateNotification object:nil];
            assert(SubmittedAnimation(animated,key));
            [isolated setDouble:0 forKey:kTabBarBorderWidthKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
            [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
            assert(!SubmittedAnimation(animated,key));
            [isolated removeObjectForKey:kTabBarBorderWidthKey];
        }
        [isolated setInteger:0 forKey:kTabBarBorderAnimationKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        NSUInteger noAnimationCount=submittedAnimationCount;
        [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
        assert(submittedAnimationCount==noAnimationCount);
        [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        [NSNotificationCenter.defaultCenter postNotificationName:UISceneDidActivateNotification object:nil];
        assert(!bar.backgroundView.hidden && submittedAnimationCount==noAnimationCount);
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        // Moving the entire native bar outside a clipping parent during a transition must not flash native UI.
        root.clipsToBounds=YES;bar.frame=CGRectMake(0,850,390,83);CSTabBarUpdate(bar);
        assert(bar.backgroundView.hidden && first.textLabel.hidden==NO);
        bar.frame=originalBar;root.clipsToBounds=NO;CSTabBarUpdate(bar);
        // A stationary clipping ancestor still rejects an unreachable raised capsule.
        [isolated setDouble:80 forKey:kTabBarPositionOffsetKey];[CSTabBarPreferences reload];
        root.clipsToBounds=YES;root.bounds=CGRectMake(0,761,390,83);
        CSTabBarUpdate(bar);
        assert(!bar.backgroundView.hidden && CGRectEqualToRect(first.frame,originalItem));
        root.bounds=CGRectMake(0,0,390,844);root.clipsToBounds=NO;
        // Unsupported native composition leaves the native controls untouched.
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];controller.buttons=@[];
        CSTabBarUpdate(bar);assert(!bar.backgroundView.hidden && CGRectEqualToRect(first.frame,originalItem));
        NSLog(@"tabbar preferences/native lifecycle: PASS");
    } @finally {
        [isolated removePersistentDomainForName:suite];method_setImplementation(m,original);
        method_setImplementation(add,originalAddAnimation);method_setImplementation(remove,originalRemoveAnimation);
        method_setImplementation(lookup,originalLookupAnimation);method_setImplementation(removeAll,originalRemoveAllAnimations);
    }
}return 0;}
