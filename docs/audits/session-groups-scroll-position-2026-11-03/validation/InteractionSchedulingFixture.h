// Uses the exact extracted production native refresh, scheduler and wakeup hooks.
// FixtureJobs replaces only the dispatch clock, without changing method bodies.
static NSUInteger FixtureNativeEndCallbacks;
#include "NativeInteractionCallbacks.h"

static CSGroupListAdapter *InteractionAdapter(NewMainFrameViewController **retainedOwner,UITableView **retainedTable) {
    FixturePanMoving=NO;FixtureMenuState=0;FixtureActive=YES;
    FixtureNow=100;FixtureJobs=[NSMutableArray array];FixtureJobsEnqueued=0;FixtureJobsExecuted=0;
    Policy=MakePolicy(@[],NO,NO,nil,Policy.revision+1);
    MMSessionInfo *one=Session(@"interaction-a",2),*two=Session(@"interaction-b@chatroom",3);
    Main.hostTop=@[];Main.hostNormal=@[one,two];Main.hostAllTop=@[];Main.hostTotal=0;
    Full->m_arrSession=Main.hostNormal;Folded.chatBoxSessions=@[];
    Select(@"preset_0");[Main rebuildMainSessions];
    NewMainFrameViewController *owner=[NewMainFrameViewController new];
    UITableView *table=[UITableView new];owner.m_tableView=table;
    FixtureMainFrameLogic *logic=[FixtureMainFrameLogic new];logic.useManager=YES;owner.m_mainFrameLogicController=logic;
    FixtureMainFrameDataSource *source=[FixtureMainFrameDataSource new];source.logic=logic;table.dataSource=source;
    [CSGroupListAdapter attachToController:owner];
    CSGroupListAdapter *a=[CSGroupListAdapter adapterForController:owner];
    CHECK(a.usesNativeSessionModel && a.projection.isValid && !Coordinator.compatibilityFallback);
    [a cancelScheduledRefresh];FixtureJobs=[NSMutableArray array];FixtureJobsEnqueued=0;FixtureJobsExecuted=0;
    a.dirty=NO;*retainedOwner=owner;*retainedTable=table;return a;
}
static void SetInteractionState(CSGroupListAdapter *a,UITableView *table,NSUInteger state,BOOL active) {
    switch(state) {
        case 0:table.decelerating=active;break;
        case 1:table.dragging=active;break;
        case 2:table.editing=active;break;
        case 3:a.swipeActive=active;break;
        case 4:table.tracking=active;break;
        case 5:FixturePanMoving=active;break;
        case 6:FixtureMenuState=active ? 1 : 0;break;
        case 7:FixtureMenuState=active ? 3 : 0;break;
    }
}
static void InteractionSchedulingTests(void) {
    NewMainFrameViewController *owner;UITableView *table;
    CSGroupListAdapter *a=InteractionAdapter(&owner,&table);
    table.decelerating=YES;
    CHECK(!table.tracking && !table.dragging);
    [a requestRefresh];NSUInteger executed=DrainFixtureJobs(0,64);
    BOOL baseline=getenv("WECHAT_INTERACTION_EXPECT_BASELINE")!=NULL;
    if(baseline) {
        CHECK(executed==64 && FixtureJobs.count>0 && a.dirty);
        CHECK(FixtureJobsExecuted==64 && FixtureJobsEnqueued>=65);
        printf("Baseline 2.2-8: dirty+decelerating+tracking=false executed %lu immediate jobs with another pending; stopped at fixture budget.\n",(unsigned long)executed);
        [a cancelScheduledRefresh];FixtureJobs=[NSMutableArray array];table.decelerating=NO;[Adapters() removeObject:a];return;
    }
    CHECK(executed==0 && a.scheduledInteraction && a.dirty);
    CHECK(a.scheduledRefreshDue>FixtureNow && FixtureJobsEnqueued==1);
    [a cancelScheduledRefresh];FixtureJobs=[NSMutableArray array];[Adapters() removeObject:a];
    for(NSUInteger state=0;state<8;state++) {
        a=InteractionAdapter(&owner,&table);SetInteractionState(a,table,state,YES);
        NSUInteger initialReloads=table.reloads,initialLayouts=table.layouts;
        [a requestRefresh];CHECK(a.dirty && a.scheduledInteraction && a.scheduledRefreshDue>FixtureNow);
        for(NSUInteger step=0;step<18;step++)Advance(.137);
        CHECK(a.dirty && !a.publishing && !a.scheduled && FixtureJobs.count==0);
        CHECK(FixtureJobsExecuted<=10 && table.reloads==initialReloads && table.layouts==initialLayouts);
        NSUInteger enqueued=FixtureJobsEnqueued;
        for(NSUInteger repeat=0;repeat<5;repeat++)[a requestCoalescedRefresh];
        CHECK(a.dirty && FixtureJobsEnqueued==enqueued && FixtureJobs.count==0);
        // New native data arrives after the retry window expired. The latest
        // data must publish from the real terminal callback, without a timer.
        MMSessionInfo *changed=Full->m_arrSession[0];changed.m_uUnReadCount=40+(unsigned int)state;
        [Coordinator performNativeMutationForManager:Full original:^{}];
        [a mergePendingChangeOfKind:CSGroupChangeUnknown changedUserNames:nil];
        a.immediateRefreshPending=YES;
        SetInteractionState(a,table,state,NO);
        if(state==0)FixtureDidEndDecelerating(table);
        else if(state==1 || state==4)FixtureDidEndDragging(table,NO);
        else if(state==2 || state==3)FixtureDidEndEditing(table,nil);
        else [a nativeMenuDidChange];
        CHECK(a.scheduled && !a.scheduledInteraction);
        Advance(0);
        CHECK(!a.dirty && !a.publishing && a.projection.isValid && FixtureJobs.count==0);
        CHECK([a.projection badgeForTabID:@"preset_0"].count==43+state);
        CHECK(table.reloads>initialReloads);
        // Urgent privacy publication bypasses all ordinary interaction states.
        SetInteractionState(a,table,state,YES);a.privacyRefreshPending=YES;initialReloads=table.reloads;
        [a requestCoalescedRefresh];CHECK(a.scheduled && !a.scheduledInteraction && a.scheduledRefreshDue<=FixtureNow);
        Advance(0);CHECK(!a.dirty && !a.privacyRefreshPending && table.reloads>initialReloads);
        SetInteractionState(a,table,state,NO);[a cancelScheduledRefresh];FixtureJobs=[NSMutableArray array];[Adapters() removeObject:a];
    }
    // UIKit tells the drag hook that deceleration will continue; it must avoid
    // falsely publishing between hand-up and the actual deceleration end.
    a=InteractionAdapter(&owner,&table);table.decelerating=YES;[a requestRefresh];
    NSUInteger generation=a.refreshGeneration;FixtureDidEndDragging(table,YES);
    CHECK(a.refreshGeneration==generation && a.dirty && a.scheduledInteraction);
    table.decelerating=NO;FixtureDidEndDecelerating(table);Advance(0);
    CHECK(!a.dirty && !a.scheduled);
    // Native mutation nesting defers work until the outer change ends.
    a.changeDepth=1;table.decelerating=YES;[a requestRefresh];CHECK(a.dirty && !a.scheduled);
    [a endNativeChange];CHECK(a.scheduledInteraction && a.scheduledRefreshDue>FixtureNow);
    table.decelerating=NO;FixtureDidEndDecelerating(table);Advance(0);CHECK(!a.dirty);
    CHECK(FixtureNativeEndCallbacks>=7);
    // An action explicitly held for the offscreen native presentation retains
    // the existing exception even if UIKit still reports a motion state.
    a.presentationSuspended=YES;table.decelerating=YES;table.editing=YES;
    __block BOOL actionRan=NO;[a.nativeActions addObject:[^{actionRan=YES;} copy]];
    [a requestRefresh];CHECK(a.scheduled && !a.scheduledInteraction);Advance(0);
    CHECK(actionRan && a.nativeActions.count==0 && !a.dirty);
    a.presentationSuspended=NO;table.decelerating=NO;table.editing=NO;
    [a cancelScheduledRefresh];FixtureJobs=[NSMutableArray array];[Adapters() removeObject:a];
    (void)owner;
}
