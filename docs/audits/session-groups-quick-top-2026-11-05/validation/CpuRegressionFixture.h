#define CPUCHECK(...) CHECK((__VA_ARGS__))
// CPU regression checks run production Model/Projection code with host metadata.
static NSUInteger CpuRowReads;
static CSGroupNativeModelResult *CpuUpdate(CSGroupNativeModelResult *model,NSSet *names) {
    CpuRowReads=0;
    return [CSGroupNativeModel modelByUpdatingResult:model changedUserNames:names
        rowProvider:^CSGroupRow *(id object,NSIndexPath *path,BOOL top) {
            CpuRowReads++;return CSGroupRowForNativeSession(object,path,top);
        }];
}
static BOOL CpuProjectionEqual(CSGroupProjection *a,CSGroupProjection *b,NSArray *tabs) {
    if(!a.isValid || !b.isValid || a.sections.count!=b.sections.count)return NO;
    for(NSUInteger s=0;s<a.sections.count;s++) {
        NSArray *left=a.sections[s],*right=b.sections[s];if(left.count!=right.count)return NO;
        for(NSUInteger r=0;r<left.count;r++) {
            CSGroupRow *x=left[r],*y=right[r];
            if(![x.nativePath isEqual:y.nativePath] || ![x.userName isEqual:y.userName] || x.kind!=y.kind || x.category!=y.category ||
                x.top!=y.top || x.unreadCount!=y.unreadCount || x.redDot!=y.redDot || x.privacyMasked!=y.privacyMasked)return NO;
        }
    }
    for(WESessionTabItem *tab in tabs) {
        CSGroupBadge *x=[a badgeForTabID:tab.tabId],*y=[b badgeForTabID:tab.tabId];
        if(x.count!=y.count || x.redDot!=y.redDot || [a sessionCountForTabID:tab.tabId]!=[b sessionCountForTabID:tab.tabId])return NO;
    }
    return YES;
}
static CSGroupRow *CpuReplacement(CSGroupRow *old,NSString *name,CSGroupRowCategory category,BOOL top,NSUInteger unread,BOOL dot) {
    return [[CSGroupRow alloc] initWithNativePath:old.nativePath userName:name kind:old.kind category:category top:top
        unreadCount:unread redDot:dot nativeSummary:old.nativeSummary sortTime:old.nativeSortTime nativePrefix:old.nativePrefix];
}
static void CpuModelRegressionTests(void) {
    MMSessionInfo *a=Session(@"cpu-a",2),*b=Session(@"cpu-b@chatroom",3),*c=Session(@"cpu-c",4);
    MainSessionInfoItem *wa=Wrap(a,200),*wb=Wrap(b,300),*wc=Wrap(c,400);
    NSArray *top=@[wa],*normal=@[wb,wc],*allTop=@[wa],*all=@[a,b,c];
    CSGroupNativeModelResult *old=Build(top,normal,allTop,all,@"preset_0",YES,NSSet.set);
    CPUCHECK(old.isValid && old.sourceRows.count==3);
    a.m_uUnReadCount=9;wa.mainUnReadCount=900;
    CSGroupNativeModelResult *delta=CpuUpdate(old,[NSSet setWithObject:@"cpu-a"]);
    CPUCHECK(delta.isValid && CpuRowReads==2);
    CPUCHECK(delta.topSessions==old.topSessions && delta.normalSessions==old.normalSessions && delta.allTopSessions==old.allTopSessions);
    CPUCHECK(delta.sourceRows[1]==old.sourceRows[1] && delta.sourceRows[2]==old.sourceRows[2]);
    CPUCHECK(delta.sourceRows[0]!=old.sourceRows[0] && old.sourceRows[0].unreadCount==2 && delta.sourceRows[0].unreadCount==9);
    CPUCHECK([delta rowForSession:wa].unreadCount==9 && [delta rowForSession:wa].top);
    CPUCHECK(CpuProjectionEqual(delta.projection,Build(top,normal,allTop,all,@"preset_0",YES,NSSet.set).projection,Tabs()));
    CPUCHECK(CpuUpdate(delta,NSSet.set)==delta && CpuRowReads==0);
    CPUCHECK(CpuUpdate(delta,[NSSet setWithObject:@"missing-name"])==nil && CpuRowReads==0);
    a.m_nsUserName=@"cpu-renamed";CPUCHECK(CpuUpdate(delta,[NSSet setWithObject:@"cpu-a"])==nil);a.m_nsUserName=@"cpu-a";
    CPUCHECK([CSGroupNativeModel modelByUpdatingResult:delta changedUserNames:[NSSet setWithObject:@"cpu-a"]
        rowProvider:^CSGroupRow *(id object,NSIndexPath *path,BOOL isTop) {
            CSGroupRow *row=CSGroupRowForNativeSession(object,path,isTop);
            return CpuReplacement(row,row.userName,CSGroupRowCategoryGroup,row.top,row.unreadCount,row.redDot);
        }]==nil);
    CPUCHECK([CSGroupNativeModel modelByUpdatingResult:delta changedUserNames:[NSSet setWithObject:@"cpu-a"]
        rowProvider:^CSGroupRow *(id object,NSIndexPath *path,BOOL isTop) {
            CSGroupRow *row=CSGroupRowForNativeSession(object,path,isTop);
            return CpuReplacement(row,row.userName,row.category,!row.top,row.unreadCount,row.redDot);
        }]==nil);
    CPUCHECK([CSGroupNativeModel modelByUpdatingResult:delta changedUserNames:[NSSet setWithObject:@"cpu-a"]
        rowProvider:^CSGroupRow *(id object,NSIndexPath *path,BOOL isTop) {
            (void)object;(void)path;(void)isTop;@throw [NSException exceptionWithName:@"FixtureRead" reason:nil userInfo:nil];
        }]==nil);
    b.m_uUnReadCount=6;c.m_uUnReadCount=8;
    delta=CpuUpdate(delta,[NSSet setWithArray:@[@"cpu-b@chatroom",@"cpu-c"]]);
    CPUCHECK(delta.isValid && CpuRowReads==4);
    CPUCHECK(CpuProjectionEqual(delta.projection,Build(top,normal,allTop,all,@"preset_0",YES,NSSet.set).projection,Tabs()));
    // A hidden record is refreshed without contributing to any visible badge.
    NSSet *hidden=[NSSet setWithObject:@"cpu-a"];
    old=Build(top,normal,allTop,all,@"preset_0",YES,hidden);NSUInteger visible=[old.projection badgeForTabID:@"preset_0"].count;
    a.m_uUnReadCount=33;delta=CpuUpdate(old,hidden);
    CPUCHECK(delta.isValid && CpuRowReads==2 && delta.sourceRows[0].unreadCount==33);
    CPUCHECK([delta.projection badgeForTabID:@"preset_0"].count==visible && delta.normalSessions.count==2 && delta.topSessions.count==0);
    CPUCHECK(CpuProjectionEqual(delta.projection,Build(top,normal,allTop,all,@"preset_0",YES,hidden).projection,Tabs()));
    // Multiple contributors keep the dot until the last unread dot disappears.
    a.m_uUnReadCount=3;b.m_uUnReadCount=2;c.m_uUnReadCount=0;
    a.m_bShowUnReadAsRedDot=YES;b.m_bShowUnReadAsRedDot=YES;
    old=Build(top,normal,allTop,all,@"preset_0",YES,NSSet.set);
    CPUCHECK([old.projection badgeForTabID:@"preset_0"].redDot && [old.projection badgeForTabID:@"preset_0"].count==0);
    a.m_uUnReadCount=0;delta=CpuUpdate(old,[NSSet setWithObject:@"cpu-a"]);
    CPUCHECK(delta.isValid && [delta.projection badgeForTabID:@"preset_0"].redDot);
    b.m_uUnReadCount=0;delta=CpuUpdate(delta,[NSSet setWithObject:@"cpu-b@chatroom"]);
    CPUCHECK(delta.isValid && ![delta.projection badgeForTabID:@"preset_0"].redDot);
    a.m_bShowUnReadAsRedDot=NO;a.m_uUnReadCount=4;delta=CpuUpdate(delta,[NSSet setWithObject:@"cpu-a"]);
    CPUCHECK(delta.isValid && ![delta.projection badgeForTabID:@"preset_0"].redDot && [delta.projection badgeForTabID:@"preset_0"].count==4);
    CPUCHECK(CpuProjectionEqual(delta.projection,Build(top,normal,allTop,all,@"preset_0",YES,NSSet.set).projection,Tabs()));
    // Retained/aggregate presentation cannot enter the ordinary-record delta.
    MMSessionInfo *box=Session(@"chatroom_session_box",3);
    old=Build(@[],@[box],nil,@[box],@"preset_0",YES,NSSet.set);
    CPUCHECK(old.isValid && CpuUpdate(old,[NSSet setWithObject:@"chatroom_session_box"])==nil);
    // Projection remapping consumes the exact canonical rows once, preserves
    // statistics, and refuses subsequent synthetic-coordinate computation.
    old=Build(top,normal,allTop,all,@"preset_0",YES,NSSet.set);
    CSGroupRow *r0=old.projection.sections[0][0],*r1=old.projection.sections[0][1],*r2=old.projection.sections[0][2];
    CSGroupProjection *mapped=[old.projection projectionByRemappingVisibleRows:@[@[r0],@[r1,r2]]];
    CPUCHECK(mapped.isValid && mapped.sections.count==2 && [mapped.sections[1] count]==2);
    CPUCHECK([[mapped rowAtDisplayPath:[NSIndexPath indexPathWithIndexes:(NSUInteger[]){1,0} length:2]].userName isEqual:@"cpu-b@chatroom"]);
    CPUCHECK([mapped badgeForTabID:@"preset_0"].count==[old.projection badgeForTabID:@"preset_0"].count);
    CPUCHECK([mapped projectionByReplacingRows:@{}]==nil);
    CPUCHECK([old.projection projectionByRemappingVisibleRows:@[@[r0,r1,r1]]]==nil);
    CPUCHECK([old.projection projectionByRemappingVisibleRows:@[@[r0,r1]]]==nil);
    CSGroupRow *clone=CpuReplacement(r0,r0.userName,r0.category,r0.top,r0.unreadCount,r0.redDot);
    CPUCHECK([old.projection projectionByRemappingVisibleRows:@[@[clone,r1,r2]]]==nil);
    CPUCHECK([old.projection projectionByReplacingRows:@{r0.nativePath:CpuReplacement(r0,@"changed",r0.category,r0.top,5,NO)}]==nil);
    CPUCHECK([old.projection projectionByReplacingRows:@{r0.nativePath:CpuReplacement(r0,r0.userName,r0.category,!r0.top,5,NO)}]==nil);
    CPUCHECK([old.projection projectionByReplacingRows:@{r0.nativePath:CpuReplacement(r0,r0.userName,CSGroupRowCategoryGroup,r0.top,5,NO)}]==nil);
    CSGroupRow *saturated=[[CSGroupRow alloc] initWithNativePath:Path(0) userName:@"overflow-a" kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:NSUIntegerMax redDot:NO];
    CSGroupProjection *sat=[[CSGroupProjection alloc] initWithSections:@[@[saturated]] tabs:Tabs() selectedTabID:@"preset_0" filterDuplicates:NO accountID:Account];
    CPUCHECK(sat.isValid && [sat badgeForTabID:@"preset_0"].count==NSUIntegerMax);
    CPUCHECK([sat projectionByReplacingRows:@{Path(0):CpuReplacement(saturated,saturated.userName,saturated.category,NO,1,NO)}]==nil);
}

static NSUInteger CpuUnreadGetterReads;
static IMP CpuOriginalUnreadGetter;
static unsigned int CpuCountUnreadGetter(id object,SEL selector) {
    CpuUnreadGetterReads++;return ((unsigned int(*)(id,SEL))CpuOriginalUnreadGetter)(object,selector);
}
static IMP CpuOriginalNameGetter;
static void (^CpuOnNameRead)(void);
static NSString *CpuReentrantNameGetter(id object,SEL selector) {
    void(^callback)(void)=CpuOnNameRead;CpuOnNameRead=nil;if(callback)callback();
    return ((id(*)(id,SEL))CpuOriginalNameGetter)(object,selector);
}
static void CpuCoordinatorRegressionTests(void) {
    NSMutableArray *sessions=[NSMutableArray array];
    for(NSUInteger i=0;i<1000;i++)[sessions addObject:Session([NSString stringWithFormat:@"cpu-coordinator-%lu",(unsigned long)i],(unsigned int)(i%5))];
    Main.hostTop=[sessions subarrayWithRange:NSMakeRange(0,20)];Main.hostNormal=[sessions subarrayWithRange:NSMakeRange(20,980)];
    Main.hostAllTop=Main.hostTop;Main.hostTotal=20;Full->m_arrSession=[sessions copy];
    Select(@"preset_0");[Main rebuildMainSessions];CPUCHECK(!Coordinator.boundary && Coordinator.model.isValid);
    Method getter=class_getInstanceMethod(MMSessionInfo.class,@selector(m_uUnReadCount));
    CpuOriginalUnreadGetter=method_setImplementation(getter,(IMP)CpuCountUnreadGetter);
    @try {
        CSGroupNativeModelResult *old=Coordinator.model;NSUInteger revision=Coordinator.revision;
        CpuUnreadGetterReads=0;[Coordinator refreshFromPreferences];
        CPUCHECK(Coordinator.model==old && Coordinator.revision==revision && CpuUnreadGetterReads==0);
        [Coordinator refreshFromPreferences];CPUCHECK(Coordinator.model==old && CpuUnreadGetterReads==0);
        MMSessionInfo *changed=sessions[123];
        __block NSDictionary *event=nil;
        id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSGroupNativeSessionModelDidChangeNotification object:Coordinator queue:nil usingBlock:^(NSNotification *note){event=note.userInfo;}];
        CpuUnreadGetterReads=0;
        [Coordinator performChangeForUserNames:[NSSet setWithObject:changed.m_nsUserName] kind:CSGroupChangeUnread original:^{
            [Coordinator performNativeMutationForManager:Full original:^{changed.m_uUnReadCount=17;}];
        }];
        CPUCHECK(!Coordinator.boundary && Coordinator.model.isValid && Coordinator.model!=old);
        CPUCHECK(CpuUnreadGetterReads>0 && CpuUnreadGetterReads<=8);
        CPUCHECK(Coordinator.model.sourceRows[122]==old.sourceRows[122] && Coordinator.model.sourceRows[124]==old.sourceRows[124]);
        CPUCHECK(Coordinator.model.sourceRows[123].unreadCount==17 && old.sourceRows[123].unreadCount==3);
        CPUCHECK([event[@"allChangesKnown"] boolValue] && [event[@"changedUserNames"] isEqual:[NSSet setWithObject:changed.m_nsUserName]]);
        CPUCHECK([event[@"changes"] unsignedIntegerValue]==CSGroupChangeUnread);
        NSUInteger expected=0;for(MMSessionInfo *session in sessions)expected+=session.m_uUnReadCount;
        CPUCHECK([Coordinator.model.projection badgeForTabID:@"preset_0"].count==expected);
        old=Coordinator.model;CpuUnreadGetterReads=0;[Coordinator refreshFromPreferences];
        CPUCHECK(Coordinator.model==old && CpuUnreadGetterReads==0);
        CpuUnreadGetterReads=0;
        [Coordinator performNativeMutationForManager:Full original:^{changed.m_uUnReadCount=19;}];
        CPUCHECK(!Coordinator.boundary && Coordinator.model.isValid && CpuUnreadGetterReads>=1000);
        CPUCHECK(![event[@"allChangesKnown"] boolValue] && ([event[@"changes"] unsignedIntegerValue]&CSGroupChangeUnknown));
        old=Coordinator.model;CpuUnreadGetterReads=0;
        PublishPolicy(MakePolicy(@[],NO,NO,nil,201));
        CPUCHECK(!Coordinator.boundary && Coordinator.model.isValid && Coordinator.model!=old && CpuUnreadGetterReads>=1000);
        old=Coordinator.model;CpuUnreadGetterReads=0;Epoch++;[Coordinator refreshFromPreferences];
        CPUCHECK(!Coordinator.boundary && Coordinator.model.isValid && Coordinator.model!=old && CpuUnreadGetterReads>=1000);
        // An inner broad mutation cannot inherit the outer known-name hint.
        MMSessionInfo *other=sessions[124];CpuUnreadGetterReads=0;
        [Coordinator performChangeForUserNames:[NSSet setWithObject:changed.m_nsUserName] kind:CSGroupChangeContent original:^{
            CSNativeGroupUnknownMutation(Coordinator,Full,^{changed.m_uUnReadCount=23;other.m_uUnReadCount=29;});
        }];
        if(Coordinator.boundary || !Coordinator.model.isValid || CpuUnreadGetterReads<1000)fprintf(stderr,"Nested unknown: boundary=%d valid=%d reads=%lu event=%s\n",Coordinator.boundary,Coordinator.model.isValid,(unsigned long)CpuUnreadGetterReads,event.description.UTF8String);
        CPUCHECK(!Coordinator.boundary && Coordinator.model.isValid && CpuUnreadGetterReads>=1000);
        CPUCHECK(Coordinator.model.sourceRows[123].unreadCount==23 && Coordinator.model.sourceRows[124].unreadCount==29);
        CPUCHECK(![event[@"allChangesKnown"] boolValue] && ([event[@"changes"] unsignedIntegerValue]&CSGroupChangeUnknown));
        // Cached publication still performs native identity reads. A getter can
        // synchronously relock privacy after the earlier policy read.
        MMSessionInfo *protected=sessions[0];NSString *protectedName=[protected.m_nsUserName copy];
        Method nameGetter=class_getInstanceMethod(MMSessionInfo.class,@selector(m_nsUserName));
        CpuOriginalNameGetter=method_setImplementation(nameGetter,(IMP)CpuReentrantNameGetter);
        CpuOnNameRead=^{PublishPolicy(MakePolicy(@[protectedName],NO,NO,nil,202));};
        @try {[Coordinator refreshFromPreferences];}
        @finally {CpuOnNameRead=nil;method_setImplementation(nameGetter,CpuOriginalNameGetter);}
        CPUCHECK(Policy.revision==202);
        CPUCHECK(Coordinator.boundary || (Coordinator.model.isValid && [Coordinator.model rowForSession:protected]==nil));
        CPUCHECK(Coordinator.boundary || CSGroupReadInteger(Coordinator.model.projection,@"privacyRevision",-1)==202);
        CPUCHECK(Coordinator.boundary || ![Main.topSessions containsObject:protected]);
        PublishPolicy(MakePolicy(@[],NO,NO,nil,203));[Coordinator refreshFromPreferences];
        CPUCHECK(!Coordinator.boundary && Coordinator.model.isValid);
        [NSNotificationCenter.defaultCenter removeObserver:observer];
    } @finally {method_setImplementation(getter,CpuOriginalUnreadGetter);}
    Policy=MakePolicy(@[],NO,NO,nil,1);[Coordinator refreshFromPreferences];
}

static void CpuBridgeAndUIRegressionTests(void) {
    NewMainFrameViewController *owner=[NewMainFrameViewController new];UITableView *table=[UITableView new];owner.m_tableView=table;
    FixtureMainFrameLogic *logic=[FixtureMainFrameLogic new];owner.m_mainFrameLogicController=logic;
    FixtureMainFrameDataSource *source=[FixtureMainFrameDataSource new];source.logic=logic;table.dataSource=source;
    MMSessionInfo *a=Session(@"cpu-ui-a",2),*b=Session(@"cpu-ui-b",3),*c=Session(@"cpu-ui-c@chatroom",4);
    logic.fixtureSessions=@[@[a,b,c]];
    NSArray *oldSections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);CPUCHECK(oldSections.count==1 && [oldSections[0] count]==3);
    Method getter=class_getInstanceMethod(MMSessionInfo.class,@selector(m_uUnReadCount));
    CpuOriginalUnreadGetter=method_setImplementation(getter,(IMP)CpuCountUnreadGetter);
    @try {
        a.m_uUnReadCount=7;CpuUnreadGetterReads=0;
        NSArray *sections=CSGroupBuildNativeSectionsForChanges(owner,table,source,oldSections,CSGroupChangeUnread,[NSSet setWithObject:a.m_nsUserName]);
        CPUCHECK(sections!=nil && CpuUnreadGetterReads==1);
        CPUCHECK(sections[0][1]==oldSections[0][1] && sections[0][2]==oldSections[0][2]);
        CPUCHECK(((CSGroupRow *)sections[0][0]).unreadCount==7 && ((CSGroupRow *)oldSections[0][0]).unreadCount==2);
        CpuUnreadGetterReads=0;
        CPUCHECK(CSGroupBuildNativeSectionsForChanges(owner,table,source,sections,CSGroupChangeUnknown,[NSSet setWithObject:a.m_nsUserName])!=nil && CpuUnreadGetterReads==3);
        CpuUnreadGetterReads=0;
#if CS_STRICT_STRUCTURE_HINTS
        // Stable Structure hints now require a complete coordinate proof before
        // metadata reuse. Actual structural changes have separate full-result checks.
        CPUCHECK(CSGroupBuildNativeSectionsForChanges(owner,table,source,sections,CSGroupChangeStructure,[NSSet setWithObject:a.m_nsUserName])!=nil && CpuUnreadGetterReads==1);
#else
        CPUCHECK(CSGroupBuildNativeSectionsForChanges(owner,table,source,sections,CSGroupChangeStructure,[NSSet setWithObject:a.m_nsUserName])!=nil && CpuUnreadGetterReads==3);
#endif
        CpuUnreadGetterReads=0;
        CPUCHECK(CSGroupBuildNativeSectionsForChanges(owner,table,source,sections,CSGroupChangeUnread,nil)!=nil && CpuUnreadGetterReads==3);
        b.m_nsUserName=@"cpu-ui-replaced";
        sections=CSGroupBuildNativeSectionsForChanges(owner,table,source,sections,CSGroupChangeUnread,[NSSet setWithObject:a.m_nsUserName]);
        CPUCHECK([((CSGroupRow *)sections[0][1]).userName isEqual:b.m_nsUserName] && sections[0][1]!=oldSections[0][1]);
        __weak FixtureMainFrameLogic *weakLogic=logic;source.onRows=^{weakLogic.fixtureSessions=@[@[a,b]];};
        CPUCHECK(CSGroupBuildNativeSectionsForChanges(owner,table,source,sections,CSGroupChangeUnread,[NSSet setWithObject:a.m_nsUserName])==nil);
        source.onRows=nil;source.countOverride=0;logic.fixtureSessions=@[@[a,b,c]];
        b.m_nsUserName=@"cpu-ui-b";sections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);
        CSGroupNativeModelResult *model=Build(@[],@[a,b,c],nil,@[a,b,c],@"preset_0",YES,NSSet.set);
        NSArray *mapped=CSGroupMapNativeSectionsToProjection(sections,model.projection);
        CPUCHECK(mapped.count==1 && mapped[0][0]==model.projection.sections[0][0] && mapped[0][2]==model.projection.sections[0][2]);
        a.m_uUnReadCount=8;sections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);
        CPUCHECK(CSGroupMapNativeSectionsToProjection(sections,model.projection)==nil);
    } @finally {method_setImplementation(getter,CpuOriginalUnreadGetter);}
    CSGroupProjection *previous=Build(@[],@[a,b,c],nil,@[a,b,c],@"preset_0",YES,NSSet.set).projection;
    CSGroupRow *ra=previous.sections[0][0],*rc=previous.sections[0][2];
    CSGroupProjection *changed=[previous projectionByReplacingRows:@{ra.nativePath:CpuReplacement(ra,ra.userName,ra.category,NO,9,NO)}];
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.controller=owner;adapter.table=table;adapter.projecting=YES;
    UITableViewCell *ca=[UITableViewCell new],*cb=[UITableViewCell new];ca.fixturePath=Path(0);cb.fixturePath=Path(1);table.visibleCells=@[ca,cb];
    [adapter publishNativeProjection:changed previous:previous changes:CSGroupChangeUnread changedUserNames:[NSSet setWithObject:a.m_nsUserName] previouslyProjecting:YES];
    CPUCHECK(table.reloads==0 && table.rowReloads.count==1 && [table.rowReloads[0] isEqual:Path(0)] && table.layouts==1);
    [table.rowReloads removeAllObjects];table.layouts=0;
    CSGroupProjection *offscreen=[changed projectionByReplacingRows:@{rc.nativePath:CpuReplacement(rc,rc.userName,rc.category,NO,10,NO)}];
    [adapter publishNativeProjection:offscreen previous:changed changes:CSGroupChangeUnread changedUserNames:[NSSet setWithObject:c.m_nsUserName] previouslyProjecting:YES];
    CPUCHECK(table.reloads==0 && table.rowReloads.count==0 && table.layouts==0);
    [adapter publishNativeProjection:offscreen previous:offscreen changes:CSGroupChangeContent changedUserNames:[NSSet setWithObject:b.m_nsUserName] previouslyProjecting:YES];
    CPUCHECK(table.reloads==0 && table.rowReloads.count==1 && [table.rowReloads[0] isEqual:Path(1)] && table.layouts==1);
    [table.rowReloads removeAllObjects];table.layouts=0;
    [adapter publishNativeProjection:offscreen previous:offscreen changes:CSGroupChangeContent changedUserNames:nil previouslyProjecting:YES];
    CPUCHECK(table.reloads==0 && table.rowReloads.count==2 && table.layouts==1);
    [table.rowReloads removeAllObjects];table.layouts=0;
    [adapter publishNativeProjection:offscreen previous:offscreen changes:CSGroupChangeUnknown changedUserNames:nil previouslyProjecting:YES];
    CPUCHECK(table.reloads==1 && table.rowReloads.count==0 && table.layouts==1);
    table.reloads=0;table.layouts=0;source.countOverride=4;
    [adapter publishNativeProjection:offscreen previous:offscreen changes:CSGroupChangeUnread changedUserNames:NSSet.set previouslyProjecting:YES];
    CPUCHECK(table.reloads==1 && table.layouts==1);source.countOverride=0;
    table.reloads=0;table.layouts=0;
    [adapter publishNativeProjection:offscreen previous:offscreen changes:CSGroupChangeUnread changedUserNames:NSSet.set previouslyProjecting:NO];
    CPUCHECK(table.reloads==1 && table.layouts==1);
    #if CS_LEGACY_TOP_APIS
    table.reloads=0;table.layouts=0;adapter.pendingScrollToTop=YES;
    [adapter publishNativeProjection:offscreen previous:offscreen changes:CSGroupChangeUnread changedUserNames:NSSet.set previouslyProjecting:YES];
    CPUCHECK(table.reloads==1 && table.layouts==1);adapter.pendingScrollToTop=NO;
    #endif
    table.reloads=0;table.layouts=0;adapter.sessionLayoutHeld=YES;
    [adapter publishNativeProjection:offscreen previous:offscreen changes:CSGroupChangeUnread changedUserNames:NSSet.set previouslyProjecting:YES];
    CPUCHECK(table.reloads==0 && table.layouts==1);adapter.sessionLayoutHeld=NO;
    CSGroupProjection *otherAccount=[[CSGroupProjection alloc] initWithSections:offscreen.sections tabs:Tabs() selectedTabID:@"preset_0" filterDuplicates:NO accountID:@"other-account"];
    table.reloads=0;table.layouts=0;
    [adapter publishNativeProjection:otherAccount previous:offscreen changes:CSGroupChangeUnread changedUserNames:NSSet.set previouslyProjecting:YES];
    CPUCHECK(table.reloads==1 && table.layouts==1);
    CSGroupProjection *replaced=[[CSGroupProjection alloc] initWithSections:@[@[CpuReplacement(ra,@"new-identity",ra.category,NO,2,NO),previous.sections[0][1],rc]] tabs:Tabs() selectedTabID:@"preset_0" filterDuplicates:NO accountID:Account];
    table.reloads=0;table.layouts=0;
    [adapter publishNativeProjection:replaced previous:previous changes:CSGroupChangeContent changedUserNames:[NSSet setWithObject:a.m_nsUserName] previouslyProjecting:YES];
    CPUCHECK(table.reloads==1 && table.layouts==1);
    CSGroupListAdapter *merger=[CSGroupListAdapter new];
    [merger mergePendingChangeOfKind:CSGroupChangeUnread changedUserNames:[NSSet setWithObject:@"a"]];
    [merger mergePendingChangeOfKind:CSGroupChangeContent changedUserNames:[NSSet setWithObject:@"b"]];
    CPUCHECK(!merger.pendingChangeNamesUnknown && merger.pendingChangedUserNames.count==2 && merger.pendingChanges==(CSGroupChangeUnread|CSGroupChangeContent));
    [merger mergePendingChangeOfKind:CSGroupChangeUnknown changedUserNames:nil];
    [merger mergePendingChangeOfKind:CSGroupChangeUnread changedUserNames:[NSSet setWithObject:@"c"]];
    CPUCHECK(merger.pendingChangeNamesUnknown && [merger.pendingChangedUserNames containsObject:@"a"]);
}

static void CpuFoldedAndRetainedRegressionTests(void) {
    CSGroupRow *unknown=[[CSGroupRow alloc] initWithNativePath:Path(0) userName:@"cpu-unknown" kind:CSGroupRowKindSession category:CSGroupRowCategoryUnknown top:NO unreadCount:2 redDot:NO];
    CSGroupProjection *allTabs=[[CSGroupProjection alloc] initWithSections:@[@[unknown]] tabs:Tabs() selectedTabID:@"preset_0" filterDuplicates:NO accountID:Account];
    CSGroupProjection *updated=[allTabs projectionByReplacingRows:@{Path(0):CpuReplacement(unknown,unknown.userName,unknown.category,NO,6,NO)}];
    CPUCHECK(updated.isValid);
    for(WESessionTabItem *tab in Tabs())CPUCHECK([updated badgeForTabID:tab.tabId].count==6);
    CSGroupRow *ordinary=[[CSGroupRow alloc] initWithNativePath:Path(0) userName:@"cpu-main@chatroom" kind:CSGroupRowKindSession category:CSGroupRowCategoryGroup top:NO unreadCount:3 redDot:NO];
    CSGroupRow *aggregate=[[CSGroupRow alloc] initWithNativePath:Path(1) userName:@"chatroom_session_box" kind:CSGroupRowKindAggregate category:CSGroupRowCategoryGroup top:NO unreadCount:0 redDot:NO];
    CSGroupRow *child=[[CSGroupRow alloc] initWithNativePath:Path(0) userName:@"cpu-child@chatroom" kind:CSGroupRowKindSession category:CSGroupRowCategoryGroup top:NO unreadCount:2 redDot:YES nativeSummary:@"folded digest" sortTime:@2];
    CSGroupProjection *folded=[[CSGroupProjection alloc] initWithSections:@[@[child]] tabs:Tabs() selectedTabID:@"preset_1" filterDuplicates:NO accountID:Account];
    CSGroupProjection *(^project)(CSGroupRow *)=^CSGroupProjection *(CSGroupRow *row) {
        return [[CSGroupProjection alloc] initWithSections:@[@[row,aggregate]] tabs:Tabs() selectedTabID:@"preset_1" filterDuplicates:NO accountID:Account hiddenUserNames:NSSet.set unmaskedAggregateUserNames:NSSet.set privacyRevision:203 scopeFoldedEntry:YES foldedProjection:folded previousProjection:nil];
    };
    CSGroupProjection *before=project(ordinary);
    CPUCHECK(before.isValid && [before badgeForTabID:@"preset_1"].count==3 && [before badgeForTabID:@"preset_1"].redDot);
    CSGroupRow *changed=CpuReplacement(ordinary,ordinary.userName,ordinary.category,NO,7,NO);
    updated=[before projectionByReplacingRows:@{Path(0):changed}];
    CPUCHECK(updated.isValid && [updated badgeForTabID:@"preset_1"].count==7 && [updated badgeForTabID:@"preset_1"].redDot);
    CPUCHECK(CpuProjectionEqual(updated,project(changed),Tabs()));
    CSGroupRow *visibleBox=updated.sections[0][1];
    CSGroupProjection *mapped=[updated projectionByRemappingVisibleRows:@[@[updated.sections[0][0]],@[visibleBox]]];
    CSGroupRow *mappedBox=mapped.sections[1][0];
    CPUCHECK(mapped.isValid && mappedBox.foldedEntryScoped && [mappedBox.foldedEntryCount isEqual:visibleBox.foldedEntryCount]);
    CPUCHECK([mappedBox.foldedEntryAccountID isEqual:Account] && mappedBox.foldedEntryPrivacyRevision==203);
    CPUCHECK((mappedBox.foldedEntrySummary==visibleBox.foldedEntrySummary || [mappedBox.foldedEntrySummary isEqual:visibleBox.foldedEntrySummary]) && (mappedBox.foldedEntrySummaryUserName==visibleBox.foldedEntrySummaryUserName || [mappedBox.foldedEntrySummaryUserName isEqual:visibleBox.foldedEntrySummaryUserName]));
    CPUCHECK(mappedBox.privacyMasked==visibleBox.privacyMasked && [mapped badgeForTabID:@"preset_1"].redDot);
    CPUCHECK(CSGroupMapNativeSectionsToProjection(updated.sections,updated)==nil);
    // Full-privacy aggregate provenance survives presentation-only remapping.
    CSGroupProjection *masked=[[CSGroupProjection alloc] initWithSections:@[@[ordinary,aggregate]] tabs:Tabs() selectedTabID:@"preset_0" filterDuplicates:NO accountID:Account hiddenUserNames:[NSSet setWithObject:@"secret"] privacyRevision:204 previousProjection:nil];
    CSGroupRow *maskedBox=masked.sections[0][1];
    CPUCHECK(masked.isValid && maskedBox.privacyMasked);
    mapped=[masked projectionByRemappingVisibleRows:masked.sections];
    CPUCHECK(mapped.isValid && ((CSGroupRow *)mapped.sections[0][1]).privacyMasked);
    // An unscoped aggregate with exact copied metadata can reuse model statistics.
    CSGroupProjection *plain=[[CSGroupProjection alloc] initWithSections:@[@[ordinary,aggregate]] tabs:Tabs() selectedTabID:@"preset_0" filterDuplicates:NO accountID:Account];
    NSArray *canonical=CSGroupMapNativeSectionsToProjection(plain.sections,plain);
    CPUCHECK(canonical!=nil && canonical[0][1]==plain.sections[0][1]);
}

static void CpuHookNameRegressionTests(void) {
    MMSessionInfo *a=Session(@"hook-a",2);MainSessionInfoItem *wrapper=Wrap(a,3);
    MMBaseSessionInfo *base=[MMBaseSessionInfo new];base.sessionId=@"hook-base";
    CPUCHECK([CSNativeGroupChangedNames(@[a],nil) isEqual:[NSSet setWithObject:@"hook-a"]]);
    CPUCHECK([CSNativeGroupChangedNames(@[wrapper,base],@"hook-extra") isEqual:[NSSet setWithArray:@[@"hook-a",@"hook-base",@"hook-extra"]]]);
    CPUCHECK([CSNativeGroupChangedNames(@{@"a":a},nil) isEqual:[NSSet setWithObject:@"hook-a"]]);
    CPUCHECK([CSNativeGroupChangedNames([NSSet setWithObject:@"hook-string"],nil) isEqual:[NSSet setWithObject:@"hook-string"]]);
    CPUCHECK(CSNativeGroupChangedNames(@[NSNull.null],@"hook-a")==nil);
    CPUCHECK(CSNativeGroupChangedNames(@[],nil)==nil);
    CPUCHECK(CSNativeGroupChangedNames(@"unsupported",@"hook-a")==nil);
    CPUCHECK([ChangedSessionNames(wrapper) isEqual:[NSSet setWithObject:@"hook-a"]]);
    CPUCHECK([ChangedSessionNames(base) isEqual:[NSSet setWithObject:@"hook-base"]]);
    CPUCHECK(ChangedSessionNames(NSNull.null)==nil);
}

#undef CPUCHECK
