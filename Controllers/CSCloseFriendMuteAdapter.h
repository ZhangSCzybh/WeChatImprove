#import <Foundation/Foundation.h>
#import "CSCloseFriendPolicy.h"
/// Foundation transaction engine; injected I/O also permits memory-only behavior tests.
@interface CSCloseFriendMuteAdapter : NSObject
@property(nonatomic,copy) NSDictionary *(^load)(void);
@property(nonatomic,copy) BOOL (^save)(NSDictionary *, NSString *, NSUInteger);
@property(nonatomic,copy) NSNumber *(^readOpen)(NSString *);
@property(nonatomic,copy) BOOL (^writeOpen)(NSString *, BOOL);
@property(nonatomic,copy) BOOL (^current)(NSString *, NSUInteger);
- (void)reconcile:(CSCloseFriendSnapshot *)policy epoch:(NSUInteger)epoch;
- (void)externalMutation:(NSString *)name account:(NSString *)account epoch:(NSUInteger)epoch;
+ (void)start;
@end
