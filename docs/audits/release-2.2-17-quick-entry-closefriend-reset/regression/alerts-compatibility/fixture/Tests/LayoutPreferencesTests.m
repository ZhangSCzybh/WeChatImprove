#import <Foundation/Foundation.h>
#import "CSLayoutPreferences.h"
#include <stdatomic.h>
#include <stdlib.h>
static NSUInteger checks;
static atomic_uint reads;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__);exit(1); } } while(0)
@interface LayoutDefaults : NSUserDefaults
@property(nonatomic) float testFont,testScale;
@end
@implementation LayoutDefaults
- (float)floatForKey:(NSString *)key {
    atomic_fetch_add_explicit(&reads,1,memory_order_relaxed);
    NSNumber *threadValue=NSThread.currentThread.threadDictionary[key];
    if (threadValue) return threadValue.floatValue;
    return [key isEqualToString:@"font.chat_size"] ? self.testFont : self.testScale;
}
@end
int main(void) { @autoreleasepool {
    // Dedicated suite and a read-only spy; production/shared preference data is untouched.
    NSString *suite=[@"LayoutSnapshotTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    LayoutDefaults *defaults=[[LayoutDefaults alloc] initWithSuiteName:suite];
    CSLayoutValues values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==17 && values.globalScale==1);
    CSLayoutPreferencesInstall(defaults);
    values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==17 && values.globalScale==1);
    defaults.testFont=20;defaults.testScale=1.25;
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
    values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==20 && values.globalScale==1.25);
    unsigned initialReads=atomic_load_explicit(&reads,memory_order_relaxed);
    for (NSUInteger i=0;i<10000;i++) {
        values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==20 && values.globalScale==1.25);
    }
    CHECK(initialReads==atomic_load_explicit(&reads,memory_order_relaxed));
    for (NSString *name in @[@"com.wechat.tweak.local_settings_changed",@"CSBackupAccountChanged",@"CSBackupResourcesChanged",@"UIApplicationDidBecomeActiveNotification"]) {
        defaults.testFont=23;defaults.testScale=.75;
        [NSNotificationCenter.defaultCenter postNotificationName:name object:nil];
        values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==23 && values.globalScale==.75);
        defaults.testFont=20;defaults.testScale=1.25;CSLayoutPreferencesReload();
    }
    defaults.testFont=7;defaults.testScale=2.1;CSLayoutPreferencesReload();
    values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==17 && values.globalScale==1);
    defaults.testFont=26;defaults.testScale=.49;CSLayoutPreferencesReload();
    values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==17 && values.globalScale==1);
    defaults.testFont=8;defaults.testScale=.5;CSLayoutPreferencesReload();
    values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==8 && values.globalScale==.5);
    defaults.testFont=25;defaults.testScale=2;CSLayoutPreferencesReload();
    values=CSLayoutPreferencesRead();CHECK(values.chatFontSize==25 && values.globalScale==2);
    // Concurrent reload/read publication never exposes partially packed values.
    atomic_bool valid=ATOMIC_VAR_INIT(true);atomic_bool *validPointer=&valid;
    dispatch_apply(8,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^(size_t worker) {
        // Independent writers supply whole, distinct pairs; readers may see either
        // complete publication while refreshes race, never a font/scale mixture.
        NSMutableDictionary *threadValues=NSThread.currentThread.threadDictionary;
        threadValues[@"font.chat_size"]=worker%4==0 ? @8 : @25;
        threadValues[@"global.scale"]=worker%4==0 ? @.5 : @2;
        for (NSUInteger i=0;i<2000;i++) {
            if (worker%2==0) CSLayoutPreferencesReload();
            CSLayoutValues pair=CSLayoutPreferencesRead();
            BOOL whole=(pair.chatFontSize==25 && pair.globalScale==2) || (pair.chatFontSize==8 && pair.globalScale==.5);
            if (!whole) atomic_store_explicit(validPointer,false,memory_order_relaxed);
        }
        [threadValues removeObjectForKey:@"font.chat_size"];[threadValues removeObjectForKey:@"global.scale"];
    });
    CHECK(atomic_load_explicit(&valid,memory_order_relaxed));
    printf("PASS: %lu layout preference snapshot checks (read spy, immediate refresh, concurrent publication)\n",(unsigned long)checks);
} return 0; }
