#import <Foundation/Foundation.h>
#import "CSBackgroundRunPolicy.h"

static NSUInteger checks;
static void Check(BOOL condition,NSString *message) {
    checks++;if(!condition){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}
}
static NSDate *Instant(NSString *value) {
    static NSISO8601DateFormatter *formatter;static dispatch_once_t once;
    dispatch_once(&once,^{formatter=[NSISO8601DateFormatter new];});
    NSDate *date=[formatter dateFromString:value];Check(date!=nil,[@"parse instant " stringByAppendingString:value]);return date;
}
static NSCalendar *Calendar(NSString *zone) {
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone=[NSTimeZone timeZoneWithName:zone];return calendar;
}
static NSDictionary *Window(NSInteger start,NSInteger end) {
    NSMutableDictionary *policy=[CSBackgroundRunDefaultPolicy() mutableCopy];
    policy[@"allDay"]=@NO;policy[@"startMinute"]=@(start);policy[@"endMinute"]=@(end);return policy;
}
static void Allows(NSDictionary *policy,NSString *date,NSCalendar *calendar,BOOL expected,NSString *message) {
    Check(CSBackgroundRunPolicyAllowsDate(policy,Instant(date),calendar)==expected,message);
}
static void Next(NSDictionary *policy,NSString *from,NSString *expected,NSCalendar *calendar,NSString *message) {
    NSDate *date=Instant(from),*want=Instant(expected),*actual=CSBackgroundRunPolicyNextBoundary(policy,date,calendar);
    if(!actual||fabs([actual timeIntervalSinceDate:want])>=0.0001) {
        fprintf(stderr,"Expected %s, got %s\n",want.description.UTF8String,actual.description.UTF8String);
        Check(NO,message);
    }
    Check([actual compare:date]==NSOrderedDescending,message);
    Check(CSBackgroundRunPolicyAllowsDate(policy,[actual dateByAddingTimeInterval:-0.001],calendar)!=CSBackgroundRunPolicyAllowsDate(policy,actual,calendar),@"next boundary changes the allowed state");
}
static void Validation(void) {
    NSDictionary *defaults=CSBackgroundRunDefaultPolicy(),*legacy=CSBackgroundRunLegacyPolicy();NSError *error=nil;
    Check([CSBackgroundRunPolicyKey isEqual:@"BackgroundRunPolicy"],@"stable legacy-suite preference identity");
    Check([defaults isEqual:@{@"version":@1,@"allDay":@YES,@"startMinute":@480,@"endMinute":@1380,@"maxMinutes":@30,@"energySaving":@YES}],@"fresh default is all-day, thirty minutes, energy saving");
    Check([legacy[@"allDay"] boolValue]&&[legacy[@"maxMinutes"] integerValue]==0&&![legacy[@"energySaving"] boolValue],@"legacy preserves all-day unlimited operation");
    Check(CSBackgroundRunValidatePolicy(defaults,&error)&&!error&&CSBackgroundRunValidatePolicy(legacy,NULL),@"default and legacy policies validate");
    for(NSString *key in defaults) {
        NSMutableDictionary *missing=[defaults mutableCopy];[missing removeObjectForKey:key];
        Check(!CSBackgroundRunValidatePolicy(missing,&error)&&error!=nil,@"every field is required");
    }
    NSMutableDictionary *extra=[defaults mutableCopy];extra[@"unknown"]=@YES;
    Check(!CSBackgroundRunValidatePolicy(extra,NULL),@"unknown fields are rejected");
    Check(!CSBackgroundRunValidatePolicy(nil,NULL)&&!CSBackgroundRunValidatePolicy(@[],NULL)&&!CSBackgroundRunValidatePolicy(@"policy",NULL),@"non-dictionaries are rejected");
    NSDictionary *invalid=@{@"version":@[@0,@2,@YES,@1.0,@"1"],@"allDay":@[@0,@1,@1.0,@"YES"],@"energySaving":@[@0,@1,@"NO"],@"startMinute":@[@(-1),@1440,@YES,@480.0,@"480"],@"endMinute":@[@(-1),@1440,@NO,@1380.0],@"maxMinutes":@[@(-1),@1,@10,@121,@YES,@30.0]};
    for(NSString *key in invalid)for(id value in invalid[key]) {
        NSMutableDictionary *bad=[defaults mutableCopy];bad[key]=value;
        Check(!CSBackgroundRunValidatePolicy(bad,&error)&&error!=nil,[NSString stringWithFormat:@"strict field validation %@=%@",key,value]);
    }
    for(NSNumber *duration in @[@0,@5,@15,@30,@60,@120]) {
        NSMutableDictionary *valid=[defaults mutableCopy];valid[@"maxMinutes"]=duration;
        Check(CSBackgroundRunValidatePolicy(valid,NULL),@"only supported duration choices are accepted");
    }
    Check(!CSBackgroundRunValidatePolicy(Window(480,480),NULL),@"a specified window cannot have equal endpoints");
    NSMutableDictionary *allDay=[defaults mutableCopy];allDay[@"endMinute"]=allDay[@"startMinute"];
    Check(CSBackgroundRunValidatePolicy(allDay,&error)&&!error,@"all-day policy allows unused equal endpoints and clears old error");
    Check([CSBackgroundRunPolicyWindowDescription(defaults) isEqual:@"全天"],@"all-day description");
    Check([CSBackgroundRunPolicyWindowDescription(Window(480,1380)) isEqual:@"08:00–23:00"],@"same-day description");
    Check([CSBackgroundRunPolicyWindowDescription(Window(1380,480)) isEqual:@"23:00–次日08:00"],@"overnight description");
    Check(!CSBackgroundRunPolicyAllowsDate(@{},Instant(@"2026-10-30T00:00:00Z"),Calendar(@"Asia/Shanghai"))&&CSBackgroundRunPolicyNextBoundary(@{},Instant(@"2026-10-30T00:00:00Z"),Calendar(@"Asia/Shanghai"))==nil,@"invalid policies fail closed");
}
static void OrdinaryWindows(void) {
    NSCalendar *shanghai=Calendar(@"Asia/Shanghai"),*utc=Calendar(@"UTC");NSDictionary *day=Window(480,1380),*night=Window(1380,480);
    Allows(day,@"2026-10-29T23:59:59Z",shanghai,NO,@"before daytime start");
    Allows(day,@"2026-10-30T00:00:00Z",shanghai,YES,@"start is inclusive");
    Allows(day,@"2026-10-30T14:59:59Z",shanghai,YES,@"last second before end remains allowed");
    Allows(day,@"2026-10-30T15:00:00Z",shanghai,NO,@"end is exclusive");
    Allows(day,@"2026-10-30T00:00:00Z",utc,NO,@"supplied calendar time zone determines the window");
    Next(day,@"2026-10-29T23:59:59Z",@"2026-10-30T00:00:00Z",shanghai,@"next same-day start");
    Next(day,@"2026-10-30T00:00:00Z",@"2026-10-30T15:00:00Z",shanghai,@"strictly future boundary skips exact start");
    Next(day,@"2026-10-30T15:00:00Z",@"2026-10-31T00:00:00Z",shanghai,@"exact end advances to tomorrow start");
    Allows(night,@"2026-10-30T15:00:00Z",shanghai,YES,@"overnight start is inclusive");
    Allows(night,@"2026-10-30T17:00:00Z",shanghai,YES,@"overnight window spans midnight");
    Allows(night,@"2026-10-31T00:00:00Z",shanghai,NO,@"overnight end is exclusive");
    Next(night,@"2026-10-30T15:00:00Z",@"2026-10-31T00:00:00Z",shanghai,@"overnight next end is tomorrow");
    Next(night,@"2026-10-31T00:00:00Z",@"2026-10-31T15:00:00Z",shanghai,@"overnight end advances to next start");
    Next(Window(0,60),@"2026-10-30T23:59:59Z",@"2026-10-31T00:00:00Z",utc,@"midnight is an ordinary start boundary");
    Check(CSBackgroundRunPolicyNextBoundary(CSBackgroundRunDefaultPolicy(),Instant(@"2026-10-30T00:00:00Z"),shanghai)==nil,@"all-day policy has no time boundary");
}
static void ClockTransitions(void) {
    NSCalendar *newYork=Calendar(@"America/New_York");NSDictionary *spring=Window(150,240);
    Allows(spring,@"2026-03-08T06:59:59Z",newYork,NO,@"spring window is closed before missing start");
    Allows(spring,@"2026-03-08T07:00:00Z",newYork,YES,@"spring jump enters a window whose start was skipped");
    Next(spring,@"2026-03-08T06:50:00Z",@"2026-03-08T07:00:00Z",newYork,@"missing spring start advances to first real allowed minute");
    Next(Window(1380,150),@"2026-03-08T06:50:00Z",@"2026-03-08T07:00:00Z",newYork,@"missing spring end exits at the clock jump");
    Next(Window(130,170),@"2026-03-08T06:50:00Z",@"2026-03-09T06:10:00Z",newYork,@"an entirely skipped window waits for tomorrow");
    NSDictionary *early=Window(30,90);
    Next(early,@"2026-11-01T04:40:00Z",@"2026-11-01T05:30:00Z",newYork,@"first repeated end is the first actual exit");
    Allows(early,@"2026-11-01T05:59:59Z",newYork,NO,@"between first end and clock rollback is closed");
    Next(early,@"2026-11-01T05:30:00Z",@"2026-11-01T06:00:00Z",newYork,@"clock rollback itself re-enters an earlier window");
    Next(early,@"2026-11-01T06:00:00Z",@"2026-11-01T06:30:00Z",newYork,@"second repeated end is not skipped");
    NSDictionary *late=Window(90,150);
    Next(late,@"2026-11-01T05:45:00Z",@"2026-11-01T06:00:00Z",newYork,@"rollback can temporarily leave a window before its nominal end");
    Next(late,@"2026-11-01T06:00:00Z",@"2026-11-01T06:30:00Z",newYork,@"second repeated start re-enters the window");
    Next(Window(30,150),@"2026-11-01T05:45:00Z",@"2026-11-01T07:30:00Z",newYork,@"unchanged allowed state skips the rollback transition");
    NSCalendar *lordHowe=Calendar(@"Australia/Lord_Howe");
    Next(Window(130,180),@"2026-10-03T15:20:00Z",@"2026-10-03T15:30:00Z",lordHowe,@"half-hour spring jump opens a skipped start");
    Next(Window(100,120),@"2026-04-04T14:50:00Z",@"2026-04-04T15:00:00Z",lordHowe,@"half-hour rollback can leave the allowed window");
    Next(Window(100,120),@"2026-04-04T15:00:00Z",@"2026-04-04T15:10:00Z",lordHowe,@"half-hour repeated start is found");
    Next(Window(720,780),@"2011-12-30T09:00:00Z",@"2011-12-30T22:00:00Z",Calendar(@"Pacific/Apia"),@"a skipped calendar day advances to the next real window");
}
int main(void) {@autoreleasepool {
    Validation();OrdinaryWindows();ClockTransitions();
    printf("Background run policy: %lu checks passed\n",(unsigned long)checks);
}return 0;}
