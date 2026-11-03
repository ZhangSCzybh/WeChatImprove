#import "CSNativeRewardRoute.h"

// Captured from ScanWXCodeRewardUrlPrefixHandler.handleUrl: in WeChat 8.0.78 (8.0.78.34).
// The author verified this code with another account and completed a reward payment.
// This is opaque WXCode content. Preserve every byte, including '/' and '(?'.
NSString * const CSAuthorRewardContent = @"m0Ggq8kqRKX/V3Z-Ior(?3";
static NSString * const CSRewardHandlerName = @"ScanWXCodeRewardUrlPrefixHandler";

static BOOL CSRewardMethod(id target, NSString *name, NSUInteger count, char returnType) {
    @try {
        SEL sel = NSSelectorFromString(name);
        if (![target respondsToSelector:sel]) return NO;
        NSMethodSignature *sig = [target methodSignatureForSelector:sel];
        if (!sig || sig.numberOfArguments != count + 2 || sig.methodReturnType[0] != returnType) return NO;
        for (NSUInteger i = 0; i < count; i++) if ([sig getArgumentTypeAtIndex:i + 2][0] != '@') return NO;
        return YES;
    } @catch (__unused NSException *exception) { return NO; }
}
static BOOL CSRewardInvoke(id target, NSString *name, NSArray *args, id *result) {
    @try {
        if (!CSRewardMethod(target, name, args.count, result ? '@' : 'v')) return NO;
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:NSSelectorFromString(name)]];
        inv.target = target; inv.selector = NSSelectorFromString(name);
        for (NSUInteger i = 0; i < args.count; i++) {
            id arg = args[i] == NSNull.null ? nil : args[i]; [inv setArgument:&arg atIndex:i + 2];
        }
        [inv retainArguments];
        [inv invoke];
        if (result) { __unsafe_unretained id value = nil; [inv getReturnValue:&value]; *result = value; }
        return YES;
    } @catch (__unused NSException *exception) { return NO; }
}
static id CSRewardRead(id target, NSString *name) {
    id value = nil; CSRewardInvoke(target, name, @[], &value); return value;
}
static id CSRewardCreate(NSString *name) {
    @try {
        Class cls = NSClassFromString(name);
        if (![cls isSubclassOfClass:NSObject.class]) return nil;
        return [[cls alloc] init];
    } @catch (__unused NSException *exception) { return nil; }
}
@interface CSNativeRewardRoute ()
@property(nonatomic, readwrite) CSNativeRewardState state;
@property(nonatomic, weak) id host;
@property(nonatomic, strong) id handler;
@property(nonatomic, strong) id parameters;
@end
@implementation CSNativeRewardRoute
- (instancetype)initWithHost:(id)host {
    if ((self = [super init])) {
        _host = host;
    }
    return self;
}
- (void)update:(CSNativeRewardState)state message:(NSString *)message {
    self.state = state;
    if (self.changed) self.changed(state, message);
}
- (void)fail {
    [self detach];
    [self update:CSNativeRewardFailed message:@"当前微信暂未能打开赞赏页面，请返回设置后重试。"];
}
- (void)start {
    if (!NSThread.isMainThread) return;
    if (self.state != CSNativeRewardIdle) return;
    // Native payment calls MMUIViewController loading APIs, including from async CGI
    // callbacks. A plain UIViewController is not a compatible host.
    Class viewControllerClass = NSClassFromString(@"MMUIViewController");
    if (!viewControllerClass || ![self.host isKindOfClass:viewControllerClass] ||
        !CSRewardMethod(self.host, @"startLoadingNonBlock", 0, 'v') ||
        !CSRewardMethod(self.host, @"stopLoading", 0, 'v') ||
        !CSRewardMethod(self.host, @"loadingViewX", 0, '@')) { [self fail]; return; }
    [self update:CSNativeRewardPreparing message:@"正在打开微信赞赏页面…"];
    if (self.state != CSNativeRewardPreparing) return;
    // The captured reward handler supplies the reward-specific flow. Keep native defaults;
    // do not invent scanner codeType, getA8KeyScene, channel, amount or order parameters.
    self.parameters = CSRewardCreate(@"ScanQRCodeLogicParams");
    self.handler = CSRewardCreate(CSRewardHandlerName);
    if (!self.parameters || !self.handler) { [self fail]; return; }
    if (!CSRewardMethod(self.handler, @"handleUrl:", 1, 'v') ||
        !CSRewardMethod(self.handler, @"m_delegate", 0, '@') ||
        !CSRewardInvoke(self.handler, @"setM_delegate:", @[self], NULL) ||
        CSRewardRead(self.handler, @"m_delegate") != self) {
        [self fail]; return;
    }
    [self update:CSNativeRewardOpening message:@"正在打开微信赞赏页面…"];
    if (self.state != CSNativeRewardOpening) return;
    // Retain this exact handler through synchronous delegate re-entry and cancellation.
    __attribute__((objc_precise_lifetime)) id handler = self.handler;
    BOOL invoked = CSRewardInvoke(handler, @"handleUrl:", @[CSAuthorRewardContent], NULL);
    if (!invoked && self.state == CSNativeRewardOpening) {
        // The native method may already have launched work. Do not issue another request.
        [self update:self.state message:@"微信未完成跳转，请返回设置后重试。"];
    }
}
- (id)getScanQRCodeLogicParams { return self.state == CSNativeRewardCancelled ? nil : self.parameters; }
- (id)getScanQRCodeSourceWebViewControllerUrl { return nil; }
- (id)onScanQRCodeUrlPrefixHandlerRequestViewController { return self.state == CSNativeRewardCancelled ? nil : self.host; }
// Required delegate notifications; navigation remains owned by the native reward flow.
- (void)onScanQRCodeUrlPrefixHandlerStart {}
- (void)onScanQRCodeUrlPrefixHandlerScanFinish {}
- (void)onScanQRCodeUrlPrefixHandlerWithErrorMsg:(id)message {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self onScanQRCodeUrlPrefixHandlerWithErrorMsg:message]; }); return; }
    if (self.state != CSNativeRewardOpening && self.state != CSNativeRewardPresented) return;
    // Show a stable message without exposing native account or payment details.
    [self update:self.state message:@"微信暂未能打开赞赏页面，请返回设置后重试。"];
}
- (void)onScanQRCodeUrlPrefixHandlerEnd {
    if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self onScanQRCodeUrlPrefixHandlerEnd]; }); return; }
    if (self.state != CSNativeRewardOpening && self.state != CSNativeRewardPresented) return;
    [self detach];
    [self update:CSNativeRewardFinished message:@""];
}
- (void)paymentPageDidAppear {
    if (self.state != CSNativeRewardOpening) return;
    [self update:CSNativeRewardPresented message:@""];
}
- (void)openingTimedOut {
    if (self.state != CSNativeRewardOpening) return;
    [self update:self.state message:@"微信暂未显示赞赏页面，请检查网络后返回设置重试。"];
}
- (void)detach {
    id retiringHandler = self.handler;
    CSRewardInvoke(retiringHandler, @"setM_delegate:", @[NSNull.null], NULL);
    self.handler = nil; self.parameters = nil;
    // A native delegate callback may still be returning on this object's stack.
    if (retiringHandler) dispatch_async(dispatch_get_main_queue(), ^{ (void)[retiringHandler class]; });
}
- (void)cancel {
    if (self.state == CSNativeRewardCancelled) return;
    self.state = CSNativeRewardCancelled;
    self.changed = nil;
    id handler = self.handler;
    id payer = CSRewardRead(handler, @"qrcodeRewardPayerLogic");
    CSRewardInvoke(handler, @"setM_delegate:", @[NSNull.null], NULL);
    CSRewardInvoke(payer, @"stopLogic", @[], NULL); // Only this route's own control logic.
    [self detach]; self.host = nil;
}
- (void)dealloc { [self cancel]; }
@end
