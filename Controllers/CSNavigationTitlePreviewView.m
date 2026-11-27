#import "CSNavigationTitlePreviewView.h"
#include <math.h>

@implementation CSNavigationTitlePreviewConfiguration
@end

static CGFloat CSNavigationPreviewNumber(CGFloat number, CGFloat fallback, CGFloat low, CGFloat high) {
    return MIN(high,MAX(low,isfinite(number) ? number : fallback));
}

@interface CSNavigationTitlePreviewView ()
@property(nonatomic, strong) CSNavigationTitlePreviewConfiguration *settings;
@property(nonatomic, strong) UIView *titleGroup, *divider, *message;
@property(nonatomic, strong) UILabel *back, *more, *originalTitle, *otherAvatar, *selfAvatar, *nickname, *separator;
@property(nonatomic, strong) UIImageView *separatorImage;
@end

@implementation CSNavigationTitlePreviewView
- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=UIColor.tertiarySystemGroupedBackgroundColor;
        self.layer.cornerRadius=12;
        self.clipsToBounds=YES;
        self.userInteractionEnabled=NO;
        self.isAccessibilityElement=YES;
        self.accessibilityLabel=@"顶栏样式预览，使用示例头像和示例名称";
        _titleGroup=[UIView new]; [self addSubview:_titleGroup];
        _back=[self label:@"‹" font:[UIFont systemFontOfSize:31 weight:UIFontWeightRegular] color:UIColor.labelColor parent:self];
        _more=[self label:@"•••" font:[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold] color:UIColor.labelColor parent:self];
        _originalTitle=[self label:@"示例会话" font:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold] color:UIColor.labelColor parent:self];
        _otherAvatar=[self label:@"友" font:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] color:UIColor.whiteColor parent:_titleGroup];
        _otherAvatar.backgroundColor=UIColor.systemTealColor;
        _otherAvatar.clipsToBounds=YES;
        _selfAvatar=[self label:@"我" font:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] color:UIColor.whiteColor parent:_titleGroup];
        _selfAvatar.backgroundColor=UIColor.systemBlueColor;
        _selfAvatar.clipsToBounds=YES;
        _nickname=[self label:@"示例昵称" font:[UIFont systemFontOfSize:16] color:UIColor.labelColor parent:_titleGroup];
        _separator=[self label:@"💗" font:[UIFont systemFontOfSize:22] color:UIColor.labelColor parent:_titleGroup];
        _separatorImage=[UIImageView new]; _separatorImage.contentMode=UIViewContentModeScaleAspectFit;
        [_titleGroup addSubview:_separatorImage];
        _divider=[UIView new]; _divider.backgroundColor=UIColor.separatorColor; [self addSubview:_divider];
        _message=[UIView new]; _message.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        _message.layer.cornerRadius=8; [self addSubview:_message];
        UILabel *sample=[self label:@"你好，今天也要开心" font:[UIFont systemFontOfSize:12] color:UIColor.secondaryLabelColor parent:_message];
        sample.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        sample.frame=CGRectMake(8,0,140,28);
    }
    return self;
}
- (UILabel *)label:(NSString *)text font:(UIFont *)font color:(UIColor *)color parent:(UIView *)parent {
    UILabel *label=[UILabel new]; label.text=text; label.font=font; label.textColor=color;
    label.textAlignment=NSTextAlignmentCenter; label.adjustsFontSizeToFitWidth=YES;
    [parent addSubview:label]; return label;
}
- (void)configureWithSettings:(CSNavigationTitlePreviewConfiguration *)settings {
    self.settings=settings;
    [self setNeedsLayout];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.bounds), height=CGRectGetHeight(self.bounds);
    if (width<=0 || height<=0) return;
    CGFloat headerHeight=MIN(88,MAX(68,height-36));
    self.back.frame=CGRectMake(8,headerHeight/2-22,24,44);
    self.more.frame=CGRectMake(MAX(0,width-39),headerHeight/2-16,30,32);
    self.originalTitle.frame=CGRectMake(42,headerHeight/2-18,MAX(0,width-84),36);
    self.divider.frame=CGRectMake(0,headerHeight,width,.5);
    self.message.frame=CGRectMake(12,headerHeight+9,MIN(156,MAX(0,width-24)),28);
    CSNavigationTitlePreviewConfiguration *p=self.settings;
    BOOL active=p.enabled && (p.showSelfAvatar || p.showOtherAvatar);
    self.originalTitle.hidden=active;
    self.titleGroup.hidden=!active;
    if (!active) return;
    CGFloat size=CSNavigationPreviewNumber(p.avatarSize,35,5,45);
    CGFloat radius=CSNavigationPreviewNumber(p.avatarRadius,.2,0,.5)*size;
    CGFloat spacing=CSNavigationPreviewNumber(p.avatarSpacing,4,0,20);
    CGFloat separatorSize=CSNavigationPreviewNumber(p.separatorSize,22,5,35);
    CGFloat offset=CSNavigationPreviewNumber(p.verticalOffset,0,-20,20);
    self.selfAvatar.hidden=!p.showSelfAvatar;
    self.otherAvatar.hidden=!p.showOtherAvatar;
    self.selfAvatar.layer.cornerRadius=self.otherAvatar.layer.cornerRadius=radius;
    self.selfAvatar.font=self.otherAvatar.font=[UIFont systemFontOfSize:MAX(5,size*.44) weight:UIFontWeightMedium];
    self.nickname.hidden=YES;
    self.separator.hidden=YES;
    self.separatorImage.hidden=YES;
    CGFloat total=size;
    if (p.showSelfAvatar && p.showOtherAvatar) {
        self.separator.text=p.separatorText ?: @"💗";
        self.separator.font=[UIFont systemFontOfSize:separatorSize];
        CGFloat separatorWidth=p.separatorImage ? separatorSize : ceil([self.separator.text sizeWithAttributes:@{NSFontAttributeName:self.separator.font}].width)+4;
        total=size*2+separatorWidth+spacing*2;
        self.otherAvatar.frame=CGRectMake(0,0,size,size);
        self.selfAvatar.frame=CGRectMake(size+spacing*2+separatorWidth,0,size,size);
        CGRect separatorRect=CGRectMake(size+spacing,0,separatorWidth,size);
        self.separator.frame=separatorRect;
        self.separatorImage.frame=separatorRect;
        self.separatorImage.image=p.separatorImage;
        self.separator.hidden=p.separatorImage!=nil;
        self.separatorImage.hidden=p.separatorImage==nil;
    } else if (p.showOtherAvatar && p.showNickname) {
        self.nickname.hidden=NO;
        self.nickname.text=p.showRemarkName ? @"示例备注" : @"示例昵称";
        self.nickname.font=[UIFont systemFontOfSize:CSNavigationPreviewNumber(p.nicknameSize,16,5,24)];
        CGFloat textWidth=ceil([self.nickname.text sizeWithAttributes:@{NSFontAttributeName:self.nickname.font}].width);
        CGFloat textHeight=MAX(24,self.nickname.font.lineHeight);
        total=size+8+textWidth;
        // Runtime uses left/right, with historical top/bottom values falling back to right.
        BOOL left=p.nicknamePosition==1;
        self.nickname.frame=CGRectMake(left ? 0 : size+8,(size-textHeight)/2,textWidth,textHeight);
        self.otherAvatar.frame=CGRectMake(left ? textWidth+8 : 0,0,size,size);
    } else {
        self.selfAvatar.frame=self.otherAvatar.frame=CGRectMake(0,0,size,size);
    }
    // Keep the settings sample inside the card on narrow devices while preserving proportions.
    CGFloat fit=MIN(1,MAX(1,width-100)/MAX(1,total));
    self.titleGroup.transform=CGAffineTransformIdentity;
    self.titleGroup.bounds=CGRectMake(0,0,total,size);
    self.titleGroup.center=CGPointMake(width/2,headerHeight/2-offset);
    self.titleGroup.transform=CGAffineTransformMakeScale(fit,fit);
}
@end
