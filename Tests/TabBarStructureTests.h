// Production layout, hit mapping, route source and restoration against host doubles.
static NSUInteger structureChecks;
#define StructureCheck(condition) do {structureChecks++; if(!(condition)){NSLog(@"tabbar structure FAIL line %d: %s",__LINE__,#condition);exit(1);}} while(0)
static void TestTabBarWidthPreferences(void) {
    id savedWidth=[isolated objectForKey:kTabBarContentWidthKey];
    id savedScale=[isolated objectForKey:kTabBarScaleKey];
    [isolated removeObjectForKey:kTabBarContentWidthKey];
    [isolated setDouble:.75 forKey:kTabBarScaleKey];[CSTabBarPreferences reload];
    StructureCheck(equal(CSTabBarPreferences.current.contentWidth,0));
    [isolated setDouble:300 forKey:kTabBarContentWidthKey];[CSTabBarPreferences reload];
    StructureCheck(equal(CSTabBarPreferences.current.contentWidth,300) && equal(CSTabBarPreferences.current.scale,.75));
    for (id invalid in @[@0,@175,@1025,@(NAN),@"300",@[@300]]) {
        [isolated setObject:invalid forKey:kTabBarContentWidthKey];[CSTabBarPreferences reload];
        StructureCheck(equal(CSTabBarPreferences.current.contentWidth,0) && equal(CSTabBarPreferences.current.scale,.75));
    }
    if (savedWidth) [isolated setObject:savedWidth forKey:kTabBarContentWidthKey];
    else [isolated removeObjectForKey:kTabBarContentWidthKey];
    if (savedScale) [isolated setObject:savedScale forKey:kTabBarScaleKey];
    else [isolated removeObjectForKey:kTabBarScaleKey];
    [CSTabBarPreferences reload];
}
static void TestTabBarFunctionSizePreferences(void) {
    id savedSize=[isolated objectForKey:kTabBarFunctionSizeKey];
    for (NSArray *sample in @[@[@44,@44],@[@52,@52],@[@72,@72],@[@80,@80],@[@81,@80],
            @[@0,@44],@[@(NAN),@52],@[@(INFINITY),@52],@[@"80",@52]]) {
        [isolated setObject:sample[0] forKey:kTabBarFunctionSizeKey];
        [CSTabBarPreferences reload];
        StructureCheck(equal(CSTabBarPreferences.current.functionSize,[sample[1] doubleValue]));
    }
    if (savedSize) [isolated setObject:savedSize forKey:kTabBarFunctionSizeKey];
    else [isolated removeObjectForKey:kTabBarFunctionSizeKey];
    [CSTabBarPreferences reload];
}
static void CheckAbsoluteTabFrames(MMTabBar *bar,NSArray *buttons,BOOL rtl) {
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    CSTabBarRect total=CSTabBarFloatingRectWithWidth(bar.bounds.size.width,bar.bounds.size.height,p.scale,p.contentHeight,p.lift,p.contentWidth);
    CSTabBarLayout layout=CSTabBarLayoutMake(total,p.structure,p.functionGap,p.functionSize,p.centerButtonScale,rtl,bar.bounds.size.width);
    for (NSUInteger i=0;i<4;i++) {
        CGRect actual=[buttons[i] convertRect:[buttons[i] bounds] toView:bar];
        CSTabBarRect expected=CSTabBarLayoutItemRect(layout,(unsigned)i,4,rtl);
        StructureCheck(equal(actual.origin.x,expected.x) && equal(actual.origin.y,expected.y) && equal(actual.size.width,expected.width) && equal(actual.size.height,expected.height));
    }
    if (layout.actionRect.width>0) {
        BOOL handled=NO;
        CGPoint center=CGPointMake(layout.actionRect.x+layout.actionRect.width/2,layout.actionRect.y+layout.actionRect.height/2);
        UIView *hit=CSTabBarHitTest(bar,center,nil,&handled);
        StructureCheck(handled && [hit.accessibilityIdentifier isEqual:@"cs.tabbar.function"]);
    }
}
static MMMainTabBarItemView *StructureModernButton(MMTabbarItem *model,NSUInteger index) {
    MMMainTabBarItemView *button=[[MMMainTabBarItemView alloc] initWithFrame:CGRectMake(index*97.5,0,97.5,49)];
    MMTabBarItemView *item=[[MMTabBarItemView alloc] initWithFrame:button.bounds];item.item=model;
    item.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(36,4,25,25)];[item addSubview:item.imageView];
    item.textLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,32,97.5,12)];[item addSubview:item.textLabel];
    item.badgeView=[[UIView alloc] initWithFrame:CGRectMake(57,1,16,16)];[item addSubview:item.badgeView];
    button.itemView=item;button.legacyItem=model;[button addSubview:item];return button;
}
static void ExerciseTabBarStructures(id controller,MMTabBar *bar,NSArray *items,NSArray *buttons,BOOL modern) {
    CGRect nativeFirst=[buttons[0] frame];
    [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
    nativeFirst=[buttons[0] frame];
    [isolated setBool:YES forKey:kTabBarStyleEnabledKey];
    [isolated removeObjectForKey:kTabBarContentWidthKey];
    [isolated setBool:YES forKey:kTabBarSwipeSwitchKey];
    [isolated setInteger:3 forKey:kTabBarClickEffectKey];
    [isolated setInteger:0 forKey:kTabBarHapticFeedbackKey];
    [isolated setObject:@"global_search" forKey:kTabBarFunctionActionKey];
    [isolated setDouble:24 forKey:kTabBarFunctionGapKey];
    [isolated setDouble:80 forKey:kTabBarFunctionSizeKey];
    [isolated setDouble:1.8 forKey:kTabBarCenterButtonScaleKey];
    [isolated setDouble:.9 forKey:kTabBarScaleKey];
    [isolated setDouble:44 forKey:kTabBarContentHeightKey];
    [isolated setDouble:0 forKey:kTabBarPositionOffsetKey];
    [isolated setInteger:CSTabBarStructureSeparated forKey:kTabBarStructureKey];
    [isolated setDouble:12 forKey:kTabBarFunctionGapKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
    double baselineMainWidth=[buttons[0] bounds].size.width*4;
    [isolated setDouble:32 forKey:kTabBarFunctionGapKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
    StructureCheck(equal([buttons[0] bounds].size.width*4,baselineMainWidth));
    [isolated setDouble:24 forKey:kTabBarFunctionGapKey];
    for (NSNumber *structure in @[@1,@2]) for (NSNumber *rtlValue in @[@NO,@YES]) {
        BOOL rtl=rtlValue.boolValue;
        bar.effectiveUserInterfaceLayoutDirection=rtl ? UIUserInterfaceLayoutDirectionRightToLeft : UIUserInterfaceLayoutDirectionLeftToRight;
        [isolated setInteger:structure.integerValue forKey:kTabBarStructureKey];
        [CSTabBarPreferences reload];CSTabBarUpdate(bar);
        CSTabBarPreferences *p=CSTabBarPreferences.current;
        CSTabBarRect total=CSTabBarFloatingRectWithWidth(bar.bounds.size.width,bar.bounds.size.height,p.scale,p.contentHeight,p.lift,p.contentWidth);
        CSTabBarLayout layout=CSTabBarLayoutMake(total,p.structure,p.functionGap,p.functionSize,p.centerButtonScale,rtl,CGRectGetWidth(bar.bounds));
        CGRect action=CGRectMake(layout.actionRect.x,layout.actionRect.y,layout.actionRect.width,layout.actionRect.height);
        CGPoint actionCenter=CGPointMake(CGRectGetMidX(action),CGRectGetMidY(action));
        BOOL handled=NO;
        UIControl *function=(id)CSTabBarHitTest(bar,actionCenter,nil,&handled);
        StructureCheck(handled && function && [function isKindOfClass:UIControl.class] && ![buttons containsObject:function]);
        StructureCheck(CGRectEqualToRect(function.frame,action) && [function.accessibilityLabel isEqual:@"global_search"]);
        StructureCheck([function.accessibilityIdentifier isEqual:@"cs.tabbar.function"] && function.accessibilityTraits==UIAccessibilityTraitButton);
        StructureCheck(bar.subviews.lastObject==function);
        if (p.structure==CSTabBarStructureSeparated) {
            StructureCheck(equal(p.functionSize,80) && equal(action.size.width,80) && equal(action.size.height,80));
            StructureCheck(equal(layout.mainRect.height,44) && equal(CGRectGetMaxY(action),bar.bounds.size.height));
            // A tall independent key stays clickable above and below the shorter main surface.
            CGPoint upper=CGPointMake(actionCenter.x,CGRectGetMinY(action)+1);
            CGPoint lower=CGPointMake(actionCenter.x,CGRectGetMaxY(action)-1);
            StructureCheck(upper.y<layout.mainRect.y && lower.y>layout.mainRect.y+layout.mainRect.height);
            StructureCheck(CSTabBarHitTest(bar,upper,nil,&handled)==function && handled);
            StructureCheck(CSTabBarHitTest(bar,lower,nil,&handled)==function && handled);
        }
        if (p.structure==CSTabBarStructureCentered) {
            StructureCheck(equal(p.centerButtonScale,1.8) && action.size.height>layout.mainRect.height);
            StructureCheck(CGRectGetMinY(action)<layout.mainRect.y && equal(CGRectGetMaxY(action),bar.bounds.size.height));
            StructureCheck(function.layer.shadowOpacity>0 && function.layer.shadowRadius==8 && function.layer.shadowPath);
            for (UIView *child in function.subviews) if ([child isKindOfClass:UIImageView.class]) StructureCheck(child.frame.size.width>30);
            // The overlapping 8pt edge still belongs to the raised key, even
            // though a native page control and tracking control also cover it.
            CGPoint overlap=CGPointMake(action.origin.x+4,actionCenter.y);
            StructureCheck(CSTabBarHitTest(bar,overlap,nil,&handled)==function && handled);
            NSUInteger oldIndex=[controller selectedIndex];
            CSTabBarTouchBegin(bar,overlap);CSTabBarTouchEnd(bar,overlap);
            StructureCheck([controller selectedIndex]==oldIndex);
        }
        NSUInteger actionCount=functionActionCount, selected=[controller selectedIndex];
        [function sendActionsForControlEvents:UIControlEventTouchUpInside];
        StructureCheck(functionActionCount==actionCount+1 && [lastFunctionAction isEqual:@"global_search"] && lastFunctionSource==controller);
        StructureCheck([controller selectedIndex]==selected);
        CSTabBarTouchBegin(bar,actionCenter);CSTabBarTouchEnd(bar,actionCenter);
        StructureCheck(functionActionCount==actionCount+1 && [controller selectedIndex]==selected);
        for (NSUInteger i=0;i<4;i++) {
            CGRect actual=[buttons[i] convertRect:[buttons[i] bounds] toView:bar];
            CSTabBarRect expected=CSTabBarLayoutItemRect(layout,(unsigned)i,4,rtl);
            StructureCheck(equal(actual.origin.x,expected.x) && equal(actual.origin.y,expected.y) && equal(actual.size.width,expected.width));
            CGRect intersection=CGRectIntersection(actual,action);
            if (p.structure==CSTabBarStructureCentered && (i==1 || i==2)) StructureCheck(equal(CGRectGetWidth(intersection),8));
            else StructureCheck(!CGRectIntersectsRect(actual,action));
            CGRect iconRect=[[items[i] imageView] convertRect:[[items[i] imageView] bounds] toView:bar];
            StructureCheck(!CGRectIntersectsRect(iconRect,action));
        }
        if (p.structure==CSTabBarStructureSeparated) {
            double mainEdge=rtl ? layout.mainRect.x : layout.mainRect.x+layout.mainRect.width;
            double actionEdge=rtl ? layout.actionRect.x+layout.actionRect.width : layout.actionRect.x;
            CGPoint gap=CGPointMake((mainEdge+actionEdge)/2,actionCenter.y);
            StructureCheck(CSTabBarHitTest(bar,gap,nil,&handled)==nil && handled);
            // Even within the old 4pt tab touch slop, the gap is not a page target.
            CGPoint edge=CGPointMake(mainEdge+(rtl?-2:2),actionCenter.y);
            CGPoint origin=ButtonCenter(buttons,0);UIControl *tracking=TouchControlAt(bar,origin);
            SendTouch(tracking,UIControlEventTouchDown,bar,origin);
            SendTouch(tracking,UIControlEventTouchDragInside,bar,edge);
            SendTouch(tracking,UIControlEventTouchUpInside,bar,edge);
            StructureCheck([controller selectedIndex]==selected && functionActionCount==actionCount+1);
        }
        // A native tab drag ending over the function slot neither switches tabs nor invokes the action.
        CGPoint first=ButtonCenter(buttons,0);UIControl *touch=TouchControlAt(bar,first);
        StructureCheck(touch!=nil);
        SendTouch(touch,UIControlEventTouchDown,bar,first);
        SendTouch(touch,UIControlEventTouchDragInside,bar,actionCenter);
        SendTouch(touch,UIControlEventTouchUpInside,bar,actionCenter);
        StructureCheck([controller selectedIndex]==selected && functionActionCount==actionCount+1);
        UIView *raw;
        if (modern) {
            WCTabBarView *copy=[[WCTabBarView alloc] initWithFrame:bar.frame];
            NSMutableArray *copyButtons=[NSMutableArray array];
            for (NSUInteger i=0;i<4;i++) {
                MMMainTabBarItemView *button=StructureModernButton([items[i] item],i);[copy addSubview:button];[copyButtons addObject:button];
            }
            copy.items=bar.items;copy.itemViews=copyButtons;raw=copy;
        } else {
            raw=[[UIView alloc] initWithFrame:bar.frame];
            for (UIView *item in items) {[raw addSubview:[[UIImageView alloc] initWithFrame:item.frame]];}
        }
        UIView *snapshot=CSTabBarStyleSnapshot(bar,raw);
        BOOL sawFunction=NO;
        for (UIView *child in snapshot.subviews) if ([child isKindOfClass:UIControl.class] && CGRectEqualToRect(child.frame,action) && [child.accessibilityLabel isEqual:@"global_search"]) {
            sawFunction=YES;StructureCheck(!child.userInteractionEnabled);
            [(UIControl *)child sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        StructureCheck(sawFunction && functionActionCount==actionCount+1);
        bar.hidden=YES;
        [function sendActionsForControlEvents:UIControlEventTouchUpInside];
        StructureCheck(functionActionCount==actionCount+1);
        bar.hidden=NO;
        [isolated setInteger:0 forKey:kTabBarStructureKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        StructureCheck(function.superview==nil);
        [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        StructureCheck(CGRectEqualToRect([buttons[0] frame],nativeFirst));
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey];
    }
    // Narrow hosts reduce overlap to protect the native icon area while the
    // raised function key still receives hits before the underlying controls.
    CGRect originalBarFrame=bar.frame;
    [isolated setInteger:CSTabBarStructureCentered forKey:kTabBarStructureKey];
    [isolated setDouble:.6 forKey:kTabBarScaleKey];
    [isolated setDouble:1.8 forKey:kTabBarCenterButtonScaleKey];
    for (NSNumber *hostWidth in @[@216,@320]) for (NSNumber *direction in @[@NO,@YES]) {
        CGRect narrow=originalBarFrame;narrow.size.width=hostWidth.doubleValue;bar.frame=narrow;
        bar.effectiveUserInterfaceLayoutDirection=direction.boolValue ? UIUserInterfaceLayoutDirectionRightToLeft : UIUserInterfaceLayoutDirectionLeftToRight;
        [CSTabBarPreferences reload];CSTabBarUpdate(bar);
        CSTabBarPreferences *p=CSTabBarPreferences.current;
        StructureCheck(equal(p.centerButtonScale,1.8));
        CSTabBarRect total=CSTabBarFloatingRectWithWidth(bar.bounds.size.width,bar.bounds.size.height,p.scale,p.contentHeight,p.lift,p.contentWidth);
        CSTabBarLayout layout=CSTabBarLayoutMake(total,p.structure,p.functionGap,p.functionSize,p.centerButtonScale,direction.boolValue,bar.bounds.size.width);
        CGRect action=CGRectMake(layout.actionRect.x,layout.actionRect.y,layout.actionRect.width,layout.actionRect.height);
        for (NSUInteger i=0;i<4;i++) {
            CGRect icon=[[items[i] imageView] convertRect:[[items[i] imageView] bounds] toView:bar];
            StructureCheck(!CGRectIntersectsRect(icon,action));
        }
        BOOL handled=NO;
        UIControl *function=(id)CSTabBarHitTest(bar,CGPointMake(CGRectGetMidX(action),CGRectGetMidY(action)),nil,&handled);
        StructureCheck(handled && [function.accessibilityIdentifier isEqual:@"cs.tabbar.function"] && bar.subviews.lastObject==function);
    }
    bar.frame=originalBarFrame;
    // Point widths override scale without overwriting it, work across all
    // structures/directions, and can be cleared back to the legacy geometry.
    [isolated setDouble:52 forKey:kTabBarContentHeightKey];
    [isolated setDouble:14 forKey:kTabBarPositionOffsetKey];
    [isolated setDouble:12 forKey:kTabBarFunctionGapKey];
    [isolated setDouble:52 forKey:kTabBarFunctionSizeKey];
    [isolated setDouble:1 forKey:kTabBarCenterButtonScaleKey];
    for (NSNumber *structure in @[@0,@1,@2]) for (NSNumber *direction in @[@NO,@YES]) {
        BOOL rtl=direction.boolValue;
        bar.effectiveUserInterfaceLayoutDirection=rtl ? UIUserInterfaceLayoutDirectionRightToLeft : UIUserInterfaceLayoutDirectionLeftToRight;
        [isolated setInteger:structure.integerValue forKey:kTabBarStructureKey];
        [isolated setDouble:.6 forKey:kTabBarScaleKey];
        [isolated setDouble:300 forKey:kTabBarContentWidthKey];
        [isolated setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        StructureCheck(equal(CSTabBarPreferences.current.contentWidth,300));
        CheckAbsoluteTabFrames(bar,buttons,rtl);
        CGRect fixedFrames[4];for (NSUInteger i=0;i<4;i++) fixedFrames[i]=[buttons[i] frame];
        [isolated setDouble:1 forKey:kTabBarScaleKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        for (NSUInteger i=0;i<4;i++) StructureCheck(CGRectEqualToRect(fixedFrames[i],[buttons[i] frame]));
        [isolated setDouble:320 forKey:kTabBarContentWidthKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        CheckAbsoluteTabFrames(bar,buttons,rtl);
        StructureCheck([buttons[0] bounds].size.width>fixedFrames[0].size.width);
        [isolated setDouble:1024 forKey:kTabBarContentWidthKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        CheckAbsoluteTabFrames(bar,buttons,rtl);
        for (UIView *button in buttons) {
            CGRect frame=[button convertRect:button.bounds toView:bar];
            StructureCheck(frame.origin.x>=0 && CGRectGetMaxX(frame)<=bar.bounds.size.width);
        }
        [isolated setDouble:0 forKey:kTabBarContentWidthKey];
        [isolated setDouble:.6 forKey:kTabBarScaleKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        CSTabBarPreferences *p=CSTabBarPreferences.current;
        CSTabBarRect legacy=CSTabBarFloatingRect(bar.bounds.size.width,bar.bounds.size.height,p.scale,p.contentHeight,p.lift);
        CSTabBarRect cleared=CSTabBarFloatingRectWithWidth(bar.bounds.size.width,bar.bounds.size.height,p.scale,p.contentHeight,p.lift,p.contentWidth);
        StructureCheck(equal(p.contentWidth,0) && equal(legacy.x,cleared.x) && equal(legacy.width,cleared.width) && equal(legacy.y,cleared.y));
        CheckAbsoluteTabFrames(bar,buttons,rtl);
        // Existing point widths remain untouched while read. An explicit percentage
        // edit writes scale and removes that override, preserving the configured height.
        for (NSNumber *scale in @[@.6,@.8,@1]) {
            [isolated setDouble:300 forKey:kTabBarContentWidthKey];
            [isolated setDouble:scale.doubleValue forKey:kTabBarScaleKey];
            [CSTabBarPreferences reload];CSTabBarUpdate(bar);
            StructureCheck(equal(CSTabBarPreferences.current.contentWidth,300));
            for (NSUInteger i=0;i<4;i++) StructureCheck(CGRectEqualToRect(fixedFrames[i],[buttons[i] frame]));
            [isolated removeObjectForKey:kTabBarContentWidthKey];
            [CSTabBarPreferences reload];CSTabBarUpdate(bar);
            p=CSTabBarPreferences.current;
            StructureCheck([isolated objectForKey:kTabBarContentWidthKey]==nil);
            StructureCheck(equal(p.contentWidth,0) && equal(p.scale,scale.doubleValue) && equal(p.contentHeight,52));
            CheckAbsoluteTabFrames(bar,buttons,rtl);
            CGRect occupied=[[buttons firstObject] convertRect:[[buttons firstObject] bounds] toView:bar];
            for (UIView *button in buttons) occupied=CGRectUnion(occupied,[button convertRect:button.bounds toView:bar]);
            for (UIView *child in bar.subviews) if ([child.accessibilityIdentifier isEqual:@"cs.tabbar.function"])
                occupied=CGRectUnion(occupied,child.frame);
            StructureCheck(equal(occupied.size.width,bar.bounds.size.width*scale.doubleValue));
        }
        [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
        StructureCheck(CGRectEqualToRect([buttons[0] frame],nativeFirst));
    }
    bar.effectiveUserInterfaceLayoutDirection=UIUserInterfaceLayoutDirectionLeftToRight;
}
static void TestTabBarStructures(MainTabBarViewController *controller,MMTabBar *bar,NSArray *items,NSArray *buttons,NSString *suite) {
    NSDictionary *saved=[isolated persistentDomainForName:suite];
    NSUInteger selected=controller.selectedIndex;
    TestTabBarWidthPreferences();
    TestTabBarFunctionSizePreferences();
    ExerciseTabBarStructures(controller,bar,items,buttons,NO);
    UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];
    UIView *root=[[UIView alloc] initWithFrame:window.bounds];[window addSubview:root];
    WCTabBarView *modern=[[WCTabBarView alloc] initWithFrame:CGRectMake(0,761,390,83)];[root addSubview:modern];
    modern.backgroundContentView=[[UIView alloc] initWithFrame:modern.bounds];[modern addSubview:modern.backgroundContentView];
    NewMainTabBarViewController *owner=[NewMainTabBarViewController new];owner.view=root;owner.tabBarView=modern;modern.visibilityDelegate=owner;
    NSMutableArray *models=[NSMutableArray array],*modernItems=[NSMutableArray array],*modernButtons=[NSMutableArray array];
    for (NSUInteger i=0;i<4;i++) {
        MMTabbarItem *model=[MMTabbarItem new];model.index=i;[models addObject:model];
        MMMainTabBarItemView *button=StructureModernButton(model,i);
        [button addTarget:owner action:@selector(nativeClick:) forControlEvents:UIControlEventTouchUpInside];
        [modern addSubview:button];[modernButtons addObject:button];[modernItems addObject:button.itemView];
    }
    modern.items=models;modern.itemViews=modernButtons;
    ExerciseTabBarStructures(owner,(id)modern,modernItems,modernButtons,YES);
    controller.selectedIndex=selected;
    [isolated setPersistentDomain:saved forName:suite];RefreshClickPreferences();
    NSLog(@"tabbar structure lifecycle: PASS (%lu checks)",(unsigned long)structureChecks);
}
#undef StructureCheck
