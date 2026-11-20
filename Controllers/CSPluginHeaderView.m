#import "CSPluginHeaderView.h"
#import "CSSettingsHomeTheme.h"
#import <math.h>

static UIFont *CSHeaderFont(CGFloat size, UIFontWeight weight, UIFontTextStyle style, CGFloat maximum) {
    return [[UIFontMetrics metricsForTextStyle:style] scaledFontForFont:[UIFont systemFontOfSize:size weight:weight]
                                                    maximumPointSize:maximum];
}

static UIFont *CSHeaderVIPFont(void) {
    UIFont *font=[UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:12.5]
        ?: [UIFont systemFontOfSize:12.5 weight:UIFontWeightSemibold];
    return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleCaption2] scaledFontForFont:font maximumPointSize:15.5];
}

@interface CSPluginHeaderMetricView : UIView
@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *valueLabel;
@property(nonatomic, strong) UILabel *captionLabel;
- (instancetype)initWithIcon:(NSString *)icon caption:(NSString *)caption;
@end

@implementation CSPluginHeaderMetricView
- (instancetype)initWithIcon:(NSString *)icon caption:(NSString *)caption {
    if ((self=[super initWithFrame:CGRectZero])) {
        self.backgroundColor=UIColor.systemGroupedBackgroundColor;
        self.layer.cornerRadius=12;
        self.isAccessibilityElement=YES;
        _iconView=[[UIImageView alloc] initWithImage:[UIImage systemImageNamed:icon]];
        _iconView.contentMode=UIViewContentModeScaleAspectFit;
        _iconView.tintColor=UIColor.labelColor;
        _valueLabel=[UILabel new];
        _valueLabel.font=CSHeaderFont(15,UIFontWeightSemibold,UIFontTextStyleCaption1,16);
        _valueLabel.textColor=UIColor.labelColor;
        _valueLabel.adjustsFontSizeToFitWidth=YES;
        _valueLabel.minimumScaleFactor=0.7;
        _valueLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        _captionLabel=[UILabel new];
        _captionLabel.font=CSHeaderFont(12.5,UIFontWeightRegular,UIFontTextStyleCaption2,15);
        _captionLabel.textColor=UIColor.secondaryLabelColor;
        _captionLabel.text=caption;
        _captionLabel.adjustsFontSizeToFitWidth=YES;
        _captionLabel.minimumScaleFactor=0.8;
        [self addSubview:_iconView];
        [self addSubview:_valueLabel];
        [self addSubview:_captionLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.bounds), height=CGRectGetHeight(self.bounds);
    CGFloat valueHeight=ceil(self.valueLabel.font.lineHeight);
    CGFloat naturalValueWidth=[self.valueLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,valueHeight)].width;
    BOOL compact=width<76 || naturalValueWidth*self.valueLabel.minimumScaleFactor>MAX(0,width-32);
    self.iconView.hidden=compact;
    self.iconView.frame=CGRectMake(8,8,12,valueHeight);
    CGFloat valueX=compact ? 8 : 24;
    self.valueLabel.frame=CGRectMake(valueX,8,MAX(0,width-valueX-8),valueHeight);
    self.captionLabel.frame=CGRectMake(8,9+valueHeight,MAX(0,width-16),MAX(0,height-valueHeight-14));
}
@end

@interface CSPluginHeaderView ()
@property(nonatomic, strong, readwrite) UIImageView *avatarImageView;
@property(nonatomic, strong) UIView *cardView;
@property(nonatomic, strong) UILabel *nicknameLabel;
@property(nonatomic, strong) UIView *vipCapsule;
@property(nonatomic, strong) UILabel *vipLabel;
@property(nonatomic, strong) UILabel *wechatIDLabel;
@property(nonatomic, strong) NSArray<CSPluginHeaderMetricView *> *metrics;
@property(nonatomic, strong) UIImageView *quoteView;
@property(nonatomic, strong) UILabel *verseLabel;
@end

@implementation CSPluginHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        _horizontalInset=20;
        self.backgroundColor=UIColor.clearColor;
        _cardView=[UIView new];
        _cardView.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        _cardView.layer.cornerRadius=24;
        [self addSubview:_cardView];

        _avatarImageView=[UIImageView new];
        _avatarImageView.contentMode=UIViewContentModeScaleAspectFill;
        _avatarImageView.backgroundColor=UIColor.systemGray5Color;
        _avatarImageView.tintColor=UIColor.systemGray3Color;
        _avatarImageView.layer.cornerRadius=15;
        _avatarImageView.clipsToBounds=YES;
        _avatarImageView.isAccessibilityElement=YES;
        _avatarImageView.accessibilityLabel=@"头像";
        [self resetAvatarImage];
        [_cardView addSubview:_avatarImageView];

        _nicknameLabel=[UILabel new];
        _nicknameLabel.font=CSHeaderFont(22,UIFontWeightSemibold,UIFontTextStyleHeadline,27);
        _nicknameLabel.textColor=UIColor.labelColor;
        _nicknameLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [_cardView addSubview:_nicknameLabel];

        _vipCapsule=[UIView new];
        _vipCapsule.backgroundColor=[UIColor colorWithRed:248.0/255 green:216.0/255 blue:169.0/255 alpha:1];
        _vipCapsule.clipsToBounds=YES;
        _vipCapsule.isAccessibilityElement=YES;
        _vipCapsule.accessibilityLabel=@"SVIP";
        [_cardView addSubview:_vipCapsule];
        _vipLabel=[UILabel new];
        _vipLabel.text=@"SVIP";
        _vipLabel.font=CSHeaderVIPFont();
        _vipLabel.textColor=UIColor.blackColor;
        _vipLabel.textAlignment=NSTextAlignmentCenter;
        _vipLabel.numberOfLines=1;
        [_vipCapsule addSubview:_vipLabel];

        _wechatIDLabel=[UILabel new];
        _wechatIDLabel.font=CSHeaderFont(14,UIFontWeightRegular,UIFontTextStyleCaption2,16);
        _wechatIDLabel.textColor=UIColor.secondaryLabelColor;
        _wechatIDLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [_cardView addSubview:_wechatIDLabel];

        _quoteView=[[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"quote.opening"]];
        _quoteView.contentMode=UIViewContentModeScaleAspectFit;
        _quoteView.tintColor=CSSettingsHomeTheme.accentColor;
        [_cardView addSubview:_quoteView];
        _verseLabel=[UILabel new];
        _verseLabel.font=CSHeaderFont(15,UIFontWeightMedium,UIFontTextStyleFootnote,18);
        _verseLabel.textColor=UIColor.secondaryLabelColor;
        _verseLabel.numberOfLines=2;
        _verseLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [_cardView addSubview:_verseLabel];

        _metrics=@[[[CSPluginHeaderMetricView alloc] initWithIcon:@"bolt.fill" caption:@"已开启"],
                   [[CSPluginHeaderMetricView alloc] initWithIcon:@"shippingbox.fill" caption:@"插件版本"],
                   [[CSPluginHeaderMetricView alloc] initWithIcon:@"message.fill" caption:@"微信版本"]];
        // Allow long version labels to scale inside the shared card width.
        _metrics[1].valueLabel.minimumScaleFactor=0.5;
        for (UIView *metric in _metrics) [_cardView addSubview:metric];
    }
    return self;
}
- (void)resetAvatarImage {
    self.avatarImageView.image=[[UIImage systemImageNamed:@"person.crop.square.fill"]
        imageWithConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:48 weight:UIImageSymbolWeightRegular]];
}
- (void)updateNickname:(NSString *)nickname wechatID:(NSString *)wechatID enabledCount:(NSUInteger)enabledCount
        pluginVersion:(NSString *)pluginVersion wechatVersion:(NSString *)wechatVersion {
    self.nicknameLabel.text=nickname.length ? nickname : @"微信用户";
    self.wechatIDLabel.text=wechatID.length ? [@"微信号：" stringByAppendingString:wechatID] : @"微信号暂未获取";
    NSArray *values=@[[NSString stringWithFormat:@"%lu",(unsigned long)enabledCount],
                      pluginVersion,wechatVersion.length ? wechatVersion : @"未知"];
    for (NSUInteger index=0;index<self.metrics.count;index++) {
        CSPluginHeaderMetricView *metric=self.metrics[index];
        metric.valueLabel.text=values[index];
        metric.accessibilityLabel=[NSString stringWithFormat:@"%@，%@",metric.captionLabel.text,values[index]];
    }
    [self setNeedsLayout];
}
- (void)setVerse:(NSString *)verse {
    self.verseLabel.text=verse;
    [self setNeedsLayout];
}
- (void)reloadTheme {
    self.quoteView.tintColor=CSSettingsHomeTheme.accentColor;
}
- (CGFloat)metricHeight {
    return MAX(46,ceil(self.metrics.firstObject.valueLabel.font.lineHeight+self.metrics.firstObject.captionLabel.font.lineHeight+18));
}
- (CGFloat)verseHeightForWidth:(CGFloat)width {
    CGFloat textWidth=MAX(1,width-2*self.horizontalInset-32-24);
    CGFloat measured=[self.verseLabel sizeThatFits:CGSizeMake(textWidth,CGFLOAT_MAX)].height;
    return MAX(20,MIN(ceil(measured),2*ceil(self.verseLabel.font.lineHeight)));
}
- (CGFloat)vipCapsuleHeight {
    return MAX(20,ceil(self.vipLabel.font.lineHeight)+6);
}
- (CGFloat)vipCapsuleWidth {
    return ceil([self.vipLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,[self vipCapsuleHeight])].width)+14;
}
- (CGFloat)nicknameRowHeight {
    return MAX(ceil(self.nicknameLabel.font.lineHeight),[self vipCapsuleHeight]);
}
- (CGFloat)wechatIDTop {
    return 22+[self nicknameRowHeight]+8;
}
- (CGFloat)verseTop {
    CGFloat identityBottom=MAX(80,[self wechatIDTop]+ceil(self.wechatIDLabel.font.lineHeight));
    return identityBottom+18;
}
- (CGFloat)metricsTopForWidth:(CGFloat)width {
    return [self verseTop]+[self verseHeightForWidth:width]+18;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)width {
    return 8+[self metricsTopForWidth:width]+[self metricHeight]+20+4;
}
- (void)setHorizontalInset:(CGFloat)horizontalInset {
    if (fabs(_horizontalInset-horizontalInset)<0.5) return;
    _horizontalInset=MAX(0,horizontalInset);
    [self setNeedsLayout];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat cardWidth=MAX(0,CGRectGetWidth(self.bounds)-2*self.horizontalInset);
    self.cardView.frame=CGRectMake(self.horizontalInset,8,cardWidth,MAX(0,CGRectGetHeight(self.bounds)-12));
    self.avatarImageView.frame=CGRectMake(16,20,60,60);
    CGFloat identityX=88, identityWidth=MAX(0,cardWidth-identityX-16);
    CGFloat nameHeight=ceil(self.nicknameLabel.font.lineHeight);
    CGFloat rowHeight=[self nicknameRowHeight];
    CGFloat vipHeight=[self vipCapsuleHeight], vipWidth=MIN(identityWidth,[self vipCapsuleWidth]);
    CGFloat nameWidth=MIN(MAX(0,identityWidth-vipWidth-8),
                          ceil([self.nicknameLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX,nameHeight)].width));
    self.nicknameLabel.frame=CGRectMake(identityX,22+(rowHeight-nameHeight)/2,nameWidth,nameHeight);
    self.vipCapsule.frame=CGRectMake(identityX+nameWidth+8,22+(rowHeight-vipHeight)/2,vipWidth,vipHeight);
    self.vipCapsule.layer.cornerRadius=3;
    self.vipLabel.frame=CGRectMake(7,0,MAX(0,vipWidth-14),vipHeight);
    self.wechatIDLabel.frame=CGRectMake(identityX,[self wechatIDTop],identityWidth,ceil(self.wechatIDLabel.font.lineHeight));

    CGFloat width=CGRectGetWidth(self.bounds);
    CGFloat verseY=[self verseTop], verseHeight=[self verseHeightForWidth:width];
    CGFloat quoteY=verseY+MAX(0,(MIN(verseHeight,ceil(self.verseLabel.font.lineHeight))-14)/2);
    self.quoteView.frame=CGRectMake(17,quoteY,12,14);
    self.verseLabel.frame=CGRectMake(40,verseY,MAX(0,cardWidth-56),verseHeight);

    CGFloat metricY=[self metricsTopForWidth:width], metricHeight=[self metricHeight];
    CGFloat available=MAX(0,cardWidth-32-16), metricWidth=available/self.metrics.count;
    for (NSUInteger index=0;index<self.metrics.count;index++) {
        self.metrics[index].frame=CGRectMake(16+index*(metricWidth+8),metricY,metricWidth,metricHeight);
    }
}
@end
