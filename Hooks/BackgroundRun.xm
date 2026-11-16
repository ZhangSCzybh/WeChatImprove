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
    BOOL result=NO, completed=NO;
    @try { result=%orig; completed=YES; return result; }
    @finally {
        if (tracked) {
            // On iOS 8-25, IsBusy can report misuse after the session was
            // actually deactivated. Preserve the native result and NSError.
            NSError *failure=completed && !result && error?*error:nil;
            BOOL deactivated=!active && [failure.domain isEqual:NSOSStatusErrorDomain] && failure.code==AVAudioSessionErrorCodeIsBusy;
            CSBackgroundRunAudioDidChange(result || deactivated,YES,active);
        }
    }
}
- (BOOL)setActive:(BOOL)active withOptions:(AVAudioSessionSetActiveOptions)options error:(NSError **)error {
    BOOL tracked=CSBackgroundRunAudioWillChange();
    BOOL result=NO, completed=NO;
    @try { result=%orig; completed=YES; return result; }
    @finally {
        if (tracked) {
            NSError *failure=completed && !result && error?*error:nil;
            BOOL deactivated=!active && [failure.domain isEqual:NSOSStatusErrorDomain] && failure.code==AVAudioSessionErrorCodeIsBusy;
            CSBackgroundRunAudioDidChange(result || deactivated,YES,active);
        }
    }
}
%end

%ctor {
    CSBackupWhenReady(^{
        %init;
        dispatch_async(dispatch_get_main_queue(),^{ [CSBackgroundRunManager.sharedManager start]; });
    });
}
