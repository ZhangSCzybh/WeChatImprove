// Independent readiness contracts. Closed gates retain scalar scroll geometry;
// through one content-free spacer; text, views and native content stay neutral.
// All external query inputs below are controlled host callbacks, not phone traces.
#define main GroupContainerCoreMain
#include "GroupContainerReturnTests.m"
#undef main

static CSGroupProjection *ContractProjection(CSGroupListAdapter *adapter,NSString *projectionAccount,BOOL invalid) {
    NSArray *sections=[adapter nativeSectionsForAccount:account];
    if(invalid) {
        CSGroupRow *row=[sections[0] firstObject];
        sections=@[@[row,row]]; // Actual duplicate native coordinates fail validation.
    }
    return [[CSGroupProjection alloc] initWithSections:sections tabs:adapter.preferences.tabs
        selectedTabID:adapter.preferences.selectedTabID filterDuplicates:NO accountID:projectionAccount
        hiddenUserNames:[NSSet setWithArray:@[@"secret-friend",@"secret@chatroom"]]
        privacyRevision:policy.revision previousProjection:nil];
}

static void ContractReject(NSString *name,void (^prepare)(CSGroupListAdapter *)) {
    scenario=[@"readiness-contract/" stringByAppendingString:name];
    policy=Policy(NO,NO,100);CSGroupListAdapter *a=List(NO);prepare(a);Reset(a);
    CSGroupProjection *before=a.projection;NSString *selected=a.preferences.selectedTabID;
    NSUInteger generation=a.refreshGeneration;BOOL dirty=a.dirty;
    __block NSInteger sections=-1,rows=-1;__block CGFloat height=-1,headerHeight=-1;
    __block NSString *title;__block UITableViewCell *cell;
    Native(a.controller,NO,^{
        sections=Count(a,@selector(numberOfSectionsInTableView:),0,NO);
        rows=Count(a,@selector(tableView:numberOfRowsInSection:),2,YES);
        height=Height(a,At(2,0));headerHeight=SectionHeight(a,2);title=SectionTitle(a,2);
        cell=[a.uiProxy tableView:a.table cellForRowAtIndexPath:At(2,0)];
    });
    Emit(@"readiness-contract-result",@{@"sections":@(sections),@"rows":@(rows),@"height":@(height),
        @"headerHeight":@(headerHeight),@"headerTitle":title ?: @"",@"cellIsNil":@(cell==nil),
        @"cellText":cell.textLabel.text ?: @"",@"cellInteraction":@(cell.userInteractionEnabled),
        @"privateNativeCellCalls":@(a.controller.privateCellCalls),@"recoveries":@(a.recoveries),
        @"fullReloads":@(a.table.reloads),@"rowReloads":@(a.table.rowReloads),@"offsetWrites":@(a.table.offsetWrites),
        @"tableLayouts":@(a.table.layouts),@"projectionRetained":@(a.projection==before),
        @"refreshGenerationUnchanged":@(a.refreshGeneration==generation),@"dirtyUnchanged":@(a.dirty==dirty)});
    Check(sections==3 && rows==14,@"unready UI query retains published scalar section and row counts");
    Check(fabs(height-floor((a.table.contentSize.height-80)/18))<0.5 && headerHeight==0 && title==nil,@"unready ordinary slot uses integer neutral height while native header content stays neutral");
    Check(cell!=nil && cell.textLabel.text.length==0 && !cell.userInteractionEnabled,@"unready required cell is nonnil empty and noninteractive");
    Check(a.controller.privateCellCalls==0,@"unready query never asks native source for protected cell");
    Check(a.recoveries==0 && a.refreshGeneration==generation,@"unready query does not refresh or request recovery");
    Check(a.table.layouts==0 && a.table.reloads==0 && a.table.rowReloads==0 && a.table.offsetWrites==0,@"unready query performs no layout reload or offset write");
    Check(a.projection==before && [a.preferences.selectedTabID isEqual:selected] && a.dirty==dirty,@"unready query retains projection selected group and dirty state");
    Check(!a.scheduled && !a.scheduledRecovery && !a.pendingImmediateRefresh,@"unready query schedules no recovery or refresh");
    Check(!CSGroupUsesNativeIndices(a.table),@"unready query unwinds the original native owner scope");
}

static void ContractDirtyReady(void) {
    scenario=@"readiness-contract/dirty-same-valid-revision";policy=Policy(NO,NO,110);
    CSGroupListAdapter *a=List(NO);a.dirty=YES;CSGroupProjection *before=a.projection;
    NSString *selected=a.preferences.selectedTabID;NSUInteger generation=a.refreshGeneration;
    Native(a.controller,NO,^{[a.table originalLayout];});
    NSDictionary *sample=a.table.geometrySamples.firstObject;BOOL protected=NO;
    for(NSString *name in a.table.submissions.firstObject)protected|=[name hasPrefix:@"secret"];
    Emit(@"dirty-ready-result",@{@"sectionCounts":sample[@"sectionCounts"] ?: @[],
        @"protectedVisible":@(protected),@"privateNativeCellCalls":@(a.controller.privateCellCalls),
        @"projectionRetained":@(a.projection==before),@"dirty":@(a.dirty),
        @"fullReloads":@(a.table.reloads),@"rowReloads":@(a.table.rowReloads),@"offsetWrites":@(a.table.offsetWrites),
        @"recoveries":@(a.recoveries),@"refreshGenerationUnchanged":@(a.refreshGeneration==generation)});
    Check([sample[@"sectionCounts"] isEqual:@[@2,@2,@14]],@"dirty same-revision query keeps verified filtered group counts");
    Check(!protected && a.controller.privateCellCalls==0,@"dirty same-revision query never delivers protected identity");
    Check(a.projection==before && [a.preferences.selectedTabID isEqual:selected] && a.dirty,@"dirty readiness query reuses projection and retains pending dirty state");
    Check(a.refreshGeneration==generation && a.recoveries==0,@"dirty readiness query does not publish refresh or recovery");
    Check(a.table.layouts==0 && a.table.reloads==0 && a.table.rowReloads==0 && a.table.offsetWrites==0,@"dirty readiness query leaves layout publication and viewport untouched");
}

static void ContractNativeUnlocked(void) {
    scenario=@"readiness-contract/nonprojecting-unlocked-ready";policy=Policy(YES,NO,120);
    CSGroupListAdapter *a=List(NO);a.projecting=NO;a.projection=nil;Reset(a);
    __block NSInteger sections=-1;__block UITableViewCell *cell;
    Native(a.controller,NO,^{sections=Count(a,@selector(numberOfSectionsInTableView:),0,NO);
        cell=[a.uiProxy tableView:a.table cellForRowAtIndexPath:At(2,0)];});
    Emit(@"unlocked-native-result",@{@"sections":@(sections),@"cellText":cell.textLabel.text ?: @"",
        @"privateNativeCellCalls":@(a.controller.privateCellCalls),@"recoveries":@(a.recoveries),
        @"fullReloads":@(a.table.reloads),@"offsetWrites":@(a.table.offsetWrites)});
    Check(sections==3 && [cell.textLabel.text isEqual:@"secret@chatroom"],@"ready unlocked native presentation preserves native visibility semantics");
    Check(a.controller.privateCellCalls==1,@"ready unlocked native presentation delivers requested source cell once");
    Check(a.recoveries==0 && a.table.reloads==0 && a.table.offsetWrites==0,@"ready unlocked query adds no refresh or viewport work");
}

int main(void) {@autoreleasepool {
    Emit(@"probe-boundary",@{@"deviceEvidence":@NO,@"scope":@"Independent readiness contracts; 2.1-31 supersedes zero geometry with scalar-only retained geometry; privacy assertions are retained"});
    ContractReject(@"nil-policy-projecting",^(CSGroupListAdapter *a){(void)a;policy=nil;});
    ContractReject(@"nil-policy-native",^(CSGroupListAdapter *a){a.projecting=NO;a.projection=nil;policy=nil;});
    ContractReject(@"wrong-policy-account",^(CSGroupListAdapter *a){(void)a;policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"other-account" profile:@{@"enabled":@YES,@"options":@{}} revealed:NO revision:100 blocked:NO];});
    ContractReject(@"nil-projection",^(CSGroupListAdapter *a){a.projection=nil;});
    ContractReject(@"invalid-projection",^(CSGroupListAdapter *a){a.projection=ContractProjection(a,account,YES);Check(!a.projection.isValid,@"invalid-projection input is rejected by real projection validation");});
    ContractReject(@"wrong-projection-account",^(CSGroupListAdapter *a){a.projection=ContractProjection(a,@"other-account",NO);Check(a.projection.isValid,@"wrong-account input remains structurally valid");});
    ContractReject(@"stale-policy-revision",^(CSGroupListAdapter *a){(void)a;policy=Policy(NO,NO,101);});
    ContractReject(@"nonprojecting-locked",^(CSGroupListAdapter *a){a.projecting=NO;});
    ContractDirtyReady();ContractNativeUnlocked();
    Emit(@"result",@{@"checks":@(checks),@"failures":@(failures)});
    fprintf(stderr,"Group container readiness contracts HOST: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
}}
