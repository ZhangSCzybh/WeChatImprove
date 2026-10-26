#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"

NS_ASSUME_NONNULL_BEGIN
/// Local feature discovery only. This preference never grants access to protected content.
@interface CSCloseFriendEntryState : NSObject
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
- (BOOL)hasDiscoveredEntryForSnapshot:(CSCloseFriendSnapshot *)snapshot hasCredential:(BOOL)hasCredential;
- (BOOL)isEntryVisibleForSnapshot:(CSCloseFriendSnapshot *)snapshot hasCredential:(BOOL)hasCredential;
/// Returns YES only for a newly persisted discovery. Existing users and manual hiding are unchanged.
- (BOOL)discoverEntryForSnapshot:(CSCloseFriendSnapshot *)snapshot hasCredential:(BOOL)hasCredential;
/// Used only by the independently authenticated reset. Other accounts are untouched.
- (BOOL)removeDiscoveryForAccountID:(NSString *)accountID error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END
