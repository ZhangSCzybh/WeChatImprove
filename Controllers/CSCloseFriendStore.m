#import "CSCloseFriendStore.h"
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendCrypto.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CoreFoundation/CoreFoundation.h>
#import <math.h>
#import <TargetConditionals.h>
#import <sys/stat.h>
#import <fcntl.h>
#import <unistd.h>
NSString *const CSCloseFriendStoreErrorDomain=@"CSCloseFriendStore";
static const NSUInteger CSStoreLimit=4*1024*1024+72;
static BOOL CSStoreFail(NSError **error,CSCloseFriendStoreErrorCode code) { if(error)*error=[NSError errorWithDomain:CSCloseFriendStoreErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:code==CSCloseFriendStoreErrorMissing?@"No close-friend state exists for this account.":@"Close-friend state is invalid or unavailable; existing data was preserved."}]; return NO; }
static BOOL CSAccount(id value) { return [value isKindOfClass:NSString.class] && [value length]>0 && [value length]<=512 && [value rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location==NSNotFound; }
// Bounded recursive validation avoids unbounded traversal of injected object graphs and freezes mutable caller data through plist serialization.
static BOOL CSPlist(id value,NSUInteger depth,NSUInteger *budget) {
    if(depth>12 || !*budget)return NO; --*budget;
    if([value isKindOfClass:NSString.class])return [value length]<=65536;
    if([value isKindOfClass:NSData.class])return [value length]<=65536;
    if([value isKindOfClass:NSNumber.class])return isfinite([value doubleValue]);
    if([value isKindOfClass:NSDate.class])return isfinite([value timeIntervalSince1970]);
    if([value isKindOfClass:NSArray.class]) { if([value count]>20000)return NO; for(id child in value)if(!CSPlist(child,depth+1,budget))return NO; return YES; }
    if([value isKindOfClass:NSDictionary.class]) { if([value count]>20000)return NO; for(id key in value)if(![key isKindOfClass:NSString.class] || [key length]>512 || !CSPlist(value[key],depth+1,budget))return NO; return YES; }
    return NO;
}
static NSDictionary *CSState(id state,NSError **error) {
    if(![state isKindOfClass:NSDictionary.class] || [state count]>2) { CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
    for(id key in state)if(![key isEqual:@"profile"] && ![key isEqual:@"muteRecords"]) { CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
    NSDictionary *profile=CSCloseFriendNormalizeProfile(state[@"profile"],error); if(!profile)return nil;
    id records=state[@"muteRecords"]?:@{}; NSUInteger budget=100000;
    if(![records isKindOfClass:NSDictionary.class] || !CSPlist(records,0,&budget)) { CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
    NSDictionary *value=@{@"profile":profile,@"muteRecords":records};
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:value format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
    if(!data || data.length>CSStoreLimit-72) { CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
    return [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
}
@interface CSCloseFriendStore ()
@property(nonatomic,copy) CSCloseFriendKeyProvider keyProvider;
@end
@implementation CSCloseFriendStore
- (instancetype)initWithRoot:(NSURL *)root keyProvider:(CSCloseFriendKeyProvider)keyProvider { if((self=[super init])) { _root=[root copy]; _keyProvider=[keyProvider copy]; } return self; }
- (NSURL *)URLForAccount:(NSString *)account {
    NSData *data=[account dataUsingEncoding:NSUTF8StringEncoding]; uint8_t hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes,(CC_LONG)data.length,hash); NSMutableString *name=[NSMutableString stringWithString:@"state-"];
    for(NSUInteger i=0;i<sizeof(hash);i++)[name appendFormat:@"%02x",hash[i]];
    return [self.root URLByAppendingPathComponent:[name stringByAppendingString:@".bin"]];
}
- (NSData *)readURL:(NSURL *)url missing:(BOOL *)missing error:(NSError **)error {
    int fd=open(url.path.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW); if(fd<0) { if(missing)*missing=errno==ENOENT; CSStoreFail(error,errno==ENOENT?CSCloseFriendStoreErrorMissing:CSCloseFriendStoreErrorIO); return nil; }
    struct stat st; if(fstat(fd,&st) || !S_ISREG(st.st_mode) || st.st_size<0 || (uint64_t)st.st_size>CSStoreLimit) { close(fd); CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
    NSMutableData *data=[NSMutableData dataWithLength:(NSUInteger)st.st_size]; NSUInteger done=0;
    while(done<data.length) { ssize_t n=read(fd,(uint8_t *)data.mutableBytes+done,data.length-done); if(n<0 && errno==EINTR)continue; if(n<=0)break; done+=(NSUInteger)n; }
    uint8_t extra; ssize_t tail=read(fd,&extra,1); close(fd);
    if(done!=data.length || tail!=0) { CSStoreFail(error,CSCloseFriendStoreErrorIO); return nil; } return [data copy];
}
- (NSDictionary *)decode:(NSData *)data key:(NSData *)key account:(NSString *)account error:(NSError **)error {
    NSData *plain=CSCloseFriendDecrypt(data,key,error); if(!plain)return nil;
    NSPropertyListFormat format=0;
    id envelope=[NSPropertyListSerialization propertyListWithData:plain options:NSPropertyListImmutable format:&format error:NULL];
    if(format!=NSPropertyListBinaryFormat_v1_0 || ![envelope isKindOfClass:NSDictionary.class] || [envelope count]!=3 || ![envelope[@"schema"] isKindOfClass:NSNumber.class] || CFGetTypeID((__bridge CFTypeRef)envelope[@"schema"])==CFBooleanGetTypeID() || CFNumberIsFloatType((__bridge CFNumberRef)envelope[@"schema"]) || ![envelope[@"schema"] isEqual:@1] || ![envelope[@"accountID"] isEqual:account]) { CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
    return CSState(envelope[@"state"],error);
}
- (NSDictionary *)loadStateForAccountID:(NSString *)account error:(NSError **)error {
    @synchronized(CSCloseFriendStore.class) {
        if(!CSAccount(account) || !self.root.isFileURL || !self.keyProvider) { CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
        NSData *data=[self readURL:[self URLForAccount:account] missing:NULL error:error]; if(!data)return nil;
        NSError *keyError=nil; NSData *key=self.keyProvider(account,&keyError); if(!key) { if(error)*error=keyError; if(!keyError)CSStoreFail(error,CSCloseFriendStoreErrorInvalid); return nil; }
        return [self decode:data key:key account:account error:error];
    }
}
- (BOOL)writeStagedData:(NSData *)data URL:(NSURL *)url error:(NSError **)error {
    int fd=open(url.path.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600); if(fd<0)return CSStoreFail(error,CSCloseFriendStoreErrorIO);
#if TARGET_OS_IPHONE
    if(![[NSFileManager defaultManager] setAttributes:@{NSFileProtectionKey:NSFileProtectionComplete} ofItemAtPath:url.path error:error]) { close(fd); return NO; }
#endif
    NSUInteger done=0; while(done<data.length) { ssize_t n=write(fd,(const uint8_t *)data.bytes+done,data.length-done); if(n<0 && errno==EINTR)continue; if(n<=0)break; done+=(NSUInteger)n; }
    BOOL ok=done==data.length && fsync(fd)==0; if(close(fd)!=0)ok=NO;
    return ok || CSStoreFail(error,CSCloseFriendStoreErrorIO);
}
- (BOOL)saveState:(NSDictionary *)state forAccountID:(NSString *)account error:(NSError **)error {
    @synchronized(CSCloseFriendStore.class) {
        if(!CSAccount(account) || !self.root.isFileURL || !self.keyProvider)return CSStoreFail(error,CSCloseFriendStoreErrorInvalid);
        NSDictionary *valid=CSState(state,error); if(!valid)return NO;
        NSError *keyError=nil; NSData *key=self.keyProvider(account,&keyError); if(!key && keyError) { if(error)*error=keyError; return NO; } if(![key isKindOfClass:NSData.class] || key.length!=64)return CSStoreFail(error,CSCloseFriendStoreErrorInvalid);
        NSURL *destination=[self URLForAccount:account]; BOOL missing=NO; NSError *readError=nil;
        NSData *existing=[self readURL:destination missing:&missing error:&readError];
        if(existing) { if(![self decode:existing key:key account:account error:error])return NO; }
        else if(!missing) { if(error)*error=readError; return NO; }
        NSFileManager *fm=NSFileManager.defaultManager;
        if(![fm createDirectoryAtURL:self.root withIntermediateDirectories:YES attributes:@{NSFilePosixPermissions:@0700} error:error])return NO;
        struct stat rootStat; if(lstat(self.root.path.fileSystemRepresentation,&rootStat) || !S_ISDIR(rootStat.st_mode))return CSStoreFail(error,CSCloseFriendStoreErrorIO);
        if(chmod(self.root.path.fileSystemRepresentation,0700))return CSStoreFail(error,CSCloseFriendStoreErrorIO);
        NSURL *rootURL=self.root;
        if(![rootURL setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:error])return NO;
#if TARGET_OS_IPHONE
        if(![fm setAttributes:@{NSFileProtectionKey:NSFileProtectionComplete} ofItemAtPath:rootURL.path error:error])return NO;
#endif
        NSData *plain=[NSPropertyListSerialization dataWithPropertyList:@{@"schema":@1,@"accountID":account,@"state":valid} format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
        NSData *encrypted=plain?CSCloseFriendEncrypt(plain,key,error):nil; if(!encrypted)return NO;
        NSURL *stage=[self.root URLByAppendingPathComponent:[@".pending-" stringByAppendingString:NSUUID.UUID.UUIDString]];
        BOOL ok=[self writeStagedData:encrypted URL:stage error:error];
        if(ok) { NSData *readback=[self readURL:stage missing:NULL error:error]; if(!readback)ok=NO; else if(!CSCloseFriendConstantTimeEqual(readback,encrypted))ok=CSStoreFail(error,CSCloseFriendStoreErrorIO); else ok=[self decode:readback key:key account:account error:error]!=nil; }
        if(ok && rename(stage.path.fileSystemRepresentation,destination.path.fileSystemRepresentation))ok=CSStoreFail(error,CSCloseFriendStoreErrorIO);
        if(!ok) { [fm removeItemAtURL:stage error:NULL]; return NO; }
        // The file was flushed before atomic rename; flush directory metadata for crash durability.
        int dir=open(self.root.path.fileSystemRepresentation,O_RDONLY|O_DIRECTORY); if(dir>=0) { fsync(dir); close(dir); }
        return YES;
    }
}
@end
