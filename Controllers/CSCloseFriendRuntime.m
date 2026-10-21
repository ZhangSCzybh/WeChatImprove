#import "CSCloseFriendRuntime.h"
#import "CSCloseFriendCrypto.h"
#import <math.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CommonCrypto/CommonCrypto.h>
static BOOL CSRuntimeFail(NSError **error, NSString *message) {
    if(error)*error=[NSError errorWithDomain:@"CSCloseFriendRuntime" code:1 userInfo:@{NSLocalizedDescriptionKey:message}];
    return NO;
}
static NSDictionary *CSEmptyProfile(void) { return @{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":CSCloseFriendDefaultOptions()}; }
@interface CSCloseFriendRuntime ()
@property(nonatomic,strong) CSCloseFriendStore *store;
@property(nonatomic,strong) CSCloseFriendSnapshot *publishedSnapshot, *boundarySnapshot;
@property(nonatomic,copy) NSTimeInterval (^wallClock)(void);
@property(nonatomic,copy) NSTimeInterval (^elapsedClock)(void);
@property(nonatomic,copy) CSCloseFriendCredentialReader reader;
@property(nonatomic,copy) CSCloseFriendCredentialWriter writer;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSDictionary *state, *credential;
@property(nonatomic) NSUInteger epoch, generation, revision;
@property(nonatomic) BOOL blocked, active, suspended;
@property(nonatomic) NSTimeInterval revealUntil;
@property(nonatomic,strong) dispatch_queue_t searchQueue;
@property(nonatomic,strong) NSData *searchCacheKey;
@property(nonatomic,strong) NSMutableDictionary<NSData *,NSNumber *> *searchCache;
@property(nonatomic) NSUInteger searchCredentialVersion, searchRequest;
@end
@implementation CSCloseFriendRuntime
- (instancetype)initWithStore:(CSCloseFriendStore *)store clock:(NSTimeInterval (^)(void))clock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer {
    return [self initWithStore:store wallClock:clock elapsedClock:^NSTimeInterval{ return NSProcessInfo.processInfo.systemUptime; } credentialReader:reader credentialWriter:writer];
}
- (instancetype)initWithStore:(CSCloseFriendStore *)store wallClock:(NSTimeInterval (^)(void))wallClock elapsedClock:(NSTimeInterval (^)(void))elapsedClock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer {
    if((self=[super init])) { _store=store; _wallClock=[wallClock copy]; _elapsedClock=[elapsedClock copy]; _reader=[reader copy]; _writer=[writer copy]; _account=@""; _blocked=YES; _active=YES; }
    return self;
}
- (void)invalidateSearchVerification {
    self.searchCredentialVersion++; self.searchRequest++;
    self.searchCache=nil; self.searchCacheKey=nil;
}
- (void)changed { self.revision++; self.publishedSnapshot=nil; self.boundarySnapshot=nil; if(self.didChange)self.didChange(); }
- (BOOL)validCredential:(NSDictionary *)value {
    if(![value isKindOfClass:NSDictionary.class] || value.count!=5)return NO;
    for(NSString *key in @[@"iterations",@"failures",@"cooldown"]) {
        id number=value[key];
        if(![number isKindOfClass:NSNumber.class] || CFGetTypeID((__bridge CFTypeRef)number)==CFBooleanGetTypeID())return NO;
        double numeric=[number doubleValue];
        if(!isfinite(numeric) || numeric<0 || ((![key isEqual:@"cooldown"]) && floor(numeric)!=numeric))return NO;
    }
    if([value[@"failures"] unsignedIntegerValue]>10)return NO;
    return [value[@"salt"] isKindOfClass:NSData.class] && [value[@"salt"] length]==32 && [value[@"verifier"] isKindOfClass:NSData.class] && [value[@"verifier"] length]==32 && [value[@"iterations"] isKindOfClass:NSNumber.class] && [value[@"iterations"] unsignedIntegerValue]>=210000 && [value[@"iterations"] unsignedIntegerValue]<=2000000 && [value[@"failures"] isKindOfClass:NSNumber.class] && [value[@"cooldown"] isKindOfClass:NSNumber.class];
}
- (void)synchronizeAccount:(NSString *)account epoch:(NSUInteger)epoch suspended:(BOOL)suspended {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if([self.account isEqual:account] && self.epoch==epoch && self.suspended==suspended && !self.blocked)return;
        [self invalidateSearchVerification];
        self.account=[account copy]?:@""; self.epoch=epoch; self.suspended=suspended; self.generation++; self.revealUntil=0; self.state=nil; self.credential=nil; self.blocked=YES;
        if(account.length && !suspended) {
            NSError *error=nil;
            NSDictionary *state=[self.store loadStateForAccountID:account error:&error];
            BOOL missing=[error.domain isEqual:CSCloseFriendStoreErrorDomain] && error.code==CSCloseFriendStoreErrorMissing;
            if(state || missing) {
                error=nil; NSDictionary *credential=self.reader(account,&error);
                if(!error && (!credential || [self validCredential:credential])) {
                    self.credential=credential;
                    self.state=state?:@{@"profile":CSEmptyProfile(),@"muteRecords":@{}};
                    // Any persisted policy without its verifier is a security failure, never a new setup.
                    self.blocked=state!=nil && !credential;
                }
            }
        }
        [self changed];
    }
}
- (CSCloseFriendSnapshot *)snapshotForEpoch:(NSUInteger)epoch suspended:(BOOL)suspended {
    @synchronized(self) {
        // A boundary must not apply the old account's notification/call membership.
        if(self.suspended || suspended || epoch!=self.epoch) {
            if(!self.boundarySnapshot)self.boundarySnapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"" profile:CSEmptyProfile() revealed:NO revision:self.revision blocked:YES];
            return self.boundarySnapshot;
        }
        BOOL revealed=!self.blocked && self.active && self.revealUntil>self.elapsedClock();
        if(self.publishedSnapshot && self.publishedSnapshot.revealed!=revealed)[self changed];
        if(!self.publishedSnapshot) {
            self.publishedSnapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:self.account profile:self.state[@"profile"]?:CSEmptyProfile() revealed:revealed revision:self.revision blocked:self.blocked];
        }
        return self.publishedSnapshot;
    }
}
- (void)lock {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        BOOL changed=self.publishedSnapshot.revealed || self.revealUntil>self.elapsedClock() ||
            (self.publishedSnapshot && self.publishedSnapshot.blocked!=self.blocked);
        self.revealUntil=0; self.generation++; self.searchRequest++;
        // Authentication is invalidated even when display state was already locked.
        if(changed)[self changed];
    }
}
- (NSTimeInterval)revealTimeRemaining {
    @synchronized(self) { return !self.blocked && !self.suspended && self.active ? MAX(0,self.revealUntil-self.elapsedClock()) : 0; }
}
- (void)setActive:(BOOL)active { NSAssert(NSThread.isMainThread,@"Main-thread mutation required"); @synchronized(self) { _active=active; if(!active)[self lock]; } }
- (NSDictionary *)authenticationToken { @synchronized(self) { if(self.blocked || self.suspended || !self.active || !self.account.length)return nil; return @{@"account":self.account,@"epoch":@(self.epoch),@"generation":@(self.generation)}; } }
- (BOOL)isTokenCurrent:(NSDictionary *)token { @synchronized(self) { return token && [[self authenticationToken] isEqual:token]; } }
- (BOOL)hasCredential { @synchronized(self) { return self.credential!=nil; } }
- (BOOL)isAuthorized { @synchronized(self) { return !self.blocked && !self.suspended && self.active && self.revealUntil>self.elapsedClock(); } }
- (BOOL)setPassword:(NSString *)password token:(NSDictionary *)token error:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if(![self isTokenCurrent:token] || (self.credential && ![self isAuthorized]))return CSRuntimeFail(error,@"请重新验证当前账号。");
        BOOL numeric=password.length>=6 && [password rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"].invertedSet].location==NSNotFound;
        if((!numeric && password.length<8) || password.length>128)return CSRuntimeFail(error,@"密码至少 6 位数字或 8 个字符，最长 128 个字符。");
        NSData *salt=CSCloseFriendRandomBytes(32,error); NSData *verifier=salt?CSCloseFriendPasswordVerifier(password,salt,210000,error):nil;
        if(!verifier)return NO;
        NSDictionary *credential=@{@"salt":salt,@"verifier":verifier,@"iterations":@210000,@"failures":@0,@"cooldown":@0};
        if(!self.writer(self.account,credential,error))return NO;
        [self invalidateSearchVerification]; self.credential=credential; self.generation++; self.revealUntil=self.elapsedClock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue]; [self changed]; return YES;
    }
}
- (BOOL)persistCredential:(NSDictionary *)credential error:(NSError **)error {
    if(!self.writer(self.account,credential,error)) { self.blocked=YES; [self lock]; return NO; }
    self.credential=credential; return YES;
}
- (BOOL)authenticatePassword:(NSString *)password token:(NSDictionary *)token error:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if(![self isTokenCurrent:token] || !self.credential)return CSRuntimeFail(error,@"验证已失效，请重试。");
        if([self.credential[@"cooldown"] doubleValue]>self.wallClock())return CSRuntimeFail(error,@"错误次数过多，请稍后重试。");
        NSData *derived=CSCloseFriendPasswordVerifier(password,self.credential[@"salt"],[self.credential[@"iterations"] unsignedIntegerValue],NULL);
        BOOL success=derived && CSCloseFriendConstantTimeEqual(derived,self.credential[@"verifier"]);
        NSMutableDictionary *next=[self.credential mutableCopy];
        NSUInteger failures=success?0:MIN([next[@"failures"] unsignedIntegerValue]+1,10u);
        next[@"failures"]=@(failures); next[@"cooldown"]=@(!success && failures>=5 ? self.wallClock()+MIN(300.0,30.0*(failures-4)):0);
        if(![self persistCredential:next error:error])return NO;
        if(!success)return CSRuntimeFail(error,@"密码错误。");
        self.revealUntil=self.elapsedClock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue]; self.generation++; [self changed]; return YES;
    }
}
- (BOOL)revealWithShortcutToken:(NSDictionary *)token {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if(![self isTokenCurrent:token] || !self.credential || ![self.state[@"profile"][@"enabled"] boolValue]) return NO;
        self.revealUntil=self.elapsedClock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue];
        self.generation++; [self changed]; return YES;
    }
}
- (BOOL)consumeVerifiedSearchPassword:(NSDictionary *)token {
    // Recognition always consumes the secret, including cooldown or stale authority.
    if(![self isTokenCurrent:token] || ![self.state[@"profile"][@"enabled"] boolValue] ||
       [self.credential[@"cooldown"] doubleValue]>self.wallClock())return YES;
    if([self.credential[@"failures"] unsignedIntegerValue] || [self.credential[@"cooldown"] doubleValue]) {
        NSMutableDictionary *next=[self.credential mutableCopy]; next[@"failures"]=@0; next[@"cooldown"]=@0;
        if(![self persistCredential:next error:NULL])return YES;
    }
    [self revealWithShortcutToken:token]; return YES;
}
- (void)checkSearchPassword:(NSString *)query token:(NSDictionary *)token isCurrent:(BOOL (^)(void))isCurrent completion:(void (^)(BOOL))completion {
    NSAssert(NSThread.isMainThread,@"Main-thread search dispatch required");
    if(!completion)return;
    void (^finish)(BOOL)=^(BOOL consumed){ dispatch_async(dispatch_get_main_queue(),^{completion(consumed);}); };
    @synchronized(self) {
        if(![query isKindOfClass:NSString.class] || query.length<6 || query.length>128 ||
           !self.credential || ![self.state[@"profile"][@"enabled"] boolValue]) {finish(NO);return;}
        if(![self isTokenCurrent:token] || !isCurrent()) {finish(YES);return;}
        if(!self.searchCacheKey)self.searchCacheKey=CSCloseFriendRandomBytes(32,NULL);
        if(!self.searchCacheKey) {finish(YES);return;}
        NSData *input=[query dataUsingEncoding:NSUTF8StringEncoding]; uint8_t bytes[CC_SHA256_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA256,self.searchCacheKey.bytes,self.searchCacheKey.length,input.bytes,input.length,bytes);
        NSData *tag=[NSData dataWithBytes:bytes length:sizeof(bytes)];
        NSUInteger request=++self.searchRequest, version=self.searchCredentialVersion;
        if(self.searchCache[tag]) {finish(NO);return;}
        if(!self.searchQueue)self.searchQueue=dispatch_queue_create("com.wechatimprove.closefriends.search",dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,QOS_CLASS_USER_INITIATED,0));
        NSData *salt=self.credential[@"salt"], *verifier=self.credential[@"verifier"];
        NSUInteger iterations=[self.credential[@"iterations"] unsignedIntegerValue];
        NSString *candidate=[query copy];
        dispatch_async(self.searchQueue,^{
            BOOL current;
            @synchronized(self) {current=request==self.searchRequest && version==self.searchCredentialVersion;}
            // Superseded queued queries never spend another PBKDF2 operation.
            NSData *derived=current ? CSCloseFriendPasswordVerifier(candidate,salt,iterations,NULL) : nil;
            BOOL match=derived && CSCloseFriendConstantTimeEqual(derived,verifier);
            dispatch_async(dispatch_get_main_queue(),^{
                @synchronized(self) {
                    if(!derived || request!=self.searchRequest || version!=self.searchCredentialVersion || ![self isTokenCurrent:token] || !isCurrent()) {finish(YES);return;}
                    // Cache only unrelated queries, never a fast verifier for the real password.
                    if(!match) {
                        if(!self.searchCache)self.searchCache=[NSMutableDictionary dictionary];
                        if(self.searchCache.count>=32)[self.searchCache removeAllObjects];
                        self.searchCache[tag]=@NO;
                    }
                    finish(match ? [self consumeVerifiedSearchPassword:token] : NO);
                }
            });
        });
    }
}
- (BOOL)completeBiometricWithToken:(NSDictionary *)token {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if(![self isTokenCurrent:token] || !self.credential || ![self.state[@"profile"][@"options"][@"biometric"] boolValue] || [self.credential[@"cooldown"] doubleValue]>self.wallClock())return NO;
        self.revealUntil=self.elapsedClock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue]; self.generation++; [self changed]; return YES;
    }
}
- (NSDictionary *)currentProfile { @synchronized(self) { return self.blocked?nil:self.state[@"profile"]; } }
- (BOOL)saveState:(NSDictionary *)state error:(NSError **)error {
    if(![self.store saveState:state forAccountID:self.account error:error]) { self.blocked=YES; [self lock]; return NO; }
    // Read back immutable normalized data. A failure holds protection without replacing bytes.
    self.state=[self.store loadStateForAccountID:self.account error:error];
    if(!self.state) { self.blocked=YES; [self lock]; return NO; }
    [self changed]; return YES;
}
- (BOOL)updateProfile:(NSDictionary *)profile error:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if(![self isAuthorized] || !self.credential)return CSRuntimeFail(error,@"请先设置密码并验证当前账号。");
        NSDictionary *normalized=CSCloseFriendNormalizeProfile(profile,error); if(!normalized)return NO;
        return [self saveState:@{@"profile":normalized,@"muteRecords":self.state[@"muteRecords"]?:@{}} error:error];
    }
}
@end
