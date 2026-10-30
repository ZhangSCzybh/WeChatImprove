#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackgroundRunPolicy.h"
#import "CSScheduledTaskStore.h"

static NSUInteger checks;
static NSString *const TextKey=@"com.wechat.tweak.navigation.separator.text";
static NSString *const ImageKey=@"com.wechat.tweak.navigation.separator.image";
static void Check(BOOL value,NSString *message){checks++;if(!value){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
@interface CSBackupEngine (LegacyPolicyFixture)
- (NSArray *)rawFields:(NSError **)error;
- (NSDictionary *)capture:(NSString *)name kind:(NSString *)kind allowingMissingAssets:(BOOL)allowMissing error:(NSError **)error;
@end
@interface PolicyFixture : NSObject
@property(nonatomic) CSBackupEngine *engine;
@property(nonatomic) NSDictionary *defaults,*domains;
- (void)clean;
@end
@implementation PolicyFixture
- (void)clean {for(NSString *alias in self.defaults)[self.defaults[alias] removePersistentDomainForName:self.domains[alias]];}
@end
static PolicyFixture *Fixture(NSURL *base,NSString *name) {
    PolicyFixture *fixture=[PolicyFixture new];NSMutableDictionary *defaults=[NSMutableDictionary dictionary],*domains=[NSMutableDictionary dictionary];
    for(NSString *alias in @[@"standard",@"legacy",@"layout"]){NSString *suite=[@"backup.background.policy." stringByAppendingString:NSUUID.UUID.UUIDString];domains[alias]=suite;defaults[alias]=[[NSUserDefaults alloc]initWithSuiteName:suite];}
    fixture.defaults=defaults;fixture.domains=domains;NSURL *root=[base URLByAppendingPathComponent:name];
    fixture.engine=[[CSBackupEngine alloc]initWithDefaults:defaults domains:domains store:[[CSBackupStore alloc]initWithRoot:[root URLByAppendingPathComponent:@"backups"]] resources:[root URLByAppendingPathComponent:@"resources"]];
    fixture.engine.context=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"policy-test-install",@"pluginVersion":@"policy-test"};};return fixture;
}
static NSDictionary *PolicyField(NSArray *fields) {
    for(NSDictionary *field in fields)if([field[@"domain"] isEqual:@"legacy"]&&[field[@"key"] isEqual:CSBackgroundRunPolicyKey])return field;return nil;
}
static NSArray *OldFields(NSArray *fields) {
    NSMutableArray *old=[NSMutableArray array];
    for(NSDictionary *field in fields) {
        if([field[@"domain"] isEqual:@"legacy"]&&[field[@"key"] isEqual:CSBackgroundRunPolicyKey])continue;
        [old addObject:field];
    }
    return old;
}
static NSDictionary *OldSnapshot(NSDictionary *snapshot) {
    NSMutableDictionary *old=[snapshot mutableCopy];old[@"fields"]=OldFields(snapshot[@"fields"]);[old removeObjectForKey:@"integrity"];
    return [CSBackupCodec decode:[CSBackupCodec encode:old error:NULL] error:NULL];
}
// Exact pre-policy v2 digest layouts. The old client had no policy registry row,
// including in the raw reset fingerprint and in runtime-sensitive revisions.
static NSString *OldRevision(CSBackupEngine *engine,BOOL reset,BOOL runtime) {
    NSDictionary *state=[engine capture:@"old client state" kind:@"protection" allowingMissingAssets:reset error:NULL];Check(state!=nil,@"capture old-client revision fixture");
    NSArray *fields=OldFields(state[@"fields"]);NSString *raw=reset?[CSBackupCodec digest:OldFields([engine rawFields:NULL])]:@"";
    if(runtime&&(state[@"scheduledTaskRevision"]||state[@"aiReplyRevision"]))return [CSBackupCodec digest:@[fields,state[@"assets"],state[@"scheduledTaskRevision"]?:@"",state[@"aiReplyRevision"]?:@"",raw,state[@"missingAssets"]?:@[]]];
    return reset?[CSBackupCodec digest:@[fields,state[@"assets"],raw,state[@"missingAssets"]?:@[]]]:[CSBackupCodec digest:@[fields,state[@"assets"]]];
}
static void Complete(CSBackupEngine *engine) {
    NSError *error=nil;Check([engine applyPending:&error],error.description?:@"apply prepared policy restore");
    Check([engine finishStartup:&error]&&[engine confirmStartup:&error],error.description?:@"finish policy restore startup");
    Check([engine cancelPending:&error],@"archive confirmed policy transaction");
}
static void LegacyPrepared(NSURL *base,BOOL reset,BOOL runtime) {
    PolicyFixture *fixture=Fixture(base,[NSString stringWithFormat:@"legacy-%d-%d",reset,runtime]);CSBackupEngine *engine=fixture.engine;NSUserDefaults *standard=fixture.defaults[@"standard"],*legacy=fixture.defaults[@"legacy"];
    NSError *error=nil;[standard setObject:@"wanted" forKey:TextKey];
    if(runtime)Check([CSScheduledTaskStore replaceState:@{@"schema":@1,@"account":@"alice",@"enabled":@YES,@"tasks":@[],@"history":@[]} atURL:CSScheduledTaskFileURL(engine.resourceRoot,@"alice") account:@"alice" error:&error],@"seed isolated runtime state");
    NSDictionary *source=[engine save:@"legacy source" error:&error];Check(source!=nil,@"save fixture before creating missing resource");
    Check(PolicyField(source[@"fields"])!=nil&&![PolicyField(source[@"fields"])[@"present"] boolValue],@"new snapshots retain explicit absent policy for clearing");
    [standard setObject:@"before" forKey:TextKey];NSString *missing=[engine.resourceRoot URLByAppendingPathComponent:@"missing.png"].path;
    if(reset)[standard setObject:missing forKey:ImageKey];
    NSDictionary *target=OldSnapshot(reset?[engine resetSnapshot:&error]:source);Check(target!=nil&&PolicyField(target[@"fields"])==nil,@"old v2 snapshot contains no new policy field");
    NSMutableSet *modules=[NSMutableSet setWithObject:@"navigation"];if(runtime)[modules addObject:@"scheduled_tasks"];
    NSDictionary *preview=[engine preview:target modules:modules accounts:[NSSet setWithObject:@"alice"] error:&error];Check(preview!=nil,error.description?:@"preview old v2 source");
    NSString *revision=OldRevision(engine,reset,runtime);Check([preview[@"revision"] isEqual:revision],@"absent policy keeps the pre-policy revision byte-for-byte");
    Check([engine prepare:preview error:&error],error.description?:@"prepare legacy transaction");
    NSMutableDictionary *journal=[[engine.store journal:NULL] mutableCopy];journal[@"revision"]=revision;
    Check(journal[@"protectionID"]==nil&&PolicyField(journal[@"before"])==nil&&PolicyField(journal[@"after"])==nil,@"old prepared fixture needs no new policy or protection file");
    Check([engine.store writeJournal:journal error:&error],@"persist old-client revision fixture");
    if(reset) {
        BOOL retained=NO;for(NSDictionary *field in journal[@"before"])if([field[@"key"] isEqual:ImageKey])retained=[field[@"value"] isEqual:missing];
        Check(retained,@"old reset journal keeps the original missing image reference");
    }
    Complete(engine);
    Check(reset?[standard objectForKey:TextKey]==nil:[[standard objectForKey:TextKey] isEqual:@"wanted"],@"legacy prepared restore/reset applies after registration changes");
    Check([legacy objectForKey:CSBackgroundRunPolicyKey]==nil,@"old transaction never materializes a policy");
    if(runtime) {
        NSDictionary *restored=[CSScheduledTaskStore readStateAtURL:CSScheduledTaskFileURL(engine.resourceRoot,@"alice") account:@"alice" error:NULL];
        Check(![restored[@"enabled"] boolValue],@"runtime restore/reset remains disabled");
    }
    if(reset)Check([standard objectForKey:ImageKey]==nil,@"legacy reset clears the selected missing reference");
    Check([engine.store records:NULL].count==1,@"legacy prepare/apply creates no automatic protection files");[fixture clean];
}
static void PolicyRoundTrip(NSURL *base) {
    PolicyFixture *source=Fixture(base,@"source"),*target=Fixture(base,@"target");NSError *error=nil;
    NSUserDefaults *original=source.defaults[@"legacy"],*destination=target.defaults[@"legacy"];
    [original setObject:CSBackgroundRunDefaultPolicy() forKey:CSBackgroundRunPolicyKey];[original setBool:YES forKey:@"BackgroundRunEnabled"];
    NSDictionary *snapshot=[source.engine save:@"new policy" error:&error];Check(snapshot!=nil&&[PolicyField(snapshot[@"fields"])[@"value"] isEqual:CSBackgroundRunDefaultPolicy()],@"manual save contains typed policy value");
    NSData *encoded=[CSBackupCodec encode:snapshot error:&error];NSDictionary *decoded=[CSBackupCodec decode:encoded error:&error];Check(decoded!=nil,@"policy backup exports and decodes");
    [destination setObject:CSBackgroundRunLegacyPolicy() forKey:CSBackgroundRunPolicyKey];
    Check([target.engine.store importSnapshot:decoded error:&error],@"policy backup imports into independent storage");
    Check([[destination objectForKey:CSBackgroundRunPolicyKey] isEqual:CSBackgroundRunLegacyPolicy()],@"import does not change current policy");
    NSSet *background=[NSSet setWithObject:@"background"],*accounts=[NSSet setWithObject:@"alice"];
    NSDictionary *preview=[target.engine preview:decoded modules:background accounts:accounts error:&error];Check(preview!=nil&&[target.engine prepare:preview error:&error],@"prepare imported policy restore");Complete(target.engine);
    Check([[destination objectForKey:CSBackgroundRunPolicyKey] isEqual:CSBackgroundRunDefaultPolicy()]&&[destination boolForKey:@"BackgroundRunEnabled"],@"typed policy and original master switch restore together");
    [original removeObjectForKey:CSBackgroundRunPolicyKey];NSDictionary *clear=[source.engine save:@"policy not configured" error:&error];
    Check(clear!=nil&&![PolicyField(clear[@"fields"])[@"present"] boolValue],@"manual backup preserves an explicit clear operation");
    preview=[target.engine preview:clear modules:background accounts:accounts error:&error];Check(preview!=nil&&[target.engine prepare:preview error:&error],@"prepare explicit policy clear");Complete(target.engine);
    Check([destination objectForKey:CSBackgroundRunPolicyKey]==nil,@"restoring explicit absence clears a newer policy");
    [destination setObject:CSBackgroundRunLegacyPolicy() forKey:CSBackgroundRunPolicyKey];NSDictionary *old=OldSnapshot(clear);
    preview=[target.engine preview:old modules:background accounts:accounts error:&error];Check(preview!=nil&&[target.engine prepare:preview error:&error],@"prepare old backup without policy field");Complete(target.engine);
    Check([[destination objectForKey:CSBackgroundRunPolicyKey] isEqual:CSBackgroundRunLegacyPolicy()],@"old backup without policy field leaves current policy untouched");
    NSMutableDictionary *bad=[snapshot mutableCopy];NSMutableArray *fields=[snapshot[@"fields"] mutableCopy];NSMutableDictionary *field=[PolicyField(fields) mutableCopy];field[@"value"]=@{@"allDay":@"YES"};fields[[fields indexOfObject:PolicyField(fields)]]=field;bad[@"fields"]=fields;
    Check([CSBackupCodec encode:bad error:&error]==nil&&error!=nil,@"malformed policy dictionary cannot enter exported or imported backup data");
    [source clean];[target clean];
}
static void PolicyChangesExpirePlans(NSURL *base) {
    PolicyFixture *fixture=Fixture(base,@"stale");CSBackupEngine *engine=fixture.engine;NSUserDefaults *standard=fixture.defaults[@"standard"],*legacy=fixture.defaults[@"legacy"];
    [standard setObject:@"wanted" forKey:TextKey];NSDictionary *snapshot=[engine save:@"restore target" error:NULL];[standard setObject:@"before" forKey:TextKey];
    for(NSUInteger scenario=0;scenario<3;scenario++) {
        if(scenario==0)[legacy removeObjectForKey:CSBackgroundRunPolicyKey];else [legacy setObject:CSBackgroundRunDefaultPolicy() forKey:CSBackgroundRunPolicyKey];
        NSDictionary *preview=[engine preview:snapshot modules:[NSSet setWithObject:@"navigation"] accounts:[NSSet set] error:NULL];Check(preview!=nil&&[engine prepare:preview error:NULL],@"prepare policy-generation drift fixture");
        if(scenario==0)[legacy setObject:CSBackgroundRunDefaultPolicy() forKey:CSBackgroundRunPolicyKey];
        else if(scenario==1)[legacy setObject:CSBackgroundRunLegacyPolicy() forKey:CSBackgroundRunPolicyKey];else [legacy removeObjectForKey:CSBackgroundRunPolicyKey];
        NSError *error=nil;Check(![engine applyPending:&error]&&error!=nil,@"adding, changing or removing a real policy expires an already-prepared plan");
        Check([[standard objectForKey:TextKey] isEqual:@"before"],@"expired plan never changes live selected fields");
        Check([engine cancelPending:NULL],@"stale plan remains cancellable");
    }
    NSDictionary *preview=[engine preview:snapshot modules:[NSSet setWithObject:@"navigation"] accounts:[NSSet set] error:NULL];[legacy setObject:CSBackgroundRunDefaultPolicy() forKey:CSBackgroundRunPolicyKey];
    Check(![engine prepare:preview error:NULL]&&[engine.store journal:NULL]==nil,@"policy added after preview also invalidates preparation");[fixture clean];
}
int main(int argc,const char **argv) {@autoreleasepool {
    Check(argc==2,@"isolated fixture root supplied");NSURL *base=[NSURL fileURLWithPath:@(argv[1])];
    for(NSNumber *reset in @[@NO,@YES])for(NSNumber *runtime in @[@NO,@YES])LegacyPrepared(base,reset.boolValue,runtime.boolValue);
    PolicyRoundTrip(base);PolicyChangesExpirePlans(base);
    printf("Backup background policy: %lu checks passed\n",(unsigned long)checks);
}return 0;}
