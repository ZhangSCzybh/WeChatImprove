#import <Foundation/Foundation.h>
#import "CSBackupStore.h"
#import "CSBackupCodec.h"
static NSUInteger checks;
static void Check(BOOL ok, NSString *message) { checks++; if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);} }
static NSDictionary *Snapshot(NSString *kind, NSUInteger t) {
    return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"fixture",@"createdAt":[NSDate dateWithTimeIntervalSince1970:t],@"kind":kind,@"source":@{@"account":@"audit",@"installationID":@"audit",@"pluginVersion":@"test"},@"fields":@[],@"assets":@{},@"warnings":@[]};
}
int main(void) { @autoreleasepool {
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:root];NSError *error=nil;
    NSDictionary *favorite=Snapshot(@"automatic",1);
    Check([store publish:favorite error:&error],@"publish target");
    Check([store setMetadata:@{@"favorite":@YES} identifier:favorite[@"id"] error:&error],@"favorite target");
    for(NSUInteger n=0;n<25;n++)Check([store publish:Snapshot(@"automatic",100+n) error:&error],@"publish newer automatic");
    NSURL *meta=[root URLByAppendingPathComponent:[favorite[@"id"] stringByAppendingPathExtension:@"meta"]];
    Check([[@"broken" dataUsingEncoding:NSUTF8StringEncoding]writeToURL:meta atomically:YES],@"corrupt primary metadata");
    [store prune:NULL];
    Check([store snapshot:favorite[@"id"] error:NULL]!=nil,@"favorite survives damaged metadata during retention");

    NSFileManager *fm=NSFileManager.defaultManager;
    error=nil;NSDictionary *recovered=[store metadata:favorite[@"id"] error:&error];
    Check([recovered[@"favorite"] boolValue]&&error!=nil,@"mirror preserves favorite and reports damaged primary");
    Check([store setMetadata:recovered identifier:favorite[@"id"] error:&error],@"explicit confirmation repairs both copies");
    error=nil;Check([[store metadata:favorite[@"id"] error:&error][@"favorite"] boolValue]&&error==nil,@"repaired metadata is fully verified");
    for(NSString *fault in @[@"missing-primary",@"missing-mirror",@"missing-both",@"corrupt-both",@"oversize",@"nonregular",@"tampered",@"wrong-type",@"single-v2-copy"]){
        NSDictionary *target=Snapshot(@"automatic",2);
        Check([store publish:target error:&error],@"publish fault target");
        Check([store setMetadata:@{@"favorite":@YES} identifier:target[@"id"] error:&error],@"favorite fault target");
        NSURL *primary=[root URLByAppendingPathComponent:[target[@"id"] stringByAppendingPathExtension:@"meta"]];
        NSURL *mirror=[root URLByAppendingPathComponent:[target[@"id"] stringByAppendingPathExtension:@"meta.bak"]];
        NSData *broken=[@"broken" dataUsingEncoding:NSUTF8StringEncoding];
        if([fault isEqual:@"missing-primary"]||[fault isEqual:@"missing-both"])Check([fm removeItemAtURL:primary error:&error],@"remove primary fixture");
        if([fault isEqual:@"missing-mirror"]||[fault isEqual:@"missing-both"])Check([fm removeItemAtURL:mirror error:&error],@"remove mirror fixture");
        if([fault isEqual:@"corrupt-both"]){Check([broken writeToURL:primary atomically:YES]&&[broken writeToURL:mirror atomically:YES],@"corrupt both fixtures");}
        if([fault isEqual:@"oversize"])Check([[NSMutableData dataWithLength:16385]writeToURL:primary atomically:YES],@"oversized metadata fixture");
        if([fault isEqual:@"nonregular"]){Check([fm removeItemAtURL:primary error:&error]&&[fm createDirectoryAtURL:primary withIntermediateDirectories:NO attributes:nil error:&error],@"nonregular metadata fixture");}
        if([fault isEqual:@"tampered"]){
            NSMutableDictionary *envelope=[[NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfURL:primary] options:NSPropertyListMutableContainers format:NULL error:NULL] mutableCopy];
            envelope[@"metadata"][@"favorite"]=@NO;
            Check([envelope writeToURL:primary atomically:YES],@"alter favorite without updating integrity");
        }
        if([fault isEqual:@"wrong-type"])Check([@{@"favorite":@"yes"}writeToURL:primary atomically:YES],@"wrong metadata type fixture");
        if([fault isEqual:@"single-v2-copy"]){Check([@{@"favorite":@YES,@"name":@"existing v2"}writeToURL:primary atomically:YES]&&[fm removeItemAtURL:mirror error:&error],@"existing v2 local metadata fixture");}
        error=nil;NSDictionary *value=[store metadata:target[@"id"] error:&error];
        Check(error!=nil,@"degraded state is reported");
        if(![fault isEqual:@"missing-both"]&&![fault isEqual:@"corrupt-both"])Check([value[@"favorite"] boolValue],@"any readable favorite survives");
        [store prune:NULL];Check([store snapshot:target[@"id"] error:NULL]!=nil,@"uncertain snapshot is not pruned");
        Check([fm fileExistsAtPath:primary.path]||[fault hasPrefix:@"missing"],@"reads do not silently overwrite bad evidence");
    }
    NSDictionary *partial=Snapshot(@"automatic",3);Check([store publish:partial error:&error],@"publish interrupted-update fixture");
    NSURL *partialMirror=[root URLByAppendingPathComponent:[partial[@"id"] stringByAppendingPathExtension:@"meta.bak"]];
    NSData *uncollected=[NSData dataWithContentsOfURL:partialMirror];
    Check([store setMetadata:@{@"favorite":@YES} identifier:partial[@"id"] error:&error],@"collect before simulated cancellation");
    NSURL *partialPrimary=[root URLByAppendingPathComponent:[partial[@"id"] stringByAppendingPathExtension:@"meta"]];
    Check([uncollected writeToURL:partialPrimary atomically:YES],@"simulate interruption between cancellation writes");
    error=nil;Check([[store metadata:partial[@"id"] error:&error][@"favorite"] boolValue]&&error!=nil,@"disagreement retains collection conservatively");
    [store prune:NULL];Check([store snapshot:partial[@"id"] error:NULL]!=nil,@"interrupted cancellation cannot unprotect snapshot");
    Check([fm removeItemAtURL:partialMirror error:&error]&&[fm createDirectoryAtURL:partialMirror withIntermediateDirectories:NO attributes:nil error:&error],@"force mirror publication failure");
    error=nil;Check(![store setMetadata:@{@"favorite":@YES} identifier:partial[@"id"] error:&error]&&error!=nil,@"partial write reports failure");
    Check([[store metadata:partial[@"id"]][@"favorite"] boolValue],@"partial collection retains successfully written protection");
    Check([fm removeItemAtURL:partialMirror error:&error],@"remove failed mirror fixture");
    Check([store setMetadata:@{@"favorite":@NO} identifier:partial[@"id"] error:&error],@"explicit cancellation updates both copies");
    [store prune:NULL];Check([store snapshot:partial[@"id"] error:NULL]==nil,@"confirmed ordinary automatic can be pruned");
    Check(![fm fileExistsAtPath:partialPrimary.path]&&![fm fileExistsAtPath:partialMirror.path],@"deletion removes both protection files");
    NSData *before=[NSData dataWithContentsOfURL:meta];
    error=nil;Check(![store setMetadata:@{@"favorite":@YES,@"padding":[NSMutableData dataWithLength:16385]} identifier:favorite[@"id"] error:&error]&&error!=nil,@"unsupported or oversized metadata is rejected");
    Check([[NSData dataWithContentsOfURL:meta]isEqual:before],@"rejected metadata leaves original intact");
    NSDictionary *manual=Snapshot(@"manual",1);Check([store publish:manual error:&error],@"publish manual fixture");
    for(NSString *extension in @[@"meta",@"meta.bak"])Check([fm removeItemAtURL:[root URLByAppendingPathComponent:[manual[@"id"] stringByAppendingPathExtension:extension]] error:&error],@"remove manual protection fixtures");
    [store prune:NULL];Check([store snapshot:manual[@"id"] error:NULL]!=nil,@"manual survives even when both protection records are gone");
    NSDictionary *imported=Snapshot(@"automatic",1);Check([store importSnapshot:imported error:&error],@"publish original automatic with durable imported protection");
    error=nil;Check([store metadata:imported[@"id"] error:&error][@"importedAt"]!=nil&&error==nil,@"imported protection is complete on publication");
    Check([store importSnapshot:favorite error:&error]&&[[store metadata:favorite[@"id"]][@"favorite"]boolValue],@"reimport preserves existing collection");
    NSMutableDictionary *conflict=[imported mutableCopy];conflict[@"name"]=@"different original";
    NSData *importState=[NSData dataWithContentsOfURL:[root URLByAppendingPathComponent:[imported[@"id"]stringByAppendingPathExtension:@"meta"]]];
    Check(![store importSnapshot:conflict error:&error],@"conflicting import cannot overwrite snapshot");
    Check([[NSData dataWithContentsOfURL:[root URLByAppendingPathComponent:[imported[@"id"]stringByAppendingPathExtension:@"meta"]]]isEqual:importState],@"conflicting import leaves collection and import state unchanged");
    [store prune:NULL];Check([store snapshot:imported[@"id"] error:NULL]!=nil,@"import mark excludes automatic from retention");
    NSDictionary *hidden=Snapshot(@"manual",1);Check([store publish:hidden error:&error],@"publish invalid snapshot fixture");
    NSString *filename=[hidden[@"id"] stringByAppendingPathExtension:@"wcbak"];
    NSData *broken=[@"broken original" dataUsingEncoding:NSUTF8StringEncoding];
    Check([broken writeToURL:[root URLByAppendingPathComponent:filename] atomically:YES],@"invalidate snapshot fixture");
    NSArray *records=[store records:&error];NSDictionary *unavailable=nil;
    for(NSDictionary *record in records)if([record[@"id"]isEqual:hidden[@"id"]])unavailable=record;
    Check([unavailable[@"unavailable"] boolValue]&&[unavailable[@"issue"] length]>0,@"invalid snapshot stays listed with a reason");
    Check([[store originalData:filename error:&error]isEqual:broken],@"raw export preserves exact invalid original bytes");
    error=nil;Check([store originalData:@"../outside.wcbak" error:&error]==nil&&error!=nil,@"raw export rejects traversal");
    NSURL *link=[root URLByAppendingPathComponent:@"linked.wcbak"];
    Check([fm createSymbolicLinkAtURL:link withDestinationURL:meta error:&error],@"raw export symlink fixture");
    error=nil;Check([store originalData:link.lastPathComponent error:&error]==nil&&error!=nil,@"raw export refuses symlink");
    [store prune:NULL];Check([fm fileExistsAtPath:[root URLByAppendingPathComponent:filename].path],@"unreadable original is never cleaned");
    Check(store.cleanupStatus.length>0,@"cleanup warning is visible");
    CSBackupStore *reopened=[[CSBackupStore alloc]initWithRoot:root];Check(reopened.cleanupStatus.length>0,@"cleanup status survives store restart");
    Check([fm removeItemAtURL:root error:NULL],@"remove isolated main fixtures");
    NSURL *auditRoot=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    CSBackupStore *auditStore=[[CSBackupStore alloc]initWithRoot:auditRoot];NSMutableArray *autos=[NSMutableArray array];
    for(NSUInteger n=0;n<25;n++){NSDictionary *s=Snapshot(@"automatic",n+1);[autos addObject:s];Check([auditStore publish:s error:&error],@"publish audit fixtures");}
    NSURL *log=[auditRoot URLByAppendingPathComponent:@"cleanup.plist"];
    Check([fm createDirectoryAtURL:log withIntermediateDirectories:NO attributes:nil error:&error],@"prevent cleanup audit publication");
    error=nil;Check(![auditStore prune:&error]&&error!=nil,@"cleanup stops when audit cannot be written");
    Check([auditStore snapshots:NULL].count==25,@"audit failure prevents all deletions");
    Check([fm removeItemAtURL:log error:&error],@"repair isolated audit destination");
    Check([auditStore prune:&error]&&[auditStore snapshots:NULL].count==20,@"ordinary automatic retention still works");
    NSDictionary *report=[NSDictionary dictionaryWithContentsOfURL:log];NSUInteger deleted=0;
    for(NSDictionary *event in report[@"events"]){if([event[@"action"]isEqual:@"deleted"]){deleted++;Check([event[@"reason"]length]>0&&[event[@"metadataVerified"] boolValue],@"deletion audit includes reason and verified protection");}}
    Check(deleted==5,@"all actual deletions recorded");
    NSDictionary *bad=Snapshot(@"manual",1);Check([auditStore publish:bad error:&error],@"publish unavailable beside ordinary snapshots");
    Check([[@"broken" dataUsingEncoding:NSUTF8StringEncoding]writeToURL:[auditRoot URLByAppendingPathComponent:[bad[@"id"] stringByAppendingPathExtension:@"wcbak"]] atomically:YES],@"damage isolated snapshot");
    Check([auditStore publish:Snapshot(@"automatic",100) error:&error],@"publish another ordinary snapshot");
    [auditStore prune:NULL];NSUInteger ordinary=0;
    for(NSDictionary *record in [auditStore records:NULL])if([record[@"kind"]isEqual:@"automatic"])ordinary++;
    Check(ordinary==20,@"unavailable original does not prevent safe ordinary retention");
    Check([fm fileExistsAtPath:[auditRoot URLByAppendingPathComponent:[bad[@"id"] stringByAppendingPathExtension:@"wcbak"]].path],@"unavailable original still retained beside cleanup");
    Check([fm removeItemAtURL:auditRoot error:NULL],@"remove isolated audit fixtures");
    printf("Backup retention: %lu checks passed\n",(unsigned long)checks);
} return 0; }
