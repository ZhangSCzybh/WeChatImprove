#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "CSVoicePlaybackPreferences.h"
#import "CSMessageActionPreferences.h"
#include <stdio.h>
#include <stdlib.h>

static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)
static void Drain(void) {
    NSDate *until=[NSDate dateWithTimeIntervalSinceNow:.03];
    while ([until timeIntervalSinceNow]>0) [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:until];
}
@interface PlaybackDefaults : NSUserDefaults
@property(nonatomic) NSUInteger writes;
@property(nonatomic) NSUInteger reads;
@property(nonatomic, strong) NSMutableSet *readKeys;
@end
@implementation PlaybackDefaults
- (id)objectForKey:(NSString *)key { self.reads++; [self.readKeys addObject:key]; return [super objectForKey:key]; }
- (void)setObject:(id)value forKey:(NSString *)key { self.writes++; [super setObject:value forKey:key]; }
- (void)registerDefaults:(NSDictionary *)values { self.writes++; [super registerDefaults:values]; }
@end

int main(void) { @autoreleasepool {
    NSString *suite=[@"VoicePlaybackPreferencesTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    PlaybackDefaults *defaults=[[PlaybackDefaults alloc] initWithSuiteName:suite];
    [defaults removePersistentDomainForName:suite]; defaults.readKeys=[NSMutableSet set];
    NSUInteger writes=defaults.writes;
    CSVoicePlaybackPreferences *preferences=[[CSVoicePlaybackPreferences alloc] initWithDefaults:defaults];
    CHECK(!preferences.progressEnabled);
    CHECK([CSVoicePlaybackProgressEnabledKey isEqual:@"com.wechat.enhance.voice_playback.progress_enabled"]);
    CHECK([defaults.readKeys isEqual:[NSSet setWithObject:CSVoicePlaybackProgressEnabledKey]]);
    CHECK(defaults.writes==writes && [defaults persistentDomainForName:suite].count==0);

    __block NSUInteger notifications=0;
    __block BOOL mainDelivery=YES,correctObject=YES;
    __weak CSVoicePlaybackPreferences *weakPreferences=preferences;
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSVoicePlaybackSettingsDidChangeNotification object:preferences queue:nil
        usingBlock:^(NSNotification *note){ notifications++; mainDelivery &= NSThread.isMainThread; correctObject &= note.object==weakPreferences; }];
    CSMessageActionPreferences *actions=[[CSMessageActionPreferences alloc] initWithDefaults:defaults];
    NSUInteger actionVersion=actions.snapshot.version;
    [defaults setBool:YES forKey:CSMessageActionVoiceForwardEnabledKey];
    [defaults setBool:YES forKey:CSMessageActionFavoriteVoiceForwardEnabledKey];
    [actions requestRefresh]; Drain();
    CHECK(actions.snapshot.voiceForwardEnabled && actions.snapshot.favoriteVoiceForwardEnabled);
    CHECK(actions.snapshot.version==actionVersion+1 && notifications==0);
    actionVersion=actions.snapshot.version;

    // Progress refreshes independently and never invalidates action snapshots.
    [defaults setBool:YES forKey:CSVoicePlaybackProgressEnabledKey];
    for (NSUInteger i=0;i<50;i++) [preferences requestRefresh];
    [actions requestRefresh]; Drain();
    CHECK(preferences.progressEnabled && notifications==1);
    CHECK(actions.snapshot.version==actionVersion);
    CHECK(actions.snapshot.voiceForwardEnabled && actions.snapshot.favoriteVoiceForwardEnabled);
    [defaults setBool:NO forKey:CSVoicePlaybackProgressEnabledKey];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults]; Drain();
    CHECK(!preferences.progressEnabled && notifications==2);
    CHECK(actions.snapshot.version==actionVersion);
    [defaults setBool:YES forKey:CSVoicePlaybackProgressEnabledKey];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),(__bridge CFStringRef)CSMessageActionVoiceForwardDarwinNotification,NULL,NULL,true);
    Drain();
    CHECK(preferences.progressEnabled && notifications==3);
    [defaults setBool:NO forKey:CSVoicePlaybackProgressEnabledKey];
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil]; Drain();
    CHECK(!preferences.progressEnabled && notifications==4);
    CHECK(actions.snapshot.version==actionVersion);

    // Irrelevant defaults/voice-forward changes emit no playback notifications.
    [defaults setObject:@"keep" forKey:@"host.sentinel"];
    [defaults setBool:NO forKey:CSMessageActionVoiceForwardEnabledKey];
    [defaults setBool:NO forKey:CSMessageActionFavoriteVoiceForwardEnabledKey];
    [preferences requestRefresh]; [actions requestRefresh]; Drain();
    CHECK(!preferences.progressEnabled && notifications==4);
    CHECK(!actions.snapshot.voiceForwardEnabled && !actions.snapshot.favoriteVoiceForwardEnabled);
    actionVersion=actions.snapshot.version;
    NSUInteger readCount=defaults.reads;
    for (NSUInteger i=0;i<1000;i++) (void)preferences.progressEnabled;
    CHECK(defaults.reads==readCount);

    // Import replaces a domain; activation observes it without feature-specific writes.
    [defaults setPersistentDomain:@{CSVoicePlaybackProgressEnabledKey:@YES,@"host.sentinel":@"keep"} forName:suite];
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil]; Drain();
    CHECK(preferences.progressEnabled && notifications==5);
    CHECK(actions.snapshot.version==actionVersion);
    CHECK([[defaults objectForKey:@"host.sentinel"] isEqual:@"keep"]);
    [defaults removeObjectForKey:CSVoicePlaybackProgressEnabledKey];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults]; Drain();
    CHECK(!preferences.progressEnabled && notifications==6);
    CHECK([[defaults objectForKey:@"host.sentinel"] isEqual:@"keep"]);

    // Off-main observers/requests always publish changed values on main.
    [defaults setBool:YES forKey:CSVoicePlaybackProgressEnabledKey];
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        for (NSUInteger i=0;i<100;i++) [preferences requestRefresh];
        [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
    });
    CHECK(dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    Drain();
    CHECK(preferences.progressEnabled && notifications==7);
    CHECK(mainDelivery && correctObject);
    writes=defaults.writes;
    [preferences requestRefresh]; Drain();
    CHECK(notifications==7 && defaults.writes==writes);

    // A queued weak refresh must not keep a discarded test instance alive.
    // Existing delivered notifications can retain their object until pool drain.
    __weak CSVoicePlaybackPreferences *temporaryWeak;
    @autoreleasepool {
        CSVoicePlaybackPreferences *temporary=[[CSVoicePlaybackPreferences alloc] initWithDefaults:defaults];
        temporaryWeak=temporary;
        [temporary requestRefresh];
    }
    CHECK(temporaryWeak==nil);
    [NSNotificationCenter.defaultCenter removeObserver:observer];
    [preferences requestRefresh]; preferences=nil;
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:defaults];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),(__bridge CFStringRef)CSMessageActionVoiceForwardDarwinNotification,NULL,NULL,true);
    Drain();
    CHECK(notifications==7);
    [defaults removePersistentDomainForName:suite];
    printf("Voice playback preferences passed (%lu checks)\n",(unsigned long)checks);
} return 0; }
