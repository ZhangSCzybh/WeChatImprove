#import "CSAuthorizationManager.h"
#import "CSServiceCenter.h"
#import <objc/message.h>

static NSString * const kOfficialAccountUserName = @"gh_cac882c8f729";
@implementation CSAuthorizationManager

+ (instancetype)sharedManager {
    static CSAuthorizationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSAuthorizationManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _officialAccountUserName = kOfficialAccountUserName;
    }
    return self;
}

- (BOOL)isAuthorized {
    // Always check the live follow state; authorization reads need no persistent cache.
    Class contactMgrClass = NSClassFromString(@"CContactMgr");
    if (!contactMgrClass) {
        return NO;
    }
    
    id contactMgr = CSGetService(contactMgrClass);
    if (!contactMgr) {
        return NO;
    }
    
    // 原生查询成功返回时直接采用结果，包括 NO。
    Class contactClass = NSClassFromString(@"CContact");
    if (contactClass) {
        SEL isBrandFollowedSelector = NSSelectorFromString(@"isBrandFollowedWithUsername:");
        if ([contactClass respondsToSelector:isBrandFollowedSelector]) {
            @try {
                return ((BOOL (*)(id, SEL, id))objc_msgSend)(contactClass, isBrandFollowedSelector, self.officialAccountUserName);
            } @catch (__unused NSException *exception) {}
        }
    }
    
    // 仅在 CContact 类/查询方法缺失或查询抛异常时读取联系人属性。
    SEL getContactByNameSelector = NSSelectorFromString(@"getContactByName:");
    if (![contactMgr respondsToSelector:getContactByNameSelector]) {
        return NO;
    }
    
    @try {
        id contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, getContactByNameSelector, self.officialAccountUserName);
        if (!contact) {
            return NO;
        }
        
        // 检查 m_uiBrandSubscriptionSettings 属性
        SEL brandSubscriptionSettingsSelector = NSSelectorFromString(@"m_uiBrandSubscriptionSettings");
        if ([contact respondsToSelector:brandSubscriptionSettingsSelector]) {
            unsigned int subscriptionSettings = ((unsigned int (*)(id, SEL))objc_msgSend)(contact, brandSubscriptionSettingsSelector);
            
            // 如果 subscriptionSettings > 0，表示已关注
            return subscriptionSettings > 0;
        }
    } @catch (__unused NSException *exception) {}
    
    return NO;
}

- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)viewController
                                              completion:(CSAuthorizationCompletion)completion {
    if ([self isAuthorized]) {
        if (completion) {
            completion(YES, @"已获得授权");
        }
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"需要授权"
                                                                   message:@"请先关注公众号以使用此功能"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlert = alert;
    
    UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"关注公众号"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
        // Finish the alert transition before opening another native page.
        [weakAlert dismissViewControllerAnimated:YES completion:^{
            [self openOfficialAccountFromViewController:viewController];
            if (completion) {
                completion(NO, @"请关注公众号后重新打开插件");
            }
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
        // The settings host can safely pop/dismiss once this alert is gone.
        [weakAlert dismissViewControllerAnimated:YES completion:^{
            if (completion) {
                completion(NO, @"用户取消授权");
            }
        }];
    }];
    
    [alert addAction:openAction];
    [alert addAction:cancelAction];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

- (void)openOfficialAccountFromViewController:(UIViewController *)viewController {
    // 使用TingRouter打开公众号主页
    Class tingRouterClass = NSClassFromString(@"TingRouter");
    if (!tingRouterClass) {
        NSLog(@"[授权管理] 无法获取TingRouter类");
        [self openBrandProfileDirectly];
        return;
    }
    
    SEL openBrandProfileSelector = NSSelectorFromString(@"openBrandProfileWithUsername:");
    if (![tingRouterClass respondsToSelector:openBrandProfileSelector]) {
        NSLog(@"[授权管理] TingRouter不支持openBrandProfileWithUsername方法");
        [self openBrandProfileDirectly];
        return;
    }
    
    @try {
        ((void (*)(id, SEL, id))objc_msgSend)(tingRouterClass, openBrandProfileSelector, self.officialAccountUserName);
    } @catch (NSException *exception) {
        NSLog(@"[授权管理] TingRouter打开公众号失败: %@", exception);
        [self openBrandProfileDirectly];
    }
}

- (void)openBrandProfileDirectly {
    // 使用微信内部URL scheme直接打开公众号主页
    // 方式1: 使用 profile/username 格式
    NSString *urlString = [NSString stringWithFormat:@"weixin://profile/%@", self.officialAccountUserName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            if (!success) {
                NSLog(@"[授权管理] profile方式失败，尝试其他方式");
                // 如果失败，尝试其他URL scheme
                [self tryAlternativeURLScheme];
            }
        }];
    });
}

- (void)tryAlternativeURLScheme {
    // 方式2: 使用 findfriend/verifycontact 格式
    NSString *urlString = [NSString stringWithFormat:@"weixin://findfriend/verifycontact?username=%@", self.officialAccountUserName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            if (!success) {
                NSLog(@"[授权管理] 所有方式都失败");
            }
        }];
    });
}

@end
