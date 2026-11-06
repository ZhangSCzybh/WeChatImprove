#import <UIKit/UIKit.h>
#import "CSCloseFriendRuntime.h"
@interface CSCloseFriendManager : NSObject
+ (instancetype)sharedManager;
@property(nonatomic,strong,readonly) CSCloseFriendRuntime *runtime;
- (void)start;
- (void)refreshAccount;
- (void)lockAndReturnToSafePage;
- (void)handleShake;
- (void)returnToChatListIfNeeded;
- (void)authenticateFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion;
- (void)presentSettingsFrom:(UIViewController *)presenter;
- (BOOL)settingsEntryVisible;
/// Capture at touch-down; discovery revalidates the account and foreground generation.
- (NSDictionary *)settingsEntryDiscoveryToken;
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token;
- (void)changePasswordFrom:(UIViewController *)presenter;
- (void)resetFrom:(UIViewController *)presenter completion:(void (^)(BOOL success))completion;
- (void)resetFrom:(UIViewController *)presenter settingsToken:(NSDictionary *)token completion:(void (^)(BOOL success))completion;
- (NSDictionary *)capabilities;
- (void)recordCapability:(NSString *)name available:(BOOL)available;
- (void)attachRecoveryGestureTo:(UIViewController *)controller;
- (void)checkHomepageSearchPassword:(NSString *)query isCurrent:(BOOL (^)(void))isCurrent completion:(void (^)(BOOL consumed))completion;
@end
