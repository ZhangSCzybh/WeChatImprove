#import "CSInputTextPreviewView.h"
#import <math.h>

static double CSInputPreviewNumber(NSUserDefaults *defaults, NSString *suffix, double fallback) {
    id value=[defaults objectForKey:[@"com.wechat.enhance.inputText." stringByAppendingString:suffix]];
    double number=[value respondsToSelector:@selector(doubleValue)] ? [value doubleValue] : fallback;
    return isfinite(number) ? number : fallback;
}

// The native chat bar owns these icons. Draw a small, inert outline sample
// rather than using SF Symbols with different silhouettes and proportions.
static UIImage *CSInputPreviewToolbarIcon(NSUInteger kind) {
    UIGraphicsImageRenderer *renderer=[[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(28,28)];
    UIImage *image=[renderer imageWithActions:^(__unused UIGraphicsImageRendererContext *context) {
        [UIColor.blackColor setStroke];
        [UIColor.blackColor setFill];
        UIBezierPath *outline=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(1,1,26,26)];
        outline.lineWidth=1.5;
        [outline stroke];
        UIBezierPath *detail=[UIBezierPath bezierPath];
        detail.lineWidth=1.5;
        detail.lineCapStyle=kCGLineCapRound;
        detail.lineJoinStyle=kCGLineJoinRound;
        if (kind==0) {
            UIBezierPath *speaker=[UIBezierPath bezierPath];
            [speaker moveToPoint:CGPointMake(7.5,12)];
            [speaker addLineToPoint:CGPointMake(10,9.5)];
            [speaker addLineToPoint:CGPointMake(10,18.5)];
            [speaker addLineToPoint:CGPointMake(7.5,16)];
            [speaker closePath];
            [speaker fill];
            [detail moveToPoint:CGPointMake(13,10)];
            [detail addCurveToPoint:CGPointMake(13,18) controlPoint1:CGPointMake(16.5,12) controlPoint2:CGPointMake(16.5,16)];
            [detail moveToPoint:CGPointMake(16,7)];
            [detail addCurveToPoint:CGPointMake(16,21) controlPoint1:CGPointMake(22,11) controlPoint2:CGPointMake(22,17)];
        } else if (kind==1) {
            [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(8.4,8.5,3,3.6)] fill];
            [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(16.6,8.5,3,3.6)] fill];
            [detail moveToPoint:CGPointMake(6.8,15)];
            [detail addLineToPoint:CGPointMake(21.2,15)];
            [detail addCurveToPoint:CGPointMake(6.8,15) controlPoint1:CGPointMake(20,25) controlPoint2:CGPointMake(8,25)];
            [detail closePath];
        } else {
            [detail moveToPoint:CGPointMake(14,7)];
            [detail addLineToPoint:CGPointMake(14,21)];
            [detail moveToPoint:CGPointMake(7,14)];
            [detail addLineToPoint:CGPointMake(21,14)];
        }
        [detail stroke];
    }];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@interface CSInputTextPreviewView ()
@property(nonatomic, strong) UIView *toolbar, *input;
@property(nonatomic, strong) UILabel *placeholderLabel;
@property(nonatomic, strong) UIImageView *voice, *emoji, *plus;
@property(nonatomic, strong) UIColor *previewBorderColor;
@property(nonatomic, strong) UIFont *previewFont;
@property(nonatomic) CGFloat previewRadius, previewBorderWidth;
@end

@implementation CSInputTextPreviewView
- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=NO;
        self.isAccessibilityElement=YES;
        self.accessibilityLabel=@"文本占位预览，示例输入框不可编辑";
        self.backgroundColor=[UIColor colorWithDynamicProvider:^UIColor *(UITraitCollection *traits) {
            return [UIColor colorWithWhite:traits.userInterfaceStyle==UIUserInterfaceStyleDark ? .10 : .965 alpha:1];
        }];
        self.toolbar=[UIView new];
        self.toolbar.backgroundColor=self.backgroundColor;
        [self addSubview:self.toolbar];
        self.input=[UIView new];
        self.input.backgroundColor=[UIColor colorWithDynamicProvider:^UIColor *(UITraitCollection *traits) {
            return [UIColor colorWithWhite:traits.userInterfaceStyle==UIUserInterfaceStyleDark ? .18 : 1 alpha:1];
        }];
        self.input.clipsToBounds=YES;
        [self.toolbar addSubview:self.input];
        self.placeholderLabel=[UILabel new];
        self.placeholderLabel.numberOfLines=2;
        // Match the centered idle placeholder in the supplied chat reference.
        self.placeholderLabel.textAlignment=NSTextAlignmentCenter;
        self.previewFont=[UIFont systemFontOfSize:15];
        self.previewRadius=5;
        [self.input addSubview:self.placeholderLabel];
        NSMutableArray *icons=[NSMutableArray array];
        for (NSUInteger kind=0;kind<3;kind++) {
            UIImageView *icon=[[UIImageView alloc] initWithImage:CSInputPreviewToolbarIcon(kind)];
            icon.tintColor=UIColor.labelColor;
            icon.contentMode=UIViewContentModeScaleAspectFit;
            [self.toolbar addSubview:icon];
            [icons addObject:icon];
        }
        self.voice=icons[0]; self.emoji=icons[1]; self.plus=icons[2];
    }
    return self;
}
- (void)reloadWithDefaults:(NSUserDefaults *)defaults textColor:(UIColor *)textColor borderColor:(UIColor *)borderColor {
    BOOL enabled=[defaults boolForKey:@"com.wechat.enhance.inputText.enabled"];
    BOOL rounded=[defaults boolForKey:@"com.wechat.enhance.inputText.roundedCorners"];
    BOOL bordered=[defaults boolForKey:@"com.wechat.enhance.inputText.border.enabled"];
    CGFloat radius=CSInputPreviewNumber(defaults,@"cornerRadius",18);
    CGFloat borderWidth=CSInputPreviewNumber(defaults,@"border.width",1);
    CGFloat fontSize=CSInputPreviewNumber(defaults,@"fontSize",15);
    CGFloat alpha=MIN(1,MAX(0,CSInputPreviewNumber(defaults,@"alpha",.5)));
    if (radius<=0) radius=18;
    if (borderWidth<=0) borderWidth=1;
    if (fontSize<=0) fontSize=15;
    // This sample only reads style preferences. It cannot focus, send or run gestures.
    self.previewRadius=rounded ? radius : 5;
    self.previewBorderWidth=bordered ? borderWidth : 0;
    self.previewBorderColor=borderColor ?: UIColor.systemGrayColor;
    self.input.layer.borderColor=[self.previewBorderColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
    id content=[defaults objectForKey:@"com.wechat.enhance.inputText.content"];
    self.placeholderLabel.text=enabled ? ([content isKindOfClass:NSString.class] && [content length] ? content : @"我爱你呀") : @"输入消息…";
    self.placeholderLabel.textColor=enabled ? [(textColor ?: UIColor.grayColor) colorWithAlphaComponent:alpha] : UIColor.placeholderTextColor;
    BOOL bold=enabled && [defaults boolForKey:@"com.wechat.enhance.inputText.bold"];
    self.previewFont=bold ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:enabled ? fontSize : 15];
    self.accessibilityValue=self.placeholderLabel.text;
    [self setNeedsLayout];
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    self.input.layer.borderColor=[self.previewBorderColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.bounds), height=CGRectGetHeight(self.bounds);
    if (width<=0 || height<=0) return;
    // Fit the entire native-width bar, including font, radius and border, at one
    // scale. Keeping only the width smaller made the old sample look too tall.
    CGFloat windowWidth=CGRectGetWidth(self.window.bounds);
    CGFloat referenceWidth=MAX(240,MAX(width,windowWidth>0 ? windowWidth : CGRectGetWidth(UIScreen.mainScreen.bounds)));
    CGFloat scale=MIN(1,MIN(width/referenceWidth,height/50));
    CGFloat toolbarWidth=referenceWidth*scale, toolbarHeight=50*scale;
    self.toolbar.frame=CGRectMake((width-toolbarWidth)/2,(height-toolbarHeight)/2,toolbarWidth,toolbarHeight);
    self.voice.frame=CGRectMake(10*scale,11*scale,28*scale,28*scale);
    self.emoji.frame=CGRectMake((referenceWidth-78)*scale,11*scale,28*scale,28*scale);
    self.plus.frame=CGRectMake((referenceWidth-38)*scale,11*scale,28*scale,28*scale);
    self.input.frame=CGRectMake(48*scale,7*scale,(referenceWidth-136)*scale,36*scale);
    self.input.layer.cornerRadius=self.previewRadius*scale;
    self.input.layer.borderWidth=self.previewBorderWidth*scale;
    self.placeholderLabel.font=[self.previewFont fontWithSize:self.previewFont.pointSize*scale];
    self.placeholderLabel.frame=CGRectInset(self.input.bounds,8*scale,3*scale);
}
@end
