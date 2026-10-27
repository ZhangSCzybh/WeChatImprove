#import "CSCloseFriendSessionPresentation.h"
#import "CSGroupProjection.h"
#import "CSCloseFriendBridge.h"
#import <objc/runtime.h>
#import <math.h>

@interface CSCloseFriendSessionCover : UIView
@property(nonatomic,strong) CSGroupRow *row;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *summaryLabel;
@property(nonatomic,strong) NSMapTable<UIView *,NSNumber *> *hiddenStates;
@property(nonatomic,strong) id originalAccessibilityElements;
@property(nonatomic,copy) NSString *originalAccessibilityLabel;
@property(nonatomic) BOOL originalAccessibilityElement;
@end
@implementation CSCloseFriendSessionCover @end
static char CoverKey;
static UIView *CSFoldedViewIvar(id object, const char *name, UIView *container) {
    Ivar ivar=class_getInstanceVariable([object class],name);
    const char *type=ivar ? ivar_getTypeEncoding(ivar) : NULL;
    id value=type && type[0]=='@' ? object_getIvar(object,ivar) : nil;
    return [value isKindOfClass:UIView.class] && value!=container && [value isDescendantOfView:container] ? value : nil;
}
static void CSFoldedRestoreHiddenViews(CSCloseFriendSessionCover *cover) {
    for (UIView *child in cover.hiddenStates) child.hidden=[[cover.hiddenStates objectForKey:child] boolValue];
    [cover.hiddenStates removeAllObjects];
}
static void CSFoldedHideView(CSCloseFriendSessionCover *cover, UIView *child) {
    if (!child) return;
    if (![cover.hiddenStates objectForKey:child]) [cover.hiddenStates setObject:@(child.hidden) forKey:child];
    child.hidden=YES;
}
static void CSFoldedConcealItem(CSCloseFriendSessionCover *cover, UIView *container, UIView *icon) {
    for (UIView *child in container.subviews) {
        if (child==cover || child==icon) continue;
        if ([icon isDescendantOfView:child]) CSFoldedConcealItem(cover,child,icon);
        else CSFoldedHideView(cover,child);
    }
}
static BOOL CSFoldedValidFrame(CGRect frame) {
    return isfinite(frame.origin.x) && isfinite(frame.origin.y) && isfinite(frame.size.width) && isfinite(frame.size.height) && frame.size.width>0 && frame.size.height>0;
}
static void CSFoldedLayoutLabel(UILabel *label, UIView *nativeLabel, UIView *container, CGRect fallback, BOOL summary) {
    CGRect frame=nativeLabel ? [nativeLabel convertRect:nativeLabel.bounds toView:container] : CGRectZero;
    label.frame=CSFoldedValidFrame(frame) ? frame : fallback;
    UILabel *native=[nativeLabel isKindOfClass:UILabel.class] ? (UILabel *)nativeLabel : nil;
    label.font=native.font ?: [UIFont preferredFontForTextStyle:summary ? UIFontTextStyleSubheadline : UIFontTextStyleBody];
    label.textColor=native.textColor ?: (summary ? UIColor.secondaryLabelColor : UIColor.labelColor);
}
void CSCloseFriendUpdateSessionCover(UITableViewCell *cell, CSGroupRow *row) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL privacyCover=row.privacyMasked && row.kind==CSGroupRowKindAggregate && [row.userName isEqual:@"chatroom_session_box"] && (policy.blocked ||
        (policy.enabled && !policy.revealed && [policy.options[@"hideSessions"] boolValue] && policy.protectedUserNames.count));
    BOOL cover=privacyCover || row.foldedEntryScoped;
    CSCloseFriendSessionCover *view=objc_getAssociatedObject(cell,&CoverKey);
    if (!cover) {
        if (!view) return;
        CSFoldedRestoreHiddenViews(view);
        cell.isAccessibilityElement=view.originalAccessibilityElement;
        cell.accessibilityElements=view.originalAccessibilityElements;
        cell.accessibilityLabel=view.originalAccessibilityLabel;
        [view removeFromSuperview]; objc_setAssociatedObject(cell,&CoverKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if (!view) {
        view=[[CSCloseFriendSessionCover alloc] initWithFrame:cell.bounds];
        view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.userInteractionEnabled=NO;
        view.hiddenStates=[NSMapTable weakToStrongObjectsMapTable];
        view.originalAccessibilityElement=cell.isAccessibilityElement;
        view.originalAccessibilityElements=cell.accessibilityElements;
        view.originalAccessibilityLabel=cell.accessibilityLabel;
        view.titleLabel=[[UILabel alloc] initWithFrame:CGRectZero];[view addSubview:view.titleLabel];
        view.summaryLabel=[[UILabel alloc] initWithFrame:CGRectZero];[view addSubview:view.summaryLabel];
        view.isAccessibilityElement=YES;
        objc_setAssociatedObject(cell,&CoverKey,view,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    view.row=row;
    // A policy transition may precede the next projection. Conceal its stale
    // count immediately; never reuse a previous account's summary.
    BOOL currentCount=!policy.blocked && [policy.accountID isEqual:row.foldedEntryAccountID] && policy.revision==row.foldedEntryPrivacyRevision;
    NSString *title=row.foldedEntryScoped ? (currentCount && row.foldedEntryCount ?
        [NSString stringWithFormat:@"折叠的聊天（%@）",row.foldedEntryCount] : @"折叠的聊天") : @"折叠的群聊";
    view.titleLabel.text=title;view.accessibilityLabel=title;
    view.summaryLabel.text=row.foldedEntryScoped && currentCount && row.foldedEntryCount ?
        [NSString stringWithFormat:@"%@ 个会话",row.foldedEntryCount] : @"折叠的聊天";

    // The row is still a native NewMainFrameCell. Keep its icon, card, separators,
    // height and native label geometry; conceal only the global business content.
    UIView *item=CSFoldedViewIvar(cell,"m_itemView",cell);
    UIView *icon=CSFoldedViewIvar(item,"m_frameHeadView",item);
    UIView *name=CSFoldedViewIvar(item,"m_nameLabel",item);
    UIView *message=CSFoldedViewIvar(item,"m_messageLabel",item);
    BOOL nativeLayout=item && icon && name;
    UIView *container=nativeLayout ? item : cell;
    if (view.superview!=container) {
        CSFoldedRestoreHiddenViews(view);
        [view removeFromSuperview]; [container addSubview:view];
    }
    view.frame=container.bounds;
    CGFloat x=18;
    if (nativeLayout) {
        CGRect nameFrame=[name convertRect:name.bounds toView:container];
        CGRect iconFrame=[icon convertRect:icon.bounds toView:container];
        x=CSFoldedValidFrame(nameFrame) ? nameFrame.origin.x : CGRectGetMaxX(iconFrame)+12;
        view.backgroundColor=UIColor.clearColor;
        CSFoldedConcealItem(view,item,icon);
        CSFoldedHideView(view,CSFoldedViewIvar(item,"m_unreadCountView",item));
    } else {
        // Unknown native structure: retain conservative privacy protection, with
        // a neutral two-line fallback. Never guess or display the global digest.
        view.backgroundColor=UIColor.systemBackgroundColor;
        for (UIView *child in cell.subviews) if (child!=view) CSFoldedHideView(view,child);
    }
    CGFloat middle=CGRectGetMidY(view.bounds),width=MAX(1,view.bounds.size.width-x-12);
    CSFoldedLayoutLabel(view.titleLabel,nativeLayout ? name : nil,container,CGRectMake(x,MAX(0,middle-24),width,22),NO);
    CSFoldedLayoutLabel(view.summaryLabel,nativeLayout ? message : nil,container,CGRectMake(x,middle+4,width,18),YES);
    if (container.subviews.lastObject!=view) [container bringSubviewToFront:view];
    cell.isAccessibilityElement=NO; cell.accessibilityLabel=nil; cell.accessibilityElements=@[view];
}

void CSCloseFriendRefreshSessionCover(UITableViewCell *cell) {
    CSCloseFriendSessionCover *cover=objc_getAssociatedObject(cell,&CoverKey);
    if (cover) CSCloseFriendUpdateSessionCover(cell,cover.row);
}
