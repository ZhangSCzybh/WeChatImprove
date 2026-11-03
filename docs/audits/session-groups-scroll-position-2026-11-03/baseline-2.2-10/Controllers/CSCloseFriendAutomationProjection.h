#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"

NS_ASSUME_NONNULL_BEGIN
/// Presentation copies only. Account mismatch or unavailable policy conceals all entries.
/// Neither projection changes stored definitions nor authorizes message execution.
FOUNDATION_EXPORT NSArray<NSDictionary *> *CSCloseFriendVisibleScheduledTasks(NSArray<NSDictionary *> * _Nullable tasks, NSString * _Nullable account, CSCloseFriendSnapshot * _Nullable snapshot);
/// Sorted enabled conversation IDs, shared by the list and its visible count.
FOUNDATION_EXPORT NSArray<NSString *> *CSCloseFriendVisibleAIConversations(NSDictionary * _Nullable conversations, NSString * _Nullable account, CSCloseFriendSnapshot * _Nullable snapshot);
NS_ASSUME_NONNULL_END
