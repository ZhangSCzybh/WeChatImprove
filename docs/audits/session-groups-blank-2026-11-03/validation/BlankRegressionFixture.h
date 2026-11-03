@interface MMBaseSessionInfo:NSObject
@property(nonatomic,copy) NSString *sessionId;
@property(nonatomic) unsigned int unreadCount;
@property(nonatomic) BOOL showRedDotOuter;
@end
@implementation MMBaseSessionInfo @end
@interface FixtureCellData:NSObject
@property(nonatomic,strong) id m_sessionInfo;
@property(nonatomic,copy) NSString *userName;
@end
@implementation FixtureCellData @end

static void BridgeRepresentationTests(void) {
    NewMainFrameViewController *owner=[NewMainFrameViewController new];
    UITableView *table=[UITableView new];owner.m_tableView=table;
    FixtureMainFrameLogic *logic=[FixtureMainFrameLogic new];owner.m_mainFrameLogicController=logic;
    FixtureMainFrameDataSource *source=[FixtureMainFrameDataSource new];source.logic=logic;table.dataSource=source;
    MMSessionInfo *raw=Session(@"bridge-raw",3);raw.m_bIsTop=YES;
    MainSessionInfoItem *wrapper=Wrap(Session(@"bridge-wrapper@chatroom",5),19);wrapper.showAsRedDot=YES;
    MMBaseSessionInfo *base=[MMBaseSessionInfo new];base.sessionId=@"bridge-base@chatroom";base.unreadCount=23;base.showRedDotOuter=YES;
    MMSessionInfo *aggregate=Session(@"chatroom_session_box",7);
    logic.fixtureSessions=@[@[raw,wrapper,base,aggregate]];
    NSArray *sections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);
    CHECK(sections.count==1 && [sections[0] count]==4);
    NSArray *rows=sections[0];
    CHECK([((CSGroupRow *)rows[0]).userName isEqual:@"bridge-raw"] && ((CSGroupRow *)rows[0]).top);
    CHECK(((CSGroupRow *)rows[0]).kind==CSGroupRowKindSession && ((CSGroupRow *)rows[0]).category==CSGroupRowCategoryPrivate);
    CHECK([((CSGroupRow *)rows[1]).userName isEqual:@"bridge-wrapper@chatroom"]);
    CHECK(((CSGroupRow *)rows[1]).kind==CSGroupRowKindSession && ((CSGroupRow *)rows[1]).category==CSGroupRowCategoryGroup);
    CHECK(((CSGroupRow *)rows[1]).unreadCount==19 && ((CSGroupRow *)rows[1]).redDot);
    CHECK([((CSGroupRow *)rows[2]).userName isEqual:@"bridge-base@chatroom"]);
    CHECK(((CSGroupRow *)rows[2]).kind==CSGroupRowKindSession && ((CSGroupRow *)rows[2]).category==CSGroupRowCategoryGroup);
    CHECK(((CSGroupRow *)rows[2]).unreadCount==23 && ((CSGroupRow *)rows[2]).redDot);
    CHECK(((CSGroupRow *)rows[3]).kind==CSGroupRowKindAggregate && ((CSGroupRow *)rows[3]).category==CSGroupRowCategoryGroup);
    for(NSUInteger index=0;index<rows.count;index++) {
        CSGroupRow *row=rows[index];
        CHECK([CSGroupNativeUserNameAtPath(owner,Path(index)) isEqual:row.userName]);
        CHECK([CSGroupResolveNativeRowPath(owner,row,YES) isEqual:Path(index)]);
    }
    CHECK(CSGroupBuildNativeSectionsReusing(owner,table,source,sections)==sections);

    // Data-only rows remain Fake, with real-session presence overriding stale
    // CellData usernames when the row later becomes a real conversation.
    FixtureCellData *fake=[FixtureCellData new];fake.userName=@"bridge-fake";
    logic.fixtureSessions=@[@[NSNull.null]];logic.fixtureData=@[@[fake]];
    sections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);
    CSGroupRow *fakeRow=sections[0][0];
    CHECK(fakeRow.kind==CSGroupRowKindFake && [fakeRow.userName isEqual:fake.userName]);
    CHECK([CSGroupNativeUserNameAtPath(owner,Path(0)) isEqual:fake.userName]);
    CHECK([CSGroupResolveNativeRowPath(owner,fakeRow,YES) isEqual:Path(0)]);
    logic.fixtureSessions=@[@[Session(@"bridge-fake",9)]];
    CHECK(CSGroupResolveNativeRowPath(owner,fakeRow,YES)==nil);

    // The CellData fallback may itself contain a wrapper or MMBaseSessionInfo.
    fake.m_sessionInfo=wrapper;logic.fixtureSessions=@[@[NSNull.null]];
    sections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);
    CHECK([((CSGroupRow *)sections[0][0]).userName isEqual:@"bridge-wrapper@chatroom"]);
    CHECK([CSGroupResolveNativeRowPath(owner,sections[0][0],YES) isEqual:Path(0)]);
    fake.m_sessionInfo=base;
    sections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);
    CHECK([((CSGroupRow *)sections[0][0]).userName isEqual:@"bridge-base@chatroom"]);
    CHECK([CSGroupNativeUserNameAtPath(owner,Path(0)) isEqual:@"bridge-base@chatroom"]);

    // Anonymous native business rows can render while the source remains
    // anonymous, but cannot be reused after a real session occupies the slot.
    fake.userName=nil;fake.m_sessionInfo=nil;
    sections=CSGroupBuildNativeSectionsReusing(owner,table,source,nil);
    CSGroupRow *business=sections[0][0];
    CHECK(business.kind==CSGroupRowKindBusiness && business.userName==nil);
    CHECK([CSGroupResolveNativeRowPath(owner,business,YES) isEqual:Path(0)]);
    logic.fixtureSessions=@[@[raw]];
    CHECK(CSGroupResolveNativeRowPath(owner,business,YES)==nil);
    logic.fixtureSessions=@[@[]];
    CHECK(CSGroupResolveNativeRowPath(owner,business,NO)==nil);

    // A host row count changed during enumeration invalidates the real bridge
    // snapshot; a read-only callback cannot stamp incomplete rows as stable.
    logic.fixtureData=nil;logic.fixtureSessions=@[@[raw]];
    __weak FixtureMainFrameLogic *weak=logic;
    source.onRows=^{weak.fixtureSessions=@[@[raw,wrapper]];};
    CHECK(CSGroupBuildNativeSectionsReusing(owner,table,source,nil)==nil);
}

static void NativeAvailabilityRegressionTests(void) {
    PublishPolicy(MakePolicy(@[],NO,NO,nil,201));Select(@"preset_0");
    MMSessionInfo *raw=Session(@"availability-a",7);
    MainSessionInfoItem *wrapper=Wrap(Session(@"availability-a",8),17);
    Main.hostTop=nil;Main.hostNormal=@[wrapper];Main.hostAllTop=@[];Main.hostTotal=0;Full->m_arrSession=@[raw];
    [Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && !Coordinator.compatibilityFallback && Main.normalSessions.count==1);
    CHECK([Coordinator.model rowForSession:wrapper].unreadCount==7);
    Main.hostTop=@[wrapper];Main.hostNormal=nil;Main.hostAllTop=@[wrapper];Main.hostTotal=1;
    [Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && Main.topSessions.count==1 && Main.normalSessions.count==0);
    Main.hostTop=@[];Main.hostNormal=@[wrapper];Main.hostAllTop=nil;Main.hostTotal=0;
    [Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    Full->m_arrSession=nil;[Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    CHECK([Coordinator.model rowForSession:wrapper].unreadCount==17);
    __block BOOL entered=NO;
    CHECK([Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered=YES;}]);
    CHECK(entered && Main.normalSessions.count==1);
    Full->m_arrSession=@[raw];[Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && [Coordinator.model rowForSession:wrapper].unreadCount==7);
    raw.isHidden=YES;[Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    CHECK([Coordinator.model rowForSession:wrapper].unreadCount==17);
    raw.isHidden=NO;raw.isSingleChatSession=NO;[Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && [Coordinator.model rowForSession:wrapper].unreadCount==17);
    raw.isSingleChatSession=YES;Full->m_arrSession=@[raw,Session(@"availability-a",100)];[Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && [Coordinator.model rowForSession:wrapper].unreadCount==17);
    Full->m_arrSession=nil;
    PublishPolicy(MakePolicy(@[@"availability-a"],NO,NO,nil,202));
    CHECK(!Coordinator.boundary && Main.normalSessions.count==0);
    PublishPolicy(MakePolicy(@[@"availability-a"],YES,NO,nil,203));
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    Main.hostTop=nil;Main.hostNormal=nil;Main.hostAllTop=@[];
    [Main rebuildMainSessions];
    CHECK(Coordinator.boundary && !Coordinator.compatibilityFallback);
    Main.hostTop=@[];Main.hostNormal=@[wrapper];[Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
}

static void HandoffIntegrityRegressionTests(void) {
    MainSessionMgr *savedMain=Main;CSGroupNativeSessionCoordinator *savedCoordinator=Coordinator;
    NSArray *savedRaw=Full->m_arrSession;
    for(NSUInteger scenario=0;scenario<2;scenario++) {
        Main=[MainSessionMgr new];Coordinator=[CSGroupNativeSessionCoordinator new];
        NewMainFrameViewController *owner=[NewMainFrameViewController new];[Coordinator setMainController:owner];
        Policy=MakePolicy(@[],NO,NO,nil,205+scenario);
        MMSessionInfo *private=Session(@"handoff-private",3),*group=Session(@"handoff-group@chatroom",5);
        Main.hostTop=@[private];Main.hostNormal=@[group];Main.hostAllTop=@[private];Main.hostTotal=1;
        Full->m_arrSession=@[private,group];Select(@"preset_0");
        CHECK(!Coordinator.boundary && Main.topSessions.count==1 && Main.normalSessions.count==1);
        if(scenario==0) {
            Select(@"preset_1");CHECK(Main.topSessions.count==0 && Main.normalSessions.count==1);
            MMSessionInfo *added=Session(@"handoff-arriving@chatroom",7);
            Main.onSetNormal=^{
                [Coordinator performNativeMutationForManager:Full original:^{
                    // A real source notification changes the complete host
                    // input while restore setters still target the old list.
                    Main.hostNormal=@[group,added];Full->m_arrSession=@[private,group,added];
                }];
            };
            [Coordinator useCompatibilityFallback];
            CHECK(Coordinator.compatibilityFallback && !Coordinator.boundary);
            CHECK(Main.topSessions.count==1 && Main.normalSessions.count==2 && Main.normalSessions[1]==added);
        } else {
            Main.rejectNormalWrites=YES;Select(@"preset_1");
            CHECK(Coordinator.boundary && !Coordinator.applied && !Coordinator.compatibilityFallback);
            CHECK(Main.topSessions.count==0 && Main.normalSessions.count==1);
            Main.rejectNormalWrites=NO;[Coordinator useCompatibilityFallback];
            CHECK(Coordinator.compatibilityFallback && !Coordinator.boundary);
            CHECK(Main.topSessions.count==1 && Main.topSessions[0]==private && Main.normalSessions.count==1);
        }
        (void)owner;
    }
    Main=savedMain;Coordinator=savedCoordinator;Full->m_arrSession=savedRaw;
}

static void CompatibilityFallbackRegressionTests(NewMainFrameViewController *owner) {
    // Unknown/blocked privacy must stay closed even when fallback is requested.
    PublishPolicy(MakePolicy(@[],NO,YES,nil,210));
    [Coordinator useCompatibilityFallback];
    CHECK(!Coordinator.compatibilityFallback && Coordinator.boundary);
    PublishPolicy(MakePolicy(@[],NO,NO,nil,211));
    // A concrete private ABI mismatch must select compatibility automatically;
    // never rely only on directly calling the public escape hatch in a test.
    Class incompatible=objc_allocateClassPair(MainSessionMgr.class,"FixtureUnsupportedMainSessionMgr",0);
    CHECK(incompatible!=Nil);
    IMP totalSetter=class_getMethodImplementation(MainSessionMgr.class,@selector(setTotalTopSessionCount:));
    CHECK(class_addMethod(incompatible,@selector(setTotalTopSessionCount:),totalSetter,"v@:I"));
    objc_registerClassPair(incompatible);
    MainSessionMgr *savedMain=Main,*unsupportedManager=[incompatible new];
    unsupportedManager.normalSessions=[NSMutableArray arrayWithObject:Session(@"unsupported-host",1)];
    unsupportedManager.hostTop=@[];unsupportedManager.hostNormal=[unsupportedManager.normalSessions copy];unsupportedManager.hostAllTop=@[];
    Main=unsupportedManager;
    CSGroupNativeSessionCoordinator *unsupportedCoordinator=[CSGroupNativeSessionCoordinator new];
    CSGroupNativeSessionCoordinator *savedCoordinator=Coordinator;Coordinator=unsupportedCoordinator;
    [unsupportedCoordinator refreshFromPreferences];
    CHECK(unsupportedCoordinator.compatibilityFallback && !unsupportedCoordinator.boundary);
    CHECK(unsupportedManager.normalSessions.count==1);
    Main=savedMain;Coordinator=savedCoordinator;
    MMSessionInfo *private=Session(@"fallback-private",3),*group=Session(@"fallback-group@chatroom",5);
    Main.hostTop=@[];Main.hostNormal=@[private,group];Main.hostAllTop=@[];Main.hostTotal=0;Full->m_arrSession=@[private,group];
    [Main rebuildMainSessions];Select(@"preset_1");
    CHECK(Main.normalSessions.count==1 && Main.normalSessions[0]==group);

    // Drive the actual bounded-recovery and source-notification bodies through
    // all three real retry delays and a successful reset, then reject metadata
    // again while external source notifications wake each following attempt.
    // Legacy refresh remains a separately tested downstream boundary here,
    // retaining the shield until it can publish.
    FixtureJobs=[NSMutableArray array];FixtureNow=300;
    UITableView *failureTable=[UITableView new];UITableViewCell *failureCell=[UITableViewCell new];failureTable.visibleCells=@[failureCell];
    FixtureMainFrameLogic *failureLogic=[FixtureMainFrameLogic new];failureLogic.useManager=YES;
    FixtureMainFrameDataSource *failureSource=[FixtureMainFrameDataSource new];failureSource.logic=failureLogic;failureSource.countOverride=100001;
    __block NSUInteger interleavedSourceEvents=0;
    failureSource.onSections=^{interleavedSourceEvents++;[Main rebuildMainSessions];};
    id failureDelegate=[NSObject new],failurePrefetch=[NSObject new];
    failureTable.dataSource=failureSource;failureTable.delegate=failureDelegate;failureTable.prefetchDataSource=failurePrefetch;
    owner.m_tableView=failureTable;owner.m_mainFrameLogicController=failureLogic;
    CSGroupListAdapter *failing=[CSGroupListAdapter new];failing.controller=owner;failing.table=failureTable;
    failing.usesNativeSessionModel=YES;failing.fixtureRealRecovery=YES;failing.fixtureRealNotifications=YES;
    failing.nativeActions=[NSMutableArray array];failing.completions=[NSMutableArray array];
    failing.proxies=[NSMutableDictionary dictionary];failing.anchors=[NSMutableDictionary dictionary];
    [NSNotificationCenter.defaultCenter addObserver:failing selector:@selector(nativeSessionModelChanged:)
        name:CSGroupNativeSessionModelDidChangeNotification object:nil];
    [failing refresh];
    CHECK(failing.nativeRecoveryAttempts==1 && failing.projection==nil && failureCell.hidden);
    Advance(.099);CHECK(failing.fixtureRefreshes==1 && !Coordinator.compatibilityFallback);
    Advance(.002);CHECK(failing.nativeRecoveryAttempts==2 && failing.fixtureRefreshes==2);
    Advance(.251);CHECK(failing.nativeRecoveryAttempts==3 && failing.fixtureRefreshes==3);
    Advance(.499);CHECK(failing.fixtureRefreshes==3 && !Coordinator.compatibilityFallback);
    failureSource.countOverride=0;failureSource.onSections=nil;
    Advance(.002);
    CHECK(failing.fixtureRefreshes==4 && failing.nativeRecoveryAttempts==0 && !Coordinator.compatibilityFallback);
    CHECK(failing.projection.isValid && interleavedSourceEvents==3);

    // Source events also arrive after native publication has returned. Those
    // external notifications must preserve an existing metadata-failure budget
    // even when they wake the next recovery immediately.
    failureSource.countOverride=100001;[failing refresh];
    CHECK(!failing.publishing && failing.nativeRecoveryAttempts==1);
    NSUInteger recoveryGeneration=failing.nativeRecoveryGeneration;
    [Main rebuildMainSessions];
    CHECK(!failing.publishing && failing.nativeRecoveryAttempts==1 && failing.nativeRecoveryGeneration==recoveryGeneration);
    Advance(0);CHECK(failing.nativeRecoveryAttempts==2 && !Coordinator.compatibilityFallback);
    [Main rebuildMainSessions];
    CHECK(!failing.publishing && failing.nativeRecoveryAttempts==2);
    Advance(0);CHECK(failing.nativeRecoveryAttempts==3 && !Coordinator.compatibilityFallback);
    [Main rebuildMainSessions];
    CHECK(!failing.publishing && failing.nativeRecoveryAttempts==3);
    Advance(0);
    CHECK(failing.fixtureRecoveries==7 && Coordinator.compatibilityFallback);
    CHECK(!failing.usesNativeSessionModel && failing.fixtureLegacyRefreshes==1 && failing.privacyRefreshPending && failureCell.hidden);
    CHECK([(CSGroupTableProxy *)failureTable.dataSource target]==failureSource);
    CHECK([(CSGroupTableProxy *)failureTable.delegate target]==failureDelegate);
    CHECK([(CSGroupTableProxy *)failureTable.prefetchDataSource target]==failurePrefetch);
    [NSNotificationCenter.defaultCenter removeObserver:failing];
    CHECK(Coordinator.compatibilityFallback && !Coordinator.boundary && !Coordinator.applied);
    CHECK(Main.normalSessions.count==2 && Main.normalSessions[0]==private && Main.normalSessions[1]==group);
    CHECK([Coordinator foldSessionCountWithNativeCount:73]==73);
    [Coordinator refreshFromPreferences];
    CHECK(Main.normalSessions.count==2 && Coordinator.model==nil);
    [Main rebuildMainSessions];
    CHECK(Main.normalSessions.count==2 && Coordinator.compatibilityFallback);

    // Test the actual Adapter transition body, including proxy installation and
    // the privacy shield retained until the legacy projection can publish.
    UITableView *table=[UITableView new];UITableViewCell *cell=[UITableViewCell new];table.visibleCells=@[cell];
    id data=[NSObject new],delegate=[NSObject new],prefetch=[NSObject new];
    table.dataSource=data;table.delegate=delegate;table.prefetchDataSource=prefetch;
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.table=table;adapter.controller=owner;
    adapter.usesNativeSessionModel=YES;adapter.proxies=[NSMutableDictionary dictionary];
    adapter.cachedNativeSections=@[@[]];adapter.tabBadgeSections=@[@[]];
    CHECK([adapter adoptCompatibilityModelIfNeeded]);
    CHECK(!adapter.usesNativeSessionModel && adapter.projecting && adapter.sessionLayoutHeld && adapter.privacyRefreshPending);
    CHECK(adapter.dirty && adapter.immediateRefreshPending && adapter.projection==nil && adapter.cachedNativeSections==nil);
    CHECK(adapter.tabBadgeSections==nil && cell.hidden && adapter.pendingChanges);
    CHECK([table.dataSource isKindOfClass:CSGroupTableProxy.class] && [(CSGroupTableProxy *)table.dataSource target]==data);
    CHECK([table.delegate isKindOfClass:CSGroupTableProxy.class] && [(CSGroupTableProxy *)table.delegate target]==delegate);
    CHECK([table.prefetchDataSource isKindOfClass:CSGroupTableProxy.class] && [(CSGroupTableProxy *)table.prefetchDataSource target]==prefetch);
    CHECK([adapter nativeSource]==data && ![adapter adoptCompatibilityModelIfNeeded]);

    __block BOOL entered=NO;
    CHECK([Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered=YES;}]);
    CHECK(entered);
    entered=NO;
    CHECK(![Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered=YES;Policy=MakePolicy(@[],NO,YES,nil,212);}]);
    CHECK(entered);
    entered=NO;
    CHECK(![Coordinator performWithCompleteSourceForSurface:CSCloseFriendSurfaceSession original:^{entered=YES;}]);
    CHECK(!entered);
}
