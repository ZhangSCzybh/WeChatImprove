#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSVoicePlaybackController.h"
#import "../Controllers/CSVoicePlaybackOverlay.h"
#import "../Controllers/CSMessageCellLifecycle.h"

// Keep WeChat's playback, audio route, rate and callback ordering intact. These
// callbacks carry CMessageWrap, not NSNotification. The controller rechecks the
// current account-bound facade and the exact playing message before every seek.
%hook MsgPlayingFacade
- (void)OnBeginPlaying:(id)message success:(BOOL)success {
    %orig;
    if (!success) return;
    void (^refresh)(void)=^{ [CSVoicePlaybackController.sharedController messageDidBegin:message]; };
    if (NSThread.isMainThread) refresh(); else dispatch_async(dispatch_get_main_queue(),refresh);
}
- (void)OnEndPlaying:(id)message isForceStop:(BOOL)forced {
    %orig;
    void (^refresh)(void)=^{ [CSVoicePlaybackController.sharedController messageDidEnd:message]; };
    if (NSThread.isMainThread) refresh(); else dispatch_async(dispatch_get_main_queue(),refresh);
}
- (void)OnPausePlaying:(id)message {
    %orig;
    void (^refresh)(void)=^{ [CSVoicePlaybackController.sharedController messageDidEnd:message]; };
    if (NSThread.isMainThread) refresh(); else dispatch_async(dispatch_get_main_queue(),refresh);
}
%end

%hook VoiceMessageCellView
- (void)onBeginPlayingMsg:(id)message autoPlayEnabled:(BOOL)enabled {
    %orig;
    if (NSThread.isMainThread) CSMessageCellRefresh(self);
}
- (void)onEndPlayingMsg:(id)message autoPlayEnabled:(BOOL)enabled {
    %orig;
    if (NSThread.isMainThread) CSMessageCellRefresh(self);
}
- (void)onWindowHide {
    CSVoicePlaybackDetachCell(self);
    %orig;
}
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
