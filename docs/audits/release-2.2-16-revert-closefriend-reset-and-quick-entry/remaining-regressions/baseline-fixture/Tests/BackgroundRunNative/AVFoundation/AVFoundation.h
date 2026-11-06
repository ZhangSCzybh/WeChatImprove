#import <Foundation/Foundation.h>
typedef NSUInteger AVAudioSessionCategoryOptions;
typedef NSUInteger AVAudioSessionSetActiveOptions;
typedef NSUInteger AVAudioSessionRouteSharingPolicy;
enum { AVAudioSessionCategoryOptionMixWithOthers=1, AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation=1, AVAudioSessionRouteSharingPolicyDefault=0 };
enum { AVAudioSessionInterruptionTypeEnded=0, AVAudioSessionInterruptionTypeBegan=1, AVAudioSessionInterruptionOptionShouldResume=1 };
extern NSString *const AVAudioSessionCategoryAmbient, *const AVAudioSessionCategorySoloAmbient, *const AVAudioSessionCategoryPlayback, *const AVAudioSessionCategoryPlayAndRecord, *const AVAudioSessionModeDefault;
extern NSNotificationName const AVAudioSessionInterruptionNotification, AVAudioSessionMediaServicesWereLostNotification, AVAudioSessionMediaServicesWereResetNotification, AVAudioSessionRouteChangeNotification;
extern NSString *const AVAudioSessionInterruptionTypeKey, *const AVAudioSessionInterruptionOptionKey;
@interface AVAudioSession : NSObject
+ (instancetype)sharedInstance;
@property(nonatomic, copy) NSString *category, *mode;
@property(nonatomic) AVAudioSessionCategoryOptions categoryOptions;
@property(nonatomic) AVAudioSessionRouteSharingPolicy routeSharingPolicy;
@property(nonatomic) BOOL active;
@property(nonatomic) BOOL failCategory, failActivation, failDeactivation, throwCategory;
@property(nonatomic) NSUInteger configurations, activations, deactivations;
@property(nonatomic, copy) dispatch_block_t activationAction;
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
extern BOOL CSTestFailPlayerCreation, CSTestFailPlayerPlay;
@interface AVAudioPlayer : NSObject
@property(nonatomic, weak) id<AVAudioPlayerDelegate> delegate;
@property(nonatomic) NSInteger numberOfLoops;
@property(nonatomic, getter=isPlaying) BOOL playing;
- (instancetype)initWithData:(NSData *)data error:(NSError **)error;
- (BOOL)play;
- (void)stop;
@end
