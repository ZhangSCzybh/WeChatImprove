#import "CSReleaseNotesViewController.h"
#import "CSUserInfoHelper.h"

// 发布时与 kPluginVersionString、control 同步维护。按版本取值，避免显示其他版本的说明。
static NSArray<NSDictionary<NSString *, NSString *> *> *CSCurrentReleaseNotes(void) {
    NSDictionary *releases = @{
        @"1.7-21": @[
            @{@"title": @"修复发现页未读提示错位",
              @"detail": @"保留视频号、直播等入口的标题、未读文字、头像和红点布局，处理长提示与标题重叠。"},
            @{@"title": @"包含通讯录与资料卡修复",
              @"detail": @"保留星标朋友、字母导航背景、列表分割线及个人资料卡片圆角修复。"}
        ],
        @"1.7-20": @[
            @{@"title": @"修复通讯录圆角显示",
              @"detail": @"统一星标朋友与字母分组标题的背景，清理卡片边缘和行间残留分割线。"},
            @{@"title": @"修复个人资料卡片圆角",
              @"detail": @"处理资料卡片的原生背景遮挡，并清理“我”页面原生布局后重现的分割线。"}
        ],
        @"1.7-19": @[
            @{@"title": @"整理四页列表圆角",
              @"detail": @"统一会话、通讯录、发现和我的列表圆角处理，保留各页布局、独立左右边距、会话间距和颜色设置。"},
            @{@"title": @"完善列表复用与资料卡显示",
              @"detail": @"列表复用、宽度变化或原生布局刷新后恢复卡片样式，保留角标、二维码和状态卡片展开收起。"}
        ],
        @"1.7-17": @[
            @{@"title": @"后台模糊功能整理",
              @"detail": @"保留已验证的 0.22 秒模糊与快照淡出过渡，统一动画和快照清理，减少重复处理。"}
        ],
        @"1.7-16": @[
            @{@"title": @"调整返回微信时的模糊呈现",
              @"detail": @"返回时以当前模糊画面的临时快照做 0.22 秒淡出，让清晰页面逐渐显露，减少实时模糊材质消退时的亮度突变。"}
        ],
        @"1.7-15": @[
            @{@"title": @"优化返回微信的清晰过渡",
              @"detail": @"返回微信与进入切换器统一使用 0.22 秒平滑过渡，减少动画结束时的重复效果设置，并避免无关配置刷新打断动画。"}
        ],
        @"1.7-14": @[
            @{@"title": @"优化后台模糊过渡",
              @"detail": @"进入 App 切换器时渐入模糊，回到微信时平滑恢复清晰；快速往返时动画反向衔接，并适配系统减弱动态效果。"}
        ],
        @"1.7-13": @[
            @{@"title": @"新增后台模糊",
              @"detail": @"在功能增强中开启后台模糊后，拉起 App 切换器或切到后台时模糊微信页面，回到微信后恢复清晰。支持深浅色显示，开关立即生效。"}
        ],
        @"1.7-12": @[
            @{@"title": @"参考国民级APP更新",
              @"detail": @"解决了一些已知问题。"}
        ],
        @"1.7-11": @[
            @{@"title": @"调整指示器拖动收缩效果",
              @"detail": @"拖动时指示器先缩短再恢复，中间阶段最窄为正常宽度的 30%；松手或取消时平滑恢复，不再额外拉长。"}
        ],
        @"1.7-10": @[
            @{@"title": @"修复搜索转场闪现全部会话",
              @"detail": @"使用分组栏搜索时保留当前分组列表，避免进入和返回过程中先显示全部会话；返回后合并更新搜索期间的数据变化。"},
            @{@"title": @"分组指示器随手势移动",
              @"detail": @"横滑开始即响应，指示器随拖动距离移动；取消手势回到原组，松手确认后立即完成切换。"},
            @{@"title": @"增强指示器伸缩效果",
              @"detail": @"加大滑动中的伸长幅度，缩短落位动画；继续支持关闭动画和系统减弱动态效果。"}
        ],
        @"1.7-9": @[
            @{@"title": @"修复分组搜索切换闪现",
              @"detail": @"使用分组栏搜索按钮进入搜索及返回时，保持列表分组栏稳定，避免先显示原生搜索框再切回分组栏。"},
            @{@"title": @"调整分组搜索图标",
              @"detail": @"采用原生风格的细线放大镜样式，支持深浅色显示。"},
            @{@"title": @"减少分组无效刷新",
              @"detail": @"限制重复失败重试和交互等待；微信非活跃或聊天列表不可见时暂停分组界面刷新。"},
            @{@"title": @"优化消息更新计算",
              @"detail": @"复用分组成员索引和计算结果；普通会话结构不变时优先更新需要刷新的可见行，减少整表重载。"}
        ],
        @"1.7-8": @[
            @{@"title": @"优化撤回提示用户名显示",
              @"detail": @"统一用户名引号，修复提示中出现 &quot; 和重复引号的问题。"},
            @{@"title": @"清理防撤回调试代码",
              @"detail": @"移除运行日志、无效设置通知及问题排查入口，保留原消息保护和点击原文定位。"}
        ],
        @"1.7-7": @[
            @{@"title": @"修复群聊防撤回兼容问题",
              @"detail": @"兼容带群成员前缀的撤回通知，完善群会话与原消息的身份校验。"},
            @{@"title": @"完善本人撤回判断",
              @"detail": @"结合原消息的实际发送者判断，避免通知收发方向影响群聊防撤回。"},
            @{@"title": @"保留撤回提示与原文定位",
              @"detail": @"沿用撤回提示和原文跳转；提示插入失败时仍保留已验证的原消息。"}
        ],
        @"1.7-6": @[
            @{@"title": @"修复支持作者闪退",
              @"detail": @"修正赞赏流程的页面兼容处理，由微信原生控制器承载设置界面。"},
            @{@"title": @"保持原生赞赏直达",
              @"detail": @"点击支持作者后直接打开微信赞赏金额选择页，不显示插件中转页或结束页。"},
            @{@"title": @"完善等待与返回处理",
              @"detail": @"等待跳转时避免重复操作；退出或打开失败后清理请求并恢复设置页操作。"}
        ],
        @"1.7-1": @[
            @{@"title": @"新增更新内容查看入口",
              @"detail": @"点击设置页“关于”分区中的“版本信息”，即可查看当前安装版本的更新内容。"},
            @{@"title": @"支持离线查看",
              @"detail": @"更新说明随安装包提供，无需联网即可阅读，并与当前安装版本对应。"},
            @{@"title": @"适配阅读体验",
              @"detail": @"更新内容支持滚动阅读，并跟随系统字号和深色模式显示。"}
        ]
    };
    return releases[kPluginVersionString] ?: @[
        @{@"title": @"暂无更新说明",
          @"detail": @"此安装版本尚未附带更新说明。"}
    ];
}

@interface CSReleaseNotesViewController ()
@property(nonatomic, copy) NSArray<NSDictionary<NSString *, NSString *> *> *releaseNotes;
@end

@implementation CSReleaseNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本更新内容";
    self.releaseNotes = CSCurrentReleaseNotes();
    self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 88;
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"ReleaseNoteCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.releaseNotes.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"当前版本" : @"本次更新";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseNoteCell" forIndexPath:indexPath];
    UIListContentConfiguration *content = [cell defaultContentConfiguration];
    if (indexPath.section == 0) {
        content.text = @"WeChatImprove";
        content.secondaryText = [NSString stringWithFormat:@"版本 %@", kPluginVersionString];
    } else {
        NSDictionary<NSString *, NSString *> *note = self.releaseNotes[indexPath.row];
        content.text = note[@"title"];
        content.secondaryText = note[@"detail"];
    }
    content.textProperties.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    content.textProperties.color = UIColor.labelColor;
    content.textProperties.numberOfLines = 0;
    content.textProperties.adjustsFontForContentSizeCategory = YES;
    content.secondaryTextProperties.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    content.secondaryTextProperties.color = UIColor.secondaryLabelColor;
    content.secondaryTextProperties.numberOfLines = 0;
    content.secondaryTextProperties.adjustsFontForContentSizeCategory = YES;
    content.textToSecondaryTextVerticalPadding = 8;
    cell.contentConfiguration = content;
    cell.backgroundColor = UIColor.secondarySystemGroupedBackgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
