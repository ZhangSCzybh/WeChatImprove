#import "CSPaymentLedger.h"
#import "CSPaymentCore.h"
#import <limits.h>
NSString *const CSPaymentStatisticsDidChangeNotification=@"CSPaymentStatisticsDidChange";
static NSString *const TC=@"kReceiveTransferTotalCountKey", *const TA=@"kReceiveTransferTotalAmountKey";
static NSString *const EC=@"com.wechat.enhance.redenvelop.totalCount", *const EA=@"com.wechat.enhance.redenvelop.totalAmount";
@interface CSPaymentLedger ()
@property NSURL *url;
@property NSUserDefaults *defaults;
@property dispatch_queue_t io;
@property NSMutableDictionary *events;
@property(nonatomic, readwrite) NSDictionary *totals;
@property(nonatomic, readwrite) BOOL ready;
@end
@implementation CSPaymentLedger
- (instancetype)initWithURL:(NSURL *)u defaults:(NSUserDefaults *)d {
    if ((self=[super init])) { _url=u; _defaults=d; _io=dispatch_queue_create("com.wechat.improve.payment-ledger",DISPATCH_QUEUE_SERIAL); _events=[NSMutableDictionary dictionary]; _totals=@{}; }
    return self;
}
- (BOOL)write:(NSDictionary *)state to:(NSURL *)url {
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:state format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
    return data && [data writeToURL:url options:NSDataWritingAtomic error:NULL];
}
- (void)load:(dispatch_block_t)completion {
    dispatch_async(self.io,^{
        NSFileManager *fm=NSFileManager.defaultManager;
        BOOL ok=[fm createDirectoryAtURL:[self.url URLByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:NULL];
        BOOL exists=[fm fileExistsAtPath:self.url.path];
        NSDictionary *state=[NSDictionary dictionaryWithContentsOfURL:self.url];
        if (!exists && ok) {
            NSMutableDictionary *old=[NSMutableDictionary dictionary];
            for (NSString *key in @[TC,TA,EC,EA]) old[key]=CSPaymentInteger([self.defaults objectForKey:key])?:@0;
            NSURL *backup=[[self.url URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"payment-statistics-before-v1.plist"];
            if (![fm fileExistsAtPath:backup.path]) ok=[self write:old to:backup];
            state=@{@"version":@1,@"totals":old,@"events":@{}};
            if (ok) ok=[self write:state to:self.url];
        }
        ok=ok && [state[@"version"] isEqual:@1] && [state[@"totals"] isKindOfClass:NSDictionary.class] && [state[@"events"] isKindOfClass:NSDictionary.class];
        if (ok) {
            for (NSString *key in @[TC,TA,EC,EA]) if (!CSPaymentInteger(state[@"totals"][key])) ok=NO;
            if ([state[@"events"] count]>2048) ok=NO;
            for (id key in state[@"events"]) if (!CSPaymentString(key) || ![state[@"events"][key] isKindOfClass:NSNumber.class]) ok=NO;
        }
        dispatch_async(dispatch_get_main_queue(),^{
            self.ready=ok;
            if (ok) { self.totals=state[@"totals"]; self.events=[state[@"events"] mutableCopy]; [self mirror]; }
            if (completion) completion();
        });
    });
}
- (void)mirror {
    for (NSString *key in @[TC,TA,EC,EA]) [self.defaults setObject:self.totals[key]?:@0 forKey:key];
    [NSNotificationCenter.defaultCenter postNotificationName:CSPaymentStatisticsDidChangeNotification object:self];
}
- (BOOL)containsKey:(NSString *)key { return self.events[key]!=nil; }
- (void)persist:(void (^)(BOOL))completion {
    NSDictionary *state=@{@"version":@1,@"totals":[self.totals copy],@"events":[self.events copy]};
    dispatch_async(self.io,^{
        BOOL ok=[self write:state to:self.url];
        dispatch_async(dispatch_get_main_queue(),^{
            if (!ok) self.ready=NO; // fail closed; keep the in-memory duplicate fence
            if (ok) [self mirror];
            completion(ok);
        });
    });
}
- (void)recordKey:(NSString *)key envelope:(BOOL)e cents:(long long)c currency:(NSString *)currency completion:(void (^)(BOOL))completion {
    if (!self.ready || [self containsKey:key] || c<=0) { completion(NO); return; }
    NSMutableDictionary *totals=[self.totals mutableCopy];
    NSString *countKey=e?EC:TC, *amountKey=e?EA:TA;
    long long count=[totals[countKey] longLongValue], amount=[totals[amountKey] longLongValue];
    if (count==LLONG_MAX || ([currency isEqual:@"CNY"] && amount>LLONG_MAX-c)) { completion(NO); return; }
    totals[countKey]=@(count+1);
    if ([currency isEqual:@"CNY"]) totals[amountKey]=@(amount+c);
    self.totals=[totals copy];
    NSTimeInterval now=NSDate.date.timeIntervalSince1970;
    for (NSString *old in self.events.allKeys) if ([self.events[old] doubleValue]<now-7*86400) [self.events removeObjectForKey:old];
    self.events[key]=@(now);
    if (self.events.count>2048) [self.events removeObjectForKey:[self.events keysSortedByValueUsingSelector:@selector(compare:)].firstObject];
    // The durable event is also the intent to emit effects. A crash between this
    // write and AddMsg can miss a reply, but must not replay it on restart.
    [self persist:completion];
}
- (void)resetEnvelopes:(dispatch_block_t)completion {
    if (!self.ready) { if (completion) completion(); return; }
    NSMutableDictionary *totals=[self.totals mutableCopy]; totals[EC]=@0; totals[EA]=@0; self.totals=totals;
    [self persist:^(__unused BOOL ok){ if (completion) completion(); }];
}
@end
