#import "CSBackgroundRunPolicy.h"
#include <math.h>
#include <string.h>

NSString *const CSBackgroundRunPolicyKey=@"BackgroundRunPolicy";

NSDictionary *CSBackgroundRunDefaultPolicy(void) {
    return @{@"version":@1,@"allDay":@YES,@"startMinute":@480,@"endMinute":@1380,@"maxMinutes":@30,@"energySaving":@YES};
}
NSDictionary *CSBackgroundRunLegacyPolicy(void) {
    NSMutableDictionary *policy=[CSBackgroundRunDefaultPolicy() mutableCopy];
    policy[@"maxMinutes"]=@0;policy[@"energySaving"]=@NO;return [policy copy];
}
static BOOL PolicyBoolean(id value) {
    return [value isKindOfClass:NSNumber.class]&&CFGetTypeID((__bridge CFTypeRef)value)==CFBooleanGetTypeID();
}
static BOOL PolicyInteger(id value, NSInteger minimum, NSInteger maximum) {
    if(![value isKindOfClass:NSNumber.class]||PolicyBoolean(value))return NO;
    const char *type=[value objCType];
    if(!type||!type[0]||type[1]||!strchr("cCsSiIlLqQ",type[0]))return NO;
    double number=[value doubleValue];return isfinite(number)&&number>=minimum&&number<=maximum;
}
BOOL CSBackgroundRunValidatePolicy(id policy, NSError **error) {
    if(error)*error=nil;
    NSSet *keys=[NSSet setWithArray:@[@"version",@"allDay",@"startMinute",@"endMinute",@"maxMinutes",@"energySaving"]];
    BOOL valid=[policy isKindOfClass:NSDictionary.class]&&[[NSSet setWithArray:[policy allKeys]] isEqual:keys];
    if(valid)valid=PolicyInteger(policy[@"version"],1,1)&&PolicyBoolean(policy[@"allDay"])&&
        PolicyInteger(policy[@"startMinute"],0,1439)&&PolicyInteger(policy[@"endMinute"],0,1439)&&
        PolicyInteger(policy[@"maxMinutes"],0,120)&&[@[@0,@5,@15,@30,@60,@120] containsObject:policy[@"maxMinutes"]]&&
        PolicyBoolean(policy[@"energySaving"])&&([policy[@"allDay"] boolValue]||![policy[@"startMinute"] isEqual:policy[@"endMinute"]]);
    if(!valid&&error)*error=[NSError errorWithDomain:@"CSBackgroundRunPolicy" code:1 userInfo:@{NSLocalizedDescriptionKey:@"后台运行策略无效，请重新设置时段、持续时间和节能选项。"}];
    return valid;
}
static BOOL PolicyAllowsDate(NSDictionary *policy, NSDate *date, NSCalendar *calendar) {
    if([policy[@"allDay"] boolValue])return YES;
    NSDateComponents *components=[calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    NSInteger minute=components.hour*60+components.minute,start=[policy[@"startMinute"] integerValue],end=[policy[@"endMinute"] integerValue];
    return start<end?(minute>=start&&minute<end):(minute>=start||minute<end);
}
BOOL CSBackgroundRunPolicyAllowsDate(NSDictionary *policy, NSDate *date, NSCalendar *calendar) {
    if(!CSBackgroundRunValidatePolicy(policy,NULL)||![date isKindOfClass:NSDate.class]||!isfinite(date.timeIntervalSince1970)||![calendar isKindOfClass:NSCalendar.class])return NO;
    return PolicyAllowsDate(policy,date,calendar);
}
NSDate *CSBackgroundRunPolicyNextBoundary(NSDictionary *policy, NSDate *date, NSCalendar *calendar) {
    if(!CSBackgroundRunValidatePolicy(policy,NULL)||[policy[@"allDay"] boolValue]||![date isKindOfClass:NSDate.class]||!isfinite(date.timeIntervalSince1970)||![calendar isKindOfClass:NSCalendar.class])return nil;
    NSCalendar *local=[calendar copy];
    NSDate *horizon=[local dateByAddingUnit:NSCalendarUnitDay value:3 toDate:date options:0];
    if(!horizon)return nil;
    NSMutableSet<NSDate *> *candidates=[NSMutableSet set];
    NSCalendar *civil=[local copy];civil.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:0];
    for(NSInteger dayOffset=0;dayOffset<=3;dayOffset++) {
        NSDate *day=[local dateByAddingUnit:NSCalendarUnitDay value:dayOffset toDate:date options:0];
        if(!day)continue;
        // Resolve a civil time against both offsets around a clock change. Calendar
        // repeated-time matching can miss the second occurrence of a half-hour fold.
        NSMutableSet<NSNumber *> *offsets=[NSMutableSet set];
        for(NSNumber *distance in @[@(-129600),@0,@129600])
            [offsets addObject:@([local.timeZone secondsFromGMTForDate:[day dateByAddingTimeInterval:distance.doubleValue]])];
        for(NSString *key in @[@"startMinute",@"endMinute"]) {
            NSInteger minute=[policy[key] integerValue];
            NSDateComponents *components=[local components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:day];
            components.hour=minute/60;components.minute=minute%60;components.second=0;
            NSDate *wall=[civil dateFromComponents:components];if(!wall)continue;
            for(NSNumber *offset in offsets) {
                NSDate *candidate=[wall dateByAddingTimeInterval:-offset.doubleValue];
                if([candidate compare:date]!=NSOrderedDescending||[candidate compare:horizon]==NSOrderedDescending)continue;
                NSDateComponents *actual=[local components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:candidate];
                if([local isDate:candidate inSameDayAsDate:day]&&actual.hour==components.hour&&actual.minute==components.minute&&actual.second==0)
                    [candidates addObject:candidate];
            }
        }
    }
    // A clock jump itself can cross a window edge even when neither endpoint is
    // that local time (for example 01:59 -> 01:00 during a repeated hour).
    NSDate *cursor=date;
    for(NSUInteger attempt=0;attempt<4;attempt++) {
        NSDate *transition=[local.timeZone nextDaylightSavingTimeTransitionAfterDate:cursor];
        if(!transition||[transition compare:cursor]!=NSOrderedDescending||[transition compare:horizon]==NSOrderedDescending)break;
        [candidates addObject:transition];cursor=transition;
    }
    for(NSDate *candidate in [candidates.allObjects sortedArrayUsingSelector:@selector(compare:)])
        if(PolicyAllowsDate(policy,[candidate dateByAddingTimeInterval:-0.001],local)!=PolicyAllowsDate(policy,candidate,local))return candidate;
    return nil;
}
NSString *CSBackgroundRunPolicyWindowDescription(NSDictionary *policy) {
    if(!CSBackgroundRunValidatePolicy(policy,NULL))return @"时段设置无效";
    if([policy[@"allDay"] boolValue])return @"全天";
    NSInteger start=[policy[@"startMinute"] integerValue],end=[policy[@"endMinute"] integerValue];
    return [NSString stringWithFormat:@"%02ld:%02ld–%@%02ld:%02ld",(long)(start/60),(long)(start%60),start>end?@"次日":@"",(long)(end/60),(long)(end%60)];
}
