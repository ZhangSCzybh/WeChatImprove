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
static NSString * const UIFontTextStyleSubheadline=@"Subheadline";
enum {UIViewContentModeScaleAspectFit=1,UIViewContentModeScaleAspectFill=2};
enum {UIAccessibilityTraitHeader=1};
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
static UIColor *themeAccent;
@interface CSSettingsHomeTheme : NSObject
+ (UIColor *)accentColor;
@end
@implementation CSSettingsHomeTheme
+ (UIColor *)accentColor {return themeAccent;}
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
@property(nonatomic) NSUInteger accessibilityTraits;
@property(nonatomic,copy) NSString *accessibilityLabel;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)setNeedsLayout;
- (void)layoutSubviews;
- (void)layoutIfNeeded;
- (void)didMoveToSuperview;
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
@end
@implementation UIView
- (instancetype)init {return [self initWithFrame:CGRectZero];}
- (instancetype)initWithFrame:(CGRect)frame {
    if((self=[super init])) {self.frame=frame;_layer=[HeaderTestLayer new];_subviews=[NSMutableArray new];}return self;
}
- (void)setFrame:(CGRect)frame {_frame=frame;_bounds=(CGRect){CGPointZero,frame.size};}
- (void)addSubview:(UIView *)view {[self.subviews addObject:view];view.superview=self;[view didMoveToSuperview];}
- (void)setNeedsLayout {}
- (void)layoutSubviews {}
- (void)layoutIfNeeded {[self layoutSubviews];for(UIView *view in self.subviews)[view layoutIfNeeded];}
- (void)didMoveToSuperview {}
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view {
    for(UIView *ancestor=view;ancestor;ancestor=ancestor.superview) {
        point.x+=CGRectGetMinX(ancestor.frame)-CGRectGetMinX(ancestor.bounds);
        point.y+=CGRectGetMinY(ancestor.frame)-CGRectGetMinY(ancestor.bounds);
    }
    for(UIView *ancestor=self;ancestor;ancestor=ancestor.superview) {
        point.x-=CGRectGetMinX(ancestor.frame)-CGRectGetMinX(ancestor.bounds);
        point.y-=CGRectGetMinY(ancestor.frame)-CGRectGetMinY(ancestor.bounds);
    }
    return point;
}
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
// UIKit and theme imports are replaced by drawing/preferences doubles; every
// initializer, theme refresh and layout method is real.
#import "PluginHeaderUnderTest.h"
#import "SectionHeaderUnderTest.h"

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
static void ValidateQuoteTheme(void) {
    for(NSNumber *scale in @[@1,@3]) {
        fontScale=scale.doubleValue;
        themeAccent=[UIColor colorWithRed:7.0/255 green:193.0/255 blue:96.0/255 alpha:1];
        CSPluginHeaderView *header=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
        Check(header.quoteView.tintColor==themeAccent,"quote initializes from the currently selected homepage theme");
        [header updateNickname:@"阿北" wechatID:@"wechat_identifier" enabledCount:32
                pluginVersion:kPluginVersionString wechatVersion:@"8.0.80"];
        [header setVerse:@"春风又绿江南岸。"];
        header.frame=CGRectMake(0,0,390,[header preferredHeightForWidth:390]);
        [header layoutIfNeeded];
        UIImageView *quote=header.quoteView;
        UIImageView *avatar=header.avatarImageView;
        UIImage *avatarImage=avatar.image;
        CGRect quoteFrame=quote.frame,verseFrame=header.verseLabel.frame,headerFrame=header.frame;
        UIFont *verseFont=header.verseLabel.font,*vipFont=header.vipLabel.font;
        UIColor *verseColor=header.verseLabel.textColor;
        NSArray *identityFonts=@[header.nicknameLabel.font,header.wechatIDLabel.font];
        NSArray *identityText=@[header.nicknameLabel.text,header.wechatIDLabel.text];
        NSArray *metricValues=[header.metrics valueForKeyPath:@"valueLabel.text"];
        for(UIColor *next in @[[UIColor colorWithRed:0.48 green:0.27 blue:0.87 alpha:1],
                               [UIColor colorWithRed:0.83 green:0.21 blue:0.57 alpha:1]]) {
            themeAccent=next;
            [header reloadTheme];
            Check(header.quoteView==quote && quote.tintColor==next,"theme reload updates the existing quote icon immediately");
            Check([header.vipCapsule.backgroundColor isEqual:ExpectedVIPBackgroundColor()] &&
                  [header.vipLabel.textColor isEqual:UIColor.blackColor] && header.vipLabel.font==vipFont,
                  "quote theme changes preserve fixed light-gold SVIP background, black lettering and serif font");
            Check([header.verseLabel.text isEqual:@"春风又绿江南岸。"] && header.verseLabel.font==verseFont &&
                  header.verseLabel.textColor==verseColor,"theme reload preserves random text content, typography and reading color");
            Check(([@[header.nicknameLabel.font,header.wechatIDLabel.font] isEqual:identityFonts] &&
                  [@[header.nicknameLabel.text,header.wechatIDLabel.text] isEqual:identityText] &&
                  [[header.metrics valueForKeyPath:@"valueLabel.text"] isEqual:metricValues]),
                  "quote theme changes preserve identity fonts, identity text and status values");
            [header layoutIfNeeded];
            Check(CGRectEqualToRect(quote.frame,quoteFrame) && CGRectEqualToRect(header.verseLabel.frame,verseFrame) &&
                  CGRectEqualToRect(header.frame,headerFrame),"theme refresh does not reflow the random text or change profile geometry");
            Check(header.avatarImageView==avatar && avatar.image==avatarImage,"quote recoloring preserves the same avatar and image");
        }
        CSPluginHeaderView *reentered=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
        Check(reentered.quoteView.tintColor==themeAccent,"a newly entered header initializes directly with the latest custom theme");
    }
    fontScale=1;
}
static void ValidateVIPAppearance(void) {
    for(NSNumber *scale in @[@1,@3]) {
        fontScale=scale.doubleValue;
        for(NSUInteger index=0;index<3;index++) {
            CSPluginHeaderView *header=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
            Check([header.vipCapsule.backgroundColor isEqual:ExpectedVIPBackgroundColor()],"every new SVIP badge uses the fixed opaque light-gold background");
            Check([header.vipLabel.textColor isEqual:UIColor.blackColor],"every new SVIP badge uses black lettering");
            NSFont *expected=[NSFont fontWithName:@"TimesNewRomanPS-BoldMT" size:MIN(15.5,12.5*fontScale)];
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
        NSFont *system=[NSFontManager.sharedFontManager convertFont:[NSFont systemFontOfSize:12.5 weight:NSFontWeightSemibold]
                                                          toSize:MIN(15.5,12.5*fontScale)];
        Check([fallback.vipLabel.font.native.fontName isEqual:system.fontName] &&
              fabs(fallback.vipLabel.font.pointSize-MIN(15.5,12.5*fontScale))<0.01,"unavailable named fonts retain a correctly scaled semibold system-font fallback");
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
    Check(fabs(CGRectGetMinY(header.wechatIDLabel.frame)-identityRowBottom-8)<0.01,"the plain WeChat ID follows the complete nickname row by eight points");
    CGFloat identityBottom=MAX(CGRectGetMaxY(avatar.frame),CGRectGetMaxY(header.wechatIDLabel.frame));
    Check(fabs(CGRectGetMinY(header.verseLabel.frame)-identityBottom-18)<0.01,"random text starts below the complete identity area with an eighteen-point gap");
    Check(fabs(CGRectGetMinY(avatar.frame)-20)<0.01,"the identity area retains twenty points of top breathing room");
    CGFloat previousRight=0;
    for(CSPluginHeaderMetricView *metric in header.metrics) {
        Check(Contained(metric.frame,header.cardView.bounds),"each metric stays inside the card");
        Check(CGRectGetMinX(metric.frame)>=previousRight,"metric columns do not overlap");previousRight=CGRectGetMaxX(metric.frame);
        Check(Contained(metric.valueLabel.frame,metric.bounds) && Contained(metric.captionLabel.frame,metric.bounds),"metric labels stay inside their column");
        Check(CGRectGetMaxY(metric.valueLabel.frame)<CGRectGetMinY(metric.captionLabel.frame),"value and caption do not overlap");
        Check(NaturalWidth(metric.valueLabel)*metric.valueLabel.minimumScaleFactor<=CGRectGetWidth(metric.valueLabel.bounds)+0.1,"the complete metric value fits at its allowed minimum font scale");
        if(!metric.iconView.hidden)Check(CGRectGetMaxX(metric.iconView.frame)<=CGRectGetMinX(metric.valueLabel.frame),"a visible metric icon does not overlap its value");
        Check(NaturalWidth(metric.captionLabel)*metric.captionLabel.minimumScaleFactor<=CGRectGetWidth(metric.captionLabel.bounds)+0.1,"each metric caption fits at its allowed minimum font scale");
        Check(fabs(metric.valueLabel.font.pointSize-MIN(16,15*fontScale))<0.01 &&
              fabs(metric.captionLabel.font.pointSize-MIN(15,12.5*fontScale))<0.01,"all three cards use the enlarged matching value and caption fonts");
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
    Check(fabs(CGRectGetMinY(header.metrics.firstObject.frame)-CGRectGetMaxY(header.verseLabel.frame)-18)<0.01,"status cards follow the random text with an eighteen-point gap");
    Check(Contained(header.verseLabel.frame,header.cardView.bounds),"verse stays inside the card");
    Check(fabs(CGRectGetMaxY(header.metrics.lastObject.frame)+20-CGRectGetHeight(header.cardView.bounds))<0.01,"preferred header height leaves twenty points below the status cards");
    Check(Contained(header.quoteView.frame,header.cardView.bounds),"quote icon stays inside the card");
    Check(CGRectGetMaxX(header.quoteView.frame)<CGRectGetMinX(header.verseLabel.frame),"quote icon does not overlap the verse");
    Check(fabs(header.nicknameLabel.font.pointSize-MIN(27,22*fontScale))<0.01 &&
          fabs(header.wechatIDLabel.font.pointSize-MIN(16,14*fontScale))<0.01 &&
          fabs(header.vipLabel.font.pointSize-MIN(15.5,12.5*fontScale))<0.01 &&
          fabs(header.verseLabel.font.pointSize-MIN(18,15*fontScale))<0.01,"nickname, WeChat ID, SVIP and random text use the newly enlarged base sizes and dynamic font limits");
    Check([header.verseLabel.font.textStyle isEqual:UIFontTextStyleFootnote],"the enlarged random text size retains Footnote dynamic scaling");
    Check([header.vipLabel.font.native.fontName isEqual:@"TimesNewRomanPS-BoldMT"],"identity updates and reflow preserve the selected SVIP serif face");
}

static void ValidateSectionHeaderAlignment(void) {
    // Compile the actual section header class. The host fixture models translated
    // UIView hierarchies and scroll bounds; it does not emulate UIKit scheduling.
    NSArray<NSString *> *titles=@[@"账号与安全",@"界面定制",@"功能增强",@"插件设置",@"关于"];
    for(NSNumber *scale in @[@1,@3]) {
        fontScale=scale.doubleValue;
        UIView *table=[[UIView alloc] initWithFrame:CGRectMake(17,13,390,844)];
        UIView *profileContainer=[[UIView alloc] initWithFrame:CGRectMake(0,0,390,320)];
        CSPluginHeaderView *profile=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
        [profile updateNickname:@"阿北" wechatID:@"wechat_identifier" enabledCount:32
                 pluginVersion:kPluginVersionString wechatVersion:@"8.0.80"];
        [profile setVerse:@"春风又绿江南岸。"];
        [table addSubview:profileContainer];
        [profileContainer addSubview:profile];
        UIView *sectionContainer=[[UIView alloc] initWithFrame:CGRectMake(3,400,390,38)];
        [table addSubview:sectionContainer];
        for(NSString *title in titles) {
            CSSettingsHomeSectionHeaderView *section=[[CSSettingsHomeSectionHeaderView alloc]
                initWithFrame:CGRectMake(0,0,390,38)];
            section.alignmentReference=profile;
            section.titleLabel.text=title;
            [section layoutIfNeeded];
            Check(fabs(CGRectGetMinX(section.titleLabel.frame)-24)<0.01,
                  "a detached section uses a stable local fallback before UIKit places it");
            [sectionContainer addSubview:section];
            // Reuse the same live section through portrait, landscape, an inset
            // change at constant width, and different profile/wrapper origins.
            NSArray<NSArray<NSNumber *> *> *geometry=@[
                @[@390,@20,@20,@0,@0,@0,@0],
                @[@844,@75,@59,@0,@0,@0,@0],
                @[@844,@91,@59,@0,@0,@0,@210],
                @[@390,@32,@20,@0,@0,@0,@390],
                @[@430,@32,@20,@11,@7,@9,@120]
            ];
            for(NSArray<NSNumber *> *values in geometry) {
                CGFloat width=values[0].doubleValue,profileInset=values[1].doubleValue;
                CGFloat sectionInset=values[2].doubleValue,containerX=values[3].doubleValue;
                CGFloat profileX=values[4].doubleValue,scrollX=values[5].doubleValue;
                CGFloat scrollY=values[6].doubleValue;
                table.frame=CGRectMake(17,13,width,844);
                table.bounds=CGRectMake(scrollX,scrollY,width,844);
                profileContainer.frame=CGRectMake(containerX,0,width,320);
                profile.horizontalInset=profileInset;
                profile.frame=CGRectMake(profileX,0,width,[profile preferredHeightForWidth:width]);
                sectionContainer.frame=CGRectMake(3,400,width,38);
                section.frame=CGRectMake(sectionInset-3,0,MAX(0,width-2*sectionInset),38);
                [profile layoutIfNeeded];
                [section layoutIfNeeded];
                UILabel *caption=profile.metrics.firstObject.captionLabel;
                CGFloat actualCaptionInProfile=[profile convertPoint:CGPointZero fromView:caption].x;
                CGFloat actualCaptionInTable=[table convertPoint:CGPointZero fromView:caption].x;
                CGFloat titleInTable=[table convertPoint:CGPointZero fromView:section.titleLabel].x;
                Check(fabs(profile.metricCaptionLeadingInset-actualCaptionInProfile)<0.01,
                      "the exposed anchor matches the actual first metric caption after each layout");
                Check(fabs(titleInTable-actualCaptionInTable)<0.01,
                      "all section titles align with the actual enabled caption across placement, rotation and safe-area geometry");
                Check(fabs(CGRectGetMinY(section.titleLabel.frame)-6)<0.01 &&
                      fabs(CGRectGetHeight(section.titleLabel.frame)-26)<0.01 &&
                      fabs(CGRectGetHeight(section.bounds)-38)<0.01,
                      "coordinate conversion preserves the existing vertical section geometry");
                Check(Contained(section.titleLabel.frame,section.bounds),
                      "the aligned title remains within the grouped section header");
                Check(section.titleLabel.textAlignment==NSTextAlignmentLeft &&
                      section.titleLabel.accessibilityTraits==UIAccessibilityTraitHeader &&
                      [section.titleLabel.text isEqual:title],
                      "every tab and shared about title retains left alignment, text and header accessibility");
            }
        }
    }
    fontScale=1;
}

int main(void) {@autoreleasepool {
    ValidateQuoteTheme();
    ValidateVIPAppearance();
    ValidateSectionHeaderAlignment();
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
            for(NSNumber *widthValue in @[@320,@375,@390,@430]) {
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
                 pluginVersion:@"2.7-5-beta01" wechatVersion:@"8.0.80"];
        [header setVerse:@"春风又绿江南岸。"];
        for(NSNumber *insetValue in @[@20,@32]) {
            header.horizontalInset=insetValue.doubleValue;
            for(NSNumber *widthValue in @[@320,@375,@390,@430]) {
                ValidateLayout(header,widthValue.doubleValue,avatar,vipColor,@"2.7-5-beta01");
            }
        }
    }
    fontScale=1;
    CSPluginHeaderView *density=[[CSPluginHeaderView alloc] initWithFrame:CGRectZero];
    [density updateNickname:@"阿北" wechatID:@"wechat_identifier" enabledCount:32
              pluginVersion:@"2.7-5-beta01" wechatVersion:@"8.0.80"];
    [density setVerse:@"春风又绿江南岸。"];
    CGFloat shortHeight=[density preferredHeightForWidth:390];
    [density setVerse:@"长风破浪会有时，直挂云帆济沧海。欲穷千里目，更上一层楼。"];
    CGFloat longHeight=[density preferredHeightForWidth:390];
    Check(shortHeight>=210 && longHeight<=250,"normal 390-point headers gain breathing room while keeping a bounded first-screen footprint");
    Check(844-88-34-longHeight-76-38>=5*56,"a representative tall phone retains room for at least five native function rows below a two-line header, Tab rail and section title");
    printf("PluginHeaderLayoutTests: %lu checks passed (real view, AppKit fonts, equal cards/gaps/insets, enlarged 15pt random text and profile fonts, current/long beta versions, short/long names, 320/375/390/430pt, inset20/32, fixed gold/black SVIP, real serif face/fallback, 3pt corners, plain WeChat ID, relaxed identity/text/status spacing, actual section-header/caption coordinate alignment through portrait/landscape/inset/scroll/wrapper changes); 390pt normal header %.0fpt/%.0fpt for one/two lines\n",(unsigned long)checks,(double)shortHeight,(double)longHeight);
}return 0;}
