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
BOOL CSAIWriteCredential(NSString *account, NSString *revision, NSString *key, NSError **error) {
    NSDictionary *base=Query(account,revision); if(!base || ![key isKindOfClass:NSString.class] || !key.length || key.length>16384 || [key rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location!=NSNotFound) { CredentialError(error); return NO; }
    NSMutableDictionary *query=[base mutableCopy]; query[(__bridge id)kSecAttrAccessible]=(__bridge id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly; query[(__bridge id)kSecValueData]=[key dataUsingEncoding:NSUTF8StringEncoding];
    OSStatus status=SecItemAdd((__bridge CFDictionaryRef)query,NULL);
    // Immutable slots: never update an existing revision, even when its value matches.
    if(status!=errSecSuccess) CredentialError(error); return status==errSecSuccess;
}
void CSAIRemoveCredential(NSString *account, NSString *revision) { NSDictionary *query=Query(account,revision); if(query) SecItemDelete((__bridge CFDictionaryRef)query); }
