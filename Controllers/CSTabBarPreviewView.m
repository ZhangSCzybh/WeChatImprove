#import "CSTabBarPreviewView.h"
#import "CSTabBarPreferences.h"
#import "CSTabBarGeometry.h"
#import "CSQuickPanelPreferences.h"

static CGRect CSPreviewRect(CSTabBarRect rect) {
    return CGRectMake(rect.x, rect.y, rect.width, rect.height);
}

@interface CSTabBarPreviewView ()
@property(nonatomic, strong) CSTabBarPreferences *preferences;
@property(nonatomic, strong) UIView *sample;
@property(nonatomic, strong) UIView *surface, *selection;
@property(nonatomic, strong) UIVisualEffectView *material;
@property(nonatomic, strong) UIView *functionSurface;
@property(nonatomic, strong) UIVisualEffectView *functionMaterial;
@property(nonatomic, strong) UIImageView *functionImage;
@property(nonatomic, strong) NSArray<UIButton *> *tabs;
@property(nonatomic, strong) NSArray<UIImageView *> *icons;
@property(nonatomic, strong) NSArray<UILabel *> *labels;
@property(nonatomic) NSUInteger selectedIndex;
@end

@implementation CSTabBarPreviewView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        self.backgroundColor=UIColor.clearColor;
        self.clipsToBounds=YES;
        _sample=[UIView new];
        [self addSubview:_sample];
        _surface=[UIView new];
        _material=[[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial]];
        [_surface addSubview:_material];
        [_sample addSubview:_surface];
        _selection=[UIView new]; _selection.userInteractionEnabled=NO;
        [_surface addSubview:_selection];
        _functionSurface=[UIView new]; _functionSurface.userInteractionEnabled=NO;
        _functionMaterial=[[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial]];
        [_functionSurface addSubview:_functionMaterial];
        _functionImage=[UIImageView new]; _functionImage.contentMode=UIViewContentModeScaleAspectFit;
        [_functionSurface addSubview:_functionImage];
        [_sample addSubview:_functionSurface];
        NSMutableArray *tabs=[NSMutableArray array], *icons=[NSMutableArray array], *labels=[NSMutableArray array];
        for (NSUInteger index=0;index<4;index++) {
            UIButton *tab=[UIButton buttonWithType:UIButtonTypeCustom]; tab.tag=index;
            [tab addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *icon=[UIImageView new]; icon.contentMode=UIViewContentModeScaleAspectFit;
            UILabel *label=[UILabel new]; label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:10]; label.adjustsFontSizeToFitWidth=YES;
            [tab addSubview:icon]; [tab addSubview:label]; [_sample addSubview:tab];
            [tabs addObject:tab]; [icons addObject:icon]; [labels addObject:label];
        }
        _tabs=tabs; _icons=icons; _labels=labels;
        self.accessibilityLabel=@"底栏样式预览";
    }
    return self;
}
- (void)updateWithPreferences:(CSTabBarPreferences *)preferences {
    self.preferences=preferences;
    [self setNeedsLayout];
}
- (void)selectTab:(UIButton *)sender {
    self.selectedIndex=sender.tag;
    [self setNeedsLayout];
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self setNeedsLayout];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CSTabBarPreferences *p=self.preferences;
    CGFloat availableWidth=CGRectGetWidth(self.bounds)-24;
    if (!p || availableWidth<=0 || CGRectGetHeight(self.bounds)<=0) return;
    // Percentage input uses scale; retained point widths stay compatible until
    // explicitly replaced. Match the live host before fitting the settings card.
    CGFloat referenceWidth=CGRectGetWidth(self.window.bounds);
    if (!isfinite(referenceWidth) || referenceWidth<=0) referenceWidth=CGRectGetWidth(self.bounds);
    if (!isfinite(referenceWidth) || referenceWidth<=0) return;
    // Build the same natural geometry as the real bar, then fit the complete
    // sample into the compact card without reserving a full screen's lift area.
    CSTabBarRect total=CSTabBarFloatingRectWithWidth(referenceWidth,p.contentHeight,p.scale,p.contentHeight,0,p.contentWidth);
    BOOL rtl=self.effectiveUserInterfaceLayoutDirection==UIUserInterfaceLayoutDirectionRightToLeft;
    CSTabBarLayout layout=CSTabBarLayoutMake(total,(int)p.structure,p.functionGap,p.functionSize,p.centerButtonScale,rtl,referenceWidth);
    CGRect occupied=CSPreviewRect(layout.mainRect);
    if (layout.actionRect.width>0) occupied=CGRectUnion(occupied,CSPreviewRect(layout.actionRect));
    CGFloat sampleHeight=CGRectGetHeight(occupied);
    if (sampleHeight<=0) return;
    layout.mainRect.y-=CGRectGetMinY(occupied);
    layout.actionRect.y-=CGRectGetMinY(occupied);
    // Reserve the largest supported key at this bar height, so changing only
    // its size or spacing never makes the preview's main bar appear to shrink.
    CGFloat fitHeight=MAX(sampleHeight,MAX(80,p.contentHeight*1.35));
    CGFloat fit=MIN(1,MIN(availableWidth/referenceWidth,MAX(1,CGRectGetHeight(self.bounds)-40)/fitHeight));
    self.sample.bounds=CGRectMake(0,0,referenceWidth,sampleHeight);
    self.sample.transform=CGAffineTransformMakeScale(fit,fit);
    // Keep position changes visible while the style remains the focus.
    CGFloat liftOffset=8-CSTabBarClamp(p.lift,0,100,0)*.16;
    self.sample.center=CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds)+liftOffset);
    CGRect main=CSPreviewRect(layout.mainRect);
    self.surface.frame=main; self.material.frame=self.surface.bounds;
    CGFloat radius=p.borderStyle==0 ? main.size.height/2 : MIN(p.cornerRadius,main.size.height/2);
    self.surface.layer.cornerRadius=radius;
    self.material.layer.cornerRadius=radius; self.material.clipsToBounds=YES;
    self.material.hidden=p.backgroundColor!=nil;
    self.surface.backgroundColor=p.backgroundColor ?: UIColor.tertiarySystemGroupedBackgroundColor;
    self.surface.layer.borderColor=[p.borderColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
    self.surface.layer.borderWidth=p.borderColor ? p.borderWidth : 0;
    UIColor *active=p.selectedIconColor ?: UIColor.systemGreenColor;
    NSArray *symbols=@[@"message",@"person.2",@"safari",@"person"];
    NSArray *selectedSymbols=@[@"message.fill",@"person.2.fill",@"safari.fill",@"person.fill"];
    NSArray *titles=@[@"微信",@"通讯录",@"发现",@"我"];
    CGRect selectedSlot=CGRectZero;
    for (NSUInteger i=0;i<4;i++) {
        BOOL selected=i==self.selectedIndex;
        CGRect slot=CSPreviewRect(CSTabBarLayoutItemRect(layout,(unsigned)i,4,rtl));
        UIButton *tab=self.tabs[i]; UIImageView *icon=self.icons[i]; UILabel *label=self.labels[i];
        tab.frame=slot;
        UIImage *custom=[p iconAtIndex:i selected:selected];
        icon.image=custom ?: [UIImage systemImageNamed:(selected ? selectedSymbols : symbols)[i]];
        icon.tintColor=selected ? active : UIColor.labelColor;
        CGFloat iconSize=MIN(28,MAX(18,slot.size.width-12));
        CGFloat y=p.hideText ? (slot.size.height-iconSize)/2 : MAX(3,(slot.size.height-iconSize-15)/2);
        icon.frame=CGRectMake((slot.size.width-iconSize)/2,y,iconSize,iconSize);
        label.frame=CGRectMake(2,CGRectGetMaxY(icon.frame)+2,MAX(0,slot.size.width-4),12);
        label.text=[p titleAtIndex:i] ?: titles[i]; label.hidden=p.hideText;
        label.textColor=selected ? active : UIColor.labelColor;
        tab.accessibilityLabel=[NSString stringWithFormat:@"预览%@",label.text];
        tab.accessibilityTraits=UIAccessibilityTraitButton | (selected ? UIAccessibilityTraitSelected : 0);
        if (selected) selectedSlot=CGRectOffset(slot,-main.origin.x,-main.origin.y);
    }
    BOOL underline=p.clickEffect==CSTabBarClickEffectUnderline;
    self.selection.hidden=p.clickEffect==CSTabBarClickEffectNone;
    self.selection.backgroundColor=p.indicatorColor ?: [UIColor colorWithWhite:self.traitCollection.userInterfaceStyle==UIUserInterfaceStyleDark ? 1 : 0 alpha:.10];
    if (underline) self.selection.frame=CGRectMake(CGRectGetMidX(selectedSlot)-12,main.size.height-5,24,3);
    else self.selection.frame=CGRectInset(selectedSlot,4,4);
    self.selection.layer.cornerRadius=underline ? 1.5 : MIN(radius,CGRectGetHeight(self.selection.bounds)/2);
    self.functionSurface.hidden=p.structure==CSTabBarStructureClassic;
    self.functionSurface.frame=CSPreviewRect(layout.actionRect);
    self.functionMaterial.frame=self.functionSurface.bounds;
    CGFloat actionRadius=MIN(CGRectGetWidth(self.functionSurface.bounds),CGRectGetHeight(self.functionSurface.bounds))/2;
    self.functionSurface.layer.cornerRadius=actionRadius;
    self.functionMaterial.layer.cornerRadius=actionRadius; self.functionMaterial.clipsToBounds=YES;
    self.functionMaterial.hidden=p.functionBackgroundColor!=nil;
    self.functionSurface.backgroundColor=p.functionBackgroundColor ?: UIColor.tertiarySystemGroupedBackgroundColor;
    BOOL centered=p.structure==CSTabBarStructureCentered;
    BOOL dark=self.traitCollection.userInterfaceStyle==UIUserInterfaceStyleDark;
    self.functionSurface.layer.borderWidth=p.borderColor ? p.borderWidth : (centered ? 1.25 : 0);
    UIColor *functionOutline=p.borderColor ?: [UIColor colorWithWhite:dark ? 1 : 0 alpha:.18];
    self.functionSurface.layer.borderColor=[functionOutline resolvedColorWithTraitCollection:self.traitCollection].CGColor;
    self.functionImage.image=[UIImage systemImageNamed:[CSQuickPanelPreferences symbolNameForActionIdentifier:p.functionAction] ?: @"qrcode.viewfinder"];
    self.functionImage.tintColor=[(p.functionIconColor ?: [UIColor colorWithRed:dark?1:0 green:dark?1:0 blue:dark?1:0 alpha:1]) resolvedColorWithTraitCollection:self.traitCollection];
    CGFloat minimumSide=MIN(CGRectGetWidth(self.functionSurface.bounds),CGRectGetHeight(self.functionSurface.bounds));
    CGFloat actionIcon=centered ? MIN(42,MAX(22,minimumSide*.56)) : MIN(32,MAX(20,minimumSide*.48));
    self.functionImage.frame=CGRectMake((CGRectGetWidth(self.functionSurface.bounds)-actionIcon)/2,(CGRectGetHeight(self.functionSurface.bounds)-actionIcon)/2,actionIcon,actionIcon);
    self.functionSurface.layer.shadowColor=UIColor.blackColor.CGColor;
    self.functionSurface.layer.shadowOpacity=centered ? (dark ? .24 : .16) : 0;
    self.functionSurface.layer.shadowRadius=8;
    self.functionSurface.layer.shadowOffset=CGSizeMake(0,3);
    self.functionSurface.layer.shadowPath=[UIBezierPath bezierPathWithRoundedRect:self.functionSurface.bounds cornerRadius:actionRadius].CGPath;
    // The center capsule sits above the neighboring slots, with icons protected.
    [self.sample bringSubviewToFront:self.functionSurface];
}
@end
