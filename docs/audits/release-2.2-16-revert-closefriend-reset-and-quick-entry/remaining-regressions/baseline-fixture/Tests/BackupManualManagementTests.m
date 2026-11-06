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
    for(NSUInteger n=0;n<25;n++)Check([store publish:Snapshot(@"automatic",100+n) error:&error],@"publish historical automatic");
    NSURL *meta=[root URLByAppendingPathComponent:[favorite[@"id"] stringByAppendingPathExtension:@"meta"]];
    Check([[@"broken" dataUsingEncoding:NSUTF8StringEncoding]writeToURL:meta atomically:YES],@"corrupt primary metadata");
    Check([store snapshot:favorite[@"id"] error:NULL]!=nil,@"reading a damaged favorite record preserves original backup");

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
        Check([store snapshot:target[@"id"] error:NULL]!=nil,@"metadata read leaves original snapshot intact");
        Check([fm fileExistsAtPath:primary.path]||[fault hasPrefix:@"missing"],@"reads do not silently overwrite bad evidence");
    }
    NSDictionary *partial=Snapshot(@"automatic",3);Check([store publish:partial error:&error],@"publish interrupted-update fixture");
    NSURL *partialMirror=[root URLByAppendingPathComponent:[partial[@"id"] stringByAppendingPathExtension:@"meta.bak"]];
    NSData *uncollected=[NSData dataWithContentsOfURL:partialMirror];
    Check([store setMetadata:@{@"favorite":@YES} identifier:partial[@"id"] error:&error],@"collect before simulated cancellation");
    NSURL *partialPrimary=[root URLByAppendingPathComponent:[partial[@"id"] stringByAppendingPathExtension:@"meta"]];
    Check([uncollected writeToURL:partialPrimary atomically:YES],@"simulate interruption between cancellation writes");
    error=nil;Check([[store metadata:partial[@"id"] error:&error][@"favorite"] boolValue]&&error!=nil,@"disagreement retains collection conservatively");
    Check([store snapshot:partial[@"id"] error:NULL]!=nil,@"interrupted metadata update leaves snapshot intact");
    Check([fm removeItemAtURL:partialMirror error:&error]&&[fm createDirectoryAtURL:partialMirror withIntermediateDirectories:NO attributes:nil error:&error],@"force mirror publication failure");
    error=nil;Check(![store setMetadata:@{@"favorite":@YES} identifier:partial[@"id"] error:&error]&&error!=nil,@"partial write reports failure");
    Check([[store metadata:partial[@"id"]][@"favorite"] boolValue],@"partial collection retains successfully written protection");
    Check([fm removeItemAtURL:partialMirror error:&error],@"remove failed mirror fixture");
    Check([store setMetadata:@{@"favorite":@NO} identifier:partial[@"id"] error:&error],@"explicit cancellation updates both copies");
    Check([store snapshot:partial[@"id"] error:NULL]!=nil,@"cancelling favorite does not delete a historical automatic backup");
    Check([store remove:partial[@"id"] error:&error],@"explicit manual deletion removes the selected historical backup");
    Check(![fm fileExistsAtPath:partialPrimary.path]&&![fm fileExistsAtPath:partialMirror.path],@"manual deletion removes both local metadata files");
    NSData *before=[NSData dataWithContentsOfURL:meta];
    error=nil;Check(![store setMetadata:@{@"favorite":@YES,@"padding":[NSMutableData dataWithLength:16385]} identifier:favorite[@"id"] error:&error]&&error!=nil,@"unsupported or oversized metadata is rejected");
    Check([[NSData dataWithContentsOfURL:meta]isEqual:before],@"rejected metadata leaves original intact");
    NSDictionary *manual=Snapshot(@"manual",1);Check([store publish:manual error:&error],@"publish manual fixture");
    for(NSString *extension in @[@"meta",@"meta.bak"])Check([fm removeItemAtURL:[root URLByAppendingPathComponent:[manual[@"id"] stringByAppendingPathExtension:extension]] error:&error],@"remove manual metadata fixtures");
    Check([store snapshot:manual[@"id"] error:NULL]!=nil,@"manual backup remains readable when both metadata records are gone");
    NSDictionary *imported=Snapshot(@"automatic",1);Check([store importSnapshot:imported error:&error],@"import historical automatic backup with durable provenance");
    error=nil;Check([store metadata:imported[@"id"] error:&error][@"importedAt"]!=nil&&error==nil,@"import provenance is complete on publication");
    Check([store importSnapshot:favorite error:&error]&&[[store metadata:favorite[@"id"]][@"favorite"]boolValue],@"reimport preserves existing collection");
    NSMutableDictionary *conflict=[imported mutableCopy];conflict[@"name"]=@"different original";
    NSData *importState=[NSData dataWithContentsOfURL:[root URLByAppendingPathComponent:[imported[@"id"]stringByAppendingPathExtension:@"meta"]]];
    Check(![store importSnapshot:conflict error:&error],@"conflicting import cannot overwrite snapshot");
    Check([[NSData dataWithContentsOfURL:[root URLByAppendingPathComponent:[imported[@"id"]stringByAppendingPathExtension:@"meta"]]]isEqual:importState],@"conflicting import leaves collection and import state unchanged");
    Check([store snapshot:imported[@"id"] error:NULL]!=nil,@"imported historical backup remains readable");
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
    Check([fm fileExistsAtPath:[root URLByAppendingPathComponent:filename].path],@"unreadable original is never cleaned");
    CSBackupStore *reopened=[[CSBackupStore alloc]initWithRoot:root];
    Check([[reopened originalData:filename error:NULL] isEqual:broken],@"reopening store preserves exact unreadable original");
    Check([reopened snapshots:NULL].count>=25,@"listing and reopening retain every historical backup beyond old quotas");
    Check([fm removeItemAtURL:root error:NULL],@"remove isolated main fixtures");
    printf("Backup manual management: %lu checks passed\n",(unsigned long)checks);
} return 0; }
