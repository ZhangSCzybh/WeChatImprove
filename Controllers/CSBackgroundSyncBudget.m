#import "CSBackgroundSyncBudget.h"
#import "CSBackupBootstrap.h"
#include <math.h>

static const NSTimeInterval CSBackgroundSyncBudgetInterval=45;
static const NSTimeInterval CSBackgroundSyncBudgetMinimumInterval=10;

static BOOL CSBackgroundSyncBudgetValidInterval(NSTimeInterval interval) {
    return isfinite(interval) && interval>=CSBackgroundSyncBudgetMinimumInterval && interval<=CSBackgroundSyncBudgetInterval;
}

@interface CSBackgroundSyncBudget ()
@property(nonatomic) BOOL attempted,verified,hasEpoch,hasObservedTime,readingClock;
@property(nonatomic) NSUInteger currentEpoch;
@property(nonatomic) NSTimeInterval lastAttempt,lastVerified,lastObservedTime;
@end

@implementation CSBackgroundSyncBudget
+ (instancetype)sharedBudget {
    static CSBackgroundSyncBudget *budget;static dispatch_once_t once;
    dispatch_once(&once,^{budget=[self new];});return budget;
}
- (instancetype)init {
    if((self=[super init]))_now=^{return NSProcessInfo.processInfo.systemUptime;};
    return self;
}
- (BOOL)prepareEpoch:(NSUInteger)epoch {
    if(!NSThread.isMainThread || self.readingClock || epoch!=CSBackupAccountEpoch())return NO;
    if(!self.hasEpoch || self.currentEpoch!=epoch){
        self.hasEpoch=YES;self.currentEpoch=epoch;
        self.verified=NO;self.lastVerified=0;
    }
    return YES;
}
- (BOOL)sampleForEpoch:(NSUInteger)epoch minimumInterval:(NSTimeInterval)minimumInterval time:(NSTimeInterval *)time {
    if(![self prepareEpoch:epoch])return NO;
    NSTimeInterval value=NAN;self.readingClock=YES;
    @try {if(self.now)value=self.now();}
    @catch(__unused NSException *exception) {value=NAN;}
    @finally {self.readingClock=NO;}
    // Revalidate after the injected clock boundary. Keep the global clock
    // watermark and attempt budget even when the active account changes.
    if(![self prepareEpoch:epoch] || !isfinite(value) || value<0 ||
       !isfinite(value+minimumInterval) || value+minimumInterval<=value ||
       (self.hasObservedTime && value<self.lastObservedTime))return NO;
    self.hasObservedTime=YES;self.lastObservedTime=value;*time=value;return YES;
}
- (NSTimeInterval)delayAtTime:(NSTimeInterval)time minimumInterval:(NSTimeInterval)minimumInterval {
    NSTimeInterval deadline=time;
    if(self.attempted)deadline=MAX(deadline,self.lastAttempt+minimumInterval);
    if(self.verified)deadline=MAX(deadline,self.lastVerified+minimumInterval);
    NSTimeInterval delay=deadline-time;
    return isfinite(delay)?MAX(0,delay):CSBackgroundSyncBudgetInterval;
}
- (NSTimeInterval)nextDelayForEpoch:(NSUInteger)epoch {
    return [self nextDelayForEpoch:epoch minimumInterval:CSBackgroundSyncBudgetInterval];
}
- (NSTimeInterval)nextDelayForEpoch:(NSUInteger)epoch minimumInterval:(NSTimeInterval)minimumInterval {
    if(!CSBackgroundSyncBudgetValidInterval(minimumInterval))return CSBackgroundSyncBudgetInterval;
    NSTimeInterval time=0;
    return [self sampleForEpoch:epoch minimumInterval:minimumInterval time:&time]?[self delayAtTime:time minimumInterval:minimumInterval]:CSBackgroundSyncBudgetInterval;
}
- (BOOL)performForEpoch:(NSUInteger)epoch request:(void (^)(void))request {
    return [self performForEpoch:epoch minimumInterval:CSBackgroundSyncBudgetInterval request:request];
}
- (BOOL)performForEpoch:(NSUInteger)epoch minimumInterval:(NSTimeInterval)minimumInterval request:(void (^)(void))request {
    if(!request || !CSBackgroundSyncBudgetValidInterval(minimumInterval))return NO;
    NSTimeInterval time=0;
    if(![self sampleForEpoch:epoch minimumInterval:minimumInterval time:&time] || [self delayAtTime:time minimumInterval:minimumInterval]>0 || epoch!=CSBackupAccountEpoch())return NO;
    // Reserve before the native boundary. Reentry, native rejection and native
    // exceptions retain this attempt; the original request exception propagates.
    self.attempted=YES;self.lastAttempt=time;
    request();return YES;
}
- (void)verifiedFullSyncForEpoch:(NSUInteger)epoch {
    NSTimeInterval time=0;
    if(![self sampleForEpoch:epoch minimumInterval:CSBackgroundSyncBudgetInterval time:&time])return;
    self.verified=YES;self.lastVerified=time;
}
@end
