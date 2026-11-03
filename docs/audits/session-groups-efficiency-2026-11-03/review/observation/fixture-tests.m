static void ScopeTests(void) {
    UITableView *a=[UITableView new],*b=[UITableView new];
    CHECK(!CSGroupPerformanceObservesReload(a,NO));
    CHECK(!CSGroupPerformanceObservesReload(a,YES));
    CSGroupPerformancePublicationScope outer={nil,NULL,0};
    CSGroupPerformanceEnterPublication(&outer,a);
    CHECK(outer.verifiedReloadDispatch==3);
    CHECK(CSGroupPerformanceObservesReload(a,NO));
    CHECK(CSGroupPerformanceObservesReload(a,YES));
    CHECK(!CSGroupPerformanceObservesReload(b,NO));
    CSGroupPerformancePublicationScope inner={nil,NULL,0};
    CSGroupPerformanceEnterPublication(&inner,b);
    CHECK(!CSGroupPerformanceObservesReload(a,NO));
    CHECK(CSGroupPerformanceObservesReload(b,NO));
    CSGroupPerformanceLeavePublication(&inner);
    CHECK(CSGroupPerformanceObservesReload(a,NO));
    CHECK(!CSGroupPerformanceObservesReload(b,NO));
    CSGroupPerformanceEnterPublication(&inner,nil);
    CHECK(!CSGroupPerformanceObservesReload(a,NO));
    CHECK(inner.table==nil && inner.verifiedReloadDispatch==0);
    CSGroupPerformanceLeavePublication(&inner);
    CHECK(CSGroupPerformanceObservesReload(a,NO));
    @try {
        CSGroupPerformancePublicationScope exceptional={nil,NULL,0};
        CSGroupPerformanceEnterPublication(&exceptional,b);
        @try { CHECK(CSGroupPerformanceObservesReload(b,YES)); [NSException raise:@"Fixture" format:@"scope leave"]; }
        @finally { CSGroupPerformanceLeavePublication(&exceptional); }
    } @catch (NSException *e) { CHECK([e.name isEqual:@"Fixture"]); }
    CHECK(CSGroupPerformanceObservesReload(a,NO));
    CSGroupPerformanceLeavePublication(&outer);
    CHECK(outer.table==nil);
    CHECK(!CSGroupPerformanceObservesReload(a,NO));
    NSArray *fixtures=@[[InheritedTable new],[OverrideDataTable new],[OverrideRowsTable new]];
    for (NSUInteger i=0;i<fixtures.count;i++) {
        UITableView *table=fixtures[i];CSGroupPerformancePublicationScope scope={nil,NULL,0};
        CSGroupPerformanceEnterPublication(&scope,table);
        CHECK(CSGroupPerformanceObservesReload(table,NO)==(i!=1));
        CHECK(CSGroupPerformanceObservesReload(table,YES)==(i!=2));
        CHECK(!CSGroupPerformanceObservesReload(a,NO));
        CSGroupPerformanceLeavePublication(&scope);
        CHECK(!CSGroupPerformanceObservesReload(table,NO));
    }
    dispatch_semaphore_t done=dispatch_semaphore_create(0);
    [NSThread detachNewThreadWithBlock:^{ @autoreleasepool {
        CSGroupPerformancePublicationScope scope={nil,NULL,0};
        CSGroupPerformanceEnterPublication(&scope,a);
        CHECK(!NSThread.isMainThread);
        CHECK(!CSGroupPerformanceObservesReload(a,NO));
        CHECK(!CSGroupPerformanceObservesReload(a,YES));
        CHECK(scope.table==nil && scope.verifiedReloadDispatch==0);
        CSGroupPerformanceLeavePublication(&scope);
        dispatch_semaphore_signal(done);
    }}];
    CHECK(dispatch_semaphore_wait(done,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0);
    CHECK(!CSGroupPerformanceObservesReload(a,NO));
}
static void OwnershipTests(void) {
    Owners=[NSMapTable strongToStrongObjectsMapTable];Tables=[NSMapTable strongToStrongObjectsMapTable];
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];
    adapter.controller=[NewMainFrameViewController new];adapter.table=[UITableView new];
    [Owners setObject:adapter forKey:adapter.controller];[Tables setObject:adapter forKey:adapter.table];
    CHECK(CSGroupPerformanceAdapterTargetsMain(adapter));
    CHECK((CSGroupPerformanceAdapterRoute(adapter)&CSGroupPerformanceRouteNative)==0);
    CSGroupNativeSessionCoordinator.sharedCoordinator.compatibilityFallback=YES;
    CHECK((CSGroupPerformanceAdapterRoute(adapter)&CSGroupPerformanceRouteCompatibilityFallback)!=0);
    CHECK(CSGroupPerformanceAdapterTargetsMain(adapter));
    adapter.usesNativeSessionModel=YES;
    CHECK((CSGroupPerformanceAdapterRoute(adapter)&CSGroupPerformanceRouteNative)!=0);
    CHECK(CSGroupPerformanceAdapterTargetsMain(adapter));
    CHECK((CSGroupPerformanceAdapterRoute(adapter)&CSGroupPerformanceRouteMainThread)!=0);
    dispatch_semaphore_t done=dispatch_semaphore_create(0);
    [NSThread detachNewThreadWithBlock:^{ @autoreleasepool {
        CHECK((CSGroupPerformanceAdapterRoute(adapter)&CSGroupPerformanceRouteMainThread)==0);
        CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
        dispatch_semaphore_signal(done);
    }}];
    CHECK(dispatch_semaphore_wait(done,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0);
    [Tables removeObjectForKey:adapter.table];CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
    [Tables setObject:[CSGroupListAdapter new] forKey:adapter.table];CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
    [Tables setObject:adapter forKey:adapter.table];
    [Owners removeObjectForKey:adapter.controller];CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
    [Owners setObject:[CSGroupListAdapter new] forKey:adapter.controller];CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
    adapter.controller=[NSObject new];[Owners setObject:adapter forKey:adapter.controller];
    CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
    adapter.controller=[FoldedFrame new];[Owners setObject:adapter forKey:adapter.controller];
    CHECK((CSGroupPerformanceAdapterRoute(adapter)&CSGroupPerformanceRouteFolded)!=0);
    CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
    adapter.controller=nil;CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
    adapter.table=nil;CHECK(!CSGroupPerformanceAdapterTargetsMain(adapter));
}
static void HintTests(void) {
    CHECK(!CSGroupPerformanceHintIsKnown(nil,CSGroupChangeUnread));
    CHECK(!CSGroupPerformanceHintIsKnown((id)@[@"a"],CSGroupChangeContent));
    CHECK(!CSGroupPerformanceHintIsKnown([NSSet setWithObject:@1],CSGroupChangeContent));
    CHECK(!CSGroupPerformanceHintIsKnown([NSSet setWithObject:@""],CSGroupChangeContent));
    CHECK(!CSGroupPerformanceHintIsKnown([NSSet setWithObject:@"a"],CSGroupChangeContent|CSGroupChangeUnknown));
    CHECK(CSGroupPerformanceHintIsKnown(NSSet.set,CSGroupChangeUnread));
    CHECK(CSGroupPerformanceHintIsKnown([NSSet setWithObject:@"a"],CSGroupChangeUnread));
    CHECK(CSGroupPerformanceHintIsKnown([NSSet setWithObject:@"a"],CSGroupChangeContent|CSGroupChangeStructure));
}
int main(void) { @autoreleasepool { ScopeTests();OwnershipTests();HintTests();printf("PASS %lu observation scope, owner and hint checks\n",(unsigned long)Checks); } return 0; }
