#import "CSListCornerPreviewView.h"
#import "CSListCornerConfiguration.h"
#import <math.h>

@interface CSListCornerPreviewView ()
@property(nonatomic, strong) CSListCornerSnapshot *configuration;
@property(nonatomic, strong) UIColor *pendingColor;
@property(nonatomic) NSInteger pendingComponent;
@property(nonatomic) UIUserInterfaceStyle pendingStyle;
@end

@implementation CSListCornerPreviewView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        self.opaque=NO;
        self.clipsToBounds=YES;
        self.layer.cornerRadius=12;
        self.userInteractionEnabled=NO;
        self.isAccessibilityElement=YES;
        self.accessibilityLabel=@"列表圆角预览，置顶会话与普通会话均为示例";
        self.contentMode=UIViewContentModeRedraw;
    }
    return self;
}

- (void)configureWithSnapshot:(CSListCornerSnapshot *)snapshot {
    self.configuration=snapshot;
    self.pendingColor=nil;
    [self setNeedsDisplay];
}

- (void)previewColor:(UIColor *)color component:(NSInteger)component style:(UIUserInterfaceStyle)style {
    self.pendingColor=color;
    self.pendingComponent=component;
    self.pendingStyle=style;
    [self setNeedsDisplay];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self setNeedsDisplay];
}

- (void)drawText:(NSString *)text rect:(CGRect)rect font:(UIFont *)font color:(UIColor *)color {
    NSMutableParagraphStyle *paragraph=[NSMutableParagraphStyle new];
    paragraph.lineBreakMode=NSLineBreakByTruncatingTail;
    [text drawInRect:rect withAttributes:@{NSFontAttributeName:font,
        NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:paragraph}];
}

- (void)drawRect:(CGRect)rect {
    (void)rect;
    CSListCornerSnapshot *configuration=self.configuration;
    CGFloat canvasWidth=CGRectGetWidth(self.bounds), canvasHeight=CGRectGetHeight(self.bounds);
    if (!configuration || canvasWidth<=0 || canvasHeight<=0) return;
    [UIColor.systemGroupedBackgroundColor setFill];
    UIRectFill(self.bounds);

    CGFloat referenceWidth=CGRectGetWidth(self.window.bounds);
    if (!isfinite(referenceWidth) || referenceWidth<=0) referenceWidth=canvasWidth;
    CGFloat left=MIN(30,MAX(1,configuration.leftMargin));
    CGFloat right=MIN(30,MAX(1,configuration.rightMargin));
    CGFloat pinnedGap=MIN(50,MAX(0,configuration.pinnedGap));
    CGFloat normalGap=MIN(50,MAX(0,configuration.normalGap));
    CGFloat rowHeight=64, sampleHeight=pinnedGap+normalGap+rowHeight*2;
    CGFloat scale=MIN(1,MIN(canvasWidth/referenceWidth,canvasHeight/sampleHeight));
    CGFloat rowWidth=MAX(1,referenceWidth-left-right);
    CGContextRef context=UIGraphicsGetCurrentContext();
    if (!context || scale<=0) return;
    CGContextSaveGState(context);
    CGContextTranslateCTM(context,(canvasWidth-referenceWidth*scale)/2,(canvasHeight-sampleHeight*scale)/2);
    CGContextScaleCTM(context,scale,scale);

    UIUserInterfaceStyle style=self.traitCollection.userInterfaceStyle;
    UIColor *surface=[configuration backgroundForStyle:style];
    BOOL dark=style==UIUserInterfaceStyleDark;
    if (self.pendingColor && ((self.pendingComponent==0 && !dark) || (self.pendingComponent==1 && dark)))
        surface=self.pendingColor;
    CGFloat y=0;
    NSArray<NSString *> *names=@[@"置顶会话",@"普通会话"];
    NSArray<NSString *> *subtitles=@[@"置顶列表的圆角与顶部间距",@"普通列表的边距与背景效果"];
    for (NSUInteger index=0;index<2;index++) {
        CGFloat gap=index==0 ? pinnedGap : normalGap;
        UIColor *gapColor=index==0 ? [configuration pinnedColorForStyle:style] : [configuration normalColorForStyle:style];
        if (self.pendingColor && self.pendingComponent==(NSInteger)index+2 && self.pendingStyle==style)
            gapColor=self.pendingColor;
        [gapColor setFill];
        UIRectFill(CGRectMake(0,y,referenceWidth,gap));
        y+=gap;
        CGRect card=CGRectMake(left,y,rowWidth,rowHeight);
        CGFloat radius=MIN(30,MAX(5,configuration.radius));
        [surface setFill];
        [[UIBezierPath bezierPathWithRoundedRect:card cornerRadius:radius] fill];

        CGRect avatar=CGRectMake(left+12,y+12,40,40);
        UIColor *avatarColor=index==0 ? UIColor.systemBlueColor : UIColor.systemGreenColor;
        [[avatarColor colorWithAlphaComponent:.14] setFill];
        [[UIBezierPath bezierPathWithRoundedRect:avatar cornerRadius:9] fill];
        UIImage *symbol=[[UIImage systemImageNamed:index==0 ? @"pin.fill" : @"bubble.left.fill"]
            imageWithTintColor:avatarColor renderingMode:UIImageRenderingModeAlwaysOriginal];
        [symbol drawInRect:CGRectInset(avatar,11,11)];
        CGFloat textX=left+64, textWidth=MAX(1,rowWidth-78);
        [self drawText:names[index] rect:CGRectMake(textX,y+11,MAX(1,textWidth-36),21)
            font:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium] color:UIColor.labelColor];
        [self drawText:@"12:00" rect:CGRectMake(CGRectGetMaxX(card)-48,y+14,40,16)
            font:[UIFont systemFontOfSize:11] color:UIColor.tertiaryLabelColor];
        [self drawText:subtitles[index] rect:CGRectMake(textX,y+37,textWidth,18)
            font:[UIFont systemFontOfSize:12] color:UIColor.secondaryLabelColor];
        y+=rowHeight;
    }
    CGContextRestoreGState(context);
}

@end
