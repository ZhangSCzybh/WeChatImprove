#import <AppKit/AppKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CSUserInfoHelper.h"

// Host-only geometry fixture. The real view implementation is compiled below;
// AppKit supplies actual system-font measurements, not guessed character widths.
// Colors retain their declared components; this test makes no device-rendering claim.
// Keep fixture Objective-C runtime names distinct from AppKit's private classes.
#define UIFont HeaderHostFont
#define UIFontMetrics HeaderHostFontMetrics
#define UIColor HeaderHostColor
#define UIView HeaderHostView
#define UIImageSymbolConfiguration HeaderHostSymbolConfiguration
#define UIImage HeaderHostImage
#define UIImageView HeaderHostImageView
#define UILabel HeaderHostLabel
typedef CGFloat UIFontWeight;
typedef NSString *UIFontTextStyle;
#define UIFontWeightRegular NSFontWeightRegular
#define UIFontWeightMedium NSFontWeightMedium
#define UIFontWeightSemibold NSFontWeightSemibold
#define UIImageSymbolWeightRegular NSFontWeightRegular
static NSString * const UIFontTextStyleCaption1=@"Caption1";
static NSString * const UIFontTextStyleCaption2=@"Caption2";
static NSString * const UIFontTextStyleHeadline=@"Headline";
static NSString * const UIFontTextStyleFootnote=@"Footnote";
enum {UIViewContentModeScaleAspectFit=1,UIViewContentModeScaleAspectFill=2};
static CGFloat fontScale=1;
static BOOL simulateNamedFontUnavailable;

@interface UIFont : NSObject
@property(nonatomic,strong) NSFont *native;
@property(nonatomic,copy) NSString *textStyle;
@property(nonatomic,readonly) CGFloat lineHeight,pointSize;
+ (instancetype)systemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight;
+ (instancetype)fontWithName:(NSString *)name size:(CGFloat)size;
@end
@implementation UIFont
+ (instancetype)systemFontOfSize:(CGFloat)size weight:(UIFontWeight)weight {
    UIFont *font=[self new];font.native=[NSFont systemFontOfSize:size weight:weight];return font;
}
+ (instancetype)fontWithName:(NSString *)name size:(CGFloat)size {
    if(simulateNamedFontUnavailable)return nil;
    NSFont *native=[NSFont fontWithName:name size:size];
    if(!native)return nil;
    UIFont *font=[self new];font.native=native;return font;
}
- (CGFloat)lineHeight {return [[NSLayoutManager new] defaultLineHeightForFont:self.native];}
- (CGFloat)pointSize {return self.native.pointSize;}
@end
@interface UIFontMetrics : NSObject
@property(nonatomic,copy) NSString *style;
+ (instancetype)metricsForTextStyle:(UIFontTextStyle)style;
- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximum;
@end
@implementation UIFontMetrics
+ (instancetype)metricsForTextStyle:(UIFontTextStyle)style {UIFontMetrics *metrics=[self new];metrics.style=style;return metrics;}
- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximum {
    UIFont *scaled=[UIFont new];
    scaled.native=[NSFontManager.sharedFontManager convertFont:font.native toSize:MIN(maximum,font.pointSize*fontScale)];
    scaled.textStyle=self.style;
    return scaled;
}
@end
@interface UIColor : NSObject
@property(nonatomic) CGFloat red,green,blue,alpha;
@property(nonatomic,copy) NSString *semanticName;
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (instancetype)whiteColor;
+ (instancetype)blackColor;
+ (instancetype)systemGroupedBackgroundColor;
+ (instancetype)labelColor;
+ (instancetype)secondaryLabelColor;
+ (instancetype)clearColor;
+ (instancetype)secondarySystemGroupedBackgroundColor;
+ (instancetype)systemGray5Color;
+ (instancetype)systemGray3Color;
+ (instancetype)tertiarySystemFillColor;
+ (instancetype)systemBlueColor;
@end
@implementation UIColor
+ (instancetype)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    UIColor *color=[self new];color.red=red;color.green=green;color.blue=blue;color.alpha=alpha;return color;
}
+ (instancetype)whiteColor {return [self colorWithRed:1 green:1 blue:1 alpha:1];}
+ (instancetype)blackColor {return [self colorWithRed:0 green:0 blue:0 alpha:1];}
+ (instancetype)named:(NSString *)name {UIColor *color=[self new];color.semanticName=name;return color;}
- (BOOL)isEqual:(id)object {
    if(![object isKindOfClass:UIColor.class])return NO;
    UIColor *other=object;
    if(self.semanticName || other.semanticName)return [self.semanticName isEqual:other.semanticName];
    return fabs(self.red-other.red)<0.00001 && fabs(self.green-other.green)<0.00001 &&
        fabs(self.blue-other.blue)<0.00001 && fabs(self.alpha-other.alpha)<0.00001;
}
- (NSUInteger)hash {return self.semanticName.hash;}
+ (instancetype)systemGroupedBackgroundColor {return [self named:@"systemGroupedBackgroundColor"];}
+ (instancetype)labelColor {return [self named:@"labelColor"];}
+ (instancetype)secondaryLabelColor {return [self named:@"secondaryLabelColor"];}
+ (instancetype)clearColor {return [self named:@"clearColor"];}
+ (instancetype)secondarySystemGroupedBackgroundColor {return [self named:@"secondarySystemGroupedBackgroundColor"];}
+ (instancetype)systemGray5Color {return [self named:@"systemGray5Color"];}
+ (instancetype)systemGray3Color {return [self named:@"systemGray3Color"];}
+ (instancetype)tertiarySystemFillColor {return [self named:@"tertiarySystemFillColor"];}
+ (instancetype)systemBlueColor {return [self named:@"systemBlueColor"];}
@end
@interface HeaderTestLayer : NSObject
@property(nonatomic) CGFloat cornerRadius;
@end
@implementation HeaderTestLayer @end
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic,strong) UIColor *backgroundColor;
@property(nonatomic,strong) HeaderTestLayer *layer;
@property(nonatomic,strong) NSMutableArray<UIView *> *subviews;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic) BOOL clipsToBounds,isAccessibilityElement,hidden;
@property(nonatomic,copy) NSString *accessibilityLabel;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)setNeedsLayout;
- (void)layoutSubviews;
- (void)layoutIfNeeded;
@end
@implementation UIView
- (instancetype)init {return [self initWithFrame:CGRectZero];}
- (instancetype)initWithFrame:(CGRect)frame {
    if((self=[super init])) {self.frame=frame;_layer=[HeaderTestLayer new];_subviews=[NSMutableArray new];}return self;
}
- (void)setFrame:(CGRect)frame {_frame=frame;_bounds=(CGRect){CGPointZero,frame.size};}
- (void)addSubview:(UIView *)view {[self.subviews addObject:view];view.superview=self;}
- (void)setNeedsLayout {}
- (void)layoutSubviews {}
- (void)layoutIfNeeded {[self layoutSubviews];for(UIView *view in self.subviews)[view layoutIfNeeded];}
@end
@interface UIImageSymbolConfiguration : NSObject
+ (instancetype)configurationWithPointSize:(CGFloat)size weight:(UIFontWeight)weight;
@end
@implementation UIImageSymbolConfiguration
+ (instancetype)configurationWithPointSize:(CGFloat)size weight:(UIFontWeight)weight {return [self new];}
@end
@interface UIImage : NSObject
+ (instancetype)systemImageNamed:(NSString *)name;
- (instancetype)imageWithConfiguration:(UIImageSymbolConfiguration *)configuration;
@end
@implementation UIImage
+ (instancetype)systemImageNamed:(NSString *)name {return [self new];}
- (instancetype)imageWithConfiguration:(UIImageSymbolConfiguration *)configuration {return self;}
@end
@interface UIImageView : UIView
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) UIColor *tintColor;
@property(nonatomic) NSInteger contentMode;
- (instancetype)initWithImage:(UIImage *)image;
@end
@implementation UIImageView
- (instancetype)initWithImage:(UIImage *)image {if((self=[super initWithFrame:CGRectZero]))_image=image;return self;}
@end
@interface UILabel : UIView
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,copy) NSString *text;
@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic) NSLineBreakMode lineBreakMode;
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic) BOOL adjustsFontSizeToFitWidth;
@property(nonatomic) CGFloat minimumScaleFactor;
- (CGSize)sizeThatFits:(CGSize)size;
@end
@implementation UILabel
- (CGSize)sizeThatFits:(CGSize)size {
    NSFont *font=self.font.native ?: [NSFont systemFontOfSize:17];
    NSRect measured=[(self.text ?: @"") boundingRectWithSize:NSMakeSize(MAX(1,size.width),CGFLOAT_MAX)
        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font}];
    CGFloat height=ceil(measured.size.height);
    if(self.numberOfLines>0)height=MIN(height,self.numberOfLines*self.font.lineHeight);
    return CGSizeMake(MIN(size.width,ceil(measured.size.width)),height);
}
@end

// Generated by the runner from the unmodified production .h and .m. Only the
// UIKit framework import is removed; every initializer and layout method is real.
#import "PluginHeaderUnderTest.h"

static NSUInteger checks;
#define Check(value,message) do {checks++;if(!(value)){fprintf(stderr,"FAIL: %s\n",message);exit(1);}} while(0)
static BOOL Contained(CGRect inner,CGRect outer) {
    return CGRectGetMinX(inner)>=CGRectGetMinX(outer)-0.01 && CGRectGetMinY(inner)>=CGRectGetMinY(outer)-0.01 &&
        CGRectGetMaxX(inner)<=CGRectGetMaxX(outer)+0.01 && CGRectGetMaxY(inner)<=CGRectGetMaxY(outer)+0.01;
}
static CGFloat NaturalWidth(UILabel *label) {
    return [(label.text ?: @"") sizeWithAttributes:@{NSFontAttributeName:label.font.native}].width;
}
static UIColor *ExpectedVIPBackgroundColor(void) {
    return [UIColor colorWithRed:248.0/255 green:216.0/255 blue:169.0/255 alpha:1];
}
static void ValidateVIPAppearance(void) {
    for(NSNumber *scale in @[@1,@3]) {
        fontScale=scale.doubleValue;
        for(NSUInteger index=0;index<3;index++) {
            CSPluginHeaderView *header=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
            Check([header.vipCapsule.backgroundColor isEqual:ExpectedVIPBackgroundColor()],"every new SVIP badge uses the fixed opaque light-gold background");
            Check([header.vipLabel.textColor isEqual:UIColor.blackColor],"every new SVIP badge uses black lettering");
            NSFont *expected=[NSFont fontWithName:@"TimesNewRomanPS-BoldMT" size:MIN(15,12*fontScale)];
            Check(expected!=nil && [header.vipLabel.font.native.fontName isEqual:expected.fontName],"the SVIP fixture measures the real Times New Roman bold serif face");
            CGFloat systemWidth=[@"SVIP" sizeWithAttributes:@{NSFontAttributeName:[NSFont systemFontOfSize:header.vipLabel.font.pointSize weight:NSFontWeightSemibold]}].width;
            Check(fabs(NaturalWidth(header.vipLabel)-systemWidth)>0.1,"the selected serif glyph metrics differ from the system-font fallback");
            Check([header.vipLabel.font.textStyle isEqual:UIFontTextStyleCaption2],"the serif SVIP font keeps Caption2 dynamic scaling");
        }
        simulateNamedFontUnavailable=YES;
        CSPluginHeaderView *fallback=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
        simulateNamedFontUnavailable=NO;
        // AppKit normalizes system-font aliases while scaling; compare the same
        // native face after normalization instead of its unscaled alias name.
        NSFont *system=[NSFontManager.sharedFontManager convertFont:[NSFont systemFontOfSize:12 weight:NSFontWeightSemibold]
                                                          toSize:MIN(15,12*fontScale)];
        Check([fallback.vipLabel.font.native.fontName isEqual:system.fontName] &&
              fabs(fallback.vipLabel.font.pointSize-MIN(15,12*fontScale))<0.01,"unavailable named fonts retain a correctly scaled semibold system-font fallback");
        Check([fallback.vipCapsule.backgroundColor isEqual:ExpectedVIPBackgroundColor()] &&
              [fallback.vipLabel.textColor isEqual:UIColor.blackColor],"font fallback preserves the fixed gold-and-black badge appearance");
    }
    fontScale=1;
}
static void ValidateLayout(CSPluginHeaderView *header,CGFloat width,UIImageView *avatar,UIColor *vipColor,NSString *pluginVersion) {
    header.frame=CGRectMake(0,0,width,[header preferredHeightForWidth:width]);[header layoutIfNeeded];
    Check(Contained(header.cardView.frame,header.bounds),"card remains inside the measured header");
    Check(header.avatarImageView==avatar && avatar.layer.cornerRadius==15 && avatar.clipsToBounds,"layout preserves the same rounded-square avatar object");
    Check(Contained(avatar.frame,header.cardView.bounds),"avatar remains within the card");
    Check(CGRectGetMaxX(avatar.frame)<CGRectGetMinX(header.nicknameLabel.frame),"identity remains to the right of the avatar");
    Check(Contained(header.nicknameLabel.frame,header.cardView.bounds) && Contained(header.wechatIDLabel.frame,header.cardView.bounds),"identity text stays inside the card");
    Check(header.wechatIDLabel.superview==header.cardView && ![header respondsToSelector:NSSelectorFromString(@"wechatIDCapsule")],"WeChat ID is a direct plain label without the removed capsule");
    Check((!header.wechatIDLabel.backgroundColor || [header.wechatIDLabel.backgroundColor isEqual:UIColor.clearColor]) &&
          header.wechatIDLabel.layer.cornerRadius==0,"the plain WeChat ID has no colored capsule background or rounded corners");
    Check(header.vipCapsule.superview==header.cardView && header.vipLabel.superview==header.vipCapsule,"the VIP label remains inside its own badge beside the nickname");
    Check(Contained(header.vipCapsule.frame,header.cardView.bounds) && Contained(header.vipLabel.frame,header.vipCapsule.bounds),"the complete VIP badge stays inside the identity area");
    Check([header.vipLabel.text isEqual:@"SVIP"] && header.vipLabel.numberOfLines==1,"the SVIP badge retains its complete single-line title");
    Check([header.vipLabel.textColor isEqual:UIColor.blackColor] && [header.vipCapsule.backgroundColor isEqual:ExpectedVIPBackgroundColor()],"the SVIP badge retains fixed light-gold and black colors during refresh and layout");
    Check([header.vipCapsule.backgroundColor isEqual:vipColor],"identity refreshes and layout changes preserve the fixed SVIP color");
    Check(header.vipCapsule.clipsToBounds && fabs(header.vipCapsule.layer.cornerRadius-3)<0.01,"the SVIP badge keeps its clipped three-point corner radius");
    Check(NaturalWidth(header.vipLabel)<=CGRectGetWidth(header.vipLabel.bounds)+0.01 &&
          ceil(header.vipLabel.font.lineHeight)<=CGRectGetHeight(header.vipLabel.bounds)+0.01,"the VIP title fits at its natural font size");
    Check(fabs(CGRectGetMinX(header.vipCapsule.frame)-CGRectGetMaxX(header.nicknameLabel.frame)-8)<0.01,"the VIP badge follows the visible nickname by eight points");
    CGFloat availableNicknameWidth=CGRectGetWidth(header.cardView.bounds)-CGRectGetMinX(header.nicknameLabel.frame)-16-CGRectGetWidth(header.vipCapsule.bounds)-8;
    Check(fabs(CGRectGetWidth(header.nicknameLabel.bounds)-MIN(ceil(NaturalWidth(header.nicknameLabel)),availableNicknameWidth))<=1,"short nicknames use their natural width and long nicknames preserve the VIP reservation");
    Check(header.nicknameLabel.lineBreakMode==NSLineBreakByTruncatingTail,"long nicknames keep their tail-truncation behavior");
    Check(fabs(CGRectGetMidY(header.nicknameLabel.frame)-CGRectGetMidY(header.vipCapsule.frame))<0.01,"nickname and VIP are vertically centered in one row");
    CGFloat identityRowBottom=MAX(CGRectGetMaxY(header.nicknameLabel.frame),CGRectGetMaxY(header.vipCapsule.frame));
    Check(fabs(CGRectGetMinY(header.wechatIDLabel.frame)-identityRowBottom-6)<0.01,"the plain WeChat ID follows the complete nickname row by six points");
    CGFloat identityBottom=MAX(CGRectGetMaxY(avatar.frame),CGRectGetMaxY(header.wechatIDLabel.frame));
    Check(fabs(CGRectGetMinY(header.verseLabel.frame)-identityBottom-12)<0.01,"random text starts below the complete identity area with its promised gap");
    CGFloat previousRight=0;
    for(CSPluginHeaderMetricView *metric in header.metrics) {
        Check(Contained(metric.frame,header.cardView.bounds),"each metric stays inside the card");
        Check(CGRectGetMinX(metric.frame)>=previousRight,"metric columns do not overlap");previousRight=CGRectGetMaxX(metric.frame);
        Check(Contained(metric.valueLabel.frame,metric.bounds) && Contained(metric.captionLabel.frame,metric.bounds),"metric labels stay inside their column");
        Check(CGRectGetMaxY(metric.valueLabel.frame)<CGRectGetMinY(metric.captionLabel.frame),"value and caption do not overlap");
        Check(NaturalWidth(metric.valueLabel)*metric.valueLabel.minimumScaleFactor<=CGRectGetWidth(metric.valueLabel.bounds)+0.1,"the complete metric value fits at its allowed minimum font scale");
        if(!metric.iconView.hidden)Check(CGRectGetMaxX(metric.iconView.frame)<=CGRectGetMinX(metric.valueLabel.frame),"a visible metric icon does not overlap its value");
        Check(NaturalWidth(metric.captionLabel)*metric.captionLabel.minimumScaleFactor<=CGRectGetWidth(metric.captionLabel.bounds)+0.1,"each metric caption fits at its allowed minimum font scale");
        Check(fabs(metric.valueLabel.font.pointSize-MIN(15,14*fontScale))<0.01 &&
              fabs(metric.captionLabel.font.pointSize-MIN(14,11.5*fontScale))<0.01,"all three cards use the enlarged matching value and caption fonts");
        Check(fabs(CGRectGetWidth(metric.bounds)-CGRectGetWidth(header.metrics.firstObject.bounds))<0.01 &&
              fabs(CGRectGetHeight(metric.bounds)-CGRectGetHeight(header.metrics.firstObject.bounds))<0.01 &&
              fabs(CGRectGetMinY(metric.frame)-CGRectGetMinY(header.metrics.firstObject.frame))<0.01,"all three cards have exactly equal widths, heights and vertical alignment");
    }
    Check([header.metrics[1].valueLabel.text isEqual:pluginVersion],"version value retains the supplied version without adding a v prefix, including long beta suffixes");
    Check([header.metrics[0].captionLabel.text isEqual:@"已开启"] && [header.metrics[1].captionLabel.text isEqual:@"插件版本"] &&
          [header.metrics[2].captionLabel.text isEqual:@"微信版本"],"status columns retain count, plugin version and WeChat version order");
    CGFloat metricWidth=CGRectGetWidth(header.metrics[0].bounds)+CGRectGetWidth(header.metrics[1].bounds)+CGRectGetWidth(header.metrics[2].bounds);
    Check(fabs(metricWidth-(CGRectGetWidth(header.cardView.bounds)-48))<0.01,"equal-width cards fill the available row after two gaps and side insets");
    Check(fabs(CGRectGetMinX(header.metrics.firstObject.frame)-16)<0.01 &&
          fabs(CGRectGetWidth(header.cardView.bounds)-CGRectGetMaxX(header.metrics.lastObject.frame)-16)<0.01,"the row retains equal sixteen-point left and right insets");
    Check(fabs(CGRectGetMinX(header.metrics[1].frame)-CGRectGetMaxX(header.metrics[0].frame)-8)<0.01 &&
          fabs(CGRectGetMinX(header.metrics[2].frame)-CGRectGetMaxX(header.metrics[1].frame)-8)<0.01,"both status card gaps remain exactly eight points");
    Check(fabs(CGRectGetMinY(header.metrics.firstObject.frame)-CGRectGetMaxY(header.verseLabel.frame)-12)<0.01,"status cards follow the random text with a consistent gap");
    Check(Contained(header.verseLabel.frame,header.cardView.bounds),"verse stays inside the card");
    Check(fabs(CGRectGetMaxY(header.metrics.lastObject.frame)+16-CGRectGetHeight(header.cardView.bounds))<0.01,"preferred header height leaves exactly the promised padding below the status cards");
    Check(Contained(header.quoteView.frame,header.cardView.bounds),"quote icon stays inside the card");
    Check(CGRectGetMaxX(header.quoteView.frame)<CGRectGetMinX(header.verseLabel.frame),"quote icon does not overlap the verse");
    Check(fabs(header.nicknameLabel.font.pointSize-MIN(26,21*fontScale))<0.01 &&
          fabs(header.wechatIDLabel.font.pointSize-MIN(15,13*fontScale))<0.01 &&
          fabs(header.vipLabel.font.pointSize-MIN(15,12*fontScale))<0.01 &&
          fabs(header.verseLabel.font.pointSize-MIN(21,16*fontScale))<0.01,"nickname, WeChat ID, SVIP and random text use their selected base sizes and dynamic font limits");
    Check([header.verseLabel.font.textStyle isEqual:UIFontTextStyleFootnote],"the enlarged random text retains Footnote dynamic scaling");
    Check([header.vipLabel.font.native.fontName isEqual:@"TimesNewRomanPS-BoldMT"],"identity updates and reflow preserve the selected SVIP serif face");
}

int main(void) {@autoreleasepool {
    ValidateVIPAppearance();
    for(NSNumber *scale in @[@1,@3]) {
        fontScale=scale.doubleValue;
        CSPluginHeaderView *header=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
        UIImageView *avatar=header.avatarImageView;
        UIColor *vipColor=header.vipCapsule.backgroundColor;
        Check([vipColor isEqual:ExpectedVIPBackgroundColor()],"new headers use the same fixed SVIP background");
        UIImage *loadedImage=[UIImage new];avatar.image=loadedImage;
        for(NSString *nickname in @[@"阿北",@"昵称较长时也保留微信号与头像空间"]) {
        [header updateNickname:nickname wechatID:@"wechat_long_identifier_12345" enabledCount:32
                 pluginVersion:kPluginVersionString wechatVersion:@"8.0.80"];
        Check([header.nicknameLabel.text isEqual:nickname],"nickname updates preserve the complete source name for display");
        Check([header.wechatIDLabel.text isEqual:@"微信号：wechat_long_identifier_12345"],"the plain WeChat ID restores the requested label prefix");
        for(NSNumber *insetValue in @[@20,@32]) {
            header.horizontalInset=insetValue.doubleValue;
            for(NSNumber *widthValue in @[@320,@375,@430]) {
                CGFloat width=widthValue.doubleValue;
                [header setVerse:@"春风又绿江南岸。"];
                CGFloat shortHeight=[header preferredHeightForWidth:width];
                ValidateLayout(header,width,avatar,vipColor,kPluginVersionString);
                CGFloat shortTextHeight=CGRectGetHeight(header.verseLabel.bounds);
                CGFloat shortMetricY=CGRectGetMinY(header.metrics.firstObject.frame);
                CGFloat textY=CGRectGetMinY(header.verseLabel.frame);
                CGRect avatarFrame=avatar.frame;
                Check(shortTextHeight<=MAX(20,ceil(header.verseLabel.font.lineHeight))+0.01,"a short verse occupies one line");
                [header setVerse:@"长风破浪会有时，直挂云帆济沧海。欲穷千里目，更上一层楼。"];
                ValidateLayout(header,width,avatar,vipColor,kPluginVersionString);
                CGFloat textGrowth=CGRectGetHeight(header.verseLabel.bounds)-shortTextHeight;
                Check([header preferredHeightForWidth:width]>shortHeight,"a two-line verse increases the actual header height");
                Check(CGRectGetHeight(header.verseLabel.bounds)>ceil(header.verseLabel.font.lineHeight) &&
                      CGRectGetHeight(header.verseLabel.bounds)<=2*ceil(header.verseLabel.font.lineHeight),"a long verse occupies at most two lines");
                Check(fabs(CGRectGetMinY(header.verseLabel.frame)-textY)<0.01,"longer text keeps its origin below the identity area");
                Check(CGRectGetMinY(header.metrics.firstObject.frame)>shortMetricY &&
                      fabs(CGRectGetMinY(header.metrics.firstObject.frame)-shortMetricY-textGrowth)<0.01,"longer text moves status cards down by its measured height growth");
                Check(fabs([header preferredHeightForWidth:width]-shortHeight-textGrowth)<0.01,"preferred height and applied layout grow together");
                Check(CGRectEqualToRect(avatar.frame,avatarFrame) && avatar.image==loadedImage,"longer random text leaves the avatar position and pixels intact");
                [header setVerse:@"春风又绿江南岸。"];
                ValidateLayout(header,width,avatar,vipColor,kPluginVersionString);
                Check(fabs([header preferredHeightForWidth:width]-shortHeight)<0.01 &&
                      fabs(CGRectGetMinY(header.metrics.firstObject.frame)-shortMetricY)<0.01,"shortening text returns the status cards and header height to their original positions");
                Check(CGRectEqualToRect(avatar.frame,avatarFrame) && avatar.image==loadedImage,"identity updates, text changes, insets and widths preserve the loaded avatar");
            }
        }
        }
        [header updateNickname:@"新账号" wechatID:@"" enabledCount:0 pluginVersion:kPluginVersionString wechatVersion:@""];
        Check([header.wechatIDLabel.text isEqual:@"微信号暂未获取"],"missing WeChat ID preserves the existing unavailable-ID fallback");
        [header resetAvatarImage];ValidateLayout(header,320,avatar,vipColor,kPluginVersionString);
        Check(avatar.image!=loadedImage && avatar.layer.cornerRadius==15,"reset replaces only avatar pixels and preserves the square radius");
        [header updateNickname:@"昵称较长时也保留标识空间" wechatID:@"wechat_long_identifier_12345" enabledCount:32
                 pluginVersion:@"2.7-2-beta05" wechatVersion:@"8.0.80"];
        [header setVerse:@"春风又绿江南岸。"];
        for(NSNumber *insetValue in @[@20,@32]) {
            header.horizontalInset=insetValue.doubleValue;
            for(NSNumber *widthValue in @[@320,@375,@430]) {
                ValidateLayout(header,widthValue.doubleValue,avatar,vipColor,@"2.7-2-beta05");
            }
        }
    }
    printf("PluginHeaderLayoutTests: %lu checks passed (real view, AppKit fonts, equal cards/gaps/insets, 16pt random text, current/long beta versions, short/long names, 320/375/430pt, inset20/32, fixed gold/black SVIP, real serif face/fallback, 3pt corners, plain WeChat ID, identity/text/status order)\n",(unsigned long)checks);
}return 0;}
