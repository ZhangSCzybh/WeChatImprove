#import "CSSettingsHomePaletteCell.h"
#import "CSSettingsHomeTheme.h"

@interface CSSettingsHomePaletteCell ()
@property(nonatomic, strong) UILabel *paletteTitleLabel;
@property(nonatomic, strong) NSArray<UIButton *> *paletteButtons;
@property(nonatomic, strong) NSArray<UIView *> *swatches;
@property(nonatomic, strong) NSArray<UIImageView *> *marks;
@property(nonatomic, strong) NSArray<UILabel *> *captions;
@end

@implementation CSSettingsHomePaletteCell
+ (NSString *)reuseIdentifier { return @"CSSettingsHomePaletteCell"; }
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.separatorInset=UIEdgeInsetsMake(0,16,0,16);
        _paletteTitleLabel=[UILabel new];
        _paletteTitleLabel.text=@"界面调色";
        _paletteTitleLabel.textColor=UIColor.labelColor;
        _paletteTitleLabel.font=[[UIFontMetrics metricsForTextStyle:UIFontTextStyleSubheadline] scaledFontForFont:[UIFont systemFontOfSize:15 weight:UIFontWeightSemibold] maximumPointSize:18];
        [self.contentView addSubview:_paletteTitleLabel];
        NSMutableArray *buttons=[NSMutableArray array],*swatches=[NSMutableArray array],*marks=[NSMutableArray array],*captions=[NSMutableArray array];
        NSArray *names=@[@"默认绿",@"蓝",@"紫",@"橙",@"自定义"];
        for (NSUInteger index=0;index<names.count;index++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.tag=index;
            button.layer.cornerRadius=12;
            button.layer.borderWidth=2;
            button.accessibilityLabel=names[index];
            button.accessibilityHint=index==4 ? @"打开取色器，自定义界面颜色" : @"应用到标签、功能图标和箭头";
            [button addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            [buttons addObject:button];

            UIView *swatch=[UIView new];
            swatch.layer.cornerRadius=15;
            swatch.layer.borderWidth=0.5;
            swatch.userInteractionEnabled=NO;
            [button addSubview:swatch];
            [swatches addObject:swatch];

            UIImageView *mark=[UIImageView new];
            mark.contentMode=UIViewContentModeScaleAspectFit;
            mark.userInteractionEnabled=NO;
            [swatch addSubview:mark];
            [marks addObject:mark];

            UILabel *caption=[UILabel new];
            caption.text=names[index];
            caption.textAlignment=NSTextAlignmentCenter;
            caption.font=[[UIFontMetrics metricsForTextStyle:UIFontTextStyleCaption1] scaledFontForFont:[UIFont systemFontOfSize:12] maximumPointSize:14];
            caption.adjustsFontSizeToFitWidth=YES;
            caption.minimumScaleFactor=0.8;
            caption.textColor=UIColor.labelColor;
            [button addSubview:caption];
            [captions addObject:caption];
        }
        self.paletteButtons=buttons;self.swatches=swatches;self.marks=marks;self.captions=captions;
        [self reloadTheme];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat available=MAX(0,CGRectGetWidth(self.contentView.bounds)-24);
    CGFloat gap=5;
    CGFloat width=MAX(0,(available-gap*4)/5);
    self.paletteTitleLabel.frame=CGRectMake(16,10,MAX(0,CGRectGetWidth(self.contentView.bounds)-32),26);
    CGFloat height=MIN(76,MAX(0,CGRectGetHeight(self.contentView.bounds)-52));
    CGFloat top=42;
    for (NSUInteger index=0;index<self.paletteButtons.count;index++) {
        self.paletteButtons[index].frame=CGRectMake(12+index*(width+gap),top,width,height);
        self.swatches[index].frame=CGRectMake(MAX(0,(width-30)/2),10,30,30);
        self.marks[index].frame=CGRectMake(7,7,16,16);
        self.captions[index].frame=CGRectMake(2,44,MAX(0,width-4),22);
    }
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) [self reloadTheme];
}
- (void)reloadTheme {
    NSUInteger selected=CSSettingsHomeTheme.selectedIndex;
    UIColor *accent=CSSettingsHomeTheme.accentColor;
    for (NSUInteger index=0;index<self.paletteButtons.count;index++) {
        UIButton *button=self.paletteButtons[index];
        BOOL active=index==selected;
        button.selected=active;
        button.layer.borderColor=(active ? accent : UIColor.clearColor).CGColor;
        button.backgroundColor=UIColor.tertiarySystemGroupedBackgroundColor;
        button.accessibilityTraits=UIAccessibilityTraitButton | (active ? UIAccessibilityTraitSelected : 0);
        self.swatches[index].backgroundColor=[CSSettingsHomeTheme colorAtIndex:index];
        self.swatches[index].layer.borderColor=[[UIColor.labelColor colorWithAlphaComponent:0.12] resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        self.marks[index].image=active ? [UIImage systemImageNamed:@"checkmark" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:14 weight:UIImageSymbolWeightSemibold]] : (index==4 ? [UIImage systemImageNamed:@"eyedropper"] : nil);
        if (active) self.marks[index].tintColor=index<4 ? UIColor.whiteColor : CSSettingsHomeTheme.foregroundColorForAccent;
        else if (index==4) {
            // The unselected custom sample may itself be very light or dark.
            CGFloat red=0,green=0,blue=0,alpha=1;
            [CSSettingsHomeTheme.customColor getRed:&red green:&green blue:&blue alpha:&alpha];
            self.marks[index].tintColor=(0.299*red+0.587*green+0.114*blue)>0.6 ? UIColor.blackColor : UIColor.whiteColor;
        }
    }
}
- (void)selectColor:(UIButton *)button {
    NSUInteger index=(NSUInteger)button.tag;
    if (index>=self.paletteButtons.count) return;
    if (index==4) {
        if (self.customColorRequested) self.customColorRequested();
    } else {
        [CSSettingsHomeTheme setPresetIndex:index];
        [self reloadTheme];
    }
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.customColorRequested=nil;
    [self reloadTheme];
}
@end
