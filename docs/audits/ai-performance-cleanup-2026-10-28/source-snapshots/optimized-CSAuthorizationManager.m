#import "CSAuthorizationManager.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "../Headers/WCHeaders.h"

static NSString * const kOfficialAccountUserName = @"gh_cac882c8f729"; // 替换为你的公众号原始ID
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
    return [self checkAuthorization];
}

- (BOOL)checkAuthorization {
    Class contactMgrClass = NSClassFromString(@"CContactMgr");
    if (!contactMgrClass) {
        return NO;
    }
    
    id contactMgr = CSGetService(contactMgrClass);
    if (!contactMgr) {
        return NO;
    }
    
    // 尝试方式1: 使用 CContact 的类方法 isBrandFollowedWithUsername:
    Class contactClass = NSClassFromString(@"CContact");
    if (contactClass) {
        SEL isBrandFollowedSelector = NSSelectorFromString(@"isBrandFollowedWithUsername:");
        if ([contactClass respondsToSelector:isBrandFollowedSelector]) {
            @try {
                return ((BOOL (*)(id, SEL, id))objc_msgSend)(contactClass, isBrandFollowedSelector, self.officialAccountUserName);
            } @catch (__unused NSException *exception) {}
        }
    }
    
    // 尝试方式2: 获取联系人对象并检查属性
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
    
    UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"关注公众号"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
        [self openOfficialAccountFromViewController:viewController];
        
        if (completion) {
            completion(NO, @"请关注公众号后重新打开插件");
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
        if (completion) {
            completion(NO, @"用户取消授权");
        }
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
        NSLog(@"[授权管理] 尝试通过TingRouter打开公众号: %@", self.officialAccountUserName);
        ((void (*)(id, SEL, id))objc_msgSend)(tingRouterClass, openBrandProfileSelector, self.officialAccountUserName);
        NSLog(@"[授权管理] 成功调用TingRouter打开公众号");
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
    
    NSLog(@"[授权管理] 尝试打开公众号: %@", urlString);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                if (!success) {
                    NSLog(@"[授权管理] profile方式失败，尝试其他方式");
                    // 如果失败，尝试其他URL scheme
                    [self tryAlternativeURLScheme];
                } else {
                    NSLog(@"[授权管理] 成功打开公众号主页");
                }
            }];
        } else {
            BOOL success = [[UIApplication sharedApplication] openURL:url];
            if (!success) {
                NSLog(@"[授权管理] profile方式失败，尝试其他方式");
                [self tryAlternativeURLScheme];
            } else {
                NSLog(@"[授权管理] 成功打开公众号主页");
            }
        }
    });
}

- (void)tryAlternativeURLScheme {
    // 方式2: 使用 findfriend/verifycontact 格式
    NSString *urlString = [NSString stringWithFormat:@"weixin://findfriend/verifycontact?username=%@", self.officialAccountUserName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"[授权管理] 尝试备用方式: %@", urlString);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                if (!success) {
                    NSLog(@"[授权管理] 所有方式都失败");
                } else {
                    NSLog(@"[授权管理] 备用方式成功");
                }
            }];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    });
}

- (void)openBrandProfileWithContact:(id)contact fromViewController:(UIViewController *)viewController {
    Class brandProfileClass = NSClassFromString(@"BrandProfileMsgTabViewController");
    if (!brandProfileClass) {
        NSLog(@"[授权管理] 无法获取BrandProfileMsgTabViewController类");
        [self openBrandProfileWithBizUtil:contact];
        return;
    }
    
    @try {
        id brandProfileVC = nil;
        
        SEL initWithContactSelector = NSSelectorFromString(@"initWithContact:");
        if ([brandProfileClass instancesRespondToSelector:initWithContactSelector]) {
            brandProfileVC = ((id (*)(id, SEL, id))objc_msgSend)([[brandProfileClass alloc] init], initWithContactSelector, contact);
        }
        
        if (!brandProfileVC) {
            SEL initSelector = NSSelectorFromString(@"init");
            if ([brandProfileClass instancesRespondToSelector:initSelector]) {
                brandProfileVC = [[brandProfileClass alloc] init];
            }
        }
        
        if (!brandProfileVC) {
            NSLog(@"[授权管理] 无法初始化BrandProfileMsgTabViewController");
            [self openBrandProfileWithBizUtil:contact];
            return;
        }
        
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:brandProfileVC];
        navVC.modalPresentationStyle = UIModalPresentationPageSheet;
        
        if (@available(iOS 13.0, *)) {
            navVC.modalPresentationStyle = UIModalPresentationAutomatic;
        }
        
        [viewController presentViewController:navVC animated:YES completion:nil];
        
        NSLog(@"[授权管理] 成功打开公众号主页");
        
    } @catch (NSException *exception) {
        NSLog(@"[授权管理] 打开公众号主页失败: %@", exception);
        [self openBrandProfileWithBizUtil:contact];
    }
}

- (void)openBrandProfileWithBizUtil:(id)contact {
    Class bizUtilClass = NSClassFromString(@"WCBizUtil");
    if (!bizUtilClass) {
        NSLog(@"[授权管理] 无法获取WCBizUtil类");
        [self searchOfficialAccount];
        return;
    }
    
    SEL openBrandProfileSelector = NSSelectorFromString(@"openBrandProfileViewControllerWithContact:");
    if ([bizUtilClass respondsToSelector:openBrandProfileSelector]) {
        @try {
            ((void (*)(id, SEL, id))objc_msgSend)(bizUtilClass, openBrandProfileSelector, contact);
            NSLog(@"[授权管理] 通过WCBizUtil打开公众号主页");
        } @catch (NSException *exception) {
            NSLog(@"[授权管理] WCBizUtil打开公众号主页失败: %@", exception);
            [self searchOfficialAccount];
        }
    } else {
        NSLog(@"[授权管理] WCBizUtil不支持openBrandProfileViewControllerWithContact方法");
        [self searchOfficialAccount];
    }
}

- (void)searchOfficialAccount {
    NSString *url = [NSString stringWithFormat:@"weixin://findfriend/verifycontact?username=%@", self.officialAccountUserName];
    NSURL *nsurl = [NSURL URLWithString:url];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:nsurl options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:nsurl];
        }
    });
    
    NSLog(@"[授权管理] 打开搜索公众号页面");
}

@end
