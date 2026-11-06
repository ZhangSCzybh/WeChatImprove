#import <Foundation/Foundation.h>
#import "CSNativeRewardRoute.h"
#include <stdlib.h>
static unsigned checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); exit(1); } } while (0)
@interface CSNativeRewardRoute (Callbacks)
- (id)getScanQRCodeLogicParams;
- (id)getScanQRCodeSourceWebViewControllerUrl;
- (id)onScanQRCodeUrlPrefixHandlerRequestViewController;
- (void)onScanQRCodeUrlPrefixHandlerStart;
- (void)onScanQRCodeUrlPrefixHandlerScanFinish;
- (void)onScanQRCodeUrlPrefixHandlerEnd;
- (void)onScanQRCodeUrlPrefixHandlerWithErrorMsg:(id)message;
@end
@interface UIViewController : NSObject @end
@implementation UIViewController @end
@interface MMUIViewController : UIViewController
- (void)startLoadingNonBlock;
- (void)stopLoading;
- (id)loadingViewX;
@end
@implementation MMUIViewController
- (void)startLoadingNonBlock {}
- (void)stopLoading {}
- (id)loadingViewX { return nil; }
@end
static BOOL parametersNil;
@interface ScanQRCodeLogicParams : NSObject @end
@implementation ScanQRCodeLogicParams
- (instancetype)init { return parametersNil ? nil : [super init]; }
@end
@interface FakePayer : NSObject
@property(nonatomic) NSUInteger stops;
- (void)stopLogic;
@end
@implementation FakePayer
- (void)stopLogic { self.stops++; }
@end
static NSUInteger routeCalls;
static NSUInteger behavior;
static NSString *received;
static BOOL badDelegate;
static BOOL badSignature;
static BOOL handlerNil;
@interface ScanWXCodeRewardUrlPrefixHandler : NSObject
@property(nonatomic, weak) CSNativeRewardRoute *m_delegate;
@property(nonatomic, strong) FakePayer *qrcodeRewardPayerLogic;
- (void)handleUrl:(id)url;
@end
static ScanWXCodeRewardUrlPrefixHandler *lastHandler;
@implementation ScanWXCodeRewardUrlPrefixHandler
- (instancetype)init {
    if (handlerNil) return nil;
    if ((self = [super init])) { _qrcodeRewardPayerLogic = [FakePayer new]; lastHandler = self; }
    return self;
}
- (void)setM_delegate:(CSNativeRewardRoute *)delegate { _m_delegate = badDelegate ? nil : delegate; }
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (badSignature && sel == @selector(handleUrl:)) return [NSMethodSignature signatureWithObjCTypes:"v@:q"];
    return [super methodSignatureForSelector:sel];
}
- (void)handleUrl:(id)url {
    routeCalls++; received = [url copy];
    CHECK([self.m_delegate getScanQRCodeLogicParams] != nil);
    CHECK([self.m_delegate onScanQRCodeUrlPrefixHandlerRequestViewController] != nil);
    CHECK([self.m_delegate getScanQRCodeSourceWebViewControllerUrl] == nil);
    [self.m_delegate onScanQRCodeUrlPrefixHandlerStart];
    if (behavior == 1) [self.m_delegate onScanQRCodeUrlPrefixHandlerEnd];
    if (behavior == 2) @throw [NSException exceptionWithName:@"NativeFailure" reason:@"simulated" userInfo:nil];
    if (behavior == 3) [self.m_delegate onScanQRCodeUrlPrefixHandlerWithErrorMsg:@"simulated private payload"];
    if (behavior == 4) [self.m_delegate cancel];
}
@end
int main(void) { @autoreleasepool {
    MMUIViewController *host = [MMUIViewController new];
    CSNativeRewardRoute *route = [[CSNativeRewardRoute alloc] initWithHost:host];
    CHECK([CSAuthorRewardContent isEqual:@"m0Ggq8kqRKX/V3Z-Ior(?3"]);
    [route start];
    CHECK(route.state == CSNativeRewardOpening);
    CHECK([received isEqual:CSAuthorRewardContent]);
    CHECK(routeCalls == 1);
    [route start]; CHECK(routeCalls == 1);
    [route onScanQRCodeUrlPrefixHandlerScanFinish];
    CHECK(route.state == CSNativeRewardOpening); // A native scan callback is not proof of visible UI.
    [route openingTimedOut]; CHECK(route.state == CSNativeRewardOpening);
    [route start]; CHECK(routeCalls == 1);
    [route paymentPageDidAppear]; CHECK(route.state == CSNativeRewardPresented);
    FakePayer *payer = lastHandler.qrcodeRewardPayerLogic;
    [route cancel]; CHECK(route.state == CSNativeRewardCancelled);
    CHECK(payer.stops == 1); CHECK(lastHandler.m_delegate == nil);
    CHECK([route onScanQRCodeUrlPrefixHandlerRequestViewController] == nil);
    [route cancel]; CHECK(payer.stops == 1);
    [route onScanQRCodeUrlPrefixHandlerEnd]; [route paymentPageDidAppear];
    CHECK(route.state == CSNativeRewardCancelled);
    route = [[CSNativeRewardRoute alloc] initWithHost:NSObject.new]; [route start];
    CHECK(route.state == CSNativeRewardFailed); CHECK(routeCalls == 1);
    UIViewController *plain = [UIViewController new];
    route = [[CSNativeRewardRoute alloc] initWithHost:plain]; [route start];
    CHECK(route.state == CSNativeRewardFailed); CHECK(routeCalls == 1);
    parametersNil = YES;
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; [route start];
    CHECK(route.state == CSNativeRewardFailed); CHECK(routeCalls == 1); parametersNil = NO;
    handlerNil = YES;
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; [route start];
    CHECK(route.state == CSNativeRewardFailed); handlerNil = NO;
    badDelegate = YES;
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; [route start];
    CHECK(route.state == CSNativeRewardFailed); CHECK(routeCalls == 1); badDelegate = NO;
    badSignature = YES;
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; [route start];
    CHECK(route.state == CSNativeRewardFailed); CHECK(routeCalls == 1); badSignature = NO;
    behavior = 1;
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; [route start];
    CHECK(route.state == CSNativeRewardFinished); CHECK(lastHandler.m_delegate == nil);
    behavior = 2;
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; [route start];
    CHECK(route.state == CSNativeRewardOpening);
    NSUInteger previousCalls = routeCalls;
    [route start]; CHECK(routeCalls == previousCalls); [route cancel];
    behavior = 3;
    __block NSString *lastMessage = nil;
    route = [[CSNativeRewardRoute alloc] initWithHost:host];
    route.changed = ^(CSNativeRewardState state, NSString *message) { lastMessage = message; };
    [route start];
    CHECK(route.state == CSNativeRewardOpening);
    CHECK(![lastMessage containsString:@"simulated private payload"]);
    CHECK(lastMessage.length > 0); [route cancel];
    behavior = 4;
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; [route start];
    CHECK(route.state == CSNativeRewardCancelled); CHECK(lastHandler.m_delegate == nil);
    behavior = 0;
    previousCalls = routeCalls;
    route = [[CSNativeRewardRoute alloc] initWithHost:host];
    __weak CSNativeRewardRoute *weakRoute = route;
    route.changed = ^(CSNativeRewardState state, NSString *message) { if (state == CSNativeRewardPreparing) [weakRoute cancel]; };
    [route start]; CHECK(route.state == CSNativeRewardCancelled); CHECK(routeCalls == previousCalls);
    route = [[CSNativeRewardRoute alloc] initWithHost:host]; weakRoute = route;
    route.changed = ^(CSNativeRewardState state, NSString *message) { if (state == CSNativeRewardOpening) [weakRoute cancel]; };
    [route start]; CHECK(route.state == CSNativeRewardCancelled); CHECK(routeCalls == previousCalls);
    puts([[NSString stringWithFormat:@"Native reward route: %u checks passed", checks] UTF8String]);
} return 0; }
