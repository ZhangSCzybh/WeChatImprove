#import "CSCloseFriendCrypto.h"
#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>
static const NSUInteger CSMaxPlaintext=4*1024*1024;
static id CSFail(NSError **error) { if(error)*error=[NSError errorWithDomain:@"CSCloseFriendCrypto" code:1 userInfo:@{NSLocalizedDescriptionKey:@"Close-friend encrypted data could not be verified."}]; return nil; }
NSData *CSCloseFriendRandomBytes(NSUInteger length,NSError **error) {
    if(!length || length>CSMaxPlaintext)return CSFail(error);
    NSMutableData *data=[NSMutableData dataWithLength:length];
    if(SecRandomCopyBytes(kSecRandomDefault,length,data.mutableBytes)!=errSecSuccess)return CSFail(error);
    return [data copy];
}
BOOL CSCloseFriendConstantTimeEqual(NSData *a,NSData *b) {
    if(![a isKindOfClass:NSData.class] || ![b isKindOfClass:NSData.class] || a.length!=b.length)return NO;
    const uint8_t *aa=a.bytes,*bb=b.bytes; volatile uint8_t difference=0;
    for(NSUInteger i=0;i<a.length;i++) difference|=aa[i]^bb[i];
    return difference==0;
}
NSData *CSCloseFriendPasswordVerifier(NSString *password,NSData *salt,NSUInteger iterations,NSError **error) {
    if(![password isKindOfClass:NSString.class] || !password.length || password.length>4096 || ![salt isKindOfClass:NSData.class] || salt.length!=32 || iterations<210000 || iterations>2000000)return CSFail(error);
    NSData *input=[password dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *derived=[NSMutableData dataWithLength:32];
    if(!input || CCKeyDerivationPBKDF(kCCPBKDF2,input.bytes,input.length,salt.bytes,salt.length,kCCPRFHmacAlgSHA256,(uint)iterations,derived.mutableBytes,derived.length)!=kCCSuccess)return CSFail(error);
    return [derived copy];
}
static NSData *CSMAC(NSData *data,NSData *key) {
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256,(const uint8_t *)key.bytes+32,32,data.bytes,data.length,digest);
    return [NSData dataWithBytes:digest length:sizeof(digest)];
}
static NSData *CSCrypt(CCOperation operation,NSData *input,NSData *key,const void *iv,NSError **error) {
    NSMutableData *output=[NSMutableData dataWithLength:input.length+kCCBlockSizeAES128]; size_t written=0;
    CCCryptorStatus status=CCCrypt(operation,kCCAlgorithmAES,kCCOptionPKCS7Padding,key.bytes,32,iv,input.bytes,input.length,output.mutableBytes,output.length,&written);
    if(status!=kCCSuccess)return CSFail(error);
    output.length=written; return [output copy];
}
NSData *CSCloseFriendEncrypt(NSData *plaintext,NSData *key,NSError **error) {
    if(![plaintext isKindOfClass:NSData.class] || plaintext.length>CSMaxPlaintext || ![key isKindOfClass:NSData.class] || key.length!=64)return CSFail(error);
    NSData *iv=CSCloseFriendRandomBytes(16,error); if(!iv)return nil;
    NSData *cipher=CSCrypt(kCCEncrypt,plaintext,key,iv.bytes,error); if(!cipher)return nil;
    const uint8_t header[]={0x43,0x53,0x43,0x46,0,0,0,1};
    NSMutableData *envelope=[NSMutableData dataWithBytes:header length:sizeof(header)];
    [envelope appendData:iv]; [envelope appendData:cipher]; [envelope appendData:CSMAC(envelope,key)]; return [envelope copy];
}
NSData *CSCloseFriendDecrypt(NSData *envelope,NSData *key,NSError **error) {
    if(![envelope isKindOfClass:NSData.class] || envelope.length<72 || envelope.length>CSMaxPlaintext+72 || (envelope.length-56)%16 || ![key isKindOfClass:NSData.class] || key.length!=64)return CSFail(error);
    NSData *body=[envelope subdataWithRange:NSMakeRange(0,envelope.length-32)];
    NSData *mac=[envelope subdataWithRange:NSMakeRange(envelope.length-32,32)];
    if(!CSCloseFriendConstantTimeEqual(CSMAC(body,key),mac))return CSFail(error);
    const uint8_t expected[]={0x43,0x53,0x43,0x46,0,0,0,1};
    if(memcmp(envelope.bytes,expected,sizeof(expected)))return CSFail(error);
    NSData *cipher=[envelope subdataWithRange:NSMakeRange(24,envelope.length-56)];
    return CSCrypt(kCCDecrypt,cipher,key,(const uint8_t *)envelope.bytes+8,error);
}
