#import "CSMomentsLayoutPreviewView.h"

static UIColor *CSMomentsPreviewColor(CGFloat lightRed, CGFloat lightGreen, CGFloat lightBlue,
                                      CGFloat darkRed, CGFloat darkGreen, CGFloat darkBlue) {
    return [UIColor colorWithDynamicProvider:^UIColor *(UITraitCollection *traits) {
        BOOL dark=traits.userInterfaceStyle==UIUserInterfaceStyleDark;
        return [UIColor colorWithRed:dark ? darkRed : lightRed green:dark ? darkGreen : lightGreen
                                blue:dark ? darkBlue : lightBlue alpha:1];
    }];
}

@interface CSMomentsLayoutPreviewView ()
@property(nonatomic, strong) UIColor *canvasColor, *cardColor, *coverColor, *titleColor, *summaryColor, *dotColor;
@end

@implementation CSMomentsLayoutPreviewView
- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.canvasColor=CSMomentsPreviewColor(.95,.96,.95,.10,.13,.115);
        self.cardColor=CSMomentsPreviewColor(.995,.998,.995,.16,.19,.17);
        self.coverColor=CSMomentsPreviewColor(.80,.86,.81,.29,.36,.31);
        self.titleColor=CSMomentsPreviewColor(.62,.71,.65,.49,.58,.51);
        self.summaryColor=CSMomentsPreviewColor(.80,.85,.81,.34,.41,.36);
        self.dotColor=CSMomentsPreviewColor(.56,.67,.59,.49,.61,.53);
        self.backgroundColor=self.canvasColor;
        self.layer.cornerRadius=12;
        self.clipsToBounds=YES;
        self.contentMode=UIViewContentModeRedraw;
        self.userInteractionEnabled=NO;
        self.isAccessibilityElement=YES;
        self.accessibilityLabel=@"朋友圈原生列表布局示意";
    }
    return self;
}
- (void)setWaterfallEnabled:(BOOL)waterfallEnabled {
    _waterfallEnabled=waterfallEnabled;
    self.accessibilityLabel=waterfallEnabled ? @"朋友圈双列瀑布流布局示意，两列卡片高低错落" : @"朋友圈原生列表布局示意";
    [self setNeedsDisplay];
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self setNeedsDisplay];
}
- (void)fillRoundedRect:(CGRect)rect radius:(CGFloat)radius color:(UIColor *)color {
    if (CGRectGetWidth(rect)<=0 || CGRectGetHeight(rect)<=0) return;
    [color setFill];
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] fill];
}
- (void)drawWaterfallCard:(CGRect)rect coverRatio:(CGFloat)coverRatio {
    [self fillRoundedRect:rect radius:8 color:self.cardColor];
    CGFloat width=CGRectGetWidth(rect), height=CGRectGetHeight(rect);
    CGFloat inset=7, x=CGRectGetMinX(rect), y=CGRectGetMinY(rect);
    CGFloat coverHeight=MAX(8,MIN(height-32,height*coverRatio));
    [self fillRoundedRect:CGRectMake(x+inset,y+inset,width-inset*2,coverHeight) radius:5 color:self.coverColor];
    CGFloat titleY=y+inset+coverHeight+7;
    [self fillRoundedRect:CGRectMake(x+inset,titleY,width*.58,4) radius:2 color:self.titleColor];
    [self fillRoundedRect:CGRectMake(x+inset,titleY+8,width*.36,3) radius:1.5 color:self.summaryColor];
    [self fillRoundedRect:CGRectMake(CGRectGetMaxX(rect)-13,CGRectGetMaxY(rect)-12,5,5) radius:2.5 color:self.dotColor];
}
- (void)drawListRow:(CGRect)rect {
    [self fillRoundedRect:rect radius:8 color:self.cardColor];
    CGFloat x=CGRectGetMinX(rect), y=CGRectGetMinY(rect), height=CGRectGetHeight(rect);
    CGFloat coverSize=MAX(12,height-16), textX=x+coverSize+18;
    CGFloat textWidth=MAX(0,CGRectGetMaxX(rect)-textX-12);
    [self fillRoundedRect:CGRectMake(x+8,y+8,coverSize,coverSize) radius:5 color:self.coverColor];
    [self fillRoundedRect:CGRectMake(textX,y+height*.31,textWidth*.62,4) radius:2 color:self.titleColor];
    [self fillRoundedRect:CGRectMake(textX,y+height*.31+10,textWidth*.83,3) radius:1.5 color:self.summaryColor];
    [self fillRoundedRect:CGRectMake(textX,y+height*.31+18,textWidth*.44,3) radius:1.5 color:self.summaryColor];
    [self fillRoundedRect:CGRectMake(CGRectGetMaxX(rect)-13,CGRectGetMaxY(rect)-12,5,5) radius:2.5 color:self.dotColor];
}
- (void)drawRect:(CGRect)rect {
    (void)rect;
    [self.canvasColor setFill];
    UIRectFill(self.bounds);
    CGFloat width=CGRectGetWidth(self.bounds), height=CGRectGetHeight(self.bounds);
    if (width<=44 || height<=72) return;
    // Keep the diagram compact and proportional on wide settings pages.
    CGFloat sampleHeight=MIN(156,height-20);
    CGFloat sampleWidth=MIN(width-24,sampleHeight*1.85);
    CGFloat x=(width-sampleWidth)/2, y=(height-sampleHeight)/2, gap=8;
    if (self.isWaterfallEnabled) {
        CGFloat columnWidth=(sampleWidth-gap)/2;
        CGFloat leftTopHeight=sampleHeight*.58, rightTopHeight=sampleHeight*.40;
        [self drawWaterfallCard:CGRectMake(x,y,columnWidth,leftTopHeight) coverRatio:.50];
        [self drawWaterfallCard:CGRectMake(x+columnWidth+gap,y,columnWidth,rightTopHeight) coverRatio:.36];
        [self drawWaterfallCard:CGRectMake(x,y+leftTopHeight+gap,columnWidth,sampleHeight-leftTopHeight-gap) coverRatio:.32];
        [self drawWaterfallCard:CGRectMake(x+columnWidth+gap,y+rightTopHeight+gap,columnWidth,sampleHeight-rightTopHeight-gap) coverRatio:.51];
    } else {
        CGFloat rowHeight=(sampleHeight-gap)/2;
        [self drawListRow:CGRectMake(x,y,sampleWidth,rowHeight)];
        [self drawListRow:CGRectMake(x,y+rowHeight+gap,sampleWidth,rowHeight)];
    }
}
@end
