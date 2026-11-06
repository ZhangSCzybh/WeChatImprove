// Runs against the production adapter and real QuartzCore animation values.
static NSUInteger clickChecks;
#define ClickCheck(condition) do {clickChecks++; if(!(condition)){NSLog(@"click effect FAIL line %d: %s",__LINE__,#condition);exit(1);}} while(0)
static NSString *const ClickKey=@"cs.tabbar.clickBounce";
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
static void ClickTab(UIControl *button,BOOL drain) {
    [button sendActionsForControlEvents:UIControlEventTouchDown];
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    if(drain) DrainClickQueue();
}
static CAKeyframeAnimation *ClickAnimation(UIView *view) {return (id)SubmittedAnimation(view.layer,ClickKey);}
static void TestClickEffects(MainTabBarViewController *controller,MMTabBar *bar,NSArray *items,NSArray *buttons,NSString *suite,NSString *imagePath) {
    DrainClickQueue();
    NSDictionary *saved=[isolated persistentDomainForName:suite];
    [isolated setObject:imagePath forKey:kTabBarIconChatKey];
    NSUInteger savedIndex=controller.selectedIndex;
    MMTabBarItemView *first=items[0],*second=items[1],*third=items[2],*fourth=items[3];
    ClickCheck(CSTabBarPreferences.current.clickEffect==CSTabBarClickEffectNone);
    for(id value in @[@(-1),@2,@.5,@"1",@[@1]]) {
        [isolated setObject:value forKey:kTabBarClickEffectKey];[CSTabBarPreferences reload];
        ClickCheck(CSTabBarPreferences.current.clickEffect==CSTabBarClickEffectNone);
    }
    [isolated removeObjectForKey:kTabBarClickEffectKey];RefreshClickPreferences();
    NSUInteger haptics=CSTestHapticCount;
    ClickTab(buttons[0],YES);
    ClickCheck(!ClickAnimation(first.imageView) && CSTestHapticCount==haptics+1); // Existing haptic works with effect off.
    [isolated setInteger:0 forKey:kTabBarHapticFeedbackKey];
    [isolated setInteger:CSTabBarClickEffectBounce forKey:kTabBarClickEffectKey];RefreshClickPreferences();
    CGRect image=second.imageView.frame,label=second.textLabel.frame,badge=second.badgeView.frame,button=[buttons[1] frame];
    CATransform3D nativeTransform=CATransform3DMakeScale(.9,.9,1);second.imageView.layer.transform=nativeTransform;
    haptics=CSTestHapticCount;
    ClickTab(buttons[1],YES);
    CAKeyframeAnimation *bounce=ClickAnimation(second.imageView);
    ClickCheck(bounce && [bounce.keyPath isEqual:@"transform"] && bounce.additive && equal(bounce.duration,.34));
    ClickCheck(bounce.removedOnCompletion && bounce.repeatCount==0 && bounce.values.count==5);
    ClickCheck(CATransform3DIsIdentity([bounce.values.firstObject CATransform3DValue]) && CATransform3DIsIdentity([bounce.values.lastObject CATransform3DValue]));
    CATransform3D pressed=[bounce.values[1] CATransform3DValue],raised=[bounce.values[2] CATransform3DValue];
    ClickCheck(equal(pressed.m11,.92) && equal(raised.m11,1.08) && equal(raised.m42,-4));
    ClickCheck(CGRectEqualToRect(second.imageView.frame,image) && CGRectEqualToRect(second.textLabel.frame,label) && CGRectEqualToRect(second.badgeView.frame,badge) && CGRectEqualToRect([buttons[1] frame],button));
    ClickCheck(CATransform3DEqualToTransform(second.imageView.layer.transform,nativeTransform) && CSTestHapticCount==haptics);
    NSUInteger submissions=submittedAnimationCount;
    for(int i=0;i<20;i++) CSTabBarUpdate(bar);
    ClickCheck(ClickAnimation(second.imageView)==bounce && submittedAnimationCount==submissions);
    [second.imageView.layer removeAnimationForKey:ClickKey];CSTabBarUpdate(bar);
    ClickCheck(!ClickAnimation(second.imageView) && submittedAnimationCount==submissions); // No replay when a one-shot finishes.
    ClickTab(buttons[1],YES);
    ClickCheck(!ClickAnimation(second.imageView) && submittedAnimationCount==submissions); // Current tab retains native repeat action.
    UIControl *thirdButton=buttons[2];
    NSArray *nativeOrder=[thirdButton.actions copy];thirdButton.actions=[thirdButton.actions.reverseObjectEnumerator.allObjects mutableCopy];
    ClickTab(buttons[2],YES);
    ClickCheck(ClickAnimation(third.imageView) && controller.selectedIndex==2); // Feedback observer can run before native navigation.
    thirdButton.actions=[nativeOrder mutableCopy];
    submissions=submittedAnimationCount;
    ClickTab(buttons[0],NO);ClickTab(buttons[3],NO);DrainClickQueue();
    ClickCheck(!ClickAnimation(first.imageView) && !ClickAnimation(third.imageView) && ClickAnimation(fourth.imageView));
    ClickCheck(submittedAnimationCount==submissions+1); // Only the latest queued touch is allowed to animate.
    controller.selectedIndex=0;CSTabBarUpdate(bar);
    ClickCheck(!ClickAnimation(fourth.imageView) && !ClickAnimation(first.imageView)); // Programmatic selection never starts an effect.
    [(UIControl *)buttons[2] sendActionsForControlEvents:UIControlEventTouchUpInside];DrainClickQueue();
    ClickCheck(!ClickAnimation(third.imageView)); // No stale touch-down can be reused.
    ClickTab(buttons[1],NO);
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillResignActiveNotification object:nil];
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];DrainClickQueue();
    ClickCheck(!ClickAnimation(second.imageView)); // Even quick background/foreground cancels queued feedback.
    ClickTab(buttons[2],YES);ClickCheck(ClickAnimation(third.imageView)!=nil);
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillResignActiveNotification object:nil];
    ClickCheck(!ClickAnimation(third.imageView));
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    ClickCheck(!ClickAnimation(third.imageView));
    ClickTab(buttons[0],YES);ClickCheck(ClickAnimation(first.imageView)!=nil); // Imported custom image.
    bar.hidden=YES;CSTabBarUpdate(bar);ClickCheck(!ClickAnimation(first.imageView));
    bar.hidden=NO;CSTabBarUpdate(bar);ClickCheck(!ClickAnimation(first.imageView));
    ClickTab(buttons[1],YES);
    CSTestReduceMotionEnabled=YES;
    [NSNotificationCenter.defaultCenter postNotificationName:UIAccessibilityReduceMotionStatusDidChangeNotification object:nil];DrainClickQueue();
    [isolated setInteger:1 forKey:kTabBarHapticFeedbackKey];RefreshClickPreferences();haptics=CSTestHapticCount;
    ClickTab(buttons[2],YES);
    ClickCheck(!ClickAnimation(second.imageView) && !ClickAnimation(third.imageView) && CSTestHapticCount==haptics+1);
    CSTestReduceMotionEnabled=NO;[NSNotificationCenter.defaultCenter postNotificationName:UIAccessibilityReduceMotionStatusDidChangeNotification object:nil];DrainClickQueue();
    ClickCheck(!ClickAnimation(third.imageView));
    ClickTab(buttons[3],YES);
    [isolated setInteger:0 forKey:kTabBarClickEffectKey];RefreshClickPreferences();
    ClickCheck(!ClickAnimation(fourth.imageView));
    [isolated setInteger:1 forKey:kTabBarClickEffectKey];RefreshClickPreferences();
    ClickTab(buttons[0],YES);
    testThermalState=NSProcessInfoThermalStateSerious;[NSNotificationCenter.defaultCenter postNotificationName:NSProcessInfoThermalStateDidChangeNotification object:nil];
    ClickCheck(!ClickAnimation(first.imageView));
    testThermalState=NSProcessInfoThermalStateNominal;[NSNotificationCenter.defaultCenter postNotificationName:NSProcessInfoThermalStateDidChangeNotification object:nil];
    ClickCheck(!ClickAnimation(first.imageView));
    UIView *parent=bar.superview;ClickTab(buttons[1],YES);[bar removeFromSuperview];CSTabBarUpdate(bar);
    ClickCheck(!ClickAnimation(second.imageView));[parent addSubview:bar];CSTabBarUpdate(bar);
    ClickTab(buttons[2],YES);[isolated setBool:NO forKey:kTabBarStyleEnabledKey];RefreshClickPreferences();
    ClickCheck(!ClickAnimation(third.imageView) && [buttons[0] actions].count==1);
    [isolated setBool:YES forKey:kTabBarStyleEnabledKey];RefreshClickPreferences();
    UIView *custom=[[UIView alloc] initWithFrame:third.imageView.frame];third.customIconView=custom;[third addSubview:custom];
    ClickTab(buttons[0],YES);ClickTab(buttons[2],YES);
    ClickCheck(ClickAnimation(custom) && !ClickAnimation(third.imageView));
    custom.hidden=YES;CSTabBarUpdate(bar);
    ClickCheck(!ClickAnimation(custom));
    [custom removeFromSuperview];third.customIconView=nil;
    // Cancelling only our animation must preserve a native animation on the icon.
    [first.imageView.layer addAnimation:[CABasicAnimation animationWithKeyPath:@"opacity"] forKey:@"native.icon"];
    ClickTab(buttons[0],YES);ClickTab(buttons[1],YES);
    ClickCheck(SubmittedAnimation(first.imageView.layer,@"native.icon") && !ClickAnimation(first.imageView));
    [first.imageView.layer removeAnimationForKey:@"native.icon"];
    second.imageView.layer.transform=CATransform3DIdentity;
    [isolated setPersistentDomain:saved forName:suite];RefreshClickPreferences();controller.selectedIndex=savedIndex;
    ClickCheck(CSTabBarPreferences.current.clickEffect==CSTabBarClickEffectNone);
    NSLog(@"tabbar click effect: %lu checks passed",(unsigned long)clickChecks);
}
#undef ClickCheck
