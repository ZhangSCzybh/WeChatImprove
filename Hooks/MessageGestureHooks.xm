#import "../Controllers/CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import "../Controllers/CSMessageCellLifecycle.h"
#import "../Controllers/CSMessageGestureAdapter.h"
#import "../Controllers/CSVoicePlaybackOverlay.h"

@interface CommonMessageCellView : UIView @end
@interface VoiceMessageCellView : CommonMessageCellView @end
@interface MMContextManager : NSObject @end

// A single lifecycle owner replaces the three independent gesture/merge/time chains.
%hook CommonMessageCellView
- (id)initWithViewModel:(id)model { id cell=%orig; if (cell) CSMessageCellRefresh(cell); return cell; }
- (void)setViewModel:(id)model { CSMessageCellPerformBinding(self,model,^{ %orig; }); }
- (void)prepareForReuse { CSMessageCellPerformReuse(self,^{ %orig; }); }
- (void)layoutSubviews { CSMessageCellPerformLayout(self,^{ %orig; }); }
- (void)updateNodeStatus { %orig; CSMessageCellRefresh(self); }
- (void)onAppear { %orig; CSMessageCellRefresh(self); }
- (void)onDisappear { CSVoicePlaybackDetachCell(self); [CSMessageGestureAdapterForCell(self,NO) cancel]; %orig; }
- (void)didMoveToWindow { %orig; CSMessageCellWindowChanged(self); }
%end

// Voice subclasses that omit super still participate; nested super chains execute once.
%hook VoiceMessageCellView
- (void)setViewModel:(id)model { CSMessageCellPerformBinding(self,model,^{ %orig; }); }
- (void)prepareForReuse { CSMessageCellPerformReuse(self,^{ %orig; }); }
- (void)layoutSubviews { CSMessageCellPerformLayout(self,^{ %orig; }); }
%end

%hook MMContextManager
- (void)logout:(id)context {
    CSMessageActionAccountWillChangeAtNativeBoundary();
    CSMessageGestureAccountBoundary();
    %orig;
}
- (void)loginByContext:(id)context {
    %orig;
    CSMessageActionAccountDidChangeAtNativeBoundary();
    CSMessageGestureAccountBoundary();
}
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
