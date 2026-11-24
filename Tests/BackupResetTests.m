#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static NSDictionary *Field(NSArray *fields,NSString *key){for(NSDictionary *f in fields)if([f[@"key"] isEqual:key])return f;return nil;}
int main(void){@autoreleasepool{
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSMutableDictionary *defaults=[NSMutableDictionary dictionary],*domains=[NSMutableDictionary dictionary];
    for(NSString *alias in @[@"standard",@"legacy",@"layout"]){NSString *suite=[@"reset.test." stringByAppendingString:NSUUID.UUID.UUIDString];domains[alias]=suite;defaults[alias]=[[NSUserDefaults alloc]initWithSuiteName:suite];}
    NSUserDefaults *standard=defaults[@"standard"];
    NSURL *resources=[root URLByAppendingPathComponent:@"Library/Preferences/WeChatImprove"];
    CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:[resources URLByAppendingPathComponent:@"BackupV2"]];
    CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:defaults domains:domains store:store resources:resources];
    __block NSString *account=@"alice";engine.context=^{return @{@"account":account,@"epoch":@1,@"installationID":@"test-install",@"pluginVersion":@"test"};};
    [NSFileManager.defaultManager createDirectoryAtURL:engine.resourceRoot withIntermediateDirectories:YES attributes:nil error:NULL];
    NSString *icon=@"com.wechat.enhance.tabbar_style.icon.chat",*otherIcon=@"com.wechat.enhance.tabbar_style.icon.me",*text=@"com.wechat.tweak.navigation.separator.text",*contacts=@"com.wechat.tweak.navigation.contact.overrides",*navImage=@"com.wechat.tweak.navigation.separator.image";
    NSString *missing=[engine.resourceRoot URLByAppendingPathComponent:@"gone.png"].path;
    NSURL *good=[engine.resourceRoot URLByAppendingPathComponent:@"good.png"];
    NSData *png=[[NSData alloc]initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aD1sAAAAASUVORK5CYII=" options:0];
    NSMutableArray *sentinels=[NSMutableArray array];
    for(NSString *leaf in @[@"BackupV2",@"CloseFriends"]){
        NSURL *folder=[resources URLByAppendingPathComponent:leaf];
        [NSFileManager.defaultManager createDirectoryAtURL:folder withIntermediateDirectories:YES attributes:nil error:NULL];
        NSURL *sentinel=[folder URLByAppendingPathComponent:@"keep.png"];[png writeToURL:sentinel atomically:YES];[sentinels addObject:sentinel];
    }
    [png writeToURL:good atomically:YES];
    [standard setObject:missing forKey:icon];[standard setObject:good.path forKey:otherIcon];
    [standard setObject:missing forKey:navImage];
    [standard setObject:@{@"friend":@{@"enabled":@YES,@"separatorImagePath":missing,@"separatorText":@"keep"}} forKey:contacts];
    [standard setObject:@"keep" forKey:text];[standard setObject:@"host-secret" forKey:@"host.account"];[standard setInteger:99 forKey:@"kReceiveTransferTotalCountKey"];
    NSArray *voiceKeys=@[@"com.wechat.enhance.voice_playback.progress_enabled",@"com.wechat.enhance.voice_forward.enabled",@"com.wechat.enhance.voice_forward.favorite_enabled"];
    for(NSString *key in voiceKeys)[standard setBool:YES forKey:key];
    NSString *momentsLayoutKey=@"com.wechat.enhance.moments_layout.enabled";
    [standard setBool:YES forKey:momentsLayoutKey];
    NSDictionary *inputGestureValues=@{@"com.wechat.enhance.inputText.gesture.enabled":@YES,
                                      @"com.wechat.enhance.inputText.gesture.leftAction":@1,
                                      @"com.wechat.enhance.inputText.gesture.rightAction":@5};
    for(NSString *key in inputGestureValues)[standard setObject:inputGestureValues[key] forKey:key];
    NSError *error=nil;NSSet *all=[NSSet setWithArray:CSBackupRegistry.moduleTitles.allKeys],*alice=[NSSet setWithObject:@"alice"],*tabbar=[NSSet setWithObject:@"tabbar"];
    Check(![engine save:@"strict" error:&error]&&error!=nil,@"ordinary backups still reject missing images");
    error=nil;NSDictionary *reset=[engine resetSnapshot:&error];Check(reset!=nil&&error==nil,@"missing tabbar, navigation and contact images do not block reset entry");
    for(NSString *key in voiceKeys)Check([Field(reset[@"fields"],key)[@"present"] isEqual:@NO],@"reset snapshot removes each registered playback/forward preference");
    Check([Field(reset[@"fields"],momentsLayoutKey)[@"present"] isEqual:@NO],@"reset snapshot removes registered moments layout preference");
    for(NSString *key in inputGestureValues)Check([Field(reset[@"fields"],key)[@"present"] isEqual:@NO],@"reset snapshot includes all registered input gesture preferences");
    NSDictionary *preview=[engine preview:reset modules:tabbar accounts:alice error:&error];Check(preview!=nil,@"missing images do not block reset preview");
    Check([preview[@"warnings"] count]>0,@"preview discloses lost images");
    BOOL removal=NO;for(NSDictionary *change in preview[@"changes"])if([change[@"key"] isEqual:icon])removal=[change[@"before"][@"value"] isEqual:missing]&&[change[@"reset"] boolValue];
    Check(removal,@"missing reference appears in reset diff");
    [standard setObject:[engine.resourceRoot URLByAppendingPathComponent:@"another-gone.png"].path forKey:icon];
    Check(![engine prepare:preview error:&error],@"changing one missing path invalidates preview");[standard setObject:missing forKey:icon];
    preview=[engine preview:reset modules:tabbar accounts:alice error:&error];Check([engine prepare:preview error:&error],@"prepare reset with missing resources");
    NSDictionary *journal=[store journal:NULL];
    Check(journal[@"protectionID"]==nil&&[store records:NULL].count==0,@"reset preparation creates no protection backup file");
    Check([Field(journal[@"before"],otherIcon)[@"value"] isEqual:good.path],@"journal retains available image references needed for rollback");
    Check([Field(journal[@"before"],icon)[@"value"] isEqual:missing],@"transaction retains exact original missing reference for rollback");
    Check([[standard objectForKey:icon] isEqual:missing],@"preparation does not change live settings");
    [png writeToFile:missing atomically:YES];Check(![engine applyPending:&error],@"reappearing image invalidates prepared reset");
    [NSFileManager.defaultManager removeItemAtPath:missing error:NULL];Check([engine cancelPending:&error],@"cancel stale reset");
    preview=[engine preview:reset modules:tabbar accounts:alice error:&error];Check([engine prepare:preview error:&error],@"prepare rollback scenario");
    __block BOOL interrupted=NO;engine.checkpoint=^(NSString *point){if(!interrupted&&[point isEqual:@"field"]){interrupted=YES;@throw [NSException exceptionWithName:@"TestCrash" reason:nil userInfo:nil];}};
    @try{[engine applyPending:&error];}@catch(__unused NSException *exception){}
    engine.checkpoint=nil;Check([engine applyPending:&error],@"interrupted reset rolls back on next startup");
    Check([[standard objectForKey:icon] isEqual:missing]&&[[standard objectForKey:otherIcon] isEqual:good.path],@"rollback restores original missing and valid image references");
    Check([[NSData dataWithContentsOfURL:good] isEqual:png],@"rollback preserves original image file");
    Check([engine applyPending:&error],@"archive rolled back journal");
    preview=[engine preview:reset modules:tabbar accounts:alice error:&error];Check([engine prepare:preview error:&error],@"prepare partial reset");account=@"bob";Check(![engine applyPending:&error],@"account change still blocks reset");account=@"alice";
    Check([engine applyPending:&error]&&[engine finishStartup:&error]&&[engine confirmStartup:&error],@"partial reset applies and completes startup");
    Check([standard objectForKey:icon]==nil&&[standard objectForKey:otherIcon]==nil,@"selected tabbar preferences cleared");
    for(NSString *key in voiceKeys)Check([standard boolForKey:key],@"unselected message-actions module retains playback and forward preferences");
    Check([standard boolForKey:momentsLayoutKey],@"unselected moments layout module retains the enabled preference");
    for(NSString *key in inputGestureValues)Check([[standard objectForKey:key] isEqual:inputGestureValues[key]],@"partial reset preserves the unselected input gesture switch and directional actions");
    Check([[standard objectForKey:navImage] isEqual:missing]&&[[standard objectForKey:text] isEqual:@"keep"],@"unselected navigation preferences preserved including missing path");
    Check([engine applyPending:&error],@"completed partial reset is idempotent");
    reset=[engine resetSnapshot:&error];preview=[engine preview:reset modules:all accounts:alice error:&error];
    Check([engine prepare:preview error:&error]&&[engine applyPending:&error]&&[engine finishStartup:&error]&&[engine confirmStartup:&error],@"full reset with missing contact and fixed-path images completes");
    Check([standard objectForKey:contacts]==nil&&[standard objectForKey:navImage]==nil,@"full reset removes selected missing image references");
    for(NSString *key in voiceKeys)Check([standard objectForKey:key]==nil,@"full reset removes playback progress and preserves forwarding reset semantics");
    Check([standard objectForKey:momentsLayoutKey]==nil,@"full reset removes moments layout preference and restores its disabled default");
    for(NSString *key in inputGestureValues)Check([standard objectForKey:key]==nil,@"full reset removes input gesture preferences and restores disabled defaults");
    Check([[standard objectForKey:@"host.account"] isEqual:@"host-secret"]&&[standard integerForKey:@"kReceiveTransferTotalCountKey"]==99,@"host account and payment statistics preserved");
    Check([store records:NULL].count==0,@"prepare, reset, interrupted rollback and startup never create backup files");
    Check([engine save:@"after reset" error:&error]!=nil,@"complete backup works after full reset");
    for(NSURL *sentinel in sentinels)Check([[NSData dataWithContentsOfURL:sentinel] isEqual:png],@"real reset and rollback preserve data subtrees including PNG files");
    // Existing corrupt files and dangling links are not silently treated as missing.
    [@"invalid image" writeToFile:missing atomically:YES encoding:NSUTF8StringEncoding error:NULL];[standard setObject:missing forKey:icon];
    Check([engine resetSnapshot:&error]==nil,@"existing corrupt image remains a visible repair error");
    [NSFileManager.defaultManager removeItemAtPath:missing error:NULL];[NSFileManager.defaultManager createSymbolicLinkAtPath:missing withDestinationPath:[missing stringByAppendingString:@".target"] error:NULL];
    Check([engine resetSnapshot:&error]==nil,@"dangling symlink remains a visible repair error");
    for(NSString *alias in defaults)[defaults[alias] removePersistentDomainForName:domains[alias]];
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];printf("Backup reset: %lu checks passed\n",(unsigned long)checks);
}return 0;}
