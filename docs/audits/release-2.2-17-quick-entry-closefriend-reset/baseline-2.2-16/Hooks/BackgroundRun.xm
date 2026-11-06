#import "../Controllers/CSBackupBootstrap.h"
#import "CSBackgroundRunManager.h"
#import <AVFoundation/AVFoundation.h>

// Observe host ownership at public session boundaries. All native calls retain
// their arguments, return values and errors. No application delegate guessing.
%hook AVAudioSession
- (BOOL)setCategory:(NSString *)category error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO;
    @try { result=%orig; return result; }
    @finally { if (tracked) CSBackgroundRunAudioDidChange(result,NO,NO); }
}
- (BOOL)setCategory:(NSString *)category withOptions:(AVAudioSessionCategoryOptions)options error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO;
    @try { result=%orig; return result; }
    @finally { if (tracked) CSBackgroundRunAudioDidChange(result,NO,NO); }
}
- (BOOL)setCategory:(NSString *)category mode:(NSString *)mode options:(AVAudioSessionCategoryOptions)options error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO;
    @try { result=%orig; return result; }
    @finally { if (tracked) CSBackgroundRunAudioDidChange(result,NO,NO); }
}
- (BOOL)setCategory:(NSString *)category mode:(NSString *)mode routeSharingPolicy:(AVAudioSessionRouteSharingPolicy)policy options:(AVAudioSessionCategoryOptions)options error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO;
    @try { result=%orig; return result; }
    @finally { if (tracked) CSBackgroundRunAudioDidChange(result,NO,NO); }
}
- (BOOL)setMode:(NSString *)mode error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO;
    @try { result=%orig; return result; }
    @finally { if (tracked) CSBackgroundRunAudioDidChange(result,NO,NO); }
}
- (BOOL)setActive:(BOOL)active error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO;
    @try { result=%orig; return result; }
    @finally { if (tracked) CSBackgroundRunAudioDidChange(result,YES,active); }
}
- (BOOL)setActive:(BOOL)active withOptions:(AVAudioSessionSetActiveOptions)options error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO;
    @try { result=%orig; return result; }
    @finally { if (tracked) CSBackgroundRunAudioDidChange(result,YES,active); }
}
%end

%ctor {
    CSBackupWhenReady(^{
        %init;
        dispatch_async(dispatch_get_main_queue(),^{ [CSBackgroundRunManager.sharedManager start]; });
    });
}
