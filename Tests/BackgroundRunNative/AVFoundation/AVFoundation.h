#import <Foundation/Foundation.h>
typedef NSUInteger AVAudioSessionCategoryOptions;
typedef NSUInteger AVAudioSessionSetActiveOptions;
typedef NSUInteger AVAudioSessionRouteSharingPolicy;
typedef NS_ENUM(NSUInteger, AVAudioSessionRouteChangeReason) {
    AVAudioSessionRouteChangeReasonUnknown=0,
    AVAudioSessionRouteChangeReasonNewDeviceAvailable=1,
    AVAudioSessionRouteChangeReasonOldDeviceUnavailable=2,
    AVAudioSessionRouteChangeReasonCategoryChange=3,
    AVAudioSessionRouteChangeReasonOverride=4,
    AVAudioSessionRouteChangeReasonWakeFromSleep=6,
    AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory=7,
    AVAudioSessionRouteChangeReasonRouteConfigurationChange=8
};
enum { AVAudioSessionCategoryOptionMixWithOthers=1, AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation=1, AVAudioSessionRouteSharingPolicyDefault=0 };
enum { AVAudioSessionInterruptionTypeEnded=0, AVAudioSessionInterruptionTypeBegan=1, AVAudioSessionInterruptionOptionShouldResume=1 };
enum { AVAudioSessionErrorCodeIsBusy=560030580 };
extern NSString *const AVAudioSessionCategoryAmbient, *const AVAudioSessionCategorySoloAmbient, *const AVAudioSessionCategoryPlayback, *const AVAudioSessionCategoryPlayAndRecord, *const AVAudioSessionModeDefault;
extern NSNotificationName const AVAudioSessionInterruptionNotification, AVAudioSessionMediaServicesWereLostNotification, AVAudioSessionMediaServicesWereResetNotification, AVAudioSessionRouteChangeNotification, AVAudioSessionSilenceSecondaryAudioHintNotification;
extern NSString *const AVAudioSessionInterruptionTypeKey, *const AVAudioSessionInterruptionOptionKey;
extern NSString *const AVAudioSessionRouteChangeReasonKey;
@interface AVAudioSession : NSObject
+ (instancetype)sharedInstance;
@property(nonatomic, copy) NSString *category, *mode;
@property(nonatomic) AVAudioSessionCategoryOptions categoryOptions;
@property(nonatomic) AVAudioSessionRouteSharingPolicy routeSharingPolicy;
@property(nonatomic) BOOL active;
@property(nonatomic) BOOL secondaryAudioShouldBeSilencedHint;
@property(nonatomic) BOOL failCategory, failActivation, failDeactivation, throwCategory;
@property(nonatomic) BOOL failDeactivationWithBusy;
@property(nonatomic) NSUInteger configurations, activations, deactivations;
@property(nonatomic, copy) dispatch_block_t activationAction;
@property(nonatomic, copy) dispatch_block_t deactivationAction;
@property(nonatomic, copy) dispatch_block_t categoryAction;
@property(nonatomic, copy) dispatch_block_t categoryReadAction;
- (BOOL)setCategory:(NSString *)category error:(NSError **)error;
- (BOOL)setCategory:(NSString *)category withOptions:(AVAudioSessionCategoryOptions)options error:(NSError **)error;
- (BOOL)setCategory:(NSString *)category mode:(NSString *)mode options:(AVAudioSessionCategoryOptions)options error:(NSError **)error;
- (BOOL)setCategory:(NSString *)category mode:(NSString *)mode routeSharingPolicy:(AVAudioSessionRouteSharingPolicy)policy options:(AVAudioSessionCategoryOptions)options error:(NSError **)error;
- (BOOL)setMode:(NSString *)mode error:(NSError **)error;
- (BOOL)setActive:(BOOL)active error:(NSError **)error;
- (BOOL)setActive:(BOOL)active withOptions:(AVAudioSessionSetActiveOptions)options error:(NSError **)error;
@end
@class AVAudioPlayer;
@protocol AVAudioPlayerDelegate <NSObject>
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;
@end
extern NSUInteger CSTestPlayerCreates, CSTestPlayerStarts, CSTestPlayerStops, CSTestPlayersAlive;
extern NSUInteger CSTestBlankResourceLookups;
extern BOOL CSTestFailPlayerCreation, CSTestFailPlayerPreparation, CSTestFailPlayerPlay, CSTestBlankResourceAvailable;
extern NSURL *CSTestLastPlayerURL;
extern __weak AVAudioPlayer *CSTestLastPlayer;
void CSTestInstallBlankBundle(void);
@interface AVAudioPlayer : NSObject
@property(nonatomic, weak) id<AVAudioPlayerDelegate> delegate;
@property(nonatomic) NSInteger numberOfLoops;
@property(nonatomic) float volume;
@property(nonatomic, getter=isPlaying) BOOL playing;
- (instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError **)error;
- (BOOL)prepareToPlay;
- (BOOL)play;
- (void)stop;
- (void)finishSuccessfully:(BOOL)flag;
@end
