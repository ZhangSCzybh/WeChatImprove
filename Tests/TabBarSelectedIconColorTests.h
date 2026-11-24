@interface CSTabBarTestTraitColor : UIColor @end
@implementation CSTabBarTestTraitColor
- (UIColor *)resolvedColorWithTraitCollection:(UITraitCollection *)traits {
    return [UIColor colorWithRed:traits.userInterfaceStyle==UIUserInterfaceStyleDark ? .8 : .2 green:.3 blue:.4 alpha:.7];
}
@end

static void TestSelectedIconColor(MMTabBar *bar,NSArray<MMTabBarItemView *> *items,NSString *imagePath) {
    MMTabBarItemView *item=items[0], *other=items[1];
    UIImage *native=item.imageView.image;
    assert(CSTabBarPreferences.current.selectedIconColor==nil);
    assert([isolated objectForKey:kTabBarSelectedIconColorAlphaKey]==nil);
    [isolated setDouble:.3 forKey:kTabBarSelectedIconColorRedKey];
    [isolated setDouble:.5 forKey:kTabBarSelectedIconColorGreenKey];
    [isolated setDouble:.7 forKey:kTabBarSelectedIconColorBlueKey];
    [isolated setDouble:.6 forKey:kTabBarSelectedIconColorAlphaKey];
    [CSTabBarPreferences reload];
    UIColor *color=CSTabBarPreferences.current.selectedIconColor;
    assert(equal(color.red,.3) && equal(color.green,.5) && equal(color.blue,.7) && equal(color.alpha,.6));
    CSTabBarUpdate(bar);
    assert(item.imageView.image==native && other.imageView.image.appliedTint==nil);
    CSTabBarBeginItemUpdate(item);item.isSelected=YES;CSTabBarEndItemUpdate(item);
    UIImage *tinted=item.imageView.image;
    assert(tinted.sourceImage==native && tinted.appliedTint==color && other.imageView.image.appliedTint==nil);
    for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
    assert(item.imageView.image==tinted);
    CSTabBarBeginItemUpdate(item);item.isSelected=NO;CSTabBarEndItemUpdate(item);
    assert(item.imageView.image==native);
    CSTabBarBeginItemUpdate(item);item.isSelected=YES;CSTabBarEndItemUpdate(item);

    // A normal upload is also the selected fallback. Neither it nor an explicit
    // selected upload can be recolored by the native-only setting.
    [isolated setObject:imagePath forKey:kTabBarIconChatKey];
    [CSTabBarPreferences reload];CSTabBarUpdate(bar);
    UIImage *uploaded=[CSTabBarPreferences.current iconAtIndex:0 selected:YES];
    assert(uploaded && item.imageView.image==uploaded && uploaded.appliedTint==nil);
    [isolated setObject:[imagePath stringByAppendingString:@".missing"] forKey:kTabBarIconSelectedChatKey];
    [CSTabBarPreferences reload];CSTabBarUpdate(bar);
    assert(item.imageView.image==uploaded && uploaded.appliedTint==nil);
    [isolated setObject:imagePath forKey:kTabBarIconSelectedChatKey];
    [CSTabBarPreferences reload];CSTabBarUpdate(bar);
    assert(item.imageView.image==[CSTabBarPreferences.current iconAtIndex:0 selected:YES] && item.imageView.image.appliedTint==nil);
    [isolated removeObjectForKey:kTabBarIconChatKey];[isolated removeObjectForKey:kTabBarIconSelectedChatKey];
    [CSTabBarPreferences reload];CSTabBarUpdate(bar);
    assert(item.imageView.image.sourceImage==native && item.imageView.image.appliedTint!=nil);

    // The item cache must resolve trait-dependent colors again even when the
    // preference object, native image, selected state and geometry are unchanged.
    CSTabBarPreferences.current.selectedIconColor=[CSTabBarTestTraitColor new];
    CSTabBarInvalidateItemAppearance(item);
    bar.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;CSTabBarUpdate(bar);
    assert(equal(item.imageView.image.appliedTint.red,.2));
    bar.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;CSTabBarUpdate(bar);
    assert(equal(item.imageView.image.appliedTint.red,.8));
    bar.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;CSTabBarUpdate(bar);
    assert(equal(item.imageView.image.appliedTint.red,.2));

    // 8.0.80 may draw the icon in a native view. Replace only its rendered icon,
    // never the native view or the badge, and restore both original visibilities.
    UIView *drawn=[[UIView alloc] initWithFrame:CGRectMake(36,4,24,26)];
    UIView *barHost=bar.superview;
    CSTabBarBeginItemUpdate(item);
    item.customIconView=drawn;[item addSubview:drawn];item.imageView.hidden=YES;
    [bar removeFromSuperview];
    CSTabBarEndItemUpdate(item);
    assert(!drawn.hidden && item.imageView.hidden && item.imageView.image==native);
    for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
    assert(!drawn.hidden && item.imageView.image==native);
    // Attachment alone makes the same source renderable. No preference reload
    // or native image-reload callback is needed to retry the previous fallback.
    [barHost addSubview:bar];CSTabBarUpdate(bar);
    UIImage *drawnTint=item.imageView.image;
    assert(drawn.hidden && !item.imageView.hidden && drawnTint.appliedTint);
    assert(item.imageView.contentMode==UIViewContentModeScaleAspectFit);
    assert(CGSizeEqualToSize(drawnTint.sourceImage.renderedSize,CGSizeMake(24,26)));
    for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
    assert(item.imageView.image==drawnTint && item.customIconView==drawn);
    // Native sizing can arrive after initial layout, while the item itself and
    // its selected state remain unchanged. Preserve that update before restoring.
    CGRect itemBounds=item.bounds;
    CSTabBarBeginItemUpdate(item);drawn.frame=CGRectMake(36,4,0,0);CSTabBarEndItemUpdate(item);
    assert(!drawn.hidden && item.imageView.hidden && item.imageView.image==native);
    for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
    assert(!drawn.hidden && CGSizeEqualToSize(drawn.bounds.size,CGSizeZero));
    drawn.frame=CGRectMake(36,4,18,22);CSTabBarUpdate(bar);
    assert(CGRectEqualToRect(item.bounds,itemBounds) && drawn.hidden && !item.imageView.hidden);
    assert(CGSizeEqualToSize(item.imageView.image.sourceImage.renderedSize,CGSizeMake(18,22)));
    UIImage *lateSizedTint=item.imageView.image;
    for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
    assert(item.imageView.image==lateSizedTint);
    drawn.bounds=CGRectMake(0,0,21,23);CSTabBarUpdate(bar);
    assert(CGRectEqualToRect(item.bounds,itemBounds) && item.imageView.image!=lateSizedTint);
    assert(CGSizeEqualToSize(item.imageView.image.sourceImage.renderedSize,CGSizeMake(21,23)));
    drawnTint=item.imageView.image;
    for (NSUInteger i=0;i<20;i++) CSTabBarUpdate(bar);
    assert(item.imageView.image==drawnTint);
    drawn.alpha=0;CSTabBarUpdate(bar);
    assert(!drawn.hidden && item.imageView.hidden && item.imageView.image==native);
    drawn.alpha=1;CSTabBarUpdate(bar);
    assert(drawn.hidden && !item.imageView.hidden && item.imageView.image.appliedTint);
    drawnTint=item.imageView.image;
    CSTabBarBeginItemUpdate(item);CSTabBarInvalidateItemAppearance(item);CSTabBarEndItemUpdate(item);
    assert(item.imageView.image!=drawnTint && item.imageView.image.appliedTint);
    [isolated setBool:NO forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
    assert(!drawn.hidden && item.imageView.hidden && item.imageView.image==native);
    [isolated setBool:YES forKey:kTabBarStyleEnabledKey];[CSTabBarPreferences reload];CSTabBarUpdate(bar);
    assert(drawn.hidden && !item.imageView.hidden);

    // Restoring native default removes every component. The current native dark
    // artwork survives exactly, and no baked-in default color is persisted.
    for (NSString *key in @[kTabBarSelectedIconColorRedKey,kTabBarSelectedIconColorGreenKey,kTabBarSelectedIconColorBlueKey,kTabBarSelectedIconColorAlphaKey]) [isolated removeObjectForKey:key];
    [CSTabBarPreferences reload];CSTabBarUpdate(bar);
    assert(CSTabBarPreferences.current.selectedIconColor==nil && !drawn.hidden && item.imageView.hidden && item.imageView.image==native);
    CSTabBarBeginItemUpdate(item);
    [drawn removeFromSuperview];item.customIconView=nil;item.imageView.hidden=NO;
    UIImage *nativeDark=[UIImage new];item.imageView.image=nativeDark;
    CSTabBarInvalidateItemAppearance(item);CSTabBarEndItemUpdate(item);
    bar.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;CSTabBarUpdate(bar);
    assert(item.imageView.image==nativeDark && !item.imageView.image.appliedTint);
    CSTabBarBeginItemUpdate(item);item.isSelected=NO;item.imageView.image=native;CSTabBarInvalidateItemAppearance(item);CSTabBarEndItemUpdate(item);
    bar.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;CSTabBarUpdate(bar);
    NSLog(@"tabbar selected icon color/native restore: PASS");
}
