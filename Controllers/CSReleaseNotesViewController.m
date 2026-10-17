#import "CSReleaseNotesViewController.h"
#import "CSUserInfoHelper.h"

// 发布时与 kPluginVersionString、control 同步维护。按版本取值，避免显示其他版本的说明。
static NSArray<NSDictionary<NSString *, NSString *> *> *CSCurrentReleaseNotes(void) {
    NSDictionary *releases = @{
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
