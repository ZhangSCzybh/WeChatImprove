#import "CSCloseFriendBridge.h"
#import "CSCloseFriendManager.h"
#import "CSCloseFriendSignatures.h"
#import "CSBackupBootstrap.h"
#import <objc/message.h>
#import <substrate.h>
NSString *const CSCloseFriendPolicyDidChangeNotification=@"CSCloseFriendPolicyDidChange";
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {
    return [CSCloseFriendManager.sharedManager.runtime snapshotForEpoch:CSBackupAccountEpoch() suspended:CSBackupAccountIsSuspended()];
}
NSUInteger CSCloseFriendAccountEpoch(void) { return CSBackupAccountEpoch(); }
BOOL CSCloseFriendShouldHideUserName(NSString *name, CSCloseFriendSurface surface) { return [CSCloseFriendCurrentSnapshot() hidesUserName:name surface:surface]; }
BOOL CSCloseFriendShouldRejectCall(NSString *caller, NSString *room, BOOL video) { return [CSCloseFriendCurrentSnapshot() rejectsCaller:caller chatRoom:room video:video]; }
BOOL CSCloseFriendHidesPrivacyIcons(void) { CSCloseFriendSnapshot *s=CSCloseFriendCurrentSnapshot(); return s.blocked || (s.enabled && [s.options[@"hidePrivacyIcons"] boolValue]); }
BOOL CSCloseFriendPluginEntryHidden(void) { CSCloseFriendSnapshot *s=CSCloseFriendCurrentSnapshot(); return s.enabled && [s.options[@"hidePluginEntry"] boolValue] && !s.revealed; }
id CSCloseFriendRead(id object, NSString *key) {
    if(!object || ![key isKindOfClass:NSString.class] || !key.length)return nil;
    @try {
        if([object isKindOfClass:NSDictionary.class])return object[key];
        SEL sel=NSSelectorFromString(key); Method method=class_getInstanceMethod([object class],sel);
        if(CSCloseFriendMethodMatches(method,"@@:"))return ((id(*)(id,SEL))objc_msgSend)(object,sel);
        Ivar ivar=class_getInstanceVariable([object class],key.UTF8String);
        if(ivar && ivar_getTypeEncoding(ivar)[0]=='@')return object_getIvar(object,ivar);
    } @catch(__unused NSException *exception) {}
    return nil;
}
NSString *CSCloseFriendUserName(id object) {
    if([object isKindOfClass:NSString.class])return object;
    for(NSString *key in @[@"m_nsUsrName",@"m_nsUserName",@"userName",@"username",@"m_nsChatRoomName",@"sessionName"]) {
        id value=CSCloseFriendRead(object,key); if([value isKindOfClass:NSString.class] && [value length])return value;
    }
    return nil;
}
void CSCloseFriendLock(void) { void (^lock)(void)=^{ [CSCloseFriendManager.sharedManager lockAndReturnToSafePage]; }; if(NSThread.isMainThread)lock();else dispatch_sync(dispatch_get_main_queue(),lock); }
void CSCloseFriendAuthenticate(UIViewController *presenter, void (^completion)(BOOL)) {
    NSUInteger epoch=CSBackupAccountEpoch();
    dispatch_async(dispatch_get_main_queue(),^{
        if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended()) { if(completion)completion(NO); return; }
        [CSCloseFriendManager.sharedManager authenticateFrom:presenter completion:completion];
    });
}
void CSCloseFriendRecordCapability(NSString *name, BOOL available) { [CSCloseFriendManager.sharedManager recordCapability:name available:available]; }
NSDictionary *CSCloseFriendCurrentProfile(void) { CSCloseFriendSnapshot *s=CSCloseFriendCurrentSnapshot(); return s.blocked?nil:CSCloseFriendManager.sharedManager.runtime.currentProfile; }
static BOOL CSBridgeMutation(NSString *account, NSUInteger epoch, BOOL (^mutation)(NSError **), NSError **error) {
    if(!NSThread.isMainThread) { if(error)*error=[NSError errorWithDomain:@"CSCloseFriendRuntime" code:2 userInfo:@{NSLocalizedDescriptionKey:@"必须在主线程修改密友配置。"}]; return NO; }
    __block BOOL ok=NO; __block NSError *localError=nil;
    CSBackupPerformAtAccountEpoch(epoch,^{
        if(CSBackupAccountIsSuspended())return;
        [CSCloseFriendManager.sharedManager refreshAccount];
        CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
        if(snapshot.blocked || (account && ![snapshot.accountID isEqual:account]))return;
        ok=mutation(&localError);
    });
    if(!ok && error)*error=localError?:[NSError errorWithDomain:@"CSCloseFriendRuntime" code:3 userInfo:@{NSLocalizedDescriptionKey:@"当前账号不可用或操作已失效。"}];
    return ok;
}
BOOL CSCloseFriendUpdateCurrentProfile(NSDictionary *profile, NSError **error) { return CSBridgeMutation(nil,CSBackupAccountEpoch(),^BOOL(NSError **e){ return [CSCloseFriendManager.sharedManager.runtime updateProfile:profile error:e]; },error); }
BOOL CSCloseFriendInstallHook(NSString *className, NSString *selector, IMP replacement, IMP *original, const char *encoding) {
    Class cls=NSClassFromString(className); SEL sel=NSSelectorFromString(selector);
    BOOL available=cls && replacement && original && CSCloseFriendMethodMatches(class_getInstanceMethod(cls,sel),encoding);
    if(available) { MSHookMessageEx(cls,sel,replacement,original); available=*original!=NULL; }
    CSCloseFriendRecordCapability([NSString stringWithFormat:@"%@.%@",className,selector],available);
    return available;
}
