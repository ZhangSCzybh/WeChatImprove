#import "CSPreferenceRefresh.h"
#import "CSTabBarNativeAdapter.h"
#import "CSTabBarPreferences.h"
#import "CSTabBarSwipeSwitcher.h"
#import "CSTabBarGeometry.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char CSBarStateKey, CSItemStateKey, CSControllerLayoutKey;
static NSHashTable<MMTabBar *> *CSBars;
static NSString * const CSOutwardAnimationKey=@"cs.tabbar.outwardPulse";
static NSString * const CSClassicAnimationKey=@"cs.tabbar.pulse";
static BOOL CSAnimationInactive;
static NSHashTable *CSInactiveAnimationScenes;
static CGRect CSRect(CSTabBarRect r) { return CGRectMake(r.x,r.y,r.width,r.height); }
static void CSSetFrame(UIView *view, CGRect frame) {
    if (view && !CGRectEqualToRect(view.frame,frame)) {
        [UIView performWithoutAnimation:^{ view.frame=frame; }];
    }
}

@interface CSTabBarItemOverlay : NSObject
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *text;
@property(nonatomic) UIViewContentMode imageMode;
@property(nonatomic) BOOL imageHidden, textHidden, customHidden;
@property(nonatomic) CGRect imageFrame, textFrame, badgeFrame, customFrame;
@property(nonatomic) CGRect customBounds;
@end
@implementation CSTabBarItemOverlay @end

@interface CSTabBarItemState : NSObject
@property(nonatomic, weak) MMTabBar *bar;
@property(nonatomic) NSUInteger depth;
@property(nonatomic) BOOL applied, textHidden, imageHidden, customHidden;
@property(nonatomic) CGRect imageFrame, textFrame, badgeFrame, customFrame;
@property(nonatomic) CGRect customBounds, renderedCustomBounds;
@property(nonatomic) CGPoint badgeOffset;
@property(nonatomic) UIViewContentMode imageMode;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, weak) UIView *customIcon;
@property(nonatomic, weak) MMTabBarItemView *renderedItem;
@property(nonatomic, weak) UIImageView *renderedImageView;
@property(nonatomic, weak) UILabel *renderedLabel;
@property(nonatomic, weak) UIView *renderedBadge;
@property(nonatomic) NSUInteger itemGeneration, styleGeneration, renderedIndex;
@property(nonatomic) BOOL renderedSelected;
@property(nonatomic) UIUserInterfaceStyle renderedStyle;
@property(nonatomic, weak) UIWindow *renderedCustomWindow;
@property(nonatomic) CGFloat renderedCustomAlpha;
@property(nonatomic) CGRect renderedBounds;
@property(nonatomic) CGFloat renderedLineHeight;
@property(nonatomic, strong) CSTabBarItemOverlay *overlay;
@end
@implementation CSTabBarItemState @end

@interface CSTabBarButtonState : NSObject
@property(nonatomic, weak) UIView *button;
@property(nonatomic, weak) UIView *item;
@property(nonatomic) CGRect itemFrame;
@property(nonatomic) CGRect frame;
@end
@implementation CSTabBarButtonState @end

@interface CSTabBarControllerLayout : NSObject
@property(nonatomic, weak) MMTabBar *bar;
@end
@implementation CSTabBarControllerLayout @end

@interface CSTabBarState : NSObject {
@public
    CGPoint swipeCenters[4];
    CGRect swipeFrames[4];
}
@property(nonatomic, weak) MMTabBar *bar;
@property(nonatomic, weak) MMTabBar *snapshotSource;
@property(nonatomic, weak) MMTabBarController *controller;
@property(nonatomic) NSUInteger depth;
@property(nonatomic) BOOL applied, geometryApplied, applying, clips;
@property(nonatomic) NSUInteger itemGeneration, styleGeneration;
@property(nonatomic, strong) CSTabBarPreferences *stylePreferences;
@property(nonatomic) CGRect floatingRect;
@property(nonatomic, strong) UIColor *nativeBackground;
@property(nonatomic, strong) NSMapTable<UIView *,NSNumber *> *backgroundHidden;
@property(nonatomic, strong) NSArray<CSTabBarButtonState *> *buttons;
@property(nonatomic, strong) UIView *surface;
@property(nonatomic, strong) UIVisualEffectView *material;
@property(nonatomic, strong) CAShapeLayer *border;
@property(nonatomic, strong) CALayer *haloContainer;
@property(nonatomic, strong) CAShapeLayer *halo, *haloMask;
@property(nonatomic, weak) CSTabBarPreferences *renderedPreferences;
@property(nonatomic, strong) UIColor *renderedNativeBackground;
@property(nonatomic) CGSize renderedSize;
@property(nonatomic) UIUserInterfaceStyle renderedStyle;
@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic) CGFloat nativeInset, nativeIndicatorInset, appliedInset, appliedIndicatorInset;
@property(nonatomic) BOOL insetApplied;
@property(nonatomic) BOOL insetDeferred;
@property(nonatomic, strong) UIImpactFeedbackGenerator *hapticGenerator;
@property(nonatomic) NSInteger hapticStyle;
@property(nonatomic, strong) UIView *capsuleHost, *capsule;
@property(nonatomic, strong) NSArray<UIControl *> *trackingControls;
@property(nonatomic) CSTabBarClickEffect renderedEffect;
@property(nonatomic) NSUInteger capsuleIndex, feedbackGeneration;
@property(nonatomic) BOOL touchActive, selecting, touchDragged;
@property(nonatomic) NSInteger touchStartIndex, touchOriginIndex;
@property(nonatomic) CFTimeInterval lastFirstTabTapTime;
@property(nonatomic) NSInteger swipeCount, gestureSelectedIndex, liquidHoverIndex;
@property(nonatomic) NSUInteger swipeGeneration, swipeItemGeneration, swipeStyleGeneration;
@property(nonatomic) CGRect swipeBarBounds, swipeFloatingRect;
@property(nonatomic) CGPoint touchPoint;

@end

// WCTabBarView and WCTabBarController deliberately report compatibility with
// UIKit classes. Inspect the real class chain before choosing a selector family.
static BOOL CSHasNativeClass(id object, NSString *name) {
    Class expected=NSClassFromString(name);
    if (!expected) return NO;
    for (Class cls=object_getClass(object);cls;cls=class_getSuperclass(cls)) if (cls==expected) return YES;
    return NO;
}
static BOOL CSModernBar(MMTabBar *bar) { return CSHasNativeClass(bar,@"WCTabBarView"); }
static MMTabBarController *CSOwner(MMTabBar *bar) {
    CSTabBarState *state=objc_getAssociatedObject(bar,&CSBarStateKey);
    if (state.snapshotSource) return CSOwner(state.snapshotSource);
    id owner=CSModernBar(bar) ? ((WCTabBarView *)bar).visibilityDelegate : bar.customDelegate;
    return CSHasNativeClass(owner,@"MainTabBarViewController") || CSHasNativeClass(owner,@"NewMainTabBarViewController") ? owner : nil;
}
MMTabBar *CSTabBarForController(MMTabBarController *controller) {
    if (CSHasNativeClass(controller,@"WCTabBarController")) {
        id bar=((WCTabBarController *)controller).tabBarView;
        return CSHasNativeClass(bar,@"WCTabBarView") ? bar : nil;
    }
    id bar=controller.tabBar;
    return CSHasNativeClass(bar,@"MMTabBar") ? bar : nil;
}
static CSTabBarState *CSState(MMTabBar *bar, BOOL create) {
    if (!bar) return nil;
    CSTabBarState *s=objc_getAssociatedObject(bar,&CSBarStateKey);
    if (!s && create && CSOwner(bar)) {
        s=[CSTabBarState new]; s.bar=bar; s.controller=CSOwner(bar);
        s.backgroundHidden=[NSMapTable weakToStrongObjectsMapTable];
        objc_setAssociatedObject(bar,&CSBarStateKey,s,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (!CSBars) CSBars=[NSHashTable weakObjectsHashTable];
        [CSBars addObject:bar];
    }
    return s;
}
static NSArray<MMTabBarItemView *> *CSItems(MMTabBar *bar) {
    if (CSModernBar(bar)) {
        NSArray *wrappers=((WCTabBarView *)bar).itemViews;
        if (![wrappers isKindOfClass:NSArray.class]) return @[];
        NSMutableArray *items=[NSMutableArray arrayWithCapacity:wrappers.count];
        for (id wrapper in wrappers) {
            if (!CSHasNativeClass(wrapper,@"MMMainTabBarItemView")) return @[];
            MMTabBarItemView *item=((MMMainTabBarItemView *)wrapper).itemView;
            if (!CSHasNativeClass(item,@"MMTabBarItemView") || item.item!=((MMMainTabBarItemView *)wrapper).legacyItem) return @[];
            [items addObject:item];
        }
        return items;
    }
    return [bar.tabBarItemViews isKindOfClass:NSArray.class] ? [bar.tabBarItemViews copy] : @[];
}
static NSUInteger CSItemIndex(MMTabBar *bar, MMTabBarItemView *item) {
    return CSModernBar(bar) ? [CSItems(bar) indexOfObjectIdenticalTo:item] : [bar.items indexOfObjectIdenticalTo:item.item];
}
static UIControl *CSNativeButton(MMTabBar *bar, MMTabBarController *controller, NSUInteger index) {
    if (CSModernBar(bar)) {
        NSArray *wrappers=((WCTabBarView *)bar).itemViews;
        id wrapper=index<wrappers.count ? wrappers[index] : nil;
        return CSHasNativeClass(wrapper,@"MMMainTabBarItemView") && [wrapper isKindOfClass:UIControl.class] ? wrapper : nil;
    }
    return [controller respondsToSelector:@selector(getTabBarBtnForIndex:)] ? [controller getTabBarBtnForIndex:index] : nil;
}
static void CSPrepareHaptic(UIImpactFeedbackGenerator *generator) {
    SEL prepare=NSSelectorFromString(@"prepare");
    if ([generator respondsToSelector:prepare]) ((void (*)(id,SEL))[generator methodForSelector:prepare])(generator,prepare);
}
static void CSReconcileHaptic(CSTabBarState *s) {
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    NSInteger style=p.enabled && !s.snapshotSource ? p.haptic : 0;
    if (!style) { s.hapticGenerator=nil; s.hapticStyle=0; return; }
    if (s.hapticGenerator && s.hapticStyle==style) return;
    UIImpactFeedbackStyle styles[]={UIImpactFeedbackStyleSoft,UIImpactFeedbackStyleLight,UIImpactFeedbackStyleMedium,UIImpactFeedbackStyleHeavy};
    s.hapticGenerator=[[UIImpactFeedbackGenerator alloc] initWithStyle:styles[MIN(4,style)-1]];
    s.hapticStyle=style;
    CSPrepareHaptic(s.hapticGenerator);
}
static UIView *CSNativeBackground(MMTabBar *bar) {
    return CSModernBar(bar) ? ((WCTabBarView *)bar).backgroundContentView : bar.backgroundView;
}
static BOOL CSIsNativeBackground(MMTabBar *bar, UIView *view) {
    if (view==CSNativeBackground(bar)) return YES;
    if (CSModernBar(bar)) return view==((WCTabBarView *)bar).separatorView;
    return [NSStringFromClass(view.class) containsString:@"BarBackground"];
}
static UIView *CSCustomIcon(MMTabBarItemView *item) {
    SEL selector=NSSelectorFromString(@"customIconView");
    if (![item respondsToSelector:selector]) return nil;
    id value=((id (*)(id,SEL))[item methodForSelector:selector])(item,selector);
    return [value isKindOfClass:UIView.class] ? value : nil;
}
static UIImage *CSTintedNativeIcon(CSTabBarItemState *state, UIColor *color, UITraitCollection *traits) {
    UIImage *source=state.image;
    UIView *nativeIcon=state.customIcon;
    if (nativeIcon && !state.customHidden) {
        CGSize size=nativeIcon.bounds.size;
        if (!nativeIcon.window || nativeIcon.alpha<=.01 || !isfinite(size.width) || !isfinite(size.height) || size.width<=0 || size.height<=0) return nil;
        // Some 8.0.80 icons are drawn by MMTabBarItemIconView instead of imageView.
        // Preserve its selected shape without changing its native drawing state.
        UIGraphicsImageRenderer *renderer=[[UIGraphicsImageRenderer alloc] initWithSize:size];
        source=[renderer imageWithActions:^(UIGraphicsImageRendererContext *context) {
            [nativeIcon.layer renderInContext:context.CGContext];
        }];
    }
    return [source imageWithTintColor:[color resolvedColorWithTraitCollection:traits] renderingMode:UIImageRenderingModeAlwaysOriginal];
}
static BOOL CSFeedbackVisible(CSTabBarState *s) {
    if (s.snapshotSource || !s.applied || !CSTabBarPreferences.current.enabled || !s.bar.window ||
        CSOwner(s.bar)!=s.controller || CSAnimationInactive || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) return NO;
    UIWindowScene *scene=s.bar.window.windowScene;
    if (scene && ([CSInactiveAnimationScenes containsObject:scene] || scene.activationState!=UISceneActivationStateForegroundActive)) return NO;
    for (UIView *view=s.bar;view;view=view.superview) if (view.hidden || view.alpha<.01) return NO;
    return YES;
}
static BOOL CSLiquidCanAnimate(CSTabBarState *s) {
    return CSFeedbackVisible(s) && !UIAccessibilityIsReduceMotionEnabled() &&
        NSProcessInfo.processInfo.thermalState<NSProcessInfoThermalStateSerious;
}
static BOOL CSFeedbackRequested(void) {
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    return p.clickEffect!=CSTabBarClickEffectNone || p.haptic!=0 || p.swipeSwitch;
}
static void CSResetSwipe(CSTabBarState *s) {
    s.touchActive=NO; s.selecting=NO; s.swipeGeneration++;
    s.gestureSelectedIndex=NSNotFound; s.liquidHoverIndex=NSNotFound;
    [s.capsule.layer removeAllAnimations];
    s.capsule.layer.transform=CATransform3DIdentity;
}
static void CSInvalidateFeedback(CSTabBarState *s) {
    s.feedbackGeneration++; s.lastFirstTabTapTime=0;
    CSResetSwipe(s);
}
static void CSRemoveCapsule(CSTabBarState *s) {
    [s.capsule.layer removeAllAnimations];
    [s.capsuleHost removeFromSuperview];
    s.capsule=nil; s.capsuleHost=nil;
}
static void CSLiquidWrite(CSTabBarState *s, CGRect frame, CGFloat alpha) {
    s.capsule.frame=frame;
    s.capsule.layer.cornerRadius=CGRectGetHeight(frame)/2;
    s.capsule.layer.transform=CATransform3DIdentity;
    s.capsule.alpha=alpha;
}
static void CSLiquidSettle(CSTabBarState *s, BOOL animated) {
    NSUInteger selected=s.controller.selectedIndex;
    if (!s.capsule || selected>=(NSUInteger)s.swipeCount) return;
    CGRect frame=s->swipeFrames[selected];
    s.capsuleIndex=selected;
    void (^changes)(void)=^{ CSLiquidWrite(s,frame,1); };
    if (animated && CSLiquidCanAnimate(s)) {
        [UIView animateWithDuration:.46 delay:0 usingSpringWithDamping:.62 initialSpringVelocity:.82
            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
            animations:changes completion:nil];
    } else {
        [s.capsule.layer removeAllAnimations];
        [UIView performWithoutAnimation:changes];
    }
}
static void CSReconcileClickEffect(CSTabBarState *s) {
    if (!CSFeedbackVisible(s)) CSInvalidateFeedback(s);
}
static void CSReconcileCapsule(CSTabBarState *s, BOOL allowAnimation) {
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    if (!s.applied || !s.geometryApplied || !p.enabled || p.clickEffect==CSTabBarClickEffectNone ||
        !s.surface || s.swipeCount!=4) { CSRemoveCapsule(s); return; }
    BOOL initial=!s.capsule || s.renderedEffect!=p.clickEffect;
    if (initial) {
        CSRemoveCapsule(s);
        s.capsuleHost=[UIView new]; s.capsuleHost.userInteractionEnabled=NO;
        s.capsuleHost.clipsToBounds=YES;
        s.capsule=[UIView new]; s.capsule.userInteractionEnabled=NO;
        s.capsule.layer.name=@"cs.tabbar.indicator";
        [s.capsuleHost addSubview:s.capsule]; [s.surface addSubview:s.capsuleHost];
        s.renderedEffect=p.clickEffect;
    }
    CSSetFrame(s.capsuleHost,s.surface.bounds);
    s.capsuleHost.layer.cornerRadius=s.surface.layer.cornerRadius;
    BOOL dark=s.bar.traitCollection.userInterfaceStyle==UIUserInterfaceStyleDark;
    s.capsule.backgroundColor=[(p.indicatorColor ?: [UIColor colorWithRed:dark?1:0 green:dark?1:0 blue:dark?1:0 alpha:dark?.12:.08]) resolvedColorWithTraitCollection:s.bar.traitCollection];
    if (s.touchActive || s.selecting) return;
    NSUInteger selected=s.controller.selectedIndex;
    if (selected>=4) return;
    BOOL changed=s.capsuleIndex!=selected || !CGRectEqualToRect(s.capsule.frame,s->swipeFrames[selected]);
    if (initial || changed || !allowAnimation) CSLiquidSettle(s,!initial && allowAnimation && changed);
}
void CSTabBarSelectionDidChange(MMTabBarController *controller) {
    CSTabBarState *s=CSState(CSTabBarForController(controller),NO);
    // Our synchronous native selection may relayout; keep the pressed geometry.
    if (s.selecting) return;
    if (s.touchActive) CSResetSwipe(s);
    if (s && !s.depth && !s.applying) CSReconcileCapsule(s,YES);
}
static void CSRestoreItem(MMTabBarItemView *item) {
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (!s.applied) return;
    s.applied=NO;
    if (item.imageView.image!=s.image) item.imageView.image=s.image;
    if (item.imageView.contentMode!=s.imageMode) item.imageView.contentMode=s.imageMode;
    if (item.imageView.hidden!=s.imageHidden) item.imageView.hidden=s.imageHidden;
    if (item.textLabel.hidden!=s.textHidden) item.textLabel.hidden=s.textHidden;
    if (![item.textLabel.text isEqualToString:s.text] && item.textLabel.text!=s.text) item.textLabel.text=s.text;
    CSSetFrame(item.imageView,s.imageFrame); CSSetFrame(item.textLabel,s.textFrame);
    CGRect badge=item.badgeView.frame;
    badge.origin.x-=s.badgeOffset.x; badge.origin.y-=s.badgeOffset.y;
    CSSetFrame(item.badgeView,badge);
    if (s.customIcon) {
        // A native icon can finish sizing after our overlay was installed. Keep
        // that new source geometry instead of restoring the previous zero size.
        if (s.overlay && !CGRectEqualToRect(s.customIcon.frame,s.overlay.customFrame)) s.customFrame=s.customIcon.frame;
        if (s.overlay && !CGRectEqualToRect(s.customIcon.bounds,s.overlay.customBounds)) s.customBounds=s.customIcon.bounds;
        if (s.customIcon.hidden!=s.customHidden) s.customIcon.hidden=s.customHidden;
        CSSetFrame(s.customIcon,s.customFrame);
        if (!CGRectEqualToRect(s.customIcon.bounds,s.customBounds)) s.customIcon.bounds=s.customBounds;
    }
}
static BOOL CSItemTextEqual(NSString *a, NSString *b) { return a==b || [a isEqualToString:b]; }
static BOOL CSItemAppearanceMatches(MMTabBarItemView *item,CSTabBarItemState *s,BOOL overlay) {
    CSTabBarItemOverlay *o=s.overlay;
    return item.imageView.image==(overlay ? o.image : s.image) &&
        item.imageView.contentMode==(overlay ? o.imageMode : s.imageMode) &&
        item.imageView.hidden==(overlay ? o.imageHidden : s.imageHidden) &&
        item.textLabel.hidden==(overlay ? o.textHidden : s.textHidden) &&
        CSItemTextEqual(item.textLabel.text,overlay ? o.text : s.text) &&
        CGRectEqualToRect(item.imageView.frame,overlay ? o.imageFrame : s.imageFrame) &&
        CGRectEqualToRect(item.textLabel.frame,overlay ? o.textFrame : s.textFrame) &&
        CGRectEqualToRect(item.badgeView.frame,overlay ? o.badgeFrame : s.badgeFrame) &&
        CSCustomIcon(item)==s.customIcon && (!s.customIcon ||
        (s.customIcon.hidden==(overlay ? o.customHidden : s.customHidden) &&
        CGRectEqualToRect(s.customIcon.frame,overlay ? o.customFrame : s.customFrame) &&
        CGRectEqualToRect(s.customIcon.bounds,overlay ? o.customBounds : s.customBounds)));
}
static void CSWriteItemOverlay(MMTabBarItemView *item,CSTabBarItemState *s) {
    CSTabBarItemOverlay *o=s.overlay;
    if (item.imageView.image!=o.image) item.imageView.image=o.image;
    if (item.imageView.contentMode!=o.imageMode) item.imageView.contentMode=o.imageMode;
    if (item.imageView.hidden!=o.imageHidden) item.imageView.hidden=o.imageHidden;
    if (item.textLabel.hidden!=o.textHidden) item.textLabel.hidden=o.textHidden;
    if (!CSItemTextEqual(item.textLabel.text,o.text)) item.textLabel.text=o.text;
    CSSetFrame(item.imageView,o.imageFrame); CSSetFrame(item.textLabel,o.textFrame);
    CSSetFrame(item.badgeView,o.badgeFrame);
    if (s.customIcon) {
        if (s.customIcon.hidden!=o.customHidden) s.customIcon.hidden=o.customHidden;
        CSSetFrame(s.customIcon,o.customFrame);
        if (!CGRectEqualToRect(s.customIcon.bounds,o.customBounds)) s.customIcon.bounds=o.customBounds;
    }
    s.applied=YES;
}
static void CSApplyItemAtIndex(MMTabBarItemView *item, MMTabBar *bar, NSUInteger index) {
    CSTabBarState *host=CSState(bar,NO);
    if (!host.applied || host.depth || !CSTabBarPreferences.current.enabled) return;
    if (index==NSNotFound || index>=4) return;
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (!s) {
        s=[CSTabBarItemState new];
        objc_setAssociatedObject(item,&CSItemStateKey,s,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (s.depth) return;
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    if (host.stylePreferences!=p) { host.stylePreferences=p; host.styleGeneration++; }
    UIView *nativeCustomIcon=CSCustomIcon(item);
    CGRect nativeCustomBounds=nativeCustomIcon.bounds;
    if (s.applied && nativeCustomIcon==s.customIcon && CGRectEqualToRect(nativeCustomBounds,s.overlay.customBounds)) nativeCustomBounds=s.customBounds;
    BOOL same=s.overlay && s.bar==bar && s.renderedItem==item &&
        s.itemGeneration==host.itemGeneration && s.styleGeneration==host.styleGeneration &&
        s.renderedIndex==index && s.renderedSelected==item.isSelected &&
        s.renderedStyle==bar.traitCollection.userInterfaceStyle &&
        s.renderedCustomWindow==nativeCustomIcon.window && s.renderedCustomAlpha==nativeCustomIcon.alpha &&
        CGRectEqualToRect(s.renderedCustomBounds,nativeCustomBounds) &&
        s.renderedImageView==item.imageView && s.renderedLabel==item.textLabel && s.renderedBadge==item.badgeView &&
        CGRectEqualToRect(s.renderedBounds,item.bounds) && s.renderedLineHeight==item.textLabel.font.lineHeight;
    if (same && CSItemAppearanceMatches(item,s,s.applied)) {
        // End always restores the overlay after %orig. Only unchanged inputs reuse it.
        if (!s.applied) CSWriteItemOverlay(item,s);
        CSReconcileClickEffect(host);
        return;
    }
    CSRestoreItem(item);
    s.bar=bar; s.image=item.imageView.image; s.imageMode=item.imageView.contentMode;
    s.imageFrame=item.imageView.frame; s.textFrame=item.textLabel.frame; s.badgeFrame=item.badgeView.frame;
    s.textHidden=item.textLabel.hidden; s.imageHidden=item.imageView.hidden; s.text=item.textLabel.text;
    s.customIcon=CSCustomIcon(item); s.customHidden=s.customIcon.hidden; s.customFrame=s.customIcon.frame;
    s.customBounds=s.customIcon.bounds;
    s.applied=YES;
    s.renderedItem=item; s.renderedImageView=item.imageView; s.renderedLabel=item.textLabel; s.renderedBadge=item.badgeView;
    s.itemGeneration=host.itemGeneration; s.styleGeneration=host.styleGeneration; s.renderedIndex=index;
    s.renderedSelected=item.isSelected; s.renderedBounds=item.bounds; s.renderedLineHeight=item.textLabel.font.lineHeight;
    s.renderedStyle=bar.traitCollection.userInterfaceStyle;
    s.renderedCustomWindow=s.customIcon.window; s.renderedCustomAlpha=s.customIcon.alpha;
    s.renderedCustomBounds=s.customBounds;
    UIImage *custom=[p iconAtIndex:index selected:item.isSelected];
    BOOL drawnNativeReplacement=NO;
    if (custom) {
        item.imageView.image=custom; item.imageView.contentMode=UIViewContentModeScaleAspectFit;
        item.imageView.hidden=NO; s.customIcon.hidden=YES;
    } else if (item.isSelected && p.selectedIconColor) {
        UIImage *tinted=CSTintedNativeIcon(s,p.selectedIconColor,bar.traitCollection);
        if (tinted) {
            item.imageView.image=tinted;
            item.imageView.hidden=NO;
            drawnNativeReplacement=s.customIcon && !s.customHidden && s.customIcon.alpha>.01;
            if (drawnNativeReplacement) item.imageView.contentMode=UIViewContentModeScaleAspectFit;
            s.customIcon.hidden=YES;
        }
    }
    NSString *title=[p titleAtIndex:index];
    if (title) item.textLabel.text=title;
    item.textLabel.hidden=p.hideText || s.textHidden;
    CGFloat height=CGRectGetHeight(item.bounds), width=CGRectGetWidth(item.bounds);
    CGFloat labelHeight=p.hideText ? 0 : MIN(20,MAX(12,item.textLabel.font.lineHeight));
    CGFloat iconHeight=MIN(28,MAX(20,height-labelHeight-12));
    CGSize nativeSize=custom ? CGSizeMake(25,25) : (drawnNativeReplacement ? s.customFrame.size : s.imageFrame.size);
    if (nativeSize.width<=0 || nativeSize.height<=0) nativeSize=CGSizeMake(25,25);
    CGFloat factor=MIN(iconHeight/MAX(1,nativeSize.height),MIN(32,width-12)/MAX(1,nativeSize.width));
    CGSize size=CGSizeMake(nativeSize.width*factor,nativeSize.height*factor);
    CGFloat gap=p.hideText ? 0 : 3;
    CGFloat top=(height-size.height-labelHeight-gap)/2;
    CGRect imageFrame=CGRectMake((width-size.width)/2,top,size.width,size.height);
    CSSetFrame(item.imageView,imageFrame);
    if (s.customIcon && !custom && s.customBounds.size.width>0 && s.customBounds.size.height>0) CSSetFrame(s.customIcon,imageFrame);
    if (!p.hideText) CSSetFrame(item.textLabel,CGRectMake(2,CGRectGetMaxY(imageFrame)+gap,width-4,labelHeight));
    // Keep the original badge object, value, shape and visibility. Move its native anchor.
    CGRect badge=s.badgeFrame;
    badge.origin.x+=CGRectGetMaxX(imageFrame)-CGRectGetMaxX(s.imageFrame);
    badge.origin.y+=CGRectGetMinY(imageFrame)-CGRectGetMinY(s.imageFrame);
    s.badgeOffset=CGPointMake(badge.origin.x-s.badgeFrame.origin.x,badge.origin.y-s.badgeFrame.origin.y);
    CSSetFrame(item.badgeView,badge);
    CSTabBarItemOverlay *overlay=[CSTabBarItemOverlay new];
    overlay.image=item.imageView.image; overlay.imageMode=item.imageView.contentMode;
    overlay.imageHidden=item.imageView.hidden; overlay.textHidden=item.textLabel.hidden; overlay.text=item.textLabel.text;
    overlay.imageFrame=item.imageView.frame; overlay.textFrame=item.textLabel.frame; overlay.badgeFrame=item.badgeView.frame;
    overlay.customHidden=s.customIcon.hidden; overlay.customFrame=s.customIcon.frame; overlay.customBounds=s.customIcon.bounds; s.overlay=overlay;
    CSReconcileClickEffect(host);
}
static void CSApplyItem(MMTabBarItemView *item, MMTabBar *bar) {
    CSTabBarState *host=CSState(bar,NO);
    if (!host.applied || host.depth || !CSTabBarPreferences.current.enabled) return;
    CSApplyItemAtIndex(item,bar,CSItemIndex(bar,item));
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
static void CSUpdateVisibleInset(CSTabBarState *s) {
    MMTabBar *bar=s.bar;
    if (s.snapshotSource || !s.applied || !CSTabBarPreferences.current.enabled || !bar.window || bar.hidden || bar.alpha<.01) CSRestoreInset(s);
    else CSUpdateInset(s);
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
    CSResetSwipe(s); s.swipeCount=0;
    CSInvalidateFeedback(s);
    CSRemoveCapsule(s);
    CSReconcileHaptic(s);
    CSRestoreVisuals(s); CSRestoreInset(s);
    [s.halo removeAnimationForKey:CSOutwardAnimationKey];
    [s.surface.layer removeAnimationForKey:CSClassicAnimationKey];
    s.surface.layer.shadowOpacity=0;
    s.renderedPreferences=nil;
    for (UIControl *control in s.trackingControls) [control removeFromSuperview];
    s.trackingControls=nil;
    [s.surface removeFromSuperview];
}
static NSInteger CSDesiredAnimation(CSTabBarState *s) {
    if (CSAnimationInactive || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive ||
        NSProcessInfo.processInfo.thermalState>=NSProcessInfoThermalStateSerious || !s.bar.window) return CSTabBarBorderAnimationNone;
    if (s.bar.window.windowScene && ([CSInactiveAnimationScenes containsObject:s.bar.window.windowScene] || s.bar.window.windowScene.activationState!=UISceneActivationStateForegroundActive)) return CSTabBarBorderAnimationNone;
    for (UIView *view=s.bar;view;view=view.superview) if (view.hidden || view.alpha<.01) return CSTabBarBorderAnimationNone;
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    return p.enabled && p.borderColor && p.borderWidth>0 && !UIAccessibilityIsReduceMotionEnabled() ? p.animation : CSTabBarBorderAnimationNone;
}
// Outward modes use a masked ring; classic modes preserve the original full-surface shadow.
static void CSRenderBorderAnimation(CSTabBarState *s, CGFloat radius, CGFloat line) {
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    if (!s.haloContainer) {
        s.haloContainer=[CALayer layer];
        s.halo=[CAShapeLayer layer]; s.halo.fillColor=UIColor.clearColor.CGColor;
        s.haloMask=[CAShapeLayer layer]; s.haloMask.fillRule=kCAFillRuleEvenOdd;
        s.haloMask.fillColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
        s.haloContainer.mask=s.haloMask;
        [s.haloContainer addSublayer:s.halo];
        [s.surface.layer insertSublayer:s.haloContainer below:s.border];
    }
    [s.halo removeAnimationForKey:CSOutwardAnimationKey];
    [s.surface.layer removeAnimationForKey:CSClassicAnimationKey];
    s.surface.layer.shadowOpacity=0; s.surface.layer.shadowPath=NULL;
    s.surface.layer.shadowColor=NULL; s.surface.layer.shadowRadius=0;
    NSInteger animation=CSDesiredAnimation(s);
    BOOL classic=animation==CSTabBarBorderAnimationClassicBreathing || animation==CSTabBarBorderAnimationClassicHeartbeat;
    s.haloContainer.hidden=animation==0 || classic;
    s.halo.opacity=0; // No residual glow when stopped or between pulses.
    if (!animation) return;
    if (classic) {
        s.surface.layer.shadowColor=[p.borderColor resolvedColorWithTraitCollection:s.bar.traitCollection].CGColor;
        s.surface.layer.shadowOffset=CGSizeZero; s.surface.layer.shadowRadius=6;
        s.surface.layer.shadowPath=[UIBezierPath bezierPathWithRoundedRect:s.surface.bounds cornerRadius:radius].CGPath;
        BOOL breathing=animation==CSTabBarBorderAnimationClassicBreathing;
        CAKeyframeAnimation *pulse=[CAKeyframeAnimation animationWithKeyPath:@"shadowOpacity"];
        pulse.values=breathing ? @[@.15,@.8,@.15] : @[@.15,@.8,@.2,@.55,@.15];
        pulse.duration=breathing ? 3 : 1.2; pulse.repeatCount=HUGE_VALF;
        [s.surface.layer addAnimation:pulse forKey:CSClassicAnimationKey];
        return;
    }
    // An inverse rounded-rectangle mask excludes the bar interior from outward glow.
    const CGFloat margin=36, spread=10;
    s.haloContainer.frame=CGRectInset(s.surface.bounds,-margin,-margin);
    s.halo.frame=s.haloContainer.bounds; s.haloMask.frame=s.haloContainer.bounds;
    CGRect outline=CGRectInset(s.halo.bounds,margin,margin);
    CGMutablePathRef mask=CGPathCreateMutable();
    CGPathAddRect(mask,NULL,s.haloContainer.bounds);
    CGPathAddPath(mask,NULL,[UIBezierPath bezierPathWithRoundedRect:outline cornerRadius:radius].CGPath);
    s.haloMask.path=mask; CGPathRelease(mask);
    CGRect stroke=CGRectInset(outline,line/2,line/2);
    CGFloat strokeRadius=MAX(.01,radius-line/2); // Keep rounded-path topology stable even for square corners.
    UIBezierPath *start=[UIBezierPath bezierPathWithRoundedRect:stroke cornerRadius:strokeRadius];
    UIBezierPath *near=[UIBezierPath bezierPathWithRoundedRect:CGRectInset(stroke,-2,-2) cornerRadius:strokeRadius+2];
    UIBezierPath *end=[UIBezierPath bezierPathWithRoundedRect:CGRectInset(stroke,-spread,-spread) cornerRadius:strokeRadius+spread];
    s.halo.path=start.CGPath; s.halo.lineWidth=line;
    s.halo.strokeColor=[p.borderColor resolvedColorWithTraitCollection:s.bar.traitCollection].CGColor;
    s.halo.shadowColor=s.halo.strokeColor; s.halo.shadowOffset=CGSizeZero;
    s.halo.shadowOpacity=1; s.halo.shadowRadius=0;
    // No filled shadowPath: the stroke itself is the source of the outward glow.
    CAKeyframeAnimation *shape=[CAKeyframeAnimation animationWithKeyPath:@"path"];
    CAKeyframeAnimation *fade=[CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    CAKeyframeAnimation *blur=[CAKeyframeAnimation animationWithKeyPath:@"shadowRadius"];
    if (animation==CSTabBarBorderAnimationOutwardBreathing) {
        shape.values=@[(__bridge id)start.CGPath,(__bridge id)near.CGPath,(__bridge id)end.CGPath];
        fade.values=@[@0,@.7,@0]; blur.values=@[@0,@3,@8];
        shape.keyTimes=fade.keyTimes=blur.keyTimes=@[@0,@.18,@1];
    } else {
        shape.values=@[(__bridge id)start.CGPath,(__bridge id)near.CGPath,(__bridge id)end.CGPath,(__bridge id)start.CGPath,(__bridge id)near.CGPath,(__bridge id)end.CGPath,(__bridge id)end.CGPath];
        fade.values=@[@0,@.8,@0,@0,@.6,@0,@0]; blur.values=@[@0,@3,@8,@0,@3,@8,@8];
        shape.keyTimes=fade.keyTimes=blur.keyTimes=@[@0,@.08,@.32,@.36,@.44,@.72,@1];
    }
    CFTimeInterval duration=animation==CSTabBarBorderAnimationOutwardBreathing ? 3 : 1.2;
    shape.duration=fade.duration=blur.duration=duration;
    CAAnimationGroup *pulse=[CAAnimationGroup animation];
    pulse.animations=@[shape,fade,blur]; pulse.duration=duration; pulse.repeatCount=HUGE_VALF;
    [s.halo addAnimation:pulse forKey:CSOutwardAnimationKey];
}
// Appearance caching cannot prove that CA animations survived suspension/detachment.
// Inspect the layer itself and leave an existing animation's phase untouched.
static void CSEnsureBorderAnimation(CSTabBarState *s) {
    NSInteger animation=CSDesiredAnimation(s);
    if (animation==CSTabBarBorderAnimationNone) {
        if (![s.halo animationForKey:CSOutwardAnimationKey] && ![s.surface.layer animationForKey:CSClassicAnimationKey]) return;
    } else {
        BOOL classic=animation==CSTabBarBorderAnimationClassicBreathing || animation==CSTabBarBorderAnimationClassicHeartbeat;
        if ([(classic ? s.surface.layer : s.halo) animationForKey:(classic ? CSClassicAnimationKey : CSOutwardAnimationKey)]) return;
    }
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    CSRenderBorderAnimation(s,s.surface.layer.cornerRadius,p.borderColor ? p.borderWidth : 0);
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
    if (s.renderedPreferences==p && CGSizeEqualToSize(s.renderedSize,s.surface.bounds.size) && s.renderedStyle==bar.traitCollection.userInterfaceStyle && s.renderedNativeBackground==s.nativeBackground) {
        CSEnsureBorderAnimation(s);
        return;
    }
    s.renderedPreferences=p; s.renderedNativeBackground=s.nativeBackground; s.renderedSize=s.surface.bounds.size; s.renderedStyle=bar.traitCollection.userInterfaceStyle;
    CGFloat radius=p.borderStyle==0 ? CGRectGetHeight(s.floatingRect)/2 : MIN(p.cornerRadius,CGRectGetHeight(s.floatingRect)/2);
    s.material.layer.cornerRadius=radius; s.material.clipsToBounds=YES;
    s.material.hidden=p.backgroundColor!=nil;
    s.surface.backgroundColor=p.backgroundColor ?: s.nativeBackground ?: CSNativeBackground(bar).backgroundColor ?: UIColor.clearColor;
    s.surface.layer.cornerRadius=radius;
    s.border.frame=s.surface.bounds;
    CGFloat line=p.borderColor ? p.borderWidth : 0;
    CGRect pathRect=CGRectInset(s.surface.bounds,line/2,line/2);
    s.border.path=[UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:MAX(0,radius-line/2)].CGPath;
    s.border.strokeColor=[p.borderColor resolvedColorWithTraitCollection:bar.traitCollection].CGColor;
    s.border.lineWidth=line;
    CSRenderBorderAnimation(s,radius,line);
}

static BOOL CSNativeControlAvailable(CSTabBarState *s, NSUInteger index) {
    if (index>=s.buttons.count) return NO;
    UIControl *button=(UIControl *)s.buttons[index].button;
    if (!button.enabled) return NO;
    for (UIView *view=button;view && view!=s.bar;view=view.superview) {
        if (view.hidden || view.alpha<.01 || !view.userInteractionEnabled) return NO;
    }
    return button && [button isDescendantOfView:s.bar];
}
// Match Neo's non-native-glass resting frame. The input slots stay native-sized.
static CGRect CSLiquidRestingFrame(CGRect slot, CGRect content, BOOL underline) {
    CGRect frame;
    if (underline) {
        CGFloat width=MIN(28,MAX(0,CGRectGetWidth(slot)-8));
        frame=CGRectMake(CGRectGetMidX(slot)-width/2,CGRectGetMaxY(content)-4,width,3);
    } else {
        frame=CGRectInset(slot,MAX(3,slot.size.width*.06),MAX(3,slot.size.height*.08));
        frame=CGRectInset(frame,-frame.size.width*.05,-frame.size.height*.05);
        frame=CGRectIntersection(frame,CGRectInset(content,2,2));
    }
    return CGRectIntegral(frame);
}
static void CSCacheSwipeGeometry(CSTabBarState *s, NSArray *items, NSArray *buttons) {
    if (items.count!=4 || buttons.count!=4) {
        CSResetSwipe(s); s.swipeCount=0; return;
    }
    CSTabBarPreferences *p=CSTabBarPreferences.current;
    BOOL geometryChanged=s.swipeCount!=4 || s.swipeItemGeneration!=s.itemGeneration ||
        s.swipeStyleGeneration!=s.styleGeneration || !CGRectEqualToRect(s.swipeBarBounds,s.bar.bounds) ||
        !CGRectEqualToRect(s.swipeFloatingRect,s.floatingRect);
    if (geometryChanged) CSResetSwipe(s);
    s.swipeCount=4; s.swipeItemGeneration=s.itemGeneration; s.swipeStyleGeneration=s.styleGeneration;
    s.swipeBarBounds=s.bar.bounds; s.swipeFloatingRect=s.floatingRect;
    BOOL tracks=!s.snapshotSource && CSFeedbackRequested();
    if (!tracks && s.trackingControls.count) {
        for (UIControl *control in s.trackingControls) [control removeFromSuperview];
        s.trackingControls=nil;
    }
    if (tracks && s.trackingControls.count!=4) {
        NSMutableArray *controls=[NSMutableArray arrayWithCapacity:4];
        for (NSUInteger i=0;i<4;i++) {
            UIControl *control=CSTabBarCreateTouchControl(s.bar);
            [s.bar addSubview:control]; [controls addObject:control];
        }
        s.trackingControls=controls;
    }
    BOOL underline=p.clickEffect==CSTabBarClickEffectUnderline;
    for (NSUInteger i=0;i<4;i++) {
        UIControl *button=buttons[i];
        CGRect slot=[button convertRect:button.bounds toView:s.surface];
        CGRect barSlot=[button convertRect:button.bounds toView:s.bar];
        s->swipeCenters[i]=CGPointMake(CGRectGetMidX(barSlot),CGRectGetMidY(barSlot));
        s->swipeFrames[i]=CSLiquidRestingFrame(slot,s.surface.bounds,underline);
        if (tracks) {
            UIControl *control=s.trackingControls[i];
            CSSetFrame(control,barSlot);
            control.hidden=!CSNativeControlAvailable(s,i);
            control.userInteractionEnabled=!control.hidden;
        }
    }
}

void CSTabBarUpdate(MMTabBar *bar) {
    CSTabBarState *s=CSState(bar,CSTabBarPreferences.current.enabled);
    if (!s || s.depth || s.applying) {
        return;
    }
    s.applying=YES;
    s.controller=CSOwner(bar);
    NSUInteger itemGeneration=s.itemGeneration;
    NSArray *items=CSItems(bar);
    if (!CSTabBarPreferences.current.enabled || !CSOwner(bar) || items.count!=4 || bar.items.count!=4) {
        CSStop(s); s.applying=NO; return;
    }
    // Fail closed if the native controls are unavailable; never replace navigation.
    NSMutableArray *buttons=[NSMutableArray array];
    for (NSUInteger i=0;i<items.count;i++) {
        id button=CSNativeButton(bar,s.controller,i);
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
        if (CSIsNativeBackground(bar,view)) {
            if (![s.backgroundHidden objectForKey:view]) [s.backgroundHidden setObject:@(view.hidden) forKey:view];
            if (!view.hidden) view.hidden=YES;
        }
    }
    if (![bar.backgroundColor isEqual:UIColor.clearColor]) bar.backgroundColor=UIColor.clearColor;
    bar.clipsToBounds=NO;
    s.floatingRect=CSRect(rect); s.applied=YES; s.geometryApplied=YES;
    NSMutableArray *buttonStates=[NSMutableArray array];
    BOOL rtl=bar.effectiveUserInterfaceLayoutDirection==UIUserInterfaceLayoutDirectionRightToLeft;
    CSReconcileHaptic(s);
    for (NSUInteger i=0;i<items.count;i++) {
        MMTabBarItemView *item=items[i]; UIControl *button=buttons[i];
        CSTabBarButtonState *b=[CSTabBarButtonState new]; b.button=button; b.frame=button.frame; b.item=item; b.itemFrame=item.frame; [buttonStates addObject:b];
        CGRect frame=CSRect(CSTabBarItemRect(rect,(unsigned)i,(unsigned)items.count,rtl));
        CSSetFrame(button,[bar convertRect:frame toView:button.superview]);
        // New item renderers are children of their native UIControl. Position the
        // control first, then fill its content; applying two bar-space frames to
        // this nested hierarchy would shift the renderer twice.
        if ([item isDescendantOfView:button]) CSSetFrame(item,[button convertRect:button.bounds toView:item.superview]);
        else CSSetFrame(item,[bar convertRect:frame toView:item.superview]);
        // This array belongs only to this synchronous update. A reentrant native
        // reload invalidates the generation and falls back to a fresh lookup.
        NSUInteger index=CSModernBar(bar) && s.itemGeneration==itemGeneration ? i : CSItemIndex(bar,item);
        CSApplyItemAtIndex(item,bar,index);
    }
    s.buttons=buttonStates;
    [CATransaction begin]; [CATransaction setDisableActions:YES]; CSRenderSurface(s,bar); [CATransaction commit];
    // Hidden/detached bars retain their styled appearance for native transition snapshots.
    // They must not retain ownership of a page's scroll inset or receive touches.
    CSTabBarControllerLayout *scope=objc_getAssociatedObject(s.controller,&CSControllerLayoutKey);
    if (scope.bar==bar && bar.window && !bar.hidden && bar.alpha>=.01) s.insetDeferred=YES;
    else { s.insetDeferred=NO; CSUpdateVisibleInset(s); }
    CSReconcileClickEffect(s);
    CSCacheSwipeGeometry(s,items,buttons);
    CSReconcileCapsule(s,YES);
    s.applying=NO;
}
UIView *CSTabBarStyleSnapshot(MMTabBar *bar, UIView *nativeSnapshot) {
    CSTabBarState *s=CSState(bar,NO);
    if (!s.applied || !s.geometryApplied || !CSTabBarPreferences.current.enabled || !nativeSnapshot) return nativeSnapshot;
    if (CSModernBar(bar)) {
        // 8.0.80 returns a real WCTabBarView with fresh native controls and copies
        // their transition visual state. Style that copy through the same layout
        // adapter so subsequent native layout passes retain its floating geometry.
        // It never observes a page inset or participates in click feedback.
        if (!CSHasNativeClass(nativeSnapshot,@"WCTabBarView") || CSItems((id)nativeSnapshot).count!=4) return nativeSnapshot;
        CSTabBarState *copy=[CSTabBarState new];
        copy.bar=(id)nativeSnapshot; copy.controller=s.controller; copy.snapshotSource=bar;
        copy.backgroundHidden=[NSMapTable weakToStrongObjectsMapTable];
        objc_setAssociatedObject(nativeSnapshot,&CSBarStateKey,copy,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        CSTabBarUpdate((id)nativeSnapshot);
        return nativeSnapshot;
    }
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
    copy.bar=bar; copy.floatingRect=s.floatingRect; copy.nativeBackground=s.nativeBackground;
    [CATransaction begin]; [CATransaction setDisableActions:YES]; CSRenderSurface(copy,snapshot); [CATransaction commit];
    if (s.capsule && CSTabBarPreferences.current.clickEffect!=CSTabBarClickEffectNone) {
        UIView *host=[[UIView alloc] initWithFrame:copy.surface.bounds];
        host.userInteractionEnabled=NO; host.clipsToBounds=YES; host.layer.cornerRadius=copy.surface.layer.cornerRadius;
        UIView *capsule=[UIView new]; capsule.userInteractionEnabled=NO;
        capsule.bounds=s.capsule.bounds; capsule.backgroundColor=s.capsule.backgroundColor;
        capsule.layer.position=s.capsule.layer.presentationLayer ? s.capsule.layer.presentationLayer.position : s.capsule.layer.position;
        capsule.layer.cornerRadius=s.capsule.layer.cornerRadius;
        [host addSubview:capsule]; [copy.surface addSubview:host];
    }
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
void CSTabBarInvalidateItemGeneration(MMTabBar *bar) {
    CSTabBarState *s=CSState(bar,NO);
    CSResetSwipe(s); s.swipeCount=0;
    CSRemoveCapsule(s); s.itemGeneration++;
}
void CSTabBarEndControllerLayout(MMTabBarController *controller) {
    CSTabBarControllerLayout *scope=objc_getAssociatedObject(controller,&CSControllerLayoutKey);
    if (!scope) return;
    objc_setAssociatedObject(controller,&CSControllerLayoutKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSTabBarState *s=CSState(scope.bar,NO);
    if (s.insetDeferred) { s.insetDeferred=NO; CSUpdateVisibleInset(s); }
}
void CSTabBarBeginControllerLayout(MMTabBarController *controller) {
    // A new will-layout boundary always closes a missing previous did-layout.
    // Only table discovery is deferred. Geometry and snapshots remain synchronous,
    // and no discovery result is retained across layout generations.
    CSTabBarEndControllerLayout(controller);
    MMTabBar *bar=CSTabBarForController(controller);
    if (!bar || !CSState(bar,CSTabBarPreferences.current.enabled)) return;
    CSTabBarControllerLayout *scope=[CSTabBarControllerLayout new];scope.bar=bar;
    objc_setAssociatedObject(controller,&CSControllerLayoutKey,scope,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    __weak MMTabBarController *weakController=controller;
    // UIKit normally closes synchronously in did-layout. Bound a missing callback
    // (including a detached controller) to this turn rather than leaving work deferred.
    dispatch_async(dispatch_get_main_queue(), ^{
        MMTabBarController *live=weakController;
        if (live && objc_getAssociatedObject(live,&CSControllerLayoutKey)==scope) {
            CSTabBarEndControllerLayout(live);
        }
    });
}
void CSTabBarBeginItemUpdate(MMTabBarItemView *item) {
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (!s) return; // Ordinary native item updates do no work until this instance is styled.
    if (s.depth++==0) CSRestoreItem(item);
}
void CSTabBarInvalidateItemAppearance(MMTabBarItemView *item) {
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    s.overlay=nil;
}
void CSTabBarEndItemUpdate(MMTabBarItemView *item) {
    CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
    if (s.depth) s.depth--;
    if (!s.depth && s.bar) {
        CSApplyItem(item,s.bar);
        CSTabBarState *host=CSState(s.bar,NO);
        if (!host.depth && !host.applying) CSReconcileCapsule(host,YES);
    }
}
static BOOL CSLiquidCanTrack(CSTabBarState *s) {
    return s && s.swipeCount==4 && !s.snapshotSource && s.applied && s.geometryApplied &&
        s.bar.userInteractionEnabled && CSFeedbackRequested() && CSFeedbackVisible(s);
}
static NSInteger CSLiquidIndex(CSTabBarState *s, CGPoint point, BOOL strict) {
    if (!isfinite(point.x) || !isfinite(point.y) || s.swipeCount!=4) return NSNotFound;
    if (strict) {
        for (NSInteger i=0;i<4;i++) {
            if (!CSNativeControlAvailable(s,(NSUInteger)i)) continue;
            CGRect slot=s.trackingControls[i].frame;
            if (CGRectContainsPoint(CGRectInset(slot,-4,-4),point)) return i;
        }
        return NSNotFound;
    }
    // Frames can be RTL; hit-testing physical slots also preserves native indices.
    CGFloat x=MAX(CGRectGetMinX(s.floatingRect),MIN(CGRectGetMaxX(s.floatingRect)-.1,point.x));
    for (NSInteger i=0;i<4;i++) {
        CGRect slot=s.trackingControls[i].frame;
        if (x>=CGRectGetMinX(slot) && x<CGRectGetMaxX(slot)) return i;
    }
    return NSNotFound;
}
static void CSLiquidSelect(CSTabBarState *s, NSInteger index) {
    if (index==NSNotFound || index<0 || index>=s.swipeCount || s.selecting ||
        s.gestureSelectedIndex==index || !CSNativeControlAvailable(s,(NSUInteger)index)) return;
    NSUInteger before=s.controller.selectedIndex;
    s.gestureSelectedIndex=index;
    if (before==(NSUInteger)index) return;
    s.selecting=YES;
    @try {
        SEL select=NSSelectorFromString(@"handleUserSelectionAtIndex:");
        if ([s.controller respondsToSelector:select]) {
            ((void (*)(id,SEL,NSUInteger))[s.controller methodForSelector:select])(s.controller,select,(NSUInteger)index);
        } else {
            UIControl *button=CSNativeButton(s.bar,s.controller,(NSUInteger)index);
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        if (s.controller.selectedIndex!=before && s.controller.selectedIndex==(NSUInteger)index) {
            [s.hapticGenerator impactOccurred]; CSPrepareHaptic(s.hapticGenerator);
        }
    } @finally { s.selecting=NO; }
}
static void CSLiquidUpdate(CSTabBarState *s, CGPoint point, BOOL animated) {
    NSInteger index=CSLiquidIndex(s,point,NO);
    if (index==NSNotFound) return;
    s.touchPoint=point; s.liquidHoverIndex=index;
    if (s.capsule) {
        CGRect content=s.capsuleHost.bounds, rest=s->swipeFrames[index];
        CGFloat touchX=point.x-CGRectGetMinX(s.floatingRect);
        CGFloat slotWidth=CGRectGetWidth(s.floatingRect)/4;
        CGFloat q=1-MIN(1,fabs(touchX-CGRectGetMidX(rest))/MAX(1,slotWidth*.48));
        BOOL underline=CSTabBarPreferences.current.clickEffect==CSTabBarClickEffectUnderline;
        CGFloat width=MIN(CGRectGetWidth(content)-4,rest.size.width*(underline?1.12:1.02+.06*q));
        CGFloat height=underline ? rest.size.height : MIN(CGRectGetHeight(content)-4,rest.size.height*(1.01+.03*q));
        CGFloat x=MAX(CGRectGetMinX(content)+2+width/2,MIN(CGRectGetMaxX(content)-2-width/2,touchX));
        CGRect frame=CGRectIntegral(CGRectMake(x-width/2,CGRectGetMidY(rest)-height/2,width,height));
        void (^changes)(void)=^{ CSLiquidWrite(s,frame,1); };
        if (!animated) {
            changes();
        } else if (CSLiquidCanAnimate(s)) {
            [UIView animateWithDuration:.12 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:changes completion:nil];
        } else {
            [s.capsule.layer removeAllAnimations];
            [UIView performWithoutAnimation:changes];
        }
    }
    // Preview only while tracking. Commit the final hit once on TouchUp so a
    // drag across several slots never activates the intermediate pages.
}
void CSTabBarTouchBegin(MMTabBar *bar, CGPoint pointInBar) {
    CSTabBarState *s=CSState(bar,NO);
    if (!CSLiquidCanTrack(s) || !isfinite(pointInBar.x) || !isfinite(pointInBar.y)) return;
    NSInteger origin=CSLiquidIndex(s,pointInBar,YES);
    if (origin==NSNotFound) return;
    s.touchActive=YES; s.touchDragged=NO; s.swipeGeneration++;
    s.touchStartIndex=(NSInteger)s.controller.selectedIndex; s.touchOriginIndex=origin;
    s.gestureSelectedIndex=s.touchStartIndex;
    CSReconcileHaptic(s); CSPrepareHaptic(s.hapticGenerator);
    CSLiquidUpdate(s,pointInBar,YES);
}
void CSTabBarTouchMove(MMTabBar *bar, CGPoint pointInBar) {
    CSTabBarState *s=CSState(bar,NO);
    if (!s.touchActive) return;
    if (!CSLiquidCanTrack(s)) { CSResetSwipe(s); CSLiquidSettle(s,NO); return; }
    s.touchDragged=YES;
    CSLiquidUpdate(s,pointInBar,NO);
}
static BOOL CSLiquidHandleFirstTabTap(CSTabBarState *s) {
    id target=s.controller;
    SEL action=NSSelectorFromString(@"OnMainFrameDoubleClicked:");
    BOOL takesArgument=YES;
    if (![target respondsToSelector:action]) {
        SEL frameSelector=NSSelectorFromString(@"getNewMainFrameViewController");
        target=[s.controller respondsToSelector:frameSelector] ?
            ((id (*)(id,SEL))[s.controller methodForSelector:frameSelector])(s.controller,frameSelector) : nil;
        action=NSSelectorFromString(@"onNextUnreadChat"); takesArgument=NO;
        if (![target respondsToSelector:action]) return NO;
    }
    CFTimeInterval now=CACurrentMediaTime(), previous=s.lastFirstTabTapTime;
    s.lastFirstTabTapTime=now;
    if (previous>0 && now>=previous && now-previous<=.36) {
        s.lastFirstTabTapTime=0;
        if (takesArgument) ((void (*)(id,SEL,id))[target methodForSelector:action])(target,action,nil);
        else ((void (*)(id,SEL))[target methodForSelector:action])(target,action);
    }
    return YES;
}
void CSTabBarTouchEnd(MMTabBar *bar, CGPoint pointInBar) {
    CSTabBarState *s=CSState(bar,NO);
    if (!s.touchActive) return;
    NSInteger index=CSLiquidCanTrack(s) ? CSLiquidIndex(s,pointInBar,YES) : NSNotFound;
    BOOL repeat=index!=NSNotFound && !s.touchDragged && index==s.touchOriginIndex &&
        index==s.touchStartIndex && s.controller.selectedIndex==(NSUInteger)index;
    if (!CSTabBarPreferences.current.swipeSwitch && index!=NSNotFound) {
        // Neo's ordinary tap path cancels the press tween before selecting.
        [s.capsule.layer removeAllAnimations];
        s.touchActive=NO;
    }
    CSLiquidSelect(s,index);
    BOOL firstTabHandled=index==0 && CSLiquidHandleFirstTabTap(s);
    if (repeat && !firstTabHandled && CSNativeControlAvailable(s,(NSUInteger)index)) {
        // Preserve WeChat's current-tab repeat/double-tap entry exactly once on
        // a real tap. Drag previews and taps that select a new tab do not replay it.
        s.selecting=YES;
        @try {
            UIControl *native=(UIControl *)s.buttons[index].button;
            [native sendActionsForControlEvents:UIControlEventTouchUpInside];
        } @finally { s.selecting=NO; }
    }
    CSLiquidSettle(s,YES);
    s.touchActive=NO; s.swipeGeneration++;
}
void CSTabBarTouchCancel(MMTabBar *bar) {
    CSTabBarState *s=CSState(bar,NO);
    if (!s.touchActive) return;
    s.touchActive=NO; s.swipeGeneration++;
    CSLiquidSettle(s,YES);
}
BOOL CSTabBarContainsPoint(MMTabBar *bar, CGPoint point, BOOL *handled) {
    CSTabBarState *s=CSState(bar,NO);
    *handled=s.applied && CSTabBarPreferences.current.enabled;
    if (!*handled || bar.hidden || bar.alpha<.01 || !bar.userInteractionEnabled) return NO;
    CGFloat radius=CSTabBarPreferences.current.borderStyle==0 ? s.floatingRect.size.height/2 : MIN(CSTabBarPreferences.current.cornerRadius,s.floatingRect.size.height/2);
    return [[UIBezierPath bezierPathWithRoundedRect:s.floatingRect cornerRadius:radius] containsPoint:point];
}
UIView *CSTabBarHitTest(MMTabBar *bar, CGPoint point, UIEvent *event, BOOL *handled) {
    CSTabBarState *s=CSState(bar,NO);
    if (!CSTabBarContainsPoint(bar,point,handled)) return nil;
    for (UIControl *control in s.trackingControls.reverseObjectEnumerator) {
        NSUInteger index=[s.trackingControls indexOfObjectIdenticalTo:control];
        BOOL available=CSNativeControlAvailable(s,index);
        control.hidden=!available; control.userInteractionEnabled=available;
        if (!available) continue;
        UIView *hit=[control hitTest:[bar convertPoint:point toView:control] withEvent:event];
        if (hit) return hit;
    }
    for (CSTabBarButtonState *b in s.buttons.reverseObjectEnumerator) {
        UIView *hit=[b.button hitTest:[bar convertPoint:point toView:b.button] withEvent:event];
        if (hit) return hit;
    }
    return bar;
}
@implementation CSTabBarState @end

static atomic_bool CSPreferencesPending;
static void CSRefreshPreferences(void) {
    CSRequestMainRefresh(&CSPreferencesPending, ^{
        [CSTabBarPreferences reload];
        for (MMTabBar *bar in CSBars.allObjects) {
            CSTabBarState *s=CSState(bar,NO); CSStop(s);
            [bar setNeedsLayout];
            [bar layoutIfNeeded];
            CSTabBarUpdate(bar);
        }
    });
}
static void CSDarwinPreferencesChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    CSRefreshPreferences();
}
static void CSResumeVisibleAnimations(void) {
    [CATransaction begin]; [CATransaction setDisableActions:YES];
    for (MMTabBar *bar in CSBars.allObjects) {
        CSTabBarState *s=CSState(bar,NO);
        CSReconcileClickEffect(s);
        CSReconcileCapsule(s,NO);
        if (s.applied && s.geometryApplied) CSEnsureBorderAnimation(s);
    }
    [CATransaction commit];
}
void CSTabBarInstallObservers(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [CSTabBarPreferences reload];
        CSAnimationInactive=UIApplication.sharedApplication.applicationState!=UIApplicationStateActive;
        CSInactiveAnimationScenes=[NSHashTable weakObjectsHashTable];
        NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
        for (NSString *name in @[CSTabBarPreferencesDidChange,UIAccessibilityReduceMotionStatusDidChangeNotification]) {
            [center addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification *note) { CSRefreshPreferences(); }];
        }
        for (NSString *name in @[UIApplicationDidBecomeActiveNotification, UIApplicationWillResignActiveNotification,
            UISceneDidActivateNotification, UISceneWillDeactivateNotification, NSProcessInfoThermalStateDidChangeNotification]) {
            [center addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification *note) {
                void (^update)(void)=^{
                    if ([note.name isEqual:UIApplicationWillResignActiveNotification]) CSAnimationInactive=YES;
                    if ([note.name isEqual:UIApplicationDidBecomeActiveNotification]) CSAnimationInactive=NO;
                    if (note.object && [note.name isEqual:UISceneWillDeactivateNotification]) [CSInactiveAnimationScenes addObject:note.object];
                    if (note.object && [note.name isEqual:UISceneDidActivateNotification]) [CSInactiveAnimationScenes removeObject:note.object];
                    CSResumeVisibleAnimations();
                };
                if (NSThread.isMainThread) update(); else dispatch_async(dispatch_get_main_queue(),update);
            }];
        }
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,CSDarwinPreferencesChanged,CFSTR("com.wechat.enhance.tabbar_style.changed"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
    });
}
