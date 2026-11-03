#import "CSBubbleStylePreview.h"
#import "CSBubbleStylePolicy.h"

@implementation CSBubbleStylePreview {
    UISegmentedControl *_theme, *_count;
    UILabel *_incomingTitle, *_outgoingTitle, *_hint;
    NSArray<UIImageView *> *_bubbles;
    NSArray<UILabel *> *_labels;
    NSString *_renderKey;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self=[super initWithFrame:frame])) return nil;
    _theme=[[UISegmentedControl alloc] initWithItems:@[@"浅色预览",@"深色预览"]];
    _count=[[UISegmentedControl alloc] initWithItems:@[@"单条",@"连续两条",@"连续三条"]];
    _theme.selectedSegmentIndex=0;_count.selectedSegmentIndex=2;
    for (UISegmentedControl *control in @[_theme,_count]) {
        [control addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];[self addSubview:control];
    }
    _incomingTitle=[UILabel new];_outgoingTitle=[UILabel new];_hint=[UILabel new];
    _incomingTitle.text=@"接收方";_outgoingTitle.text=@"发送方";
    for (UILabel *label in @[_incomingTitle,_outgoingTitle,_hint]) {
        label.font=[UIFont systemFontOfSize:12];label.textColor=UIColor.secondaryLabelColor;[self addSubview:label];
    }
    _hint.numberOfLines=2;
    NSMutableArray *bubbles=[NSMutableArray array],*labels=[NSMutableArray array];
    for (NSUInteger i=0;i<6;i++) {
        UIImageView *bubble=[UIImageView new];UILabel *label=[UILabel new];
        label.font=[UIFont systemFontOfSize:12];label.textAlignment=NSTextAlignmentCenter;
        [self addSubview:bubble];[self addSubview:label];[bubbles addObject:bubble];[labels addObject:label];
    }
    _bubbles=bubbles;_labels=labels;self.layer.cornerRadius=12;self.clipsToBounds=YES;
    self.accessibilityLabel=@"气泡效果预览";
    return self;
}
- (void)refresh { _renderKey=nil;[self setNeedsLayout]; }
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=self.bounds.size.width;
    _theme.frame=CGRectMake(16,10,width-32,30);_count.frame=CGRectMake(16,48,width-32,30);
    _incomingTitle.frame=CGRectMake(16,88,width/2-24,18);_outgoingTitle.frame=CGRectMake(width/2+8,88,width/2-24,18);
    _hint.frame=CGRectMake(16,224,width-32,40);
    BOOL dark=_theme.selectedSegmentIndex==1;
    UIUserInterfaceStyle appearance=dark ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
    if (self.overrideUserInterfaceStyle!=appearance) self.overrideUserInterfaceStyle=appearance;
    self.backgroundColor=dark ? [UIColor colorWithWhite:.10 alpha:1] : [UIColor colorWithWhite:.94 alpha:1];
    for (UILabel *label in @[_incomingTitle,_outgoingTitle,_hint]) label.textColor=dark ? [UIColor colorWithWhite:.75 alpha:1] : [UIColor colorWithWhite:.4 alpha:1];
    _hint.text=self.configuration.kind==CSBubbleStyleRounded ? @"经典圆角：每条气泡使用同一外观。可切换条数和浅深色预览。" : (self.mergesMessages ? @"连接处为直角，收发左右对称；聊天间距由下方合并设置控制。" : @"合并已关闭，每条均为四角圆角。开启下方合并可显示连续圆角效果。");
    if (!self.configuration || width<120) return;
    NSUInteger count=(NSUInteger)_count.selectedSegmentIndex+1;
    CGFloat scale=self.traitCollection.displayScale;if (scale<1) scale=2;
    NSString *key=[NSString stringWithFormat:@"%@/%g/%g/%d/%lu/%d/%ld/%@/%d",self.configuration.values,width,scale,dark,(unsigned long)count,self.mergesMessages,(long)self.draftPalette,self.draftColor,self.draftIsText];
    if ([_renderKey isEqual:key]) return;_renderKey=key;
    for (NSUInteger side=0;side<2;side++) for (NSUInteger i=0;i<3;i++) {
        NSUInteger index=side*3+i;UIImageView *bubble=_bubbles[index];UILabel *label=_labels[index];
        bubble.hidden=label.hidden=i>=count;if (i>=count) continue;
        BOOL outgoing=side==1;
        CGFloat available=width/2-32,bw=available-(i==1 ? 20 : (i==0 ? 8 : 0));
        CGFloat x=side ? width-16-bw : 16,y=112+i*35;
        bubble.frame=CGRectMake(x,y,bw,30);label.frame=CGRectInset(bubble.frame,8,0);
        label.text=count==1 ? @"单条消息" : @[@"第一条",@"第二条",@"第三条"][i];
        CSBubbleRGBA color=[self.configuration colorForOutgoing:outgoing dark:dark];
        NSInteger palette=(dark ? 2 : 0)+(outgoing ? 0 : 1);
        if (self.draftColor && !self.draftIsText && self.draftPalette==palette) [self.draftColor getRed:&color.red green:&color.green blue:&color.blue alpha:&color.alpha];
        CSBubbleRGBA text;
        label.textColor=[self.configuration textColorForOutgoing:outgoing dark:dark color:&text] ?
            [UIColor colorWithRed:text.red green:text.green blue:text.blue alpha:1] :
            (dark && !outgoing ? UIColor.whiteColor : UIColor.blackColor);
        if (self.draftColor && self.draftIsText && self.draftPalette==palette) label.textColor=self.draftColor;
        CSBubbleInsets padding={0};CGFloat radius=CSBubbleFittedRadius(self.configuration.radius,0,scale,padding,bubble.bounds.size);
        CSBubbleGroupPosition group=self.mergesMessages ? CSBubbleGroupPositionForJoins(i>0,i+1<count) : CSBubbleGroupSingle;
        CGImageRef cg=CSBubbleCreateStyledTemplate(color,radius,0,scale,padding,NO,self.configuration.kind,group,outgoing);
        if (!cg) { bubble.image=nil;continue; }
        CSBubbleTemplateMetrics metrics;CSBubbleStyledTemplateDescribe(radius,0,scale,padding,self.configuration.kind,&metrics);
        bubble.image=[[UIImage imageWithCGImage:cg scale:scale orientation:UIImageOrientationUp]
            resizableImageWithCapInsets:UIEdgeInsetsMake(metrics.caps.top,metrics.caps.left,metrics.caps.bottom,metrics.caps.right) resizingMode:UIImageResizingModeStretch];
        CGImageRelease(cg);
    }
}
@end
