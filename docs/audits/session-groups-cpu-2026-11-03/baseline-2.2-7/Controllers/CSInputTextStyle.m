#import "CSInputTextStyle.h"
#import "CSPreferenceRefresh.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <math.h>

@protocol CSInputPlaceholder <NSObject>
@property(nonatomic, copy) NSString *placeHolder;
@property(nonatomic, copy) NSAttributedString *attributePlaceholder;
- (id)textView;
- (void)setPlaceHolderColor:(UIColor *)color;
- (void)setPlaceHolderMultiLine:(BOOL)multiline;
@end
@protocol CSInnerPlaceholder <NSObject>
- (UIColor *)placeHolderColor;
- (BOOL)placeholderMultiLine;
@end

@interface CSInputStyleSnapshot : NSObject
@property(nonatomic) BOOL enabled, rounded, bordered;
@property(nonatomic) CGFloat radius, borderWidth;
@property(nonatomic, strong) UIColor *textColor, *borderColor;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSAttributedString *attributed;
@end
@implementation CSInputStyleSnapshot @end

@interface CSInputStyleState : NSObject
@property(nonatomic) BOOL applying, placeholderOwned, cornerOwned, borderOwned;
@property(nonatomic) NSUInteger nativeDepth;
@property(nonatomic, copy) NSString *nativeText;
@property(nonatomic, copy) NSAttributedString *nativeAttributed;
@property(nonatomic, strong) UIColor *nativeColor, *renderedColor;
@property(nonatomic, weak) id nativeInner;
@property(nonatomic) BOOL hasNativeColor, hasNativeMultiline, nativeMultiline, multilineApplied;
@property(nonatomic) UIUserInterfaceStyle renderedTrait;
@property(nonatomic) CGFloat nativeRadius, renderedRadius, nativeWidth, renderedWidth;
@property(nonatomic) BOOL nativeClips, renderedClips;
@property(nonatomic, strong) UIColor *nativeBorder, *renderedBorder;
@property(nonatomic, strong) UIColor *borderSource;
@property(nonatomic, strong) UITraitCollection *borderTraits;
@end
@implementation CSInputStyleState @end

static char CSInputStyleStateKey, CSInputChatVisibleKey;
static NSUserDefaults *CSInputDefaults;
static NSDictionary *CSInputRaw;
static CSInputStyleSnapshot *CSInputStyle;
static NSHashTable<UIView *> *CSInputViews;
static atomic_bool CSInputRefreshPending;

static BOOL CSEqual(id a, id b) { return a == b || [a isEqual:b]; }
static BOOL CSColorsEqual(CGColorRef a, CGColorRef b) { return a == b || (a && b && CGColorEqualToColor(a, b)); }
static BOOL CSInputBool(id value) { return [value respondsToSelector:@selector(boolValue)] && [value boolValue]; }
static double CSInputNumber(id value, double fallback) {
    double number = [value respondsToSelector:@selector(doubleValue)] ? [value doubleValue] : fallback;
    return isfinite(number) ? number : fallback;
}
static UIColor *CSInputDecodeColor(id data, UIColor *fallback) {
    if (![data isKindOfClass:NSData.class]) return fallback;
    @try {
        UIColor *color = [NSKeyedUnarchiver unarchivedObjectOfClass:UIColor.class fromData:data error:NULL];
        return color ?: fallback;
    } @catch (__unused NSException *exception) { return fallback; }
}
static BOOL CSInputLoadPreferences(void) {
    NSMutableDictionary *raw = [NSMutableDictionary dictionary];
    for (NSString *suffix in @[@"enabled", @"content", @"color", @"alpha", @"fontSize", @"bold",
                              @"roundedCorners", @"cornerRadius", @"border.enabled", @"border.width", @"border.color"]) {
        id value = [CSInputDefaults objectForKey:[@"com.wechat.enhance.inputText." stringByAppendingString:suffix]];
        if (value) raw[suffix] = value;
    }
    if (CSEqual(raw, CSInputRaw)) return NO;
    CSInputRaw = [raw copy];
    CSInputStyleSnapshot *p = [CSInputStyleSnapshot new];
    p.enabled = CSInputBool(raw[@"enabled"]);
    p.rounded = CSInputBool(raw[@"roundedCorners"]);
    p.bordered = CSInputBool(raw[@"border.enabled"]);
    p.radius = CSInputNumber(raw[@"cornerRadius"], 18);
    if (p.radius <= 0) p.radius = 18;
    p.borderWidth = CSInputNumber(raw[@"border.width"], 1);
    if (p.borderWidth <= 0) p.borderWidth = 1;
    if (p.bordered) p.borderColor = CSInputDecodeColor(raw[@"border.color"], UIColor.systemGrayColor);
    if (p.enabled) {
        p.text = [raw[@"content"] isKindOfClass:NSString.class] && [raw[@"content"] length] ? raw[@"content"] : @"我爱你呀";
        CGFloat alpha = MIN(1, MAX(0, CSInputNumber(raw[@"alpha"], .5)));
        p.textColor = [CSInputDecodeColor(raw[@"color"], [UIColor colorWithWhite:.5 alpha:1]) colorWithAlphaComponent:alpha];
        CGFloat size = CSInputNumber(raw[@"fontSize"], 15);
        if (size <= 0) size = 15;
        UIFont *font = CSInputBool(raw[@"bold"]) ? [UIFont boldSystemFontOfSize:size] : [UIFont systemFontOfSize:size];
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.alignment = NSTextAlignmentLeft;
        p.attributed = [[NSAttributedString alloc] initWithString:p.text attributes:@{
            NSFontAttributeName:font, NSForegroundColorAttributeName:p.textColor, NSParagraphStyleAttributeName:paragraph}];
    }
    CSInputStyle = p;
    return YES;
}

static UIViewController *CSInputChatOwner(UIView *view) {
    Class chat = NSClassFromString(@"BaseMsgContentViewController");
    if (!chat) return nil;
    for (UIResponder *responder = view.nextResponder; responder; responder = responder.nextResponder) {
        if ([responder isKindOfClass:chat]) return (UIViewController *)responder;
        // A separate presented/embedded controller owns its own input fields.
        if ([responder isKindOfClass:UIViewController.class]) return nil;
    }
    return nil;
}

static void CSInputCaptureInner(UIView<CSInputPlaceholder> *view, CSInputStyleState *s) {
    id<CSInnerPlaceholder> inner = [view respondsToSelector:@selector(textView)] ? [view textView] : nil;
    s.nativeInner = inner;
    s.hasNativeColor = [inner respondsToSelector:@selector(placeHolderColor)];
    s.hasNativeMultiline = [inner respondsToSelector:@selector(placeholderMultiLine)];
    if (s.hasNativeColor) s.nativeColor = [inner placeHolderColor];
    if (s.hasNativeMultiline) s.nativeMultiline = [inner placeholderMultiLine];
    s.renderedColor = nil;
    s.multilineApplied = NO;
}
static void CSInputCapturePlaceholder(UIView<CSInputPlaceholder> *view, CSInputStyleState *s) {
    s.nativeText = view.placeHolder;
    s.nativeAttributed = view.attributePlaceholder;
    CSInputCaptureInner(view, s);
    s.placeholderOwned = YES;
}

void CSInputTextStyleApply(UIView *candidate) {
    if (!candidate || !NSThread.isMainThread) return;
    UIView<CSInputPlaceholder> *view = (id)candidate;
    CSInputStyleState *s = objc_getAssociatedObject(view, &CSInputStyleStateKey);
    if (s.applying || s.nativeDepth) return;
    CSInputStyleSnapshot *p = CSInputStyle;
    if (s && !p.enabled && !p.rounded && !p.bordered &&
        !s.placeholderOwned && !s.cornerOwned && !s.borderOwned) return;
    UIViewController *owner = CSInputChatOwner(view);
    if (!s && !owner) return;
    if (!s) {
        s = [CSInputStyleState new];
        objc_setAssociatedObject(view, &CSInputStyleStateKey, s, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (!CSInputViews) CSInputViews = [NSHashTable weakObjectsHashTable];
        [CSInputViews addObject:view];
    }
    BOOL active = owner && [objc_getAssociatedObject(owner, &CSInputChatVisibleKey) boolValue];
    s.applying = YES;
    @try {
        // WeChat can rebuild the inner text view when switching input modes.
        if (s.placeholderOwned && [view respondsToSelector:@selector(textView)] && [view textView] != s.nativeInner)
            CSInputCaptureInner(view, s);
        if (active && p.enabled) {
            if (!s.placeholderOwned) CSInputCapturePlaceholder(view, s);
            UIUserInterfaceStyle trait = view.traitCollection.userInterfaceStyle;
            if (!CSEqual(s.renderedColor, p.textColor) || s.renderedTrait != trait) {
                // Only override auxiliary native properties when they can be restored.
                if (s.hasNativeColor) [view setPlaceHolderColor:p.textColor];
                s.renderedColor = p.textColor;
                s.renderedTrait = trait;
            }
            if (!s.multilineApplied) {
                if (s.hasNativeMultiline) [view setPlaceHolderMultiLine:YES];
                s.multilineApplied = YES;
            }
            if (!CSEqual(view.placeHolder, p.text)) view.placeHolder = p.text;
            if (!CSEqual(view.attributePlaceholder, p.attributed)) view.attributePlaceholder = p.attributed;
        } else if (s.placeholderOwned) {
            if (s.hasNativeColor) [view setPlaceHolderColor:s.nativeColor];
            if (s.hasNativeMultiline) [view setPlaceHolderMultiLine:s.nativeMultiline];
            view.placeHolder = s.nativeText;
            view.attributePlaceholder = s.nativeAttributed;
            s.placeholderOwned = NO;
            s.renderedColor = nil;
            s.nativeAttributed = nil;
            s.nativeText = nil;
            s.nativeColor = nil;
        }

        // Native layout/theme changes can replace layer values. Preserve its latest values
        // instead of restoring an obsolete snapshot when this feature is disabled.
        if (s.cornerOwned) {
            if (view.layer.cornerRadius != s.renderedRadius) s.nativeRadius = view.layer.cornerRadius;
            if (view.clipsToBounds != s.renderedClips) s.nativeClips = view.clipsToBounds;
        }
        if (active && p.rounded) {
            if (!s.cornerOwned) { s.nativeRadius = view.layer.cornerRadius; s.nativeClips = view.clipsToBounds; }
            s.cornerOwned = YES;
            if (view.layer.cornerRadius != p.radius) view.layer.cornerRadius = p.radius;
            if (!view.clipsToBounds) view.clipsToBounds = YES;
            s.renderedRadius = p.radius; s.renderedClips = YES;
        } else if (s.cornerOwned) {
            view.layer.cornerRadius = s.nativeRadius; view.clipsToBounds = s.nativeClips;
            s.cornerOwned = NO;
        }
        if (s.borderOwned) {
            if (view.layer.borderWidth != s.renderedWidth) s.nativeWidth = view.layer.borderWidth;
            if (!CSColorsEqual(view.layer.borderColor, s.renderedBorder.CGColor))
                s.nativeBorder = view.layer.borderColor ? [UIColor colorWithCGColor:view.layer.borderColor] : nil;
        }
        if (active && p.bordered) {
            if (!s.borderOwned) {
                s.nativeWidth = view.layer.borderWidth;
                s.nativeBorder = view.layer.borderColor ? [UIColor colorWithCGColor:view.layer.borderColor] : nil;
            }
            s.borderOwned = YES;
            if (s.borderSource != p.borderColor || !s.borderTraits ||
                [view.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:s.borderTraits]) {
                s.renderedBorder = [p.borderColor resolvedColorWithTraitCollection:view.traitCollection];
                s.borderSource = p.borderColor;
                s.borderTraits = view.traitCollection;
            }
            UIColor *color = s.renderedBorder;
            if (view.layer.borderWidth != p.borderWidth) view.layer.borderWidth = p.borderWidth;
            if (!CSColorsEqual(view.layer.borderColor, color.CGColor)) view.layer.borderColor = color.CGColor;
            s.renderedWidth = p.borderWidth;
        } else if (s.borderOwned) {
            view.layer.borderWidth = s.nativeWidth; view.layer.borderColor = s.nativeBorder.CGColor;
            s.borderOwned = NO; s.nativeBorder = nil; s.renderedBorder = nil;
            s.borderSource = nil; s.borderTraits = nil;
        }
    } @finally { s.applying = NO; }
}

void CSInputTextStyleNativeBegin(UIView *view, CSInputTextNativeField field, id value) {
    if (!NSThread.isMainThread) return;
    CSInputStyleState *s = objc_getAssociatedObject(view, &CSInputStyleStateKey);
    if (!s || s.applying) return;
    s.nativeDepth++;
    if (!s.placeholderOwned) return;
    switch (field) {
        case CSInputTextNativePlain: s.nativeText = value; break;
        case CSInputTextNativeAttributed: s.nativeAttributed = value; break;
        case CSInputTextNativeColor: s.nativeColor = value; s.hasNativeColor = YES; s.renderedColor = nil; break;
        case CSInputTextNativeMultiline: s.nativeMultiline = [value boolValue]; s.hasNativeMultiline = YES; s.multilineApplied = NO; break;
    }
}
void CSInputTextStyleNativeEnd(UIView *view) {
    if (!NSThread.isMainThread) return;
    CSInputStyleState *s = objc_getAssociatedObject(view, &CSInputStyleStateKey);
    if (!s || s.applying || !s.nativeDepth) return;
    if (--s.nativeDepth == 0) CSInputTextStyleApply(view);
}
void CSInputTextStyleChatVisibility(UIViewController *controller, BOOL visible) {
    if (!controller || !NSThread.isMainThread) return;
    objc_setAssociatedObject(controller, &CSInputChatVisibleKey, @(visible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIView *view in CSInputViews.allObjects) CSInputTextStyleApply(view);
}
void CSInputTextStylePreferencesChanged(void) {
    CSRequestMainRefresh(&CSInputRefreshPending, ^{
        if (CSInputLoadPreferences()) for (UIView *view in CSInputViews.allObjects) CSInputTextStyleApply(view);
    });
}
static void CSInputDarwinChanged(CFNotificationCenterRef center, void *observer, CFStringRef name,
                                 const void *object, CFDictionaryRef info) {
    CSInputTextStylePreferencesChanged();
}
void CSInputTextStyleInstall(NSUserDefaults *defaults) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSInputDefaults = defaults;
        CSInputLoadPreferences();
        for (NSString *name in @[NSUserDefaultsDidChangeNotification, @"com.wechat.tweak.local_settings_changed",
                                UIApplicationDidBecomeActiveNotification]) {
            [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification *note) {
                CSInputTextStylePreferencesChanged();
            }];
        }
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, CSInputDarwinChanged,
            CFSTR("com.wechat.enhance.settings_changed"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    });
}
