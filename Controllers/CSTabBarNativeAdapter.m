#import "CSTabBarNativeAdapter.h"
#import "CSTabBarPreferences.h"
#import "CSTabBarGeometry.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char CSBarStateKey, CSItemStateKey;
static NSHashTable<MMTabBar *> *CSBars;
static CGRect CSRect(CSTabBarRect r) { return CGRectMake(r.x,r.y,r.width,r.height); }
static void CSSetFrame(UIView *view, CGRect frame) {
    if (view && !CGRectEqualToRect(view.frame,frame)) {
        [UIView performWithoutAnimation:^{ view.frame=frame; }];
    }
}

@interface CSTabBarItemState : NSObject
@property(nonatomic, weak) MMTabBar *bar;
@property(nonatomic) NSUInteger depth;
@property(nonatomic) BOOL applied, textHidden, imageHidden, customHidden;
@property(nonatomic) CGRect imageFrame, textFrame, badgeFrame, customFrame;
@property(nonatomic) CGPoint badgeOffset;
@property(nonatomic) UIViewContentMode imageMode;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, weak) UIView *customIcon;
@end
@implementation CSTabBarItemState @end

@interface CSTabBarButtonState : NSObject
@property(nonatomic, weak) UIView *button;
@property(nonatomic, weak) UIView *item;
@property(nonatomic) CGRect itemFrame;
@property(nonatomic) CGRect frame;
@end
@implementation CSTabBarButtonState @end

@interface CSTabBarState : NSObject
@property(nonatomic, weak) MMTabBar *bar;
@property(nonatomic, weak) MMTabBarController *controller;
@property(nonatomic) NSUInteger depth;
@property(nonatomic) BOOL applied, geometryApplied, applying, clips;
@property(nonatomic) CGRect floatingRect;
@property(nonatomic, strong) UIColor *nativeBackground;
@property(nonatomic, strong) NSMapTable<UIView *,NSNumber *> *backgroundHidden;
@property(nonatomic, strong) NSArray<CSTabBarButtonState *> *buttons;
@property(nonatomic, strong) NSHashTable<UIControl *> *observedButtons;
@property(nonatomic, strong) UIView *surface;
@property(nonatomic, strong) UIVisualEffectView *material;
@property(nonatomic, strong) CAShapeLayer *border;
@property(nonatomic) NSInteger animation;
@property(nonatomic, weak) CSTabBarPreferences *renderedPreferences;
@property(nonatomic, strong) UIColor *renderedNativeBackground;
@property(nonatomic) CGSize renderedSize;
@property(nonatomic) UIUserInterfaceStyle renderedStyle;
@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic) CGFloat nativeInset, nativeIndicatorInset, appliedInset, appliedIndicatorInset;
@property(nonatomic) BOOL insetApplied;
@property(nonatomic) NSUInteger selectionBeforeTouch;
- (void)touchBegan:(UIControl *)sender;
- (void)touchEnded:(UIControl *)sender;
@end

static MMTabBarController *CSOwner(MMTabBar *bar) {
    id owner=bar.customDelegate;
    Class main=NSClassFromString(@"MainTabBarViewController");
    return main && [owner isKindOfClass:main] && [owner isKindOfClass:UITabBarController.class] ? owner : nil;
}
static CSTabBarState *CSState(MMTabBar *bar, BOOL create) {
    CSTabBarState *s=objc_getAssociatedObject(bar,&CSBarStateKey);
    if (!s && create && CSOwner(bar)) {
        s=[CSTabBarState new]; s.bar=bar; s.controller=CSOwner(bar); s.animation=-1;
        s.backgroundHidden=[NSMapTable weakToStrongObjectsMapTable];
        s.observedButtons=[NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(bar,&CSBarStateKey,s,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (!CSBars) CSBars=[NSHashTable weakObjectsHashTable];
        [CSBars addObject:bar];
    }
    return s;
}
static NSArray<MMTabBarItemView *> *CSItems(MMTabBar *bar) {
    return [bar.tabBarItemViews isKindOfClass:NSArray.class] ? [bar.tabBarItemViews copy] : @[];
}
static UIView *CSCustomIcon(MMTabBarItemView *item) {
    SEL selector=NSSelectorFromString(@"customIconView");
    if (![item respondsToSelector:selector]) return nil;
    id value=((id (*)(id,SEL))[item methodForSelector:selector])(item,selector);
    return [value isKindOfClass:UIView.class] ? value : nil;
}
static void CSRestoreItem(MMTabBarItemView *item) {
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (!s.applied) return;
    s.applied=NO;
    item.imageView.image=s.image; item.imageView.contentMode=s.imageMode;
    item.imageView.hidden=s.imageHidden; item.textLabel.hidden=s.textHidden;
    item.textLabel.text=s.text;
    CSSetFrame(item.imageView,s.imageFrame); CSSetFrame(item.textLabel,s.textFrame);
    CGRect badge=item.badgeView.frame;
    badge.origin.x-=s.badgeOffset.x; badge.origin.y-=s.badgeOffset.y;
    CSSetFrame(item.badgeView,badge);
    if (s.customIcon) { s.customIcon.hidden=s.customHidden; CSSetFrame(s.customIcon,s.customFrame); }
}
static void CSApplyItem(MMTabBarItemView *item, MMTabBar *bar) {
    CSTabBarState *host=CSState(bar,NO);
    if (!host.applied || host.depth || !CSTabBarPreferences.current.enabled) return;
    NSUInteger index=[bar.items indexOfObjectIdenticalTo:item.item];
    if (index==NSNotFound || index>=4) return;
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (!s) {
        s=[CSTabBarItemState new];
        objc_setAssociatedObject(item,&CSItemStateKey,s,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (s.depth) return;
    CSRestoreItem(item);
    s.bar=bar; s.image=item.imageView.image; s.imageMode=item.imageView.contentMode;
    s.imageFrame=item.imageView.frame; s.textFrame=item.textLabel.frame; s.badgeFrame=item.badgeView.frame;
    s.textHidden=item.textLabel.hidden; s.imageHidden=item.imageView.hidden; s.text=item.textLabel.text;
    s.customIcon=CSCustomIcon(item); s.customHidden=s.customIcon.hidden; s.customFrame=s.customIcon.frame;
    s.applied=YES;
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    UIImage *custom=[p iconAtIndex:index selected:item.isSelected];
    if (custom) {
        item.imageView.image=custom; item.imageView.contentMode=UIViewContentModeScaleAspectFit;
        item.imageView.hidden=NO; s.customIcon.hidden=YES;
    }
    NSString *title=[p titleAtIndex:index];
    if (title) item.textLabel.text=title;
    item.textLabel.hidden=p.hideText || s.textHidden;
    CGFloat height=CGRectGetHeight(item.bounds), width=CGRectGetWidth(item.bounds);
    CGFloat labelHeight=p.hideText ? 0 : MIN(20,MAX(12,item.textLabel.font.lineHeight));
    CGFloat iconHeight=MIN(28,MAX(20,height-labelHeight-12));
    CGSize nativeSize=custom ? CGSizeMake(25,25) : s.imageFrame.size;
    if (nativeSize.width<=0 || nativeSize.height<=0) nativeSize=CGSizeMake(25,25);
    CGFloat factor=MIN(iconHeight/MAX(1,nativeSize.height),MIN(32,width-12)/MAX(1,nativeSize.width));
    CGSize size=CGSizeMake(nativeSize.width*factor,nativeSize.height*factor);
    CGFloat gap=p.hideText ? 0 : 3;
    CGFloat top=(height-size.height-labelHeight-gap)/2;
    CGRect imageFrame=CGRectMake((width-size.width)/2,top,size.width,size.height);
    CSSetFrame(item.imageView,imageFrame);
    if (s.customIcon && !custom) CSSetFrame(s.customIcon,imageFrame);
    if (!p.hideText) CSSetFrame(item.textLabel,CGRectMake(2,CGRectGetMaxY(imageFrame)+gap,width-4,labelHeight));
    // Keep the original badge object, value, shape and visibility. Move its native anchor.
    CGRect badge=s.badgeFrame;
    badge.origin.x+=CGRectGetMaxX(imageFrame)-CGRectGetMaxX(s.imageFrame);
    badge.origin.y+=CGRectGetMinY(imageFrame)-CGRectGetMinY(s.imageFrame);
    s.badgeOffset=CGPointMake(badge.origin.x-s.badgeFrame.origin.x,badge.origin.y-s.badgeFrame.origin.y);
    CSSetFrame(item.badgeView,badge);
}

static void CSRestoreInset(CSTabBarState *s) {
    UIScrollView *scroll=s.scrollView;
    if (s.insetApplied && scroll) {
        UIEdgeInsets inset=scroll.contentInset;
        if (fabs(inset.bottom-s.appliedInset)<.01) { inset.bottom=s.nativeInset; scroll.contentInset=inset; }
        UIEdgeInsets indicator=scroll.verticalScrollIndicatorInsets;
        if (fabs(indicator.bottom-s.appliedIndicatorInset)<.01) { indicator.bottom=s.nativeIndicatorInset; scroll.verticalScrollIndicatorInsets=indicator; }
    }
    s.insetApplied=NO; s.scrollView=nil;
}
// Only the largest root-page table participates; nested horizontal strips and chat pages are excluded.
static UITableView *CSMainTable(UIView *view) {
    if (!view || view.hidden || view.alpha<.01) return nil;
    if ([view isKindOfClass:UITableView.class]) return (UITableView *)view;
    UITableView *best=nil;
    for (UIView *child in view.subviews) {
        UITableView *candidate=CSMainTable(child);
        if (candidate && CGRectGetWidth(candidate.bounds)*CGRectGetHeight(candidate.bounds) > CGRectGetWidth(best.bounds)*CGRectGetHeight(best.bounds)) best=candidate;
    }
    return best;
}
static void CSUpdateInset(CSTabBarState *s) {
    UIViewController *selected=s.controller.selectedViewController;
    if ([selected isKindOfClass:UINavigationController.class]) {
        UINavigationController *nav=(id)selected;
        if (nav.viewControllers.count!=1) { CSRestoreInset(s); return; }
        selected=nav.topViewController;
    }
    UITableView *table=CSMainTable(selected.viewIfLoaded);
    if (!table || table.window!=s.bar.window) { CSRestoreInset(s); return; }
    if (s.scrollView!=table) { CSRestoreInset(s); s.scrollView=table; }
    UIEdgeInsets inset=table.contentInset, indicator=table.verticalScrollIndicatorInsets;
    if (!s.insetApplied || fabs(inset.bottom-s.appliedInset)>.01) s.nativeInset=inset.bottom;
    if (!s.insetApplied || fabs(indicator.bottom-s.appliedIndicatorInset)>.01) s.nativeIndicatorInset=indicator.bottom;
    CGRect viewport=[table convertRect:table.bounds toView:s.bar];
    CGFloat system=table.adjustedContentInset.bottom-inset.bottom;
    CGFloat desired=CSTabBarRequiredBottomInset(CGRectGetMaxY(viewport),CGRectGetMinY(s.floatingRect),s.nativeInset,system);
    s.appliedInset=desired;
    s.appliedIndicatorInset=s.nativeIndicatorInset+MAX(0,desired-s.nativeInset);
    s.insetApplied=YES;
    if (fabs(inset.bottom-desired)>.01) { inset.bottom=desired; table.contentInset=inset; }
    if (fabs(indicator.bottom-s.appliedIndicatorInset)>.01) { indicator.bottom=s.appliedIndicatorInset; table.verticalScrollIndicatorInsets=indicator; }
}
static void CSRestoreGeometry(CSTabBarState *s) {
    if (!s.geometryApplied) return;
    s.geometryApplied=NO;
    for (MMTabBarItemView *item in CSItems(s.bar)) CSRestoreItem(item);
    for (CSTabBarButtonState *b in s.buttons) {
        CSRestoreItem((MMTabBarItemView *)b.item);
        CSSetFrame(b.button,b.frame); CSSetFrame(b.item,b.itemFrame);
    }
}
static void CSRestoreVisuals(CSTabBarState *s) {
    if (!s.applied) return;
    s.applied=NO;
    MMTabBar *bar=s.bar;
    bar.backgroundColor=s.nativeBackground; bar.clipsToBounds=s.clips;
    for (UIView *view in s.backgroundHidden) view.hidden=[[s.backgroundHidden objectForKey:view] boolValue];
    [s.backgroundHidden removeAllObjects];
    CSRestoreGeometry(s);
    s.surface.hidden=YES;
}
static void CSStop(CSTabBarState *s) {
    if (!s) return;
    CSRestoreVisuals(s); CSRestoreInset(s);
    [s.surface.layer removeAnimationForKey:@"cs.tabbar.pulse"];
    s.animation=-1; s.renderedPreferences=nil;
    for (UIControl *button in s.observedButtons) {
        [button removeTarget:s action:@selector(touchBegan:) forControlEvents:UIControlEventTouchDown];
        [button removeTarget:s action:@selector(touchEnded:) forControlEvents:UIControlEventTouchUpInside];
    }
    [s.observedButtons removeAllObjects];
    [s.surface removeFromSuperview];
}
static void CSRenderSurface(CSTabBarState *s, UIView *container) {
    MMTabBar *bar=s.bar; CSTabBarPreferences *p=CSTabBarPreferences.current;
    if (!s.surface) {
        s.surface=[UIView new]; s.surface.userInteractionEnabled=NO;
        s.material=[[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial]];
        s.material.userInteractionEnabled=NO; [s.surface addSubview:s.material];
        s.border=[CAShapeLayer layer]; s.border.fillColor=UIColor.clearColor.CGColor;
        [s.surface.layer addSublayer:s.border];
    }
    if (s.surface.superview!=container) [container insertSubview:s.surface atIndex:0];
    s.surface.hidden=NO;
    CSSetFrame(s.surface,s.floatingRect); CSSetFrame(s.material,s.surface.bounds);
    if (s.renderedPreferences==p && CGSizeEqualToSize(s.renderedSize,s.surface.bounds.size) && s.renderedStyle==bar.traitCollection.userInterfaceStyle && s.renderedNativeBackground==s.nativeBackground) return;
    s.renderedPreferences=p; s.renderedNativeBackground=s.nativeBackground; s.renderedSize=s.surface.bounds.size; s.renderedStyle=bar.traitCollection.userInterfaceStyle;
    CGFloat radius=p.borderStyle==0 ? CGRectGetHeight(s.floatingRect)/2 : MIN(p.cornerRadius,CGRectGetHeight(s.floatingRect)/2);
    s.material.layer.cornerRadius=radius; s.material.clipsToBounds=YES;
    s.material.hidden=p.backgroundColor!=nil;
    s.surface.backgroundColor=p.backgroundColor ?: s.nativeBackground ?: bar.backgroundView.backgroundColor ?: UIColor.clearColor;
    s.surface.layer.cornerRadius=radius;
    s.border.frame=s.surface.bounds;
    CGFloat line=p.borderColor ? p.borderWidth : 0;
    CGRect pathRect=CGRectInset(s.surface.bounds,line/2,line/2);
    s.border.path=[UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:MAX(0,radius-line/2)].CGPath;
    s.border.strokeColor=[p.borderColor resolvedColorWithTraitCollection:bar.traitCollection].CGColor;
    s.border.lineWidth=line;
    NSInteger animation=(p.borderColor && line>0 && !UIAccessibilityIsReduceMotionEnabled()) ? p.animation : 0;
    s.surface.layer.shadowColor=[p.borderColor resolvedColorWithTraitCollection:bar.traitCollection].CGColor;
    s.surface.layer.shadowOffset=CGSizeZero; s.surface.layer.shadowRadius=6;
    s.surface.layer.shadowPath=[UIBezierPath bezierPathWithRoundedRect:s.surface.bounds cornerRadius:radius].CGPath;
    s.surface.layer.shadowOpacity=0;
    if (s.animation!=animation) {
        [s.surface.layer removeAnimationForKey:@"cs.tabbar.pulse"]; s.animation=animation;
        if (animation) {
            CAKeyframeAnimation *pulse=[CAKeyframeAnimation animationWithKeyPath:@"shadowOpacity"];
            pulse.values=animation==1 ? @[@.15,@.8,@.15] : @[@.15,@.8,@.2,@.55,@.15];
            pulse.duration=animation==1 ? 3 : 1.2; pulse.repeatCount=HUGE_VALF;
            [s.surface.layer addAnimation:pulse forKey:@"cs.tabbar.pulse"];
        }
    }
}

void CSTabBarUpdate(MMTabBar *bar) {
    CSTabBarState *s=CSState(bar,CSTabBarPreferences.current.enabled);
    if (!s || s.depth || s.applying) return;
    s.applying=YES;
    s.controller=CSOwner(bar);
    NSArray *items=CSItems(bar);
    if (!CSTabBarPreferences.current.enabled || ![s.controller respondsToSelector:@selector(getTabBarBtnForIndex:)] || !CSOwner(bar) || items.count!=4 || bar.items.count!=4) {
        CSStop(s); s.applying=NO; return;
    }
    // Fail closed if the native controls are unavailable; never replace navigation.
    NSMutableArray *buttons=[NSMutableArray array];
    for (NSUInteger i=0;i<items.count;i++) {
        id button=[s.controller getTabBarBtnForIndex:i];
        if (![items[i] isKindOfClass:NSClassFromString(@"MMTabBarItemView")] || ![button isKindOfClass:UIControl.class] || ![button isDescendantOfView:bar]) {
            CSStop(s); s.applying=NO; return;
        }
        [buttons addObject:button];
    }
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    CSTabBarRect rect=CSTabBarFloatingRect(CGRectGetWidth(bar.bounds),CGRectGetHeight(bar.bounds),p.scale,p.contentHeight,p.lift);
    if (rect.width<=0 || bar.layer.mask) { CSStop(s); s.applying=NO; return; }
    for (UIView *ancestor=bar.superview;ancestor;ancestor=ancestor.superview) {
        // A navigation transition can move the whole bar beyond a clipping ancestor.
        // Only reject floating overflow when the native bar itself is fully inside it.
        if (ancestor.clipsToBounds && CGRectContainsRect(ancestor.bounds,[bar convertRect:bar.bounds toView:ancestor]) && !CGRectContainsRect(ancestor.bounds,[bar convertRect:CSRect(rect) toView:ancestor])) {
            CSStop(s); s.applying=NO; return;
        }
    }
    CSRestoreGeometry(s);
    if (!s.applied) { s.nativeBackground=bar.backgroundColor; s.clips=bar.clipsToBounds; }
    else if (![bar.backgroundColor isEqual:UIColor.clearColor]) s.nativeBackground=bar.backgroundColor;
    for (UIView *view in bar.subviews) {
        NSString *name=NSStringFromClass(view.class);
        if (view==bar.backgroundView || [name containsString:@"BarBackground"]) {
            if (![s.backgroundHidden objectForKey:view]) [s.backgroundHidden setObject:@(view.hidden) forKey:view];
            if (!view.hidden) view.hidden=YES;
        }
    }
    if (![bar.backgroundColor isEqual:UIColor.clearColor]) bar.backgroundColor=UIColor.clearColor;
    bar.clipsToBounds=NO;
    s.floatingRect=CSRect(rect); s.applied=YES; s.geometryApplied=YES;
    NSMutableArray *buttonStates=[NSMutableArray array];
    BOOL rtl=bar.effectiveUserInterfaceLayoutDirection==UIUserInterfaceLayoutDirectionRightToLeft;
    for (NSUInteger i=0;i<items.count;i++) {
        MMTabBarItemView *item=items[i]; UIControl *button=buttons[i];
        CSTabBarButtonState *b=[CSTabBarButtonState new]; b.button=button; b.frame=button.frame; b.item=item; b.itemFrame=item.frame; [buttonStates addObject:b];
        CGRect frame=CSRect(CSTabBarItemRect(rect,(unsigned)i,(unsigned)items.count,rtl));
        CSSetFrame(item,[bar convertRect:frame toView:item.superview]);
        CSSetFrame(button,[bar convertRect:frame toView:button.superview]);
        if (![s.observedButtons containsObject:button]) {
            [button addTarget:s action:@selector(touchBegan:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:s action:@selector(touchEnded:) forControlEvents:UIControlEventTouchUpInside];
            [s.observedButtons addObject:button];
        }
        CSApplyItem(item,bar);
    }
    for (UIControl *old in s.observedButtons.allObjects) {
        if (![buttons containsObject:old]) {
            [old removeTarget:s action:@selector(touchBegan:) forControlEvents:UIControlEventTouchDown];
            [old removeTarget:s action:@selector(touchEnded:) forControlEvents:UIControlEventTouchUpInside];
            [s.observedButtons removeObject:old];
        }
    }
    s.buttons=buttonStates;
    [CATransaction begin]; [CATransaction setDisableActions:YES]; CSRenderSurface(s,bar); [CATransaction commit];
    // Hidden/detached bars retain their styled appearance for native transition snapshots.
    // They must not retain ownership of a page's scroll inset or receive touches.
    if (!bar.window || bar.hidden || bar.alpha<.01) CSRestoreInset(s);
    else CSUpdateInset(s);
    s.applying=NO;
}
UIView *CSTabBarStyleSnapshot(MMTabBar *bar, UIView *nativeSnapshot) {
    CSTabBarState *s=CSState(bar,NO);
    if (!s.applied || !s.geometryApplied || !CSTabBarPreferences.current.enabled || !nativeSnapshot) return nativeSnapshot;
    // WeChat 8.0.78 snapshots each item into a direct UIImageView and independently adds
    // a full-width blur and hairline. Reuse those native pixels (including badges), but
    // compose them with our surface. Never move live items or touch native navigation.
    NSMutableArray<UIView *> *images=[NSMutableArray array];
    for (MMTabBarItemView *item in CSItems(bar)) {
        if (item.superview!=bar) return nativeSnapshot;
        CGRect frame=item.frame;
        UIView *match=nil;
        for (UIView *candidate in nativeSnapshot.subviews) {
            if ([candidate isKindOfClass:UIImageView.class] && CGRectEqualToRect(candidate.frame,frame) && ![images containsObject:candidate]) {
                if (match) return nativeSnapshot;
                match=candidate;
            }
        }
        if (!match) return nativeSnapshot; // Preserve unknown snapshot compositions.
        [images addObject:match];
    }
    if (images.count!=4) return nativeSnapshot;
    UIView *snapshot=[[UIView alloc] initWithFrame:nativeSnapshot.frame];
    snapshot.bounds=nativeSnapshot.bounds; snapshot.backgroundColor=UIColor.clearColor;
    snapshot.userInteractionEnabled=NO; snapshot.clipsToBounds=NO;
    CSTabBarState *copy=[CSTabBarState new];
    copy.bar=bar; copy.floatingRect=s.floatingRect; copy.nativeBackground=s.nativeBackground; copy.animation=-1;
    [CATransaction begin]; [CATransaction setDisableActions:YES]; CSRenderSurface(copy,snapshot); [CATransaction commit];
    for (UIView *image in images) [snapshot addSubview:image];
    return snapshot;
}
void CSTabBarBeginLayout(MMTabBar *bar) {
    CSTabBarState *s=CSState(bar,CSTabBarPreferences.current.enabled);
    if (s && s.depth++==0 && !s.applying) CSRestoreGeometry(s);
}
void CSTabBarEndLayout(MMTabBar *bar) {
    CSTabBarState *s=CSState(bar,NO);
    if (s.depth) s.depth--;
    if (!s.depth) CSTabBarUpdate(bar);
}
void CSTabBarVisibilityChanged(MMTabBar *bar) { CSTabBarUpdate(bar); }
void CSTabBarBeginItemUpdate(MMTabBarItemView *item) {
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (!s) return; // Ordinary native item updates do no work until this instance is styled.
    if (s.depth++==0) CSRestoreItem(item);
}
void CSTabBarEndItemUpdate(MMTabBarItemView *item) {
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (s.depth) s.depth--;
    if (!s.depth && s.bar) CSApplyItem(item,s.bar);
}
BOOL CSTabBarContainsPoint(MMTabBar *bar, CGPoint point, BOOL *handled) {
    CSTabBarState *s=CSState(bar,NO);
    *handled=s.applied && CSTabBarPreferences.current.enabled;
    if (!*handled || bar.hidden || bar.alpha<.01 || !bar.userInteractionEnabled) return NO;
    CGFloat radius=CSTabBarPreferences.current.borderStyle==0 ? s.floatingRect.size.height/2 : MIN(CSTabBarPreferences.current.cornerRadius,s.floatingRect.size.height/2);
    return [[UIBezierPath bezierPathWithRoundedRect:s.floatingRect cornerRadius:radius] containsPoint:point];
}
UIView *CSTabBarHitTest(MMTabBar *bar, CGPoint point, UIEvent *event, BOOL *handled) {
    if (!CSTabBarContainsPoint(bar,point,handled)) return nil;
    CSTabBarState *s=CSState(bar,NO);
    for (CSTabBarButtonState *b in s.buttons.reverseObjectEnumerator) {
        UIView *hit=[b.button hitTest:[bar convertPoint:point toView:b.button] withEvent:event];
        if (hit) return hit;
    }
    return bar;
}
@implementation CSTabBarState
- (void)touchBegan:(UIControl *)sender { self.selectionBeforeTouch=self.controller.selectedIndex; }
- (void)touchEnded:(UIControl *)sender {
    NSUInteger previous=self.selectionBeforeTouch;
    __weak typeof(self) weakSelf=self;
    // Native targets complete first, regardless of UIControl target ordering.
    dispatch_async(dispatch_get_main_queue(), ^{
        CSTabBarState *s=weakSelf;
        if (!s || !s.applied || s.controller.selectedIndex==previous) return;
        NSInteger haptic=CSTabBarPreferences.current.haptic;
        if (!haptic) return;
        UIImpactFeedbackStyle styles[]={UIImpactFeedbackStyleSoft,UIImpactFeedbackStyleLight,UIImpactFeedbackStyleMedium,UIImpactFeedbackStyleHeavy};
        UIImpactFeedbackGenerator *generator=[[UIImpactFeedbackGenerator alloc] initWithStyle:styles[MIN(4,haptic)-1]];
        [generator impactOccurred];
    });
}
@end
static void CSRefreshPreferences(void) {
    static BOOL pending=NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (pending) return;
        pending=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            pending=NO; [CSTabBarPreferences reload];
            for (MMTabBar *bar in CSBars.allObjects) {
                CSTabBarState *s=CSState(bar,NO); CSStop(s);
                [bar setNeedsLayout]; [bar layoutIfNeeded]; CSTabBarUpdate(bar);
            }
        });
    });
}
static void CSDarwinPreferencesChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    CSRefreshPreferences();
}
void CSTabBarInstallPreferencesObserver(void) {
    [CSTabBarPreferences reload];
    [[NSNotificationCenter defaultCenter] addObserverForName:CSTabBarPreferencesDidChange object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { CSRefreshPreferences(); }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIAccessibilityReduceMotionStatusDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { CSRefreshPreferences(); }];
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,CSDarwinPreferencesChanged,CFSTR("com.wechat.enhance.tabbar_style.changed"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
}
