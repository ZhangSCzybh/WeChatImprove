#import "CSBackupLegacyReader.h"
#import "CSBackupRegistry.h"
#import "CSBackupCodec.h"
#import "CSBackupAssets.h"
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <math.h>

static id LegacyError(NSError **error,NSString *message) { if(error)*error=CSBackupFailure(message);return nil; }
static BOOL Text(id value,NSUInteger limit) { return [value isKindOfClass:NSString.class] && [value length]<=limit; }
static BOOL CSLegacyComponent(id value) {
    return Text(value,255) && [value length] && ![value isEqual:@"."] && ![value isEqual:@".."] &&
        [value rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"/\\\0"]].location==NSNotFound;
}
static BOOL Bounded(id value,NSUInteger depth,NSUInteger *nodes) {
    if(depth>32 || ++*nodes>60000)return NO;
    if([value isKindOfClass:NSString.class])return [value length]<=6*1024*1024;
    if([value isKindOfClass:NSData.class])return [value length]<=4*1024*1024;
    if([value isKindOfClass:NSDate.class])return isfinite([value timeIntervalSince1970]);
    if([value isKindOfClass:NSNumber.class])return isfinite([value doubleValue]);
    if(value==NSNull.null)return YES;
    if([value isKindOfClass:NSArray.class]) { if([value count]>10000)return NO;for(id item in value)if(!Bounded(item,depth+1,nodes))return NO;return YES; }
    if([value isKindOfClass:NSDictionary.class]) { if([value count]>10000)return NO;for(id key in value)if(!Text(key,2048)||!Bounded(value[key],depth+1,nodes))return NO;return YES; }
    return NO;
}
static BOOL SafeURL(NSURL *url,NSError **error) {
    if(![url isKindOfClass:NSURL.class] || !url.isFileURL || !url.path.length) { LegacyError(error,@"旧备份必须是本地文件或目录");return NO; }
    NSString *path=url.path;
    // Never follow a link in an imported file/directory path, including its ancestors.
    NSString *cursor=@"/";
    for(NSString *part in path.pathComponents) {
        if([part isEqual:@"/"])continue;
        cursor=[cursor stringByAppendingPathComponent:part];struct stat st;
        if(lstat(cursor.fileSystemRepresentation,&st)) { LegacyError(error,@"旧备份路径不存在");return NO; }
        if(S_ISLNK(st.st_mode)) {
            // Foundation's standard container/temp URLs may use Apple's root-owned /var or /tmp aliases.
            // These fixed OS aliases do not authorize links supplied inside a backup or its parent.
            NSString *systemTarget=[@{@"/var":@"private/var",@"/tmp":@"private/tmp"} objectForKey:cursor];
            char link[1024];ssize_t size=readlink(cursor.fileSystemRepresentation,link,sizeof(link));
            NSString *destination=size>0 ? [[NSString alloc] initWithBytes:link length:(NSUInteger)size encoding:NSUTF8StringEncoding] : nil;
            if(!systemTarget || st.st_uid!=0 || ![destination isEqual:systemTarget]) { LegacyError(error,@"旧备份路径包含符号链接");return NO; }
        }
    }
    return YES;
}
static NSData *ReadFile(NSURL *url,NSUInteger limit,NSUInteger *total,NSError **error) {
    if(!SafeURL(url,error))return nil;
    NSString *path=url.path;
    if([path hasPrefix:@"/var/"] || [path hasPrefix:@"/tmp/"])path=[@"/private" stringByAppendingString:path];
    // Anchor each component with openat. A directory swapped to a symlink after SafeURL
    // cannot redirect a preference/index/resource read outside the inspected tree.
    int parent=open("/",O_RDONLY|O_DIRECTORY|O_NOFOLLOW),fd=-1;
    NSArray *parts=path.pathComponents;
    for(NSUInteger i=1;parent>=0 && i<parts.count;i++) {
        NSString *part=parts[i];
        if([part isEqual:@"."] || [part isEqual:@".."]) { close(parent);parent=-1;break; }
        BOOL last=i==parts.count-1;
        int next=openat(parent,part.fileSystemRepresentation,O_RDONLY|O_NOFOLLOW|O_NONBLOCK|(last?0:O_DIRECTORY));
        close(parent);parent=-1;
        if(last)fd=next;else parent=next;
    }
    if(parent>=0)close(parent);
    if(fd<0)return LegacyError(error,@"无法打开旧备份文件");
    struct stat st;
    if(fstat(fd,&st) || !S_ISREG(st.st_mode) || st.st_size<0 || (uint64_t)st.st_size>limit || (total && *total+(uint64_t)st.st_size>CSBackupMaximumFileSize)) {
        close(fd);return LegacyError(error,@"旧备份不是普通文件或超过读取限制");
    }
    NSMutableData *data=[NSMutableData dataWithLength:(NSUInteger)st.st_size];NSUInteger offset=0;
    while(offset<data.length) {
        ssize_t n=read(fd,(char *)data.mutableBytes+offset,data.length-offset);
        if(n<0 && errno==EINTR)continue;
        if(n<=0) { close(fd);return LegacyError(error,@"旧备份读取不完整"); }
        offset+=(NSUInteger)n;
    }
    char extra;ssize_t tail=read(fd,&extra,1);struct stat finalStat;
    BOOL stable=tail==0 && fstat(fd,&finalStat)==0 && finalStat.st_size==st.st_size && finalStat.st_mtime==st.st_mtime;
    close(fd);
    if(!stable)return LegacyError(error,@"读取期间旧备份已改变，请重试");
    if(total)*total+=data.length;
    return data;
}
static NSString *DomainAlias(NSString *name,NSString *standard) {
    if([name isEqual:standard] || [name isEqual:@"com.tencent.xin"])return @"standard";
    if([name isEqual:@"com.cyansmoke.wechattweak"])return @"legacy";
    if([name isEqual:@"com.wechat.enhance"])return @"layout";
    return nil;
}
static NSDictionary *Metadata(id value,NSError **error) {
    if(![value isKindOfClass:NSDictionary.class])return LegacyError(error,@"旧备份缺少原始元数据");
    NSDictionary *info=value;id timestamp=info[@"createTime"];
    if(!Text(info[@"backupId"],64) || ![[NSUUID alloc] initWithUUIDString:info[@"backupId"]] || !Text(info[@"backupName"],128) || ![info[@"backupName"] length] || ![timestamp isKindOfClass:NSNumber.class] || !isfinite([timestamp doubleValue]))return LegacyError(error,@"旧备份的原始标识、名称或创建时间无效");
    return info;
}
static BOOL ResourceBudget(NSMutableDictionary *resources,NSUInteger *total,NSString *path,NSData *data,NSError **error) {
    if(resources.count>=256 || !data.length || data.length>4*1024*1024 || *total+data.length>24*1024*1024) { LegacyError(error,@"旧备份图片数量或大小超过限制");return NO; }
    resources[path]=data;*total+=data.length;return YES;
}
static BOOL JSONResources(NSDictionary *tree,NSString *prefix,NSUInteger depth,NSMutableDictionary *resources,NSUInteger *total,NSError **error) {
    if(depth>16 || tree.count>256) { LegacyError(error,@"旧资源目录层级或数量超过限制");return NO; }
    for(id name in [[tree allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        if(!CSLegacyComponent(name)) { LegacyError(error,@"旧资源目录包含非法路径");return NO; }
        NSString *relative=prefix.length?[prefix stringByAppendingPathComponent:name]:name;id item=tree[name];
        if([item isKindOfClass:NSDictionary.class]) { if(!JSONResources(item,relative,depth+1,resources,total,error))return NO; }
        else {
            if(!Text(item,6*1024*1024)) { LegacyError(error,@"旧图片资源不是 base64 文本");return NO; }
            NSData *data=[[NSData alloc] initWithBase64EncodedString:item options:0];
            if(!data) { LegacyError(error,@"旧图片资源的 base64 无效");return NO; }
            if(!ResourceBudget(resources,total,relative,data,error))return NO;
        }
    }
    return YES;
}
static BOOL DirectoryResources(NSURL *url,NSString *prefix,NSUInteger depth,NSMutableDictionary *resources,NSUInteger *resourceTotal,NSUInteger *readTotal,NSError **error) {
    if(depth>16) { LegacyError(error,@"旧资源目录层级超过限制");return NO; }
    if(!SafeURL(url,error))return NO;
    NSArray *children=[NSFileManager.defaultManager contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:0 error:error];
    if(!children)return NO;
    if(children.count>256) { LegacyError(error,@"旧资源目录数量超过限制");return NO; }
    for(NSURL *child in [children sortedArrayUsingComparator:^NSComparisonResult(NSURL *a,NSURL *b){return [a.lastPathComponent compare:b.lastPathComponent];}]) {
        NSString *name=child.lastPathComponent;if(!CSLegacyComponent(name)) { LegacyError(error,@"旧资源文件名无效");return NO; }
        struct stat st;if(lstat(child.path.fileSystemRepresentation,&st) || S_ISLNK(st.st_mode)) { LegacyError(error,@"旧资源目录包含不可读文件或符号链接");return NO; }
        NSString *relative=prefix.length?[prefix stringByAppendingPathComponent:name]:name;
        if(S_ISDIR(st.st_mode)) { if(!DirectoryResources(child,relative,depth+1,resources,resourceTotal,readTotal,error))return NO; }
        else {
            NSData *data=ReadFile(child,4*1024*1024,readTotal,error);if(!data || !ResourceBudget(resources,resourceTotal,relative,data,error))return NO;
        }
    }
    return YES;
}
static NSString *FixedName(NSString *key) {
    if([key isEqual:@"com.wechat.tweak.navigation.separator.image"])return @"separator_image.png";
    if([key isEqual:@"com.wechat.tweak.touch.trail.custom.image.path"])return @"touch_trail.png";
    NSString *prefix=@"com.wechat.enhance.tabbar_style.icon.";
    if([key hasPrefix:prefix]) {
        NSString *suffix=[key substringFromIndex:prefix.length];BOOL selected=[suffix hasPrefix:@"selected."];
        if(selected)suffix=[suffix substringFromIndex:9];
        return [NSString stringWithFormat:@"tabbar_icon_%@%@.png",suffix,selected?@"_selected":@""];
    }
    return nil;
}
static NSString *ResourceReference(NSString *oldPath,NSString *fixed,NSDictionary *resources,NSMutableDictionary *assets,NSMutableSet *used,NSError **error) {
    if(!Text(oldPath,4096))return LegacyError(error,@"旧图片路径类型或长度无效");
    if([oldPath containsString:@"\\"] || [oldPath rangeOfCharacterFromSet:[NSCharacterSet characterSetWithRange:NSMakeRange(0,1)]].location!=NSNotFound || [oldPath hasPrefix:@"csbackup:"])return LegacyError(error,@"旧图片路径格式无效");
    for(NSString *part in oldPath.pathComponents)if([part isEqual:@".."] || [part isEqual:@"."])return LegacyError(error,@"旧图片路径包含目录逃逸");
    NSString *basename=oldPath.lastPathComponent,*match=nil;
    // Only match bundled bytes. Never open oldPath from untrusted metadata.
    for(NSString *path in resources)if([path.lastPathComponent isEqual:basename] && basename.length) {
        if(match)return LegacyError(error,@"旧图片 basename 存在歧义");match=path;
    }
    if(!match && fixed && resources[fixed])match=fixed;
    if(!match)return LegacyError(error,@"旧备份缺少被引用的图片，未生成不完整快照");
    NSData *data=resources[match];
    if(![CSBackupAssets validImage:data])return LegacyError(error,@"旧备份图片无效或尺寸过大");
    NSString *hash=[CSBackupCodec digest:data];assets[hash]=data;[used addObject:match];
    return [@"csbackup:" stringByAppendingString:hash];
}
static NSArray *RewriteResources(NSArray *fields,NSDictionary *resources,NSMutableDictionary *assets,NSMutableSet *used,NSError **error) {
    NSMutableArray *result=[NSMutableArray new];
    for(NSDictionary *field in fields) {
        NSMutableDictionary *f=[field mutableCopy];NSDictionary *entry=[CSBackupRegistry entryForDomain:f[@"domain"] key:f[@"key"]];NSString *resource=entry[@"resource"];
        if([resource isEqual:@"file"]) {
            NSString *path=f[@"value"],*fixed=FixedName(f[@"key"]);
            if(path.length) { NSString *ref=ResourceReference(path,fixed,resources,assets,used,error);if(!ref)return nil;f[@"value"]=ref; }
            else if(fixed && resources[fixed]) { NSString *ref=ResourceReference(@"",fixed,resources,assets,used,error);if(!ref)return nil;f[@"fallbackAsset"]=ref; }
        } else if([resource isEqual:@"contacts"]) {
            NSMutableDictionary *contacts=[f[@"value"] mutableCopy];
            for(NSString *contact in contacts.allKeys) {
                NSMutableDictionary *config=[contacts[contact] mutableCopy];NSString *path=config[@"separatorImagePath"];
                if(path.length) { NSString *ref=ResourceReference(path,nil,resources,assets,used,error);if(!ref)return nil;config[@"separatorImagePath"]=ref; }
                contacts[contact]=config;
            }
            f[@"value"]=contacts;
        }
        [result addObject:f];
    }
    return result;
}
static NSArray *ExtractFields(NSDictionary *domains,BOOL json,NSString *standard,NSMutableArray *warnings,NSError **error) {
    NSMutableDictionary *byIdentity=[NSMutableDictionary new];NSUInteger filteredKeys=0,filteredDomains=0;
    for(NSString *domainName in [[domains allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        if([domainName isEqual:@"WeChatImprove"])continue;
        NSString *alias=DomainAlias(domainName,standard);id raw=domains[domainName];
        if(!alias) { filteredDomains++;continue; }
        if(![raw isKindOfClass:NSDictionary.class])return LegacyError(error,@"旧备份的已知偏好域不是字典");
        NSDictionary *values=raw;
        for(NSString *key in [[values allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
            NSDictionary *entry=[CSBackupRegistry entryForDomain:alias key:key];
            if(!entry) { filteredKeys++;continue; }
            id value=values[key];
            if(json && [value isKindOfClass:NSDictionary.class] && value[@"__type__"]) {
                NSString *type=value[@"__type__"];
                if([type isEqual:@"unknown"]) { [warnings addObject:[NSString stringWithFormat:@"模块 %@ 不完整：旧导出已丢失 %@/%@，其描述文本无法还原。",entry[@"module"],alias,key]];continue; }
                if(![type isEqual:@"data"] || !Text(value[@"value"],2*1024*1024))return LegacyError(error,@"旧备份的数据类型标记无效");
                value=[[NSData alloc] initWithBase64EncodedString:value[@"value"] options:0];
                if(!value)return LegacyError(error,@"旧备份的数据 base64 无效");
            }
            if(![CSBackupRegistry validateValue:value entry:entry error:error])return nil;
            NSString *identity=[NSString stringWithFormat:@"%@/%@",alias,key];
            NSDictionary *field=@{@"domain":alias,@"key":key,@"present":@YES,@"value":value};
            if(byIdentity[identity] && ![byIdentity[identity] isEqual:field])return LegacyError(error,@"旧备份包含冲突的宿主偏好域");
            byIdentity[identity]=field;
        }
    }
    if(filteredKeys || filteredDomains)[warnings addObject:[NSString stringWithFormat:@"已过滤 %lu 个宿主、支付或未登记字段及 %lu 个未登记域；这些内容不会被恢复。",(unsigned long)filteredKeys,(unsigned long)filteredDomains]];
    if(byIdentity.count>4096)return LegacyError(error,@"旧备份配置字段超过限制");
    NSMutableArray *fields=[NSMutableArray new];for(NSString *identity in [[byIdentity allKeys] sortedArrayUsingSelector:@selector(compare:)])[fields addObject:byIdentity[identity]];
    return fields;
}

@implementation CSBackupLegacyReader
+ (NSDictionary *)readURL:(NSURL *)url standardDomain:(NSString *)domain error:(NSError **)error {
    if(error)*error=nil;
    if(!CSLegacyComponent(domain) || [domain isEqual:@"com.cyansmoke.wechattweak"] || [domain isEqual:@"com.wechat.enhance"])return LegacyError(error,@"宿主偏好域标识无效");
    if(!SafeURL(url,error))return nil;
    struct stat rootStat;if(lstat(url.path.fileSystemRepresentation,&rootStat))return LegacyError(error,@"无法读取旧备份");
    NSMutableDictionary *domains=[NSMutableDictionary new],*resources=[NSMutableDictionary new];NSDictionary *info=nil;
    NSUInteger readTotal=0,resourceTotal=0;BOOL json=!S_ISDIR(rootStat.st_mode);
    if(json) {
        if(![@[@"wechatbackup",@"wcbak"] containsObject:url.pathExtension.lowercaseString])return LegacyError(error,@"不支持此旧备份扩展名");
        NSData *data=ReadFile(url,CSBackupMaximumFileSize,&readTotal,error);if(!data)return nil;
        if(data.length>=8 && !memcmp(data.bytes,"bplist00",8))return nil; // The manager tries the v2 codec first.
        id root=[NSJSONSerialization JSONObjectWithData:data options:0 error:error];NSUInteger nodes=0;
        if(![root isKindOfClass:NSDictionary.class] || !Bounded(root,0,&nodes))return LegacyError(error,@"旧 JSON 备份结构或大小无效");
        if(![root[@"version"] isEqual:@"1.0"])return LegacyError(error,@"不支持此旧 JSON 备份版本");
        info=Metadata(root[@"backupInfo"],error);if(!info)return nil;
        if(![root[@"settings"] isKindOfClass:NSDictionary.class] || ![root[@"settings"] count])return LegacyError(error,@"旧备份缺少有效 settings");
        [domains addEntriesFromDictionary:root[@"settings"]];
        id tree=domains[@"WeChatImprove"];
        if(tree && (![tree isKindOfClass:NSDictionary.class] || !JSONResources(tree,@"",0,resources,&resourceTotal,error)))return LegacyError(error,@"旧备份资源目录无效");
    } else {
        if(![[NSUUID alloc] initWithUUIDString:url.lastPathComponent])return LegacyError(error,@"旧本地备份目录必须以原始 UUID 命名");
        NSURL *indexURL=[url.URLByDeletingLastPathComponent URLByAppendingPathComponent:@"backup_info.json"];
        NSData *indexData=ReadFile(indexURL,4*1024*1024,&readTotal,error);if(!indexData)return nil;
        id index=[NSJSONSerialization JSONObjectWithData:indexData options:0 error:error];NSUInteger nodes=0;
        if(![index isKindOfClass:NSArray.class] || !Bounded(index,0,&nodes))return LegacyError(error,@"旧本地备份索引无效");
        for(id record in index)if([record isKindOfClass:NSDictionary.class] && [record[@"backupId"] isEqual:url.lastPathComponent]) {
            if(info)return LegacyError(error,@"旧本地索引包含重复备份标识");info=Metadata(record,error);if(!info)return nil;
        }
        if(!info)return LegacyError(error,@"旧本地备份缺少原始创建时间和索引记录");
        NSArray *children=[NSFileManager.defaultManager contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:0 error:error];if(!children)return nil;
        if(children.count>512)return LegacyError(error,@"旧本地备份文件数量超过限制");
        for(NSURL *child in children) {
            NSString *name=child.lastPathComponent;struct stat st;
            if(!CSLegacyComponent(name) || lstat(child.path.fileSystemRepresentation,&st) || S_ISLNK(st.st_mode))return LegacyError(error,@"旧本地备份包含非法文件或符号链接");
            if([name isEqual:@"WeChatImprove"]) {
                if(!S_ISDIR(st.st_mode) || !DirectoryResources(child,@"",0,resources,&resourceTotal,&readTotal,error))return LegacyError(error,@"旧本地资源目录无效");
            } else if([name.pathExtension isEqual:@"plist"]) {
                NSString *domainName=name.stringByDeletingPathExtension;
                if(DomainAlias(domainName,domain)) {
                    NSData *data=ReadFile(child,CSBackupMaximumFileSize,&readTotal,error);if(!data)return nil;
                    id plist=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];NSUInteger plistNodes=0;
                    if(![plist isKindOfClass:NSDictionary.class] || !Bounded(plist,0,&plistNodes))return LegacyError(error,@"旧本地偏好文件无效");
                    domains[domainName]=plist;
                } else domains[domainName]=@{}; // Count the filtered domain without reading host data.
            }
        }
    }
    NSMutableArray *warnings=[NSMutableArray arrayWithObject:@"旧格式仅恢复明确存在的已登记字段；未记录字段保持当前值。旧备份缺少可靠的本机和账号来源证明。"];
    NSArray *fields=ExtractFields(domains,json,domain,warnings,error);if(!fields)return nil;
    if(!fields.count)return LegacyError(error,@"旧备份没有可恢复的已登记配置");
    NSMutableDictionary *assets=[NSMutableDictionary new];NSMutableSet *used=[NSMutableSet new];
    fields=RewriteResources(fields,resources,assets,used,error);if(!fields)return nil;
    if(resources.count>used.count)[warnings addObject:[NSString stringWithFormat:@"%lu 个未关联的旧资源未导入；缺失的旧偏好不会被猜测为恢复默认。",(unsigned long)(resources.count-used.count)]];
    NSDictionary *snapshot=@{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":info[@"backupId"],@"name":info[@"backupName"],@"createdAt":[NSDate dateWithTimeIntervalSince1970:[info[@"createTime"] doubleValue]],@"kind":@"imported",@"source":@{@"account":@"",@"installationID":@"",@"pluginVersion":@"legacy-1.0"},@"fields":fields,@"assets":assets,@"warnings":warnings};
    // Reuse the canonical codec boundary so every returned conversion is a valid v2 snapshot.
    NSData *encoded=[CSBackupCodec encode:snapshot error:error];if(!encoded)return nil;
    return [CSBackupCodec decode:encoded error:error];
}
@end
