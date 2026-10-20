#import "CSCloseFriendRuntime.h"
#import "CSCloseFriendCrypto.h"
#import <math.h>
#import <CoreFoundation/CoreFoundation.h>
static BOOL CSRuntimeFail(NSError **error, NSString *message) {
    if(error)*error=[NSError errorWithDomain:@"CSCloseFriendRuntime" code:1 userInfo:@{NSLocalizedDescriptionKey:message}];
    return NO;
}
static NSDictionary *CSEmptyProfile(void) { return @{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":CSCloseFriendDefaultOptions()}; }
@interface CSCloseFriendRuntime ()
@property(nonatomic,strong) CSCloseFriendStore *store;
@property(nonatomic,strong) CSCloseFriendSnapshot *publishedSnapshot, *boundarySnapshot;
@property(nonatomic,copy) NSTimeInterval (^clock)(void);
@property(nonatomic,copy) CSCloseFriendCredentialReader reader;
@property(nonatomic,copy) CSCloseFriendCredentialWriter writer;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSDictionary *state, *credential;
@property(nonatomic) NSUInteger epoch, generation, revision;
@property(nonatomic) BOOL blocked, active, suspended;
@property(nonatomic) NSTimeInterval revealUntil;
@end
@implementation CSCloseFriendRuntime
- (instancetype)initWithStore:(CSCloseFriendStore *)store clock:(NSTimeInterval (^)(void))clock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer {
    if((self=[super init])) { _store=store; _clock=[clock copy]; _reader=[reader copy]; _writer=[writer copy]; _account=@""; _blocked=YES; _active=YES; }
    return self;
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
        BOOL revealed=!self.blocked && self.active && self.revealUntil>self.clock();
        if(self.publishedSnapshot && self.publishedSnapshot.revealed!=revealed)[self changed];
        if(!self.publishedSnapshot) {
            self.publishedSnapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:self.account profile:self.state[@"profile"]?:CSEmptyProfile() revealed:revealed revision:self.revision blocked:self.blocked];
        }
        return self.publishedSnapshot;
    }
}
- (void)lock { NSAssert(NSThread.isMainThread,@"Main-thread mutation required"); @synchronized(self) { self.revealUntil=0; self.generation++; [self changed]; } }
- (void)setActive:(BOOL)active { NSAssert(NSThread.isMainThread,@"Main-thread mutation required"); @synchronized(self) { _active=active; if(!active)[self lock]; } }
- (NSDictionary *)authenticationToken { @synchronized(self) { if(self.blocked || self.suspended || !self.active || !self.account.length)return nil; return @{@"account":self.account,@"epoch":@(self.epoch),@"generation":@(self.generation)}; } }
- (BOOL)isTokenCurrent:(NSDictionary *)token { @synchronized(self) { return token && [[self authenticationToken] isEqual:token]; } }
- (BOOL)hasCredential { @synchronized(self) { return self.credential!=nil; } }
- (BOOL)isAuthorized { @synchronized(self) { return !self.blocked && !self.suspended && self.active && self.revealUntil>self.clock(); } }
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
        self.credential=credential; self.generation++; self.revealUntil=self.clock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue]; [self changed]; return YES;
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
        if([self.credential[@"cooldown"] doubleValue]>self.clock())return CSRuntimeFail(error,@"错误次数过多，请稍后重试。");
        NSData *derived=CSCloseFriendPasswordVerifier(password,self.credential[@"salt"],[self.credential[@"iterations"] unsignedIntegerValue],NULL);
        BOOL success=derived && CSCloseFriendConstantTimeEqual(derived,self.credential[@"verifier"]);
        NSMutableDictionary *next=[self.credential mutableCopy];
        NSUInteger failures=success?0:MIN([next[@"failures"] unsignedIntegerValue]+1,10u);
        next[@"failures"]=@(failures); next[@"cooldown"]=@(!success && failures>=5 ? self.clock()+MIN(300.0,30.0*(failures-4)):0);
        if(![self persistCredential:next error:error])return NO;
        if(!success)return CSRuntimeFail(error,@"密码错误。");
        self.revealUntil=self.clock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue]; self.generation++; [self changed]; return YES;
    }
}
- (BOOL)completeBiometricWithToken:(NSDictionary *)token {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if(![self isTokenCurrent:token] || !self.credential || ![self.state[@"profile"][@"options"][@"biometric"] boolValue] || [self.credential[@"cooldown"] doubleValue]>self.clock())return NO;
        self.revealUntil=self.clock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue]; self.generation++; [self changed]; return YES;
    }
}
- (NSDictionary *)currentProfile { @synchronized(self) { return self.blocked?nil:self.state[@"profile"]; } }
- (NSDictionary *)muteRecords { @synchronized(self) { return self.blocked?@{}:self.state[@"muteRecords"]?:@{}; } }
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
        return [self saveState:@{@"profile":normalized,@"muteRecords":[self muteRecords]} error:error];
    }
}
- (BOOL)saveMuteRecords:(NSDictionary *)records account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error {
    NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
    @synchronized(self) {
        if(self.blocked || self.suspended || !self.credential || ![self.account isEqual:account] || self.epoch!=epoch)return CSRuntimeFail(error,@"账号已改变，静音恢复记录未写入。");
        return [self saveState:@{@"profile":self.state[@"profile"],@"muteRecords":records} error:error];
    }
}
@end
