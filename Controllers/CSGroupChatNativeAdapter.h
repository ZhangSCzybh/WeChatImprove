#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT id _Nullable CSGroupChatRoomContact(NSString *roomID);
FOUNDATION_EXPORT NSString *CSGroupChatRoomName(NSString *roomID);
FOUNDATION_EXPORT NSSet<NSString *> *_Nullable CSGroupChatMemberIDs(NSString *roomID);
FOUNDATION_EXPORT BOOL CSGroupChatIsMember(NSString *roomID, NSString *accountID);
FOUNDATION_EXPORT BOOL CSGroupChatRoomUnavailable(NSString *roomID);
// Raw WeChat nickname, or an empty string if the member contact has none.
FOUNDATION_EXPORT NSString *CSGroupChatMemberName(NSString *roomID, NSString *memberID);
FOUNDATION_EXPORT NSArray<NSString *> *_Nullable CSGroupChatKnownRoomIDs(void);
FOUNDATION_EXPORT BOOL CSGroupChatRequestMembers(NSString *roomID);
FOUNDATION_EXPORT BOOL CSGroupChatSaveToContacts(NSString *roomID, NSString *accountID, NSError **error);
// nil means eligible; a user-facing reason means this room must not be submitted.
FOUNDATION_EXPORT NSString *_Nullable CSGroupChatQuitPreflight(NSString *roomID, NSString *accountID);
FOUNDATION_EXPORT BOOL CSGroupChatOpenMemberProfile(NSString *roomID, NSString *memberID, UIViewController *source);
FOUNDATION_EXPORT BOOL CSGroupChatOpenRoomProfile(NSString *roomID, UIViewController *source);
FOUNDATION_EXPORT NSNotificationName const CSGroupChatQuitDidChange;
@interface CSGroupChatQuitCoordinator : NSObject
+ (instancetype)sharedCoordinator;
@property(nonatomic,readonly) BOOL running;
@property(nonatomic,copy,readonly) NSArray<NSDictionary *> *results;
@property(nonatomic,copy,readonly) NSString *statusText;
- (BOOL)startRoomIDs:(NSArray<NSString *> *)roomIDs clearHistory:(BOOL)clearHistory account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error;
- (void)stopFollowingBatches;
- (BOOL)isQuittingRoom:(NSString *)roomID;
@end
NS_ASSUME_NONNULL_END
