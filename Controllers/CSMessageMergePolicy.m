#import "CSMessageMergePolicy.h"
#include <math.h>
#include <limits.h>

NSString *const CSMessageMergeEnabledKey = @"com.wechat.enhance.merge_messages.enabled";
NSString *const CSMessageMergeScopeKey = @"com.wechat.enhance.merge_messages.scope";
NSString *const CSMessageMergeAvatarKey = @"com.wechat.enhance.merge_messages.avatar_position";
NSString *const CSMessageMergeSpacingKey = @"com.wechat.enhance.consecutive_messages.spacing";
NSString *const CSMessageMergeSpacingModeKey = @"com.wechat.enhance.merge_messages.spacing_mode";
NSString *const CSMessageMergeSettingsNotification = @"com.wechat.enhance.bubble_style.settings_changed";

@implementation CSMessageMergeConfiguration
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults {
    if ((self = [super init])) {
        _enabled = [defaults boolForKey:CSMessageMergeEnabledKey];
        NSInteger scope = [defaults integerForKey:CSMessageMergeScopeKey];
        _scope = scope >= 1 && scope <= 3 ? scope : 3;
        _avatarPosition = [defaults integerForKey:CSMessageMergeAvatarKey] == 2 ? 2 : 1;
        id mode = [defaults objectForKey:CSMessageMergeSpacingModeKey];
        if (mode) {
            NSInteger value = [mode respondsToSelector:@selector(integerValue)] ? [mode integerValue] : 0;
            _spacingMode = value == CSMessageSpacingCompact ? CSMessageSpacingCompact : CSMessageSpacingNormal; // Retired relaxed mode -> normal.
        } else {
            // Read-through migration: retain the original value for rollback; a new selection
            // writes only the mode. Absent legacy settings default to native spacing.
            double legacy = [defaults doubleForKey:CSMessageMergeSpacingKey];
            _spacingMode = isfinite(legacy) && legacy < 0 ? CSMessageSpacingCompact : CSMessageSpacingNormal;
        }
        _spacing = _spacingMode == CSMessageSpacingCompact ? -25 : 0;
        BOOL time = [defaults boolForKey:@"com.wechat.enhance.messageTime.enabled"];
        _reservesAvatarTime = time && [defaults boolForKey:@"com.wechat.enhance.messageTime.showBelowAvatar"];
        _hasLargeTimeLabel = time && [defaults doubleForKey:@"com.wechat.enhance.messageTime.fontSize"] > 12;

    }
    return self;
}
- (BOOL)appliesToGroup:(BOOL)group {
    return self.enabled && (self.scope == 3 || self.scope == (group ? 1 : 2));
}
@end

NSString *CSMessageSpacingModeTitle(CSMessageSpacingMode mode) {
    return mode == CSMessageSpacingCompact ? @"紧密" : @"正常";
}
CSMessageMergeLayoutPlan CSMessageMergePlanLayout(CSMessageSpacingMode mode,
    double nativeHeight, double top, double bottom, BOOL before, BOOL after) {
    CSMessageMergeLayoutPlan plan={nativeHeight,0,NO};
    if (mode!=CSMessageSpacingCompact || (!before && !after) || !isfinite(nativeHeight) || nativeHeight<=0 ||
        !isfinite(top) || !isfinite(bottom) || top<0 || bottom<=top || bottom>nativeHeight) return plan;
    // One logical point on each side of an internal seam (2pt total).
    // Keep fractional native coordinates; spacing never depends on display scale.
    // Never add padding to a native edge which is already tighter.
    double edge=1;
    double leading=before ? fmin(top,edge) : top;
    double trailing=after ? fmin(nativeHeight-bottom,edge) : nativeHeight-bottom;
    plan.originDelta=leading-top;
    plan.height=bottom+plan.originDelta+trailing;
    plan.height=fmin(nativeHeight,plan.height);
    plan.valid=YES;
    return plan;
}

@implementation CSMessageMergeItem
- (instancetype)init { if ((self = [super init])) { _account = @""; _session = @""; _sender = @""; _identity = @""; } return self; }
@end

BOOL CSMessageMergeCanJoin(CSMessageMergeItem *a, CSMessageMergeItem *b) {
    return a && b && a.eligible && b.eligible && a.account.length && a.session.length && a.sender.length &&
        a.identity.length && b.identity.length && ![a.identity isEqual:b.identity] &&
        [a.account isEqual:b.account] && [a.session isEqual:b.session] && [a.sender isEqual:b.sender] && a.outgoing == b.outgoing;
}
CSMessageMergeDecision CSMessageMergeDecide(CSMessageMergeItem *previous, CSMessageMergeItem *current,
                                           CSMessageMergeItem *next, NSInteger avatarPosition) {
    BOOL before = CSMessageMergeCanJoin(previous, current), after = CSMessageMergeCanJoin(current, next);
    return (CSMessageMergeDecision){before, after, avatarPosition == 2 ? before : after};
}
double CSMessageMergeSafeDelta(double requested, double nativeHeight, double verifiedSlack) {
    if (!isfinite(requested) || !isfinite(nativeHeight) || nativeHeight <= 0) return 0;
    if (!isfinite(verifiedSlack) || verifiedSlack < 0) verifiedSlack = 0;
    verifiedSlack = fmin(verifiedSlack, fmax(0, nativeHeight - 1));
    return fmax(-verifiedSlack, fmax(-20, fmin(10, requested)));
}
long long CSMessageRevokeLinkID(NSString *link) {
    NSString *prefix = @"revoke_jump_";
    if (![link isKindOfClass:NSString.class] || ![link hasPrefix:prefix] || link.length == prefix.length) return 0;
    unsigned long long value = 0;
    for (NSUInteger i = prefix.length; i < link.length; i++) {
        unichar c = [link characterAtIndex:i];
        if (c < '0' || c > '9' || value > ((unsigned long long)LLONG_MAX - (c - '0')) / 10) return 0;
        value = value * 10 + c - '0';
    }
    return (long long)value;
}
double CSMessageNavigationMargin(double visibleHeight, double messageHeight) {
    if (!isfinite(visibleHeight) || visibleHeight <= 0) return 0;
    if (!isfinite(messageHeight) || messageHeight <= 0 || messageHeight >= visibleHeight) return 0;
    return (visibleHeight - messageHeight) * 0.5;
}
double CSMessageNavigationOffset(double rowY, double rowHeight, double viewportHeight,
                                double contentHeight, double topInset, double bottomInset) {
    if (!isfinite(rowY) || !isfinite(rowHeight) || !isfinite(viewportHeight) || !isfinite(contentHeight) ||
        !isfinite(topInset) || !isfinite(bottomInset)) return 0;
    double visible = fmax(0, viewportHeight - topInset - bottomInset);
    double target = rowY - topInset - CSMessageNavigationMargin(visible, rowHeight);
    return fmax(-topInset, fmin(fmax(-topInset, contentHeight - viewportHeight + bottomInset), target));
}
