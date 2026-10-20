#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
#import "CSBackupMutation.h"
#import <unistd.h>
static NSUInteger checks;
static NSString *const Key=@"com.wechat.tweak.navigation.separator.text";
static NSString *const Profiles=@"com.wechat.enhance.chat_group.account_profiles";
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static NSDictionary *Profile(NSString *name){return @{@"version":@1,@"customTabs":@[@{@"id":@"work",@"name":name,@"members":@[@"member"],@"created":[NSDate dateWithTimeIntervalSince1970:1700000000]}],@"presetNames":@{},@"tabOrder":@[@"work"],@"hiddenPresetTabs":@[],@"selectedTabID":@"work",@"filterDuplicates":@NO,@"legacyImported":@NO};}
static CSBackupEngine *Engine(NSString *path,NSString *suite,NSMutableDictionary **out){
 NSMutableDictionary *defaults=[NSMutableDictionary dictionary],*domains=[NSMutableDictionary dictionary];for(NSString *alias in @[@"standard",@"legacy",@"layout"]){domains[alias]=[suite stringByAppendingFormat:@".%@",alias];defaults[alias]=[[NSUserDefaults alloc]initWithSuiteName:domains[alias]];}
 NSURL *root=[NSURL fileURLWithPath:path];CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:defaults domains:domains store:[[CSBackupStore alloc]initWithRoot:[root URLByAppendingPathComponent:@"store"]] resources:[root URLByAppendingPathComponent:@"resources"]];engine.context=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"test-install",@"pluginVersion":@"test"};};if(out)*out=defaults;return engine;
}
static int Run(NSString *binary,NSArray *arguments){NSTask *task=[NSTask new];task.executableURL=[NSURL fileURLWithPath:binary];task.arguments=arguments;NSError *error=nil;Check([task launchAndReturnError:&error],error.description?:@"launch child");[task waitUntilExit];return task.terminationStatus;}
@interface FailingDefaults : NSUserDefaults
@property(nonatomic) BOOL failOnce;
@end
@implementation FailingDefaults
- (BOOL)synchronize {if(self.failOnce){self.failOnce=NO;return NO;}return [super synchronize];}
@end
@interface PublishedFailureStore : CSBackupStore
@end
@implementation PublishedFailureStore
- (BOOL)confirmActivation:(NSDictionary *)record error:(NSError **)error {
 if(![super confirmActivation:record error:error])return NO;
 if(error)*error=CSBackupFailure(@"simulated parent directory sync failure after rename");return NO;
}
@end
int main(int argc,const char **argv){@autoreleasepool{
 if(argc>=4){NSString *mode=@(argv[1]);NSMutableDictionary *defaults;CSBackupEngine *engine=Engine(@(argv[2]),@(argv[3]),&defaults);
  if([mode isEqual:@"--apply"]){NSString *point=argc>4?@(argv[4]):@"";__block NSUInteger count=0;NSUInteger occurrence=argc>5?(NSUInteger)atoi(argv[5]):1;engine.checkpoint=^(NSString *p){if([p isEqual:point]&&++count==occurrence)_exit(77);};NSError *error=nil;BOOL ok=[engine applyPending:&error];if(!ok)fprintf(stderr,"child: %s\n",error.description.UTF8String);return ok?0:2;}
  if([mode isEqual:@"--startup-gap"]||[mode isEqual:@"--startup-confirmed"]){NSError *error=nil;if(![engine applyPending:&error]||![engine finishStartup:&error])return 4;if([mode isEqual:@"--startup-confirmed"]&&![engine confirmStartup:&error])return 5;_exit(77);}
  if([mode isEqual:@"--recover-bob"]){engine.context=^{return @{@"account":@"bob",@"epoch":@2,@"installationID":@"test-install",@"pluginVersion":@"test"};};return [engine applyPending:NULL]?0:6;}
  if([mode isEqual:@"--verify"]){NSString *want=@(argv[4]);NSUserDefaults *d=defaults[@"standard"];[d synchronize];return [[d objectForKey:Key] isEqual:want]&&[[d objectForKey:@"host.sentinel"]isEqual:@"untouched"]?0:3;}
 }
 NSString *binary=@(argv[0]);NSString *suite=[@"backup.transaction." stringByAppendingString:NSUUID.UUID.UUIDString];NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString];NSMutableDictionary *defaults;CSBackupEngine *engine=Engine(path,suite,&defaults);NSUserDefaults *standard=defaults[@"standard"];
 NSSet *navigation=[NSSet setWithObject:@"navigation"],*alice=[NSSet setWithObject:@"alice"];NSError *error=nil;
 [standard setObject:@"untouched" forKey:@"host.sentinel"];
 NSData *image=[[NSData alloc]initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
 [NSFileManager.defaultManager createDirectoryAtURL:engine.resourceRoot withIntermediateDirectories:YES attributes:nil error:NULL];
 [image writeToURL:[engine.resourceRoot URLByAppendingPathComponent:@"separator_image.png"] atomically:YES];
 [standard setObject:@"wanted" forKey:Key];NSDictionary *snapshot=[engine save:@"original" kind:@"manual" error:&error];Check(snapshot!=nil,error.description?:@"save");
 for(NSString *point in @[@"applying",@"resource",@"field",@"synchronized",@"committed"]){
  [engine.store archiveJournal:NULL];[standard setObject:@"before" forKey:Key];[standard synchronize];
  NSDictionary *preview=[engine preview:snapshot modules:navigation accounts:alice error:&error];Check([engine prepare:preview error:&error],error.description?:@"prepare crash fixture");
  Check(Run(binary,@[@"--apply",path,suite,point,@"1"])==77,[@"crash at " stringByAppendingString:point]);
  Check(Run(binary,@[@"--apply",path,suite])==0,[@"recover after " stringByAppendingString:point]);
  NSString *want=[point isEqual:@"committed"]?@"wanted":@"before";
  Check(Run(binary,@[@"--verify",path,suite,want])==0,[@"cross-process persisted result for " stringByAppendingString:point]);
 }
 // Interrupt recovery itself, then recover again. The before-image must remain immutable.
 [engine.store archiveJournal:NULL];[standard setObject:@"before" forKey:Key];[standard synchronize];NSDictionary *preview=[engine preview:snapshot modules:navigation accounts:alice error:&error];Check([engine prepare:preview error:&error],@"prepare repeated interruption");
 Check(Run(binary,@[@"--apply",path,suite,@"synchronized",@"1"])==77,@"interrupt application after persistence");Check(Run(binary,@[@"--apply",path,suite,@"field",@"1"])==77,@"interrupt rollback");Check(Run(binary,@[@"--apply",path,suite])==0,@"recover interrupted rollback");Check(Run(binary,@[@"--verify",path,suite,@"before"])==0,@"rollback retained original state across two crashes");
 [engine.store archiveJournal:NULL];[standard synchronize];
 // A process killed after verification but before the locked handoff has no confirmation.
 [standard setObject:@"before" forKey:Key];[standard synchronize];preview=[engine preview:snapshot modules:navigation accounts:alice error:&error];Check([engine prepare:preview error:&error],@"prepare startup gap fixture");
 Check(Run(binary,@[@"--startup-gap",path,suite])==77,@"kill after startup verification before handoff");Check(![engine.store activationConfirmed:[engine.store journal:NULL]],@"verification alone does not publish activation");
 Check(Run(binary,@[@"--recover-bob",path,suite])==0,@"new account recovers unconfirmed commit");Check(Run(binary,@[@"--verify",path,suite,@"before"])==0,@"unconfirmed commit restores original values across processes");
 [engine.store archiveJournal:NULL];[standard synchronize];preview=[engine preview:snapshot modules:navigation accounts:alice error:&error];Check([engine prepare:preview error:&error],@"prepare confirmed handoff fixture");
 Check(Run(binary,@[@"--startup-confirmed",path,suite])==77,@"kill after durable handoff confirmation");Check([engine.store activationConfirmed:[engine.store journal:NULL]],@"handoff confirmation matches committed identity");
 [standard setObject:@"later user edit" forKey:Key];[standard synchronize];Check(Run(binary,@[@"--recover-bob",path,suite])==0,@"confirmed transaction may archive after later account switch");Check(Run(binary,@[@"--verify",path,suite,@"later user edit"])==0,@"confirmed handoff preserves later user edits");Check([engine.store journal:NULL]==nil,@"confirmed journal archived on next launch");[standard setObject:@"before" forKey:Key];[standard synchronize];
 // A change after the last preference write must roll back, including epoch-only changes.
 __block NSUInteger epoch=1;engine.context=^{return @{@"account":@"alice",@"epoch":@(epoch),@"installationID":@"test-install",@"pluginVersion":@"test"};};
 preview=[engine preview:snapshot modules:navigation accounts:alice error:&error];Check([engine prepare:preview error:&error],@"prepare epoch fixture");__block BOOL switched=NO;engine.checkpoint=^(NSString *point){if([point isEqual:@"synchronized"]&&!switched){switched=YES;epoch++;}};
 Check(![engine applyPending:&error],@"epoch change at synchronization is rejected");Check([[standard objectForKey:Key]isEqual:@"before"],@"epoch change rolls back");engine.checkpoint=nil;[engine.store archiveJournal:NULL];
 // Restore alice's prior profile; preserve bob's edits and new carol profile.
 [standard setObject:@{@"alice":Profile(@"old alice"),@"bob":Profile(@"old bob")} forKey:Profiles];NSDictionary *groups=[engine save:@"groups" kind:@"manual" error:&error];Check(groups!=nil,@"capture profiles");
 [standard setObject:@{@"alice":Profile(@"new alice"),@"bob":Profile(@"new bob"),@"carol":Profile(@"new carol")} forKey:Profiles];
 preview=[engine preview:groups modules:[NSSet setWithObject:@"groups"] accounts:alice error:&error];Check([engine prepare:preview error:&error]&&[engine applyPending:&error],error.description?:@"selected account restore");NSDictionary *profiles=[standard dictionaryForKey:Profiles];Check([profiles[@"alice"] isEqual:Profile(@"old alice")],@"selected account restored");Check([profiles[@"bob"] isEqual:Profile(@"new bob")]&&[profiles[@"carol"] isEqual:Profile(@"new carol")],@"unselected and new accounts preserved");[engine finishStartup:NULL];[engine.store archiveJournal:NULL];
 // An old snapshot with absent profile storage does not delete an account created later.
 NSMutableDictionary *empty=[snapshot mutableCopy];NSMutableArray *fields=[NSMutableArray array];for(NSDictionary *f in snapshot[@"fields"])if([f[@"key"]isEqual:Profiles])[fields addObject:@{@"domain":@"standard",@"key":Profiles,@"present":@NO}];else [fields addObject:f];empty[@"fields"]=fields;
 preview=[engine preview:empty modules:[NSSet setWithObject:@"groups"] accounts:[NSSet setWithObject:@"carol"] error:&error];Check([engine prepare:preview error:&error]&&[engine applyPending:&error],@"restore old absent account scope");Check([[[standard dictionaryForKey:Profiles] objectForKey:@"carol"]isEqual:Profile(@"new carol")],@"new account is outside old coverage");[engine finishStartup:NULL];[engine.store archiveJournal:NULL];
 // A stale/corrupt historical file does not convert successful publication into failure.
 NSURL *bad=[engine.store.root URLByAppendingPathComponent:[NSUUID.UUID.UUIDString stringByAppendingPathExtension:@"wcbak"]];[[@"broken" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:bad atomically:YES];error=nil;Check([engine save:@"still works" kind:@"manual" error:&error]!=nil,@"corrupt old file does not undo new publication");
 // No account must never produce an unusable prepared plan.
 engine.context=^{return @{@"account":@"",@"epoch":@1,@"installationID":@"test-install",@"pluginVersion":@"test"};};preview=[engine preview:snapshot modules:navigation accounts:[NSSet set] error:&error];Check(preview!=nil&&![engine prepare:preview error:&error],@"unknown account cannot stage a permanently blocked plan");
 // File+path writes explicitly hold snapshot publication out of the mutation window.
 {CSBackupResourceMutationScope();Check(![engine capture:@"racing" kind:@"manual" error:&error],@"active resource writer blocks mixed capture");}
 // No-change dedupe ignores selection churn and retains the first automatic ID.
 engine.context=^{return @{@"account":@"alice",@"epoch":@1,@"installationID":@"test-install",@"pluginVersion":@"test"};};NSDictionary *automatic=[engine save:@"auto" kind:@"automatic" error:&error];[standard setObject:@{@"version":@1,@"tabID":@"work"} forKey:@"com.wechat.enhance.chat_group.selection.alice"];NSDictionary *second=[engine save:@"auto again" kind:@"automatic" error:&error];Check([automatic[@"id"] isEqual:second[@"id"]],@"selection-only changes do not duplicate backups");
 // Account ownership remains part of automatic deduplication even with equal settings.
 engine.context=^{return @{@"account":@"bob",@"epoch":@2,@"installationID":@"test-install",@"pluginVersion":@"test"};};NSDictionary *bobAuto=[engine save:@"bob auto" kind:@"automatic" error:&error];Check(![bobAuto[@"id"] isEqual:second[@"id"]]&&[bobAuto[@"source"][@"account"] isEqual:@"bob"],@"equal content in another account keeps its original ownership");
 // A dangling recovery journal is an error, never absence.
 NSURL *journalURL=[engine.store.root URLByAppendingPathComponent:@"transaction.plist"];[NSFileManager.defaultManager removeItemAtURL:journalURL error:NULL];[NSFileManager.defaultManager createSymbolicLinkAtURL:journalURL withDestinationURL:[engine.store.root URLByAppendingPathComponent:@"missing"] error:NULL];error=nil;Check(![engine applyPending:&error]&&error!=nil,@"dangling journal cannot bypass startup recovery");[NSFileManager.defaultManager removeItemAtURL:journalURL error:NULL];
 // Account changes during activation preparation roll back before handoff.
 epoch=10;engine.context=^{return @{@"account":@"alice",@"epoch":@(epoch),@"installationID":@"test-install",@"pluginVersion":@"test"};};[standard setObject:@"before" forKey:Key];preview=[engine preview:snapshot modules:navigation accounts:alice error:&error];Check([engine prepare:preview error:&error]&&[engine applyPending:&error],@"prepare activation race");engine.checkpoint=^(NSString *point){if([point isEqual:@"activationPrepared"])epoch++;};Check(![engine finishStartup:&error],@"account changed during activation cannot release consumers");Check([[standard objectForKey:Key]isEqual:@"before"]&&[[engine.store journal:NULL][@"state"]isEqual:@"rolledBack"],@"activation race restores before-image");engine.checkpoint=nil;Check([engine applyPending:&error]&&engine.appliedContext==nil,@"retry after handoff rollback discards stale activation identity");
 // Cancelling an unhanded committed plan must restore its before-image first.
 preview=[engine preview:snapshot modules:navigation accounts:alice error:&error];Check([engine prepare:preview error:&error]&&[engine applyPending:&error],@"prepare unhanded cancellation");NSString *unhandedID=[engine.store journal:NULL][@"transactionID"];Check(![engine prepare:preview error:&error]&&[[engine.store journal:NULL][@"transactionID"]isEqual:unhandedID],@"new restore cannot discard an unhanded commit");Check([engine cancelPending:&error]&&[[standard objectForKey:Key]isEqual:@"before"],@"cancel cannot discard unhanded commit recovery evidence");
 // A marker may already be visible when the atomic publisher reports a directory-sync error.
 NSMutableDictionary *confirmationDomains=[NSMutableDictionary dictionary];for(NSString *alias in defaults)confirmationDomains[alias]=[suite stringByAppendingFormat:@".%@",alias];CSBackupEngine *confirmationEngine=[[CSBackupEngine alloc]initWithDefaults:defaults domains:confirmationDomains store:[[PublishedFailureStore alloc]initWithRoot:engine.store.root] resources:engine.resourceRoot];confirmationEngine.context=engine.context;preview=[confirmationEngine preview:snapshot modules:navigation accounts:alice error:&error];Check([confirmationEngine prepare:preview error:&error]&&[confirmationEngine applyPending:&error]&&[confirmationEngine finishStartup:&error],@"prepare post-publication confirmation failure");error=nil;Check([confirmationEngine confirmStartup:&error]&&error==nil&&[engine.store activationConfirmed:[engine.store journal:NULL]],@"published confirmation finishes locked handoff despite post-rename error");[engine.store archiveJournal:NULL];
 // Simulated persistence failure rolls back and cannot report committed.
 [engine.store archiveJournal:NULL];FailingDefaults *failing=[[FailingDefaults alloc]initWithSuiteName:[suite stringByAppendingString:@".standard"]];NSMutableDictionary *failureDefaults=[defaults mutableCopy];failureDefaults[@"standard"]=failing;NSMutableDictionary *domains=[NSMutableDictionary dictionary];for(NSString *alias in failureDefaults)domains[alias]=[suite stringByAppendingFormat:@".%@",alias];
 CSBackupEngine *failure=[[CSBackupEngine alloc]initWithDefaults:failureDefaults domains:domains store:engine.store resources:engine.resourceRoot];failure.context=engine.context;[failing setObject:@"before" forKey:Key];preview=[failure preview:snapshot modules:navigation accounts:alice error:&error];Check([failure prepare:preview error:&error],@"prepare sync failure");failing.failOnce=YES;Check(![failure applyPending:&error],@"persistence failure is reported");Check([[failing objectForKey:Key]isEqual:@"before"],@"persistence failure rolls back original value");
 for(NSString *alias in defaults)[defaults[alias] removePersistentDomainForName:[suite stringByAppendingFormat:@".%@",alias]];[NSFileManager.defaultManager removeItemAtPath:path error:NULL];printf("Backup transactions: %lu checks passed\n",(unsigned long)checks);
}return 0;}
