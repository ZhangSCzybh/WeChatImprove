// Supplemental event/reentry coverage; primary assertions remain byte-for-byte unchanged.
#define main AdmissionPrimaryTestsMain
#import "PrivacyAdmissionCacheTests.m"
#undef main
@interface AdmissionMutableRuntimeStore : AdmissionRuntimeStore
- (BOOL)saveState:(NSDictionary *)state forAccountID:(NSString *)name error:(NSError **)error;
@end
@implementation AdmissionMutableRuntimeStore
- (BOOL)saveState:(NSDictionary *)state forAccountID:(NSString *)name error:(NSError **)error {
    (void)name;(void)error;self.fixtureState=[state copy];return YES;
}
@end
static CSGroupListAdapter *RuntimeList(void) {
    CSGroupListAdapter *adapter=Fresh();
    AdmissionMutableRuntimeStore *store=[AdmissionMutableRuntimeStore new];
    store.fixtureState=@{@"profile":CSCloseFriendNormalizeProfile(Profile(),NULL),@"muteRecords":@{}};
    NSDictionary *credential=@{@"salt":[NSMutableData dataWithLength:32],@"verifier":[NSMutableData dataWithLength:32],@"iterations":@210000,@"failures":@0,@"cooldown":@0};
    runtimeProvider=[[CSCloseFriendRuntime alloc]initWithStore:(id)store wallClock:^NSTimeInterval{return 10000;} elapsedClock:^NSTimeInterval{return 1000;} credentialReader:^NSDictionary *(NSString *name,NSError **error){(void)name;(void)error;return credential;} credentialWriter:^BOOL(NSString *name,NSDictionary *value,NSError **error){(void)name;(void)value;(void)error;return YES;}];
    [runtimeProvider synchronizeAccount:account epoch:epoch suspended:NO];
    Check([runtimeProvider revealWithShortcutToken:runtimeProvider.authenticationToken],@"runtime event setup uses public reveal API");
    policy=CSCloseFriendCurrentSnapshot();adapter.projection=Projection(32,YES);Warm(adapter);
    return adapter;
}
int main(void) { @autoreleasepool {
    checks=0;failures=0;
    for(NSString *change in @[@"projection",@"table",@"native-invalidation",@"enabled",@"revision-readable",@"retry"]){
        CSGroupListAdapter *adapter=Fresh();Warm(adapter);
        CSGroupProjection *originalProjection=adapter.projection;
        AdmissionTable *originalTable=adapter.table;
        [adapter performSessionListLayout:^{
            originalLayouts++;
            if([change isEqual:@"projection"])adapter.projection=Projection(32,NO);
            else if([change isEqual:@"table"]){AdmissionTable *replacement=[AdmissionTable new];replacement.visibleCells=originalTable.visibleCells;adapter.table=replacement;}
            else if([change isEqual:@"native-invalidation"])[adapter invalidateNativeSnapshot];
            else if([change isEqual:@"enabled"])[policy setValue:@NO forKey:@"enabled"];
            else if([change isEqual:@"retry"])adapter.snapshotRetryAttempted=YES;
            else ((AdmissionProjection *)adapter.projection).fixtureRevisionKnown=NO;
        }];
        Check(originalLayouts==1 && rowChecks==0,[change stringByAppendingString:@": initial call reuses an existing safe admission"]);
        adapter.projection=originalProjection;adapter.table=originalTable;((AdmissionProjection *)adapter.projection).fixtureRevisionKnown=YES;adapter.snapshotRetryAttempted=NO;
        rowChecks=0;originalLayouts=0;snapshotReads=0;Layout(adapter);Record([@"reentry-" stringByAppendingString:change],adapter);
        Check(rowChecks==32 && originalLayouts==1,[change stringByAppendingString:@": synchronous change prevents preserving or stamping prior admission"]);
    }
    CSGroupListAdapter *adapter=Fresh();Warm(adapter);
    [adapter performSessionListLayout:^{originalLayouts++;adapter.projection=Projection(32,YES);}];
    originalLayouts=0;rowChecks=0;Layout(adapter);Record(@"reentry-unsafe-projection",adapter);CheckHeld(adapter,@"synchronous unsafe projection replacement");
    Check(rowChecks==32,@"unsafe replacement is scanned using its own identity and never stamped from old rows");

    for(NSString *event in @[@"add-friend",@"remove-friend",@"add-group",@"remove-group",@"manual-lock",@"other-surface-option"]){
        adapter=RuntimeList();
        if([event isEqual:@"remove-group"]){
            NSMutableDictionary *initial=[runtimeProvider.currentProfile mutableCopy];initial[@"groups"]=@[@"group-fixture"];
            Check([runtimeProvider updateProfile:initial error:NULL],@"group removal setup persists a real runtime profile");
            policy=CSCloseFriendCurrentSnapshot();adapter.projection=Projection(32,YES);Warm(adapter);
        }
        CSCloseFriendSnapshot *before=CSCloseFriendCurrentSnapshot();
        if([event isEqual:@"manual-lock"])[runtimeProvider lock];
        else {
            NSMutableDictionary *profile=[runtimeProvider.currentProfile mutableCopy];
            if([event isEqual:@"add-friend"])profile[@"friends"]=@[@"protected-fixture",@"new-private-fixture"];
            else if([event isEqual:@"remove-friend"])profile[@"friends"]=@[];
            else if([event isEqual:@"add-group"])profile[@"groups"]=@[@"group-fixture"];
            else if([event isEqual:@"remove-group"])profile[@"groups"]=@[];
            else {NSMutableDictionary *options=[profile[@"options"] mutableCopy];options[@"hideContacts"]=@NO;profile[@"options"]=options;}
            Check([runtimeProvider updateProfile:profile error:NULL],[event stringByAppendingString:@": event executes real runtime updateProfile"]);
        }
        CSCloseFriendSnapshot *after=CSCloseFriendCurrentSnapshot();
        Check(after!=before && after.revision>before.revision,[event stringByAppendingString:@": real runtime replaces snapshot and advances policy revision"]);
        if([event isEqual:@"add-friend"])Check([after containsUserName:@"new-private-fixture"],@"new friend membership appears in authoritative snapshot");
        else if([event isEqual:@"remove-friend"])Check(![after containsUserName:@"protected-fixture"],@"removed friend membership disappears from authoritative snapshot");
        else if([event isEqual:@"add-group"])Check([after containsUserName:@"group-fixture"],@"new group membership appears in authoritative snapshot");
        else if([event isEqual:@"remove-group"])Check(![after containsUserName:@"group-fixture"],@"removed group membership disappears from authoritative snapshot");
        else if([event isEqual:@"manual-lock"])Check(!after.revealed && [after hidesUserName:@"protected-fixture" surface:CSCloseFriendSurfaceSession],@"manual lock immediately restores protected session semantics");
        else Check(![after.options[@"hideContacts"] boolValue] && [after.options[@"hideSessions"] boolValue],@"other surface change leaves session option semantics unchanged");
        originalLayouts=0;Layout(adapter);Record([@"runtime-" stringByAppendingString:event],adapter);
        CheckHeld(adapter,[event stringByAppendingString:@": old projection rejected"]);
        Check(adapter.dirty && adapter.layoutRequests==1,[event stringByAppendingString:@": stale projection requests one filtered publication"]);
        policy=after;adapter.projection=Projection(32,NO);originalLayouts=0;Layout(adapter);
        Check(originalLayouts==1 && !adapter.sessionLayoutHeld,[event stringByAppendingString:@": matching safe replacement resumes original layout"]);
    }
    runtimeProvider=nil;
    printf("Privacy admission events/reentry: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
