// A view-only host double for the documented native quote method. Tests assert
// delegation to this contract, not pixel equivalence to UIKit/WeChat on device.
static void (^FoldedQuoteHook)(void);
static NSUInteger FoldedQuoteCalls,FoldedRemoveQuoteCalls;
static NSMutableArray *FoldedThemeMargin;
static BOOL FoldedThemeAvailable=YES;
static BOOL FoldedThemeInvalidABI,FoldedThemeThrows;
static NSUInteger FoldedUnsupportedThemeCalls;
@interface UnsupportedFoldedTheme : NSObject
- (NSInteger)getValueOfProperty:(NSString *)property inRuleSet:(NSString *)rule;
@end
@implementation UnsupportedFoldedTheme
- (NSInteger)getValueOfProperty:(NSString *)property inRuleSet:(NSString *)rule { (void)property;(void)rule;FoldedUnsupportedThemeCalls++;return 1; }
@end
@interface MMThemeManager : NSObject
- (id)getValueOfProperty:(NSString *)property inRuleSet:(NSString *)rule;
@end
@implementation MMThemeManager
- (id)getValueOfProperty:(NSString *)property inRuleSet:(NSString *)rule {
    (void)rule;
    if (FoldedThemeThrows) [NSException raise:@"fixture" format:@"native theme unavailable"];
    if (!FoldedThemeMargin) FoldedThemeMargin=[NSMutableArray arrayWithObject:@12];
    return [property isEqual:@"cell_headimg_left_margin"] ? FoldedThemeMargin : @[@48,@48];
}
@end
@interface MMContext : NSObject
+ (instancetype)currentContext;
- (id)getService:(Class)service;
@end
@implementation MMContext
+ (instancetype)currentContext { static MMContext *context;if (!context) context=[self new];return context; }
- (id)getService:(Class)service {
    (void)service;static MMThemeManager *theme;if (!theme) theme=[MMThemeManager new];
    if (!FoldedThemeAvailable) return nil;
    return FoldedThemeInvalidABI ? [UnsupportedFoldedTheme new] : theme;
}
@end
@implementation MainFrameItemView (FoldedNativeRendererFixture)
- (void)removeQuoteMessageLabel {
    FoldedRemoveQuoteCalls++;
    for (UIView *v in [self.subviews copy]) if(v.tag==10001001 || v.tag==10001002)[v removeFromSuperview];
}
- (void)quoteMessageLable:(UILabel *)message prefixText:(NSString *)text {
    FoldedQuoteCalls++;
    UILabel *prefix=[[UILabel alloc] initWithFrame:message.frame];prefix.tag=10001001;
    prefix.text=text;prefix.font=message.font;prefix.textColor=m_messageLabel.textColor;
    prefix.textAlignment=message.textAlignment;prefix.backgroundColor=message.backgroundColor;
    prefix.highlightedTextColor=message.highlightedTextColor;
    CGFloat budget=MAX(0,self.bounds.size.width-104),natural=[prefix sizeThatFits:CGSizeMake(10000,100)].width;
    CGRect f=prefix.frame;f.size.width=MIN(budget,natural);prefix.frame=f;
    f=message.frame;f.origin.x=ceil(CGRectGetMaxX(prefix.frame));
    f.size.width=natural>=budget ? 0 : MIN(ceil([message sizeThatFits:CGSizeMake(10000,100)].width)+1,budget-prefix.frame.size.width+1);
    message.frame=f;[self addSubview:prefix];if(FoldedQuoteHook)FoldedQuoteHook();
}
@end
