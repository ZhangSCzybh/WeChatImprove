#import <Foundation/Foundation.h>
#import "CSBackupLegacyReader.h"
#import "CSBackupCodec.h"
#include <sys/stat.h>
static NSUInteger checks;
static void Check(BOOL ok,NSString *message) { checks++; if(!ok){NSLog(@"FAIL: %@",message);exit(1);} }
static NSString *const Host=@"test.wechat.host";
static NSString *const ImageKey=@"com.wechat.tweak.navigation.separator.image";
static NSString *const ProfilesKey=@"com.wechat.enhance.chat_group.account_profiles";
static NSMutableDictionary *Package(void) { return [@{@"version":@"1.0",@"backupInfo":@{@"backupId":@"12345678-1234-1234-1234-123456789012",@"backupName":@"Original backup",@"createTime":@1700000000,@"isAutoBackup":@NO,@"filePath":@"/untrusted/ignored"},@"createDate":@1800000000,@"settings":@{Host:@{@"GameCheat_Enabled":@YES,@"AppleLanguages":@[@"en"],@"com.wechat.enhance.redenvelop.totalCount":@99},@"com.cyansmoke.wechattweak":@{@"roundAvatar":@YES},@"com.wechat.enhance":@{@"font.chat_size":@18}}} mutableCopy]; }
static NSDictionary *Read(NSDictionary *package,NSURL *root,NSString *extension,NSError **error) { NSURL *url=[root URLByAppendingPathComponent:[@"input." stringByAppendingString:extension]]; NSData *data=[NSJSONSerialization dataWithJSONObject:package options:0 error:NULL]; Check([data writeToURL:url options:NSDataWritingAtomic error:NULL],@"fixture write succeeds"); return [CSBackupLegacyReader readURL:url standardDomain:Host error:error]; }
static NSDictionary *Field(NSDictionary *snapshot,NSString *key) {for(NSDictionary *field in snapshot[@"fields"])if([field[@"key"] isEqual:key])return field;return nil;}
int main(int argc,const char *argv[]) { @autoreleasepool {
    Check(argc==2,@"test fixture root provided by disposable verifier directory");
    NSURL *root=[NSURL fileURLWithPath:[NSString stringWithUTF8String:argv[1]] isDirectory:YES];
    NSFileManager *fm=NSFileManager.defaultManager; NSError *error=nil;
    Check([fm createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:&error],@"isolated root created");
    NSMutableDictionary *p=Package(); NSDictionary *s=Read(p,root,@"wechatbackup",&error);
    Check(s!=nil,error.localizedDescription ?: @"old JSON imports");
    Check([s[@"createdAt"] isEqual:[NSDate dateWithTimeIntervalSince1970:1700000000]],@"original capture date survives export/import date");
    Check([s[@"id"] isEqual:p[@"backupInfo"][@"backupId"]],@"original ID preserved");
    Check([s[@"fields"] count]==3,@"only exact plugin identities survive");
    Check([Field(s,@"roundAvatar")[@"domain"] isEqual:@"legacy"],@"legacy suite is correctly mapped");
    Check([Field(s,@"font.chat_size")[@"domain"] isEqual:@"layout"],@"layout suite is correctly mapped");
    Check([s[@"warnings"] count]>0,@"host/payment filtering is disclosed");
    for(NSDictionary *f in s[@"fields"])Check([f[@"present"] isEqual:@YES],@"legacy conversion never invents absence");
    Check([CSBackupCodec encode:s error:&error]!=nil,@"conversion is valid v2 snapshot");
    Check(Read(p,root,@"wcbak",&error)!=nil,@"old sent wcbak JSON extension accepted");
    NSMutableDictionary *settings=[p[@"settings"] mutableCopy]; NSMutableDictionary *host=[settings[Host] mutableCopy];
    host[ProfilesKey]=@{@"__type__":@"unknown",@"value":@"{ lost date-containing profile description }"}; settings[Host]=host;p[@"settings"]=settings;
    s=Read(p,root,@"wechatbackup",&error);Check(s!=nil,@"historically lost group fields produce incomplete warnings");Check(!Field(s,ProfilesKey),@"unknown descriptions are not recovered or applied");
    Check([[s[@"warnings"] componentsJoinedByString:@" "] containsString:@"account_profiles"],@"warning identifies lost group configuration");
    NSData *png=[[NSData alloc] initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aX1sAAAAASUVORK5CYII=" options:0];
    host[ImageKey]=@"/old/container/Library/Preferences/WeChatImprove/separator_image.png";
    host[@"com.wechat.enhance.inputText.color"]=@{@"__type__":@"data",@"value":[[@"opaque color" dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0]};
    settings[Host]=host;settings[@"WeChatImprove"]=@{@"separator_image.png":[png base64EncodedStringWithOptions:0]};p[@"settings"]=settings;
    s=Read(p,root,@"wcbak",&error);Check(s!=nil,error.localizedDescription ?: @"old resource tree decoded");Check([s[@"assets"] count]==1,@"referenced image stored by content");Check([Field(s,ImageKey)[@"value"] hasPrefix:@"csbackup:"],@"absolute old sandbox path becomes asset reference");
    Check([Field(s,@"com.wechat.enhance.inputText.color")[@"value"] isKindOfClass:NSData.class],@"typed data wrapper decoded safely");
    Check([CSBackupCodec encode:s error:&error]!=nil,@"resource conversion encodes as v2");
    NSString *contactKey=@"com.wechat.tweak.navigation.contact.overrides",*iconKey=@"com.wechat.enhance.tabbar_style.icon.selected.chat";
    p=Package();p[@"settings"]=@{Host:@{contactKey:@{@"alice":@{@"enabled":@YES,@"separatorImagePath":@"/old/WeChatImprove/separator_alice.png"}},iconKey:@"/old/obsolete.png"},@"WeChatImprove":@{@"separator_alice.png":[png base64EncodedStringWithOptions:0],@"tabbar_icon_chat_selected.png":[png base64EncodedStringWithOptions:0],@"unreferenced.png":[png base64EncodedStringWithOptions:0]}};
    s=Read(p,root,@"wcbak",&error);Check(s!=nil,error.localizedDescription ?: @"nested contact and fixed icon fallback convert");
    Check([Field(s,contactKey)[@"value"][@"alice"][@"separatorImagePath"] hasPrefix:@"csbackup:"],@"nested contact old path becomes logical reference");
    Check([Field(s,iconKey)[@"value"] hasPrefix:@"csbackup:"],@"selected icon uses its known legacy basename fallback");
    Check([s[@"assets"] count]==1,@"same image bytes deduplicate across contact and icon");
    Check([[s[@"warnings"] componentsJoinedByString:@" "] containsString:@"未关联"],@"unreferenced old resource filtering disclosed");
    p=Package();p[@"settings"]=@{Host:@{ImageKey:@""},@"WeChatImprove":@{@"separator_image.png":[png base64EncodedStringWithOptions:0]}};
    s=Read(p,root,@"wcbak",&error);Check(s!=nil,@"explicit empty path can retain its fixed native fallback");
    Check([Field(s,ImageKey)[@"value"] isEqual:@""] && [Field(s,ImageKey)[@"fallbackAsset"] hasPrefix:@"csbackup:"],@"fallback resources do not invent preference absence");
    // Reject malformed metadata, missing settings and lookalike domains before any active write.
    p=Package();[p removeObjectForKey:@"settings"];Check(Read(p,root,@"wechatbackup",&error)==nil,@"missing settings rejected");
    p=Package();p[@"settings"]=@{};Check(Read(p,root,@"wechatbackup",&error)==nil,@"empty settings rejected");
    p=Package();p[@"version"]=@"2.0";Check(Read(p,root,@"wechatbackup",&error)==nil,@"future legacy schema rejected");
    p=Package();p[@"backupInfo"]=@{@"backupId":NSUUID.UUID.UUIDString,@"backupName":@"bad",@"createTime":@"yesterday"};Check(Read(p,root,@"wechatbackup",&error)==nil,@"invalid original date rejected");
    p=Package();p[@"settings"]=@{@"evil.com.tencent.xin.copy":@{@"GameCheat_Enabled":@YES}};Check(Read(p,root,@"wechatbackup",&error)==nil,@"domain substring match cannot authorize fields");
    p=Package();p[@"settings"]=@{@"com.tencent.xin":@{@"GameCheat_Enabled":@YES}};Check(Read(p,root,@"wechatbackup",&error)!=nil,@"exact original WeChat domain accepted");
    p=Package();p[@"settings"]=@{Host:@{ImageKey:@"/old/../../outside.png"},@"WeChatImprove":@{@"../outside.png":[png base64EncodedStringWithOptions:0]}};Check(Read(p,root,@"wcbak",&error)==nil,@"folder traversal refused");
    p=Package();p[@"settings"]=@{Host:@{ImageKey:@"/old/separator_image.png"},@"WeChatImprove":@{@"separator_image.png":@"not base64"}};Check(Read(p,root,@"wcbak",&error)==nil,@"bad resource base64 refused");
    p=Package();p[@"settings"]=@{Host:@{ImageKey:@"/old/separator_image.png"}};Check(Read(p,root,@"wcbak",&error)==nil,@"missing referenced image refuses incomplete conversion");
    p=Package();p[@"settings"]=@{Host:@{@"GameCheat_Enabled":@"yes"}};Check(Read(p,root,@"wcbak",&error)==nil,@"malformed known values rejected");
    p=Package();p[@"settings"]=@{Host:@{@"com.wechat.enhance.inputText.color":@{@"__type__":@"data",@"value":@"%%%"}}};Check(Read(p,root,@"wcbak",&error)==nil,@"malformed data wrapper rejected");
    p=Package();p[@"settings"]=@{Host:@{ImageKey:@"/old/same.png"},@"WeChatImprove":@{@"a":@{@"same.png":[png base64EncodedStringWithOptions:0]},@"b":@{@"same.png":[png base64EncodedStringWithOptions:0]}}};Check(Read(p,root,@"wcbak",&error)==nil,@"ambiguous old basename cannot choose another resource");
    p=Package();p[@"settings"]=@{Host:@{@"GameCheat_Enabled":@YES},@"WeChatImprove":@{[NSString stringWithFormat:@"bad%C.png",(unichar)0]:[png base64EncodedStringWithOptions:0]}};Check(Read(p,root,@"wcbak",&error)==nil,@"embedded NUL resource name rejected");
    p=Package();p[@"settings"]=@{Host:@{@"GameCheat_Enabled":@YES},@"com.tencent.xin":@{@"GameCheat_Enabled":@NO}};Check(Read(p,root,@"wcbak",&error)==nil,@"conflicting exact host domain variants rejected");
    // Real old local directories preserve nested dates from their plist source.
    NSURL *local=[root URLByAppendingPathComponent:@"12345678-1234-1234-1234-123456789012" isDirectory:YES];Check([fm createDirectoryAtURL:local withIntermediateDirectories:NO attributes:nil error:&error],@"local legacy directory created");
    NSDictionary *profile=@{@"version":@1,@"customTabs":@[@{@"id":@"work",@"name":@"Work",@"members":@[@"alice"],@"created":[NSDate dateWithTimeIntervalSince1970:1699999999]}],@"presetNames":@{},@"tabOrder":@[@"preset_0",@"work"],@"hiddenPresetTabs":@[],@"selectedTabID":@"work",@"filterDuplicates":@NO,@"legacyImported":@YES};
    NSDictionary *values=@{ProfilesKey:@{@"alice":profile},@"GameCheat_Enabled":@YES,ImageKey:@"/old/separator_image.png"};
    NSData *plist=[NSPropertyListSerialization dataWithPropertyList:values format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];Check([plist writeToURL:[local URLByAppendingPathComponent:[Host stringByAppendingString:@".plist"]] atomically:YES],@"local preferences fixture written");
    NSData *index=[NSJSONSerialization dataWithJSONObject:@[Package()[@"backupInfo"]] options:0 error:NULL];Check([index writeToURL:[root URLByAppendingPathComponent:@"backup_info.json"] atomically:YES],@"original index fixture written");
    NSURL *images=[local URLByAppendingPathComponent:@"WeChatImprove" isDirectory:YES];Check([fm createDirectoryAtURL:images withIntermediateDirectories:NO attributes:nil error:&error],@"local image folder created");Check([png writeToURL:[images URLByAppendingPathComponent:@"separator_image.png"] atomically:YES],@"local image fixture written");
    s=[CSBackupLegacyReader readURL:local standardDomain:Host error:&error];Check(s!=nil,error.localizedDescription ?: @"old directory converts");Check([Field(s,ProfilesKey)[@"value"] isEqual:values[ProfilesKey]],@"local original nested dates preserved");
    Check([s[@"createdAt"] isEqual:[NSDate dateWithTimeIntervalSince1970:1700000000]],@"local directory uses original index time, not mtime");
    Check([Field(s,ImageKey)[@"value"] hasPrefix:@"csbackup:"] && [s[@"assets"] count]==1,@"local directory image bytes preserved without active resource writes");
    Check([CSBackupCodec encode:s error:&error]!=nil,@"old directory output is valid v2");
    NSURL *v2=[root URLByAppendingPathComponent:@"already-v2.wcbak"];Check([[CSBackupCodec encode:s error:&error] writeToURL:v2 atomically:YES],@"v2 dispatch fixture written");error=CSBackupFailure(@"stale");Check(![CSBackupLegacyReader readURL:v2 standardDomain:Host error:&error] && error==nil,@"v2 is delegated to codec without a stale legacy error");
    Check([fm removeItemAtURL:[root URLByAppendingPathComponent:@"backup_info.json"] error:&error],@"index removed for missing-metadata test");Check(![CSBackupLegacyReader readURL:local standardDomain:Host error:&error],@"directory without original metadata refuses invented creation time");Check([index writeToURL:[root URLByAppendingPathComponent:@"backup_info.json"] atomically:YES],@"index restored for remaining source tests");
    NSURL *link=[root URLByAppendingPathComponent:@"linked.wechatbackup"];Check([fm createSymbolicLinkAtURL:link withDestinationURL:[root URLByAppendingPathComponent:@"input.wechatbackup"] error:&error],@"symlink fixture created");Check(![CSBackupLegacyReader readURL:link standardDomain:Host error:&error],@"symlink source refused");
    Check([fm createSymbolicLinkAtPath:[[local URLByAppendingPathComponent:@"evil.plist"] path] withDestinationPath:@"/etc/hosts" error:&error],@"directory symlink fixture created");Check(![CSBackupLegacyReader readURL:local standardDomain:Host error:&error],@"symlink in old directory refused");
    NSURL *oversized=[root URLByAppendingPathComponent:@"oversized.wcbak"];Check([fm createFileAtPath:oversized.path contents:NSData.data attributes:nil],@"oversize fixture created");NSFileHandle *handle=[NSFileHandle fileHandleForWritingToURL:oversized error:&error];[handle truncateFileAtOffset:CSBackupMaximumFileSize+1];[handle closeFile];Check(![CSBackupLegacyReader readURL:oversized standardDomain:Host error:&error],@"oversize file rejected before parsing");
    NSURL *fifo=[root URLByAppendingPathComponent:@"fifo.wcbak"];Check(mkfifo(fifo.path.fileSystemRepresentation,0600)==0,@"nonregular source fixture created");Check(![CSBackupLegacyReader readURL:fifo standardDomain:Host error:&error],@"nonregular input rejected without blocking");
    Check([fm removeItemAtURL:root error:&error],@"temporary fixtures removed");
    NSLog(@"Backup legacy: %lu checks passed",(unsigned long)checks);
}return 0;}
