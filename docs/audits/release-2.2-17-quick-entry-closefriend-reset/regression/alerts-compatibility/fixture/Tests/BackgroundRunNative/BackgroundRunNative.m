// These doubles exercise production state/ownership code, not iOS scheduling.
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CSBackgroundRunAudio.h"
#define NAME(n) NSString *const n=@#n
NAME(UIApplicationDidEnterBackgroundNotification); NAME(UIApplicationWillEnterForegroundNotification); NAME(UIApplicationDidBecomeActiveNotification);
NAME(UISceneDidEnterBackgroundNotification); NAME(UISceneWillEnterForegroundNotification); NAME(UISceneDidActivateNotification); NAME(UISceneDidDisconnectNotification);
NAME(AVAudioSessionCategoryAmbient); NAME(AVAudioSessionCategorySoloAmbient); NAME(AVAudioSessionCategoryPlayback); NAME(AVAudioSessionCategoryPlayAndRecord); NAME(AVAudioSessionModeDefault);
NAME(AVAudioSessionInterruptionNotification); NAME(AVAudioSessionMediaServicesWereLostNotification); NAME(AVAudioSessionMediaServicesWereResetNotification); NAME(AVAudioSessionRouteChangeNotification);
NAME(AVAudioSessionInterruptionTypeKey); NAME(AVAudioSessionInterruptionOptionKey);
@implementation UIScene @end
@implementation UIApplication
+ (instancetype)sharedApplication { static UIApplication *app; if (!app) { app=[self new]; app.connectedScenes=[NSSet set]; } return app; }
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)name expirationHandler:(void (^)(void))handler { return UIBackgroundTaskInvalid; }
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier {}
@end
@implementation AVAudioSession
+ (instancetype)sharedInstance {
    static AVAudioSession *session;
    if (!session) { session=[self new]; session.category=AVAudioSessionCategoryAmbient; session.mode=AVAudioSessionModeDefault; }
    return session;
}
// Generated from the actual Logos hook bodies, with only %orig redirected.
#import "BackgroundAudioHooksUnderTest.h"
- (BOOL)nativeCategory:(NSString *)category mode:(NSString *)mode policy:(AVAudioSessionRouteSharingPolicy)policy options:(AVAudioSessionCategoryOptions)options error:(NSError **)error {
    self.configurations++;
    if (self.throwCategory) @throw [NSException exceptionWithName:@"NativeCategoryException" reason:nil userInfo:nil];
    if (self.failCategory) { if (error) *error=[NSError errorWithDomain:@"NativeAudio" code:10 userInfo:nil]; return NO; }
    self.category=category; self.mode=mode; self.routeSharingPolicy=policy; self.categoryOptions=options;
    return YES;
}
- (BOOL)nativeMode:(NSString *)mode error:(NSError **)error { self.mode=mode; return YES; }
- (BOOL)nativeActive:(BOOL)active error:(NSError **)error {
    if (active) self.activations++; else self.deactivations++;
    if ((active && self.failActivation) || (!active && self.failDeactivation)) {
        if (error) *error=[NSError errorWithDomain:@"NativeAudio" code:11 userInfo:nil]; return NO;
    }
    self.active=active;
    if (active && self.activationAction) { dispatch_block_t action=self.activationAction; self.activationAction=nil; action(); }
    return YES;
}
@end
NSUInteger CSTestPlayerCreates, CSTestPlayerStarts, CSTestPlayerStops, CSTestPlayersAlive;
BOOL CSTestFailPlayerCreation, CSTestFailPlayerPlay;
@interface AVAudioPlayer ()
@property(nonatomic) BOOL counted;
@end
@implementation AVAudioPlayer
- (instancetype)initWithData:(NSData *)data error:(NSError **)error {
    if (CSTestFailPlayerCreation) return nil;
    if ((self=[super init])) { self.counted=YES; CSTestPlayerCreates++; CSTestPlayersAlive++; }
    return self;
}
- (void)dealloc { if (self.counted) CSTestPlayersAlive--; }
- (BOOL)play { CSTestPlayerStarts++; self.playing=!CSTestFailPlayerPlay; return self.playing; }
- (void)stop { if (self.playing) CSTestPlayerStops++; self.playing=NO; }
@end
