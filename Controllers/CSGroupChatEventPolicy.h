#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT BOOL CSGroupChatValidMemberID(id value);
// Identity completeness is independent of optional/simplified contact details.
FOUNDATION_EXPORT NSSet<NSString *> *_Nullable CSGroupChatValidatedMembers(id rawMembers, NSUInteger expectedCount);
// Returns nil for malformed/stale/contradictory snapshots; first snapshot only establishes a baseline.
FOUNDATION_EXPORT NSDictionary *_Nullable CSGroupChatMemberDelta(NSDictionary *_Nullable previous, NSDictionary *current, NSString *account);
FOUNDATION_EXPORT BOOL CSGroupChatMayWelcome(NSDictionary *previous, NSDictionary *current, NSString *member, NSDate *now);
FOUNDATION_EXPORT BOOL CSGroupChatMayWelcomeAfterGap(NSDictionary *_Nullable previous, NSDictionary *current, NSString *member, NSDate *now, BOOL recovering);
NS_ASSUME_NONNULL_END
