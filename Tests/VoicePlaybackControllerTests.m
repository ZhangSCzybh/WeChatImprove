#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "CSVoicePlaybackController.h"
#include <math.h>
#include <float.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)
#define REQUIRE(...) do { if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL invariant line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)
static void Drain(void) { [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.025]]; }
static BOOL Close(double a,double b) { return fabs(a-b)<.000001; }

@interface PlaybackMessage : NSObject {
    unsigned int _m_uiMessageType, _m_uiVoiceTime;
}
@property(nonatomic) unsigned int m_uiMessageType, m_uiVoiceTime;
@property(nonatomic, copy) NSString *identity, *owner;
@property(nonatomic) NSUInteger sourceWrites;
@property(nonatomic) BOOL throwType, throwDuration, throwIdentity;
- (BOOL)IsSameMsg:(id)message;
- (NSDictionary *)sourceState;
@end
@implementation PlaybackMessage
- (unsigned int)m_uiMessageType { if (_throwType) [NSException raise:@"TypeRead" format:@"test"]; return _m_uiMessageType; }
- (unsigned int)m_uiVoiceTime { if (_throwDuration) [NSException raise:@"DurationRead" format:@"test"]; return _m_uiVoiceTime; }
- (void)setM_uiMessageType:(unsigned int)value { _sourceWrites++; _m_uiMessageType=value; }
- (void)setM_uiVoiceTime:(unsigned int)value { _sourceWrites++; _m_uiVoiceTime=value; }
- (BOOL)IsSameMsg:(id)message {
    if (_throwIdentity) [NSException raise:@"IdentityRead" format:@"test"];
    if (![message isKindOfClass:PlaybackMessage.class]) return NO;
    PlaybackMessage *other=message;
    return [_identity isEqual:other.identity] && [_owner isEqual:other.owner];
}
- (NSDictionary *)sourceState { return @{@"type":@(_m_uiMessageType),@"duration":@(_m_uiVoiceTime),@"identity":_identity ?: @"",@"owner":_owner ?: @""}; }
@end
static PlaybackMessage *Message(NSString *identity) {
    PlaybackMessage *message=[PlaybackMessage new]; message.m_uiMessageType=34; message.m_uiVoiceTime=15000;
    message.identity=identity; message.owner=@"alice"; message.sourceWrites=0; return message;
}
@interface NoDurationMessage : NSObject
- (unsigned int)m_uiMessageType;
@end
@implementation NoDurationMessage
- (unsigned int)m_uiMessageType { return 34; }
@end
@interface ObjectDurationMessage : NoDurationMessage
- (id)m_uiVoiceTime;
@end
@implementation ObjectDurationMessage
- (id)m_uiVoiceTime { return @15000; }
@end
@interface NegativeDurationMessage : NoDurationMessage
- (int)m_uiVoiceTime;
@end
@implementation NegativeDurationMessage
- (int)m_uiVoiceTime { return -500; }
@end

// Exact 8.0.80 ABI: currentPlayTime is int32 milliseconds; seek takes uint32.
// Other player APIs are present solely to detect accidental playback side effects.
@interface PlaybackFacadeBase : NSObject
@property(nonatomic, strong) id playingMessage;
@property(nonatomic) BOOL playing, throwCurrent, throwPlaying, throwTime, throwSeek, throwAfterSeek;
@property(nonatomic) int clockMilliseconds;
@property(nonatomic) NSUInteger currentReads, playingReads, timeReads, seekAttempts, wrongABICalls, forbiddenCalls;
@property(nonatomic, strong) NSMutableArray<NSNumber *> *seekTimes;
@property(nonatomic, copy) void (^onCurrent)(void), (^onPlaying)(void), (^onTime)(void), (^onSeek)(unsigned int);
- (id)currentPlayingMsg;
- (BOOL)isMsgPlaying:(id)message;
- (void)recordSeek:(unsigned int)milliseconds;
- (void)Stop;
- (void)Start;
- (void)stop;
- (void)start;
- (void)play;
- (void)pause;
- (void)resume;
- (void)setRate:(double)value;
- (void)setPlayRate:(double)value;
- (void)setProgress:(unsigned int)value;
@end
@implementation PlaybackFacadeBase
- (instancetype)init { if ((self=[super init])) { _playing=YES; _clockMilliseconds=1250; _seekTimes=[NSMutableArray array]; } return self; }
- (id)currentPlayingMsg { _currentReads++; if (_onCurrent) _onCurrent(); if (_throwCurrent) [NSException raise:@"CurrentRead" format:@"test"]; return _playingMessage; }
- (BOOL)isMsgPlaying:(id)message {
    _playingReads++; if (_onPlaying) _onPlaying(); if (_throwPlaying) [NSException raise:@"PlayingRead" format:@"test"];
    return _playing && (_playingMessage==message || ([_playingMessage respondsToSelector:@selector(IsSameMsg:)] && [_playingMessage IsSameMsg:message]));
}
- (void)recordSeek:(unsigned int)milliseconds {
    REQUIRE(NSThread.isMainThread); _seekAttempts++;
    if (_onSeek) _onSeek(milliseconds);
    if (_throwSeek) [NSException raise:@"SeekFailed" format:@"test"];
    [_seekTimes addObject:@(milliseconds)];
    if (_throwAfterSeek) [NSException raise:@"SeekFailedAfterNativeEffect" format:@"test"];
}
- (void)Stop { _forbiddenCalls++; }
- (void)Start { _forbiddenCalls++; }
- (void)stop { _forbiddenCalls++; }
- (void)start { _forbiddenCalls++; }
- (void)play { _forbiddenCalls++; }
- (void)pause { _forbiddenCalls++; }
- (void)resume { _forbiddenCalls++; }
- (void)setRate:(double)value { (void)value; _forbiddenCalls++; }
- (void)setPlayRate:(double)value { (void)value; _forbiddenCalls++; }
- (void)setProgress:(unsigned int)value { (void)value; _forbiddenCalls++; }
@end
@interface MsgPlayingFacade : PlaybackFacadeBase
- (int)currentPlayTime;
- (void)seekToTime:(unsigned int)milliseconds;
@end
@implementation MsgPlayingFacade
- (int)currentPlayTime { self.timeReads++; if (self.onTime) self.onTime(); if (self.throwTime) [NSException raise:@"TimeRead" format:@"test"]; return self.clockMilliseconds; }
- (void)seekToTime:(unsigned int)milliseconds { [self recordSeek:milliseconds]; }
@end
@interface ObjectClockFacade : PlaybackFacadeBase
- (id)currentPlayTime;
- (void)seekToTime:(unsigned int)milliseconds;
@end
@implementation ObjectClockFacade
- (id)currentPlayTime { self.wrongABICalls++; return @1250; }
- (void)seekToTime:(unsigned int)milliseconds { [self recordSeek:milliseconds]; }
@end
@interface UnsignedClockFacade : PlaybackFacadeBase
- (unsigned int)currentPlayTime;
- (void)seekToTime:(unsigned int)milliseconds;
@end
@implementation UnsignedClockFacade
- (unsigned int)currentPlayTime { self.wrongABICalls++; return 1250; }
- (void)seekToTime:(unsigned int)milliseconds { [self recordSeek:milliseconds]; }
@end
@interface FloatingClockFacade : PlaybackFacadeBase
- (double)currentPlayTime;
- (void)seekToTime:(unsigned int)milliseconds;
@end
@implementation FloatingClockFacade
- (double)currentPlayTime { self.wrongABICalls++; return 1.25; }
- (void)seekToTime:(unsigned int)milliseconds { [self recordSeek:milliseconds]; }
@end
@interface SignedSeekFacade : PlaybackFacadeBase
- (int)currentPlayTime;
- (void)seekToTime:(int)milliseconds;
@end
@implementation SignedSeekFacade
- (int)currentPlayTime { return 1250; }
- (void)seekToTime:(int)milliseconds { (void)milliseconds; self.wrongABICalls++; }
@end
@interface FloatingSeekFacade : PlaybackFacadeBase
- (int)currentPlayTime;
- (void)seekToTime:(double)seconds;
@end
@implementation FloatingSeekFacade
- (int)currentPlayTime { return 1250; }
- (void)seekToTime:(double)seconds { (void)seconds; self.wrongABICalls++; }
@end
@interface ObjectSeekReturnFacade : PlaybackFacadeBase
- (int)currentPlayTime;
- (id)seekToTime:(unsigned int)milliseconds;
@end
@implementation ObjectSeekReturnFacade
- (int)currentPlayTime { return 1250; }
- (id)seekToTime:(unsigned int)milliseconds { (void)milliseconds; self.wrongABICalls++; return @YES; }
@end
@interface MissingClockFacade : PlaybackFacadeBase
- (void)seekToTime:(unsigned int)milliseconds;
@end
@implementation MissingClockFacade
- (void)seekToTime:(unsigned int)milliseconds { [self recordSeek:milliseconds]; }
@end
@interface MissingSeekFacade : PlaybackFacadeBase
- (int)currentPlayTime;
@end
@implementation MissingSeekFacade
- (int)currentPlayTime { return 1250; }
@end

@interface PlaybackEnvironment : NSObject <CSMessageActionEnvironment>
@property(nonatomic, copy) NSString *account;
@property(nonatomic, strong) id facade;
@property(nonatomic) NSUInteger serviceReads, accountReads;
@property(nonatomic) BOOL throwAccount, throwService;
@property(nonatomic, copy) void (^onAccount)(void), (^onService)(void);
@end
@implementation PlaybackEnvironment
- (NSString *)currentAccountID { REQUIRE(NSThread.isMainThread); _accountReads++; if (_onAccount) _onAccount(); if (_throwAccount) [NSException raise:@"AccountRead" format:@"test"]; return _account; }
- (id)serviceNamed:(NSString *)name { REQUIRE(NSThread.isMainThread && [name isEqual:@"MsgPlayingFacade"]); _serviceReads++; if (_onService) _onService(); if (_throwService) [NSException raise:@"ServiceRead" format:@"test"]; return _facade; }
- (id)controllerForCell:(id)cell { (void)cell; return nil; }
@end

@interface PlaybackAccountCoordinator : NSObject
@property(nonatomic, copy) NSString *accountID;
@end
@implementation PlaybackAccountCoordinator @end

@interface Fixture : NSObject
@property(nonatomic, copy) NSString *suite;
@property(nonatomic, strong) NSUserDefaults *defaults;
@property(nonatomic, strong) CSVoicePlaybackPreferences *preferences;
@property(nonatomic, strong) CSVoicePlaybackController *controller;
@property(nonatomic, strong) PlaybackEnvironment *environment;
@property(nonatomic, strong) MsgPlayingFacade *facade;
@property(nonatomic, strong) PlaybackMessage *message;
- (void)setEnabled:(BOOL)enabled;
- (void)close;
@end
@implementation Fixture
- (instancetype)init {
    if ((self=[super init])) {
        _suite=[@"VoicePlaybackControllerTests." stringByAppendingString:NSUUID.UUID.UUIDString];
        _defaults=[[NSUserDefaults alloc] initWithSuiteName:_suite]; [_defaults setBool:YES forKey:CSVoicePlaybackProgressEnabledKey];
        _preferences=[[CSVoicePlaybackPreferences alloc] initWithDefaults:_defaults];
        _message=Message(@"voice-1"); _facade=[MsgPlayingFacade new]; _facade.playingMessage=_message;
        _environment=[PlaybackEnvironment new]; _environment.account=@"alice"; _environment.facade=_facade;
        _controller=[[CSVoicePlaybackController alloc] initWithEnvironment:_environment preferences:_preferences];
    }
    return self;
}
- (void)setEnabled:(BOOL)enabled { [_defaults setBool:enabled forKey:CSVoicePlaybackProgressEnabledKey]; [_preferences requestRefresh]; Drain(); CHECK(_preferences.progressEnabled==enabled); }
- (void)close {
    _facade.onCurrent=nil; _facade.onPlaying=nil; _facade.onTime=nil; _facade.onSeek=nil;
    _environment.onAccount=nil; _environment.onService=nil;
    [_controller invalidate]; _controller=nil; _preferences=nil;
    [_defaults removePersistentDomainForName:_suite];
}
@end
static CSVoicePlaybackSnapshot *Snapshot(Fixture *fixture) {
    CSVoicePlaybackSnapshot *snapshot=[fixture.controller snapshotForMessage:fixture.message];
    CHECK(snapshot && snapshot.canSeek && snapshot.generation>0); return snapshot;
}

static void TestNativeMillisecondsAndReadOnly(void) {
    Fixture *f=[Fixture new]; NSDictionary *source=f.message.sourceState;
    CHECK(CSMessageNativeSupports(f.facade,@"currentPlayTime",@"i",@[]));
    CHECK(CSMessageNativeSupports(f.facade,@"seekToTime:",@"v",@[@"I"]));
    CHECK(!CSMessageNativeSupports(f.facade,@"currentPlayTime",@"d",@[]));
    CSVoicePlaybackSnapshot *snapshot=Snapshot(f);
    CHECK(Close(snapshot.currentTime,1.25) && Close(snapshot.duration,15));
    for (NSUInteger i=0;i<20;i++) { CSVoicePlaybackSnapshot *read=Snapshot(f); CHECK(read.generation==snapshot.generation); }
    CHECK(f.message.sourceWrites==0 && [f.message.sourceState isEqual:source]);
    CHECK(f.facade.seekAttempts==0 && f.facade.forbiddenCalls==0);
    CHECK([f.controller seekToTime:3.125 message:f.message generation:snapshot.generation]);
    CHECK([f.facade.seekTimes isEqual:@[@3125]]);
    CHECK(![f.controller seekToTime:5 message:f.message generation:snapshot.generation]);
    CHECK(f.facade.seekAttempts==1);
    CSVoicePlaybackSnapshot *next=Snapshot(f); CHECK(next.generation>snapshot.generation);
    CHECK(Close(snapshot.currentTime,1.25) && Close(snapshot.duration,15));
    CHECK(f.message.sourceWrites==0 && [f.message.sourceState isEqual:source]);
    CHECK(f.facade.forbiddenCalls==0);
    [f close];
}

static void TestClampAndInvalidNumbers(void) {
    Fixture *f=[Fixture new];
    NSArray *seconds=@[@(-100),@0,@(.123456),@(DBL_MAX),@15,@10000];
    NSArray *milliseconds=@[@0,@0,@123,@14900,@14900,@14900];
    for (NSUInteger i=0;i<seconds.count;i++) {
        CSVoicePlaybackSnapshot *snapshot=Snapshot(f);
        CHECK([f.controller seekToTime:[seconds[i] doubleValue] message:f.message generation:snapshot.generation]);
        CHECK([f.facade.seekTimes.lastObject isEqual:milliseconds[i]]);
    }
    CSVoicePlaybackSnapshot *token=Snapshot(f); NSUInteger calls=f.facade.seekAttempts,reads=f.environment.serviceReads;
    for (NSNumber *value in @[@(NAN),@(INFINITY),@(-INFINITY)]) CHECK(![f.controller seekToTime:value.doubleValue message:f.message generation:token.generation]);
    CHECK(f.facade.seekAttempts==calls && f.environment.serviceReads==reads);
    f.facade.clockMilliseconds=0; CHECK(Close(Snapshot(f).currentTime,0));
    f.facade.clockMilliseconds=20000; CHECK(Close(Snapshot(f).currentTime,15));
    f.message.m_uiVoiceTime=50; f.facade.clockMilliseconds=10;
    CSVoicePlaybackSnapshot *shortToken=Snapshot(f); CHECK(Close(shortToken.duration,.05));
    CHECK([f.controller seekToTime:10 message:f.message generation:shortToken.generation]);
    CHECK([f.facade.seekTimes.lastObject isEqual:@0]);
    CHECK(f.facade.forbiddenCalls==0); [f close];
}

static void TestRejectedSourcesAndABIs(void) {
    Fixture *f=[Fixture new];
    for (NSNumber *duration in @[@0,@3600001,@(UINT_MAX)]) {
        f.message.m_uiVoiceTime=duration.unsignedIntValue;
        CHECK(![f.controller snapshotForMessage:f.message]);
    }
    f.message.m_uiVoiceTime=15000; f.facade.clockMilliseconds=-1;
    CHECK(![f.controller snapshotForMessage:f.message]);
    f.facade.clockMilliseconds=1250; f.message.m_uiMessageType=1;
    CHECK(![f.controller snapshotForMessage:f.message]); f.message.m_uiMessageType=34;
    id missingMessage=nil; CHECK(![f.controller snapshotForMessage:missingMessage]);
    f.facade.playing=NO; CHECK(![f.controller snapshotForMessage:f.message]); f.facade.playing=YES;
    f.facade.playingMessage=nil; CHECK(![f.controller snapshotForMessage:f.message]); f.facade.playingMessage=f.message;
    f.environment.account=@""; CHECK(![f.controller snapshotForMessage:f.message]); f.environment.account=@"alice";
    f.environment.facade=nil; CHECK(![f.controller snapshotForMessage:f.message]);
    for (Class cls in @[ObjectClockFacade.class,UnsignedClockFacade.class,FloatingClockFacade.class,SignedSeekFacade.class,FloatingSeekFacade.class,ObjectSeekReturnFacade.class,MissingClockFacade.class,MissingSeekFacade.class]) {
        PlaybackFacadeBase *facade=[cls new]; facade.playingMessage=f.message; f.environment.facade=facade;
        CHECK(![f.controller snapshotForMessage:f.message]);
        CHECK(facade.wrongABICalls==0 && facade.seekAttempts==0 && facade.forbiddenCalls==0);
    }
    f.environment.facade=f.facade;
    for (id message in @[[NoDurationMessage new],[ObjectDurationMessage new],[NegativeDurationMessage new],[NSObject new]]) {
        f.facade.playingMessage=message;
        CHECK(![f.controller snapshotForMessage:message]);
    }
    CHECK(f.facade.seekAttempts==0 && f.facade.forbiddenCalls==0); [f close];
}

static void TestNativeExceptions(void) {
    Fixture *f=[Fixture new];
    f.message.throwType=YES; CHECK(![f.controller snapshotForMessage:f.message]); f.message.throwType=NO;
    f.message.throwDuration=YES; CHECK(![f.controller snapshotForMessage:f.message]); f.message.throwDuration=NO;
    f.environment.throwAccount=YES; CHECK(![f.controller snapshotForMessage:f.message]); f.environment.throwAccount=NO;
    f.environment.throwService=YES; CHECK(![f.controller snapshotForMessage:f.message]); f.environment.throwService=NO;
    f.facade.throwCurrent=YES; CHECK(![f.controller snapshotForMessage:f.message]); f.facade.throwCurrent=NO;
    f.facade.throwPlaying=YES; CHECK(![f.controller snapshotForMessage:f.message]); f.facade.throwPlaying=NO;
    f.facade.throwTime=YES; CHECK(![f.controller snapshotForMessage:f.message]); f.facade.throwTime=NO;
    PlaybackMessage *same=Message(@"voice-1"); same.throwIdentity=YES; f.facade.playingMessage=same;
    CHECK(![f.controller snapshotForMessage:f.message]); f.facade.playingMessage=f.message;
    CSVoicePlaybackSnapshot *token=Snapshot(f); f.facade.throwSeek=YES;
    CHECK(![f.controller seekToTime:2 message:f.message generation:token.generation]);
    CHECK(f.facade.seekAttempts==1 && f.facade.seekTimes.count==0 && f.facade.forbiddenCalls==0);
    f.facade.throwSeek=NO;
    CHECK([f.controller seekToTime:2 message:f.message generation:Snapshot(f).generation]);
    CHECK([f.facade.seekTimes isEqual:@[@2000]]); [f close];
}

static void TestIdentityAndGeneration(void) {
    Fixture *f=[Fixture new]; CSVoicePlaybackSnapshot *token=Snapshot(f);
    PlaybackMessage *same=Message(@"voice-1");
    CHECK([f.controller snapshotForMessage:same].generation==token.generation);
    CHECK([f.controller seekToTime:1 message:same generation:token.generation]);
    token=Snapshot(f); PlaybackMessage *other=Message(@"voice-2");
    CHECK(![f.controller snapshotForMessage:other]);
    CHECK(![f.controller seekToTime:1 message:other generation:token.generation]);
    f.facade.playingMessage=other;
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    CHECK(![f.controller seekToTime:1 message:other generation:token.generation]);
    CSVoicePlaybackSnapshot *otherToken=[f.controller snapshotForMessage:other]; CHECK(otherToken.generation>token.generation);
    CHECK([f.controller seekToTime:1 message:other generation:otherToken.generation]);
    f.facade.playingMessage=f.message; token=Snapshot(f);
    [f.controller invalidate];
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    CSVoicePlaybackSnapshot *fresh=Snapshot(f); CHECK(fresh.generation>token.generation);
    [f.controller messageDidEnd:other]; CHECK(Snapshot(f).generation==fresh.generation);
    [f.controller messageDidEnd:f.message]; CHECK(![f.controller seekToTime:1 message:f.message generation:fresh.generation]);
    [f.controller messageDidBegin:f.message]; CHECK(Snapshot(f).generation>fresh.generation);
    CHECK(f.facade.forbiddenCalls==0); [f close];
}

static void TestAccountSettingsAndBackground(void) {
    Fixture *f=[Fixture new]; CSVoicePlaybackSnapshot *token=Snapshot(f);
    f.environment.account=@"bob";
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    CSVoicePlaybackSnapshot *bob=Snapshot(f); CHECK(bob.generation>token.generation);
    f.environment.account=@"alice";
    CHECK(![f.controller seekToTime:1 message:f.message generation:bob.generation]);
    token=Snapshot(f); [f.controller invalidate]; // Same-account logout/login boundary.
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    token=Snapshot(f); [f setEnabled:NO];
    CHECK(![f.controller snapshotForMessage:f.message]);
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    [f setEnabled:YES];
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    token=Snapshot(f);
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidEnterBackgroundNotification" object:nil];
    CHECK(![f.controller snapshotForMessage:f.message]);
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil]; Drain();
    CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    CHECK(Snapshot(f).generation>token.generation);
    CHECK(f.facade.seekAttempts==0 && f.facade.forbiddenCalls==0); [f close];
}

static void TestReentrancyAndThreadBoundary(void) {
    Fixture *f=[Fixture new]; CSVoicePlaybackSnapshot *token=Snapshot(f);
    __block BOOL nestedAccepted=YES;
    __weak CSVoicePlaybackController *controller=f.controller;
    PlaybackMessage *message=f.message; NSUInteger generation=token.generation;
    f.facade.onSeek=^(__unused unsigned int milliseconds){ nestedAccepted=[controller seekToTime:6 message:message generation:generation]; };
    CHECK([f.controller seekToTime:1 message:f.message generation:token.generation]);
    CHECK(!nestedAccepted && f.facade.seekAttempts==1); f.facade.onSeek=nil;
    token=Snapshot(f); NSUInteger reads=f.environment.serviceReads,attempts=f.facade.seekAttempts;
    __block BOOL offMainSnapshot=YES,offMainSeek=YES;
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{
        offMainSnapshot=[controller snapshotForMessage:message]!=nil;
        offMainSeek=[controller seekToTime:5 message:message generation:token.generation];
        [controller invalidate];
    });
    CHECK(dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    CHECK(!offMainSnapshot && !offMainSeek && f.environment.serviceReads==reads && f.facade.seekAttempts==attempts);
    Drain(); CHECK(![f.controller seekToTime:1 message:f.message generation:token.generation]);
    CHECK(f.facade.forbiddenCalls==0 && f.message.sourceWrites==0); [f close];
}

static void TestNativeRevalidationRaces(void) {
    @autoreleasepool {
        Fixture *f=[Fixture new]; CSVoicePlaybackSnapshot *token=Snapshot(f);
        PlaybackMessage *other=Message(@"voice-2"); __weak MsgPlayingFacade *facade=f.facade;
        f.facade.onTime=^{ facade.playingMessage=other; };
        CHECK(![f.controller seekToTime:5 message:f.message generation:token.generation]);
        CHECK(f.facade.seekAttempts==0 && f.facade.forbiddenCalls==0); [f close];
    }
    @autoreleasepool {
        Fixture *f=[Fixture new]; CSVoicePlaybackSnapshot *token=Snapshot(f);
        __weak PlaybackEnvironment *environment=f.environment;
        NSUInteger finalAccountRead=f.environment.accountReads+2;
        f.environment.onAccount=^{ if (environment.accountReads==finalAccountRead) environment.account=@"bob"; };
        CHECK(![f.controller seekToTime:5 message:f.message generation:token.generation]);
        CHECK(f.facade.seekAttempts==0 && f.facade.forbiddenCalls==0); [f close];
    }
}

static void TestNativeExceptionConsumesToken(void) {
    Fixture *f=[Fixture new]; CSVoicePlaybackSnapshot *token=Snapshot(f);
    f.facade.throwAfterSeek=YES;
    CHECK(![f.controller seekToTime:2 message:f.message generation:token.generation]);
    CHECK(f.facade.seekAttempts==1 && [f.facade.seekTimes isEqual:@[@2000]]);
    f.facade.throwAfterSeek=NO;
    CHECK(![f.controller seekToTime:3 message:f.message generation:token.generation]);
    CHECK(f.facade.seekAttempts==1 && [f.facade.seekTimes isEqual:@[@2000]]);
    CHECK(f.facade.forbiddenCalls==0 && f.message.sourceWrites==0); [f close];
}

static void TestAccountNotificationSuspension(void) {
    for (id loggedOutAccount in @[NSNull.null,@""]) { @autoreleasepool {
        Fixture *f=[Fixture new]; CSVoicePlaybackSnapshot *oldToken=Snapshot(f);
        PlaybackAccountCoordinator *coordinator=[PlaybackAccountCoordinator new];
        coordinator.accountID=loggedOutAccount==NSNull.null ? nil : loggedOutAccount;
        __block NSUInteger immediateAdoptions=0;
        __weak CSVoicePlaybackController *controller=f.controller; PlaybackMessage *message=f.message;
        id observer=[NSNotificationCenter.defaultCenter addObserverForName:CSVoicePlaybackStateDidChangeNotification
            object:f.controller queue:nil usingBlock:^(__unused NSNotification *note){
                if ([controller snapshotForMessage:message]) immediateAdoptions++;
            }];
        NSUInteger serviceReads=f.environment.serviceReads;
        [NSNotificationCenter.defaultCenter postNotificationName:@"CSMessageActionAccountStateDidChangeNotification" object:coordinator];
        // The environment and native facade intentionally still expose Alice's
        // old playing message, as they can during the real logout boundary.
        CHECK([f.environment.account isEqual:@"alice"] && f.facade.playing);
        CHECK(immediateAdoptions==0 && ![f.controller snapshotForMessage:f.message]);
        CHECK(f.environment.serviceReads==serviceReads);
        CHECK(![f.controller seekToTime:3 message:f.message generation:oldToken.generation]);
        [NSNotificationCenter.defaultCenter postNotificationName:@"UIApplicationDidBecomeActiveNotification" object:nil];
        CHECK(immediateAdoptions==0 && ![f.controller snapshotForMessage:f.message]);
        coordinator.accountID=@"alice";
        [NSNotificationCenter.defaultCenter postNotificationName:@"CSMessageActionAccountStateDidChangeNotification" object:coordinator];
        CHECK(immediateAdoptions==1);
        CSVoicePlaybackSnapshot *fresh=Snapshot(f); CHECK(fresh.generation>oldToken.generation);
        CHECK(![f.controller seekToTime:3 message:f.message generation:oldToken.generation]);
        CHECK([f.controller seekToTime:3 message:f.message generation:fresh.generation]);
        CHECK([f.facade.seekTimes isEqual:@[@3000]] && f.facade.forbiddenCalls==0);
        [NSNotificationCenter.defaultCenter removeObserver:observer]; [f close];
    } }
}

int main(void) { @autoreleasepool {
    @autoreleasepool { TestNativeMillisecondsAndReadOnly(); }
    @autoreleasepool { TestClampAndInvalidNumbers(); }
    @autoreleasepool { TestRejectedSourcesAndABIs(); }
    @autoreleasepool { TestNativeExceptions(); }
    @autoreleasepool { TestIdentityAndGeneration(); }
    @autoreleasepool { TestAccountSettingsAndBackground(); }
    @autoreleasepool { TestReentrancyAndThreadBoundary(); }
    @autoreleasepool { TestNativeRevalidationRaces(); }
    @autoreleasepool { TestNativeExceptionConsumesToken(); }
    @autoreleasepool { TestAccountNotificationSuspension(); }
    printf("Voice playback controller passed (%lu checks; real production controller/native adapter)\n",(unsigned long)checks);
} return 0; }
