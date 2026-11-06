// Count real production resolver calls on immutable row snapshots. Native
// mutations here stay in fixture memory; no WeChat service or database exists.
static void RunFoldedRowLookupTests(void) {
    NSString *oldAccount=account;CSCloseFriendSnapshot *oldPolicy=policy;NSUInteger oldEpoch=epoch;
    account=@"folded-path-fixture";policy=Policy(@[],YES,200);
    ChatBoxSessionListViewController *host=[ChatBoxSessionListViewController new];
    host.m_tableView=[TestTable new];host.sessions=[NSMutableArray array];
    NSMutableArray *rows=[NSMutableArray array];
    for (NSUInteger i=0;i<120;i++) {
        NSString *name=[NSString stringWithFormat:@"path-%lu",(unsigned long)i];
        [host.sessions addObject:FoldedSession(name,1)];
        [rows addObject:Row(i,name,CSGroupRowKindSession,CSGroupRowCategoryPrivate,1)];
    }
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.controller=host;adapter.table=host.m_tableView;
    adapter.projection=Project(rows,@[[WESessionTabItem tabWithType:WETabTypeAll]],@"preset_0",[NSSet set],200,nil);
    adapter.dirty=YES;
    host.pathReads=0;
    Check([[adapter currentPathForRow:rows[0]] isEqual:Path(0)] && host.pathReads==1,@"folded stable coordinate reads only its native identity");
    id first=host.sessions.firstObject;[host.sessions removeObjectAtIndex:0];[host.sessions addObject:first];
    host.pathReads=0;
    BOOL resolved=YES;
    for (CSGroupRow *row in rows) if (!CSGroupResolveNativeRowPath(host,row,YES)) resolved=NO;
    Check(resolved,@"legacy moved-row baseline resolves every current identity");
    NSUInteger linear=host.pathReads;host.pathReads=0;
    resolved=YES;
    for (CSGroupRow *row in rows) if (![adapter currentPathForRow:row]) resolved=NO;
    Check(resolved,@"indexed moved rows resolve every current native identity");
    NSUInteger indexed=host.pathReads;
    Check(indexed==360 && linear==7380,@"120 moved rows use one source scan plus per-hit identity checks instead of 120 scans");
    fprintf(stdout,"Folded native path reads (120 moved rows): legacy=%lu indexed=%lu\n",(unsigned long)linear,(unsigned long)indexed);
    // Same object and row count, no modelRevision bump: a hit must notice its
    // coordinate now belongs to another row and rebuild the current name map.
    NSMutableArray *sameSource=host.sessions;NSUInteger sameCount=host.sessions.count;
    [host.sessions exchangeObjectAtIndex:0 withObjectAtIndex:30];host.pathReads=0;
    Check([[adapter currentPathForRow:rows[1]] isEqual:Path(30)] && host.pathReads>120 && host.sessions==sameSource && host.sessions.count==sameCount,
        @"same-pointer same-count reorder rejects stale hit and rebuilds without a revision signal");
    [host.sessions insertObject:FoldedSession(@"inserted",0) atIndex:0];host.pathReads=0;
    Check([[adapter currentPathForRow:rows[0]] isEqual:Path(120)] && host.pathReads>120,@"insertion during deferred refresh rebuilds a displaced cached coordinate");
    [host.sessions removeObjectAtIndex:0];host.pathReads=0;
    Check([[adapter currentPathForRow:rows[0]] isEqual:Path(119)] && host.pathReads>120,@"deletion during deferred refresh rejects an out-of-bounds cached coordinate");
    CSGroupRow *absent=Row(0,@"replacement",CSGroupRowKindSession,CSGroupRowCategoryPrivate,0);
    Check(![adapter currentPathForRow:absent],@"absent identity does not acquire another row's cached coordinate");
    host.sessions[50]=FoldedSession(@"replacement",0);host.pathReads=0;
    Check([[adapter currentPathForRow:absent] isEqual:Path(50)] && host.pathReads>120,@"same-count replacement rebuilds on miss instead of caching absence");
    adapter.modelRevision++;host.pathReads=0;
    Check([adapter currentPathForRow:rows[2]] && host.pathReads>120,@"known native model revision invalidates folded index");
    epoch++;host.pathReads=0;
    Check([adapter currentPathForRow:rows[3]] && host.pathReads>120,@"account epoch invalidates folded index even when account string is unchanged");
    account=@"different-account";host.pathReads=0;
    Check(![adapter currentPathForRow:rows[4]] && host.pathReads==0,@"old projection cannot resolve an identity under another account");
    account=@"folded-path-fixture";
    host.onPathRead=^{account=@"switched-during-read";};
    Check(![adapter currentPathForRow:rows[4]],@"account switch inside native lookup rejects the result before returning");host.onPathRead=nil;account=@"folded-path-fixture";
    host.throwsPathGetter=YES;
    Check(![adapter currentPathForRow:rows[4]],@"throwing native folded getter cannot authorize a cached coordinate");host.throwsPathGetter=NO;
    host.onPathRead=^{epoch++;};
    Check(![adapter currentPathForRow:rows[5]],@"epoch change inside native lookup is rejected before returning a coordinate");host.onPathRead=nil;
    __weak CSGroupListAdapter *weakAdapter=adapter;
    host.onPathRead=^{weakAdapter.modelRevision++;};
    Check(![adapter currentPathForRow:rows[6]],@"model revision change inside native lookup is rejected before returning a coordinate");host.onPathRead=nil;
    host.onPathRead=^{policy=Policy(@[@"path-7"],NO,201);};
    Check(![adapter currentPathForRow:rows[7]],@"privacy lock during native lookup rechecks the identity before returning");host.onPathRead=nil;
    policy=Policy(@[],YES,202);
    // Duplicate names must still honor real/fake semantics at the final gate.
    host.sessions=(id)[NSMutableArray arrayWithObjects:FoldedSession(@"other",0),NSNull.null,FoldedSession(@"duplicate",1),nil];
    // Use an actual object getter, matching native CellData rather than KVC.
    MainFrameCellData *data=[MainFrameCellData new];data.userName=@"duplicate";host.lookupData=@{Path(1):data};adapter.modelRevision++;
    CSGroupRow *real=Row(0,@"duplicate",CSGroupRowKindSession,CSGroupRowCategoryPrivate,0);
    CSGroupRow *fake=Row(0,@"duplicate",CSGroupRowKindFake,CSGroupRowCategoryUnknown,0);
    Check([[adapter currentPathForRow:real] isEqual:Path(2)] && [[adapter currentPathForRow:fake] isEqual:Path(1)],@"indexed duplicate names retain final fake-versus-real identity validation");
    data.m_sessionInfo=host.sessions[2];
    Check(![adapter currentPathForRow:fake],@"fake cached coordinate is rejected after acquiring a real native session");
    account=oldAccount;policy=oldPolicy;epoch=oldEpoch;
}
