#import <Foundation/Foundation.h>
#ifdef __cplusplus
extern "C" {
#endif
/// Native completion/status callbacks wake the bounded observer of an owned reply.
FOUNDATION_EXPORT void CSCFCallReplyMessageDidChange(id message);
#if CSCF_CALL_REPLY_TESTING
/// Host fixture clock/queue only; excluded from the shipped library.
FOUNDATION_EXPORT void CSCFCallReplyConfigureTesting(NSTimeInterval (^clock)(void),void (^schedule)(NSTimeInterval,dispatch_block_t));
#endif
#ifdef __cplusplus
}
#endif
