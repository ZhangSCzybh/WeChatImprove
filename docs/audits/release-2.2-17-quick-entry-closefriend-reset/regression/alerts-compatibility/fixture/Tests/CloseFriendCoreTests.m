#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendCrypto.h"
#import "CSCloseFriendStore.h"
#import <CommonCrypto/CommonCrypto.h>
#import <sys/stat.h>
#import <math.h>
static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while(0)
static NSDictionary *Profile(void) { return @{ @"enabled":@YES, @"friends":@[@"alice"], @"groups":@[@"room@chatroom"], @"options":@{} }; }
@interface CSCloseFriendStore (FaultInjection)
- (BOOL)writeStagedData:(NSData *)data URL:(NSURL *)url error:(NSError **)error;
@end
@interface FaultStore : CSCloseFriendStore
@property(nonatomic) NSUInteger fault;
@end
@implementation FaultStore
- (BOOL)writeStagedData:(NSData *)data URL:(NSURL *)url error:(NSError **)error {
    if(![super writeStagedData:data URL:url error:error])return NO;
    if(self.fault==1) { if(error)*error=[NSError errorWithDomain:@"TestInterruption" code:1 userInfo:nil]; return NO; }
    if(self.fault==2) { NSMutableData *broken=[data mutableCopy]; ((uint8_t *)broken.mutableBytes)[24]^=1; return [broken writeToURL:url options:0 error:error]; }
    return YES;
}
@end
static NSData *EncryptedObject(id object,NSData *key) {
    return CSCloseFriendEncrypt([NSPropertyListSerialization dataWithPropertyList:object format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL],key,NULL);
}
static NSString *Hex(NSData *data) { NSMutableString *hex=[NSMutableString string]; const uint8_t *bytes=data.bytes; for(NSUInteger i=0;i<data.length;i++)[hex appendFormat:@"%02x",bytes[i]]; return hex; }
int main(void) { @autoreleasepool {
    NSError *error=nil;
    NSDictionary *profile=CSCloseFriendNormalizeProfile(Profile(), &error);
    CHECK(profile && !error);
    CSCloseFriendSnapshot *locked=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:profile revealed:NO revision:1 blocked:NO];
    CSCloseFriendSnapshot *open=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:profile revealed:YES revision:2 blocked:NO];
    CHECK([locked hidesUserName:@"alice" surface:CSCloseFriendSurfaceSession]);
    CHECK(![locked hidesUserName:@"bob" surface:CSCloseFriendSurfaceSession]);
    CHECK(![open hidesUserName:@"alice" surface:CSCloseFriendSurfaceSession]);
    CHECK([locked rejectsCaller:@"alice" chatRoom:nil video:NO]);
    CHECK([locked rejectsCaller:@"bob" chatRoom:@"room@chatroom" video:YES]);
    CHECK(![locked rejectsCaller:@"bob" chatRoom:@"other@chatroom" video:YES]);
    CHECK([locked rejectsCaller:@"alice" chatRoom:@"other@chatroom" video:YES]);
    for(NSNumber *video in @[@NO,@YES]) {
        CHECK(![open rejectsCaller:@"alice" chatRoom:nil video:video.boolValue]);
        CHECK(![open rejectsCaller:@"bob" chatRoom:@"room@chatroom" video:video.boolValue]);
    }
    CHECK(CSCloseFriendNormalizeProfile(@{@"enabled":@"yes"}, &error)==nil);
    NSData *key=CSCloseFriendRandomBytes(64,&error);
    CHECK(key.length==64);
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(NSString *account, NSError **err) { (void)account; (void)err; return key; }];
    CHECK([store saveState:@{@"profile":profile} forAccountID:@"one" error:&error]);
    CHECK([[[store loadStateForAccountID:@"one" error:&error] objectForKey:@"profile"] isEqual:profile]);
    CHECK([store loadStateForAccountID:@"two" error:&error]==nil);
    NSArray<NSURL *> *files=[[NSFileManager defaultManager] contentsOfDirectoryAtURL:root includingPropertiesForKeys:nil options:0 error:&error];
    CHECK(files.count==1);
    NSData *cipher=[NSData dataWithContentsOfURL:files[0]];
    CHECK([cipher rangeOfData:[@"alice" dataUsingEncoding:NSUTF8StringEncoding] options:0 range:NSMakeRange(0,cipher.length)].location==NSNotFound);
    CSCloseFriendStore *wrong=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(NSString *account, NSError **err) { (void)account; return CSCloseFriendRandomBytes(64,err); }];
    CHECK([wrong loadStateForAccountID:@"one" error:&error]==nil);
    CHECK(![wrong saveState:@{@"profile":profile} forAccountID:@"one" error:&error]);
    CHECK([[NSData dataWithContentsOfURL:files[0]] isEqual:cipher]);
    NSMutableData *tampered=[cipher mutableCopy]; ((uint8_t *)tampered.mutableBytes)[20]^=1;
    CHECK([tampered writeToURL:files[0] options:0 error:&error]);
    CHECK([store loadStateForAccountID:@"one" error:&error]==nil);
    CHECK(![store saveState:@{@"profile":profile} forAccountID:@"one" error:&error]);
    CHECK([[NSData dataWithContentsOfURL:files[0]] isEqual:tampered]);
    // Invalid input cannot replace a previously valid encrypted account.
    CHECK([cipher writeToURL:files[0] options:0 error:&error]);
    NSMutableDictionary *badProfile=[profile mutableCopy]; badProfile[@"options"]=@{@"unknownFutureOption":@YES};
    CHECK(![store saveState:@{@"profile":badProfile} forAccountID:@"one" error:&error]);
    CHECK([[NSData dataWithContentsOfURL:files[0]] isEqual:cipher]);
    for(id invalid in @[@{}, @{@"enabled":@1,@"friends":@[],@"groups":@[],@"options":@{}}, @{@"enabled":@YES,@"friends":@[@1],@"groups":@[],@"options":@{}}, @{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":@{@"unlockSeconds":@0}}, @{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":@{@"hideSessions":@1}}]) CHECK(!CSCloseFriendNormalizeProfile(invalid,&error));
    // Every hiding switch controls exactly one surface.
    NSArray *surfaceKeys=@[@"hideSessions",@"hideContacts",@"hideForwarding",@"hideTags",@"hideSearch",@"hideTimeline",@"hideInteractions",@"hideStatus",@"maskProfiles",@"hideScheduledTasks",@"hideAIReply"];
    for(NSUInteger i=0;i<surfaceKeys.count;i++) {
        for(NSNumber *on in @[@NO,@YES]) {
            NSMutableDictionary *options=[NSMutableDictionary dictionary];
            for(NSString *key in surfaceKeys)options[key]=on.boolValue?@NO:@YES;
            options[surfaceKeys[i]]=on;
            NSMutableDictionary *p=[Profile() mutableCopy]; p[@"options"]=options;
            CSCloseFriendSnapshot *snap=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:p revealed:NO revision:3 blocked:NO];
            for(NSUInteger j=0;j<surfaceKeys.count;j++)CHECK([snap hidesUserName:@"alice" surface:j]==(i==j?on.boolValue:!on.boolValue));
        }
    }
    NSDictionary *defaults=CSCloseFriendDefaultOptions(); CHECK([CSCloseFriendNormalizeProfile(Profile(),NULL)[@"options"] isEqual:defaults]);
    for(NSString *name in @[@"hideSessions",@"hideContacts",@"hideForwarding",@"hideTags",@"hideSearch",@"hideTimeline",@"hideInteractions",@"hideStatus",@"maskProfiles",@"rejectVoice",@"rejectVideo",@"hidePrivacyIcons"])CHECK([defaults[name] boolValue]);
    for(NSString *retired in @[@"autoMute",@"silenceMessages"]) {
        CHECK(defaults[retired]==nil);
        for(NSNumber *value in @[@NO,@YES]) {
            NSMutableDictionary *legacyOptions=[defaults mutableCopy];legacyOptions[retired]=value;
            NSMutableDictionary *legacyProfile=[Profile() mutableCopy];legacyProfile[@"options"]=legacyOptions;
            CHECK([CSCloseFriendNormalizeProfile(legacyProfile,NULL) isEqual:profile]);
        }
        for(id value in @[@0,@1,@"true",NSNull.null]) {
            NSMutableDictionary *invalid=[Profile() mutableCopy];invalid[@"options"]=@{retired:value};
            CHECK(!CSCloseFriendNormalizeProfile(invalid,NULL));
        }
    }
    // Read historical encrypted profiles directly: loading must preserve all other data and the source bytes.
    for(NSNumber *enabled in @[@NO,@YES]) for(NSNumber *silence in @[@NO,@YES]) {
        NSMutableDictionary *legacyOptions=[defaults mutableCopy];
        legacyOptions[@"hideSearch"]=@NO;legacyOptions[@"rejectVoice"]=@NO;legacyOptions[@"callReplyText"]=@"保留原来的回复。";
        NSMutableDictionary *expected=[Profile() mutableCopy];expected[@"enabled"]=enabled;expected[@"options"]=[legacyOptions copy];
        legacyOptions[@"silenceMessages"]=silence;
        NSMutableDictionary *legacyProfile=[expected mutableCopy];legacyProfile[@"options"]=legacyOptions;
        NSDictionary *records=@{@"alice":@{@"before":@NO,@"applied":@YES}};
        NSData *legacyCipher=EncryptedObject(@{@"schema":@1,@"accountID":@"one",@"state":@{@"profile":legacyProfile,@"muteRecords":records}},key);
        CHECK([legacyCipher writeToURL:files[0] options:0 error:&error]);
        NSDictionary *loaded=[store loadStateForAccountID:@"one" error:&error];
        CHECK([loaded[@"profile"] isEqual:expected] && [loaded[@"muteRecords"] isEqual:records]);
        CHECK([[NSData dataWithContentsOfURL:files[0]] isEqual:legacyCipher]);
        CHECK([store saveState:loaded forAccountID:@"one" error:&error]);
        NSDictionary *saved=[NSPropertyListSerialization propertyListWithData:CSCloseFriendDecrypt([NSData dataWithContentsOfURL:files[0]],key,NULL) options:NSPropertyListImmutable format:NULL error:NULL];
        CHECK(!saved[@"state"][@"profile"][@"options"][@"silenceMessages"]);
        CHECK([[store loadStateForAccountID:@"one" error:&error] isEqual:loaded]);
    }
    CHECK([cipher writeToURL:files[0] options:0 error:&error]);

    for(NSString *name in @[@"showBadges",@"hideSettingsEntry",@"hidePluginEntry",@"biometric",@"shakeToLock",@"callReplyEnabled",@"hideScheduledTasks",@"hideAIReply"])CHECK(![defaults[name] boolValue]);
    for(NSString *name in @[@"hideScheduledTasks",@"hideAIReply"]) {
        NSMutableDictionary *p=[Profile() mutableCopy]; p[@"options"]=@{name:@YES};
        NSDictionary *normalized=CSCloseFriendNormalizeProfile(p,NULL);
        CHECK([normalized[@"options"][name] boolValue]);
        CHECK([store saveState:@{@"profile":normalized} forAccountID:@"one" error:&error]);
        CHECK([[store loadStateForAccountID:@"one" error:&error][@"profile"] isEqual:normalized]);
        for(id value in @[@1,@"true",NSNull.null]) {
            p[@"options"]=@{name:value};CHECK(!CSCloseFriendNormalizeProfile(p,NULL));
        }
    }
    CHECK([defaults[@"unlockSeconds"] isEqual:@300]);
    CHECK([defaults[@"longPressUnlockEnabled"] boolValue]);
    CHECK([defaults[@"longPressUnlockDuration"] doubleValue]==1.0);
    for(NSNumber *duration in @[@0.5,@0.75,@1,@1.5,@2]) {
        NSMutableDictionary *p=[Profile() mutableCopy];
        p[@"options"]=@{@"longPressUnlockEnabled":@NO,@"longPressUnlockDuration":duration};
        NSDictionary *normalized=CSCloseFriendNormalizeProfile(p,NULL);
        CHECK(normalized && ![normalized[@"options"][@"longPressUnlockEnabled"] boolValue]);
        CHECK([normalized[@"options"][@"longPressUnlockDuration"] isEqual:duration]);
        CHECK([store saveState:@{@"profile":normalized} forAccountID:@"one" error:&error]);
        CHECK([[store loadStateForAccountID:@"one" error:&error][@"profile"] isEqual:normalized]);
    }
    CHECK([cipher writeToURL:files[0] options:0 error:&error]);
    for(id duration in @[@0.49,@2.01,@(-1),@YES,@"1",@(NAN),@(INFINITY)]) {
        NSMutableDictionary *p=[Profile() mutableCopy]; p[@"options"]=@{@"longPressUnlockDuration":duration};
        CHECK(!CSCloseFriendNormalizeProfile(p,NULL));
    }
    NSMutableDictionary *invalidGesture=[Profile() mutableCopy]; invalidGesture[@"options"]=@{@"longPressUnlockEnabled":@1};
    CHECK(!CSCloseFriendNormalizeProfile(invalidGesture,NULL));
    CSCloseFriendSnapshot *blocked=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:@{} revealed:YES revision:4 blocked:NO];
    CHECK(blocked.blocked && !blocked.revealed);
    CHECK([blocked hidesUserName:@"bob" surface:CSCloseFriendSurfaceContact]);
    NSMutableString *mutableName=[@"alice" mutableCopy]; NSMutableArray *mutableNames=[NSMutableArray arrayWithObject:mutableName];
    NSMutableDictionary *mutableProfile=[Profile() mutableCopy]; mutableProfile[@"friends"]=mutableNames;
    CSCloseFriendSnapshot *frozen=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:mutableProfile revealed:NO revision:5 blocked:NO];
    [mutableName setString:@"mallory"]; [mutableNames removeAllObjects];
    CHECK([frozen containsUserName:@"alice"] && ![frozen containsUserName:@"mallory"]);
    NSMutableDictionary *callProfile=[Profile() mutableCopy]; callProfile[@"options"]=@{@"rejectVoice":@NO};
    CSCloseFriendSnapshot *calls=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:callProfile revealed:NO revision:6 blocked:NO];
    CHECK(![calls rejectsCaller:@"alice" chatRoom:nil video:NO]); CHECK([calls rejectsCaller:@"alice" chatRoom:nil video:YES]);
    // Version header, IV, ciphertext, MAC and truncation are independently rejected.
    for(NSNumber *offset in @[@0,@7,@8,@24,@(cipher.length-1)]) {
        NSMutableData *broken=[cipher mutableCopy]; ((uint8_t *)broken.mutableBytes)[offset.unsignedIntegerValue]^=1;
        CHECK(!CSCloseFriendDecrypt(broken,key,&error));
    }
    for(NSNumber *length in @[@0,@1,@55,@71,@(cipher.length-1)])CHECK(!CSCloseFriendDecrypt([cipher subdataWithRange:NSMakeRange(0,length.unsignedIntegerValue)],key,&error));
    NSMutableData *futureHeader=[cipher mutableCopy]; ((uint8_t *)futureHeader.mutableBytes)[7]=2;
    uint8_t newMAC[32]; CCHmac(kCCHmacAlgSHA256,(const uint8_t *)key.bytes+32,32,futureHeader.bytes,futureHeader.length-32,newMAC);
    memcpy((uint8_t *)futureHeader.mutableBytes+futureHeader.length-32,newMAC,32);
    CHECK(!CSCloseFriendDecrypt(futureHeader,key,&error));
    NSData *xml=[NSPropertyListSerialization dataWithPropertyList:@{@"schema":@1,@"accountID":@"one",@"state":@{@"profile":profile}} format:NSPropertyListXMLFormat_v1_0 options:0 error:NULL];
    NSArray *invalidEnvelopes=@[CSCloseFriendEncrypt(xml,key,NULL),EncryptedObject(@{@"schema":@1.0,@"accountID":@"one",@"state":@{@"profile":profile}},key),EncryptedObject(@{@"schema":@2,@"accountID":@"one",@"state":@{@"profile":profile}},key),EncryptedObject(@{@"schema":@YES,@"accountID":@"one",@"state":@{@"profile":profile}},key),EncryptedObject(@{@"schema":@1,@"accountID":@"other",@"state":@{@"profile":profile}},key),EncryptedObject(@{@"schema":@1,@"accountID":@"one",@"state":@{@"profile":badProfile}},key),futureHeader,[cipher subdataWithRange:NSMakeRange(0,71)]];
    for(NSData *invalid in invalidEnvelopes) {
        CHECK([invalid writeToURL:files[0] options:0 error:&error]);
        CHECK(![store loadStateForAccountID:@"one" error:&error]);
        CHECK(![store saveState:@{@"profile":profile} forAccountID:@"one" error:&error]);
        CHECK([[NSData dataWithContentsOfURL:files[0]] isEqual:invalid]);
    }
    CHECK([cipher writeToURL:files[0] options:0 error:&error]);
    FaultStore *faulty=[[FaultStore alloc] initWithRoot:root keyProvider:^NSData *(NSString *a,NSError **e) { (void)a;(void)e;return key; }];
    for(NSUInteger fault=1;fault<=2;fault++) {
        faulty.fault=fault;
        CHECK(![faulty saveState:@{@"profile":profile,@"muteRecords":@{@"alice":@{@"before":@NO,@"applied":@YES}}} forAccountID:@"one" error:&error]);
        CHECK([[NSData dataWithContentsOfURL:files[0]] isEqual:cipher]);
        CHECK([[NSFileManager.defaultManager contentsOfDirectoryAtURL:root includingPropertiesForKeys:nil options:0 error:&error] count]==1);
        CHECK([store loadStateForAccountID:@"one" error:&error]!=nil);
    }
    faulty.fault=0;
    CHECK([faulty saveState:@{@"profile":profile,@"muteRecords":@{@"alice":@{@"before":@NO,@"applied":@YES}}} forAccountID:@"one" error:&error]);
    CHECK([[[store loadStateForAccountID:@"one" error:&error][@"muteRecords"] allKeys] isEqual:@[@"alice"]]);
    CHECK([store saveState:@{@"profile":@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":@{}}} forAccountID:@"two" error:&error]);
    CHECK(![[store loadStateForAccountID:@"two" error:&error][@"profile"][@"enabled"] boolValue]);
    CHECK([[store loadStateForAccountID:@"one" error:&error][@"profile"][@"enabled"] boolValue]);
    NSError *sentinel=[NSError errorWithDomain:@"InjectedKeychainError" code:42 userInfo:nil];
    CSCloseFriendStore *keyFailure=[[CSCloseFriendStore alloc] initWithRoot:root keyProvider:^NSData *(NSString *a,NSError **e) { (void)a; if(e)*e=sentinel;return nil; }];
    CHECK(![keyFailure loadStateForAccountID:@"one" error:&error] && error==sentinel);
    CHECK(![keyFailure saveState:@{@"profile":profile} forAccountID:@"one" error:&error] && error==sentinel);
    error=nil; CHECK(![store loadStateForAccountID:@"absent" error:&error] && error.code==CSCloseFriendStoreErrorMissing && [error.domain isEqual:CSCloseFriendStoreErrorDomain]);
    struct stat fileStat; CHECK(!stat(files[0].path.fileSystemRepresentation,&fileStat) && (fileStat.st_mode&0777)==0600);
    CHECK(!stat(root.path.fileSystemRepresentation,&fileStat) && (fileStat.st_mode&0777)==0700);
    NSNumber *excluded=nil; CHECK([root getResourceValue:&excluded forKey:NSURLIsExcludedFromBackupKey error:&error] && excluded.boolValue);
    NSMutableData *salt=[NSMutableData dataWithLength:32]; for(NSUInteger i=0;i<32;i++)((uint8_t *)salt.mutableBytes)[i]=(uint8_t)i;
    NSData *verifier=CSCloseFriendPasswordVerifier(@"correct horse battery staple",salt,210000,&error);
    CHECK([Hex(verifier) isEqual:@"760eda82dfb2d789362bd6b7a001be36675db388296e9783f774563efcd9fc82"]);
    CHECK(!CSCloseFriendPasswordVerifier(@"password",salt,209999,&error));
    CHECK(!CSCloseFriendPasswordVerifier(@"password",[NSData data],210000,&error));
    CHECK(CSCloseFriendConstantTimeEqual(verifier,verifier)); CHECK(!CSCloseFriendConstantTimeEqual(verifier,key));
    CHECK(!CSCloseFriendConstantTimeEqual(verifier,CSCloseFriendPasswordVerifier(@"wrong",salt,210000,&error)));
    CHECK(![CSCloseFriendEncrypt([@"same" dataUsingEncoding:NSUTF8StringEncoding],key,&error) isEqual:CSCloseFriendEncrypt([@"same" dataUsingEncoding:NSUTF8StringEncoding],key,&error)]);
    [[NSFileManager defaultManager] removeItemAtURL:root error:NULL];
    printf("CloseFriendCoreTests: %lu checks passed\n",(unsigned long)checks);
} return 0; }
