// Executes the extracted production compatibility publisher and refresh entry.
// Source capture and UIKit are the controlled host boundaries, not the algorithm.
static CSGroupRow *CompatRow(NSUInteger index,NSString *name,CSGroupRowKind kind,
                             NSUInteger unread,NSString *summary,NSNumber *time) {
    return [[CSGroupRow alloc] initWithNativePath:Path(index) userName:name kind:kind
        category:CSGroupRowCategoryPrivate top:NO unreadCount:unread redDot:NO
        nativeSummary:summary sortTime:time nativePrefix:nil];
}
static CSGroupProjection *CompatProjection(NSArray *rows,NSString *selected,NSString *account,NSUInteger revision) {
    CSGroupProjection *p=[[CSGroupProjection alloc] initWithSections:@[rows] tabs:Tabs()
        selectedTabID:selected filterDuplicates:NO accountID:account hiddenUserNames:NSSet.set
        privacyRevision:revision previousProjection:nil];
    CHECK(p.isValid);return p;
}
static void CompatReset(UITableView *table) {table.reloads=0;table.layouts=0;table.rowReloads=nil;}
static void CompatPublish(CSGroupListAdapter *a,CSGroupProjection *next,CSGroupProjection *previous,
                          CSGroupChangeKind changes,NSSet *names,BOOL wasProjecting) {
#if CS_COMPAT_NAMES
    [a publishProjection:next previous:previous changes:changes changedUserNames:names previouslyProjecting:wasProjecting];
#else
    (void)names;[a publishProjection:next previous:previous changes:changes previouslyProjecting:wasProjecting];
#endif
}
static void CompatibilityPublicationTests(void) {
    NSArray *rows=@[CompatRow(0,@"compat-a",CSGroupRowKindSession,1,@"old-a",@1),
                    CompatRow(1,@"compat-b",CSGroupRowKindSession,2,@"old-b",@2),
                    CompatRow(2,@"compat-c",CSGroupRowKindSession,3,@"old-c",@3)];
    CSGroupProjection *old=CompatProjection(rows,@"preset_0",Account,1);
    NewMainFrameViewController *owner=[NewMainFrameViewController new];
    UITableView *table=[UITableView new];owner.m_tableView=table;
    FixtureMainFrameLogic *logic=[FixtureMainFrameLogic new];logic.fixtureSessions=@[rows];
    FixtureMainFrameDataSource *source=[FixtureMainFrameDataSource new];source.logic=logic;
    table.dataSource=source;owner.m_mainFrameLogicController=logic;
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.table=table;a.controller=owner;a.projecting=YES;
    UITableViewCell *ca=[UITableViewCell new],*cb=[UITableViewCell new];ca.fixturePath=Path(0);cb.fixturePath=Path(1);
    table.visibleCells=@[ca,cb];
    NSSet *onlyC=[NSSet setWithObject:@"compat-c"],*onlyA=[NSSet setWithObject:@"compat-a"];
    if(getenv("WECHAT_COMPAT_EXPECT_BASELINE")) {
        CompatPublish(a,old,old,CSGroupChangeUnread,onlyC,YES);
        CHECK(table.reloads==0 && table.rowReloads.count==0 && table.layouts==1);
        CompatReset(table);CompatPublish(a,old,old,CSGroupChangeContent,onlyA,YES);
        CHECK(table.reloads==0 && table.rowReloads.count==2 && table.layouts==1);
        printf("Baseline compatibility: offscreen unread performs synchronous layout; known content refreshes both visible rows.\n");
        return;
    }
    CompatPublish(a,old,old,CSGroupChangeUnread,onlyC,YES);
    CHECK(table.reloads==0 && table.rowReloads.count==0 && table.layouts==0);
    CompatReset(table);CompatPublish(a,old,old,CSGroupChangeContent,onlyA,YES);
    CHECK(table.reloads==0 && table.rowReloads.count==1 && [table.rowReloads[0] isEqual:Path(0)] && table.layouts==1);
    CompatReset(table);CompatPublish(a,old,old,CSGroupChangeStructure,onlyC,YES);
    CHECK(table.reloads==0 && table.rowReloads.count==0 && table.layouts==0);
    CompatReset(table);CompatPublish(a,old,old,CSGroupChangeContent,nil,YES);
    CHECK(table.reloads==0 && table.rowReloads.count==2 && table.layouts==1);
    CompatReset(table);CompatPublish(a,old,old,CSGroupChangeContent,NSSet.set,YES);
    CHECK(table.reloads==0 && table.rowReloads.count==0 && table.layouts==0);
    // Copied visible values must refresh even when a different name was hinted.
    for(NSUInteger field=0;field<4;field++) {
        CSGroupRow *r=rows[1];
        CSGroupRow *updated=[[CSGroupRow alloc] initWithNativePath:r.nativePath userName:r.userName kind:r.kind
            category:r.category top:r.top unreadCount:field==0 ? 7 : r.unreadCount redDot:field==1
            nativeSummary:field==2 ? @"changed-b" : r.nativeSummary sortTime:field==3 ? @99 : r.nativeSortTime nativePrefix:nil];
        CSGroupProjection *next=CompatProjection(@[rows[0],updated,rows[2]],@"preset_0",Account,1);
        CompatReset(table);CompatPublish(a,next,old,CSGroupChangeUnread,onlyA,YES);
        CHECK(table.reloads==0 && table.rowReloads.count==1 && [table.rowReloads[0] isEqual:Path(1)] && table.layouts==1);
    }
    // A copied content-only change leaves coordinate identity unchanged.
    CSGroupProjection *digest=CompatProjection(@[rows[0],CompatRow(1,@"compat-b",CSGroupRowKindSession,2,@"new summary",@2),rows[2]],@"preset_0",Account,1);
    CHECK(![digest hasSameDisplayStructureAs:old]); // Existing API semantics stay conservative.
    CompatReset(table);CompatPublish(a,digest,old,CSGroupChangeContent,onlyC,YES);
    CHECK(table.reloads==0 && table.rowReloads.count==1 && [table.rowReloads[0] isEqual:Path(1)] && table.layouts==1);
    CompatReset(table);a.sessionLayoutHeld=YES;CompatPublish(a,old,old,CSGroupChangeUnread,onlyC,YES);
    CHECK(table.reloads==0 && table.rowReloads.count==0 && table.layouts==1);a.sessionLayoutHeld=NO;
    // Every safety boundary retains a complete publication.
    for(NSUInteger boundary=0;boundary<10;boundary++) {
        CompatReset(table);CSGroupProjection *next=old;CSGroupChangeKind changes=CSGroupChangeUnread;BOOL was=YES;
        if(boundary==0)changes=CSGroupChangeUnknown;
        if(boundary==1)a.privacyRefreshPending=YES;
        if(boundary==2) {
#if CS_LEGACY_TOP_APIS
            a.pendingScrollToTop=YES;
#else
            continue; // Removed unreachable production top state is no contract.
#endif
        }
        if(boundary==3)source.countOverride=4;
        if(boundary==4)was=NO;
        if(boundary==5)next=CompatProjection(rows,@"preset_0",@"other-account",1);
        if(boundary==6)next=CompatProjection(rows,@"preset_2",Account,1);
        if(boundary==7)next=CompatProjection(rows,@"preset_0",Account,2);
        if(boundary==8)next=CompatProjection(@[rows[0],CompatRow(1,@"replacement",CSGroupRowKindSession,2,@"old-b",@2),rows[2]],@"preset_0",Account,1);
        if(boundary==9)next=CompatProjection(@[rows[0],rows[1]],@"preset_0",Account,1);
        CompatPublish(a,next,old,changes,onlyC,was);
        CHECK(table.reloads==1 && table.rowReloads.count==0 && table.layouts==1);
        a.privacyRefreshPending=NO;source.countOverride=0;
#if CS_LEGACY_TOP_APIS
        a.pendingScrollToTop=NO;
#endif
    }
    for(NSUInteger kind=CSGroupRowKindAggregate;kind<=CSGroupRowKindBusiness;kind++) {
        CSGroupProjection *special=CompatProjection(@[rows[0],CompatRow(1,@"special",kind,2,nil,nil),rows[2]],@"preset_0",Account,1);
        CompatReset(table);CompatPublish(a,special,special,CSGroupChangeUnread,onlyC,YES);
        CHECK(table.reloads==1 && table.layouts==1);
    }
    // Real refresh consumes the batch names. Reentrant source changes keep the
    // current publication conservative and preserve the next pending batch.
#if CS_COMPAT_NAMES
    Select(@"preset_0");FixtureActive=YES;FixturePanMoving=NO;FixtureMenuState=0;
    Policy=MakePolicy(@[],NO,NO,nil,1);Folded.chatBoxSessions=@[];
    a.preferences=[[CSGroupPreferences alloc] initWithDefaults:Defaults accountID:Account];
    a.snapshotEpoch=Epoch;a.snapshotAccount=Account;a.projection=old;a.fixtureCompatSections=@[rows];a.fixtureRealCompatibilityRefresh=YES;
    a.proxies=[NSMutableDictionary dictionary];a.nativeActions=[NSMutableArray array];a.completions=[NSMutableArray array];a.usesNativeSessionModel=NO;
    a.chrome=[WESessionTabContainerView new];a.privacyShield=[CSCloseFriendListShield new];
    CompatReset(table);[a mergePendingChangeOfKind:CSGroupChangeContent changedUserNames:onlyA];[a refresh];
    CHECK(table.reloads==0 && table.rowReloads.count==1 && [table.rowReloads[0] isEqual:Path(0)]);
    CHECK(a.pendingChanges==0 && !a.pendingChangeNamesUnknown && a.pendingChangedUserNames==nil);
    CHECK(!a.publishing && !a.dirty);
    // Unknown from an inner mutation must survive the outer known-name hint.
    CompatReset(table);[a mergePendingChangeOfKind:CSGroupChangeContent changedUserNames:onlyA];
    [a mergePendingChangeOfKind:CSGroupChangeUnknown changedUserNames:nil];[a refresh];
    CHECK(table.reloads==1 && table.layouts==1);
    CompatReset(table);a.projection=old;
    [a mergePendingChangeOfKind:CSGroupChangeContent changedUserNames:onlyA];
    __weak CSGroupListAdapter *weak=a;
    a.fixtureOnCompatSource=^{CSGroupListAdapter *target=weak;[target invalidateNativeSnapshot];
        [target mergePendingChangeOfKind:CSGroupChangeContent changedUserNames:onlyC];};
    [a refresh];CHECK(table.reloads==1 && table.layouts==1);
    CHECK(a.pendingChanges==CSGroupChangeContent && [a.pendingChangedUserNames isEqual:onlyC]);
    CHECK(!a.publishing);[a cancelScheduledRefresh];
#endif
    CHECK(!CSGroupUsesNativeIndices(table));
}

#if CS_COMPAT_SOURCE_HINTS
static void CompatPrepareSource(CSGroupListAdapter *a,NSArray *sections,CSGroupProjection *projection) {
    a.cachedNativeSections=sections;a.snapshotEpoch=Epoch;a.snapshotAccount=Account;
    a.modelRevision=20;a.snapshotRevision=19;a.projection=projection;
    a.privacyRefreshPending=NO;a.tabBadgeSections=nil;
}
static NSArray *CompatSourceValues(NSArray *sections) {
    NSMutableArray *result=[NSMutableArray array];
    for(NSArray *section in sections) {
        NSMutableArray *rows=[NSMutableArray array];
        for(CSGroupRow *row in section)[rows addObject:@[row.nativePath,row.userName ?: @"",@(row.kind),@(row.category),@(row.top),@(row.unreadCount),@(row.redDot)]];
        [result addObject:rows];
    }
    return result;
}
static void CompatibilitySourceTests(void) {
    Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},1);
    MMSessionInfo *one=Session(@"source-a",2),*two=Session(@"source-b",3),*three=Session(@"source-c",4);
    NSArray *sessions=@[one,two,three];
    NewMainFrameViewController *owner=[NewMainFrameViewController new];UITableView *table=[UITableView new];owner.m_tableView=table;
    FixtureMainFrameLogic *logic=[FixtureMainFrameLogic new];logic.fixtureSessions=@[sessions];owner.m_mainFrameLogicController=logic;
    FixtureMainFrameDataSource *source=[FixtureMainFrameDataSource new];source.logic=logic;table.dataSource=source;
    NSArray *old=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);CHECK(old.count==1 && [old[0] count]==3);
    CSGroupProjection *projection=CompatProjection(old[0],@"preset_0",Account,1);
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.table=table;a.controller=owner;a.fixtureRealCompatSource=YES;
    CSGroupTableProxy *proxy=[CSGroupTableProxy new];proxy.target=source;proxy.adapter=a;a.proxies=[@{@0:proxy} mutableCopy];
    NSSet *known=[NSSet setWithObject:one.m_nsUserName];
    Method getter=class_getInstanceMethod(MMSessionInfo.class,@selector(m_uUnReadCount));
    CpuOriginalUnreadGetter=method_setImplementation(getter,(IMP)CpuCountUnreadGetter);
    @try {
        CompatPrepareSource(a,old,projection);one.m_uUnReadCount=9;CpuUnreadGetterReads=0;
        NSArray *delta=[a nativeSectionsForAccount:Account changes:CSGroupChangeUnread changedUserNames:known];
        CHECK(delta!=nil && CpuUnreadGetterReads==1);
        CHECK(delta[0][1]==old[0][1] && delta[0][2]==old[0][2]);
        CHECK(((CSGroupRow *)delta[0][0]).unreadCount==9 && ((CSGroupRow *)old[0][0]).unreadCount==2);
        CpuUnreadGetterReads=0;CHECK([a nativeSectionsForAccount:Account changes:CSGroupChangeUnread changedUserNames:known]==delta);
        CHECK(CpuUnreadGetterReads==0);
        CompatPrepareSource(a,old,projection);CpuUnreadGetterReads=0;
        NSArray *stableStructure=[a nativeSectionsForAccount:Account changes:CSGroupChangeContent|CSGroupChangeStructure changedUserNames:known];
        CHECK(stableStructure!=nil && CpuUnreadGetterReads==1);
        CHECK(stableStructure[0][1]==old[0][1] && stableStructure[0][2]==old[0][2]);
        for(NSUInteger boundary=0;boundary<7;boundary++) {
            CompatPrepareSource(a,old,projection);CSGroupChangeKind kind=CSGroupChangeUnread;NSSet *names=known;
            Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},1);
            if(boundary==0)kind=CSGroupChangeUnknown;
            if(boundary==1){kind=CSGroupChangeStructure;logic.fixtureSessions=@[@[three,two,one]];}
            if(boundary==2)names=nil;
            if(boundary==3)a.privacyRefreshPending=YES;
            if(boundary==4)Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},2);
            if(boundary==5)Policy=MakePolicy(@[],NO,YES,@{@"hideSessions":@NO},1);
            if(boundary==6)a.snapshotEpoch=Epoch-1;
            CpuUnreadGetterReads=0;NSArray *all=[a nativeSectionsForAccount:Account changes:kind changedUserNames:names];
            if(!all || (boundary==1 ? CpuUnreadGetterReads<3 : CpuUnreadGetterReads!=3))fprintf(stderr,"Compatibility source boundary %lu: rows=%lu unread reads=%lu\n",(unsigned long)boundary,(unsigned long)all.count,(unsigned long)CpuUnreadGetterReads);
            CHECK(all!=nil && (boundary==1 ? CpuUnreadGetterReads>=3 : CpuUnreadGetterReads==3));
            logic.fixtureSessions=@[sessions];
        }
        Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},1);
        CompatPrepareSource(a,old,projection);CpuUnreadGetterReads=0;
        CHECK([a nativeSectionsForAccount:@"other-account" changes:CSGroupChangeUnread changedUserNames:known]==nil);
        CHECK(CpuUnreadGetterReads==0 && a.cachedNativeSections==nil);
        // The full identity scan still detects a renamed unhinted native row.
        CompatPrepareSource(a,old,projection);two.m_nsUserName=@"source-replaced";CpuUnreadGetterReads=0;
        NSArray *renamed=[a nativeSectionsForAccount:Account changes:CSGroupChangeUnread changedUserNames:known];
        CHECK(renamed!=nil && CpuUnreadGetterReads==2 && renamed[0][1]!=old[0][1]);
        CHECK([((CSGroupRow *)renamed[0][1]).userName isEqual:@"source-replaced"]);two.m_nsUserName=@"source-b";
        // Real new-message callbacks carry Content|Structure. A full strict
        // coordinate proof permits one named read; any uncertain structure must
        // reclassify every row, including unhinted rows before a late mismatch.
        for(NSUInteger boundary=0;boundary<7;boundary++) {
            CompatPrepareSource(a,old,projection);logic.fixtureSessions=@[sessions];
            one.isSingleChatSession=YES;three.m_bIsTop=NO;three.m_nsUserName=@"source-c";
            two.m_uUnReadCount=77;CSGroupChangeKind kind=CSGroupChangeContent|CSGroupChangeStructure;
            if(boundary==0)logic.fixtureSessions=@[@[one,three,two]];
            if(boundary==1)three.m_bIsTop=YES;
            if(boundary==2)logic.fixtureSessions=@[@[one,two],@[three]];
            if(boundary==3)logic.fixtureSessions=@[@[one,two,two]];
            if(boundary==4)one.isSingleChatSession=NO;
            if(boundary==5)three.m_nsUserName=@"chatroom_session_box";
            if(boundary==6)kind|=CSGroupChangeUnknown;
            CpuUnreadGetterReads=0;NSArray *conservative=[a nativeSectionsForAccount:Account changes:kind changedUserNames:known];
            NSUInteger reads=CpuUnreadGetterReads;
            CHECK(conservative!=nil && reads>=3);
            NSArray *complete=CSGroupBuildNativeSectionsReusing(owner,table,source,old);
            CHECK([CompatSourceValues(conservative) isEqual:CompatSourceValues(complete)]);
        }
        logic.fixtureSessions=@[sessions];one.isSingleChatSession=YES;three.m_bIsTop=NO;three.m_nsUserName=@"source-c";two.m_uUnReadCount=3;
        // A source getter can invalidate any key while the bridge is enumerating.
        for(NSUInteger boundary=0;boundary<4;boundary++) {
            CompatPrepareSource(a,old,projection);Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},1);
            NSUInteger epoch=Epoch;NSString *account=Account;__weak CSGroupListAdapter *weak=a;
            source.onRows=^{
                if(boundary==0)[weak invalidateNativeSnapshot];
                if(boundary==1)Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},2);
                if(boundary==2)Epoch++;
                if(boundary==3)Account=@"switched-account";
            };
            CHECK([a nativeSectionsForAccount:account changes:CSGroupChangeUnread changedUserNames:known]==nil);
            CHECK(a.cachedNativeSections==nil);source.onRows=nil;Epoch=epoch;Account=account;
        }
        // Count real expensive metadata reads for a realistic stable list. The
        // complete coordinate scan still runs; this is not a phone CPU result.
        NSMutableArray *many=[NSMutableArray array];
        for(NSUInteger index=0;index<1200;index++)[many addObject:Session([NSString stringWithFormat:@"large-source-%lu",(unsigned long)index],(unsigned int)(index%5))];
        logic.fixtureSessions=@[many];Policy=MakePolicy(@[],NO,NO,@{@"hideSessions":@NO},1);
        NSArray *largeOld=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);CHECK([largeOld[0] count]==1200);
        CSGroupProjection *largeProjection=CompatProjection(largeOld[0],@"preset_0",Account,1);
        MMSessionInfo *changed=many[601];changed.m_uUnReadCount=44;NSSet *single=[NSSet setWithObject:changed.m_nsUserName];
        CompatPrepareSource(a,largeOld,largeProjection);CpuUnreadGetterReads=0;
        NSArray *named=[a nativeSectionsForAccount:Account changes:CSGroupChangeContent|CSGroupChangeStructure changedUserNames:single];
        NSUInteger namedReads=CpuUnreadGetterReads;CHECK(named!=nil && namedReads==1);
        CompatPrepareSource(a,largeOld,largeProjection);CpuUnreadGetterReads=0;
        NSArray *complete=[a nativeSectionsForAccount:Account changes:CSGroupChangeUnknown changedUserNames:nil];
        NSUInteger completeReads=CpuUnreadGetterReads;CHECK(complete!=nil && completeReads==1200);
        CHECK([CompatSourceValues(named) isEqual:CompatSourceValues(complete)]);
        CHECK(((CSGroupRow *)named[0][601]).unreadCount==44 && ((CSGroupRow *)largeOld[0][601]).unreadCount==1);
        printf("Large compatibility source: sessions=1200 complete_metadata_reads=%lu named_metadata_reads=%lu all_row_fields_equal=YES\n",(unsigned long)completeReads,(unsigned long)namedReads);
    } @finally {method_setImplementation(getter,CpuOriginalUnreadGetter);}
    CHECK(!CSGroupUsesNativeIndices(table));Policy=MakePolicy(@[],NO,NO,nil,1);
}
#endif
