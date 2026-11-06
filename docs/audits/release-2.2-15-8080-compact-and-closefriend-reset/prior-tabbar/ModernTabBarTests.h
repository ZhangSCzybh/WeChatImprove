// Behavioral fixture for the class/selector hierarchy extracted from 8.0.80.
// UIKit and rendering remain host doubles; the production adapter is unmodified.
@interface WCTabBarController ()
@property(nonatomic, readwrite, strong) WCTabBarView *tabBarView;
@end
@implementation WCTabBarController
- (BOOL)isKindOfClass:(Class)cls { return cls==UITabBarController.class || [super isKindOfClass:cls]; }
@end
@implementation WCTabBarView
- (BOOL)isKindOfClass:(Class)cls { return cls==UITabBar.class || [super isKindOfClass:cls]; }
@end
@implementation WCTabBarItemView @end
@interface MMMainTabBarItemView ()
@property(nonatomic, readwrite, strong) MMTabBarItemView *itemView;
@property(nonatomic, readwrite, strong) MMTabbarItem *legacyItem;
@end
@implementation MMMainTabBarItemView @end
@interface NewMainTabBarViewController : WCTabBarController
@property(nonatomic) NSUInteger selectedIndex, nativeClicks;
@property(nonatomic, strong) UIViewController *selectedViewController;
- (void)nativeClick:(MMMainTabBarItemView *)button;
@end
@implementation NewMainTabBarViewController
- (BOOL)isKindOfClass:(Class)cls { return cls==MainTabBarViewController.class || [super isKindOfClass:cls]; }
// 8.0.80 advertises compatibility selectors through forwarding. A style adapter
// must not select the old renderer merely because respondsToSelector: says yes.
- (BOOL)respondsToSelector:(SEL)sel {
    if (sel==@selector(getTabBarBtnForIndex:)) return YES;
    return [super respondsToSelector:sel];
}
- (void)nativeClick:(MMMainTabBarItemView *)button {
    self.nativeClicks++;
    self.selectedIndex=[self.tabBarView.itemViews indexOfObjectIdenticalTo:button];
    for (MMMainTabBarItemView *wrapper in self.tabBarView.itemViews) wrapper.itemView.isSelected=wrapper==button;
}
@end

static WCTabBarView *ModernFixture(NewMainTabBarViewController *owner, CGRect frame) {
    WCTabBarView *bar=[[WCTabBarView alloc] initWithFrame:frame];
    bar.visibilityDelegate=owner;
    bar.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    bar.clipsToBounds=YES;
    bar.backgroundContentView=[[UIView alloc] initWithFrame:bar.bounds];[bar addSubview:bar.backgroundContentView];
    bar.separatorView=[[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,.5)];[bar addSubview:bar.separatorView];
    NSMutableArray *models=[NSMutableArray array], *wrappers=[NSMutableArray array];
    for (NSUInteger i=0;i<4;i++) {
        // The WCTabBarView compatibility models are distinct from legacy items.
        [models addObject:[UITabBarItem new]];
        MMTabbarItem *legacy=[MMTabbarItem new];legacy.index=100+i;
        MMMainTabBarItemView *wrapper=[[MMMainTabBarItemView alloc] initWithFrame:CGRectMake(i*97.5,0,97.5,49)];
        wrapper.legacyItem=legacy;
        MMTabBarItemView *item=[[MMTabBarItemView alloc] initWithFrame:wrapper.bounds];item.item=legacy;wrapper.itemView=item;
        item.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(36,4,25,25)];item.imageView.image=[UIImage new];[item addSubview:item.imageView];
        item.textLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,32,97.5,12)];item.textLabel.text=@"Modern native";[item addSubview:item.textLabel];
        item.badgeView=[[UIView alloc] initWithFrame:CGRectMake(57,1,16,16)];[item addSubview:item.badgeView];
        [wrapper addSubview:item];[bar addSubview:wrapper];[wrappers addObject:wrapper];
        if (owner) [wrapper addTarget:owner action:@selector(nativeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    bar.items=models;bar.itemViews=wrappers;
    return bar;
}

static void TestModernTabBar(NSString *suite, UIWindow *window, UIView *root, UIImage *loaded) {
    [isolated removePersistentDomainForName:suite];
    [isolated setBool:YES forKey:kTabBarStyleEnabledKey];
    [isolated setBool:YES forKey:kTabBarHideTextKey];
    [isolated setObject:loaded.path forKey:kTabBarIconChatKey];
    [isolated setObject:@"Modern renamed" forKey:kTabBarTextChatKey];
    [isolated setInteger:1 forKey:kTabBarClickEffectKey];
    [isolated setInteger:1 forKey:kTabBarHapticFeedbackKey];
    [CSTabBarPreferences reload];
    NewMainTabBarViewController *controller=[NewMainTabBarViewController new];controller.view=root;
    WCTabBarView *bar=ModernFixture(controller,CGRectMake(0,761,390,83));controller.tabBarView=bar;[root addSubview:bar];
    UIViewController *page=[UIViewController new];page.view=[[CountingPageView alloc] initWithFrame:CGRectMake(0,0,390,761)];[root addSubview:page.view];controller.selectedViewController=page;
    UITableView *table=[[UITableView alloc] initWithFrame:page.view.bounds];table.contentInset=(UIEdgeInsets){0,0,2,0};[page.view addSubview:table];
    MMMainTabBarItemView *first=bar.itemViews[0];MMTabBarItemView *item=first.itemView;
    CGRect originalControl=first.frame,originalItem=item.frame,originalIcon=item.imageView.frame,originalBadge=item.badgeView.frame;
    UIColor *originalColor=bar.backgroundColor;UIImage *originalImage=item.imageView.image;
    UIView *badge=item.badgeView;
    assert(CSTabBarForController((id)controller)==(id)bar);
    CSTabBarUpdate((id)bar);
    assert(bar.backgroundContentView.hidden && bar.separatorView.hidden && !bar.clipsToBounds);
    assert(CGRectEqualToRect(first.frame,CGRectMake(19.5,31,87.75,52)));
    assert(CGRectEqualToRect(item.frame,first.bounds)); // Nested renderer has no double shift.
    assert(item.textLabel.hidden && [item.textLabel.text isEqual:@"Modern renamed"] && item.imageView.image.path);
    assert(item.badgeView==badge && item.item==first.legacyItem);
    assert(first.actions.count==3);
    CGRect floated=first.frame, floatedBadge=badge.frame;
    for (int i=0;i<30;i++) CSTabBarUpdate((id)bar);
    assert(CGRectEqualToRect(first.frame,floated) && CGRectEqualToRect(item.frame,first.bounds) && CGRectEqualToRect(badge.frame,floatedBadge));
    // Simulate a real native layout and item update between before/after hooks.
    CSTabBarBeginControllerLayout((id)controller);CSTabBarBeginLayout((id)bar);
    assert(CGRectEqualToRect(first.frame,originalControl) && CGRectEqualToRect(item.frame,originalItem));
    CSTabBarEndLayout((id)bar);CSTabBarEndControllerLayout((id)controller);
    assert(CGRectEqualToRect(first.frame,floated) && CGRectEqualToRect(item.frame,first.bounds));
    BOOL handled=NO;
    CGPoint center=CGPointMake(CGRectGetMidX(floated),CGRectGetMidY(floated));
    assert(CSTabBarContainsPoint((id)bar,center,&handled) && handled);
    assert(CSTabBarHitTest((id)bar,center,nil,&handled)==first && handled);
    assert(!CSTabBarContainsPoint((id)bar,CGPointMake(1,1),&handled) && handled);
    MMMainTabBarItemView *second=bar.itemViews[1];
    NSUInteger haptics=CSTestHapticCount;
    [second sendActionsForControlEvents:UIControlEventTouchDown];[second sendActionsForControlEvents:UIControlEventTouchUpInside];
    NSDate *until=[NSDate dateWithTimeIntervalSinceNow:.02];
    while ([until timeIntervalSinceNow]>0) [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:until];
    assert(controller.nativeClicks==1 && controller.selectedIndex==1 && CSTestHapticCount==haptics+1);
    assert(SubmittedAnimation(second.itemView.imageView.layer,@"cs.tabbar.clickBounce"));
    assert(second.itemView.isSelected && !item.isSelected && second.itemView.badgeView);
    // A native transition copy gets its own geometry and never owns page insets,
    // even if UIKit attaches it in the same window as the original bar.
    WCTabBarView *copy=ModernFixture(nil,bar.frame);
    UIView *snapshot=CSTabBarStyleSnapshot((id)bar,copy);assert(snapshot==copy);
    [root addSubview:copy];
    MMMainTabBarItemView *copyFirst=copy.itemViews[0];
    assert(copy.backgroundContentView.hidden && copy.separatorView.hidden && CGRectEqualToRect(copyFirst.frame,floated));
    NSUInteger reads=((CountingPageView *)page.view).treeReads;
    for (int i=0;i<10;i++) CSTabBarUpdate((id)copy);
    assert(((CountingPageView *)page.view).treeReads==reads);
    assert(copyFirst.itemView.textLabel.hidden && CGRectEqualToRect(copyFirst.itemView.frame,copyFirst.bounds));
    // The copy's native relayout must be reversible independently of the live bar.
    CSTabBarBeginLayout((id)copy);CSTabBarEndLayout((id)copy);
    assert(CGRectEqualToRect(copyFirst.frame,floated) && CGRectEqualToRect(first.frame,floated));
    bar.hidden=YES;CSTabBarUpdate((id)bar);
    assert(!CSTabBarContainsPoint((id)bar,center,&handled) && handled && equal(table.contentInset.bottom,2));
    bar.hidden=NO;CSTabBarUpdate((id)bar);
    // Unsupported wrapper content stops styling without retaining partial geometry.
    MMTabbarItem *legacy=first.legacyItem;first.legacyItem=[MMTabbarItem new];CSTabBarUpdate((id)bar);
    assert(!bar.backgroundContentView.hidden && !bar.separatorView.hidden && CGRectEqualToRect(first.frame,originalControl));
    first.legacyItem=legacy;CSTabBarUpdate((id)bar);assert(bar.backgroundContentView.hidden);
    [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];
    CSTabBarUpdate((id)bar);CSTabBarUpdate((id)copy);
    assert(!bar.backgroundContentView.hidden && !bar.separatorView.hidden && bar.backgroundColor==originalColor && bar.clipsToBounds);
    assert(CGRectEqualToRect(first.frame,originalControl) && CGRectEqualToRect(item.frame,originalItem));
    assert(CGRectEqualToRect(item.imageView.frame,originalIcon) && CGRectEqualToRect(badge.frame,originalBadge));
    assert(item.imageView.image==originalImage && !item.textLabel.hidden && [item.textLabel.text isEqual:@"Modern native"]);
    assert(first.actions.count==1 && copyFirst.actions.count==0);
    assert(equal(table.contentInset.bottom,2));
    assert(CSTabBarStyleSnapshot((id)bar,copy)==copy);
    [copy removeFromSuperview];[bar removeFromSuperview];[page.view removeFromSuperview];
    (void)window;
    NSLog(@"8.0.80 native tabbar: wrappers, layout, selection, badge, hit targets, snapshot, restoration PASS");
}
