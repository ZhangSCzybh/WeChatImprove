// These scenarios execute extracted production methods. UIKit's pan target/action
// delivery is modeled independently from scroll-view delegate forwarding.
static void QuickTopEndDragging(ScrollRig *r,BOOL decelerate) {
    if(r.adapter.usesNativeSessionModel)FixtureDidEndDragging(r.table,decelerate);
    else {
        ScrollDragHost *host=[ScrollDragHost new];
        NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]];
        inv.selector=@selector(scrollViewDidEndDragging:willDecelerate:);id table=r.table;
        [inv setArgument:&table atIndex:2];[inv setArgument:&decelerate atIndex:3];
        [r.adapter forwardInvocation:inv target:host];
    }
}
static void QuickTopEndDecelerating(ScrollRig *r) {
    if(r.adapter.usesNativeSessionModel)FixtureDidEndDecelerating(r.table);
    else {
        ScrollDragHost *host=[ScrollDragHost new];
        NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:@selector(scrollViewDidEndDecelerating:)]];
        inv.selector=@selector(scrollViewDidEndDecelerating:);id table=r.table;[inv setArgument:&table atIndex:2];
        [r.adapter forwardInvocation:inv target:host];
    }
}
static void QuickTopFinishMotion(ScrollRig *r) {
    r.table.dragging=NO;r.table.tracking=NO;r.table.decelerating=YES;
    QuickTopEndDragging(r,YES);[r.adapter layout];
    r.table.decelerating=NO;QuickTopEndDecelerating(r);
}
static void QuickTopPrepareReturn(ScrollRig *r,CGFloat height,BOOL finished) {
    ScrollAt(r,height);Fixture_viewWillDisappear(r.owner);Fixture_viewDidDisappear(r.owner);
    Fixture_viewWillAppear(r.owner);
    if(finished)Fixture_viewDidAppear(r.owner);
}
static void __attribute__((unused)) QuickTopDelegateBegin(ScrollRig *r) {
    if(r.adapter.usesNativeSessionModel)FixtureDidBeginDragging(r.table);
    else {
        ScrollDragHost *host=[ScrollDragHost new];
        NSInvocation *inv=[NSInvocation invocationWithMethodSignature:[host methodSignatureForSelector:@selector(scrollViewWillBeginDragging:)]];
        inv.selector=@selector(scrollViewWillBeginDragging:);id table=r.table;[inv setArgument:&table atIndex:2];
        [r.adapter forwardInvocation:inv target:host];CHECK(host.beginnings==1);
    }
}
static void QuickTopTests(void) {
    const char *probe=getenv("WECHAT_QUICK_TOP_PROBE");
    const char *onlyMode=getenv("WECHAT_QUICK_TOP_MODE");
    for(NSUInteger mode=0;mode<2;mode++) {
        if(onlyMode && mode!=(NSUInteger)strtoul(onlyMode,NULL,10))continue;
        ScrollRig *r=NewScrollRig(mode==0);CSGroupListAdapter *a=r.adapter;
        // attach is the real production registration boundary. Repeated attach
        // must not multiply callbacks on the table's native pan recognizer.
        [CSGroupListAdapter attachToController:r.owner];
        [CSGroupListAdapter attachToController:r.owner];
        if(!probe || strcmp(probe,"table-pan")==0) {
            QuickTopPrepareReturn(r,1150,NO);
            CHECK(a.presentationViewport);
            r.table.tracking=YES;r.table.dragging=YES;
            [r.table.panGestureRecognizer fixtureSendState:UIGestureRecognizerStateBegan];
            // The host does not forward scrollViewWillBeginDragging: in this
            // scenario. A finger drag and its inertia still own the position.
            ScrollAt(r,0);QuickTopFinishMotion(r);
            Fixture_viewDidAppear(r.owner);[a layout];[a refresh];[a cancelScheduledRefresh];
            CheckHeight(r,0);CHECK(!a.presentationViewport && !a.switchViewport);
#if CS_TABLE_PAN_APIS
            CHECK(r.table.panGestureRecognizer.fixtureTargets.count==1);
#endif
        }
        if(!probe || strcmp(probe,"anchor")==0) {
            // A completed return creates an ordinary row anchor. The next
            // genuine drag must also invalidate that older representation.
            QuickTopPrepareReturn(r,1180,YES);CHECK(a.anchors[a.publishedTabID]);
            ScrollWillBeginDragging(r);r.table.tracking=YES;r.table.dragging=YES;
            ScrollAt(r,0);QuickTopFinishMotion(r);
            // This is the exact production restoration boundary used at the
            // end of both native and compatibility publication methods.
            [a restoreViewportFromSource:nil];CheckHeight(r,0);
            [a layout];[a refresh];[a cancelScheduledRefresh];CheckHeight(r,0);
        }
        if(!probe || strcmp(probe,"source")==0) {
            // A source viewport retained before a finger drag must not later
            // become a fresh switch request after that drag has finished.
            ScrollAt(r,1210);NSDictionary *oldSource=[a captureViewportForTabID:a.publishedTabID];CHECK(oldSource);
            a.publishing=YES;[a selectIndex:1];a.publishing=NO;
            ScrollWillBeginDragging(r);r.table.tracking=YES;r.table.dragging=YES;
            ScrollAt(r,0);QuickTopFinishMotion(r);[a refresh];[a cancelScheduledRefresh];
            CHECK([a.publishedTabID isEqual:@"preset_1"]);CheckHeight(r,0);
            [a restoreViewportFromSource:oldSource];CheckHeight(r,0);
            CHECK(!a.presentationViewport && !a.switchViewport);
        }
        if(!probe) {
            // Changed/Ended states are bookkeeping events, not a second user
            // command. A later real selection and a later chat return survive.
            ScrollAt(r,430);[a selectIndex:0];CheckHeight(r,430);
            QuickTopPrepareReturn(r,790,NO);CHECK(a.presentationViewport);
            [r.table.panGestureRecognizer fixtureSendState:UIGestureRecognizerStateChanged];
            [r.table.panGestureRecognizer fixtureSendState:UIGestureRecognizerStateEnded];
            Fixture_viewDidAppear(r.owner);CheckHeight(r,790);
            CHECK(!a.presentationViewport && !a.switchViewport);
            // A stale callback belonging to a different table is ignored.
#if CS_TABLE_PAN_APIS
            QuickTopPrepareReturn(r,810,NO);CHECK(a.presentationViewport);
            UIPanGestureRecognizer *other=[UIPanGestureRecognizer new];other.state=UIGestureRecognizerStateBegan;
            [a tablePan:other];Fixture_viewDidAppear(r.owner);CheckHeight(r,810);
#endif
            // Group horizontal gestures retain the pending shared-height
            // contract through both native-pan and delegate entry points.
#if CS_TABLE_PAN_APIS
            [Defaults setObject:@YES forKey:@"com.wechat.enhance.chat_group.swipe_gesture_enabled"];
            QuickTopPrepareReturn(r,830,NO);CHECK(a.presentationViewport);
            a.listTouchAllowed=YES;r.table.panGestureRecognizer.fixtureVelocity=CGPointMake(500,20);
            [r.table.panGestureRecognizer fixtureSendState:UIGestureRecognizerStateBegan];
            QuickTopDelegateBegin(r);CHECK(a.presentationViewport);
            r.table.panGestureRecognizer.fixtureVelocity=CGPointZero;a.listTouchAllowed=NO;
            Fixture_viewDidAppear(r.owner);CheckHeight(r,830);
            QuickTopPrepareReturn(r,850,NO);FixturePanMoving=YES;
            [r.table.panGestureRecognizer fixtureSendState:UIGestureRecognizerStateBegan];
            QuickTopDelegateBegin(r);CHECK(a.presentationViewport);FixturePanMoving=NO;
            Fixture_viewDidAppear(r.owner);CheckHeight(r,850);
            // An admitted touch with vertical motion still cancels normally.
            QuickTopPrepareReturn(r,870,NO);a.listTouchAllowed=YES;
            r.table.panGestureRecognizer.fixtureVelocity=CGPointMake(20,-500);
            [r.table.panGestureRecognizer fixtureSendState:UIGestureRecognizerStateBegan];
            ScrollAt(r,0);Fixture_viewDidAppear(r.owner);CheckHeight(r,0);
            a.listTouchAllowed=NO;r.table.panGestureRecognizer.fixtureVelocity=CGPointZero;
#endif
            // A genuine new command can arrive synchronously from the host
            // while setContentOffset is being delivered. Old restoration must
            // neither create an anchor nor consume a newer request afterward.
            QuickTopPrepareReturn(r,890,NO);ScrollAt(r,0);
            __weak ScrollRig *weakRig=r;__weak CSGroupListAdapter *weak=a;
            r.table.fixtureOnOffset=^{[weak beginUserScrolling];ScrollAt(weakRig,0);};
            Fixture_viewDidAppear(r.owner);CheckHeight(r,0);
            CHECK(!a.presentationViewport && !a.switchViewport && !a.anchors[a.publishedTabID]);
            [a restoreViewportFromSource:nil];CheckHeight(r,0);
        }
        [a cancelScheduledRefresh];[Adapters() removeObject:a];
    }
}
