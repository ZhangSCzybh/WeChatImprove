#import "CSSettingsPreviewCell.h"

@interface CSSettingsPreviewCell ()
@property(nonatomic, strong) UIView *preview;
@property(nonatomic, strong) UILabel *captionLabel;
@end

@implementation CSSettingsPreviewCell
+ (NSString *)reuseIdentifier { return @"CSSettingsPreviewCell"; }
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        self.captionLabel=[UILabel new];
        self.captionLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        self.captionLabel.adjustsFontForContentSizeCategory=YES;
        self.captionLabel.textColor=UIColor.secondaryLabelColor;
        self.captionLabel.numberOfLines=2;
        [self.contentView addSubview:self.captionLabel];
        self.contentView.clipsToBounds=YES;
    }
    return self;
}
- (void)configureWithPreview:(UIView *)preview caption:(NSString *)caption {
    if (self.preview!=preview) {
        [self.preview removeFromSuperview];
        self.preview=preview;
        [self.contentView insertSubview:preview belowSubview:self.captionLabel];
    }
    self.captionLabel.text=caption;
    self.accessoryView=nil;
    self.accessoryType=UITableViewCellAccessoryNone;
    [self setNeedsLayout];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    [self.preview removeFromSuperview];
    self.preview=nil;
    self.captionLabel.text=nil;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=MAX(0,CGRectGetWidth(self.contentView.bounds)-24);
    CGFloat height=CGRectGetHeight(self.contentView.bounds);
    CGFloat captionHeight=MIN(40,MAX(28,[self.captionLabel sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)].height));
    self.captionLabel.frame=CGRectMake(12,MAX(12,height-12-captionHeight),width,captionHeight);
    self.preview.frame=CGRectMake(12,12,width,MAX(0,CGRectGetMinY(self.captionLabel.frame)-18));
    self.preview.layer.cornerRadius=12;
    self.preview.clipsToBounds=YES;
}
@end
