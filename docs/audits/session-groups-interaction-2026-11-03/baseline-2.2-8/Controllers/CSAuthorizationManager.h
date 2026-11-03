#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CSAuthorizationCompletion)(BOOL success, NSString *message);

@interface CSAuthorizationManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, copy, readonly) NSString *officialAccountUserName;
@property (nonatomic, assign, readonly) BOOL isAuthorized;

- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)viewController
                                              completion:(nullable CSAuthorizationCompletion)completion;
- (void)openOfficialAccountFromViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
