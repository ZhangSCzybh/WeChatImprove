#import "CSSettingsHomeCell.h"
#import "CSSettingTableViewCell.h"
#import "CSSettingsHomeTheme.h"

@interface CSSettingsHomeCell ()
@property(nonatomic, strong) UIView *iconBackgroundView;
@property(nonatomic, strong) UIImageView *homeIconView;
@property(nonatomic, strong) UILabel *homeTitleLabel;
@property(nonatomic, strong) UILabel *homeDetailLabel;
@property(nonatomic, strong) UIImageView *homeChevronView;
@property(nonatomic, strong) UIView *homeChevronBackgroundView;
@end

@implementation CSSettingsHomeCell
+ (NSString *)reuseIdentifier {
    return @"CSSettingsHomeCell";
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        self.separatorInset=UIEdgeInsetsMake(0,64,0,0);
        UIView *selected=[UIView new];
        selected.backgroundColor=UIColor.tertiarySystemGroupedBackgroundColor;
        self.selectedBackgroundView=selected;

        _iconBackgroundView=[UIView new];
        _iconBackgroundView.translatesAutoresizingMaskIntoConstraints=NO;
        _iconBackgroundView.layer.cornerRadius=11;
        _iconBackgroundView.isAccessibilityElement=NO;
        [self.contentView addSubview:_iconBackgroundView];

        _homeIconView=[UIImageView new];
        _homeIconView.translatesAutoresizingMaskIntoConstraints=NO;
        _homeIconView.contentMode=UIViewContentModeScaleAspectFit;
        _homeIconView.isAccessibilityElement=NO;
        [_iconBackgroundView addSubview:_homeIconView];

        _homeTitleLabel=[UILabel new];
        _homeTitleLabel.translatesAutoresizingMaskIntoConstraints=NO;
        _homeTitleLabel.font=[[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody]
            scaledFontForFont:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular] maximumPointSize:22];
        _homeTitleLabel.textColor=UIColor.labelColor;
        _homeTitleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [_homeTitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh-1 forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_homeTitleLabel];

        _homeDetailLabel=[UILabel new];
        _homeDetailLabel.translatesAutoresizingMaskIntoConstraints=NO;
        _homeDetailLabel.font=[[UIFontMetrics metricsForTextStyle:UIFontTextStyleFootnote]
            scaledFontForFont:[UIFont systemFontOfSize:13 weight:UIFontWeightRegular] maximumPointSize:16];
        _homeDetailLabel.textColor=UIColor.secondaryLabelColor;
        _homeDetailLabel.textAlignment=NSTextAlignmentRight;
        _homeDetailLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [_homeDetailLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_homeDetailLabel];

        _homeChevronView=[[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"
            withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:12 weight:UIImageSymbolWeightSemibold]]];
        _homeChevronBackgroundView=[[UIView alloc] initWithFrame:CGRectMake(0,0,28,28)];
        _homeChevronBackgroundView.layer.cornerRadius=14;
        _homeChevronBackgroundView.isAccessibilityElement=NO;
        _homeChevronView.frame=CGRectMake(8,4,12,20);
        _homeChevronView.contentMode=UIViewContentModeScaleAspectFit;
        _homeChevronView.isAccessibilityElement=NO;
        [_homeChevronBackgroundView addSubview:_homeChevronView];

        NSLayoutConstraint *minimumHeight=[self.contentView.heightAnchor constraintGreaterThanOrEqualToConstant:56];
        minimumHeight.priority=999;
        [NSLayoutConstraint activateConstraints:@[
            minimumHeight,
            [_iconBackgroundView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
            [_iconBackgroundView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_iconBackgroundView.widthAnchor constraintEqualToConstant:34],
            [_iconBackgroundView.heightAnchor constraintEqualToConstant:34],
            [_homeIconView.centerXAnchor constraintEqualToAnchor:_iconBackgroundView.centerXAnchor],
            [_homeIconView.centerYAnchor constraintEqualToAnchor:_iconBackgroundView.centerYAnchor],
            [_homeIconView.widthAnchor constraintEqualToConstant:18],
            [_homeIconView.heightAnchor constraintEqualToConstant:18],
            [_homeTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:64],
            [_homeTitleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_homeTitleLabel.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:12],
            [_homeTitleLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:-12],
            [_homeDetailLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_homeDetailLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
            [_homeDetailLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:_homeTitleLabel.trailingAnchor constant:10],
            [_homeDetailLabel.widthAnchor constraintLessThanOrEqualToAnchor:self.contentView.widthAnchor multiplier:0.45]
        ]];
    }
    return self;
}
- (void)resetPresentation {
    [self.layer removeAllAnimations];
    [self.contentView.layer removeAllAnimations];
    self.alpha=1;
    self.transform=CGAffineTransformIdentity;
    self.contentView.alpha=1;
    self.contentView.transform=CGAffineTransformIdentity;
    self.accessoryType=UITableViewCellAccessoryNone;
    self.accessoryView=self.homeChevronBackgroundView;
    self.selectionStyle=UITableViewCellSelectionStyleDefault;
}
- (void)prepareForReuse {
    [super prepareForReuse];
    [self resetPresentation];
    self.homeTitleLabel.text=nil;
    self.homeDetailLabel.text=nil;
    self.homeIconView.image=nil;
    self.accessibilityLabel=nil;
}
- (void)configureWithItem:(CSSettingItem *)item {
    [self resetPresentation];
    self.homeTitleLabel.text=item.title;
    self.homeDetailLabel.text=item.detail;
    UIImage *icon=item.customImage ?: [UIImage systemImageNamed:item.iconName ?: @"square.grid.2x2"
        withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:18 weight:UIImageSymbolWeightMedium]];
    self.homeIconView.image=[icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    BOOL about=[item.title isEqualToString:@"版本信息"] || [item.title isEqualToString:@"支持作者"];
    UIColor *accent=about ? CSSettingsHomeTheme.aboutGoldColor : CSSettingsHomeTheme.accentColor;
    self.homeIconView.tintColor=accent;
    self.homeChevronView.tintColor=accent;
    UIColor *wash=[UIColor colorWithDynamicProvider:^UIColor *(UITraitCollection *traits) {
        return [accent colorWithAlphaComponent:traits.userInterfaceStyle==UIUserInterfaceStyleDark ? 0.19 : 0.10];
    }];
    self.iconBackgroundView.backgroundColor=wash;
    self.homeChevronBackgroundView.backgroundColor=wash;
    self.isAccessibilityElement=YES;
    self.accessibilityTraits=UIAccessibilityTraitButton;
    self.accessibilityLabel=item.detail.length ? [NSString stringWithFormat:@"%@，%@",item.title,item.detail] : item.title;
}
@end
