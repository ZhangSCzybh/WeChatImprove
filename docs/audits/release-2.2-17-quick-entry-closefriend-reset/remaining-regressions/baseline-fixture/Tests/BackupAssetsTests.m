#import <Foundation/Foundation.h>
#import "CSBackupAssets.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
static NSUInteger checks;
static void Check(BOOL b,NSString *m){checks++;if(!b){fprintf(stderr,"FAIL: %s\n",m.UTF8String);exit(1);}}
int main(void){@autoreleasepool{
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    [NSFileManager.defaultManager createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:NULL];
    NSData *png=[[NSData alloc] initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aWZcAAAAASUVORK5CYII=" options:0];
    [png writeToURL:[root URLByAppendingPathComponent:@"separator_image.png"] atomically:YES];
    NSArray *fields=@[@{@"domain":@"standard",@"key":@"com.wechat.tweak.touch.trail.custom.image.path",@"present":@YES,@"value":[root URLByAppendingPathComponent:@"separator_image.png"].path}];
    NSMutableDictionary *assets=[NSMutableDictionary dictionary];NSError *error=nil;
    NSArray *captured=[CSBackupAssets captureFields:fields root:root assets:assets error:&error];
    Check(captured!=nil&&assets.count==1,@"referenced image bytes captured");
    Check([captured[0][@"value"] hasPrefix:@"csbackup:"],@"snapshot removes sandbox absolute path");
    NSURL *newRoot=[root URLByAppendingPathComponent:@"new-container"];
    NSMutableDictionary *writes=[NSMutableDictionary dictionary];
    NSArray *ready=[CSBackupAssets materializeFields:captured assets:assets root:newRoot writes:writes error:&error];
    Check([ready[0][@"value"] hasPrefix:newRoot.path]&&writes.count==1,@"restore generates destination in current container");
    Check([[writes.allValues.firstObject objectForKey:@"data"] isEqual:png],@"restore retains original image bytes");
    Check(![CSBackupAssets materializeFields:captured assets:@{} root:newRoot writes:writes error:&error],@"missing referenced image blocks restoration");
    NSMutableDictionary *bad=[fields[0] mutableCopy];bad[@"value"]=@"/etc/hosts";
    Check(![CSBackupAssets captureFields:@[bad] root:root assets:assets error:&error],@"resource path outside plugin directory rejected");
    [NSFileManager.defaultManager createSymbolicLinkAtPath:[root URLByAppendingPathComponent:@"link.png"].path withDestinationPath:[root URLByAppendingPathComponent:@"separator_image.png"].path error:NULL];
    bad[@"value"]=[root URLByAppendingPathComponent:@"link.png"].path;
    Check(![CSBackupAssets captureFields:@[bad] root:root assets:assets error:&error],@"symlink cannot enter snapshot");
    Check(![CSBackupAssets validImage:[@"not an image" dataUsingEncoding:NSUTF8StringEncoding]],@"bad media rejected");
    NSArray *icons=@[@{@"domain":@"standard",@"key":@"com.wechat.enhance.tabbar_style.icon.chat",@"present":@YES,@"value":captured[0][@"value"]},@{@"domain":@"standard",@"key":@"com.wechat.enhance.tabbar_style.icon.selected.chat",@"present":@YES,@"value":captured[0][@"value"]}];
    writes=[NSMutableDictionary dictionary];NSArray *iconPaths=[CSBackupAssets materializeFields:icons assets:assets root:newRoot writes:writes error:&error];
    Check(iconPaths.count==2&&![iconPaths[0][@"value"] isEqual:iconPaths[1][@"value"]]&&writes.count==2,@"identical images have separate owned files so clearing one icon preserves others");
    NSMutableArray *unsetIcons=[NSMutableArray array];
    for(NSDictionary *entry in CSBackupRegistry.entries)if([entry[@"module"] isEqual:@"tabbar"]&&[entry[@"resource"] isEqual:@"file"])
        [unsetIcons addObject:@{@"domain":entry[@"domain"],@"key":entry[@"key"],@"present":@NO}];
    NSMutableDictionary *iconAssets=[NSMutableDictionary dictionary];error=nil;
    NSArray *unsetCaptured=[CSBackupAssets captureFields:unsetIcons root:root assets:iconAssets error:&error];
    Check(unsetCaptured.count==8&&iconAssets.count==0&&error==nil,@"all eight unset tab icons back up without requiring image files");
    NSMutableDictionary *staleIcon=[unsetIcons[0] mutableCopy];staleIcon[@"present"]=@YES;
    staleIcon[@"value"]=[root URLByAppendingPathComponent:@"removed-tabbar.png"].path;
    NSArray *staleCaptured=[CSBackupAssets captureFields:@[staleIcon] root:root assets:iconAssets error:&error];
    Check(staleCaptured.count==1&&![staleCaptured[0][@"present"] boolValue]&&!staleCaptured[0][@"value"],@"stale tab icon path exports the native fallback as unset");
    Check([staleIcon[@"present"] boolValue]&&[staleIcon[@"value"] hasSuffix:@"removed-tabbar.png"],@"capture does not rewrite live preferences");
    writes=[NSMutableDictionary dictionary];
    NSArray *staleReady=[CSBackupAssets materializeFields:staleCaptured assets:iconAssets root:newRoot writes:writes error:&error];
    Check(staleReady.count==1&&![staleReady[0][@"present"] boolValue]&&writes.count==0,@"restore clears stale icon preference without fabricating a file");
    staleIcon[@"value"]=@"";
    Check(![[CSBackupAssets captureFields:@[staleIcon] root:root assets:iconAssets error:&error][0][@"present"] boolValue],@"empty tab icon path is unset");
    NSURL *corruptIcon=[root URLByAppendingPathComponent:@"corrupt-tabbar.png"];
    [[@"broken image" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:corruptIcon atomically:YES];
    staleIcon[@"value"]=corruptIcon.path;
    Check(![CSBackupAssets captureFields:@[staleIcon] root:root assets:iconAssets error:&error],@"existing corrupt tab icon still blocks incomplete backup");
    staleIcon[@"value"]=[root URLByAppendingPathComponent:@"link.png"].path;
    Check(![CSBackupAssets captureFields:@[staleIcon] root:root assets:iconAssets error:&error],@"tab icon symlink is not treated as unset");
    staleIcon[@"value"]=[root URLByAppendingPathComponent:@"separator_image.png"].path;error=nil;
    NSArray *realIcon=[CSBackupAssets captureFields:@[staleIcon] root:root assets:iconAssets error:&error];
    Check([realIcon[0][@"present"] boolValue]&&[realIcon[0][@"value"] hasPrefix:@"csbackup:"]&&iconAssets.count==1,@"valid configured tab icon remains fully backed up");
    bad[@"value"]=[root URLByAppendingPathComponent:@"missing-non-tabbar.png"].path;
    Check(![CSBackupAssets captureFields:@[bad] root:root assets:assets error:&error],@"missing non-tabbar resource retains its existing protection");
    NSArray *fallback=@[@{@"domain":@"standard",@"key":@"com.wechat.tweak.navigation.separator.image",@"present":@NO}];
    NSArray *fallbackCaptured=[CSBackupAssets captureFields:fallback root:root assets:assets error:&error];
    Check(![fallbackCaptured[0][@"present"] boolValue]&&fallbackCaptured[0][@"fallbackAsset"]!=nil,@"fixed fallback survives explicitly absent path key");
    writes=[NSMutableDictionary dictionary];NSArray *fallbackReady=[CSBackupAssets materializeFields:fallbackCaptured assets:assets root:newRoot writes:writes error:&error];
    Check(![fallbackReady[0][@"present"] boolValue]&&[writes[@"separator_image.png"][@"data"] isEqual:png],@"fallback restoration preserves preference absence and bytes");
    writes=[NSMutableDictionary dictionary];[CSBackupAssets materializeFields:fallback assets:@{} root:newRoot writes:writes error:&error];
    Check(![writes[@"separator_image.png"][@"present"] boolValue],@"explicit absent fallback removes stale fixed file");
    NSMutableDictionary *contactEntry=nil;for(NSDictionary *entry in [CSBackupRegistry entries])if([entry[@"resource"] isEqual:@"contacts"])contactEntry=[entry mutableCopy];
    NSDictionary *contactField=@{@"domain":contactEntry[@"domain"],@"key":contactEntry[@"key"],@"present":@YES,@"value":@{@"alice":@{@"enabled":@YES,@"separatorImagePath":[root URLByAppendingPathComponent:@"separator_image.png"].path}}};
    NSArray *contactCaptured=[CSBackupAssets captureFields:@[contactField] root:root assets:assets error:&error];writes=[NSMutableDictionary dictionary];NSArray *contactReady=[CSBackupAssets materializeFields:contactCaptured assets:assets root:newRoot writes:writes error:&error];
    Check([contactReady[0][@"value"][@"alice"][@"separatorImagePath"] hasPrefix:newRoot.path],@"nested contact image rebased to current container");
    Check(![CSBackupAssets validImage:[png subdataWithRange:NSMakeRange(0,40)]],@"truncated image cannot pass on metadata alone");
    NSURL *alias=[NSURL fileURLWithPath:[root.path stringByAppendingString:@"-alias"]];
    [NSFileManager.defaultManager createSymbolicLinkAtURL:alias withDestinationURL:root error:NULL];
    NSURL *ownedRoot=[root URLByAppendingPathComponent:@"owned"],*aliasedRoot=[alias URLByAppendingPathComponent:@"owned"];
    [NSFileManager.defaultManager createDirectoryAtURL:ownedRoot withIntermediateDirectories:YES attributes:nil error:NULL];
    [png writeToURL:[ownedRoot URLByAppendingPathComponent:@"icon.png"] atomically:YES];
    bad[@"value"]=[aliasedRoot URLByAppendingPathComponent:@"icon.png"].path;
    Check([CSBackupAssets captureFields:@[bad] root:aliasedRoot assets:assets error:&error]!=nil,@"trusted system parent alias does not reject an ordinary owned image");
    bad[@"value"]=[ownedRoot URLByAppendingPathComponent:@"icon.png"].path;
    Check([CSBackupAssets captureFields:@[bad] root:aliasedRoot assets:assets error:&error]!=nil,@"canonical path and aliased root refer to the same owned file");
    [NSFileManager.defaultManager createSymbolicLinkAtURL:[ownedRoot URLByAppendingPathComponent:@"linked"] withDestinationURL:root error:NULL];
    bad[@"value"]=[aliasedRoot URLByAppendingPathComponent:@"linked/separator_image.png"].path;
    Check(![CSBackupAssets captureFields:@[bad] root:aliasedRoot assets:assets error:&error],@"symlink within owned directory is still rejected");
    [NSFileManager.defaultManager removeItemAtURL:alias error:NULL];
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];
    printf("Backup assets: %lu checks passed\n",(unsigned long)checks);
}return 0;}
