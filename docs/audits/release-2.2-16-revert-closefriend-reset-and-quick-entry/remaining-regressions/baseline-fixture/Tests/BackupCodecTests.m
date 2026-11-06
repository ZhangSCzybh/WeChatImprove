#import <Foundation/Foundation.h>
#import "CSBackupCodec.h"
static NSUInteger checks;
static void Check(BOOL b,NSString *message) { checks++;if (!b) { fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1); } }
int main(void) { @autoreleasepool {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:1700000000];
    NSDictionary *profile=@{@"version":@1,@"customTabs":@[@{@"id":@"work",@"name":@"工作",@"members":@[@"friend"],@"created":date,@"updated":date}],@"presetNames":@{},@"tabOrder":@[@"work"],@"hiddenPresetTabs":@[],@"selectedTabID":@"work",@"filterDuplicates":@NO,@"legacyImported":@NO};
    NSDictionary *s=@{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"createdAt":date,@"name":@"test",@"kind":@"manual",@"source":@{@"account":@"alice",@"installationID":@"test",@"pluginVersion":@"1.8-37"},@"fields":@[@{@"domain":@"standard",@"key":@"com.wechat.enhance.chat_group.account_profiles",@"present":@YES,@"value":@{@"alice":profile}},@{@"domain":@"legacy",@"key":@"roundAvatar",@"present":@NO}],@"assets":@{},@"warnings":@[]};
    NSError *error=nil;NSData *data=[CSBackupCodec encode:s error:&error];
    Check(data!=nil,@"complete nested-date snapshot encodes");
    NSDictionary *restored=[CSBackupCodec decode:data error:&error];
    Check([restored[@"fields"] isEqual:s[@"fields"]],@"nested group dates and explicit absence survive export/import");
    Check([[CSBackupCodec digest:@{@"a":@1,@"b":@2}] isEqual:[CSBackupCodec digest:@{@"b":@2,@"a":@1}]],@"dictionary ordering does not create duplicate snapshots");
    Check(![[CSBackupCodec digest:@YES] isEqual:[CSBackupCodec digest:@1]],@"bool and numeric one retain distinct types");
    Check(![[CSBackupCodec digest:[@"x" dataUsingEncoding:NSUTF8StringEncoding]] isEqual:[CSBackupCodec digest:@"x"]],@"binary and text are distinct");
    NSMutableDictionary *bad=[s mutableCopy];bad[@"formatVersion"]=@3;
    Check(![CSBackupCodec encode:bad error:&error],@"future format cannot be applied");
    bad=[s mutableCopy];bad[@"fields"]=@[@{@"domain":@"standard",@"key":@"WeChatHostSetting",@"present":@YES,@"value":@1}];
    Check(![CSBackupCodec encode:bad error:&error],@"unknown host key is rejected");
    bad=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:NULL];bad[@"name"]=@"tampered";
    NSData *tampered=[NSPropertyListSerialization dataWithPropertyList:bad format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
    Check(![CSBackupCodec decode:tampered error:&error],@"metadata tampering fails integrity before application");
    Check(![CSBackupCodec decode:[@"{}" dataUsingEncoding:NSUTF8StringEncoding] error:&error],@"arbitrary JSON is not a v2 snapshot");
    bad=[s mutableCopy];bad[@"fields"]=@[@{@"domain":@"standard",@"key":@"com.wechat.tweak.navigation.separator.image",@"present":@YES,@"value":[@"csbackup:" stringByAppendingString:[@"" stringByPaddingToLength:64 withString:@"0" startingAtIndex:0]]}];
    Check(![CSBackupCodec encode:bad error:&error],@"missing asset rejected before publication");
    bad=[s mutableCopy];bad[@"fields"]=@[@{@"domain":@"legacy",@"key":@"roundAvatar",@"present":@NO,@"fallbackAsset":@"csbackup:invalid"}];
    Check(![CSBackupCodec encode:bad error:&error],@"non-resource field cannot smuggle a fallback");
    bad=[s mutableCopy];bad[@"fields"]=@[s[@"fields"][0],s[@"fields"][0]];
    Check(![CSBackupCodec encode:bad error:&error],@"duplicate covered field rejected");
    bad=[s mutableCopy];bad[@"name"]=[@"x" stringByPaddingToLength:129 withString:@"x" startingAtIndex:0];
    Check(![CSBackupCodec encode:bad error:&error],@"name bound enforced");
    bad=[s mutableCopy];NSMutableDictionary *source=[s[@"source"] mutableCopy];source[@"accounts"]=@"not-an-array";bad[@"source"]=source;
    Check(![CSBackupCodec encode:bad error:&error],@"malformed account coverage rejected");
    id deep=@"leaf";for(NSUInteger i=0;i<35;i++)deep=@[deep];bad=[s mutableCopy];bad[@"unexpected"]=deep;
    Check(![CSBackupCodec encode:bad error:&error],@"deep structure rejected before hashing");
    NSMutableData *oversize=[NSMutableData dataWithLength:CSBackupMaximumFileSize+1];memcpy(oversize.mutableBytes,"bplist00",8);
    Check(![CSBackupCodec decode:oversize error:&error],@"oversized file rejected before parsing");
    printf("Backup codec: %lu checks passed\n",(unsigned long)checks);
}return 0; }
