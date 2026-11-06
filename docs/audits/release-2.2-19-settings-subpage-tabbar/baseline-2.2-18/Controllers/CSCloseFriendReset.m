#import "CSCloseFriendReset.h"
#import "CSCloseFriendStore.h"
#import "CSCloseFriendEntryState.h"

static NSData *CSResetIntent(void) { return [@"close-friends-reset-v1" dataUsingEncoding:NSUTF8StringEncoding]; }
static BOOL CSResetAccount(NSString *account) {
    return [account isKindOfClass:NSString.class] && account.length>0 && account.length<=512 &&
        [account rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location==NSNotFound;
}
static BOOL CSResetFail(NSError **error, BOOL pending) {
    if(error)*error=[NSError errorWithDomain:@"CSCloseFriendReset" code:pending?2:1 userInfo:@{NSLocalizedDescriptionKey:pending ?
        @"密友重置尚未完成，暂时无法使用密友。解锁设备并重新进入当前账号后会继续重试。" :
        @"无法记录密友重置，尚未开始清理。请解锁设备后重试。"}];
    return NO;
}
@interface CSCloseFriendReset ()
@property(nonatomic,strong) CSCloseFriendStore *store;
@property(nonatomic,strong) CSCloseFriendEntryState *entryState;
@property(nonatomic,copy) CSCloseFriendSecureReader reader;
@property(nonatomic,copy) CSCloseFriendSecureWriter writer;
@property(nonatomic,copy) CSCloseFriendSecureRemover remover;
@end
@implementation CSCloseFriendReset
- (instancetype)initWithStore:(CSCloseFriendStore *)store entryState:(CSCloseFriendEntryState *)entryState
                       reader:(CSCloseFriendSecureReader)reader writer:(CSCloseFriendSecureWriter)writer remover:(CSCloseFriendSecureRemover)remover {
    if((self=[super init])) { _store=store; _entryState=entryState; _reader=[reader copy]; _writer=[writer copy]; _remover=[remover copy]; }
    return self;
}
- (BOOL)beginResetForAccountID:(NSString *)account error:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Reset is serialized with account mutations");
    if(!CSResetAccount(account))return CSResetFail(error,NO);
    NSError *readError=nil;
    NSData *intent=self.reader(account,@"reset",&readError);
    if(readError || (intent && ![intent isEqual:CSResetIntent()]))return CSResetFail(error,YES);
    // Never clean any data before the secure intent is durable and read back.
    if(!intent && !self.writer(account,@"reset",CSResetIntent(),NULL))return CSResetFail(error,NO);
    intent=self.reader(account,@"reset",&readError);
    if(readError || ![intent isEqual:CSResetIntent()])return CSResetFail(error,YES);
    return [self finishResetForAccountID:account error:error];
}
- (BOOL)resumeResetForAccountID:(NSString *)account error:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Reset recovery is serialized with account mutations");
    if(!CSResetAccount(account))return CSResetFail(error,NO);
    NSError *readError=nil;
    NSData *intent=self.reader(account,@"reset",&readError);
    if(!readError && [intent isEqual:[@"close-friends-credential-reset-v1" dataUsingEncoding:NSUTF8StringEncoding]]) {
        self.remover(account,@"reset",NULL);
        return YES;
    }
    if(readError || (intent && ![intent isEqual:CSResetIntent()]))return CSResetFail(error,YES);
    return !intent || [self finishResetForAccountID:account error:error];
}
- (BOOL)finishResetForAccountID:(NSString *)account error:(NSError **)error {
    // Each step is idempotent. Retain the encryption key until ciphertext removal
    // is durable, and retain the intent until every account resource is cleared.
    if(![self.store removeStateForAccountID:account error:NULL] ||
       ![self.entryState removeDiscoveryForAccountID:account error:NULL])return CSResetFail(error,YES);
    for(NSString *kind in @[@"biometric-domain",@"auth",@"policy",@"reset"])
        if(!self.remover(account,kind,NULL))return CSResetFail(error,YES);
    return YES;
}
@end
