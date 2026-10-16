#import <Foundation/Foundation.h>
#import "CSMessageMergePolicy.h"
#include <math.h>
#include <stdlib.h>
static unsigned checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #x); exit(1); } } while (0)
static CSMessageMergeItem *item(NSString *ID) {
    CSMessageMergeItem *m = [CSMessageMergeItem new];
    m.account = @"account"; m.session = @"group@chatroom"; m.sender = @"sender"; m.identity = ID; m.eligible = YES; return m;
}
int main(void) { @autoreleasepool {
    CSMessageMergeItem *a = item(@"1"), *b = item(@"2"), *c = item(@"3");
    CHECK(CSMessageMergeCanJoin(a,b));
    CHECK(CSMessageMergeDecide(a,b,c,1).hidesIdentity);
    CHECK(!CSMessageMergeDecide(a,b,nil,1).hidesIdentity);
    CHECK(!CSMessageMergeDecide(nil,a,b,2).hidesIdentity);
    CHECK(CSMessageMergeDecide(a,b,nil,2).hidesIdentity);
    b.outgoing = YES; CHECK(!CSMessageMergeCanJoin(a,b)); b.outgoing = NO;
    b.sender = @"other"; CHECK(!CSMessageMergeCanJoin(a,b)); b.sender = @""; CHECK(!CSMessageMergeCanJoin(a,b)); b.sender = a.sender;
    b.session = @"elsewhere"; CHECK(!CSMessageMergeCanJoin(a,b)); b.session = a.session;
    b.account = @"other"; CHECK(!CSMessageMergeCanJoin(a,b)); b.account = a.account;
    b.eligible = NO; CHECK(!CSMessageMergeCanJoin(a,b)); b.eligible = YES;
    b.identity = a.identity; CHECK(!CSMessageMergeCanJoin(a,b)); b.identity = @""; CHECK(!CSMessageMergeCanJoin(a,b));
    CHECK(!CSMessageMergeCanJoin(nil,a));
    // Time and wrapper addresses are deliberately absent: burst size does not affect the decision.
    for (NSUInteger i=1; i<1000; i++) CHECK(CSMessageMergeCanJoin(item(@(i).stringValue), item(@(i+1).stringValue)));
    CHECK(CSMessageMergeSafeDelta(-12,60,4) == -4);
    CHECK(CSMessageMergeSafeDelta(-12,60,0) == 0);
    CHECK(CSMessageMergeSafeDelta(0,60,10) == 0);
    CHECK(CSMessageMergeSafeDelta(NAN,60,10) == 0);
    CHECK(CSMessageMergeSafeDelta(-20,5,100) == -4);
    for (int h=1; h<200; h++) for (int s=0; s<30; s++) CHECK(h + CSMessageMergeSafeDelta(-20,h,s) >= 1);
    CHECK(CSMessageRevokeLinkID(@"revoke_jump_9223372036854775807") == LLONG_MAX);
    for (NSString *bad in @[@"", @"revoke_jump_", @"revoke_jump_0", @"revoke_jump_-1", @"revoke_jump_1x", @"revoke_jump_ 1", @"revoke_jump_9223372036854775808"]) CHECK(CSMessageRevokeLinkID(bad) == 0);
    CHECK(CSMessageRevokeLinkID(@"revoke_jump_123") == 123);
    CHECK([CSMessageEscapeMarkup(@"<&\"'>") isEqual:@"&lt;&amp;&quot;&#39;&gt;"]);
    CHECK(CSMessageNavigationMargin(500,100) == 200);
    CHECK(CSMessageNavigationMargin(500,1000) == 0);
    CHECK(CSMessageNavigationOffset(1000,100,600,2000,50,50) == 750);
    CHECK(CSMessageNavigationOffset(0,100,600,200,50,50) == -50);
    CHECK(CSMessageNavigationOffset(1900,100,600,2000,50,50) == 1450);
    NSString *suite = [@"CSMergeTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *d = [[NSUserDefaults alloc] initWithSuiteName:suite];
    CSMessageMergeConfiguration *config = [[CSMessageMergeConfiguration alloc] initWithDefaults:d];
    CHECK(config.scope == 3 && config.spacing == 0 && !config.enabled);
    CHECK([d objectForKey:CSMessageMergeScopeKey] == nil);
    [d setDouble:0 forKey:CSMessageMergeSpacingKey]; [d setBool:YES forKey:CSMessageMergeEnabledKey]; [d setInteger:1 forKey:CSMessageMergeScopeKey];
    config = [[CSMessageMergeConfiguration alloc] initWithDefaults:d]; CHECK(config.spacing == 0); CHECK([config appliesToGroup:YES]); CHECK(![config appliesToGroup:NO]);
    for (NSNumber *legacy in @[@(-20),@(-1),@0,@4,@10]) {
        [d setDouble:legacy.doubleValue forKey:CSMessageMergeSpacingKey];
        config=[[CSMessageMergeConfiguration alloc] initWithDefaults:d];
        CHECK(config.spacingMode==(legacy.doubleValue<0 ? CSMessageSpacingCompact :
            CSMessageSpacingNormal));
        CHECK([d objectForKey:CSMessageMergeSpacingModeKey]==nil);
    }
    for (NSInteger mode=0;mode<=1;mode++) {
        [d setInteger:mode forKey:CSMessageMergeSpacingModeKey];
        config=[[CSMessageMergeConfiguration alloc] initWithDefaults:d];
        CHECK(config.spacingMode==mode);CHECK(CSMessageSpacingModeTitle(mode).length>0);
    }
    [d setInteger:2 forKey:CSMessageMergeSpacingModeKey];
    CHECK([[CSMessageMergeConfiguration alloc] initWithDefaults:d].spacingMode==CSMessageSpacingNormal);
    [d setInteger:99 forKey:CSMessageMergeSpacingModeKey];
    CHECK([[CSMessageMergeConfiguration alloc] initWithDefaults:d].spacingMode==CSMessageSpacingNormal);
    CHECK(CSMessageMergePlannedDelta(CSMessageSpacingCompact,60,30,0,0)==-25);
    CHECK(CSMessageMergePlannedDelta(CSMessageSpacingCompact,60,30,44,0)==-12);
    CHECK(CSMessageMergePlannedDelta(CSMessageSpacingCompact,60,30,44,24)==-2);
    CHECK(CSMessageMergePlannedDelta(CSMessageSpacingCompact,60,0,0,0)==0);
    CHECK(CSMessageMergePlannedDelta(CSMessageSpacingCompact,60,NAN,0,0)==0);
    CHECK(CSMessageMergePlannedDelta(CSMessageSpacingNormal,60,30,0,0)==0);
    CHECK(CSMessageMergePlannedDelta((CSMessageSpacingMode)2,60,30,0,0)==0);
    for (int height=20;height<400;height++) for (int content=10;content<=height;content+=5) {
        double delta=CSMessageMergePlannedDelta(CSMessageSpacingCompact,height,content,0,0);
        CHECK(delta>=-25 && delta<=0);
        CHECK(height+delta>=content);
        CHECK(delta==0 || height+delta>=content+4);
    }
    [d removePersistentDomainForName:suite];
    printf("PASS: %u message merge/navigation checks\n", checks);
} return 0; }
