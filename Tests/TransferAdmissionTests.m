#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSPreferenceRefresh.h"
static NSUInteger nativeCalls, handled, checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#x); return 1; } } while(0)
@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic,copy) NSString *m_nsContent;
@property(nonatomic,strong) id m_oWCPayInfoItem;
@end
@implementation CMessageWrap @end
@interface PayInfo : NSObject
@property(nonatomic,copy) NSString *m_c2cNativeUrl;
@end
@implementation PayInfo @end
static NSUserDefaults *isolated;
static id Defaults(id object, SEL selector) { (void)object; (void)selector; return isolated; }
static void cs_handleTransferMessage(CMessageWrap *wrap) { (void)wrap; handled++; }
#import "TransferAdmissionUnderTest.h"
static void pump(void) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:.03]; while (end.timeIntervalSinceNow>0) [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:end]; }
int main(void) { @autoreleasepool {
    NSString *suite=[@"transfer.test." stringByAppendingString:NSUUID.UUID.UUIDString];
    isolated=[[NSUserDefaults alloc] initWithSuiteName:suite];
    method_setImplementation(class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults)),(IMP)Defaults);
    TestMessageMgr *manager=[TestMessageMgr new]; CMessageWrap *wrap=[CMessageWrap new]; wrap.m_uiMessageType=49; wrap.m_nsContent=@"transfer";
    CSReloadTransferAdmission();
    for (NSUInteger i=0;i<1000;i++) [manager AsyncOnAddMsg:@"chat" MsgWrap:wrap];
    pump(); CHECK(nativeCalls==1000 && handled==0);
    [isolated setBool:YES forKey:kReceiveTransferAutoEnableKey];
    [isolated setBool:NO forKey:kReceiveTransferGroupEnableKey];
    CSReloadTransferAdmission(); CHECK(!CSIsTransferCandidate(wrap));
    [isolated setBool:YES forKey:kReceiveTransferPrivateEnableKey]; CSReloadTransferAdmission(); CHECK(CSIsTransferCandidate(wrap));
    wrap.m_nsContent=@"ordinary shared article";
    for (NSUInteger i=0;i<1000;i++) [manager AddMsg:@"chat" MsgWrap:wrap];
    pump(); CHECK(nativeCalls==2000 && handled==0);
    wrap.m_nsContent=@"<appmsg><title>转账</title></appmsg>";
    [manager AddMsg:@"chat" MsgWrap:wrap]; pump(); CHECK(handled==1);
    wrap.m_nsContent=nil; PayInfo *pay=[PayInfo new];pay.m_c2cNativeUrl=@"weixin://Transfer/receive";wrap.m_oWCPayInfoItem=pay;
    [manager AsyncOnAddMsg:@"chat" MsgWrap:wrap]; pump(); CHECK(handled==2 && nativeCalls==2002);
    wrap.m_uiMessageType=1; CHECK(!CSIsTransferCandidate(wrap));
    [isolated removePersistentDomainForName:suite];
    printf("Transfer admission: %lu checks passed; native callbacks preserved, no payment services invoked\n",(unsigned long)checks);
} return 0; }
