#import <UIKit/UIKit.h>
#import "CSCloseFriendRuntime.h"
@interface CSCloseFriendManager : NSObject
+ (instancetype)sharedManager;
@property(nonatomic,strong,readonly) CSCloseFriendRuntime *runtime;
- (void)start;
- (void)refreshAccount;
- (void)lockAndReturnToSafePage;
- (void)authenticateFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion;
- (void)presentSettingsFrom:(UIViewController *)presenter;
- (void)changePasswordFrom:(UIViewController *)presenter;
- (NSDictionary *)capabilities;
- (void)recordCapability:(NSString *)name available:(BOOL)available;
- (void)attachRecoveryGestureTo:(UIViewController *)controller;
@end
