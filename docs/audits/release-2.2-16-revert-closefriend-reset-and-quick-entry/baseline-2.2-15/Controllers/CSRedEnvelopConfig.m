#import "CSRedEnvelopConfig.h"
#import "CSPaymentAutomation.h"
#import "CSPreferenceRefresh.h"
static atomic_bool summaryEnabled, summaryPending;
static void CSReloadSummary(void) {
    atomic_store(&summaryEnabled,[NSUserDefaults.standardUserDefaults boolForKey:@"com.wechat.enhance.redenvelop.pageSummary"]);
}
@implementation CSRedEnvelopConfig
+ (instancetype)sharedConfig {
    static CSRedEnvelopConfig *config; static dispatch_once_t once;
    dispatch_once(&once,^{ config=[CSRedEnvelopConfig new]; CSReloadSummary();
        [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil usingBlock:^(__unused NSNotification *n){
            CSRequestMainRefresh(&summaryPending,^{ CSReloadSummary(); });
        }]; }); return config;
}
- (void)reload { CSRequestMainRefresh(&summaryPending,^{ CSReloadSummary(); }); CSPaymentReload(); }
- (BOOL)receiveDonePageSummaryEnable { return atomic_load(&summaryEnabled); }
- (NSInteger)totalReceiveCount { return [NSUserDefaults.standardUserDefaults integerForKey:@"com.wechat.enhance.redenvelop.totalCount"]; }
- (long long)totalReceiveAmount { return [[NSUserDefaults.standardUserDefaults objectForKey:@"com.wechat.enhance.redenvelop.totalAmount"] longLongValue]; }
- (void)resetReceiveRecordsWithCompletion:(dispatch_block_t)completion { CSPaymentResetEnvelopeStatistics(completion); }
@end
