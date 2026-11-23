// Behavioral regression against production input mapping and submitted UIView animation values.
// These host doubles do not render UIKit or prove on-device animation smoothness.
static NSUInteger clickChecks;
#define ClickCheck(condition) do {clickChecks++; if(!(condition)){NSLog(@"tabbar touch FAIL line %d: %s",__LINE__,#condition);exit(1);}} while(0)
static void DrainClickQueue(void) {
    __block BOOL done=NO;
    dispatch_async(dispatch_get_main_queue(),^{done=YES;});
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:2];
    while(!done && deadline.timeIntervalSinceNow>0) [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.001]];
    assert(done);
}
static void RefreshClickPreferences(void) {
    [NSNotificationCenter.defaultCenter postNotificationName:CSTabBarPreferencesDidChange object:nil];
    DrainClickQueue();
}
static UIView *FindIndicator(UIView *view) {
    if ([view.layer.name isEqualToString:@"cs.tabbar.indicator"]) return view;
    for (UIView *child in view.subviews) {UIView *found=FindIndicator(child);if(found)return found;}
    return nil;
}
static UIControl *TouchControlAt(MMTabBar *bar, CGPoint point) {
    BOOL handled=NO;
    UIView *hit=CSTabBarHitTest(bar,point,nil,&handled);
    Class touchClass=NSClassFromString(@"CSTabBarTouchControl");
    return handled && touchClass && [hit isKindOfClass:touchClass] ? (id)hit : nil;
}
static CGPoint ButtonCenter(NSArray *buttons,NSUInteger index) {
    return CGPointMake(CGRectGetMidX([buttons[index] frame]),CGRectGetMidY([buttons[index] frame]));
}
static void SendTouch(UIControl *control,UIControlEvents events,MMTabBar *bar,CGPoint point) {
    UITouch *touch=[UITouch new];touch.testView=bar;touch.testLocation=point;
    UIEvent *event=[UIEvent new];event.allTouches=[NSSet setWithObject:touch];
    [control sendActionsForControlEvents:events withEvent:event];
}
static void CheckPressAnimation(void) {
    CSTestViewAnimation *animation=CSTestViewAnimations.lastObject;
    ClickCheck(animation && !animation.spring && equal(animation.duration,.12) && equal(animation.delay,0));
    ClickCheck((animation.options & (3<<16))==UIViewAnimationOptionCurveEaseOut);
}
static void CheckSettleAnimation(void) {
    CSTestViewAnimation *animation=CSTestViewAnimations.lastObject;
    ClickCheck(animation && animation.spring && equal(animation.duration,.46) && equal(animation.delay,0));
    ClickCheck(equal(animation.damping,.62) && equal(animation.velocity,.82) && animation.options==6);
}
static void CheckIndicatorAt(UIView *indicator,MMTabBar *bar,CGPoint point) {
    CGPoint local=[bar convertPoint:point toView:indicator.superview];
    ClickCheck(fabs(CGRectGetMidX(indicator.frame)-local.x)<=1);
}
static void TestClickEffects(MainTabBarViewController *controller,MMTabBar *bar,NSArray *items,NSArray *buttons,NSString *suite,NSString *imagePath) {
    DrainClickQueue();
    NSDictionary *saved=[isolated persistentDomainForName:suite];
    NSUInteger savedIndex=controller.selectedIndex;
    for(id value in @[@(-1),@2,@.5,@"1",@[@1]]) {
        [isolated setObject:value forKey:kTabBarClickEffectKey];[CSTabBarPreferences reload];
        ClickCheck(CSTabBarPreferences.current.clickEffect==CSTabBarClickEffectNone);
    }
    [isolated setBool:NO forKey:kTabBarSwipeSwitchKey];
    [isolated setInteger:0 forKey:kTabBarHapticFeedbackKey];
    for (NSNumber *mode in @[@1,@3]) {
        [isolated setInteger:mode.integerValue forKey:kTabBarClickEffectKey];
        controller.selectedIndex=0;RefreshClickPreferences();CSTabBarSwipeRefresh(bar);
        [controller.selectionRequests removeAllObjects];
        UIView *indicator=FindIndicator(bar);
        CGPoint first=ButtonCenter(buttons,0),second=ButtonCenter(buttons,1),last=ButtonCenter(buttons,3);
        UIControl *control=TouchControlAt(bar,second);
        ClickCheck(indicator && control && !indicator.userInteractionEnabled);
        ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
        CGRect itemFrame=[items[1] frame],badgeFrame=[[items[1] badgeView] frame];
        NSInteger nativeClicks=controller.nativeClicks;
        [CSTestViewAnimations removeAllObjects];
        SendTouch(control,UIControlEventTouchDown,bar,second);
        CheckPressAnimation();
        ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
        CGFloat previousX=CGRectGetMidX(indicator.frame);
        NSUInteger animations=CSTestViewAnimations.count;
        SendTouch(control,UIControlEventTouchDragInside,bar,last);
        ClickCheck(CSTestViewAnimations.count==animations && CGRectGetMidX(indicator.frame)>previousX);
        ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
        NSUInteger removals=[objc_getAssociatedObject(indicator.layer,&AnimationRemovalCountKey) unsignedIntegerValue];
        [CSTestIndicatorFrameWrites removeAllObjects];
        SendTouch(control,UIControlEventTouchUpInside,bar,last);
        CheckSettleAnimation();
        ClickCheck([objc_getAssociatedObject(indicator.layer,&AnimationRemovalCountKey) unsignedIntegerValue]>removals);
        ClickCheck([CSTestIndicatorFrameWrites isEqualToArray:@[@2]]); // The release does not write an intermediate snapped frame.
        ClickCheck(controller.selectedIndex==3 && [controller.selectionRequests isEqualToArray:@[@3]]);
        CheckIndicatorAt(indicator,bar,last);
        ClickCheck(controller.nativeClicks==nativeClicks);
        ClickCheck(CGRectEqualToRect([items[1] frame],itemFrame) && CGRectEqualToRect([[items[1] badgeView] frame],badgeFrame));
        if(mode.integerValue==1) {
            UIView *lastButton=buttons[3];CGRect slot=[lastButton convertRect:lastButton.bounds toView:indicator.superview];
            CGRect expected=CGRectIntegral(CGRectMake(CGRectGetMidX(slot)-14,CGRectGetMaxY(indicator.superview.bounds)-4,28,3));
            ClickCheck(CGRectEqualToRect(indicator.frame,expected)); // Neo integralizes its nominal 28x3-point frame.
            ClickCheck(equal(CGRectGetHeight(indicator.superview.bounds)-CGRectGetMaxY(indicator.frame),1));
        } else {
            ClickCheck(CGRectGetHeight(indicator.frame)>3 && equal(indicator.layer.cornerRadius,CGRectGetHeight(indicator.frame)/2));
        }
        // TouchUpOutside settles without selecting a page outside the touch target.
        [controller.selectionRequests removeAllObjects];
        control=TouchControlAt(bar,first);SendTouch(control,UIControlEventTouchDown,bar,first);
        SendTouch(control,UIControlEventTouchDragOutside,bar,CGPointMake(first.x,first.y-100));
        SendTouch(control,UIControlEventTouchUpOutside,bar,CGPointMake(first.x,first.y-100));
        ClickCheck(controller.selectedIndex==3 && controller.selectionRequests.count==0);
        CheckSettleAnimation();CheckIndicatorAt(indicator,bar,last);
        // Cancellation restores current selection and makes later moves inert.
        SendTouch(control,UIControlEventTouchDown,bar,first);
        SendTouch(control,UIControlEventTouchCancel,bar,first);
        CheckSettleAnimation();CheckIndicatorAt(indicator,bar,last);
        NSUInteger requests=controller.selectionRequests.count;
        CSTabBarTouchMove(bar,second);
        ClickCheck(controller.selectionRequests.count==requests && controller.selectedIndex==3);
    }
    [isolated setInteger:3 forKey:kTabBarClickEffectKey];
    [isolated setBool:YES forKey:kTabBarSwipeSwitchKey];
    [isolated setInteger:1 forKey:kTabBarHapticFeedbackKey];
    controller.selectedIndex=0;RefreshClickPreferences();CSTabBarSwipeRefresh(bar);
    [controller.selectionRequests removeAllObjects];
    CGPoint first=ButtonCenter(buttons,0),second=ButtonCenter(buttons,1),third=ButtonCenter(buttons,2),last=ButtonCenter(buttons,3);
    UIControl *control=TouchControlAt(bar,first);
    UIView *indicator=FindIndicator(bar);
    NSUInteger haptics=CSTestHapticCount;
    NSInteger nativeClicks=controller.nativeClicks;
    SendTouch(control,UIControlEventTouchDown,bar,first);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    NSUInteger animations=CSTestViewAnimations.count;
    SendTouch(control,UIControlEventTouchDragInside,bar,second);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    CheckIndicatorAt(indicator,bar,second);
    SendTouch(control,UIControlEventTouchDragInside,bar,second);
    ClickCheck(controller.selectionRequests.count==0 && CSTestHapticCount==haptics);
    SendTouch(control,UIControlEventTouchDragOutside,bar,CGPointMake(third.x,third.y-100));
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && CSTestViewAnimations.count==animations);
    CheckIndicatorAt(indicator,bar,third);
    SendTouch(control,UIControlEventTouchUpInside,bar,third);
    ClickCheck(controller.selectedIndex==2 && [controller.selectionRequests isEqualToArray:@[@2]]);
    ClickCheck(CSTestHapticCount==haptics+1 && controller.nativeClicks==nativeClicks);
    CheckSettleAnimation();CheckIndicatorAt(indicator,bar,third);
    // A -> C -> A only previews the intermediate page and commits nothing.
    controller.selectedIndex=0;CSTabBarUpdate(bar);[controller.selectionRequests removeAllObjects];
    haptics=CSTestHapticCount;
    SendTouch(control,UIControlEventTouchDown,bar,first);
    SendTouch(control,UIControlEventTouchDragInside,bar,third);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    SendTouch(control,UIControlEventTouchDragInside,bar,first);
    SendTouch(control,UIControlEventTouchUpInside,bar,first);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && CSTestHapticCount==haptics && controller.nativeClicks==nativeClicks);
    CheckSettleAnimation();CheckIndicatorAt(indicator,bar,first);
    // A nonadjacent Down and one-pixel slot crossings remain previews until release.
    SendTouch(control,UIControlEventTouchDown,bar,last);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    ClickCheck(CGRectContainsPoint(indicator.frame,[bar convertPoint:last toView:indicator.superview])); // Edge preview can clamp within its host.
    CGFloat boundary=(second.x+third.x)/2;
    SendTouch(control,UIControlEventTouchDragInside,bar,CGPointMake(boundary+1,third.y));
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    CheckIndicatorAt(indicator,bar,CGPointMake(boundary+1,third.y));
    SendTouch(control,UIControlEventTouchDragInside,bar,CGPointMake(boundary-1,third.y));
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    CheckIndicatorAt(indicator,bar,CGPointMake(boundary-1,third.y));
    SendTouch(control,UIControlEventTouchCancel,bar,second);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && CSTestHapticCount==haptics && controller.nativeClicks==nativeClicks);
    CheckSettleAnimation();CheckIndicatorAt(indicator,bar,first);
    CSTabBarTouchMove(bar,last);CSTabBarTouchEnd(bar,last);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    // Invalid coordinates cannot corrupt an active interaction or native selection.
    CSTabBarTouchBegin(bar,CGPointMake(NAN,first.y));CSTabBarTouchMove(bar,last);CSTabBarTouchEnd(bar,last);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    // A real short tap of the selected first page retains its native repeat action once.
    controller.selectedIndex=0;CSTabBarUpdate(bar);[controller.selectionRequests removeAllObjects];
    control=TouchControlAt(bar,first);
    SendTouch(control,UIControlEventTouchDown,bar,first);
    ClickCheck(controller.selectionRequests.count==0);
    nativeClicks=controller.nativeClicks;
    SendTouch(control,UIControlEventTouchUpInside,bar,first);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && controller.nativeClicks==nativeClicks+1);
    // A plain click selects exactly once on Up, and a repeated Up cannot replay it.
    [controller.selectionRequests removeAllObjects];
    SendTouch(control,UIControlEventTouchDown,bar,last);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    SendTouch(control,UIControlEventTouchUpInside,bar,last);
    SendTouch(control,UIControlEventTouchUpInside,bar,last);
    ClickCheck(controller.selectedIndex==3 && [controller.selectionRequests isEqualToArray:@[@3]]);
    UIControl *thirdButton=buttons[2];
    for(NSNumber *hidden in @[@NO,@YES]) {
        thirdButton.enabled=hidden.boolValue;thirdButton.hidden=hidden.boolValue;CSTabBarUpdate(bar);
        NSUInteger requests=controller.selectionRequests.count;
        NSUInteger feedback=CSTestHapticCount;NSInteger clicks=controller.nativeClicks;
        control=TouchControlAt(bar,last);
        SendTouch(control,UIControlEventTouchDown,bar,last);
        SendTouch(control,UIControlEventTouchDragInside,bar,third);
        SendTouch(control,UIControlEventTouchUpInside,bar,third);
        ClickCheck(controller.selectedIndex==3 && controller.selectionRequests.count==requests && controller.nativeClicks==clicks && CSTestHapticCount==feedback);
        ClickCheck(!TouchControlAt(bar,third));
    }
    thirdButton.enabled=YES;thirdButton.hidden=NO;CSTabBarUpdate(bar);
    // Older native controllers still dispatch their original button target as the selection fallback.
    controller.nativeSelectionUnavailable=YES;nativeClicks=controller.nativeClicks;
    controller.selectedIndex=0;CSTabBarUpdate(bar);
    [controller.selectionRequests removeAllObjects];
    control=TouchControlAt(bar,first);
    SendTouch(control,UIControlEventTouchDown,bar,first);
    SendTouch(control,UIControlEventTouchDragInside,bar,second);
    SendTouch(control,UIControlEventTouchDragInside,bar,third);
    ClickCheck(controller.selectedIndex==0 && controller.nativeClicks==nativeClicks && controller.selectionRequests.count==0);
    SendTouch(control,UIControlEventTouchUpInside,bar,third);
    SendTouch(control,UIControlEventTouchUpInside,bar,third);
    ClickCheck(controller.selectedIndex==2 && controller.nativeClicks==nativeClicks+1 && controller.selectionRequests.count==0);
    controller.nativeSelectionUnavailable=NO;nativeClicks=controller.nativeClicks;
    // The original native button action and badge hierarchy remain intact.
    [(UIControl *)buttons[2] sendActionsForControlEvents:UIControlEventTouchUpInside];
    ClickCheck(controller.nativeClicks==nativeClicks+1 && controller.selectedIndex==2);
    ClickCheck([[items[0] badgeView] superview]==items[0] && ![[items[0] badgeView] hidden]);
    // With both features off, hit-testing returns the original native control.
    [isolated setInteger:0 forKey:kTabBarClickEffectKey];[isolated setBool:NO forKey:kTabBarSwipeSwitchKey];[isolated setInteger:0 forKey:kTabBarHapticFeedbackKey];RefreshClickPreferences();
    BOOL handled=NO;
    ClickCheck(!FindIndicator(bar) && !TouchControlAt(bar,first));
    ClickCheck(CSTabBarHitTest(bar,first,nil,&handled)==buttons[0] && handled);
    [isolated setPersistentDomain:saved forName:suite];RefreshClickPreferences();controller.selectedIndex=savedIndex;CSTabBarUpdate(bar);
    ClickCheck(CSTabBarPreferences.current.clickEffect==CSTabBarClickEffectNone);
    NSLog(@"tabbar Neo touch/animation: %lu checks passed",(unsigned long)clickChecks);
}
static void TestModernTouchHierarchy(NSString *suite) {
    NSDictionary *saved=[isolated persistentDomainForName:suite];
    [isolated setBool:YES forKey:kTabBarStyleEnabledKey];[isolated setBool:YES forKey:kTabBarSwipeSwitchKey];
    [isolated setInteger:3 forKey:kTabBarClickEffectKey];[isolated setInteger:0 forKey:kTabBarHapticFeedbackKey];
    [CSTabBarPreferences reload];
    UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];window.safeAreaInsets=(UIEdgeInsets){0,0,34,0};
    UIView *root=[[UIView alloc] initWithFrame:window.bounds];[window addSubview:root];
    WCTabBarView *modern=[[WCTabBarView alloc] initWithFrame:CGRectMake(0,761,390,83)];[root addSubview:modern];
    modern.backgroundContentView=[[UIView alloc] initWithFrame:modern.bounds];[modern addSubview:modern.backgroundContentView];
    modern.separatorView=[[UIView alloc] initWithFrame:CGRectMake(0,0,390,.5)];[modern addSubview:modern.separatorView];
    NewMainTabBarViewController *controller=[NewMainTabBarViewController new];controller.view=root;controller.tabBarView=modern;modern.visibilityDelegate=controller;
    NSMutableArray *models=[NSMutableArray array],*buttons=[NSMutableArray array];
    for(NSUInteger i=0;i<4;i++) {
        MMTabbarItem *model=[MMTabbarItem new];model.index=i;[models addObject:model];
        MMMainTabBarItemView *button=[[MMMainTabBarItemView alloc] initWithFrame:CGRectMake(i*97.5,0,97.5,49)];
        MMTabBarItemView *item=[[MMTabBarItemView alloc] initWithFrame:button.bounds];item.item=model;
        item.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(36,4,25,25)];[item addSubview:item.imageView];
        item.textLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,32,97.5,12)];[item addSubview:item.textLabel];
        item.badgeView=[[UIView alloc] initWithFrame:CGRectMake(57,1,16,16)];[item addSubview:item.badgeView];
        button.itemView=item;button.legacyItem=model;[button addSubview:item];
        [button addTarget:controller action:@selector(nativeClick:) forControlEvents:UIControlEventTouchUpInside];
        [modern addSubview:button];[buttons addObject:button];
    }
    modern.items=models;modern.itemViews=buttons;
    MMTabBar *bar=(id)modern;CSTabBarUpdate(bar);
    CGPoint first=ButtonCenter(buttons,0),second=ButtonCenter(buttons,1),third=ButtonCenter(buttons,2),last=ButtonCenter(buttons,3);
    UIControl *control=TouchControlAt(bar,first);UIView *indicator=FindIndicator(modern);
    ClickCheck(control && indicator && modern.backgroundContentView.hidden && modern.separatorView.hidden);
    SendTouch(control,UIControlEventTouchDown,bar,first);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    NSUInteger animations=CSTestViewAnimations.count;
    SendTouch(control,UIControlEventTouchDragInside,bar,second);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    SendTouch(control,UIControlEventTouchDragOutside,bar,third);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    ClickCheck(CSTestViewAnimations.count==animations);
    CheckIndicatorAt(indicator,bar,third);
    SendTouch(control,UIControlEventTouchUpInside,bar,third);
    ClickCheck(controller.selectedIndex==2 && [controller.selectionRequests isEqualToArray:@[@2]] && controller.nativeClicks==0);
    CheckSettleAnimation();CheckIndicatorAt(indicator,bar,third);
    controller.selectedIndex=0;CSTabBarUpdate(bar);[controller.selectionRequests removeAllObjects];
    SendTouch(control,UIControlEventTouchDown,bar,first);
    SendTouch(control,UIControlEventTouchDragInside,bar,third);
    SendTouch(control,UIControlEventTouchDragInside,bar,first);
    SendTouch(control,UIControlEventTouchUpInside,bar,first);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    CheckSettleAnimation();CheckIndicatorAt(indicator,bar,first);
    SendTouch(control,UIControlEventTouchDown,bar,third);
    SendTouch(control,UIControlEventTouchDragInside,bar,last);
    SendTouch(control,UIControlEventTouchCancel,bar,last);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    CheckSettleAnimation();CheckIndicatorAt(indicator,bar,first);
    SendTouch(control,UIControlEventTouchDown,bar,last);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    SendTouch(control,UIControlEventTouchUpInside,bar,last);
    SendTouch(control,UIControlEventTouchUpInside,bar,last);
    ClickCheck(controller.selectedIndex==3 && [controller.selectionRequests isEqualToArray:@[@3]] && controller.nativeClicks==0);
    // Native first-page double-tap support consumes two quick taps without reselecting.
    controller.selectedIndex=0;CSTabBarUpdate(bar);[controller.selectionRequests removeAllObjects];
    RefreshClickPreferences(); // A prior drag ending in the first slot also records a Neo first-tab tap.
    control=TouchControlAt(bar,first);
    SendTouch(control,UIControlEventTouchDown,bar,first);SendTouch(control,UIControlEventTouchUpInside,bar,first);
    ClickCheck(controller.doubleClicks==0 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    SendTouch(control,UIControlEventTouchDown,bar,first);SendTouch(control,UIControlEventTouchUpInside,bar,first);
    ClickCheck(controller.doubleClicks==1 && controller.selectionRequests.count==0 && controller.nativeClicks==0);
    modern.hidden=YES;CSTabBarUpdate(bar);CSTabBarTouchBegin(bar,last);CSTabBarTouchEnd(bar,last);
    ClickCheck(controller.selectedIndex==0 && controller.selectionRequests.count==0);
    modern.hidden=NO;modern.itemViews=@[];CSTabBarUpdate(bar);
    ClickCheck(!modern.backgroundContentView.hidden && !modern.separatorView.hidden && !FindIndicator(modern));
    [isolated setPersistentDomain:saved forName:suite];RefreshClickPreferences();
    NSLog(@"tabbar modern native hierarchy: PASS (%lu total touch checks)",(unsigned long)clickChecks);
}
#undef ClickCheck
