#import "../Controllers/CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import "CSMessageActionCoordinator.h"

// Native selection, confirmation, comments and cleanup always run. Only the verified
// per-target voice boundary may replace the native (voice-refusing) sender.
%hook BaseMessageCellView
- (void)onForward:(id)sender {
    CSMessageActionCoordinator *coordinator=CSMessageActionCoordinator.sharedCoordinator;
    if (!coordinator.settings.voiceForwardEnabled || CSMessageNativeUnsigned(CSMessageActionResolveSourceWrap(self),@"m_uiMessageType")!=34) { %orig; return; }
    CSMessageActionContext *context=[coordinator captureContextForCell:self controller:nil bindingGeneration:1];
    if (!context || context.messageType!=34 || !coordinator.settings.voiceForwardEnabled) { %orig; return; }
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ %orig; }];
}
%end

%hook ForwardMessageLogicController
- (void)forwardMessage:(id)source {
    [CSMessageActionCoordinator.sharedCoordinator bindForwardLogic:self source:source];
    %orig;
}
- (BOOL)bShowSendSuccessView {
    if ([CSMessageActionCoordinator.sharedCoordinator shouldSuppressNativeSuccessForLogic:self]) return NO;
    return %orig;
}
- (BOOL)bHiddenSendSuccessToastView {
    if ([CSMessageActionCoordinator.sharedCoordinator shouldSuppressNativeSuccessForLogic:self]) return YES;
    return %orig;
}
- (void)ForwardMsgList:(id)messages ToContact:(id)target WithRevokeBatchId:(id)batchID {
    // Reaching native dispatch (after waiting/refusal checks) authorizes the final target snapshot.
    [CSMessageActionCoordinator.sharedCoordinator confirmForwardLogic:self];
    %orig;
}
- (void)ForwardMsg:(id)source ToContact:(id)target {
    if ([CSMessageActionCoordinator.sharedCoordinator handleForwardLogic:self source:source target:target]) return;
    %orig;
}
- (void)clearData {
    [CSMessageActionCoordinator.sharedCoordinator finishForwardLogic:self cancelled:YES];
    %orig;
}
%end

%hook ForwardMessageMgr
- (void)OnForwardMessageSend:(id)logic {
    // UI completion is not native acceptance/delivery and never causes another send.
    [CSMessageActionCoordinator.sharedCoordinator finishForwardLogic:logic cancelled:NO];
    %orig;
}
- (void)OnForwardMessageCancel:(id)logic {
    [CSMessageActionCoordinator.sharedCoordinator finishForwardLogic:logic cancelled:YES];
    %orig;
}
// Confirmation cancellation returns to the picker; no hook is needed to preserve its binding.
%end

%hook VoiceMsgDownloader
- (void)OnRecvData:(id)chat MesLocalID:(unsigned int)localID n64MesSvrID:(long long)serverID CreateTime:(unsigned int)createTime VoiceTime:(unsigned int)voiceTime Offset:(unsigned int)offset Len:(unsigned int)length Data:(id)data EndFlag:(unsigned int)endFlag ErrNo:(unsigned int)error {
    %orig;
    if (endFlag!=1 || !CSMessageHasPendingVoiceDownloads()) return;
    // Native completion first persists the full audio and updates its message state.
    void (^continuation)(void)=^{ [CSMessageActionCoordinator.sharedCoordinator voiceDownloadCompletedForChat:chat localID:localID serverID:serverID endFlag:endFlag error:error]; };
    if (NSThread.isMainThread) continuation(); else dispatch_async(dispatch_get_main_queue(),continuation);
}
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
