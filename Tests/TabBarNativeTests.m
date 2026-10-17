#import "CSTabBarNativeAdapter.h"
#import "CSTabBarPreferences.h"
#import <objc/runtime.h>
#import <assert.h>

static NSUserDefaults *isolated;
static NSUserDefaults *TestDefaults(id self,SEL selector) { return isolated; }
@implementation MMTabbarItem @end
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
- (void)nativeClick:(UIControl *)button;
@end
@implementation MainTabBarViewController
- (id)getTabBarBtnForIndex:(unsigned long long)i { return i<self.buttons.count ? self.buttons[i] : nil; }
- (void)nativeClick:(UIControl *)button { self.nativeClicks++;self.selectedIndex=[self.buttons indexOfObjectIdenticalTo:button]; }
@end
static BOOL equal(CGFloat a,CGFloat b) { return fabs(a-b)<.001; }
int main(int argc,const char *argv[]) { @autoreleasepool {
    NSString *suite=[@"com.wechatimprove.test.tabbar." stringByAppendingString:NSUUID.UUID.UUIDString];
    isolated=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Method m=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));
    IMP original=method_setImplementation(m,(IMP)TestDefaults);
    @try {
        [CSTabBarPreferences reload];
        assert(!CSTabBarPreferences.current.enabled && equal(CSTabBarPreferences.current.contentHeight,52));
        assert(CSTabBarPreferences.current.backgroundColor==nil && CSTabBarPreferences.current.borderColor==nil);
        [isolated setDouble:0 forKey:kTabBarBgColorAlphaKey]; [isolated setDouble:0 forKey:kTabBarBgColorRedKey];
        [isolated setDouble:500 forKey:kTabBarHapticFeedbackKey]; [isolated setDouble:500 forKey:kTabBarBorderAnimationKey];
        [CSTabBarPreferences reload];
        assert(CSTabBarPreferences.current.backgroundColor && CSTabBarPreferences.current.backgroundColor.alpha==0);
        assert(CSTabBarPreferences.current.haptic<=4 && CSTabBarPreferences.current.animation<=2);
        [isolated removeObjectForKey:kTabBarBgColorAlphaKey];
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey]; [isolated setBool:YES forKey:kTabBarHideTextKey];
        [isolated setObject:@"Renamed" forKey:kTabBarTextChatKey];
        NSString *imagePath=[NSString stringWithUTF8String:argv[1]];
        [@"image" writeToFile:imagePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [isolated setObject:imagePath forKey:kTabBarIconChatKey]; [CSTabBarPreferences reload];
        UIImage *loaded=[CSTabBarPreferences.current iconAtIndex:0 selected:NO];
        assert(loaded && loaded==[CSTabBarPreferences.current iconAtIndex:0 selected:YES]);
        assert(loaded==[CSTabBarPreferences.current iconAtIndex:0 selected:NO]);

        UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];window.safeAreaInsets=(UIEdgeInsets){0,0,34,0};
        UIView *root=[[UIView alloc] initWithFrame:window.bounds];[window addSubview:root];
        MMTabBar *bar=[[MMTabBar alloc] initWithFrame:CGRectMake(0,761,390,83)];[root addSubview:bar];
        bar.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];bar.clipsToBounds=YES;
        UIColor *nativeColor=bar.backgroundColor;
        bar.backgroundView=[[UIView alloc] initWithFrame:bar.bounds];[bar addSubview:bar.backgroundView];
        MainTabBarViewController *controller=[MainTabBarViewController new];controller.view=root;controller.tabBar=bar;bar.customDelegate=controller;
        UIViewController *page=[UIViewController new]; page.view=[[UIView alloc] initWithFrame:CGRectMake(0,0,390,761)];[root addSubview:page.view];controller.selectedViewController=page;
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
        for(int i=0;i<100;i++) CSTabBarUpdate(bar);
        assert(CGRectEqualToRect(first.frame,floating) && CGRectEqualToRect(badge.frame,badgeFrame));
        assert(equal(table.contentInset.bottom,2));
        assert([buttons[0] actions].count==3); // native target plus the two feedback observers
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
        // A native badge update may change width before calling layoutBadgeView.
        CGRect newBadge=badge.frame;newBadge.size.width=30;badge.frame=newBadge;
        CSTabBarBeginItemUpdate(first);CSTabBarEndItemUpdate(first);
        assert(equal(badge.frame.size.width,30) && first.badgeView==badge);
        // A host change to bottom inset is retained when ownership is released.
        UIEdgeInsets external=table.contentInset;external.bottom=41;table.contentInset=external;
        bar.hidden=YES;CSTabBarVisibilityChanged(bar);
        assert(equal(table.contentInset.bottom,41) && equal(table.verticalScrollIndicatorInsets.bottom,5));
        assert(CGRectEqualToRect(first.frame,floating) && first.textLabel.hidden && first.imageView.image==loaded);
        assert(bar.hidden && !bar.clipsToBounds && bar.backgroundView.hidden);
        assert([buttons[0] actions].count==3);
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
        bar.hidden=NO;bar.alpha=0;CSTabBarVisibilityChanged(bar);
        assert(bar.backgroundView.hidden && first.textLabel.hidden && bar.alpha==0);
        assert(!CSTabBarContainsPoint(bar,center,&handled));
        [bar removeFromSuperview];CSTabBarVisibilityChanged(bar);
        assert(bar.backgroundView.hidden && CGRectEqualToRect(first.frame,floating));
        [root addSubview:bar];bar.alpha=1;CSTabBarVisibilityChanged(bar);
        assert(bar.backgroundView.hidden && CGRectEqualToRect(first.frame,floating));
        bar.hidden=YES;CSTabBarVisibilityChanged(bar);
        [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        assert(CGRectEqualToRect(first.frame,originalItem) && CGRectEqualToRect(first.imageView.frame,originalImage));
        assert(!first.textLabel.hidden && [first.textLabel.text isEqual:@"Native"] && first.imageView.image==nativeImage);
        assert(bar.hidden && bar.clipsToBounds && !bar.backgroundView.hidden && bar.backgroundColor==nativeColor);
        assert([buttons[0] actions].count==1);
        assert(CSTabBarStyleSnapshot(bar,raw)==raw);
        bar.hidden=NO;CSTabBarVisibilityChanged(bar);
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
    }
}return 0;}
