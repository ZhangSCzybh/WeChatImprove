#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <stdatomic.h>
#import "CSAICredentialStore.h"
static NSUInteger checks;
#define CHECK(...) do {checks++;if(!(__VA_ARGS__)){fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__);exit(1);}}while(0)
static atomic_uint reads,mainReads;
static atomic_bool holdRead,failRead;
static dispatch_semaphore_t gate;
NSError *CSAIError(NSInteger code,NSString *message){return [NSError errorWithDomain:@"com.wechatimprove.ai-reply" code:code userInfo:@{NSLocalizedDescriptionKey:message}];}
// Linked in place of SecItemCopyMatching; no real Keychain calls or credentials.
OSStatus CSAITestCopyMatching(CFDictionaryRef query,CFTypeRef *result){
    atomic_fetch_add(&reads,1);if(NSThread.isMainThread)atomic_fetch_add(&mainReads,1);
    if(atomic_load(&holdRead))dispatch_semaphore_wait(gate,DISPATCH_TIME_FOREVER);
    NSDictionary *values=(__bridge NSDictionary *)query;
    if(![values[(__bridge id)kSecAttrService] isEqual:@"com.wechatimprove.ai-reply.v1"] || !values[(__bridge id)kSecAttrAccount])return errSecParam;
    if(atomic_exchange(&failRead,false))return errSecInteractionNotAllowed;
    *result=CFBridgingRetain([@"synthetic-key" dataUsingEncoding:NSUTF8StringEncoding]);return errSecSuccess;
}
static void Wait(BOOL (^ready)(void)){
    NSTimeInterval until=NSProcessInfo.processInfo.systemUptime+5;
    while(!ready() && NSProcessInfo.processInfo.systemUptime<until)[NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.001]];
    CHECK(ready());
}
int main(void){@autoreleasepool{
    gate=dispatch_semaphore_create(0);atomic_store(&holdRead,true);
    __block NSUInteger completed=0,cancelled=0,first=0,second=0;
    CSAICompletion success=^(NSString *key,NSError *error){CHECK(NSThread.isMainThread && !error && [key isEqual:@"synthetic-key"]);completed++;};
    CSAIReadCredentialAsync(@"alice",@"r1",^(NSString *key,NSError *error){first++;success(key,error);});
    Wait(^BOOL{return atomic_load(&reads)==1;});
    CSAIReadCredentialAsync(@"alice",@"r1",^(NSString *key,NSError *error){second++;success(key,error);});
    id<CSAICancellable> cancelledReader=CSAIReadCredentialAsync(@"alice",@"r1",^(NSString *key,NSError *error){CHECK(NSThread.isMainThread && !key && error.code==NSURLErrorCancelled);cancelled++;});
    [cancelledReader cancel];[cancelledReader cancel];CHECK(cancelled==1);
    CSAIReadCredentialAsync(@"alice",@"r2",success);CSAIReadCredentialAsync(@"bob",@"r1",success);
    __block BOOL responsive=NO;dispatch_async(dispatch_get_main_queue(),^{responsive=YES;});Wait(^BOOL{return responsive;});
    CHECK(!completed && atomic_load(&reads)==1 && !atomic_load(&mainReads));
    atomic_store(&holdRead,false);dispatch_semaphore_signal(gate);Wait(^BOOL{return completed==4;});
    CHECK(first==1 && second==1 && cancelled==1 && atomic_load(&reads)==3);
    // A completed slot is read again; plaintext is never cached for later requests.
    CSAIReadCredentialAsync(@"alice",@"r1",success);Wait(^BOOL{return completed==5;});CHECK(atomic_load(&reads)==4);
    // A blocked failing read is shared, then a subsequent request can retry.
    atomic_store(&holdRead,true);atomic_store(&failRead,true);__block NSUInteger failures=0;
    CSAICompletion fail=^(NSString *key,NSError *error){CHECK(NSThread.isMainThread && !key && error.code==30);failures++;};
    CSAIReadCredentialAsync(@"alice",@"failed",fail);Wait(^BOOL{return atomic_load(&reads)==5;});
    CSAIReadCredentialAsync(@"alice",@"failed",fail);atomic_store(&holdRead,false);dispatch_semaphore_signal(gate);
    Wait(^BOOL{return failures==2;});CHECK(atomic_load(&reads)==5);
    CSAIReadCredentialAsync(@"alice",@"failed",success);Wait(^BOOL{return completed==6;});CHECK(atomic_load(&reads)==6);
    // Invalid revisions complete asynchronously and never reach the backend.
    CSAIReadCredentialAsync(@"alice",@"",fail);CHECK(failures==2);Wait(^BOOL{return failures==3;});CHECK(atomic_load(&reads)==6);
    // Admission and cancellation are safe off-main; every callback still runs on main.
    __block BOOL backgroundDone=NO;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY,0),^{
        id<CSAICancellable> read=CSAIReadCredentialAsync(@"carol",@"r1",^(NSString *key,NSError *error){CHECK(NSThread.isMainThread && !key && error.code==NSURLErrorCancelled);backgroundDone=YES;});[read cancel];
    });
    Wait(^BOOL{return backgroundDone;});Wait(^BOOL{return atomic_load(&reads)==7;});CHECK(!atomic_load(&mainReads));
    printf("AI credential store: %lu checks passed (7 stub reads, 0 reads on main)\n",(unsigned long)checks);
}return 0;}
