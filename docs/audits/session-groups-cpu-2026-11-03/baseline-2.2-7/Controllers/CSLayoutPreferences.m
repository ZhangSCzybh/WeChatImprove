#import "CSLayoutPreferences.h"
#import <CoreFoundation/CoreFoundation.h>
#include <stdatomic.h>
#include <stdint.h>
#include <string.h>

// Pack the original floatForKey values into one coherent snapshot (17pt, 1x).
static atomic_uint_fast64_t CSLayoutPacked=ATOMIC_VAR_INIT(UINT64_C(0x418800003f800000));
static atomic_uint_fast64_t CSLayoutRevision;
static NSUserDefaults *CSLayoutDefaults;
static NSObject *CSLayoutPublicationLock;
CSLayoutValues CSLayoutPreferencesRead(void) {
    uint64_t bits=atomic_load_explicit(&CSLayoutPacked,memory_order_acquire);
    uint32_t fontBits=(uint32_t)(bits>>32),scaleBits=(uint32_t)bits;
    float font,scale;memcpy(&font,&fontBits,sizeof(font));memcpy(&scale,&scaleBits,sizeof(scale));
    return (CSLayoutValues){font,scale};
}
void CSLayoutPreferencesReload(void) {
    if (!CSLayoutDefaults) return;
    uint64_t revision=atomic_fetch_add_explicit(&CSLayoutRevision,1,memory_order_acq_rel)+1;
    // Never query Defaults under the publication lock: a Defaults notification
    // may synchronously arrive on another thread while these reads are in progress.
    float font=[CSLayoutDefaults floatForKey:@"font.chat_size"];
    float scale=[CSLayoutDefaults floatForKey:@"global.scale"];
    if (font<8 || font>25) font=17;
    if (scale<.5 || scale>2) scale=1;
    uint32_t fontBits,scaleBits;memcpy(&fontBits,&font,sizeof(font));memcpy(&scaleBits,&scale,sizeof(scale));
    @synchronized(CSLayoutPublicationLock) {
        if (revision==atomic_load_explicit(&CSLayoutRevision,memory_order_acquire))
            atomic_store_explicit(&CSLayoutPacked,((uint64_t)fontBits<<32)|scaleBits,memory_order_release);
    }
}
static void CSLayoutDarwinChanged(__unused CFNotificationCenterRef center,__unused void *observer,__unused CFStringRef name,__unused const void *object,__unused CFDictionaryRef info) {
    CSLayoutPreferencesReload();
}
void CSLayoutPreferencesInstall(NSUserDefaults *defaults) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSLayoutPublicationLock=[NSObject new];CSLayoutDefaults=defaults;
        for (NSString *name in @[NSUserDefaultsDidChangeNotification,@"com.wechat.tweak.local_settings_changed",
            @"CSBackupAccountChanged",@"CSBackupResourcesChanged",@"UIApplicationDidBecomeActiveNotification"]) {
            [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
                CSLayoutPreferencesReload();
            }];
        }
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,CSLayoutDarwinChanged,
            CFSTR("com.wechat.enhance.settings_changed"),NULL,CFNotificationSuspensionBehaviorCoalesce);
        CSLayoutPreferencesReload();
    });
}
