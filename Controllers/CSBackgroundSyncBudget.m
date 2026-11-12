#import "CSBackgroundSyncBudget.h"
#import "CSBackupBootstrap.h"
#include <math.h>

static const NSTimeInterval CSBackgroundSyncBudgetInterval=45;

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
- (BOOL)sampleForEpoch:(NSUInteger)epoch time:(NSTimeInterval *)time {
    if(![self prepareEpoch:epoch])return NO;
    NSTimeInterval value=NAN;self.readingClock=YES;
    @try {if(self.now)value=self.now();}
    @catch(__unused NSException *exception) {value=NAN;}
    @finally {self.readingClock=NO;}
    // Revalidate after the injected clock boundary. Keep the global clock
    // watermark and attempt budget even when the active account changes.
    if(![self prepareEpoch:epoch] || !isfinite(value) || value<0 ||
       !isfinite(value+CSBackgroundSyncBudgetInterval) || value+CSBackgroundSyncBudgetInterval<=value ||
       (self.hasObservedTime && value<self.lastObservedTime))return NO;
    self.hasObservedTime=YES;self.lastObservedTime=value;*time=value;return YES;
}
- (NSTimeInterval)delayAtTime:(NSTimeInterval)time {
    NSTimeInterval deadline=time;
    if(self.attempted)deadline=MAX(deadline,self.lastAttempt+CSBackgroundSyncBudgetInterval);
    if(self.verified)deadline=MAX(deadline,self.lastVerified+CSBackgroundSyncBudgetInterval);
    NSTimeInterval delay=deadline-time;
    return isfinite(delay)?MAX(0,delay):CSBackgroundSyncBudgetInterval;
}
- (NSTimeInterval)nextDelayForEpoch:(NSUInteger)epoch {
    NSTimeInterval time=0;
    return [self sampleForEpoch:epoch time:&time]?[self delayAtTime:time]:CSBackgroundSyncBudgetInterval;
}
- (BOOL)performForEpoch:(NSUInteger)epoch request:(void (^)(void))request {
    if(!request)return NO;
    NSTimeInterval time=0;
    if(![self sampleForEpoch:epoch time:&time] || [self delayAtTime:time]>0 || epoch!=CSBackupAccountEpoch())return NO;
    // Reserve before the native boundary. Reentry, native rejection and native
    // exceptions retain this attempt; the original request exception propagates.
    self.attempted=YES;self.lastAttempt=time;
    request();return YES;
}
- (void)verifiedFullSyncForEpoch:(NSUInteger)epoch {
    NSTimeInterval time=0;
    if(![self sampleForEpoch:epoch time:&time])return;
    self.verified=YES;self.lastVerified=time;
}
@end
