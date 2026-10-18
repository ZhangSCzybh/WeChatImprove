#import <Foundation/Foundation.h>
#import "CSPaymentAutomation.h"

@interface CMessageMgr : NSObject @end
@interface WCPayReveiverControlTransferControlLogic : NSObject
- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer;
@end
@interface TenPayRequest : NSObject
@property(nonatomic, readonly) id reqText;
@end
@interface WCPayNetworkHelper : NSObject @end
@interface WCPayLogicMgr : NSObject @end
@interface MMContextManager : NSObject @end

%hook CMessageMgr
- (void)AsyncOnAddMsg:(id)session MsgWrap:(id)wrap {
    %orig;
    CSPaymentAdmitMessage(wrap,NO);
    CSPaymentAdmitMessage(wrap,YES);
}
- (void)AddMsg:(id)session MsgWrap:(id)wrap {
    %orig;
    CSPaymentAdmitMessage(wrap,NO);
    CSPaymentAdmitMessage(wrap,YES);
}
%end

%hook WCPayReveiverControlTransferControlLogic
- (id)initWithData:(id)data {
    id result=%orig;
    CSPaymentTask *task=CSPaymentOwner(data);
    if (task) { CSPaymentSetOwner(result,task); task.nativeLogic=result; }
    return result;
}
- (void)startLogic {
    CSPaymentTask *task=CSPaymentOwner(self);
    if (!task) { %orig; return; }
    dispatch_async(dispatch_get_main_queue(),^{
        if (CSPaymentCanConfirm(task)) [self OnWCPayTransferMoneyStatusViewControllerConfirmTransfer];
    });
}
- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer {
    id task=CSPaymentOwner(self);
    if (!task) { %orig; return; }
    if (CSPaymentCanConfirm(task)) CSPaymentWithOwner(task,^{ %orig; });
}
- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer:(id)arg1 againCtx:(id)arg2 {
    id task=CSPaymentOwner(self);
    if (!task) { %orig; return; }
    if (CSPaymentCanConfirm(task)) CSPaymentWithOwner(task,^{ %orig; });
}
// This callback is a native extension broadcast, without a transaction ID.
// Owned flows finish from their exact TenPayRequest response instead.
- (void)OnConfirmTransferMoney:(id)response Error:(id)error {
    if (!CSPaymentOwner(self)) { %orig; }
}
- (void)OnCheckTransferMoneyStatus:(id)response Error:(id)error {
    if (!CSPaymentOwner(self)) { %orig; }
}
- (void)stopLogic {
    CSPaymentTask *task=CSPaymentOwner(self);
    if (task) task.nativeLogic=nil;
    %orig;
}

%end

// Observe the complete request at the concrete native submission boundary.
// Protobuf accessors are resolved dynamically and are not stable hook targets.
%hook WCPayNetworkHelper
- (void)WCToTenpayCommonRequest:(id)request RetryCount:(unsigned int)retryCount routeInfo:(unsigned char)routeInfo {
    CSPaymentCaptureRequest(request,[request reqText],NO);
    %orig;
}
%end

%hook WCPayLogicMgr
- (void)OnWCToTenpayCommonResponse:(id)response Request:(id)request {
    NSDictionary *snapshot=CSPaymentResponseSnapshot(response,request,NO,NO);
    %orig;
    CSPaymentHandleResponse(snapshot);
}
- (void)OnWCToTenpayCommonErrorResponse:(id)response Request:(id)request {
    NSDictionary *snapshot=CSPaymentResponseSnapshot(response,request,NO,YES);
    %orig;
    CSPaymentHandleResponse(snapshot);
}
- (void)OnWCToTenpayCommonSystemErrorResponse:(id)response Request:(id)request {
    NSDictionary *snapshot=CSPaymentResponseSnapshot(response,request,NO,YES);
    %orig;
    CSPaymentHandleResponse(snapshot);
}
// The native license gate may accept asynchronously. Preserve that gate and
// carry the exact task into its void(void) callback (8.0.78 block ABI v8@?0).
- (void)checkAndShowRealnameLicense:(unsigned int)scene acceptCallback:(dispatch_block_t)accept denyCallback:(dispatch_block_t)deny startLoadingCallback:(dispatch_block_t)start stopLoadingCallback:(dispatch_block_t)stop {
    dispatch_block_t guarded=CSPaymentGuardConfirmation(accept);
    %orig(scene,guarded,deny,start,stop);
}

%end

%hook MMContextManager
- (void)logout:(id)context { CSPaymentAccountWillChange(); %orig; }
- (void)loginByContext:(id)context { %orig; CSPaymentAccountDidChange(); }
%end

%ctor { CSPaymentStart(); }
