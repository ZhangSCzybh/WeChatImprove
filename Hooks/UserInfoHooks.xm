// UserInfoHooks.xm
// 用于获取微信用户信息和头像URL的整合钩子

#import "../Headers/WCHeaders.h"      // 微信相关的所有类和框架
#import "../Headers/CSUserInfoHelper.h" // 用户信息助手和全局常量
#import <UIKit/UIKit.h>
#import "../Controllers/CSAvatarURLCache.h"
static CSAvatarURLCache *userAvatarCache;
@interface MMContextManager : NSObject @end

#pragma mark - 全局常量定义

// 缓存路径常量
NSString * const kUserAvatarURLKey = @"com.wechat.tweak.user.avatar.url";  // 存储用户头像URL的Key
NSString * const kChatAvatarURLKey = @"com.wechat.tweak.chat.avatar.url";  // 存储聊天对象头像URL的Key

// 聊天界面方法声明
@interface BaseMsgContentViewController (Additions)
- (void)getChatContactInfo;
@end

#pragma mark - CSUserInfoHelper 实现

@implementation CSUserInfoHelper

+ (NSString *)getUserWXID {
    CContact *selfContact = [[%c(CContactMgr) alloc] getSelfContact];
    return selfContact.m_nsUsrName ?: @"";
}

+ (NSString *)getUserNickname {
    CContact *selfContact = [[%c(CContactMgr) alloc] getSelfContact];
    return selfContact.m_nsNickName ?: @"微信用户";
}

+ (NSString *)getUserAliasName {
    CContact *selfContact = [[%c(CContactMgr) alloc] getSelfContact];
    return selfContact.m_nsAliasName ?: @"未知";
}

+ (NSString *)getUserAvatarURL {
    // Resolve the current account instead of returning a previous account's cache.
    CContact *selfContact = [[%c(CContactMgr) alloc] getSelfContact];
    NSString *avatarURL = selfContact.m_nsHeadImgUrl;

    return avatarURL;
}

// 获取格式化的当前时间
+ (NSString *)getCurrentTimeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    return [formatter stringFromDate:[NSDate date]];
}

@end

#pragma mark - 钩子实现

// Hook CContactMgr类获取用户信息
%hook CContactMgr

- (CContact *)getSelfContact {
    NSUInteger generation = [userAvatarCache generation];
    CContact *contact = %orig;
    [userAvatarCache captureURL:contact.m_nsHeadImgUrl account:contact.m_nsUsrName generation:generation];

    return contact;
}

%end

// Hook BaseMsgContentViewController 类以获取聊天界面的头像URL和wxid
%hook BaseMsgContentViewController

// 视图加载完成时
- (void)viewDidLoad {
    %orig;
    
    // 获取当前聊天对象的信息
    [self getChatContactInfo];
}

// 聊天界面即将出现时
- (void)viewWillAppear:(_Bool)animated {
    %orig;
    
    // 获取聊天对象信息
    [self getChatContactInfo];
}

%new
- (void)getChatContactInfo {
    // 获取聊天对象的信息
    CContact *contact = [self GetContact];
    if (contact) {
        // 缓存聊天对象头像URL
        if (contact.m_nsHeadImgUrl.length > 0) {
            NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
            if (![[defaults stringForKey:kChatAvatarURLKey] isEqual:contact.m_nsHeadImgUrl])
                [defaults setObject:contact.m_nsHeadImgUrl forKey:kChatAvatarURLKey];
        }
    }
}

%end

%hook MMContextManager
- (void)logout:(id)context {
    [userAvatarCache accountBoundaryAcceptingContacts:NO];
    %orig;
}
- (void)loginByContext:(id)context {
    // Accept new-account contacts during native service initialization.
    [userAvatarCache accountBoundaryAcceptingContacts:YES];
    %orig;
}
%end

// 主入口函数
%ctor {
    userAvatarCache = [[CSAvatarURLCache alloc] initWithDefaults:NSUserDefaults.standardUserDefaults key:kUserAvatarURLKey];
}
