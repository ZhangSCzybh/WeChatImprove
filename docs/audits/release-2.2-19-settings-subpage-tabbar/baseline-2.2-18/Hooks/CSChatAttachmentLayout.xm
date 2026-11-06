#import "../Controllers/CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 保存设置的键
static NSString * const kChatAttachmentLayoutEnabledKey = @"com.wechat.tweak.chat.attachment.layout.enabled";
static NSString * const kChatAttachmentColumnsKey = @"com.wechat.tweak.chat.attachment.columns";
static NSString * const kChatAttachmentSpacingKey = @"com.wechat.tweak.chat.attachment.spacing";
// 场景控制相关键
static NSString * const kChatAttachmentShowInPrivateKey = @"com.wechat.tweak.chat.attachment.show.in.private";
static NSString * const kChatAttachmentShowInGroupKey = @"com.wechat.tweak.chat.attachment.show.in.group";
static NSString * const kChatAttachmentShowInOfficialKey = @"com.wechat.tweak.chat.attachment.show.in.official";
// 公众号自定义排序相关键
static NSString * const kChatAttachmentOfficialSortEnabledKey = @"com.wechat.tweak.chat.attachment.official.sort.enabled";
static NSString * const kChatAttachmentOfficialSortOrderKey = @"com.wechat.tweak.chat.attachment.official.sort.order";
// 私聊自定义排序相关键
static NSString * const kChatAttachmentPrivateSortEnabledKey = @"com.wechat.tweak.chat.attachment.private.sort.enabled";
static NSString * const kChatAttachmentPrivateSortOrderKey = @"com.wechat.tweak.chat.attachment.private.sort.order";
// 群聊自定义排序相关键
static NSString * const kChatAttachmentGroupSortEnabledKey = @"com.wechat.tweak.chat.attachment.group.sort.enabled";
static NSString * const kChatAttachmentGroupSortOrderKey = @"com.wechat.tweak.chat.attachment.group.sort.order";
// 按钮隐藏相关键
static NSString * const kChatAttachmentOfficialHiddenButtonsKey = @"com.wechat.tweak.chat.attachment.official.hidden.buttons";
static NSString * const kChatAttachmentPrivateHiddenButtonsKey = @"com.wechat.tweak.chat.attachment.private.hidden.buttons";
static NSString * const kChatAttachmentGroupHiddenButtonsKey = @"com.wechat.tweak.chat.attachment.group.hidden.buttons";

// 设置默认值
static const int kDefaultColumns = 5;
static const float kDefaultSpacing = 0.0f;
static const float kBaseSpacing = 8.0f; // 微信默认基础间距

// 公众号按钮Tag常量
static const int kTagPhoto = 18000;       // 照片
static const int kTagCamera = 18001;      // 拍摄
static const int kTagLocation = 18002;    // 位置
static const int kTagVoiceInput = 18003;  // 语音输入 
static const int kTagFavorite = 18004;    // 收藏
static const int kTagContact = 18005;     // 个人名片

// 私聊按钮Tag常量
static const int kPrivateTagPhoto = 18000;       // 照片
static const int kPrivateTagCamera = 18001;      // 拍摄
static const int kPrivateTagVideoCall = 18002;   // 视频通话
static const int kPrivateTagLocation = 18003;    // 位置
static const int kPrivateTagRedPacket = 18004;   // 红包
static const int kPrivateTagGift = 18005;        // 礼物
static const int kPrivateTagTransfer = 18006;    // 转账
static const int kPrivateTagVoiceInput = 18007;  // 语音输入
static const int kPrivateTagFavorite = 18008;    // 收藏
static const int kPrivateTagContact = 18009;     // 个人名片
static const int kPrivateTagFile = 18010;        // 文件
static const int kPrivateTagCard = 18011;        // 卡券
static const int kPrivateTagMusic = 18012;       // 音乐

// 群聊按钮Tag常量 
static const int kGroupTagPhoto = 18000;        // 照片
static const int kGroupTagCamera = 18001;       // 拍摄
static const int kGroupTagVoiceCall = 18002;    // 语音通话
static const int kGroupTagLocation = 18003;     // 位置
static const int kGroupTagRedPacket = 18004;    // 红包
static const int kGroupTagGift = 18005;         // 礼物
static const int kGroupTagTransfer = 18006;     // 转账
static const int kGroupTagVoiceInput = 18007;   // 语音输入
static const int kGroupTagFavorite = 18008;     // 收藏
static const int kGroupTagGroupTool = 18009;    // 群工具
static const int kGroupTagChain = 18010;        // 接龙
static const int kGroupTagLiveStream = 18011;   // 直播
static const int kGroupTagContact = 18012;      // 个人名片
static const int kGroupTagFile = 18013;         // 文件
static const int kGroupTagCard = 18014;         // 卡券
static const int kGroupTagMusic = 18015;        // 音乐

// 导入微信相关头文件的声明
@interface SelectAttachmentView : UIView
- (void)layoutSubviews;
- (double)itemOffset;
- (struct CGRect)calculateEmoticonViewFrameAtIndex:(unsigned int)arg1 forViewWidth:(double)arg2;
@end

@interface AttachmentButton : UIButton
@end

@interface CBaseContact : NSObject
@property(retain, nonatomic) NSString *m_nsUsrName;
@end

@interface MMUIViewController : UIViewController
@end

@interface CBaseMessageViewController : MMUIViewController
- (id)getMainTableDataSource;
- (CBaseContact *)GetContact;
@end

@interface BaseMsgContentViewController : CBaseMessageViewController
@end

// 存储SelectAttachmentView的宽度，初始值使用设备屏幕宽度
static CGFloat viewWidth = 0;

// 存储当前聊天场景状态
static BOOL currentChatIsPrivate = NO;
static BOOL currentChatIsGroup = NO;
static BOOL currentChatIsOfficial = NO;
static NSString *currentChatID = nil;

// BEGIN Attachment layout snapshot
// The cache owns Foundation values only. Geometry and native frame side effects stay live.
@interface CSAttachmentLayoutSnapshot : NSObject
@property(nonatomic) NSUInteger revision, scene;
@property(nonatomic,copy) NSString *chatID;
@property(nonatomic) BOOL enabled, sorting;
@property(nonatomic) int columns;
@property(nonatomic) float spacing;
@property(nonatomic,copy) NSArray<NSNumber *> *tags, *visiblePrefix;
@property(nonatomic,copy) NSDictionary<NSNumber *,NSNumber *> *positions;
@property(nonatomic,copy) NSSet *hidden;
@end
@implementation CSAttachmentLayoutSnapshot @end
static NSUInteger CSAttachmentLayoutRevision;
static CSAttachmentLayoutSnapshot *CSAttachmentLayoutCached;
static void CSAttachmentLayoutInvalidate(void) {
    CSAttachmentLayoutRevision++;CSAttachmentLayoutCached=nil;
}
static void CSAttachmentLayoutObserveSettings(NSUserDefaults *defaults) {
    [NSNotificationCenter.defaultCenter addObserverForName:@"CSChatAttachmentLayoutSettingsChanged"
        object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) {
            CSAttachmentLayoutInvalidate();
        }];
    [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification
        object:defaults queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) {
            CSAttachmentLayoutInvalidate();
        }];
}
static NSUInteger CSAttachmentLayoutScene(void) {
    return currentChatIsOfficial ? 3 : currentChatIsPrivate ? 1 : currentChatIsGroup ? 2 : 0;
}
static NSArray *CSAttachmentDefaultTags(NSUInteger scene) {
    static NSArray *officialTags, *privateTags, *groupTags;
    static dispatch_once_t once;dispatch_once(&once, ^{
        officialTags=@[@(kTagPhoto),@(kTagCamera),@(kTagLocation),@(kTagVoiceInput),@(kTagFavorite),@(kTagContact)];
        privateTags=@[@(kPrivateTagPhoto),@(kPrivateTagCamera),@(kPrivateTagVideoCall),@(kPrivateTagLocation),@(kPrivateTagRedPacket),@(kPrivateTagGift),@(kPrivateTagTransfer),@(kPrivateTagVoiceInput),@(kPrivateTagFavorite),@(kPrivateTagContact),@(kPrivateTagFile),@(kPrivateTagCard),@(kPrivateTagMusic)];
        groupTags=@[@(kGroupTagPhoto),@(kGroupTagCamera),@(kGroupTagVoiceCall),@(kGroupTagLocation),@(kGroupTagRedPacket),@(kGroupTagGift),@(kGroupTagTransfer),@(kGroupTagVoiceInput),@(kGroupTagFavorite),@(kGroupTagGroupTool),@(kGroupTagChain),@(kGroupTagLiveStream),@(kGroupTagContact),@(kGroupTagFile),@(kGroupTagCard),@(kGroupTagMusic)];
    });
    return scene==3 ? officialTags : scene==2 ? groupTags : privateTags;
}
static CSAttachmentLayoutSnapshot *CSAttachmentLayoutConfiguration(void) {
    NSUInteger scene=CSAttachmentLayoutScene();NSString *chatID=currentChatID ?: @"";
    CSAttachmentLayoutSnapshot *cached=CSAttachmentLayoutCached;
    if (cached && cached.revision==CSAttachmentLayoutRevision && cached.scene==scene && [cached.chatID isEqual:chatID]) return cached;
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    CSAttachmentLayoutSnapshot *snapshot=[CSAttachmentLayoutSnapshot new];
    snapshot.scene=scene;snapshot.chatID=chatID;snapshot.tags=CSAttachmentDefaultTags(scene);
    snapshot.enabled=[defaults boolForKey:kChatAttachmentLayoutEnabledKey];
    if (snapshot.enabled) {
        NSString *showKey=scene==3 ? kChatAttachmentShowInOfficialKey : scene==2 ? kChatAttachmentShowInGroupKey : kChatAttachmentShowInPrivateKey;
        snapshot.enabled=[defaults boolForKey:showKey];
    }
    snapshot.columns=kDefaultColumns;snapshot.spacing=kBaseSpacing+kDefaultSpacing;
    snapshot.hidden=[NSSet set];snapshot.positions=@{};snapshot.visiblePrefix=@[@0];
    if (snapshot.enabled) {
        snapshot.columns=[defaults objectForKey:kChatAttachmentColumnsKey] ? (int)[defaults integerForKey:kChatAttachmentColumnsKey] : kDefaultColumns;
        snapshot.spacing=kBaseSpacing+([defaults objectForKey:kChatAttachmentSpacingKey] ? [defaults floatForKey:kChatAttachmentSpacingKey] : kDefaultSpacing);
        NSString *sortKey=scene==3 ? kChatAttachmentOfficialSortEnabledKey : scene==2 ? kChatAttachmentGroupSortEnabledKey : kChatAttachmentPrivateSortEnabledKey;
        snapshot.sorting=scene!=0 && [defaults boolForKey:sortKey];
        if (snapshot.sorting) {
            NSString *orderKey=scene==3 ? kChatAttachmentOfficialSortOrderKey : scene==2 ? kChatAttachmentGroupSortOrderKey : kChatAttachmentPrivateSortOrderKey;
            NSString *hiddenKey=scene==3 ? kChatAttachmentOfficialHiddenButtonsKey : scene==2 ? kChatAttachmentGroupHiddenButtonsKey : kChatAttachmentPrivateHiddenButtonsKey;
            NSArray *order=[[defaults arrayForKey:orderKey] copy];
            // Preserve the original lazy default initialization, including empty orders.
            if (!order.count) { order=snapshot.tags;[defaults setObject:order forKey:orderKey];[defaults synchronize]; }
            snapshot.hidden=[NSSet setWithArray:[defaults arrayForKey:hiddenKey] ?: @[]];
            NSMutableDictionary *positions=[NSMutableDictionary dictionary];
            NSMutableArray *prefix=[NSMutableArray arrayWithObject:@0];NSUInteger visible=0;
            for (id tag in order) {
                if (!positions[tag]) positions[tag]=@(prefix.count-1); // indexOfObject used the first occurrence.
                if (![snapshot.hidden containsObject:tag]) visible++;
                [prefix addObject:@(visible)];
            }
            snapshot.positions=positions;snapshot.visiblePrefix=prefix;
        }
    }
    snapshot.revision=CSAttachmentLayoutRevision;CSAttachmentLayoutCached=snapshot;return snapshot;
}
static CGRect CSAttachmentLayoutFrame(CSAttachmentLayoutSnapshot *config,unsigned int index,CGFloat width) {
    NSUInteger mapped=index;
    if (config.sorting) {
        NSNumber *tag=config.tags[index % config.tags.count];
        if ([config.hidden containsObject:tag]) return CGRectMake(width*100,0,0,0);
        NSNumber *position=config.positions[tag];if (position) mapped=position.unsignedIntegerValue;
    }
    // Preserve existing no-sort and unknown-index placement semantics.
    NSUInteger visible=[config.visiblePrefix[MIN(mapped,config.visiblePrefix.count-1)] unsignedIntegerValue];
    NSUInteger perPage=(NSUInteger)config.columns*2, page=visible/perPage, inPage=visible%perPage;
    CGFloat start=(width-(65.0*config.columns+config.spacing*(config.columns-1)))/2.0;
    return CGRectMake(start+(inPage%config.columns)*(65.0+config.spacing)+page*width,(inPage/config.columns)*96.0,65.0,96.0);
}
// END Attachment layout snapshot

// 钩住BaseMsgContentViewController来识别聊天类型
%hook BaseMsgContentViewController

- (void)viewDidLoad {
    %orig;
    
    // 重置聊天类型状态
    currentChatIsPrivate = NO;
    currentChatIsGroup = NO;
    currentChatIsOfficial = NO;
    currentChatID = nil;
    
    // 获取聊天联系人
    CBaseContact *contact = [self GetContact];
    if (!contact) {
        return;
    }
    
    // 获取聊天ID
    NSString *chatID = contact.m_nsUsrName;
    if (!chatID) {
        return;
    }
    
    // 保存当前聊天ID
    currentChatID = chatID;
    
    // 判断聊天类型
    if ([chatID hasPrefix:@"gh_"]) {
        // 公众号聊天
        currentChatIsOfficial = YES;
    } else if ([chatID hasSuffix:@"@chatroom"]) {
        // 群聊
        currentChatIsGroup = YES;
    } else if ([chatID hasPrefix:@"wxid_"] || ![chatID containsString:@"@"]) {
        // 私聊 - 处理wxid_前缀和普通用户名（不包含@符号的）
        currentChatIsPrivate = YES;
    } else {
        // 其他类型的聊天（如企业号、小程序等）
        // 启用布局功能但不参与排序
        currentChatIsPrivate = YES; // 视为私聊，但使用默认排序，不会影响实际排序
        currentChatIsGroup = NO;
        currentChatIsOfficial = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    
    // 更新聊天联系人信息（防止中途切换联系人）
    CBaseContact *contact = [self GetContact];
    if (!contact) {
        return;
    }
    
    // 获取聊天ID
    NSString *chatID = contact.m_nsUsrName;
    if (!chatID) {
        return;
    }
    
    // 保存/更新当前聊天ID
    currentChatID = chatID;
    
    // 重置并更新聊天类型
    currentChatIsPrivate = NO;
    currentChatIsGroup = NO;
    currentChatIsOfficial = NO;
    
    if ([chatID hasPrefix:@"gh_"]) {
        // 公众号聊天
        currentChatIsOfficial = YES;
    } else if ([chatID hasSuffix:@"@chatroom"]) {
        // 群聊
        currentChatIsGroup = YES;
    } else if ([chatID hasPrefix:@"wxid_"] || ![chatID containsString:@"@"]) {
        // 私聊 - 处理wxid_前缀和普通用户名（不包含@符号的）
        currentChatIsPrivate = YES;
    } else {
        // 其他类型的聊天（如企业号、小程序等）
        // 启用布局功能但不参与排序
        currentChatIsPrivate = YES; // 视为私聊，但使用默认排序，不会影响实际排序
        currentChatIsGroup = NO;
        currentChatIsOfficial = NO;
    }
}

%end

%hook SelectAttachmentView

// 钩住layoutSubviews来观察整体布局和保存实际宽度
- (void)layoutSubviews {
    // Recheck effective preferences once per native layout, including external changes.
    CSAttachmentLayoutInvalidate();
    %orig;
    
    // 保存实际宽度
    viewWidth = self.bounds.size.width;
}

// 完全重写计算方法，使用我们存储的视图实际宽度
- (struct CGRect)calculateEmoticonViewFrameAtIndex:(unsigned int)arg1 forViewWidth:(double)arg2 {
    CSAttachmentLayoutSnapshot *config=CSAttachmentLayoutConfiguration();
    if (!config.enabled) return %orig(arg1,arg2);
    // Native implementations may update bookkeeping; retain the original call.
    %orig;
    return CSAttachmentLayoutFrame(config,arg1,viewWidth);
}

%end

// 添加Notification监听，当设置改变时更新状态
%ctor {
    CSBackupWhenReady(^{
        // 默认值初始化 - 如果键不存在，设置默认值
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        // 检查场景控制设置是否存在，如不存在则设置默认值(全部开启)
        if (![defaults objectForKey:kChatAttachmentShowInPrivateKey]) {
            [defaults setBool:YES forKey:kChatAttachmentShowInPrivateKey];
        }

        if (![defaults objectForKey:kChatAttachmentShowInGroupKey]) {
            [defaults setBool:YES forKey:kChatAttachmentShowInGroupKey];
        }

        if (![defaults objectForKey:kChatAttachmentShowInOfficialKey]) {
            [defaults setBool:YES forKey:kChatAttachmentShowInOfficialKey];
        }

        // 初始化公众号排序设置
        if (![defaults objectForKey:kChatAttachmentOfficialSortEnabledKey]) {
            [defaults setBool:YES forKey:kChatAttachmentOfficialSortEnabledKey];
        }

        // 初始化私聊排序设置
        if (![defaults objectForKey:kChatAttachmentPrivateSortEnabledKey]) {
            [defaults setBool:YES forKey:kChatAttachmentPrivateSortEnabledKey];
        }

        // 初始化群聊排序设置
        if (![defaults objectForKey:kChatAttachmentGroupSortEnabledKey]) {
            [defaults setBool:YES forKey:kChatAttachmentGroupSortEnabledKey];
        }

        // 同步设置
        [defaults synchronize];

        CSAttachmentLayoutObserveSettings(defaults);
        %init;
    });
}
