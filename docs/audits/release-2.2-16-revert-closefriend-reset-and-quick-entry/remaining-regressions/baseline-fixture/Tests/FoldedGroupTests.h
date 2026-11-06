// Production projection/refresh selection replay; no WeChat account or runtime.
static NativeSession *FoldedSession(NSString *name,NSUInteger unread) {
    NativeSession *session=[NativeSession new];session.m_nsUserName=name;session.m_uUnReadCount=unread;return session;
}
static NSNumber *FoldedEntryCount(CSGroupRow *row) {
    return [row respondsToSelector:NSSelectorFromString(@"foldedEntryCount")] ? [row valueForKey:@"foldedEntryCount"] : nil;
}
static void FoldedPublish(CSGroupListAdapter *adapter,NSArray *native,NSArray *tabs,NSString *selection) {
    adapter.projection=[adapter projectionForSections:native tabs:tabs selectedTabID:selection accountID:account];
    NSMutableDictionary *paths=[NSMutableDictionary dictionary];
    [adapter.projection.sections enumerateObjectsUsingBlock:^(NSArray *rows,NSUInteger section,BOOL *stop) {
        (void)stop;[rows enumerateObjectsUsingBlock:^(CSGroupRow *row,NSUInteger index,BOOL *end) {
            (void)end;NSUInteger coordinates[]={section,index};paths[row.userName]=[NSIndexPath indexPathWithIndexes:coordinates length:2];
        }];
    }];
    adapter.identityDisplayPaths=paths;
}
static void RunFoldedGroupTests(void) {
    NSString *oldAccount=account;CSCloseFriendSnapshot *oldPolicy=policy;id oldService=foldedService;BOOL oldEnabled=groupEnabled;
    account=@"folded-fixture";policy=Policy(@[],YES,100);groupEnabled=YES;
    WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll],*groups=[WESessionTabItem tabWithType:WETabTypeGroup],*private=[WESessionTabItem tabWithType:WETabTypePrivate];
    WESessionTabItem *aTab=[WESessionTabItem tabWithType:WETabTypeCustom];aTab.tabId=@"custom-a";aTab.sessionUserNames=@[@"a@chatroom"];
    WESessionTabItem *bTab=[WESessionTabItem tabWithType:WETabTypeCustom];bTab.tabId=@"custom-b";bTab.sessionUserNames=@[@"b@chatroom"];
    WESessionTabItem *empty=[WESessionTabItem tabWithType:WETabTypeCustom];empty.tabId=@"custom-empty";empty.sessionUserNames=@[];
    NSArray *tabs=@[all,groups,private,aTab,bTab,empty];
    ChatBoxMgr *manager=[ChatBoxMgr new];foldedService=manager;
    NativeSession *a=FoldedSession(@"a@chatroom",4),*b=FoldedSession(@"b@chatroom",0),*c=FoldedSession(@"c@chatroom",2);
    manager.sourceSessions=@[a,b,c];
    ChatBoxSessionListViewController *folded=[ChatBoxSessionListViewController new];folded.sessions=[manager.sourceSessions mutableCopy];folded.m_tableView=[TestTable new];
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.controller=folded;adapter.table=folded.m_tableView;adapter.preferences=[Preferences new];
    NSDictionary *selection=[adapter foldedSelectionFixture:tabs selected:bTab.tabId];
    Check([selection[@"enabled"] boolValue] && [selection[@"selected"] isEqual:bTab.tabId],@"folded controller follows current custom group instead of forcing All");
    Check(![selection[@"chrome"] boolValue],@"folded grouping does not install main-list group chrome");
    NSArray *native=CSGroupBuildNativeSections(folded,folded.m_tableView,folded);
    FoldedPublish(adapter,native,selection[@"tabs"],selection[@"selected"]);
    Check(adapter.projection.sections[0].count==1 && [adapter.projection.sections[0][0].userName isEqual:b.m_nsUserName],@"folded proxy publishes only current-group sessions");
    Check([[adapter nativePath:Path(0)] isEqual:Path(1)],@"folded group display zero resolves native B index");
    Check([adapter displayPath:Path(0)]==nil && [[adapter displayPath:Path(1)] isEqual:Path(0)],@"folded native open guard rejects another group's original index");
    NSInvocation *select=[NSInvocation invocationWithMethodSignature:[folded methodSignatureForSelector:@selector(tableView:didSelectRowAtIndexPath:)]];
    select.selector=@selector(tableView:didSelectRowAtIndexPath:);id table=adapter.table;NSIndexPath *display=Path(0);
    [select setArgument:&table atIndex:2];[select setArgument:&display atIndex:3];[adapter forwardInvocation:select target:folded];
    Check(folded.calls==1 && [folded.opened isEqual:Path(1)] && !adapter.nativePresentation,@"native selection receives B's original path without switching to All");
    folded.nativeCell=[UITableViewCell new];[adapter cellForDisplayPath:Path(0) target:folded];
    Check([folded.rendered isEqual:Path(1)],@"native folded renderer receives original B coordinate");
    [folded.sessions exchangeObjectAtIndex:0 withObjectAtIndex:1];adapter.dirty=YES;
    Check([[adapter nativePath:Path(0)] isEqual:Path(0)],@"folded selection resolves identity again after native reorder");
    policy=Policy(@[b.m_nsUserName],NO,101);NSUInteger calls=folded.calls;
    [adapter forwardInvocation:select target:folded];
    Check(folded.calls==calls && [adapter displayPath:Path(0)]==nil,@"new privacy lock rejects stale group selection before republication");
    policy=Policy(@[],YES,102);folded.sessions=[manager.sourceSessions mutableCopy];adapter.dirty=NO;
    for (NSString *tabID in @[aTab.tabId,bTab.tabId,empty.tabId]) {
        selection=[adapter foldedSelectionFixture:tabs selected:tabID];FoldedPublish(adapter,native,selection[@"tabs"],selection[@"selected"]);
        Check([selection[@"selected"] isEqual:tabID] && adapter.projection.sections[0].count==([tabID isEqual:empty.tabId]?0:1),@"reentering folded owner reads the current selected group");
    }
    NativeHost *main=[NativeHost new];main.m_tableView=[TestTable new];main.sessions=[NSMutableArray arrayWithObject:FoldedSession(@"chatroom_session_box",1)];
    main.sessions[0].m_bShowUnReadAsRedDot=YES;adapter.controller=main;adapter.table=main.m_tableView;
    NSArray *mainRows=CSGroupBuildNativeSections(main,main.m_tableView,main);
    CSGroupProjection *emptyProjection=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:empty.tabId accountID:account];
    Check(emptyProjection.isValid && emptyProjection.sections[0].count==0,@"confirmed empty custom group has no folded entry");
    CSGroupProjection *bProjection=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check(bProjection.sections[0].count==1 && [FoldedEntryCount(bProjection.sections[0][0]) isEqual:@1],@"folded entry carries current group's visible conversation count");
    Check(![bProjection badgeForTabID:bTab.tabId].redDot,@"another group's unread folded child cannot mark B unread");
    Check([bProjection badgeForTabID:aTab.tabId].redDot,@"folded unread indicator remains attributed to its own group");
    Check([bProjection badgeForTabID:aTab.tabId].count==0,@"folded summary never converts child count into aggregate numeric unread");
    adapter.projection=bProjection;policy=Policy(@[],YES,103);
    CSGroupProjection *revised=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check(![revised hasSameDisplayStructureAs:bProjection],@"same folded count with new policy revision invalidates stale presentation provenance");
    adapter.projection=revised;
    CSGroupProjection *unchanged=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check(unchanged==revised,@"unchanged child summary reuses the projection");
    NativeSession *friend=FoldedSession(@"ordinary-friend",0);manager.sourceSessions=@[a,b,c,friend];
    CSGroupProjection *privateProjection=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:private.tabId accountID:account];
    Check([FoldedEntryCount(privateProjection.sections[0][0]) isEqual:@1],@"folded private category uses native session classification");
    CSGroupProjection *allProjection=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:all.tabId accountID:account];
    Check([FoldedEntryCount(allProjection.sections[0][0]) isEqual:@4],@"All counts the visible union without double counting custom memberships");
    CSGroupProjection *groupsProjection=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:groups.tabId accountID:account];
    Check([FoldedEntryCount(groupsProjection.sections[0][0]) isEqual:@3],@"native group category excludes ordinary private sessions");
    adapter.preferences.filterDuplicates=YES;
    groupsProjection=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:groups.tabId accountID:account];
    Check([FoldedEntryCount(groupsProjection.sections[0][0]) isEqual:@1],@"folded entry respects the same duplicate filtering as child projection");
    adapter.preferences.filterDuplicates=NO;
    policy=Policy(@[a.m_nsUserName,b.m_nsUserName],NO,104);
    CSGroupProjection *locked=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:groups.tabId accountID:account];
    Check([FoldedEntryCount(locked.sections[0][0]) isEqual:@1] && ![locked badgeForTabID:aTab.tabId].redDot,@"folded summary omits hidden members and their unread");
    locked=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check(locked.sections[0].count==0,@"group containing only hidden folded children has no entry");
    policy=Policy(@[a.m_nsUserName,b.m_nsUserName],YES,105);
    CSGroupProjection *revealed=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check([FoldedEntryCount(revealed.sections[0][0]) isEqual:@1],@"privacy reveal restores only the current group's folded members");
    bTab.sessionUserNames=@[b.m_nsUserName,c.m_nsUserName];adapter.projection=revealed;
    CSGroupProjection *membersChanged=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check([FoldedEntryCount(membersChanged.sections[0][0]) isEqual:@2] && ![membersChanged hasSameDisplayStructureAs:revealed],@"group membership edit republishes the folded count");
    bTab.sessionUserNames=@[b.m_nsUserName];manager.sourceSessions=@[a,c,friend];
    CSGroupProjection *removed=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check(removed.sections[0].count==0,@"unfolding the final member removes its group's aggregate");
    manager.sourceSessions=@[];
    CSGroupProjection *confirmedEmpty=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:all.tabId accountID:account];
    Check(confirmedEmpty.sections[0].count==0 && CSGroupCopyFoldedRows().count==0,@"confirmed empty source removes entry rather than showing stale global count");
    for (id invalid in @[NSNull.null,@[[NSObject new]],@[a,a],@[main.sessions[0]]]) {
        manager.sourceSessions=invalid==NSNull.null ? nil : invalid;
        CSGroupProjection *unknown=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:empty.tabId accountID:account];
        Check(unknown.isValid && unknown.sections[0].count==1 && !FoldedEntryCount(unknown.sections[0][0]) && ![unknown badgeForTabID:empty.tabId].redDot,@"unknown/malformed/duplicate/recursive folded source retains neutral entry without invented zero or unread");
    }
    WrongFoldedGetter *wrong=[WrongFoldedGetter new];foldedService=wrong;
    Check(CSGroupCopyFoldedRows()==nil && wrong.calls==0,@"group count snapshot rejects scalar getter before invocation");
    foldedService=manager;manager.sourceSessions=@[a,b,c];manager.replaceEpoch=YES;
    CSGroupProjection *epochChanged=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check(epochChanged.sections.count==0,@"account epoch transition during folded snapshot publishes no scoped rows");
    manager.replaceEpoch=NO;NSString *fixtureAccount=account;account=@"other-account";
    CSGroupProjection *accountChanged=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:bTab.tabId accountID:account];
    Check(accountChanged.sections.count==0,@"old policy cannot publish another account's folded summary");account=fixtureAccount;
    groupEnabled=NO;adapter.controller=folded;
    selection=[adapter foldedSelectionFixture:tabs selected:bTab.tabId];
    Check([selection[@"selected"] isEqual:all.tabId] && ![selection[@"enabled"] boolValue] && ![selection[@"chrome"] boolValue],@"disabled grouping restores native global folded selection without chrome");
    FoldedPublish(adapter,native,selection[@"tabs"],selection[@"selected"]);
    Check(adapter.projection.sections[0].count==3,@"disabled grouping shows all native folded children when revealed");
    policy=Policy(@[b.m_nsUserName],NO,106);FoldedPublish(adapter,native,selection[@"tabs"],selection[@"selected"]);
    Check(adapter.projection.sections[0].count==2 && [adapter displayPath:Path(1)]==nil,@"disabled grouping retains the existing folded privacy gate");
    adapter.controller=main;policy=Policy(@[],YES,107);
    CSGroupProjection *disabled=[adapter projectionForSections:mainRows tabs:tabs selectedTabID:all.tabId accountID:account];
    Check(!FoldedEntryCount(disabled.sections[0][0]) && [disabled badgeForTabID:all.tabId].redDot,@"disabled grouping restores original aggregate unread presentation");
    Check(manager.sourceSessions.count==3 && a.m_uUnReadCount==4 && main.sessions[0].m_uUnReadCount==1,@"group scoping never rewrites native membership or aggregate unread");
    account=oldAccount;policy=oldPolicy;foldedService=oldService;groupEnabled=oldEnabled;
}
