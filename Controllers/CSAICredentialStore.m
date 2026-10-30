#import "CSAICredentialStore.h"
#import "CSAIReplyStore.h"
#import <Security/Security.h>
static NSDictionary *Query(NSString *account, NSString *revision) {
    if(![account isKindOfClass:NSString.class] || !account.length || account.length>512 || ![revision isKindOfClass:NSString.class] || !revision.length || revision.length>200) return nil;
    return @{(__bridge id)kSecClass:(__bridge id)kSecClassGenericPassword,(__bridge id)kSecAttrService:@"com.wechatimprove.ai-reply.v1",(__bridge id)kSecAttrAccount:[NSString stringWithFormat:@"%lu:%@%@",(unsigned long)account.length,account,revision],(__bridge id)kSecAttrSynchronizable:@NO};
}
static void CredentialError(NSError **error) { if(error) *error=CSAIError(30,@"无法访问 AI 凭据，请重新保存 API Key"); }
NSString *CSAIReadCredential(NSString *account, NSString *revision, NSError **error) {
    NSDictionary *base=Query(account,revision); if(!base) { CredentialError(error); return nil; }
    NSMutableDictionary *query=[base mutableCopy]; query[(__bridge id)kSecReturnData]=@YES; query[(__bridge id)kSecMatchLimit]=(__bridge id)kSecMatchLimitOne;
    CFTypeRef result=NULL; OSStatus status=SecItemCopyMatching((__bridge CFDictionaryRef)query,&result);
    if(status!=errSecSuccess) { if(result) CFRelease(result); CredentialError(error); return nil; }
    id data=CFBridgingRelease(result); NSString *key=[data isKindOfClass:NSData.class]?[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]:nil;
    if(!key.length) CredentialError(error); return key;
}
@interface CSAICredentialRead : NSObject <CSAICancellable>
@property(nonatomic,copy) CSAICompletion completion;
@property(nonatomic) BOOL finished;
- (void)finish:(NSString *)key error:(NSError *)error;
@end
@implementation CSAICredentialRead
- (void)finish:(NSString *)key error:(NSError *)error {
    CSAICompletion completion=nil;
    @synchronized(self){if(self.finished)return;self.finished=YES;completion=self.completion;self.completion=nil;}
    if(!completion)return;
    if(NSThread.isMainThread)completion(key,error);
    else dispatch_async(dispatch_get_main_queue(),^{completion(key,error);});
}
- (void)cancel {[self finish:nil error:CSAIError(NSURLErrorCancelled,@"已取消凭据读取。")];}
@end
id<CSAICancellable> CSAIReadCredentialAsync(NSString *account, NSString *revision, CSAICompletion completion) {
    CSAICredentialRead *reader=[CSAICredentialRead new];reader.completion=completion;
    // Admission must not queue behind blocking Keychain I/O: a second reader
    // can join while the first system call is still running.
    static NSMutableDictionary<NSArray<NSString *> *,NSMutableArray<CSAICredentialRead *> *> *flights;
    static dispatch_queue_t worker;static dispatch_once_t once;
    dispatch_once(&once,^{flights=[NSMutableDictionary dictionary];worker=dispatch_queue_create("com.wechatimprove.ai.credentials",DISPATCH_QUEUE_SERIAL);});
    if(!Query(account,revision)){
        dispatch_async(dispatch_get_main_queue(),^{NSError *error=nil;CredentialError(&error);[reader finish:nil error:error];});return reader;
    }
    NSArray<NSString *> *slot=@[[account copy],[revision copy]];
    @synchronized(flights){
        NSMutableArray *readers=flights[slot];
        if(readers){[readers addObject:reader];return reader;}
        flights[slot]=[NSMutableArray arrayWithObject:reader];
    }
    dispatch_async(worker,^{@autoreleasepool{
        NSError *error=nil;NSString *key=CSAIReadCredential(slot[0],slot[1],&error);
        dispatch_async(dispatch_get_main_queue(),^{
            NSArray<CSAICredentialRead *> *readers;
            @synchronized(flights){readers=[flights[slot] copy];[flights removeObjectForKey:slot];}
            // No result cache: plaintext lives only until these callbacks return.
            for(CSAICredentialRead *pending in readers)[pending finish:key error:error];
        });
    }});
    return reader;
}
BOOL CSAIWriteCredential(NSString *account, NSString *revision, NSString *key, NSError **error) {
    NSDictionary *base=Query(account,revision); if(!base || ![key isKindOfClass:NSString.class] || !key.length || key.length>16384 || [key rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location!=NSNotFound) { CredentialError(error); return NO; }
    NSMutableDictionary *query=[base mutableCopy]; query[(__bridge id)kSecAttrAccessible]=(__bridge id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly; query[(__bridge id)kSecValueData]=[key dataUsingEncoding:NSUTF8StringEncoding];
    OSStatus status=SecItemAdd((__bridge CFDictionaryRef)query,NULL);
    // Immutable slots: never update an existing revision, even when its value matches.
    if(status!=errSecSuccess) CredentialError(error); return status==errSecSuccess;
}
void CSAIRemoveCredential(NSString *account, NSString *revision) { NSDictionary *query=Query(account,revision); if(query) SecItemDelete((__bridge CFDictionaryRef)query); }
