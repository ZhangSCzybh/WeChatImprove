#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static NSDictionary *StandardField(NSDictionary *snapshot,NSString *key){
 for(NSDictionary *field in snapshot[@"fields"])if([field[@"domain"] isEqual:@"standard"]&&[field[@"key"] isEqual:key])return field;
 return nil;
}
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
 NSError *error=nil;NSDictionary *snapshot=[engine save:@"original" error:&error];Check(snapshot!=nil,error.description?:@"capture");
 Check([store snapshots:NULL].count==1,@"snapshot listed without an index");
 NSMutableArray<NSString *> *functionColorKeys=[NSMutableArray array];
 for(NSString *color in @[@"function_background_color",@"function_icon_color"])for(NSString *component in @[@"red",@"green",@"blue",@"alpha"])
  [functionColorKeys addObject:[NSString stringWithFormat:@"com.wechat.enhance.tabbar_style.%@.%@",color,component]];
 NSArray<NSNumber *> *functionColorValues=@[@0.12,@0.34,@0.56,@0.78,@0.88,@0.66,@0.44,@0];
 for(NSString *colorKey in functionColorKeys){
  NSDictionary *field=StandardField(snapshot,colorKey);
  Check(field!=nil&&![field[@"present"] boolValue]&&field[@"value"]==nil,@"unset function color exports as absence");
  Check([standard objectForKey:colorKey]==nil,@"capturing defaults does not persist a function color");
 }
 for(NSUInteger i=0;i<functionColorKeys.count;i++)[standard setObject:functionColorValues[i] forKey:functionColorKeys[i]];
 NSString *icon=@"com.wechat.enhance.tabbar_style.icon.chat",*stale=[engine.resourceRoot URLByAppendingPathComponent:@"old-icon.png"].path;
 [standard setObject:stale forKey:icon];error=nil;
 NSDictionary *withoutIcon=[engine save:@"native tab icons" error:&error];
 Check(withoutIcon!=nil&&error==nil&&[withoutIcon[@"assets"] count]==0,@"complete backup succeeds with a stale optional tab icon path");
 Check([[standard objectForKey:icon] isEqual:stale],@"successful backup leaves current preferences unchanged");
 NSData *exported=[CSBackupCodec encode:withoutIcon error:&error];
 Check(exported.length>0,@"backup without custom tab images remains exportable");
 NSDictionary *portableColors=[CSBackupCodec decode:exported error:&error];
 Check(portableColors!=nil,error.description?:@"function colors decode after export");
 for(NSUInteger i=0;i<functionColorKeys.count;i++){
  NSDictionary *field=StandardField(portableColors,functionColorKeys[i]);
  Check([field[@"present"] boolValue]&&[field[@"value"] isEqual:functionColorValues[i]],@"export preserves each independent RGBA component including zero alpha");
  Check([[standard objectForKey:functionColorKeys[i]] isEqual:functionColorValues[i]],@"export leaves configured function colors unchanged");
 }
 [legacy setBool:NO forKey:@"BackgroundRunEnabled"];[standard setObject:@"changed" forKey:key];[layout setDouble:1.5 forKey:@"global.scale"];
 NSSet *modules=[NSSet setWithArray:[CSBackupRegistry moduleTitles].allKeys];
 NSDictionary *preview=[engine preview:snapshot modules:modules accounts:[NSSet setWithObject:account] error:&error];Check(preview!=nil,error.description?:@"preview");
 Check([engine prepare:preview error:&error],error.description?:@"prepare");
 Check([[standard objectForKey:key]isEqual:@"changed"],@"prepare must not touch active preferences");
 Check([engine applyPending:&error],error.description?:@"apply");
 for(NSString *colorKey in functionColorKeys)Check([standard objectForKey:colorKey]==nil,@"restore of explicit color absence removes a current custom component");
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
 Check([engine finishStartup:&error]&&[engine confirmStartup:&error],@"finish navigation reset before the function color restore");
 NSSet *tabbarModule=[NSSet setWithObject:@"tabbar"];
 preview=[engine preview:portableColors modules:tabbarModule accounts:[NSSet setWithObject:account] error:&error];
 Check(preview!=nil,error.description?:@"preview exported function colors");
 Check([engine prepare:preview error:&error],error.description?:@"prepare exported function colors");
 for(NSString *colorKey in functionColorKeys)Check([standard objectForKey:colorKey]==nil,@"preparing function colors leaves current defaults untouched");
 Check([engine applyPending:&error],error.description?:@"restore exported function colors");
 for(NSUInteger i=0;i<functionColorKeys.count;i++)Check([[standard objectForKey:functionColorKeys[i]] isEqual:functionColorValues[i]],@"tabbar restore reapplies independent background and icon RGBA values");
 Check([standard objectForKey:key]==nil&&[layout doubleForKey:@"global.scale"]==1.2,@"function color restore preserves unselected modules");
 Check([engine finishStartup:&error]&&[engine confirmStartup:&error],@"finish function color restore before reset");
 reset=[engine resetSnapshot:&error];
 for(NSString *colorKey in functionColorKeys){NSDictionary *field=StandardField(reset,colorKey);Check(field!=nil&&![field[@"present"] boolValue],@"tabbar reset includes each function color component as absence");}
 preview=[engine preview:reset modules:tabbarModule accounts:[NSSet setWithObject:account] error:&error];
 Check(preview!=nil,error.description?:@"preview function color reset");
 Check([engine prepare:preview error:&error],error.description?:@"prepare function color reset");
 Check([engine applyPending:&error],error.description?:@"apply function color reset");
 for(NSString *colorKey in functionColorKeys)Check([standard objectForKey:colorKey]==nil,@"tabbar reset removes custom colors without persisting defaults");
 Check([[standard objectForKey:@"host.account"] isEqual:@"host-secret"]&&[standard integerForKey:@"kReceiveTransferTotalCountKey"]==99,@"function color reset preserves host identity and payment history");
 for(NSString *alias in defaults)[defaults[alias] removePersistentDomainForName:domains[alias]];
 [NSFileManager.defaultManager removeItemAtURL:root error:NULL];printf("Backup engine: %lu checks passed\n",(unsigned long)checks);
}return 0;}
