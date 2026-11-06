#import <Foundation/Foundation.h>
#import "CSAIReplyStore.h"
#import "CSBackupMutation.h"
#import <stdatomic.h>
#import <sys/stat.h>
#import <unistd.h>
#import <errno.h>
#define CHECK(...) do { if(!(__VA_ARGS__)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while(0)
static atomic_bool blockNext,failFile,failDirectory;
static atomic_uint writes;
static dispatch_semaphore_t entered,resumeIO;
int CSAIAsyncFsync(int descriptor) {
    CHECK(!NSThread.isMainThread);
    struct stat info;CHECK(fstat(descriptor,&info)==0);
    if(S_ISREG(info.st_mode) && atomic_exchange(&blockNext,false)) {
        dispatch_semaphore_signal(entered);CHECK(dispatch_semaphore_wait(resumeIO,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC))==0);
    }
    if((S_ISREG(info.st_mode) && atomic_exchange(&failFile,false)) || (S_ISDIR(info.st_mode) && atomic_exchange(&failDirectory,false))){errno=EIO;return -1;}
    return fsync(descriptor);
}
@interface AsyncStore : CSAIReplyStore @end
@implementation AsyncStore
+ (BOOL)replaceState:(NSDictionary *)state atURL:(NSURL *)url account:(NSString *)account error:(NSError **)error {
    CHECK(!NSThread.isMainThread);atomic_fetch_add(&writes,1);return [super replaceState:state atURL:url account:account error:error];
}
@end
static void Wait(BOOL(^condition)(void)) {
    NSDate *limit=[NSDate dateWithTimeIntervalSinceNow:5];
    while(!condition() && [limit timeIntervalSinceNow]>0)[NSRunLoop.mainRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.005]];
    CHECK(condition());
}
static NSDictionary *Record(NSUInteger i) {return @{@"date":NSDate.date,@"conversation":@"friend",@"preset":@"default",@"result":@"submitted",@"detail":[NSString stringWithFormat:@"已提交 %lu",(unsigned long)i]};}
static AsyncStore *Open(NSURL *url) {
    AsyncStore *store=[[AsyncStore alloc]initWithURL:url account:@"alice"];__block BOOL done=NO;
    [store loadWithCompletion:^(BOOL ok,NSError *error){CHECK(NSThread.isMainThread && ok && !error);done=YES;}];Wait(^BOOL{return done;});return store;
}
int main(void){@autoreleasepool{
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    NSURL *url=[root URLByAppendingPathComponent:@"state.plist"];AsyncStore *store=Open(url);
    entered=dispatch_semaphore_create(0);resumeIO=dispatch_semaphore_create(0);
    NSDictionary *base=store.configuration;__block BOOL done=NO;
    atomic_store(&blockNext,true);NSMutableString *identity=[@"first" mutableCopy];
    [store claimMessageIDs:@[identity] completion:^(BOOL ok,NSError *error){CHECK(NSThread.isMainThread && ok && !error);CHECK([store hasHandledMessageID:@"first"]);done=YES;}];[identity setString:@"mutated"];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
    CHECK(CSBackupResourceWriteInProgress());CHECK(!done && store.ready && ![store hasHandledMessageID:@"first"]);
    NSTimeInterval start=NSDate.timeIntervalSinceReferenceDate;for(NSUInteger i=0;i<1000;i++){CHECK(store.configuration==base);CHECK(store.history.count==0);}
    CHECK(NSDate.timeIntervalSinceReferenceDate-start<.1);
    __block BOOL mainTurn=NO;dispatch_async(dispatch_get_main_queue(),^{mainTurn=YES;});Wait(^BOOL{return mainTurn;});CHECK(!done);
    dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return done;});CHECK(!CSBackupResourceWriteInProgress());CHECK(![store hasHandledMessageID:@"mutated"]);

    // A history-only append is acknowledged without another fsync, then a claim flushes it.
    unsigned before=atomic_load(&writes);done=NO;
    [store appendHistory:Record(0) completion:^(BOOL ok,NSError *error){CHECK(ok && !error);done=YES;}];Wait(^BOOL{return done;});
    CHECK(store.history.count==1 && atomic_load(&writes)==before);
    NSDictionary *disk=[CSAIReplyStore readStateAtURL:url account:@"alice" error:NULL];CHECK([disk[@"history"] count]==0);
    done=NO;[store claimMessageIDs:@[@"second"] completion:^(BOOL ok,NSError *error){CHECK(ok && !error);done=YES;}];Wait(^BOOL{return done;});
    disk=[CSAIReplyStore readStateAtURL:url account:@"alice" error:NULL];CHECK([disk[@"history"] count]==1 && disk[@"handled"][@"second"]);CHECK(atomic_load(&writes)==before+1);

    // Ten history appends share one durable write; otherwise the first append's 1s timer flushes.
    before=atomic_load(&writes);__block NSUInteger completions=0;
    for(NSUInteger i=0;i<10;i++)[store appendHistory:Record(i+1) completion:^(BOOL ok,NSError *error){CHECK(ok && !error);completions++;}];
    Wait(^BOOL{return completions==10;});CHECK(atomic_load(&writes)==before+1 && store.history.count==11);
    before=atomic_load(&writes);done=NO;[store appendHistory:Record(11) completion:^(BOOL ok,NSError *error){CHECK(ok && !error);done=YES;}];Wait(^BOOL{return done;});CHECK(atomic_load(&writes)==before);
    Wait(^BOOL{return atomic_load(&writes)==before+1 && !CSBackupResourceWriteInProgress();});
    disk=[CSAIReplyStore readStateAtURL:url account:@"alice" error:NULL];CHECK([disk[@"history"] count]==12);

    // All instances on this path merge deltas into the same newest state. Stale config is rejected.
    AsyncStore *other=Open(url);base=store.configuration;NSMutableDictionary *a=[base mutableCopy],*b=[base mutableCopy];a[@"model"]=@"new-model";b[@"model"]=@"stale-model";
    completions=0;[store saveConfiguration:a expectedConfiguration:base completion:^(BOOL ok,NSError *error){CHECK(ok && !error);completions++;}];
    [other saveConfiguration:b expectedConfiguration:base completion:^(BOOL ok,NSError *error){CHECK(!ok && error);completions++;}];
    [other claimMessageIDs:@[@"third"] completion:^(BOOL ok,NSError *error){CHECK(ok && !error);completions++;}];Wait(^BOOL{return completions==3;});
    CHECK([store.configuration[@"model"] isEqual:@"new-model"] && [other hasHandledMessageID:@"third"]);
    disk=[CSAIReplyStore readStateAtURL:url account:@"alice" error:NULL];CHECK([disk[@"configuration"][@"model"] isEqual:@"new-model"] && disk[@"handled"][@"first"] && disk[@"handled"][@"third"] && [disk[@"history"] count]==12);

    // Account invalidation revokes a queued claim and a late success; the next load follows in-flight IO.
    atomic_store(&blockNext,true);completions=0;
    [store claimMessageIDs:@[@"in-flight"] completion:^(BOOL ok,NSError *error){CHECK(!ok && error && [error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue]);completions++;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
    [store claimMessageIDs:@[@"cancelled-before-io"] completion:^(BOOL ok,NSError *error){CHECK(!ok && error);completions++;}];[store invalidate];CHECK(!store.ready);
    AsyncStore *next=[[AsyncStore alloc]initWithURL:url account:@"alice"];
    [next loadWithCompletion:^(BOOL ok,NSError *error){CHECK(ok && !error);CHECK([next hasHandledMessageID:@"in-flight"] && ![next hasHandledMessageID:@"cancelled-before-io"]);completions++;}];
    dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return completions==3;});store=next;

    // Failed directory fsync reports an uncertain replacement and closes the gate; reload recovers it.
    atomic_store(&failDirectory,true);done=NO;
    [store claimMessageIDs:@[@"uncertain"] completion:^(BOOL ok,NSError *error){CHECK(!ok && [error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue]);CHECK(!store.ready && ![store hasHandledMessageID:@"uncertain"]);done=YES;}];Wait(^BOOL{return done;});
    store=Open(url);CHECK([store hasHandledMessageID:@"uncertain"]);
    atomic_store(&failFile,true);done=NO;
    [store claimMessageIDs:@[@"failed-before-rename"] completion:^(BOOL ok,NSError *error){CHECK(!ok && error && ![error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue]);CHECK(!store.ready);done=YES;}];Wait(^BOOL{return done;});
    store=Open(url);CHECK(![store hasHandledMessageID:@"failed-before-rename"]);
    done=NO;[store flushHistoryWithCompletion:^(BOOL ok,NSError *error){CHECK(ok && !error);done=YES;}];Wait(^BOOL{return done;});

    // Accepted aliases finish on the original path before a new account store can load it.
    atomic_store(&blockNext,true);completions=0;
    [store claimMessageIDs:@[@"alias-order-blocker"] completion:^(BOOL ok,NSError *error){CHECK(!ok && error.code==20);completions++;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
    NSMutableString *alias=[@"alias-after-switch" mutableCopy];
    [store claimMessageAliases:@[alias,@"first"] completion:^(BOOL ok,NSError *error){CHECK(!ok && error.code==20 && [error.userInfo[CSAIReplyStoreCommitUncertainKey] boolValue]);completions++;}];
    [alias setString:@"mutated-alias"];[store invalidate];
    next=[[AsyncStore alloc]initWithURL:url account:@"alice"];
    [next loadWithCompletion:^(BOOL ok,NSError *error){CHECK(ok && !error && [next hasHandledMessageID:@"alias-after-switch"] && ![next hasHandledMessageID:@"mutated-alias"]);completions++;}];
    dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return completions==3;});store=next;
    disk=[CSAIReplyStore readStateAtURL:url account:@"alice" error:NULL];CHECK(disk[@"handled"][@"alias-after-switch"]);

    // A burst behind blocked I/O coalesces into one alias commit, including repeated IDs.
    before=atomic_load(&writes);atomic_store(&blockNext,true);completions=0;
    [store claimMessageIDs:@[@"alias-batch-blocker"] completion:^(BOOL ok,NSError *error){CHECK(ok && !error);completions++;}];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,3*NSEC_PER_SEC))==0);
    for(NSUInteger i=0;i<40;i++){
        NSString *key=[NSString stringWithFormat:@"burst-alias-%lu",(unsigned long)i];
        [store claimMessageAliases:@[key,key,@"first"] completion:^(BOOL ok,NSError *error){CHECK(ok && !error);completions++;}];
    }
    CHECK(store.ready);dispatch_semaphore_signal(resumeIO);Wait(^BOOL{return completions==41;});
    CHECK(atomic_load(&writes)==before+2);
    disk=[CSAIReplyStore readStateAtURL:url account:@"alice" error:NULL];
    for(NSUInteger i=0;i<40;i++)CHECK(disk[@"handled"][[NSString stringWithFormat:@"burst-alias-%lu",(unsigned long)i]]);
    [[NSFileManager defaultManager]removeItemAtURL:root error:NULL];
    puts("AIReplyStoreAsyncTests passed: nonblocking snapshots, durable claims/aliases, immutable inputs, shared state/CAS, history batching/timer, account invalidation and fsync uncertainty");
}return 0;}
