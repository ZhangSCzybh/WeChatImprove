#import "CSReleaseNotesViewController.h"
#import "CSUserInfoHelper.h"

// 发布时与 kPluginVersionString、control 同步维护。按版本取值，避免显示其他版本的说明。
static NSArray<NSDictionary<NSString *, NSString *> *> *CSCurrentReleaseNotes(void) {
    NSDictionary *releases = @{
        @"1.8-20": @[
            @{@"title": @"参考国民级APP更新",
              @"detail": @"解决了一些已知问题。"}
        ],
        @"1.8-19": @[
            @{@"title": @"聊天分组新增胶囊包裹",
              @"detail": @"分组指示器切换动画改为下划线、胶囊包裹或关闭。保留原下划线效果，胶囊在标题背后原地收拢、展开，支持点击和滑动切组。"},
            @{@"title": @"沿用分组颜色与偏好",
              @"detail": @"胶囊底色使用指示器颜色的浅色填充，标题使用选中文本颜色，深浅色分别配置。升级沿用原动画开关状态，支持系统减弱动态效果。"},
            @{@"title": @"更新界面定制图标",
              @"detail": @"调整顶栏信息、气泡样式、列表圆角、底栏样式、布局设置和聊天分组图标，沿用系统图标与原配色。"}
        ],
        @"1.8-18": @[
            @{@"title": @"红包模块代码整理",
              @"detail": @"清理红包设置保存时的冗余操作和设置常量声明，保留自动领取、自动回复、通知、领取记录和专属红包判断。"}
        ],
        @"1.8-17": @[
            @{@"title": @"收款模块代码整理",
              @"detail": @"清理共用支付模块中无用的参数、返回值和旧校验分支，保留已验证的转账到账核验、自动回复、记录与通知流程。"}
        ],
        @"1.8-16": @[
            @{@"title": @"补齐转账到账核验",
              @"detail": @"确认收款后按交易查询一次最终状态，核验本人收款和实际金额后更新记录、自动回复及收款通知，避免确认回包字段不全导致漏记。"},
            @{@"title": @"转账成功去重",
              @"detail": @"待领取、退回、他人交易和无关联回调不计入收款；重复回包只记录与通知一次，保留账号切换、开关和超时保护。"}
        ],
        @"1.8-15": @[
            @{@"title": @"修复收款与红包领取",
              @"detail": @"修复私聊转账识别、领取请求关联和成功状态兼容；仅处理本人可领取的交易，排除他人之间的转账和他人专属红包。"},
            @{@"title": @"补齐自动回复设置",
              @"detail": @"新增红包自动回复开关，修复领取成功后漏回复的问题；回复开关不影响领取记录累计。"},
            @{@"title": @"修复领取记录更新",
              @"detail": @"本人领取成功后累计次数和金额，并刷新记录页面；已识别交易的手动领取也可统计，同一笔领取只记录一次。"}
        ],
        @"1.8-14": @[
            @{@"title": @"修正自动收款范围",
              @"detail": @"仅处理明确转给本人的转账；确认成功后才回复、通知和统计，避免群内他人转账误回复，保留手动收款流程。"},
            @{@"title": @"完善红包领取与取消",
              @"detail": @"零延迟也遵守串行设置；重复消息、异常回包和超时任务统一清理，关闭功能后撤销待领取任务。"},
            @{@"title": @"减少消息处理开销",
              @"detail": @"缓存设置、限制任务积压并异步保存领取记录；换号及长时间后台后丢弃失效任务，保留已有统计。"}
        ],
        @"1.8-11": @[
            @{@"title": @"改善首条语音处理",
              @"detail": @"语音信息未更新时重新获取原消息记录，读取未就绪时进行一次准备重试；转发和复读仍只提交一次，失败提示更具体。"}
        ],
        @"1.8-10": @[
            @{@"title": @"改善语音转发与复读兼容",
              @"detail": @"修正完整语音因时长标注差异被误判的问题；语音缓存不完整时尝试读取本地文件，并加强群聊与私聊之间的转发校验。"},
            @{@"title": @"优化头像旋转耗电",
              @"detail": @"头像离开可见页面、微信退到后台或设备过热时暂停旋转；旋转开关和速度修改即时生效。"},
            @{@"title": @"减少输入框重复处理",
              @"detail": @"缓存输入框文字、颜色和边框样式，减少输入与键盘切换时的重复工作；关闭自定义样式后恢复原生显示。"}
        ],
        @"1.8-9": @[
            @{@"title": @"减少日常处理开销",
              @"detail": @"精简页面刷新、入口加载和消息处理中的重复记录与无用操作，延续首屏恢复和界面能耗优化。"}
        ],
        @"1.8-8": @[
            @{@"title": @"改善后台返回",
              @"detail": @"调整用户资料缓存和设置刷新，减少长时间后台后返回首屏时相互等待的风险。"},
            @{@"title": @"优化界面耗电",
              @"detail": @"优化触摸轨迹缓存、采样和拖尾回收；底栏动画在不可见、离开前台或设备过热时暂停，恢复后继续显示。"},
            @{@"title": @"减少重复工作",
              @"detail": @"修复布局设置通知循环，合并分组批量消息刷新，减少无关语音和转账消息的额外处理。"}
        ],
        @"1.8-7": @[
            @{@"title": @"参考国民级APP更新",
              @"detail": @"解决了一些已知问题。"},
            @{@"title": @"清理消息操作诊断",
              @"detail": @"重构消息手势和语音复读转发功能。"}
        ],
        @"1.8-6": @[
            @{@"title": @"清理消息操作诊断",
              @"detail": @"移除复读和语音转发设置中的诊断开关、复制入口及临时记录代码。"},
            @{@"title": @"精简多余处理",
              @"detail": @"清理排查期间增加的菜单记录和重复刷新，保留已验证正常的表情复读、骰子猜拳菜单及语音复读转发。"}
        ],
        @"1.8-5": @[
            @{@"title": @"修正已完成语音判断",
              @"detail": @"修正可播放的已下载语音被误判为正在录音的问题，保留录音中、取消和不完整语音的拦截。"},
            @{@"title": @"补齐表情菜单入口",
              @"detail": @"针对手机日志中绕过原菜单入口的表情，在微信去重前补齐复读项，继续保留原生菜单限制。"},
            @{@"title": @"精简诊断记录",
              @"detail": @"减少页面刷新产生的重复记录，保留菜单和语音操作的关键阶段，便于排查。"}
        ],
        @"1.8-4": @[
            @{@"title": @"修正语音发送准备",
              @"detail": @"修正语音复读和转发创建新消息时的兼容性判断；发送失败时区分语音读取、校验和发送准备问题。"},
            @{@"title": @"新增消息操作诊断",
              @"detail": @"复读和语音转发设置新增问题排查入口，按需开启，复现后复制诊断；不记录消息内容或联系人。"},
            @{@"title": @"表情菜单仍在排查",
              @"detail": @"部分独立表情仍缺少复读按钮，本版新增菜单阶段记录以定位原因，尚未确认解决。"}
        ],
        @"1.8-3": @[
            @{@"title": @"精简消息操作处理",
              @"detail": @"引用、收藏、普通转发直接交给微信处理，减少额外等待任务；删除、撤回保留确认和取消校验。"},
            @{@"title": @"修复大表情复读菜单",
              @"detail": @"完善独立大表情、表情包和自定义动图的复读菜单，补齐骰子、猜拳消息的独立菜单入口。"},
            @{@"title": @"减少重复菜单处理",
              @"detail": @"没有菜单变化时复用原有菜单，关闭功能时跳过无关处理；保留微信原有菜单顺序和显示限制。"}
        ],
        @"1.8-2": @[
            @{@"title": @"修复复读提示与文字发送",
              @"detail": @"修复图片、引用复读交给微信处理后仍出现异常提示的问题，并修正普通文字和文字表情的复读处理。"},
            @{@"title": @"补齐消息复读菜单",
              @"detail": @"补齐独立表情、语音、文件和名片的复读菜单，保留微信原有菜单顺序与限制。"},
            @{@"title": @"完善语音准备与转发提示",
              @"detail": @"修正本地语音读取与下载状态判断，准备失败时及时结束等待；增强语音转发不再提前显示微信的成功提示，保留选择、留言和取消流程。"}
        ],
        @"1.8-1": @[
            @{@"title": @"修复消息菜单和手势不可用",
              @"detail": @"修复 1.8-0 在微信 8.0.78 中可能不显示复读、语音转发菜单且无法滑动消息的问题，保留原有设置。"},
            @{@"title": @"修复等待语音时转发被取消",
              @"detail": @"已确认的转发在等待语音准备时，关闭原生转发页面不会再误取消该操作；主动取消仍会停止发送。"}
        ],
        @"1.8-0": @[
            @{@"title": @"统一消息操作处理",
              @"detail": @"消息手势、长按复读和语音转发共用操作处理，保留各自设置；滑动复读不再依赖长按复读开关。"},
            @{@"title": @"完善取消与重复操作保护",
              @"detail": @"滑动取消、消息复用或切换账号时停止未提交操作；转发继续使用微信的收件人选择、确认和留言流程。"},
            @{@"title": @"优化消息滑动与布局配合",
              @"detail": @"统一处理消息滑动、时间和连续消息布局；仅在松手确认后执行动作，减少重复处理并保留系统减弱动态效果适配。"}
        ],
        @"1.7-24": @[
            @{@"title": @"修复首次进入时会话卡片缺失",
              @"detail": @"会话原生布局完成后同步卡片背景与圆角遮罩尺寸，处理首次加载、行高变化和占位会话切换时背景覆盖不完整的问题。"}
        ],
        @"1.7-23": @[
            @{@"title": @"整理列表圆角实现",
              @"detail": @"清理无效参数、重复代码及多余重绘请求，保留四页圆角、未读提示、好友数量背景和已有设置。"}
        ],
        @"1.7-22": @[
            @{@"title": @"补齐通讯录底部背景",
              @"detail": @"好友数量区域与通讯录背景保持一致，保留原生人数文字和布局，并包含此前发现页未读提示、分割线及资料卡片圆角修复。"}
        ],
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
