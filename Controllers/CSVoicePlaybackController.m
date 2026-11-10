#import "CSVoicePlaybackController.h"
#include <math.h>
#include <limits.h>

NSNotificationName const CSVoicePlaybackStateDidChangeNotification = @"CSVoicePlaybackStateDidChangeNotification";

@interface CSVoicePlaybackSnapshot ()
@property(nonatomic) NSUInteger generation;
@property(nonatomic) NSTimeInterval currentTime, duration;
@property(nonatomic) BOOL canSeek;
@end
@implementation CSVoicePlaybackSnapshot @end

static BOOL CSPlaybackSameMessage(id first, id second) {
    if (!first || !second) return NO;
    if (first == second) return YES;
    @try {
        return CSMessageNativeSupports(first,@"IsSameMsg:",@"B",@[@"@"]) &&
            [CSMessageNativeInvoke(first,@"IsSameMsg:",@[second]) boolValue];
    } @catch (__unused NSException *exception) { return NO; }
}

@interface CSVoicePlaybackController () {
    id<CSMessageActionEnvironment> _environment;
    CSVoicePlaybackPreferences *_preferences;
    id _facade, _message;
    NSString *_accountID;
    NSUInteger _generation;
    NSTimer *_timer;
    NSArray *_observers;
    BOOL _inBackground, _seeking, _accountSuspended;
}
@end

@implementation CSVoicePlaybackController
+ (instancetype)sharedController {
    static CSVoicePlaybackController *controller;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        controller=[[self alloc] initWithEnvironment:[CSMessageNativeEnvironment new]
            preferences:CSVoicePlaybackPreferences.sharedPreferences];
    });
    return controller;
}
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment
    preferences:(CSVoicePlaybackPreferences *)preferences {
    if ((self=[super init])) {
        _environment=environment; _preferences=preferences; _generation=1;
        __weak typeof(self) weakSelf=self;
        NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
        id settings=[center addObserverForName:CSVoicePlaybackSettingsDidChangeNotification object:preferences
            queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) {
                [weakSelf invalidate];
            }];
        id background=[center addObserverForName:@"UIApplicationDidEnterBackgroundNotification" object:nil
            queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) {
                typeof(self) strongSelf=weakSelf; if (!strongSelf) return;
                strongSelf->_inBackground=YES; [strongSelf invalidate];
            }];
        id foreground=[center addObserverForName:@"UIApplicationDidBecomeActiveNotification" object:nil
            queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) {
                typeof(self) strongSelf=weakSelf; if (!strongSelf) return;
                strongSelf->_inBackground=NO; [strongSelf publish];
            }];
        id account=[center addObserverForName:@"CSMessageActionAccountStateDidChangeNotification" object:nil
            queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) {
                typeof(self) strongSelf=weakSelf; if (!strongSelf) return;
                if (CSMessageNativeSupports(note.object,@"accountID",@"@",@[])) {
                    id accountID=CSMessageNativeInvoke(note.object,@"accountID",@[]);
                    strongSelf->_accountSuspended=![accountID isKindOfClass:NSString.class] || ![accountID length];
                }
                [strongSelf invalidate];
            }];
        _observers=@[settings,background,foreground,account];
    }
    return self;
}
- (void)publish {
    [NSNotificationCenter.defaultCenter postNotificationName:CSVoicePlaybackStateDidChangeNotification object:self];
}
- (void)startTimerIfNeeded {
    if (_timer) return;
    __weak typeof(self) weakSelf=self;
    _timer=[NSTimer timerWithTimeInterval:0.15 repeats:YES block:^(__unused NSTimer *timer) {
        typeof(self) strongSelf=weakSelf; if (!strongSelf) return;
        if (![strongSelf snapshotForMessage:strongSelf->_message]) [strongSelf invalidate];
        else [strongSelf publish];
    }];
    _timer.tolerance=0.03;
    [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (BOOL)facade:(id)facade isPlayingMessage:(id)message {
    if (!message || CSMessageNativeUnsigned(message,@"m_uiMessageType")!=34) return NO;
    if (!CSMessageNativeSupports(facade,@"currentPlayingMsg",@"@",@[]) ||
        !CSMessageNativeSupports(facade,@"isMsgPlaying:",@"B",@[@"@"])) return NO;
    id current=CSMessageNativeInvoke(facade,@"currentPlayingMsg",@[]);
    return CSPlaybackSameMessage(current,message) &&
        [CSMessageNativeInvoke(facade,@"isMsgPlaying:",@[message]) boolValue];
}
- (CSVoicePlaybackSnapshot *)snapshotForMessage:(id)message {
    if (!NSThread.isMainThread || !_preferences.progressEnabled || _inBackground || _accountSuspended || !message) return nil;
    @try {
        NSString *account=[_environment currentAccountID];
        if (!account.length) return nil;
        // A freshly obtained account-bound service wrapper preserves WeChat's
        // forwarding context. Never unwrap it or call its implementation pointer.
        id facade=[_environment serviceNamed:@"MsgPlayingFacade"];
        if (![self facade:facade isPlayingMessage:message] ||
            !CSMessageNativeSupports(facade,@"currentPlayTime",@"i",@[]) ||
            !CSMessageNativeSupports(facade,@"seekToTime:",@"v",@[@"I"])) return nil;
        unsigned long long milliseconds=CSMessageNativeUnsigned(message,@"m_uiVoiceTime");
        int current=[CSMessageNativeInvoke(facade,@"currentPlayTime",@[]) intValue];
        if (!milliseconds || milliseconds>3600000 || current<0) return nil;
        if (![_accountID isEqualToString:account] || !CSPlaybackSameMessage(_message,message)) {
            _generation++; _accountID=[account copy]; _message=message;
        }
        _facade=facade;
        CSVoicePlaybackSnapshot *snapshot=[CSVoicePlaybackSnapshot new];
        snapshot.generation=_generation;
        snapshot.duration=(double)milliseconds/1000.0;
        snapshot.currentTime=MIN((double)current/1000.0,snapshot.duration);
        snapshot.canSeek=YES;
        [self startTimerIfNeeded];
        return snapshot;
    } @catch (__unused NSException *exception) { return nil; }
}
- (BOOL)seekToTime:(NSTimeInterval)seconds message:(id)message generation:(NSUInteger)generation {
    if (!NSThread.isMainThread || _seeking || !isfinite(seconds) || !generation || generation!=_generation) return NO;
    CSVoicePlaybackSnapshot *snapshot=[self snapshotForMessage:message];
    if (!snapshot.canSeek || snapshot.generation!=generation) return NO;
    // Keep the endpoint inside the last decodable packet. Codec seek granularity
    // belongs to WeChat (SILK/OPUS 100 ms, AMR/SPX whole seconds).
    double clamped=MAX(0.0,MIN(seconds,MAX(0.0,snapshot.duration-0.1)));
    unsigned int milliseconds=(unsigned int)MIN(floor(clamped*1000.0),(double)UINT_MAX);
    BOOL submitted=NO;
    _seeking=YES;
    @try {
        if (_preferences.progressEnabled && [self facade:_facade isPlayingMessage:message] &&
            [_accountID isEqualToString:[_environment currentAccountID]]) {
            // Consume before the native call: an exception may follow an actual
            // cursor update, so the same drag must never be submitted again.
            _generation++;
            CSMessageNativeInvoke(_facade,@"seekToTime:",@[@(milliseconds)]);
            submitted=YES;
        }
    } @catch (__unused NSException *exception) {}
    @finally { _seeking=NO; }
    [self publish];
    return submitted;
}
- (void)messageDidBegin:(id)message {
    if (!NSThread.isMainThread) return;
    if ([self snapshotForMessage:message]) [self publish];
}
- (void)messageDidEnd:(id)message {
    if (NSThread.isMainThread && CSPlaybackSameMessage(_message,message)) [self invalidate];
}
- (void)invalidate {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf invalidate]; });
        return;
    }
    [_timer invalidate]; _timer=nil; _facade=nil; _message=nil; _accountID=nil; _generation++;
    [self publish];
}
- (void)dealloc {
    [_timer invalidate];
    for (id observer in _observers) [NSNotificationCenter.defaultCenter removeObserver:observer];
}
@end
