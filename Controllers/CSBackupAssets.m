#import "CSBackupAssets.h"
#import "CSBackupCodec.h"
#import "CSBackupRegistry.h"
#import <ImageIO/ImageIO.h>
#import <sys/stat.h>
#import <errno.h>
static id AssetError(NSError **error,NSString *message){if(error)*error=CSBackupFailure(message);return nil;}
static NSString *FixedName(NSString *key) {
    if([key isEqual:@"com.wechat.tweak.touch.trail.custom.image.path"])return @"touch_trail.png";
    if([key isEqual:@"com.wechat.tweak.navigation.separator.image"])return @"separator_image.png";
    return nil;
}
static NSString *OwnedName(NSDictionary *field,NSString *contact) {
    NSString *identity=[NSString stringWithFormat:@"%@/%@/%@",field[@"domain"],field[@"key"],contact?:@""];
    return [NSString stringWithFormat:@"backup_%@.png",[CSBackupCodec digest:identity]];
}
static BOOL RecordMissing(NSString *path,NSDictionary *field,NSString *contact,NSMutableArray *missing) {
    if(!missing)return NO;
    struct stat st;
    // Do not confuse permissions, malformed files or dangling symlinks with absent files.
    if(lstat(path.fileSystemRepresentation,&st)==0||errno!=ENOENT)return NO;
    NSMutableDictionary *record=[@{@"domain":field[@"domain"],@"key":field[@"key"],@"path":path} mutableCopy];
    if(contact)record[@"contact"]=contact;
    [missing addObject:record];return YES;
}
static NSString *ReadAsset(NSString *path,NSURL *root,NSMutableDictionary *assets,NSError **error) {
    NSString *base=root.path.stringByStandardizingPath,*resolvedBase=base.stringByResolvingSymlinksInPath,*p=path.stringByStandardizingPath;
    NSString *relative=nil;
    if([p hasPrefix:[base stringByAppendingString:@"/"]])relative=[p substringFromIndex:base.length+1];
    else if([p hasPrefix:[resolvedBase stringByAppendingString:@"/"]])relative=[p substringFromIndex:resolvedBase.length+1];
    if(!relative.length)return AssetError(error,@"图片路径不在插件资源目录内或包含符号链接");
    // System container aliases (such as /var and /private/var) are legitimate.
    // Resolve the trusted parent first, but still reject links inside the resource directory.
    p=[resolvedBase stringByAppendingPathComponent:relative];
    struct stat rootStat;
    if((lstat(base.fileSystemRepresentation,&rootStat)==0&&S_ISLNK(rootStat.st_mode))||![p isEqual:p.stringByResolvingSymlinksInPath])return AssetError(error,@"图片路径不在插件资源目录内或包含符号链接");
    struct stat st;if(lstat(p.fileSystemRepresentation,&st)||!S_ISREG(st.st_mode)||st.st_size<=0||st.st_size>4*1024*1024)return AssetError(error,@"图片不存在、不是普通文件或超过 4 MiB");
    NSData *data=[NSData dataWithContentsOfFile:p options:NSDataReadingMappedIfSafe error:error];
    if(![CSBackupAssets validImage:data])return AssetError(error,@"自定义图片无效或尺寸过大");
    NSString *hash=[CSBackupCodec digest:data];assets[hash]=data;
    return [@"csbackup:" stringByAppendingString:hash];
}
static NSString *Materialize(NSString *reference,NSString *name,NSDictionary *assets,NSURL *root,NSMutableDictionary *writes,NSError **error) {
    if(![reference isKindOfClass:NSString.class]||![reference hasPrefix:@"csbackup:"]||reference.length!=73)return AssetError(error,@"图片引用无效");
    NSString *hash=[reference substringFromIndex:9];NSData *data=assets[hash];
    if(![data isKindOfClass:NSData.class]||![[CSBackupCodec digest:data] isEqual:hash]||![CSBackupAssets validImage:data])return AssetError(error,@"备份缺少完整的图片资源");
    NSString *filename=name ?: [NSString stringWithFormat:@"backup_%@.png",hash];
    NSDictionary *record=@{@"present":@YES,@"data":data};
    if(writes[filename]&&![writes[filename] isEqual:record])return AssetError(error,@"多个配置引用了冲突的固定图片");
    writes[filename]=record;return [root URLByAppendingPathComponent:filename].path;
}
@implementation CSBackupAssets
+ (BOOL)validImage:(NSData *)data {
    if(![data isKindOfClass:NSData.class]||!data.length||data.length>4*1024*1024)return NO;
    CGImageSourceRef source=CGImageSourceCreateWithData((__bridge CFDataRef)data,NULL);if(!source)return NO;
    NSUInteger frames=CGImageSourceGetCount(source);NSDictionary *props=CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL));
    double w=[props[(__bridge NSString *)kCGImagePropertyPixelWidth] doubleValue],h=[props[(__bridge NSString *)kCGImagePropertyPixelHeight] doubleValue];
    BOOL valid=frames==1&&w>0&&h>0&&w*h<=16000000;
    if(valid){CGImageRef decoded=CGImageSourceCreateImageAtIndex(source,0,(__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageSourceShouldCache:@NO});valid=decoded!=NULL;if(decoded)CGImageRelease(decoded);}
    CFRelease(source);return valid;
}
+ (NSArray *)captureFields:(NSArray *)fields root:(NSURL *)root assets:(NSMutableDictionary *)assets error:(NSError **)error {
    return [self captureFields:fields root:root assets:assets missing:nil error:error];
}
+ (NSArray *)captureFields:(NSArray *)fields root:(NSURL *)root assets:(NSMutableDictionary *)assets missing:(NSMutableArray *)missing error:(NSError **)error {
    NSMutableArray *result=[NSMutableArray array];
    for(NSDictionary *field in fields) {
        NSMutableDictionary *f=[field mutableCopy];NSDictionary *entry=[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]];NSString *resource=entry[@"resource"];
        if([resource isEqual:@"file"]) {
            NSString *path=[f[@"present"] boolValue]?f[@"value"]:nil;
            NSString *fixed=FixedName(f[@"key"]);NSString *fallback=fixed?[root URLByAppendingPathComponent:fixed].path:nil;
            if(path.length) {
                // Existing readers use the fixed file when the saved sandbox path has moved.
                if(![NSFileManager.defaultManager fileExistsAtPath:path]&&fallback&&[NSFileManager.defaultManager fileExistsAtPath:fallback])path=fallback;
                NSError *readError=nil;NSString *ref=ReadAsset(path,root,assets,&readError);
                if(ref)f[@"value"]=ref;
                else if(RecordMissing(path,field,nil,missing)){f[@"present"]=@NO;[f removeObjectForKey:@"value"];}
                else return AssetError(error,[NSString stringWithFormat:@"%@：图片 %@ 无法完整读取。可在“修复当前配置”中重新选择图片后重试。",CSBackupRegistry.moduleTitles[entry[@"module"]],path.lastPathComponent]);
            } else if(fallback&&[NSFileManager.defaultManager fileExistsAtPath:fallback]) {
                NSString *ref=ReadAsset(fallback,root,assets,error);if(!ref)return nil;f[@"fallbackAsset"]=ref;
            }
        } else if([resource isEqual:@"contacts"]&&[f[@"present"] boolValue]) {
            NSMutableDictionary *contacts=[f[@"value"] mutableCopy];
            for(NSString *contact in [contacts.allKeys sortedArrayUsingSelector:@selector(compare:)]) {
                NSMutableDictionary *config=[contacts[contact] mutableCopy];NSString *path=config[@"separatorImagePath"];
                if(path.length) {
                    NSError *readError=nil;NSString *ref=ReadAsset(path,root,assets,&readError);
                    if(ref)config[@"separatorImagePath"]=ref;
                    else if(RecordMissing(path,field,contact,missing))[config removeObjectForKey:@"separatorImagePath"];
                    else return AssetError(error,[NSString stringWithFormat:@"联系人 %@ 的分隔图片无法读取，可在“修复当前配置”中重新选择或清除图片。",contact]);
                }
                contacts[contact]=config;
            }
            f[@"value"]=contacts;
        }
        [result addObject:f];
    }
    return result;
}
+ (NSArray *)materializeFields:(NSArray *)fields assets:(NSDictionary *)assets root:(NSURL *)root writes:(NSMutableDictionary *)writes error:(NSError **)error {
    NSMutableArray *result=[NSMutableArray array];
    for(NSDictionary *field in fields) {
        NSMutableDictionary *f=[field mutableCopy];NSDictionary *entry=[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]];NSString *resource=entry[@"resource"];
        if([resource isEqual:@"file"]) {
            NSString *ref=[f[@"present"] boolValue]?f[@"value"]:nil,*fixed=FixedName(f[@"key"]);
            if(ref.length) { NSString *path=Materialize(ref,fixed?:OwnedName(f,nil),assets,root,writes,error);if(!path)return nil;f[@"value"]=path; }
            else if(f[@"fallbackAsset"]) { if(!fixed||!Materialize(f[@"fallbackAsset"],fixed,assets,root,writes,error))return nil; }
            else if(fixed)writes[fixed]=@{@"present":@NO};
        } else if([resource isEqual:@"contacts"]&&[f[@"present"] boolValue]) {
            NSMutableDictionary *contacts=[f[@"value"] mutableCopy];
            for(NSString *contact in contacts.allKeys) {
                NSMutableDictionary *config=[contacts[contact] mutableCopy];NSString *ref=config[@"separatorImagePath"];
                if(ref.length) { NSString *path=Materialize(ref,OwnedName(f,contact),assets,root,writes,error);if(!path)return nil;config[@"separatorImagePath"]=path; }
                contacts[contact]=config;
            }
            f[@"value"]=contacts;
        } else if(f[@"fallbackAsset"])return AssetError(error,@"非图片配置包含非法资源引用");
        [f removeObjectForKey:@"fallbackAsset"];[result addObject:f];
    }
    return result;
}
@end
