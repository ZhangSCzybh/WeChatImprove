#import "CSCloseFriendSessionPresentation.h"
#import "CSGroupProjection.h"
#import "CSCloseFriendBridge.h"
#import <objc/runtime.h>

@interface CSCloseFriendSessionCover : UIView
@property(nonatomic,strong) CSGroupRow *row;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) NSMapTable<UIView *,NSNumber *> *hiddenStates;
@property(nonatomic,strong) id originalAccessibilityElements;
@property(nonatomic,copy) NSString *originalAccessibilityLabel;
@property(nonatomic) BOOL originalAccessibilityElement;
@end
@implementation CSCloseFriendSessionCover @end
static char CoverKey;
void CSCloseFriendUpdateSessionCover(UITableViewCell *cell, CSGroupRow *row) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL privacyCover=row.privacyMasked && row.kind==CSGroupRowKindAggregate && [row.userName isEqual:@"chatroom_session_box"] && (policy.blocked ||
        (policy.enabled && !policy.revealed && [policy.options[@"hideSessions"] boolValue] && policy.protectedUserNames.count));
    BOOL cover=privacyCover || row.foldedEntryScoped;
    CSCloseFriendSessionCover *view=objc_getAssociatedObject(cell,&CoverKey);
    if (!cover) {
        if (!view) return;
        for (UIView *child in view.hiddenStates) child.hidden=[[view.hiddenStates objectForKey:child] boolValue];
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
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectInset(view.bounds,18,0)];
        title.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        title.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody]; title.textColor=UIColor.labelColor;
        view.titleLabel=title;[view addSubview:title]; view.isAccessibilityElement=YES;
        objc_setAssociatedObject(cell,&CoverKey,view,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    view.row=row;
    // A policy transition may precede the next projection. Conceal its stale
    // count immediately; never reuse a previous account's summary.
    BOOL currentCount=!policy.blocked && [policy.accountID isEqual:row.foldedEntryAccountID] && policy.revision==row.foldedEntryPrivacyRevision;
    NSString *title=row.foldedEntryScoped ? (currentCount && row.foldedEntryCount ?
        [NSString stringWithFormat:@"折叠的聊天（%@）",row.foldedEntryCount] : @"折叠的聊天") : @"折叠的群聊";
    view.titleLabel.text=title;view.accessibilityLabel=title;
    view.backgroundColor=cell.backgroundColor ?: UIColor.systemBackgroundColor;
    for (UIView *child in cell.subviews) if (child!=view) {
        if (![view.hiddenStates objectForKey:child]) [view.hiddenStates setObject:@(child.hidden) forKey:child];
        child.hidden=YES;
    }
    if (view.superview!=cell) [cell addSubview:view];
    if (cell.subviews.lastObject!=view) [cell bringSubviewToFront:view];
    cell.isAccessibilityElement=NO; cell.accessibilityLabel=nil; cell.accessibilityElements=@[view];
}

void CSCloseFriendRefreshSessionCover(UITableViewCell *cell) {
    CSCloseFriendSessionCover *cover=objc_getAssociatedObject(cell,&CoverKey);
    if (cover) CSCloseFriendUpdateSessionCover(cell,cover.row);
}
