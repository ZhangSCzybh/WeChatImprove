// Exercise production color selection and image caching without real user defaults.
static NSUInteger functionColorChecks;
#define FunctionColorCheck(condition) do {functionColorChecks++; if(!(condition)){NSLog(@"tabbar function color FAIL line %d: %s",__LINE__,#condition);exit(1);}} while(0)

static void FunctionClearColor(NSString *prefix) {
    for (NSString *component in @[@"red",@"green",@"blue",@"alpha"])
        [isolated removeObjectForKey:[prefix stringByAppendingFormat:@".%@",component]];
}
static void FunctionSetColor(NSString *prefix,CGFloat r,CGFloat g,CGFloat b,CGFloat a) {
    NSArray *values=@[@(r),@(g),@(b),@(a)];NSUInteger index=0;
    for (NSString *component in @[@"red",@"green",@"blue",@"alpha"])
        [isolated setObject:values[index++] forKey:[prefix stringByAppendingFormat:@".%@",component]];
}
static UIControl *FunctionColorControl(UIView *view) {
    for (UIView *child in view.subviews)
        if ([child.accessibilityIdentifier isEqualToString:@"cs.tabbar.function"]) return (id)child;
    return nil;
}
static UIImageView *FunctionColorImage(UIControl *control) {
    for (UIView *child in control.subviews) if ([child isKindOfClass:UIImageView.class]) return (id)child;
    return nil;
}
static UIVisualEffectView *FunctionColorMaterial(UIControl *control) {
    for (UIView *child in control.subviews) if ([child isKindOfClass:UIVisualEffectView.class]) return (id)child;
    return nil;
}
static void CheckFunctionSnapshot(MMTabBar *bar,NSArray *items,BOOL modern,UIColor *background,BOOL materialHidden,UIColor *icon) {
    UIView *raw;
    if (modern) {
        WCTabBarView *copy=[[WCTabBarView alloc] initWithFrame:bar.frame];
        copy.traitCollection.userInterfaceStyle=bar.traitCollection.userInterfaceStyle;
        // Temporary snapshot colors must not become the independent key's default.
        copy.backgroundColor=[UIColor colorWithRed:.01 green:.02 blue:.03 alpha:1];
        NSMutableArray *buttons=[NSMutableArray array];
        for (NSUInteger i=0;i<4;i++) {
            MMMainTabBarItemView *button=StructureModernButton([items[i] item],i);
            [copy addSubview:button];[buttons addObject:button];
        }
        copy.items=bar.items;copy.itemViews=buttons;raw=copy;
    } else {
        raw=[[UIView alloc] initWithFrame:bar.frame];
        for (UIView *item in items) [raw addSubview:[[UIImageView alloc] initWithFrame:item.frame]];
    }
    UIView *snapshot=CSTabBarStyleSnapshot(bar,raw);
    UIControl *function=FunctionColorControl(snapshot);
    FunctionColorCheck(function && !function.userInteractionEnabled);
    FunctionColorCheck(CGColorEqualToColor(function.backgroundColor.CGColor,background.CGColor));
    FunctionColorCheck(FunctionColorMaterial(function).hidden==materialHidden);
    FunctionColorCheck(CGColorEqualToColor(FunctionColorImage(function).image.appliedTint.CGColor,icon.CGColor));
    NSUInteger actions=functionActionCount;
    [function sendActionsForControlEvents:UIControlEventTouchUpInside];
    FunctionColorCheck(functionActionCount==actions);
}

static void ExerciseTabBarFunctionColors(BOOL modern) {
    UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];
    UIView *root=[[UIView alloc] initWithFrame:window.bounds];[window addSubview:root];
    MMTabBar *bar=modern ? (id)[WCTabBarView new] : [MMTabBar new];
    bar.frame=CGRectMake(0,761,390,83);[root addSubview:bar];
    UIColor *native=[UIColor colorWithRed:.92 green:.93 blue:.94 alpha:1];bar.backgroundColor=native;
    UIView *nativeView=[[UIView alloc] initWithFrame:bar.bounds];
    nativeView.backgroundColor=[UIColor colorWithRed:.82 green:.83 blue:.84 alpha:.9];[bar addSubview:nativeView];
    id owner=modern ? (id)[NewMainTabBarViewController new] : [MainTabBarViewController new];
    [owner setView:root];
    if (modern) { ((WCTabBarView *)bar).backgroundContentView=nativeView;((WCTabBarView *)bar).visibilityDelegate=owner;[owner setTabBarView:(id)bar]; }
    else { bar.backgroundView=nativeView;bar.customDelegate=owner;[owner setTabBar:bar]; }
    NSMutableArray *models=[NSMutableArray array],*items=[NSMutableArray array],*buttons=[NSMutableArray array],*nativeImages=[NSMutableArray array];
    for (NSUInteger i=0;i<4;i++) {
        MMTabbarItem *model=[MMTabbarItem new];model.index=i;[models addObject:model];
        MMMainTabBarItemView *wrapper=StructureModernButton(model,i);
        MMTabBarItemView *item=wrapper.itemView;
        UIImage *image=[UIImage new];item.imageView.image=image;[nativeImages addObject:image];
        UIView *button=modern ? wrapper : [[UIControl alloc] initWithFrame:wrapper.frame];
        if (modern) [bar addSubview:wrapper];
        else { [bar addSubview:button];item.frame=wrapper.frame;[bar addSubview:item]; }
        [items addObject:item];[buttons addObject:button];
    }
    bar.items=models;
    if (modern) ((WCTabBarView *)bar).itemViews=buttons;
    else { bar.tabBarItemViews=items;[owner setButtons:buttons]; }
    [isolated setBool:YES forKey:kTabBarStyleEnabledKey];
    [isolated setDouble:.9 forKey:kTabBarScaleKey];
    [isolated setDouble:52 forKey:kTabBarContentHeightKey];
    [isolated setObject:@"global_search" forKey:kTabBarFunctionActionKey];
    FunctionSetColor(@"com.wechat.enhance.tabbar_style.bg_color",.7,.6,.5,.8);
    FunctionSetColor(kTabBarSelectedIconColorKey,.3,.4,.5,.6);
    FunctionSetColor(kTabBarIndicatorColorKey,.5,.6,.7,.4);
    FunctionSetColor(@"com.wechat.enhance.tabbar_style.border_color",.2,.3,.4,.9);
    for (NSNumber *structure in @[@1,@2]) {
        FunctionClearColor(kTabBarFunctionBackgroundColorKey);FunctionClearColor(kTabBarFunctionIconColorKey);
        [isolated setInteger:structure.integerValue forKey:kTabBarStructureKey];
        [CSTabBarPreferences reload];CSTabBarUpdate(bar);
        UIControl *function=FunctionColorControl(bar);UIImageView *image=FunctionColorImage(function);
        FunctionColorCheck(function && image && function.userInteractionEnabled);
        FunctionColorCheck(function.backgroundColor==native && !FunctionColorMaterial(function).hidden);
        FunctionColorCheck(CGColorEqualToColor([bar.subviews[0] backgroundColor].CGColor,CSTabBarPreferences.current.backgroundColor.CGColor));
        CGRect tabFrames[4];for (NSUInteger i=0;i<4;i++) tabFrames[i]=[buttons[i] frame];
        for (NSNumber *style in @[@1,@2,@1]) {
            bar.traitCollection.userInterfaceStyle=style.integerValue;CSTabBarUpdate(bar);
            CGFloat channel=style.integerValue==UIUserInterfaceStyleDark ? 1 : 0;
            FunctionColorCheck(equal(image.image.appliedTint.red,channel) && equal(image.image.appliedTint.green,channel) && equal(image.image.appliedTint.blue,channel) && equal(image.image.appliedTint.alpha,1));
            UIImage *cached=image.image;
            for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
            FunctionColorCheck(image.image==cached);
            CheckFunctionSnapshot(bar,items,modern,native,NO,image.image.appliedTint);
        }
        // Background-only edits leave the icon image and all native tab pixels intact.
        UIImage *defaultImage=image.image;
        FunctionSetColor(kTabBarFunctionBackgroundColorKey,.1,.2,.3,.4);
        [CSTabBarPreferences reload];CSTabBarUpdate(bar);
        FunctionColorCheck(function.backgroundColor==CSTabBarPreferences.current.functionBackgroundColor && FunctionColorMaterial(function).hidden);
        FunctionColorCheck(image.image==defaultImage);
        CheckFunctionSnapshot(bar,items,modern,CSTabBarPreferences.current.functionBackgroundColor,YES,image.image.appliedTint);
        for (NSNumber *red in @[@.25,@.75]) {
            UIImage *previous=image.image;
            FunctionSetColor(kTabBarFunctionIconColorKey,red.doubleValue,.35,.45,.55);
            [CSTabBarPreferences reload];CSTabBarUpdate(bar);
            FunctionColorCheck(image.image!=previous && equal(image.image.appliedTint.red,red.doubleValue) && equal(image.image.appliedTint.alpha,.55));
            UIImage *cached=image.image;
            [CSTabBarPreferences reload];CSTabBarUpdate(bar);
            for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
            FunctionColorCheck(image.image==cached);
            CheckFunctionSnapshot(bar,items,modern,CSTabBarPreferences.current.functionBackgroundColor,YES,image.image.appliedTint);
        }
        // Resolve dynamic colors each layout; cache only the resulting pixels.
        CSTabBarPreferences.current.functionIconColor=[CSTabBarTestTraitColor new];
        for (NSNumber *style in @[@1,@2,@1]) {
            bar.traitCollection.userInterfaceStyle=style.integerValue;CSTabBarUpdate(bar);
            FunctionColorCheck(equal(image.image.appliedTint.red,style.integerValue==UIUserInterfaceStyleDark ? .8 : .2));
            UIImage *cached=image.image;CSTabBarUpdate(bar);FunctionColorCheck(image.image==cached);
        }
        // Explicit transparent colors remain configured and suppress the blur.
        FunctionSetColor(kTabBarFunctionBackgroundColorKey,.8,.7,.6,0);
        FunctionSetColor(kTabBarFunctionIconColorKey,.6,.5,.4,0);
        [CSTabBarPreferences reload];CSTabBarUpdate(bar);
        FunctionColorCheck(CSTabBarPreferences.current.functionBackgroundColor && equal(function.backgroundColor.alpha,0) && FunctionColorMaterial(function).hidden);
        FunctionColorCheck(CSTabBarPreferences.current.functionIconColor && equal(image.image.appliedTint.alpha,0));
        FunctionColorCheck(equal(CSTabBarPreferences.current.backgroundColor.red,.7) && equal(CSTabBarPreferences.current.selectedIconColor.red,.3) && equal(CSTabBarPreferences.current.indicatorColor.red,.5) && equal(CSTabBarPreferences.current.borderColor.red,.2));
        CheckFunctionSnapshot(bar,items,modern,function.backgroundColor,YES,image.image.appliedTint);
        for (NSUInteger i=0;i<4;i++) {
            FunctionColorCheck([items[i] imageView].image==nativeImages[i]);
            FunctionColorCheck(CGRectEqualToRect([buttons[i] frame],tabFrames[i]));
        }
        // Restore each channel independently, then restore the native defaults.
        FunctionClearColor(kTabBarFunctionBackgroundColorKey);[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        FunctionColorCheck(!CSTabBarPreferences.current.functionBackgroundColor && function.backgroundColor==native && !FunctionColorMaterial(function).hidden);
        FunctionColorCheck(CSTabBarPreferences.current.functionIconColor && equal(image.image.appliedTint.alpha,0));
        FunctionClearColor(kTabBarFunctionIconColorKey);[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        FunctionColorCheck(!CSTabBarPreferences.current.functionIconColor && equal(image.image.appliedTint.red,0) && equal(image.image.appliedTint.alpha,1));
        CheckFunctionSnapshot(bar,items,modern,native,NO,image.image.appliedTint);
        // A missing bar fill uses the native background view, including snapshots.
        bar.backgroundColor=nil;CSTabBarUpdate(bar);
        FunctionColorCheck(function.backgroundColor==nativeView.backgroundColor && !FunctionColorMaterial(function).hidden);
        CheckFunctionSnapshot(bar,items,modern,nativeView.backgroundColor,NO,image.image.appliedTint);
        bar.backgroundColor=native;CSTabBarUpdate(bar);
        [isolated setInteger:CSTabBarStructureClassic forKey:kTabBarStructureKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        FunctionColorCheck(function.hidden && !function.superview && !FunctionColorControl(bar));
        [isolated setInteger:structure.integerValue forKey:kTabBarStructureKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        FunctionColorCheck(FunctionColorControl(bar)==function && !function.hidden);
        [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        FunctionColorCheck(!function.superview && !nativeView.hidden);
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey];
    }
    [root removeFromSuperview];
}

static void TestTabBarFunctionColors(NSString *suite) {
    NSDictionary *saved=[isolated persistentDomainForName:suite];
    [isolated setPersistentDomain:@{} forName:suite];
    [CSTabBarPreferences reload];
    FunctionColorCheck(CSTabBarPreferences.current.functionBackgroundColor==nil && CSTabBarPreferences.current.functionIconColor==nil);
    FunctionColorCheck([isolated persistentDomainForName:suite].count==0);
    // A missing alpha always means the default, even if obsolete RGB remain.
    [isolated setDouble:.4 forKey:kTabBarFunctionBackgroundColorRedKey];
    [isolated setDouble:.6 forKey:kTabBarFunctionIconColorGreenKey];
    NSDictionary *before=[isolated persistentDomainForName:suite];[CSTabBarPreferences reload];
    FunctionColorCheck(!CSTabBarPreferences.current.functionBackgroundColor && !CSTabBarPreferences.current.functionIconColor);
    FunctionColorCheck([[isolated persistentDomainForName:suite] isEqualToDictionary:before]);
    // Both new colors preserve the existing RGBA normalization semantics.
    for (NSString *prefix in @[kTabBarFunctionBackgroundColorKey,kTabBarFunctionIconColorKey]) {
        FunctionSetColor(prefix,-1,2,NAN,INFINITY);[CSTabBarPreferences reload];
        UIColor *color=[prefix isEqual:kTabBarFunctionBackgroundColorKey] ? CSTabBarPreferences.current.functionBackgroundColor : CSTabBarPreferences.current.functionIconColor;
        FunctionColorCheck(color && equal(color.red,0) && equal(color.green,1) && equal(color.blue,0) && equal(color.alpha,1));
        FunctionClearColor(prefix);
    }
    ExerciseTabBarFunctionColors(NO);ExerciseTabBarFunctionColors(YES);
    [isolated setPersistentDomain:saved forName:suite];RefreshClickPreferences();
    NSLog(@"tabbar independent function colors/native restore: PASS (%lu checks)",(unsigned long)functionColorChecks);
}
#undef FunctionColorCheck
