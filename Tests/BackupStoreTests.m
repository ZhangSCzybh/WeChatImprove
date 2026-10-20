#import <Foundation/Foundation.h>
#import "CSBackupStore.h"
#import "CSBackupCodec.h"
static NSUInteger checks;
static void Check(BOOL ok,NSString *message){checks++;if(!ok){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
static NSDictionary *Snapshot(NSString *kind,NSTimeInterval t){return @{@"magic":@"WeChatImproveBackup",@"formatVersion":@2,@"id":NSUUID.UUID.UUIDString,@"name":@"test",@"createdAt":[NSDate dateWithTimeIntervalSince1970:t],@"kind":kind,@"source":@{@"account":@"alice",@"installationID":@"test",@"pluginVersion":@"test"},@"fields":@[],@"assets":@{},@"warnings":@[]};}
int main(void){@autoreleasepool{
 NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];CSBackupStore *store=[[CSBackupStore alloc]initWithRoot:root];NSError *error=nil;
 NSDictionary *manual=Snapshot(@"manual",1);Check([store publish:manual error:&error],@"publish complete snapshot");Check([store publish:manual error:&error],@"identical import is idempotent");NSMutableDictionary *changed=[manual mutableCopy];changed[@"name"]=@"changed";Check(![store publish:changed error:&error],@"immutable identifier cannot overwrite different snapshot");Check(![store snapshot:@"../other" error:&error],@"path traversal identifier rejected");
 NSMutableArray *automatic=[NSMutableArray array];for(NSUInteger n=0;n<25;n++){NSDictionary *s=Snapshot(@"automatic",100+n);[automatic addObject:s];Check([store publish:s error:&error],@"publish retention fixture");}
 Check([store setMetadata:@{@"favorite":@YES} identifier:automatic[0][@"id"] error:&error],@"favorite metadata persisted");Check([store setMetadata:@{@"importedAt":NSDate.date} identifier:automatic[2][@"id"] error:&error],@"import origin remains local metadata");
 NSDictionary *journal=@{@"state":@"prepared",@"sourceID":manual[@"id"],@"protectionID":automatic[1][@"id"]};Check([store writeJournal:journal error:&error],@"active references persisted");
 for(NSUInteger n=0;n<10;n++)Check([store publish:Snapshot(n%2?@"upgrade":@"protection",200+n) error:&error],@"publish mixed operation protections");
 error=nil;Check([store prune:&error],@"prune after complete publication");NSArray *items=[store snapshots:NULL];NSUInteger autos=0,protections=0,manuals=0;for(NSDictionary *s in items){if([s[@"kind"]isEqual:@"automatic"])autos++;else if([s[@"kind"]isEqual:@"manual"])manuals++;else protections++;}
 Check(autos==23,@"twenty ordinary autos plus favorite/imported/active are retained");Check(protections==5&&manuals==1,@"combined five operation protections and all manual backups retained");
 Check([store snapshot:automatic[0][@"id"] error:NULL]!=nil&&[store snapshot:automatic[1][@"id"] error:NULL]!=nil&&[store snapshot:automatic[2][@"id"] error:NULL]!=nil,@"favorite active imported originals survive");Check(![store remove:manual[@"id"] error:&error],@"active source cannot be deleted");
 NSURL *corrupt=[root URLByAppendingPathComponent:[NSUUID.UUID.UUIDString stringByAppendingPathExtension:@"wcbak"]];[[@"broken" dataUsingEncoding:NSUTF8StringEncoding]writeToURL:corrupt atomically:YES];error=nil;Check([store snapshots:&error].count==items.count&&error!=nil,@"list rebuild returns valid manifests and reports corrupt retained file");
 NSData *oversize=[NSMutableData dataWithLength:80*1024*1024+1];Check(![store writeJournal:@{@"large":oversize} error:&error],@"oversized journal rejected before replacement");Check([[store journal:NULL][@"state"]isEqual:@"prepared"],@"rejected journal leaves previous recovery record intact");
 Check([store archiveJournal:&error],@"completed or canceled journal evidence archived");Check([store journal:NULL]==nil,@"archival clears pending marker");
 [NSFileManager.defaultManager removeItemAtURL:root error:NULL];printf("Backup store: %lu checks passed\n",(unsigned long)checks);
}return 0;}
