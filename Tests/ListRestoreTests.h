// UIKit host event simulations; these are not measurements of an attached iPhone.
static void RestorePost(NSString *name,id object) {
    [NSNotificationCenter.defaultCenter postNotificationName:name object:object];
}
static void SessionLifecycleRestoreTests(void) {
    NSArray *paths=@[@[@"cold_then_background",@YES],@[@"lock_unlock",@YES],@[@"switcher_return",@NO],@[@"notification_control_center",@NO],@[@"other_app_over_minute",@YES]];
    for(NSArray *path in paths) for(NSNumber *dark in @[@NO,@YES]) for(NSNumber *changed in @[@NO,@YES]) {
        Configure();UITableView *table=Table();id owner=Owner(CSListCornerPageSession,table);
        table.window=[UIWindow new];table.window.windowScene=[NSObject new];
        UIUserInterfaceStyle style=dark.boolValue ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        table.traitCollection.userInterfaceStyle=style;table.contentOffset=CGPointMake(0,137);table.backgroundView=View(UIView.class,table.bounds);
        CSGroupRow *firstRow=CardRow(0,@"normal"),*folded=[[CSGroupRow alloc] initWithNativePath:Path(1,0) userName:@"chatroom_session_box" kind:CSGroupRowKindAggregate category:CSGroupRowCategoryUnknown top:NO unreadCount:0 redDot:NO];
        CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.active=YES;adapter.projection=[ProjectionFixture new];
        adapter.projection.sections=@[@[firstRow,folded]];table.groupAdapter=adapter;table.rows=@[@2];
        UITableViewCell *first=Cell(table,0,0),*last=Cell(table,1,0);
        first.contentView.traitCollection.userInterfaceStyle=style;last.contentView.traitCollection.userInterfaceStyle=style;
        CSListCornerSessionDecorate(first,table,first.path,owner);CSListCornerSessionDecorate(last,table,last.path,owner);
        UIView *gap=CSListCornerSectionView(owner,table,nil,0,CSListCornerPageSession,NO);[table addSubview:gap];CGRect gapFrame=gap.frame;
        HookSessionViewportLayout(owner,^{});
        UIColor *canvas=dark.boolValue ? UIColor.blackColor : CSListCornerCanvasColor(),*wrong=dark.boolValue ? UIColor.whiteColor : UIColor.blackColor;
        for(NSUInteger cycle=0;cycle<2;cycle++) {
            RestorePost(UIApplicationWillResignActiveNotification,nil);
            if([path[1] boolValue]) RestorePost(UIApplicationDidEnterBackgroundNotification,nil);
            table.backgroundColor=wrong;table.backgroundView.backgroundColor=wrong;gap.backgroundColor=wrong;
            Background(first).hidden=YES;Background(last).layer.mask=nil;
            if(changed.boolValue) {
                // Actual projection rows change, then native display callbacks establish current roles.
                firstRow=[[CSGroupRow alloc] initWithNativePath:Path(0,0) userName:@"normal" kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:YES unreadCount:cycle ? 0 : 3 redDot:NO];adapter.projection.sections=cycle ? @[@[firstRow,folded]] : @[@[firstRow],@[folded]];
                table.rows=cycle ? @[@2] : @[@1,@1];last.path=cycle ? Path(1,0) : Path(0,1);
                CSListCornerSessionDecorate(first,table,first.path,owner);CSListCornerSessionDecorate(last,table,last.path,owner);
            }
            NSUInteger queries=table.queries;table.throwsOnQuery=YES;
            if([path[1] boolValue]) RestorePost(UIApplicationWillEnterForegroundNotification,nil);
            RestorePost(UIApplicationDidBecomeActiveNotification,nil);
            Check([table.backgroundColor isEqual:canvas] && [table.backgroundView.backgroundColor isEqual:canvas],[NSString stringWithFormat:@"%@ cycle %lu: first paint restores canvas without scrolling",path[0],(unsigned long)cycle]);
            Check([gap.backgroundColor isEqual:[FixtureConfiguration.snapshot pinnedColorForStyle:style]],@"foreground repairs live gap color, including transparent sentinel");
            Check(!Background(first).hidden && Background(last).layer.mask!=nil,@"foreground repairs existing cards without cell or scroll callback");
            BOOL split=changed.boolValue && cycle==0;
            Check(!Rounded(Background(first),CGPointMake(1,1)) && Rounded(Background(first),CGPointMake(1,59))==!split && Rounded(Background(last),CGPointMake(1,1))==!split && !Rounded(Background(last),CGPointMake(1,59)),@"native-delivered roles persist: folded entry shares section card, singleton has four corners");
            Check([Background(last).backgroundColor isEqual:[FixtureConfiguration.snapshot backgroundForStyle:style]] && CGRectEqualToRect(gap.frame,gapFrame),@"restore preserves card colors and gap geometry in both themes");
            Check(CGPointEqualToPoint(table.contentOffset,CGPointMake(0,137)) && table.reloads==0 && table.queries==queries,@"foreground never queries/reloads rows or moves scroll position");
            __block NSUInteger originals=0;
            HookSessionTableLayout(table,^{originals++;table.backgroundView=View(UIView.class,table.bounds);table.backgroundView.backgroundColor=wrong;gap.backgroundColor=wrong;});
            Check(originals==1 && [table.backgroundView.backgroundColor isEqual:canvas] && [gap.backgroundColor isEqual:[FixtureConfiguration.snapshot pinnedColorForStyle:style]],@"post-native table layout repairs later replacement before returning");
            Check(CGPointEqualToPoint(table.contentOffset,CGPointMake(0,137)) && table.reloads==0 && table.queries==queries,@"post-layout repair remains independent of data and scroll state");
            table.throwsOnQuery=NO;
        }
        table.window=nil;
    }
    Configure();
}
static void SessionRestoreBoundaryTests(void) {
    Configure();UITableView *table=Table();id owner=Owner(CSListCornerPageSession,table);
    table.window=[UIWindow new];table.window.windowScene=[NSObject new];table.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
    table.contentOffset=CGPointMake(0,53);table.backgroundView=View(UIView.class,table.bounds);
    UITableViewCell *cell=Cell(table,0,0);CSListCornerSessionDecorate(cell,table,cell.path,owner);
    HookSessionViewportLayout(owner,^{});table.throwsOnQuery=YES;NSUInteger queries=table.queries;
    HookSessionTableColor(table,^{table.backgroundColor=UIColor.blackColor;});
    Check([table.backgroundColor isEqual:CSListCornerCanvasColor()],@"native paint after restoration cannot undo owned canvas");
    HookSessionTableBackground(table,^{table.backgroundView=View(UIView.class,table.bounds);table.backgroundView.backgroundColor=UIColor.blackColor;});
    Check([table.backgroundView.backgroundColor isEqual:CSListCornerCanvasColor()],@"native backgroundView replacement is repaired after original setter");
    CGRect oldFrame=Background(cell).frame;table.bounds=CGRectZero;cell.contentView.frame=CGRectZero;
    RestorePost(UIApplicationWillResignActiveNotification,nil);RestorePost(UIApplicationDidBecomeActiveNotification,nil);
    Check(CGRectEqualToRect(Background(cell).frame,oldFrame),@"zero geometry preserves existing card until native layout supplies dimensions");
    HookSessionTableLayout(table,^{table.bounds=CGRectMake(0,0,430,800);cell.contentView.frame=CGRectMake(0,0,430,76);table.backgroundColor=UIColor.blackColor;});
    Check([table.backgroundColor isEqual:CSListCornerCanvasColor()] && Background(cell).frame.size.width==392 && Background(cell).frame.size.height==76,@"first valid native layout completes pending geometry without timer");
    RestorePost(UISceneWillDeactivateNotification,table.window.windowScene);table.backgroundColor=UIColor.blackColor;
    RestorePost(UISceneDidActivateNotification,[NSObject new]);Check([table.backgroundColor isEqual:UIColor.blackColor],@"another scene cannot restore this table");
    RestorePost(UISceneWillEnterForegroundNotification,table.window.windowScene);RestorePost(UISceneDidActivateNotification,table.window.windowScene);
    Check([table.backgroundColor isEqual:CSListCornerCanvasColor()],@"matching scene activation covers scene-based return");
    [FixtureConfiguration saveEnabled:NO];RestorePost(UIApplicationDidBecomeActiveNotification,nil);
    Check(!CSListCornerExistingSessionBackground(cell) && [table.backgroundColor isEqual:UIColor.whiteColor],@"disabled return removes cards and preserves existing flat appearance");
    [FixtureConfiguration saveEnabled:YES];table.throwsOnQuery=NO;CSListCornerSessionDecorate(cell,table,cell.path,owner);table.throwsOnQuery=YES;queries=table.queries;
    RestorePost(UIApplicationDidBecomeActiveNotification,nil);
    Check(CSListCornerExistingSessionBackground(cell)!=nil && [table.backgroundColor isEqual:CSListCornerCanvasColor()],@"reenabled native delivery restores cards without stale flat paint");
    Check(table.queries==queries && table.reloads==0 && CGPointEqualToPoint(table.contentOffset,CGPointMake(0,53)),@"boundary repair preserves data source and offset");
    UITableView *search=Table();search.responder=owner;search.window=table.window;search.throwsOnQuery=YES;
    HookSessionTableColor(search,^{search.backgroundColor=UIColor.blackColor;});HookSessionTableLayout(search,^{});
    Check([search.backgroundColor isEqual:UIColor.blackColor] && search.queries==0 && search.layoutInvalidations==0,@"search and unowned tables are untouched");
    table.window=nil;table.backgroundColor=UIColor.blackColor;RestorePost(UIApplicationDidBecomeActiveNotification,nil);
    Check([table.backgroundColor isEqual:UIColor.blackColor],@"offscreen table waits for own appearance or layout");
    table.window=[UIWindow new];HookSessionTableLayout(table,^{});
    Check([table.backgroundColor isEqual:CSListCornerCanvasColor()],@"offscreen pending restore completes on reattachment layout");
    Configure();
}

@interface RestoreHookedTable : UITableView
@property(nonatomic) NSUInteger paintCalls;
@end
@implementation RestoreHookedTable
- (void)setBackgroundColor:(UIColor *)color {
    self.paintCalls++;
    HookSessionTableColor(self,^{[super setBackgroundColor:color];});
}
- (void)setBackgroundView:(UIView *)view {
    self.paintCalls++;
    HookSessionTableBackground(self,^{[super setBackgroundView:view];});
}
@end
static void SessionRestorePaintTests(void) {
    Configure();RestoreHookedTable *table=[[RestoreHookedTable alloc] initWithFrame:CGRectMake(0,0,390,700)];
    id owner=Owner(CSListCornerPageSession,table);table.window=[UIWindow new];table.throwsOnQuery=YES;
    table.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;HookSessionViewportLayout(owner,^{});
    NSUInteger count=table.paintCalls;
    table.backgroundColor=UIColor.blackColor;
    UIView *replacement=View(UIView.class,table.bounds);replacement.backgroundColor=UIColor.blackColor;table.backgroundView=replacement;
    Check(table.paintCalls-count<8 && [table.backgroundColor isEqual:CSListCornerCanvasColor()] && [replacement.backgroundColor isEqual:CSListCornerCanvasColor()],@"real hooked setter recursion is bounded and original background identity is retained");
    UIView *normal=CSListCornerSectionView(owner,table,nil,1,CSListCornerPageSession,NO);[table addSubview:normal];
    UIColor *custom=[UIColor colorWithRed:.2 green:.3 blue:.4 alpha:.5];
    [FixtureConfiguration saveColor:custom redKey:kNormalSessionTopMarginLightBgColorRedKey greenKey:kNormalSessionTopMarginLightBgColorGreenKey blueKey:kNormalSessionTopMarginLightBgColorBlueKey alphaKey:kNormalSessionTopMarginLightBgColorAlphaKey];
    RestorePost(UIApplicationWillResignActiveNotification,nil);RestorePost(UIApplicationDidBecomeActiveNotification,nil);
    Check(Near(normal.backgroundColor.red,.2) && Near(normal.backgroundColor.alpha,.5),@"custom normal gap color survives foreground with original alpha");
    normal.backgroundColor=UIColor.blackColor;[normal layoutSubviews];
    Check(Near(normal.backgroundColor.red,.2),@"owned gap repairs paint after its own later native layout");
    for(NSUInteger index=0;index<30;index++) {HookSessionTableLayout(table,^{});table.backgroundColor=UIColor.blackColor;}
    Check(table.queries==0 && table.reloads==0,@"repeated native overwrites on empty group perform no model read or reload");
    Check([table.backgroundColor isEqual:CSListCornerCanvasColor()] && [replacement.backgroundColor isEqual:CSListCornerCanvasColor()],@"empty foreground viewport retains the entire canvas");
    NSUInteger tableDraws=table.displayInvalidations,backingDraws=replacement.displayInvalidations,gapDraws=normal.displayInvalidations;
    RestorePost(UIApplicationWillResignActiveNotification,nil);RestorePost(UIApplicationDidBecomeActiveNotification,nil);
    Check(table.displayInvalidations>tableDraws,@"foreground invalidates stale canvas rendering even when color properties already match");
    Check(replacement.displayInvalidations>backingDraws,@"foreground invalidates existing backing without replacing its identity");
    Check(normal.displayInvalidations>gapDraws,@"foreground invalidates owned gap rendering without changing its height");
    Configure();
}
