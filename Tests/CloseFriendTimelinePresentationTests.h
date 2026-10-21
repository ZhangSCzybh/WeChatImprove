// Native behavior is represented by the fixture methods above, not pixel rendering.
// Adapter methods/hook wrappers under test are extracted from production verbatim.
static int TestTimelinePresentation(void) {
    InstallTimelinePresentation();
    TimelineMethod(@"numberOfSectionsInTableView:","q@:@");
    TimelineMethod(@"tableView:willDisplayCell:forRowAtIndexPath:","v@:@@@");
    Policy(NO,200);
    WCTimeLineViewController *page=[WCTimeLineViewController new];
    page.view=[UIView new]; page.viewLoaded=YES;
    page.tableView=[UITableView new]; page.nestedMedia=[UITableView new];
    page.cellHeightCache=[@{@"old":@100} mutableCopy]; page.cellShowItemCache=[@{@"old":@1} mutableCopy];
    page.deferredRows=[@[@0] mutableCopy]; page.facade=[WCFacade new]; page.facade.styleCache=[NSMutableDictionary new];
    WCDataItem *secret=[WCDataItem new]; secret.username=@"secret"; secret.itemID=@"hidden";
    WCDataItem *ordinary=[WCDataItem new]; ordinary.username=@"alice"; ordinary.itemID=@"ordinary";
    page.facade.source=@[secret,ordinary]; NSArray *source=page.facade.source;
    [page viewWillAppear:YES];
    Check(page.nativeReloads==1 && page.tableView.renderPending && page.deferredRows.count==0);
    Check(page.cellHeightCache.count==0 && page.cellShowItemCache.count==0 && page.nestedMedia.reloads==0);
    Check([page numberOfSectionsInTableView:page.tableView]==1);
    NSIndexPath *first=[NSIndexPath indexPathForRow:0 inSection:0];
    [page tableView:page.tableView willDisplayCell:nil forRowAtIndexPath:first];
    Check(page.displayedItem==ordinary); // Old adapter reads raw index 0 -> secret here.
    [page viewDidAppear:YES]; [page viewWillAppear:NO]; [page viewDidAppear:NO];
    Check(page.nativeReloads==1 && page.appearances==4);
    Check(![InstalledHooks containsObject:@"WCTimeLineViewController.viewDidLayoutSubviews"] && ![InstalledHooks containsObject:@"WCTimeLineViewController.reloadDataWrap"]);
    [page viewDidLayoutSubviews];
    Check(page.nativeLayouts==1 && page.nativeReloads==2); // Native work is not amplified.

    void (^update)(id)=[Refreshes objectForKey:page]; Check(update!=nil);
    Policy(YES,201); update(page); // Unlock while timeline is offscreen.
    Check(page.nativeReloads==2);
    [page.deferredRows addObject:@0];
    [page viewWillAppear:YES]; [page viewDidAppear:YES];
    Check(page.nativeReloads==3 && page.deferredRows.count==0 && [page numberOfSectionsInTableView:nil]==2);
    [page tableView:page.tableView willDisplayCell:nil forRowAtIndexPath:first];
    Check(page.displayedItem==secret && page.facade.source==source && [page.facade countOfTimelineDataItem]==2);

    page.view.window=[NSObject new]; Policy(NO,202); page.refreshInsideReload=YES;
    update(page); page.refreshInsideReload=NO;
    Check(page.nativeReloads==4 && [page numberOfSectionsInTableView:nil]==1 && !State(page).refreshing);
    update(page); [page viewDidAppear:NO];
    Check(page.nativeReloads==4); // Repeated notifications/appearance do not reload again.
    [page tableView:page.tableView willDisplayCell:nil forRowAtIndexPath:first]; Check(page.displayedItem==ordinary);
    __weak id releasedInteraction=nil;
    @autoreleasepool {
        NSMutableDictionary *interaction=[NSMutableDictionary dictionaryWithObject:@"alice" forKey:@"username"];
        releasedInteraction=interaction;ordinary.likeUsers=@[interaction];
        CSCFTimelineScope *previous=Enter(page,nil);Check(ordinary.likeCount==1);Leave(previous);ordinary.likeUsers=@[];
    }
    Check(releasedInteraction!=nil);
    [page viewDidDisappear:YES];
    Check(!releasedInteraction && !State(page).posts && page.disappearances==1 && page.nativeReloads==4);
    [page viewWillAppear:YES];
    Check(page.nativeReloads==4 && [page numberOfSectionsInTableView:nil]==1);

    page.viewLoaded=NO; Policy(YES,203); update(page); [page viewWillAppear:NO];
    Check(page.nativeReloads==4); page.viewLoaded=YES; [page viewWillAppear:NO];
    Check(page.nativeReloads==5 && [page numberOfSectionsInTableView:nil]==2);
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@NO,@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:NO revision:204 blocked:NO];
    update(page); Check(page.nativeReloads==6 && [page numberOfSectionsInTableView:nil]==2);
    WCTimeLineViewController *disabled=[WCTimeLineViewController new]; disabled.viewLoaded=YES; disabled.view=[UIView new]; disabled.tableView=[UITableView new];
    [disabled viewWillAppear:NO]; [disabled viewDidAppear:NO]; Check(disabled.nativeReloads==0);
    NSUInteger displayed=page.displayCalls;
    Epoch++; Policy(NO,205); update(page); [page viewWillAppear:NO];
    [page tableView:page.tableView willDisplayCell:nil forRowAtIndexPath:first];
    Check(page.nativeReloads==6 && page.displayCalls==displayed); Epoch--;
    puts("Timeline presentation: core cases passed (native refresh, display mapping, offscreen reveal, lifecycle deduplication, no layout/reload hooks, stale accounts, disappearance releases cache without reload)");
    return 0;
}
