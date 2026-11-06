#import <Foundation/Foundation.h>
#import "CSPaymentCore.h"
#import "CSPaymentLedger.h"
static NSUInteger checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#c); exit(1); } } while(0)
static NSString *XML(NSString *extra) { return [NSString stringWithFormat:@"payer:\n<msg><appmsg><wcpayinfo><transferid><![CDATA[id-1]]></transferid><paysubtype>1</paysubtype>%@</wcpayinfo></appmsg></msg>",extra?:@""]; }
static NSDictionary *Native(NSString *receiver) { return @{@"id":@"id-1",@"payer":@"payer",@"receiver":receiver,@"subtype":@1}; }
static CSPaymentTask *Task(NSInteger i, BOOL env, double ready) {
    CSPaymentTask *t=[CSPaymentTask new]; t.key=[NSString stringWithFormat:@"%ld",(long)i]; t.account=@"self"; t.session=@"group@chatroom"; t.payload=@{}; t.envelope=env; t.readyAt=ready; t.deadline=ready+30; return t;
}
static void RunUntil(BOOL (^done)(void)) {
    NSDate *end=[NSDate dateWithTimeIntervalSinceNow:8];
    while (!done() && end.timeIntervalSinceNow>0) [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.01]];
    CHECK(done());
}
int main(void) { @autoreleasepool {
    CHECK(CSPaymentTransferFields(XML(nil),Native(@"self"),@"self",@"payer",@"self"));
    CHECK(CSPaymentTransferFields(XML(nil),Native(@"self"),@"self",@"group@chatroom",@"self"));
    CHECK(!CSPaymentTransferFields(XML(nil),Native(@"other"),@"self",@"group@chatroom",@"self"));
    CHECK(!CSPaymentTransferFields(XML(@"<receiver_username>other</receiver_username>"),Native(@"self"),@"self",@"group@chatroom",@"self"));
    CHECK(!CSPaymentTransferFields(XML(nil),Native(@"self"),@"self",@"self",@"payer"));
    CHECK(!CSPaymentTransferFields(XML(nil),Native(@"self"),@"self",@"payer",@"other"));
    CHECK(!CSPaymentTransferFields(XML(nil),@{@"subtype":@3,@"payer":@"payer",@"receiver":@"self"},@"self",@"group@chatroom",@"self"));
    CHECK(!CSPaymentTransferFields(@"<msg><wcpayinfo><transferid>id</transferid></wcpayinfo></msg>",@{@"payer":@"payer",@"receiver":@"self"},@"self",@"payer",@"self"));
    CHECK(!CSPaymentTransferFields(XML(@"<paysubtype>3</paysubtype>"),Native(@"self"),@"self",@"payer",@"self"));
    CHECK(!CSPaymentTransferFields(XML(@"<receiver_username><x>self</x></receiver_username>"),Native(@"self"),@"self",@"payer",@"self"));
    CHECK(!CSPaymentTransferFields(XML(@"<invalidtime>-1</invalidtime>"),Native(@"self"),@"self",@"payer",@"self"));
    CHECK([CSPaymentTransferFields(XML(@"<invalidtime><![CDATA[86400]]></invalidtime>"),Native(@"self"),@"self",@"payer",@"self")[@"invalidtime"] isEqual:@86400]);
    CHECK(!CSPaymentTransferFields(@"<!DOCTYPE msg [<!ENTITY x 'self'>]><msg/>",Native(@"self"),@"self",@"payer",@"self"));
    CHECK(!CSPaymentTransferFields(@"<msg>",Native(@"self"),@"self",@"payer",@"self"));
    // Private transfer cards omit group-only payer/receiver properties.
    CHECK(CSPaymentTransferFields(XML(nil),@{@"id":@"id-1",@"subtype":@0},@"self",@"payer",@"self"));
    CHECK(!CSPaymentTransferFields(XML(nil),@{@"id":@"id-1",@"subtype":@0},@"self",@"group@chatroom",@"self"));
    CHECK(!CSPaymentTransferFields(XML(@"<receiver_username>other</receiver_username>"),@{@"subtype":@0},@"self",@"payer",@"self"));
    for (id value in @[NSNull.null,@[],@{},@"",@"1.2",@1.2,@"9223372036854775808",@"1e3",@"1oops"]) CHECK(!CSPaymentInteger(value));
    CHECK([CSPaymentInteger(@"9223372036854775807") isEqual:@(LLONG_MAX)]);
    CHECK([CSPaymentInteger(@"-9223372036854775808") isEqual:@(LLONG_MIN)]);
    CHECK(!CSPaymentErrorsOK(@{@"retcode":NSNull.null}));
    CHECK(CSPaymentErrorsOK(@{@"amount":@100}));
    CHECK(!CSPaymentErrorsOK(@{@"retcode":@0,@"wx_error_type":@1,@"amount":@100}));
    CHECK(CSPaymentErrorsOK(@{@"retcode":@"0",@"amount":@100}));
    CHECK(!CSPaymentQuery(@"sendId=a&sendId=b"));
    CHECK([CSPaymentQuery(@"sendId=a&nativeUrl=wxpay%3A%2F%2Fexample")[@"nativeUrl"] isEqual:@"wxpay://example"]);
    CHECK(!CSPaymentRequestMatches(@{@"sendId":@"a",@"sign":@"s"},@{@"sendId":@"b",@"sign":@"s"}));
    CHECK(!CSPaymentRequestMatches(@{@"sendId":@"a",@"sign":@"s"},@{@"sendId":@"a",@"sign":NSNull.null}));
    CHECK(![CSPaymentBusinessKey(@"a",@"b",@"c|d",@"e") isEqual:CSPaymentBusinessKey(@"a",@"b",@"c",@"d|e")]);

    CSPaymentTaskStore *store=[CSPaymentTaskStore new];
    for (NSInteger i=0;i<1000;i++) CHECK([store add:Task(i,YES,100) now:100]==(i<256));
    CHECK(store.tasks.count==256);
    for (NSInteger i=0;i<1000;i++) CHECK(![store add:Task(0,YES,100) now:100]);
    CSPaymentTask *first=[store nextAt:100 serial:YES]; CHECK(first!=nil); first.phase=CSPaymentQuerying;
    CHECK(![store nextAt:100 serial:YES]);
    first.phase=CSPaymentReady; first.readyAt=100;
    CHECK([store nextAt:100 serial:YES]==first); first.phase=CSPaymentOpening;
    CHECK(![store nextAt:100 serial:YES]);
    [store finish:first now:100]; [store finish:first now:100]; CHECK(store.tasks.count==255);
    CHECK(![store add:Task(0,YES,101) now:101]);
    for (NSInteger i=0;i<5;i++) { CSPaymentTask *t=[store nextAt:101 serial:NO]; CHECK(t!=nil); t.phase=CSPaymentOpening; }
    CHECK(![store nextAt:101 serial:NO]); CHECK(![store nextAt:101 serial:YES]);
    for (CSPaymentTask *t in store.tasks) if (t.phase==CSPaymentOpening) [store finish:t now:101];
    CHECK([store nextAt:101 serial:YES]);
    CHECK([store expireAt:10000].count==250); CHECK(!store.tasks.count); CHECK([store nextWakeAt:10000]==DBL_MAX);
    store=[CSPaymentTaskStore new];
    for (NSInteger i=0;i<140;i++) CHECK([store add:Task(i,NO,200) now:100]==(i<128));
    CHECK(![store nextAt:199 serial:NO]); CHECK([store nextWakeAt:100]==200);
    CSPaymentTask *verifying=[store nextAt:200 serial:NO]; verifying.phase=CSPaymentVerifying;
    CHECK(![store nextAt:200 serial:NO]); // A pending receipt retains the transfer concurrency slot.
    CHECK([store nextWakeAt:200]==230);
    CHECK([store expireAt:231].count==128);

    NSString *suite=[@"payment-core-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    [defaults setInteger:7 forKey:@"kReceiveTransferTotalCountKey"]; [defaults setObject:@12345 forKey:@"kReceiveTransferTotalAmountKey"];
    NSURL *dir=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:suite]];
    NSURL *file=[dir URLByAppendingPathComponent:@"ledger.plist"];
    CSPaymentLedger *ledger=[[CSPaymentLedger alloc] initWithURL:file defaults:defaults];
    __block BOOL loaded=NO; [ledger load:^{ loaded=YES; }]; RunUntil(^BOOL{ return loaded; });
    CHECK(ledger.ready); CHECK([ledger.totals[@"kReceiveTransferTotalCountKey"] isEqual:@7]);
    CHECK([NSFileManager.defaultManager fileExistsAtPath:[[dir URLByAppendingPathComponent:@"payment-statistics-before-v1.plist"] path]]);
    __block NSInteger completions=0, successes=0;
    for (NSInteger i=0;i<5;i++) [ledger recordKey:@"same-success" envelope:NO cents:250 currency:@"CNY" completion:^(BOOL ok){ completions++; successes+=ok; }];
    RunUntil(^BOOL{ return completions==5; }); CHECK(successes==1); CHECK([ledger.totals[@"kReceiveTransferTotalAmountKey"] isEqual:@12595]);
    CSPaymentLedger *restart=[[CSPaymentLedger alloc] initWithURL:file defaults:defaults]; loaded=NO;
    [restart load:^{loaded=YES;}]; RunUntil(^BOOL{ return loaded; }); CHECK([restart containsKey:@"same-success"]);
    __block BOOL reset=NO; [restart resetEnvelopes:^{reset=YES;}]; RunUntil(^BOOL{ return reset; }); CHECK([restart containsKey:@"same-success"]);
    CHECK([restart.totals[@"kReceiveTransferTotalCountKey"] isEqual:@8]);
    [@"bad" writeToURL:file atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    CSPaymentLedger *broken=[[CSPaymentLedger alloc] initWithURL:file defaults:defaults]; loaded=NO;
    [broken load:^{loaded=YES;}]; RunUntil(^BOOL{ return loaded; }); CHECK(!broken.ready);
    CHECK([defaults integerForKey:@"kReceiveTransferTotalCountKey"]==8);
    [defaults removePersistentDomainForName:suite]; [NSFileManager.defaultManager removeItemAtURL:dir error:NULL];
    printf("Payment core: %lu checks passed\n",(unsigned long)checks);
} return 0; }
