#import <Foundation/Foundation.h>
#import "CSCloseFriendNotificationAdapter.h"
#ifdef __cplusplus
extern "C" {
#endif
@interface CSCloseFriendCallToken : NSObject
@property(nonatomic,strong) CSCloseFriendAlertSubject *subject;
@property(nonatomic,copy) NSString *key, *state;
@property(nonatomic) unsigned long long roomID, roomType;
@property(nonatomic) long long roomKey;
@property(nonatomic) BOOL ilink;
@property(nonatomic,strong) id info, mono;
- (BOOL)requiresRejection;
- (BOOL)suppressesPresentation;
@end
/// Invitation claims are bounded, per account/epoch/room/message. No native reset on expiry.
@interface CSCloseFriendCallAdapter : NSObject
- (BOOL)claim:(CSCloseFriendCallToken *)token now:(NSTimeInterval)now;
- (void)end:(CSCloseFriendCallToken *)token;
@end
FOUNDATION_EXPORT CSCloseFriendCallToken *CSCFInvitationToken(id info);
FOUNDATION_EXPORT CSCloseFriendCallToken *CSCFMultiTalkToken(id message);
FOUNDATION_EXPORT CSCloseFriendCallToken *CSCFIncomingCallToken(id message);
/// Consumes a pending single-party invitation before the native UI/ring boundary.
FOUNDATION_EXPORT BOOL CSCFHandleIncomingCall(id manager,id message,BOOL ilink);
FOUNDATION_EXPORT BOOL CSCFHandleInvitation(id service,id info,unsigned long long talkingRoom);
FOUNDATION_EXPORT void CSCFHandleMultiTalk(id manager,id message,void (^native)(void));
FOUNDATION_EXPORT BOOL CSCFCallOutputSuppressed(void);
FOUNDATION_EXPORT BOOL CSCFCallBannerSuppressed(id group,unsigned long long room);
FOUNDATION_EXPORT BOOL CSCFInvitationOutputSuppressed(id controller);
/// Called only after a supported native rejection request was submitted, not on suppression alone.
FOUNDATION_EXPORT void CSCFCallDidReject(CSCloseFriendCallToken *token);
#ifdef __cplusplus
}
#endif
