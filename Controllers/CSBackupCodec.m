#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
#import "CSBackupAssets.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreFoundation/CoreFoundation.h>
#include <math.h>

const NSUInteger CSBackupMaximumFileSize=32*1024*1024;
NSError *CSBackupFailure(NSString *message) {
    return [NSError errorWithDomain:@"WeChatImprove.Backup" code:1 userInfo:@{NSLocalizedDescriptionKey:message ?: @"备份操作失败"}];
}
static BOOL Fail(NSError **error,NSString *message) { if(error)*error=CSBackupFailure(message);return NO; }
static BOOL Text(id v,NSUInteger max) { return [v isKindOfClass:NSString.class] && [v length]<=max; }
static BOOL CSIsBoolean(id v) { return [v isKindOfClass:NSNumber.class] && CFGetTypeID((__bridge CFTypeRef)v)==CFBooleanGetTypeID(); }
static BOOL Bounded(id value,NSUInteger depth,NSUInteger *nodes) {
    if(depth>32 || ++*nodes>60000)return NO;
    if([value isKindOfClass:NSString.class])return [value length]<=1024*1024;
    if([value isKindOfClass:NSData.class])return [value length]<=4*1024*1024;
    if([value isKindOfClass:NSDate.class])return isfinite([value timeIntervalSince1970]);
    if([value isKindOfClass:NSNumber.class])return isfinite([value doubleValue]);
    if([value isKindOfClass:NSArray.class]) { if([value count]>10000)return NO;for(id v in value)if(!Bounded(v,depth+1,nodes))return NO;return YES; }
    if([value isKindOfClass:NSDictionary.class]) {
        if([value count]>10000)return NO;
        for(id k in value)if(!Text(k,2048)||!Bounded(value[k],depth+1,nodes))return NO;
        return YES;
    }
    return NO;
}
static void Append(NSData *data,NSMutableData *out) {
    uint64_t n=CFSwapInt64HostToBig(data.length);[out appendBytes:&n length:sizeof(n)];[out appendData:data];
}
static void Canonical(id v,NSMutableData *out) {
    if([v isKindOfClass:NSDictionary.class]) {
        [out appendBytes:"{" length:1];for(NSString *k in [[v allKeys] sortedArrayUsingSelector:@selector(compare:)]) { Canonical(k,out);Canonical(v[k],out); }[out appendBytes:"}" length:1];
    } else if([v isKindOfClass:NSArray.class]) {
        [out appendBytes:"[" length:1];for(id item in v)Canonical(item,out);[out appendBytes:"]" length:1];
    } else if([v isKindOfClass:NSString.class]) { [out appendBytes:"s" length:1];Append([v dataUsingEncoding:NSUTF8StringEncoding],out);
    } else if([v isKindOfClass:NSData.class]) { [out appendBytes:"d" length:1];Append(v,out);
    } else if([v isKindOfClass:NSDate.class]) { [out appendBytes:"t" length:1];double d=[v timeIntervalSince1970];uint64_t bits;memcpy(&bits,&d,8);bits=CFSwapInt64HostToBig(bits);[out appendBytes:&bits length:8];
    } else if(CSIsBoolean(v)) { [out appendBytes:[v boolValue]?"T":"F" length:1];
    } else if([v isKindOfClass:NSNumber.class]) {
        // NSNumber's integer/float storage width is not semantic. Decimal text avoids
        // 64-bit integer precision loss and is stable after property-list round trips.
        [out appendBytes:"n" length:1];Append([[v descriptionWithLocale:@{NSLocaleDecimalSeparator:@"."}] dataUsingEncoding:NSUTF8StringEncoding],out);
    }
}
static BOOL Validate(NSDictionary *s,NSError **error) {
    NSUInteger nodes=0;
    if(![s isKindOfClass:NSDictionary.class]||!Bounded(s,0,&nodes))return Fail(error,@"备份结构、大小或嵌套层级无效");
    if(![s[@"magic"] isEqual:@"WeChatImproveBackup"]||![s[@"formatVersion"] isEqual:@2])return Fail(error,@"不支持此备份格式版本");
    if(!Text(s[@"id"],64)||![[NSUUID alloc] initWithUUIDString:s[@"id"]]||!Text(s[@"name"],128)||![s[@"name"] length]||![s[@"createdAt"] isKindOfClass:NSDate.class])return Fail(error,@"备份名称、标识或创建时间无效");
    if(![@[@"manual",@"automatic",@"protection",@"upgrade",@"imported"] containsObject:s[@"kind"]])return Fail(error,@"备份类型无效");
    NSDictionary *source=s[@"source"];
    if(![source isKindOfClass:NSDictionary.class]||!Text(source[@"account"],256)||!Text(source[@"installationID"],128)||!Text(source[@"pluginVersion"],64))return Fail(error,@"备份来源信息无效");
    if(source[@"accounts"]){if(![source[@"accounts"] isKindOfClass:NSArray.class]||[source[@"accounts"] count]>10000)return Fail(error,@"账号覆盖范围无效");for(id account in source[@"accounts"])if(!Text(account,128)||![account length])return Fail(error,@"账号覆盖范围无效");}
    NSArray *fields=s[@"fields"],*warnings=s[@"warnings"];
    if(![fields isKindOfClass:NSArray.class]||fields.count>4096||![warnings isKindOfClass:NSArray.class]||warnings.count>1024)return Fail(error,@"配置清单无效");
    for(id warning in warnings)if(!Text(warning,2048))return Fail(error,@"备份说明无效");
    NSMutableSet *seen=[NSMutableSet set];
    for(id object in fields) {
        if(![object isKindOfClass:NSDictionary.class])return Fail(error,@"配置记录无效");
        NSDictionary *f=object;
        for(NSString *key in f)if(![@[@"domain",@"key",@"present",@"value",@"fallbackAsset"] containsObject:key])return Fail(error,@"配置记录包含不支持的字段");
        if(!Text(f[@"domain"],32)||!Text(f[@"key"],512)||!CSIsBoolean(f[@"present"]))return Fail(error,@"配置记录缺少类型或存在性");
        NSDictionary *entry=[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]];
        if(!entry)return Fail(error,@"备份包含未登记或受保护的配置");
        NSString *identity=[NSString stringWithFormat:@"%@/%@",f[@"domain"],f[@"key"]];
        if([seen containsObject:identity])return Fail(error,@"备份中存在重复配置");[seen addObject:identity];
        if([f[@"present"] boolValue]) { if(![CSBackupRegistry validateValue:f[@"value"] entry:entry error:error])return NO; }
        else if(f[@"value"])return Fail(error,@"不存在的配置不能附带值");
    }
    NSDictionary *assets=s[@"assets"];
    if(![assets isKindOfClass:NSDictionary.class]||assets.count>256)return Fail(error,@"图片资源清单无效");
    NSUInteger total=0;
    for(id key in assets) {
        NSData *data=assets[key];
        if(!Text(key,64)||[key length]!=64||![data isKindOfClass:NSData.class]||!data.length||data.length>4*1024*1024||![[CSBackupCodec digest:data] isEqual:key]||![CSBackupAssets validImage:data])return Fail(error,@"图片资源损坏或超过限制");
        total+=data.length;if(total>24*1024*1024)return Fail(error,@"图片资源总大小超过限制");
    }
    NSMutableDictionary *writes=[NSMutableDictionary dictionary];
    if(![CSBackupAssets materializeFields:fields assets:assets root:[NSURL fileURLWithPath:@"/backup-validation"] writes:writes error:error])return NO;
    return YES;
}
@implementation CSBackupCodec
+ (NSString *)digest:(id)value {
    NSMutableData *bytes=[NSMutableData data];Canonical(value,bytes);
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];CC_SHA256(bytes.bytes,(CC_LONG)bytes.length,hash);
    NSMutableString *s=[NSMutableString string];for(NSUInteger i=0;i<sizeof(hash);i++)[s appendFormat:@"%02x",hash[i]];return s;
}
+ (NSData *)encode:(NSDictionary *)snapshot error:(NSError **)error {
    if(!Validate(snapshot,error))return nil;
    NSMutableDictionary *sealed=[snapshot mutableCopy];[sealed removeObjectForKey:@"integrity"];
    sealed[@"integrity"]=[self digest:sealed];
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:sealed format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
    if(data.length>CSBackupMaximumFileSize) { Fail(error,@"备份超过 32 MiB，未保存不完整文件");return nil; }
    return data;
}
+ (NSDictionary *)decode:(NSData *)data error:(NSError **)error {
    if(![data isKindOfClass:NSData.class]||data.length>CSBackupMaximumFileSize||data.length<8||memcmp(data.bytes,"bplist00",8)) { Fail(error,@"不是有效的 v2 备份文件");return nil; }
    id value=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
    if(!Validate(value,error))return nil;
    NSMutableDictionary *bare=[value mutableCopy];NSString *integrity=bare[@"integrity"];[bare removeObjectForKey:@"integrity"];
    if(!Text(integrity,64)||![[self digest:bare] isEqual:integrity]) { Fail(error,@"备份完整性校验失败");return nil; }
    return value;
}
@end
