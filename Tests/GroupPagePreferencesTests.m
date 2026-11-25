#import <Foundation/Foundation.h>
#import "CSGroupAppearance.h"

static NSUInteger checks, failures;
static void Check(BOOL value, NSString *message) {
    checks++;
    if (!value) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}

int main(void) { @autoreleasepool {
    NSString *suite=[@"com.wechat.improve.tests.page-preferences." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Check(!CSGroupPageTransitionEnabled(defaults),@"page transitions remain disabled until explicitly enabled");
    Check(![defaults objectForKey:CSGroupPageTransitionEnabledKey],@"reading the page transition default does not write a preference");
    for (NSNumber *enabled in @[@YES,@NO]) {
        [defaults setBool:enabled.boolValue forKey:CSGroupPageTransitionEnabledKey];
        Check(CSGroupPageTransitionEnabled([[NSUserDefaults alloc] initWithSuiteName:suite])==enabled.boolValue,
            @"the independent page transition choice survives a new preference instance");
    }
    for (id invalid in @[@"YES",@"1",@{},@[],@2,@(-1),@0.5,@(NAN),@(INFINITY)]) {
        [defaults setObject:invalid forKey:CSGroupPageTransitionEnabledKey];
        Check(!CSGroupPageTransitionEnabled(defaults),@"invalid page transition preferences cannot enable motion");
    }
    [defaults setBool:YES forKey:CSGroupPageTransitionEnabledKey];
    CSGroupSetIndicatorStyle(defaults,CSGroupIndicatorStyleNone);
    Check(CSGroupPageTransitionEnabled(defaults),@"disabling the indicator animation preserves the independent page transition choice");
    [defaults setBool:NO forKey:CSGroupPageTransitionEnabledKey];
    Check(CSGroupCurrentIndicatorStyle(defaults)==CSGroupIndicatorStyleNone,@"the page transition switch does not change the indicator style");
    [defaults removePersistentDomainForName:suite];
    printf("Group page preferences: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
