static WESessionTabContainerView *MakeContainer(void) {
    WESessionTabContainerView *v=[WESessionTabContainerView new];
    v.frame=CGRectMake(0,0,375,52);
    v.baseFontSize=15;
    v.window=[UIView new];
    v.scrollView=[UIScrollView new];
    v.searchButton=[UIButton new]; v.searchButton.hidden=YES;
    v.indicatorView=[UIView new];
    v.tabButtons=[NSMutableArray new];
    for (NSString *title in @[@"全部",@"群聊",@"自定义较长标题",@"私聊"]) {
        WETabButton *b=[WETabButton new]; b.currentTitle=title;
        b.tabID=[NSString stringWithFormat:@"tab%lu",(unsigned long)v.tabButtons.count]; b.tabIndex=v.tabButtons.count;
        [v.tabButtons addObject:b];
    }
    v.selectedIndex=0;
    v.selectedTabID=@"tab0";
    [v updateSelectedButtons];
    return v;
}
static void Layout(WESessionTabContainerView *v) {
    [v layoutSubviews];
    for (WETabButton *b in v.tabButtons) [b layoutSubviews];
}
static CGFloat ExpectedBadgeWidth(WETabButton *b) {
    if (b.unreadBadge.hidden) return 0;
    if (!b.unreadCount) return 7;
    return MAX(MAX(14,ceil(b.unreadBadge.font.pointSize*1.2)+2),ceil(b.unreadBadge.text.length*b.unreadBadge.font.pointSize*.6)+6);
}
static void CheckGeometry(WESessionTabContainerView *v,NSString *context) {
    CGFloat viewport=v.scrollView.bounds.size.width;
    CGFloat total=0;
    for (WETabButton *b in v.tabButtons) total+=MAX(60,ceil(b.currentTitle.length*b.titleLabel.font.pointSize*.6)+32+(b.unreadBadge.hidden ? 0 : ExpectedBadgeWidth(b)+3));
    CGFloat spacing=MAX(8,(viewport-total)/(v.tabButtons.count+1));
    CGFloat x=spacing;
    for (WETabButton *b in v.tabButtons) {
        CGFloat width=MAX(60,ceil(b.currentTitle.length*b.titleLabel.font.pointSize*.6)+32+(b.unreadBadge.hidden ? 0 : ExpectedBadgeWidth(b)+3));
        Check(CGRectEqualToRect(b.frame,CGRectMake(x,0,width,v.scrollView.bounds.size.height)),[context stringByAppendingString:@" button frame"]);
        CGFloat trailing=b.unreadBadge.hidden ? 0 : ExpectedBadgeWidth(b)+3;
        CGFloat available=width-16-trailing;
        CGFloat tw=MIN(MAX(0,available),ceil(b.currentTitle.length*b.titleLabel.font.pointSize*.6));
        CGFloat th=ceil(b.titleLabel.font.pointSize*1.2);
        CGRect expected=CGRectMake(8+available/2-tw/2,v.scrollView.bounds.size.height/2-th/2,tw,th);
        Check(CGRectEqualToRect(b.titleLabel.frame,expected),[context stringByAppendingString:@" title frame"]);
        x+=width+spacing;
    }
    Check(CGSizeEqualToSize(v.scrollView.contentSize,CGSizeMake(MAX(viewport,x),v.scrollView.bounds.size.height)),[context stringByAppendingString:@" content size"]);
}

int main(void) {
    @autoreleasepool {
        WESessionTabContainerView *v=MakeContainer();
        Layout(v); Layout(v);
        CheckGeometry(v,@"initial");
        ResetCounters();
        for (NSUInteger i=0;i<1000;i++) { Layout(v); [v selectTabAtIndex:0 animated:NO]; [v updateSelectedButtons]; }
        Check(Writes==0,@"1000 stable layouts/selection acknowledgements produce no visual/layer writes");
        Check(Measurements==0,@"1000 stable layouts reuse title measurements");
        Check(SynchronousLayouts==0,@"1000 stable selection acknowledgements do not force synchronous layout");
        NSUInteger stableWrites=Writes,stableMeasures=Measurements,stableSync=SynchronousLayouts;

        v.frame=CGRectMake(0,0,280,64); ResetCounters(); Layout(v);
        CheckGeometry(v,@"viewport resize");
        Check(Writes>0 && Measurements==0,@"resize changes geometry and reuses text metrics");
        v.safeAreaInsets=UIEdgeInsetsMake(0,20,0,10); Layout(v);
        Check(CGRectEqualToRect(v.scrollView.frame,CGRectMake(20,0,250,64)),@"safe area changes scroll origin and width");
        CheckGeometry(v,@"safe area");
        [v applyAppearanceWithFontSize:20 showsSearchButton:YES]; Layout(v);
        Check(CGRectEqualToRect(v.scrollView.frame,CGRectMake(20,0,206,64)),@"search button width updates viewport");
        CheckGeometry(v,@"font and search change");
        ResetCounters(); [v applyAppearanceWithFontSize:20 showsSearchButton:YES];
        Check(Writes==0 && Invalidations==0,@"identical appearance does not invalidate layout");

        v.traitCollection.fontScale=1.5;
        for (WETabButton *b in v.tabButtons) b.traitCollection.fontScale=1.5;
        [v traitCollectionDidChange:nil]; ResetCounters(); Layout(v);
        Check(Measurements>0,@"trait-dependent font change invalidates text metric cache");
        Check(v.tabButtons[0].titleLabel.font.pointSize==30,@"dynamic type scaled font applied");
        CheckGeometry(v,@"dynamic type");
        ResetCounters(); for (WETabButton *b in v.tabButtons) [b updateFonts];
        Check(Writes==0 && Invalidations==0,@"equal font objects do not invalidate button layout");

        v=MakeContainer(); Layout(v);
        [v updateUnreadCount:1 hasRedDot:NO forTabIndex:0]; Layout(v);
        CheckGeometry(v,@"badge reveal");
        [v updateUnreadCount:100 hasRedDot:NO forTabIndex:0]; Layout(v); Layout(v);
        CGRect badge100=v.tabButtons[0].unreadBadge.frame;
        ResetCounters(); [v updateUnreadCount:101 hasRedDot:NO forTabIndex:0];
        Check(Invalidations==0,@"99+ to 99+ changes accessibility only and does not invalidate geometry");
        Check([v.tabButtons[0].accessibilityValue isEqualToString:@"101 条未读消息"],@"capped badge retains full accessibility count");
        ResetCounters(); Layout(v);
        Check(Writes==0 && Measurements==0,@"same-width capped badge does not remeasure or write geometry");
        Check(CGRectEqualToRect(v.tabButtons[0].unreadBadge.frame,badge100),@"capped badge frame retained");
        [v updateUnreadCount:0 hasRedDot:YES forTabIndex:0]; Layout(v);
        CheckGeometry(v,@"red dot");
        Check(v.tabButtons[0].unreadBadge.frame.size.width==7,@"red dot width is seven points");
        [v updateUnreadCount:0 hasRedDot:NO forTabIndex:0]; Layout(v);
        CheckGeometry(v,@"badge hide");

        NSMutableArray *items=[NSMutableArray new];
        for (WETabButton *b in v.tabButtons) {
            WESessionTabItem *item=[WESessionTabItem new]; item.tabId=b.tabID; item.displayName=b.currentTitle;
            item.type=b.tabIndex==0 ? WETabTypeAll : WETabTypeCustom; [items addObject:item];
        }
        [v updateTabs:items]; Layout(v);
        ResetCounters(); [v updateTabs:items]; Layout(v);
        Check(Writes==0 && Measurements==0,@"unchanged tab records preserve layout and measurements");
        WETabButton *original=v.tabButtons[0];
        ((WESessionTabItem *)items[0]).displayName=@"重新命名后的更长分组名称";
        ResetCounters(); [v updateTabs:items]; Layout(v);
        Check(Measurements>0,@"rename invalidates text metrics");
        CheckGeometry(v,@"rename");
        [items exchangeObjectAtIndex:0 withObjectAtIndex:3];
        [v updateTabs:items]; Layout(v);
        Check(v.tabButtons[3]==original && v.selectedIndex==3 && [v.selectedTabID isEqualToString:original.tabID],@"reorder reuses buttons and preserves stable selection");
        CheckGeometry(v,@"reorder");
        [items removeObjectAtIndex:3]; [v updateTabs:items]; Layout(v);
        Check(v.selectedIndex==0,@"removing selected tab falls back to first surviving tab");
        CheckGeometry(v,@"remove selected");

        // Restore an ordinary first button for capsule lifecycle assertions.
        v=MakeContainer(); Layout(v);

        WETabButton *button=v.tabButtons[0];
        UIColor *background=[UIColor fixtureColor:.4],*foreground=[UIColor fixtureColor:.8];
        [button configureCapsuleEnabled:YES color:background textColor:foreground];
        [button setCapsuleProgress:1 animated:NO]; [button layoutSubviews];
        ResetCounters();
        for (NSUInteger i=0;i<1000;i++) {
            [button configureCapsuleEnabled:YES color:[UIColor fixtureColor:.4] textColor:[UIColor fixtureColor:.8]];
            [button setCapsuleProgress:1 animated:NO]; [button layoutSubviews];
        }
        Check(Writes==0 && Measurements==0 && Invalidations==0,@"1000 equal capsule configurations/layouts write nothing");
        [button configureCapsuleEnabled:YES color:[UIColor fixtureColor:.2] textColor:foreground];
        Check(CGColorEqualToColor(button.capsuleLayer.backgroundColor,[UIColor fixtureColor:.2].CGColor),@"capsule color changes are applied");
        Check(Invalidations==0,@"capsule color change does not invalidate geometry");
        [button configureCapsuleEnabled:NO color:background textColor:foreground];
        Check(!button.capsuleLayer && !button.capsuleTitleLabel && button.titleLabel.layer.opacity==1,@"capsule removal restores normal title opacity");
        button.currentTitle=nil;
        [button configureCapsuleEnabled:YES color:background textColor:foreground]; [button layoutSubviews];
        ResetCounters(); [button layoutSubviews];
        Check(Writes==0 && Measurements==0,@"nil title remains stable under capsule layout");

        [v updateTabs:@[]]; Layout(v);
        Check(v.selectedIndex==NSNotFound && !v.selectedTabID && v.tabButtons.count==0 && v.indicatorView.hidden,@"empty tabs hide selection and indicator");
        ResetCounters(); [v updateTabs:@[]]; Layout(v);
        Check(Writes==0 && Measurements==0,@"empty tab layout remains stable");

        v=MakeContainer(); Layout(v);
        CGRect indicator=v.indicatorView.layer.frame;
        ResetCounters(); [v moveIndicatorToFrame:indicator animated:NO];
        Check(Writes==0,@"stable nonanimated indicator target does not mutate its layer");
        CAAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.duration=10;
        [v.indicatorView.layer addAnimation:animation forKey:kIndicatorAnimationKey];
        ResetCounters(); [v moveIndicatorToFrame:indicator animated:YES];
        Check(Writes==0 && [v.indicatorView.layer animationForKey:kIndicatorAnimationKey]!=nil,@"same animated target retains in-flight animation");
        ResetCounters(); [v moveIndicatorToFrame:indicator animated:NO];
        Check(Writes==1 && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"same target nonanimated update cancels in-flight animation without geometry writes");
        [v.indicatorView.layer addAnimation:animation forKey:kIndicatorAnimationKey];
        AnimationEnabled=NO; ResetCounters(); [v selectTabAtIndex:v.selectedIndex animated:NO];
        Check(SynchronousLayouts==0 && ![v.indicatorView.layer animationForKey:kIndicatorAnimationKey],@"animation-disable acknowledgement cancels transition without forcing layout");
        AnimationEnabled=YES;
        ResetCounters(); [v selectTabAtIndex:1 animated:YES];
        Check(v.selectedIndex==1 && [v.selectedTabID isEqualToString:@"tab1"] && v.tabButtons[1].selected && !v.tabButtons[0].selected,@"actual selection changes identity and selected buttons");
        Check(SynchronousLayouts==1,@"actual selection still synchronizes geometry before animating");
        Check([v.indicatorView.layer animationForKey:kIndicatorAnimationKey]!=nil,@"actual selection still animates indicator");
        [v updateInteractiveTransitionToIndex:2 progress:.5];
        Check(v.interactiveTransition && v.selectedIndex==1,@"interactive preview keeps committed selection");
        [v selectTabAtIndex:2 animated:YES];
        Check(!v.interactiveTransition && v.selectedIndex==2,@"interactive settle commits next selection");
        Check(SynchronousLayouts==1,@"interactive settle preserves finger geometry without forced layout");

        CALayer *capsule=[CALayer layer];
        CSGroupSetCapsuleLayer(capsule,1,YES,NO);
        [capsule addAnimation:animation forKey:kCapsuleAnimationKey];
        ResetCounters(); CSGroupSetCapsuleLayer(capsule,1,YES,YES);
        Check(Writes==0 && [capsule animationForKey:kCapsuleAnimationKey]!=nil,@"same capsule animation preserves phase");
        ResetCounters(); CSGroupSetCapsuleLayer(capsule,1,YES,NO);
        Check(Writes==1 && ![capsule animationForKey:kCapsuleAnimationKey],@"same capsule target cancels animation without writing model properties");

        printf("{\"checks\":%lu,\"failures\":%lu,\"stable_iterations\":1000,\"stable_visual_writes\":%lu,\"stable_text_measurements\":%lu,\"stable_synchronous_layouts\":%lu}\n",(unsigned long)Checks,(unsigned long)Failures,(unsigned long)stableWrites,(unsigned long)stableMeasures,(unsigned long)stableSync);
    }
    return Failures ? 1 : 0;
}
