//
// CSRedEnvelopSettingsViewController.h
// 红包功能设置界面
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// UserDefaults Key常量
static NSString * const kRedEnvelopAutoReceiveKey = @"com.wechat.enhance.redenvelop.autoReceive";
static NSString * const kRedEnvelopPrivateEnableKey = @"com.wechat.enhance.redenvelop.privateEnable";
static NSString * const kRedEnvelopGroupEnableKey = @"com.wechat.enhance.redenvelop.groupEnable";
static NSString * const kRedEnvelopDelayKey = @"com.wechat.enhance.redenvelop.delay";
static NSString * const kRedEnvelopReceiveSelfKey = @"com.wechat.enhance.redenvelop.receiveSelf";
static NSString * const kRedEnvelopSerialReceiveKey = @"com.wechat.enhance.redenvelop.serialReceive";
static NSString * const kRedEnvelopGroupScopeKey = @"com.wechat.enhance.redenvelop.groupScope";
static NSString * const kRedEnvelopAllowedGroupsKey = @"com.wechat.enhance.redenvelop.allowedGroups";
static NSString * const kRedEnvelopBlockedGroupsKey = @"com.wechat.enhance.redenvelop.blockedGroups";
static NSString * const kRedEnvelopPrivateReplyKey = @"com.wechat.enhance.redenvelop.privateReply";
static NSString * const kRedEnvelopGroupReplyKey = @"com.wechat.enhance.redenvelop.groupReply";
static NSString * const kRedEnvelopNotifyTargetKey = @"com.wechat.enhance.redenvelop.notifyTarget";
static NSString * const kRedEnvelopPageSummaryKey = @"com.wechat.enhance.redenvelop.pageSummary";

@interface CSRedEnvelopSettingsViewController : UITableViewController

@end

NS_ASSUME_NONNULL_END
