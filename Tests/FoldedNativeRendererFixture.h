// A view-only host double for the documented native quote method. Tests assert
// delegation to this contract, not pixel equivalence to UIKit/WeChat on device.
static void (^FoldedQuoteHook)(void);
@implementation MainFrameItemView (FoldedNativeRendererFixture)
- (void)removeQuoteMessageLabel {
    for (UIView *v in [self.subviews copy]) if(v.tag==10001001 || v.tag==10001002)[v removeFromSuperview];
}
- (void)quoteMessageLable:(UILabel *)message prefixText:(NSString *)text {
    UILabel *prefix=[[UILabel alloc] initWithFrame:message.frame];prefix.tag=10001001;
    prefix.text=text;prefix.font=message.font;prefix.textColor=m_messageLabel.textColor;
    prefix.textAlignment=message.textAlignment;prefix.backgroundColor=message.backgroundColor;
    CGFloat budget=MAX(0,self.bounds.size.width-104),natural=[prefix sizeThatFits:CGSizeMake(10000,100)].width;
    CGRect f=prefix.frame;f.size.width=MIN(budget,natural);prefix.frame=f;
    f=message.frame;f.origin.x=ceil(CGRectGetMaxX(prefix.frame));
    f.size.width=natural>=budget ? 0 : MIN(ceil([message sizeThatFits:CGSizeMake(10000,100)].width)+1,budget-prefix.frame.size.width+1);
    message.frame=f;[self addSubview:prefix];if(FoldedQuoteHook)FoldedQuoteHook();
}
@end
