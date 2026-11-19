#import "../Controllers/CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import "../Controllers/CSClownPresentation.h"
#import "../Controllers/CSClownMenuAdapter.h"
#import "../Controllers/CSMessageCellLifecycle.h"

@interface CommonMessageCellView : UIView @end
@interface TextMessageCellView : CommonMessageCellView @end
@interface ImageMessageCellView : CommonMessageCellView @end
@interface WCPayTransferMessageCellView : CommonMessageCellView @end
@interface ChatTimeCellView : UIView @end
@interface MMContextManager : NSObject @end
@interface BaseMsgContentViewController : UIViewController @end
@interface BaseMsgContentLogicController : NSObject @end
@interface CMessageMgr : NSObject @end

// These subclasses may omit super; the shared depth guards own each complete native chain once.
%hook TextMessageCellView
- (void)setViewModel:(id)model { CSMessageCellPerformBinding(self,model,^{ %orig; }); }
- (void)prepareForReuse { CSMessageCellPerformReuse(self,^{ %orig; }); }
- (void)layoutSubviews { CSMessageCellPerformLayout(self,^{ %orig; }); }
%end

%hook ImageMessageCellView
- (void)setViewModel:(id)model { CSMessageCellPerformBinding(self,model,^{ %orig; }); }
- (void)prepareForReuse { CSMessageCellPerformReuse(self,^{ %orig; }); }
- (void)layoutSubviews { CSMessageCellPerformLayout(self,^{ %orig; }); }
%end

%hook ChatTimeCellView
- (void)layoutInternal { CSClownRestoreCell(self); %orig; CSClownBindTimeCell(self); }
- (void)setViewModel:(id)model { CSClownReuseCell(self); %orig; CSClownBindTimeCell(self); }
%end

%hook BaseMsgContentViewController
- (void)toggleTimeShowMode:(double)time { %orig; CSClownTimeDisplayModeDidChange(self); }
- (void)SendTextMessageToolView:(id)text {
    CSClownSubmitInput(self, text, ^(id value) { %orig(value); });
}
- (void)AsyncSendMessage:(id)text replyingMsg:(id)reply referPartialInfo:(id)partial isPasted:(BOOL)pasted {
    CSClownSendInput(self, text, reply, partial, ^(id value) { %orig(value, reply, partial, pasted); });
}
%end

%hook BaseMsgContentLogicController
- (id)FormTextMsg:(id)target withText:(id)text {
    id wrap = %orig; CSClownDidFormText(target, text, wrap); return wrap;
}
%end

%hook CMessageMgr
- (void)AddMsg:(id)target MsgWrap:(id)wrap {
    %orig; CSClownDidAddMessage(target, wrap);
}
%end

%hook WCPayTransferMessageCellView
- (void)setViewModel:(id)model { CSMessageCellPerformBinding(self,model,^{ %orig; }); }
- (void)prepareForReuse { CSMessageCellPerformReuse(self,^{ %orig; }); }
- (void)layoutSubviews { CSMessageCellPerformLayout(self,^{ %orig; }); }
- (id)operationMenuItems { return [CSClownMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSClownMenuAdapter isPluginSelector:action]) return [CSClownMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_clownEditAmount:(id)sender { [CSClownMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook MMContextManager
- (void)logout:(id)context { CSClownAccountBoundary(); %orig; }
- (void)loginByContext:(id)context { %orig; CSClownAccountBoundary(); }
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
