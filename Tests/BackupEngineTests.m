#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
int main(void){@autoreleasepool{
 NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
 NSMutableDictionary *defaults=[NSMutableDictionary dictionary],*domains=[NSMutableDictionary dictionary];
 for(NSString *alias in @[@"standard",@"legacy",@"layout"]){NSString *name=[@"backup.test." stringByAppendingString:NSUUID.UUID.UUIDString];domains[alias]=name;defaults[alias]=[[NSUserDefaults alloc]initWithSuiteName:name];}
 NSUserDefaults *standard=defaults[@"standard"],*legacy=defaults[@"legacy"],*layout=defaults[@"layout"];
 CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:[root URLByAppendingPathComponent:@"snapshots"]];
 CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:defaults domains:domains store:store resources:[root URLByAppendingPathComponent:@"resources"]];
 __block NSString *account=@"alice";engine.context=^{return @{@"account":account,@"epoch":@1,@"installationID":@"test-install",@"pluginVersion":@"test"};};
 NSString *key=@"com.wechat.tweak.navigation.separator.text";
 [standard setObject:@"host-secret" forKey:@"host.account"];[standard setInteger:99 forKey:@"kReceiveTransferTotalCountKey"];
 [standard setObject:@"original" forKey:key];[legacy setBool:YES forKey:@"BackgroundRunEnabled"];[layout setDouble:1.2 forKey:@"global.scale"];
 NSError *error=nil;NSDictionary *snapshot=[engine save:@"original" kind:@"manual" error:&error];Check(snapshot!=nil,error.description?:@"capture");
 Check([store snapshots:NULL].count==1,@"snapshot listed without an index");
 [legacy setBool:NO forKey:@"BackgroundRunEnabled"];[standard setObject:@"changed" forKey:key];[layout setDouble:1.5 forKey:@"global.scale"];
 NSSet *modules=[NSSet setWithArray:[CSBackupRegistry moduleTitles].allKeys];
 NSDictionary *preview=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:account] error:&error];Check(preview!=nil,error.description?:@"preview");
 Check([engine prepare:preview error:&error],error.description?:@"prepare");
 Check([[standard objectForKey:key]isEqual:@"changed"],@"prepare must not touch active preferences");
 Check([engine applyPending:&error],error.description?:@"apply");
 Check([[standard objectForKey:key]isEqual:@"original"],@"restore registered field");
 Check([layout doubleForKey:@"global.scale"]==1.2,@"restore original suite");Check([legacy boolForKey:@"BackgroundRunEnabled"],@"restore legacy suite");
 Check([[standard objectForKey:@"host.account"]isEqual:@"host-secret"],@"host account preserved");
 Check([standard integerForKey:@"kReceiveTransferTotalCountKey"]==99,@"payment counter preserved");
 Check([engine finishStartup:&error]&&[engine confirmStartup:&error],@"durable handoff before consumers");Check([engine applyPending:&error],@"committed recovery idempotent");
 [standard setObject:@"newer" forKey:key];preview=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:account] error:&error];
 [standard setObject:@"newest" forKey:key];Check(![engine prepare:preview error:&error],@"stale preview rejected");
 preview=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:account] error:&error];Check([engine prepare:preview error:&error],@"prepare new preview");
 account=@"bob";Check(![engine applyPending:&error],@"account change blocks restore");Check([[standard objectForKey:key]isEqual:@"newest"],@"account failure leaves active data");
 Check([engine cancelPending:&error],@"cancel prepared plan");account=@"alice";
 NSDictionary *reset=[engine resetSnapshot:&error];preview=[engine preview:reset modules:[NSSet setWithObject:@"navigation"] accounts:[NSSet setWithObject:account] error:&error];
 Check([engine prepare:preview error:&error],@"prepare module reset");Check([engine applyPending:&error],@"apply module reset");Check([standard objectForKey:key]==nil,@"explicit absence deletes only covered field");Check([layout doubleForKey:@"global.scale"]==1.2,@"unselected module preserved");
 for(NSString *alias in defaults)[defaults[alias] removePersistentDomainForName:domains[alias]];
 [NSFileManager.defaultManager removeItemAtURL:root error:NULL];printf("Backup engine: %lu checks passed\n",(unsigned long)checks);
}return 0;}
