// Production Model/Projection/Coordinator equivalence tests; no simplified model.

#if CS_SELECTION_APIS
static id SelectionValue(id value) {return value ?: NSNull.null;}
static NSDictionary *SelectionRowSignature(CSGroupRow *row) {
    if(!row)return @{};
    return @{ @"path":row.nativePath,@"name":SelectionValue(row.userName),@"kind":@(row.kind),@"category":@(row.category),
      @"top":@(row.top),@"unread":@(row.unreadCount),@"dot":@(row.redDot),@"masked":@(row.privacyMasked),
      @"nativeSummary":SelectionValue(row.nativeSummary),@"time":SelectionValue(row.nativeSortTime),@"prefix":SelectionValue(row.nativePrefix),
      @"scoped":@(row.foldedEntryScoped),@"foldCount":SelectionValue(row.foldedEntryCount),
      @"foldAccount":SelectionValue(row.foldedEntryAccountID),@"foldRevision":@(row.foldedEntryPrivacyRevision),
      @"foldSummary":SelectionValue(row.foldedEntrySummary),@"foldPrefix":SelectionValue(row.foldedEntryPrefix),
      @"foldUser":SelectionValue(row.foldedEntrySummaryUserName)};
}
static NSArray *SelectionTabs(void) {
    WESessionTabItem *custom=[WESessionTabItem customTabWithName:@"selection overlap" sessionUserNames:@[@"selection-a",@"selection-b@chatroom",@"selection-child@chatroom"]];
    custom.tabId=@"selection-custom";
    return [Tabs() arrayByAddingObject:custom];
}
static BOOL SelectionProjectionEqual(CSGroupProjection *left,CSGroupProjection *right,NSArray *tabs) {
    if(!left.isValid || !right.isValid || ![left.accountID isEqual:right.accountID] || left.sections.count!=right.sections.count)return NO;
    for(NSUInteger section=0;section<left.sections.count;section++) {
        NSArray *a=left.sections[section],*b=right.sections[section];if(a.count!=b.count)return NO;
        for(NSUInteger row=0;row<a.count;row++) {
            CSGroupRow *x=a[row],*y=b[row];
            if(![SelectionRowSignature(x) isEqual:SelectionRowSignature(y)] ||
               ![[left displayPathForNativePath:x.nativePath] isEqual:[right displayPathForNativePath:y.nativePath]])return NO;
        }
    }
    for(WESessionTabItem *tab in tabs) {
        CSGroupBadge *a=[left badgeForTabID:tab.tabId],*b=[right badgeForTabID:tab.tabId];
        if(a.count!=b.count || a.redDot!=b.redDot || [left sessionCountForTabID:tab.tabId]!=[right sessionCountForTabID:tab.tabId])return NO;
    }return YES;
}
static NSUInteger SelectionProviderReads;
static CSGroupNativeModelResult *SelectionBuild(NSArray *top,NSArray *normal,NSArray *allTop,NSArray *all,NSArray *tabs,NSString *selected,BOOL enabled,BOOL duplicates,NSSet *hidden,NSArray *folded) {
    SelectionProviderReads=0;
    return [CSGroupNativeModel buildWithTopSessions:top normalSessions:normal allTopSessions:allTop allSessions:all tabs:tabs
        selectedTabID:selected groupingEnabled:enabled filterDuplicates:duplicates accountID:Account hiddenUserNames:hidden
        privacyRevision:Policy.revision scopeFoldedEntry:enabled foldedRows:folded
        rowProvider:^CSGroupRow *(id session,NSIndexPath *path,BOOL isTop) {SelectionProviderReads++;return CSGroupRowForNativeSession(session,path,isTop);}];
}
static void SelectionAssertEquivalent(CSGroupNativeModelResult *selected,CSGroupNativeModelResult *complete,NSArray *tabs,NSArray *objects) {
    CHECK(selected.isValid && complete.isValid);
    CHECK([selected.selectedTabID isEqual:complete.selectedTabID]);
    CHECK([selected.topSessions isEqual:complete.topSessions] && [selected.normalSessions isEqual:complete.normalSessions]);
    CHECK((selected.allTopSessions==nil && complete.allTopSessions==nil) || [selected.allTopSessions isEqual:complete.allTopSessions]);
    CHECK(selected.totalTopSessionCount==complete.totalTopSessionCount);
    CHECK(SelectionProjectionEqual(selected.projection,complete.projection,tabs));
    for(id object in objects)CHECK([SelectionRowSignature([selected rowForSession:object]) isEqual:SelectionRowSignature([complete rowForSession:object])]);
}
static void SelectionModelTests(void) {
    MMSessionInfo *a=Session(@"selection-a",2),*b=Session(@"selection-b@chatroom",3),*c=Session(@"selection-c",4),*box=Session(@"chatroom_session_box",7);
    MainSessionInfoItem *wa=Wrap(a,200),*wb=Wrap(b,300),*wc=Wrap(c,400);
    NSArray *top=@[wa],*normal=@[wb,wc,box],*all=@[a,b,c,box],*objects=[all arrayByAddingObjectsFromArray:@[wa,wb,wc]],*tabs=SelectionTabs();
    CSGroupRow *child=[[CSGroupRow alloc] initWithNativePath:Path(0) userName:@"selection-child@chatroom" kind:CSGroupRowKindSession category:CSGroupRowCategoryGroup top:NO unreadCount:5 redDot:NO nativeSummary:@"copied folded digest" sortTime:@9 nativePrefix:@"group:"];
    CSGroupRow *visibleChild=[[CSGroupRow alloc] initWithNativePath:Path(1) userName:@"selection-visible-private" kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:8 redDot:YES nativeSummary:@"visible child digest" sortTime:@12 nativePrefix:@"private:"];
    NSArray *foldStates=@[NSNull.null,@[],@[child],@[child,visibleChild]];
    Method getter=class_getInstanceMethod(MMSessionInfo.class,@selector(m_uUnReadCount));
    CpuOriginalUnreadGetter=method_setImplementation(getter,(IMP)CpuCountUnreadGetter);
    NSUInteger scenarios=0,transitions=0;
    @try {
        for(NSUInteger foldedCase=0;foldedCase<foldStates.count;foldedCase++)for(NSUInteger hiddenCase=0;hiddenCase<2;hiddenCase++)for(NSUInteger duplicates=0;duplicates<2;duplicates++)for(NSUInteger optionalTop=0;optionalTop<2;optionalTop++) {
            NSArray *folded=foldStates[foldedCase]==NSNull.null ? nil : foldStates[foldedCase];
            NSSet *hidden=hiddenCase ? [NSSet setWithArray:@[@"selection-a",@"selection-child@chatroom"]] : NSSet.set;
            NSArray *allTop=optionalTop ? top : nil;
            CSGroupNativeModelResult *model=SelectionBuild(top,normal,allTop,all,tabs,@"preset_0",YES,duplicates,hidden,folded);
            CHECK(model.isValid && SelectionProviderReads==7);scenarios++;
            NSArray *sourceRows=model.sourceRows;
            for(NSString *target in @[@"preset_1",@"preset_2",@"selection-custom",@"preset_0",@"preset_3",@"preset_0"]) {
                CpuUnreadGetterReads=0;SelectionProviderReads=0;
                CSGroupNativeModelResult *selected=[CSGroupNativeModel modelBySelectingTabID:target fromResult:model foldedRows:folded];
                CHECK(CpuUnreadGetterReads==0 && SelectionProviderReads==0);
                CHECK(selected.sourceRows==sourceRows);
                CSGroupNativeModelResult *complete=SelectionBuild(top,normal,allTop,all,tabs,target,YES,duplicates,hidden,folded);
                SelectionAssertEquivalent(selected,complete,tabs,objects);
                model=selected;transitions++;
            }
        }
        // Disabled grouping still selects All and preserves optional capability.
        CSGroupNativeModelResult *disabled=SelectionBuild(top,normal,nil,all,tabs,@"preset_2",NO,NO,NSSet.set,@[]);
        CSGroupNativeModelResult *selected=[CSGroupNativeModel modelBySelectingTabID:@"preset_1" fromResult:disabled foldedRows:@[]];
        SelectionAssertEquivalent(selected,SelectionBuild(top,normal,nil,all,tabs,@"preset_1",NO,NO,NSSet.set,@[]),tabs,objects);
        CSGroupNativeModelResult *enabledForInvalid=SelectionBuild(top,normal,nil,all,tabs,@"preset_2",YES,NO,NSSet.set,@[]);
        CHECK([CSGroupNativeModel modelBySelectingTabID:@"missing-tab" fromResult:enabledForInvalid foldedRows:@[]]==nil);
        // Nil means unavailable, while empty means confirmed empty. Both
        // transitions and metadata changes must reject stale folded reuse.
        CSGroupNativeModelResult *model=SelectionBuild(top,normal,top,all,tabs,@"preset_0",YES,NO,NSSet.set,nil);
        CHECK([CSGroupNativeModel modelBySelectingTabID:@"preset_1" fromResult:model foldedRows:@[]]==nil);
        model=SelectionBuild(top,normal,top,all,tabs,@"preset_0",YES,NO,NSSet.set,@[]);
        CHECK([CSGroupNativeModel modelBySelectingTabID:@"preset_1" fromResult:model foldedRows:nil]==nil);
        CHECK([CSGroupNativeModel modelBySelectingTabID:@"preset_1" fromResult:model foldedRows:@[child]]==nil);
        model=SelectionBuild(top,normal,top,all,tabs,@"preset_1",YES,NO,NSSet.set,@[child]);
        CSGroupRow *other=CpuReplacement(child,child.userName,child.category,child.top,8,child.redDot);
        CHECK([CSGroupNativeModel modelBySelectingTabID:@"preset_2" fromResult:model foldedRows:@[other]]==nil);
        NSDictionary *presentationChanges=@{@"foldedEntryCount":@2,@"foldedEntryAccountID":@"stale-account",@"foldedEntryPrivacyRevision":@999,
            @"foldedEntrySummary":@"stale digest",@"foldedEntryPrefix":@"stale prefix",@"foldedEntrySummaryUserName":@"stale-child"};
        for(NSString *key in presentationChanges) {
            CSGroupRow *changedPresentation=[[CSGroupRow alloc] initWithNativePath:child.nativePath userName:child.userName kind:child.kind category:child.category top:child.top unreadCount:child.unreadCount redDot:child.redDot nativeSummary:child.nativeSummary sortTime:child.nativeSortTime nativePrefix:child.nativePrefix];
            [changedPresentation setValue:presentationChanges[key] forKey:key];
            CHECK([CSGroupNativeModel modelBySelectingTabID:@"preset_2" fromResult:model foldedRows:@[changedPresentation]]==nil);
        }
        // A named delta must retain the complete sources for later selection,
        // including rows previously outside the selected group.
        model=SelectionBuild(top,normal,top,all,tabs,@"preset_1",YES,NO,NSSet.set,@[]);
        a.m_uUnReadCount=19;CSGroupNativeModelResult *delta=CpuUpdate(model,[NSSet setWithObject:a.m_nsUserName]);
        CHECK(delta.isValid && CpuRowReads==2);
        CpuUnreadGetterReads=0;selected=[CSGroupNativeModel modelBySelectingTabID:@"preset_2" fromResult:delta foldedRows:@[]];
        CHECK(CpuUnreadGetterReads==0);
        SelectionAssertEquivalent(selected,SelectionBuild(top,normal,top,all,tabs,@"preset_2",YES,NO,NSSet.set,@[]),tabs,objects);
        // Definitions are copied into the reusable snapshot. A caller mutating
        // its former WESessionTabItem must not rewrite membership in that snapshot.
        NSMutableArray *mutableTabs=[SelectionTabs() mutableCopy];
        model=SelectionBuild(top,normal,top,all,mutableTabs,@"preset_0",YES,NO,NSSet.set,@[]);
        ((WESessionTabItem *)mutableTabs.lastObject).sessionUserNames=@[@"selection-c"];
        selected=[CSGroupNativeModel modelBySelectingTabID:@"selection-custom" fromResult:model foldedRows:@[]];
        SelectionAssertEquivalent(selected,SelectionBuild(top,normal,top,all,SelectionTabs(),@"selection-custom",YES,NO,NSSet.set,@[]),tabs,objects);
    } @finally {method_setImplementation(getter,CpuOriginalUnreadGetter);}
    printf("Selection equivalence: %lu source/fold/privacy/duplicate/capability cases, %lu group transitions; no native unread getter reads for selection.\n",(unsigned long)scenarios,(unsigned long)transitions);
}
#endif
static void SelectionCoordinatorTests(void) {
    Policy=MakePolicy(@[],NO,NO,nil,Policy.revision+1);Folded.chatBoxSessions=@[];
    NSMutableArray *sessions=[NSMutableArray array];
    for(NSUInteger i=0;i<120;i++)[sessions addObject:Session([NSString stringWithFormat:@"selection-coordinator-%lu%@",(unsigned long)i,i%2 ? @"@chatroom" : @""],(unsigned int)(i%5))];
    Main.hostTop=[sessions subarrayWithRange:NSMakeRange(0,10)];Main.hostNormal=[sessions subarrayWithRange:NSMakeRange(10,110)];Main.hostAllTop=Main.hostTop;Main.hostTotal=10;
    Full->m_arrSession=[sessions copy];Select(@"preset_0");[Main rebuildMainSessions];CHECK(Coordinator.model.isValid && !Coordinator.boundary);
    Method getter=class_getInstanceMethod(MMSessionInfo.class,@selector(m_uUnReadCount));CpuOriginalUnreadGetter=method_setImplementation(getter,(IMP)CpuCountUnreadGetter);
    BOOL baseline=getenv("WECHAT_SELECTION_EXPECT_BASELINE")!=NULL;
    @try {
        for(NSString *target in @[@"preset_1",@"preset_2",@"preset_0",@"preset_1",@"preset_0"]) {
            CpuUnreadGetterReads=0;Select(target);NSUInteger reads=CpuUnreadGetterReads;
            CHECK(Coordinator.model.isValid && !Coordinator.boundary && [Coordinator.model.selectedTabID isEqual:target]);
            if(baseline)CHECK(reads>=120);else CHECK(reads==0);
            printf("Coordinator selection %s: %lu native unread getter reads%s\n",target.UTF8String,(unsigned long)reads,baseline ? " (2.2-8 baseline)" : "");
        }
#if CS_SELECTION_APIS
        // Configuration, privacy, epoch and real source changes must invalidate
        // source/config reuse. These checks also protect account-owned caches.
        CSGroupPreferences *prefs=[[CSGroupPreferences alloc] initWithDefaults:Defaults accountID:Account];
        CpuUnreadGetterReads=0;prefs.filterDuplicates=!prefs.filterDuplicates;[Coordinator refreshFromPreferences];
        CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120);
        CpuUnreadGetterReads=0;PublishPolicy(MakePolicy(@[[(MMSessionInfo *)sessions[0] m_nsUserName]],NO,NO,nil,Policy.revision+1));
        CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120 && [Coordinator.model rowForSession:sessions[0]]==nil);
        CpuUnreadGetterReads=0;Epoch++;[Coordinator refreshFromPreferences];CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120);
        NSString *saved=Account;Account=@"selection-account-B";Policy=MakePolicy(@[],NO,NO,nil,Policy.revision+1);
        CpuUnreadGetterReads=0;[Coordinator refreshFromPreferences];CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120 && [Coordinator.accountID isEqual:Account]);
        Account=saved;Policy=MakePolicy(@[],NO,NO,nil,Policy.revision+1);[Coordinator refreshFromPreferences];
        MMSessionInfo *changed=sessions[2];CpuUnreadGetterReads=0;
        [Coordinator performNativeMutationForManager:Full original:^{changed.m_uUnReadCount=31;}];
        CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120);
        CpuUnreadGetterReads=0;Select(@"preset_2");CHECK(Coordinator.model.isValid && CpuUnreadGetterReads==0);
        CHECK([Coordinator.model rowForSession:changed].unreadCount==31);
        // Folded-child values are freshly captured at selection. Adding a child
        // must refuse a zero-read source reuse and republish matching statistics.
        MMSessionInfo *folded=Session(@"selection-folded@chatroom",6);Folded.chatBoxSessions=@[folded];
        CpuUnreadGetterReads=0;Select(@"preset_1");CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120);
        Folded.chatBoxSessions=@[];CpuUnreadGetterReads=0;Select(@"preset_2");CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120);
        // A genuine named source delta and a pending preference selection can
        // arrive in the same coordinator publication. Neither may erase the other.
        prefs=[[CSGroupPreferences alloc] initWithDefaults:Defaults accountID:Account];prefs.selectedTabID=@"preset_1";
        MMSessionInfo *groupChanged=sessions[3];CpuUnreadGetterReads=0;
        [Coordinator performChangeForUserNames:[NSSet setWithObject:groupChanged.m_nsUserName] kind:CSGroupChangeUnread original:^{
            [Coordinator performNativeMutationForManager:Full original:^{groupChanged.m_uUnReadCount=37;}];
        }];
        CHECK(Coordinator.model.isValid && !Coordinator.boundary && [Coordinator.model.selectedTabID isEqual:@"preset_1"]);
        CHECK(CpuUnreadGetterReads>0 && CpuUnreadGetterReads<=4 && [Coordinator.model rowForSession:groupChanged].unreadCount==37);
        // Definition edits invalidate selection-only reuse, whereas selecting
        // an already validated custom definition keeps ordinary source reads zero.
        prefs=[[CSGroupPreferences alloc] initWithDefaults:Defaults accountID:Account];
        WESessionTabItem *custom=[WESessionTabItem customTabWithName:@"coordinator custom" sessionUserNames:@[changed.m_nsUserName]];
        custom.tabId=@"coordinator-selection-custom";CpuUnreadGetterReads=0;
        CHECK([prefs saveCustomTabs:@[custom] presetNames:@{} tabOrder:@[] hiddenPresetTabs:NSSet.set]);
        [Coordinator refreshFromPreferences];CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120);
        CpuUnreadGetterReads=0;Select(custom.tabId);CHECK(Coordinator.model.isValid && CpuUnreadGetterReads==0 && [Coordinator.model rowForSession:changed]!=nil);
        custom.sessionUserNames=@[groupChanged.m_nsUserName];
        CHECK([prefs saveCustomTabs:@[custom] presetNames:@{} tabOrder:@[] hiddenPresetTabs:NSSet.set]);CpuUnreadGetterReads=0;
        [Coordinator refreshFromPreferences];CHECK(Coordinator.model.isValid && CpuUnreadGetterReads>=120 && [Coordinator.model rowForSession:changed]==nil && [Coordinator.model rowForSession:groupChanged]!=nil);
        CHECK([prefs saveCustomTabs:@[] presetNames:@{} tabOrder:@[] hiddenPresetTabs:NSSet.set]);prefs.filterDuplicates=NO;Select(@"preset_0");
        // Cached source selection still performs final native identity checks.
        // A getter synchronously relocking privacy must prevent stale disclosure.
        MMSessionInfo *protected=sessions[1];NSString *protectedName=[protected.m_nsUserName copy];
        Method nameGetter=class_getInstanceMethod(MMSessionInfo.class,@selector(m_nsUserName));
        CpuOriginalNameGetter=method_setImplementation(nameGetter,(IMP)CpuReentrantNameGetter);
        CpuOnNameRead=^{PublishPolicy(MakePolicy(@[protectedName],NO,NO,nil,Policy.revision+1));};
        @try {Select(@"preset_1");}
        @finally {CpuOnNameRead=nil;method_setImplementation(nameGetter,CpuOriginalNameGetter);}
        CHECK(Coordinator.boundary || (Coordinator.model.isValid && [Coordinator.model rowForSession:protected]==nil));
        CHECK(Coordinator.boundary || ![Main.normalSessions containsObject:protected]);
#endif
    } @finally {method_setImplementation(getter,CpuOriginalUnreadGetter);}
    Policy=MakePolicy(@[],NO,NO,nil,Policy.revision+1);Folded.chatBoxSessions=@[];Select(@"preset_0");
}
