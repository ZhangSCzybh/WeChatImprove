#import <Foundation/Foundation.h>
#import "CSPaymentCore.h"
#ifdef __cplusplus
extern "C" {
#endif
void CSPaymentStart(void);
void CSPaymentReload(void);
void CSPaymentAccountWillChange(void);
void CSPaymentAccountDidChange(void);
void CSPaymentAdmitMessage(id wrap, BOOL envelope);
id CSPaymentOwner(id object);
void CSPaymentSetOwner(id object, id task);
BOOL CSPaymentCanConfirm(id task);
void CSPaymentWithOwner(id task, dispatch_block_t block);
dispatch_block_t CSPaymentGuardConfirmation(dispatch_block_t callback);
void CSPaymentCaptureRequest(id request, id buffer, BOOL envelope);
NSDictionary *CSPaymentResponseSnapshot(id response, id request, BOOL envelope, BOOL failed);
void CSPaymentHandleResponse(NSDictionary *snapshot);
void CSPaymentResetEnvelopeStatistics(dispatch_block_t completion);
#ifdef __cplusplus
}
#endif
