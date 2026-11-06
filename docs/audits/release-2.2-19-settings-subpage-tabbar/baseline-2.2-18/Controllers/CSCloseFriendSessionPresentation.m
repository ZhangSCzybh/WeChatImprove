#import "CSCloseFriendSessionPresentation.h"
#import "CSGroupProjection.h"
#import "CSCloseFriendBridge.h"
#import "CSListCornerPageContext.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <math.h>

@interface CSCloseFriendSessionCover : UIView
@property(nonatomic,strong) CSGroupRow *row;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *summaryLabel;
@property(nonatomic,weak) UILabel *nativeMessage;
@property(nonatomic,strong) UIView *nativePrefix;
@property(nonatomic,copy) NSString *writtenMessage;
@property(nonatomic) CGRect messageBaseFrame;
@property(nonatomic,copy) NSArray *nativeRenderState;
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
static void CSFoldedKeepView(CSCloseFriendSessionCover *cover,UIView *view) {
    NSNumber *original=[cover.hiddenStates objectForKey:view];
    if (original) { view.hidden=original.boolValue;[cover.hiddenStates removeObjectForKey:view]; }
}
static void CSFoldedConcealItem(CSCloseFriendSessionCover *cover, UIView *container, UIView *icon,UIView *title) {
    for (UIView *child in container.subviews) {
        if (child==cover) continue;
        if (child==icon || child==title || child==cover.nativeMessage || child==cover.nativePrefix) { CSFoldedKeepView(cover,child);continue; }
        if ([icon isDescendantOfView:child] || [title isDescendantOfView:child] || [cover.nativeMessage isDescendantOfView:child] || [cover.nativePrefix isDescendantOfView:child]) {
            CSFoldedKeepView(cover,child);CSFoldedConcealItem(cover,child,icon,title);
        }
        else CSFoldedHideView(cover,child);
    }
}
static BOOL CSFoldedValidFrame(CGRect frame) {
    return isfinite(frame.origin.x) && isfinite(frame.origin.y) && isfinite(frame.size.width) && isfinite(frame.size.height) && frame.size.width>0 && frame.size.height>0;
}
static void CSFoldedLayoutLabel(UILabel *label, UIView *nativeLabel, UIView *container, CGRect fallback, BOOL summary) {
    CGRect frame=nativeLabel ? [nativeLabel convertRect:nativeLabel.bounds toView:container] : CGRectZero;
    if (!CSFoldedValidFrame(frame)) frame=fallback;
    // Native aggregate labels can be sized to their old text or centered digest.
    // Only borrow their vertical metrics; concealed time/badges reserve no width.
    frame.origin.x=fallback.origin.x;frame.size.width=fallback.size.width;
    label.frame=frame;
    UILabel *native=[nativeLabel isKindOfClass:UILabel.class] ? (UILabel *)nativeLabel : nil;
    label.font=native.font ?: [UIFont preferredFontForTextStyle:summary ? UIFontTextStyleSubheadline : UIFontTextStyleBody];
    label.textColor=native.textColor ?: (summary ? UIColor.secondaryLabelColor : UIColor.labelColor);
    label.numberOfLines=1;label.textAlignment=NSTextAlignmentLeft;
    label.lineBreakMode=summary ? NSLineBreakByTruncatingTail : NSLineBreakByClipping;
    label.adjustsFontSizeToFitWidth=NO;label.minimumScaleFactor=1;
}
static UIView *CSFoldedNativePrefix(UIView *item) {
    for (UIView *child in item.subviews) if (child.tag==10001001) return child;
    return nil;
}
static id CSFoldedThemeValue(id object,NSString *name,NSArray *arguments) {
    @try {
    SEL selector=NSSelectorFromString(name);
    Method method=class_getInstanceMethod(object_getClass(object),selector);
    const char *types=method ? method_getTypeEncoding(method) : NULL;
    NSMethodSignature *sig=types ? [NSMethodSignature signatureWithObjCTypes:types] : nil;
    if (!sig || sig.numberOfArguments!=arguments.count+2 || sig.methodReturnType[0]!='@') return nil;
    for (NSUInteger i=0;i<arguments.count;i++) if (!strchr("@#",[sig getArgumentTypeAtIndex:i+2][0])) return nil;
    if (!arguments.count) return ((id(*)(id,SEL))objc_msgSend)(object,selector);
    if (arguments.count==1) return ((id(*)(id,SEL,id))objc_msgSend)(object,selector,arguments[0]);
    if (arguments.count==2) return ((id(*)(id,SEL,id,id))objc_msgSend)(object,selector,arguments[0],arguments[1]);
    return nil;
    } @catch (__unused NSException *exception) { return nil; }
}
static id CSFoldedFreezeThemeValue(id value,NSUInteger depth) {
    if (!value) return nil;
    if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]) return [value copy];
    if (depth>3 || ![value isKindOfClass:NSArray.class] || [value count]>32) return nil;
    NSMutableArray *copy=[NSMutableArray arrayWithCapacity:[value count]];
    for (id child in value) { id frozen=CSFoldedFreezeThemeValue(child,depth+1);if (!frozen) return nil;[copy addObject:frozen]; }
    return [copy copy];
}
static NSArray *CSFoldedNativeRenderState(UIView *item,UILabel *message,UILabel *prefix) {
    // quoteMessageLable: reads these two native theme properties (8.0.78).
    // Copy their values: retaining a mutable theme collection cannot detect an
    // in-place change. Unknown accessors/values disable reuse; rendering still
    // delegates to the native quote method.
    id context=CSFoldedThemeValue(NSClassFromString(@"MMContext"),@"currentContext",@[]);
    Class themeClass=NSClassFromString(@"MMThemeManager");
    id manager=themeClass ? CSFoldedThemeValue(context,@"getService:",@[themeClass]) : nil;
    if (!manager) return nil;
    id margin=CSFoldedFreezeThemeValue(CSFoldedThemeValue(manager,@"getValueOfProperty:inRuleSet:",@[@"cell_headimg_left_margin",@"#mainframe_table"]),0);
    id size=CSFoldedFreezeThemeValue(CSFoldedThemeValue(manager,@"getValueOfProperty:inRuleSet:",@[@"cell_headimg_size",@"#mainframe_table"]),0);
    if (!margin || !size) return nil;
    id null=NSNull.null;
    CGRect bounds=item.bounds,itemFrame=item.frame,messageFrame=message.frame,prefixFrame=prefix.frame;
    return @[[NSValue value:&bounds withObjCType:@encode(CGRect)],[NSValue value:&itemFrame withObjCType:@encode(CGRect)],
        [NSValue value:&messageFrame withObjCType:@encode(CGRect)],
        [NSValue value:&prefixFrame withObjCType:@encode(CGRect)],
        message.text ?: null,prefix.text ?: null,message.font ?: null,message.textColor ?: null,message.backgroundColor ?: null,
        message.highlightedTextColor ?: null,@(message.textAlignment),@(message.numberOfLines),@(message.lineBreakMode),
        @(message.adjustsFontSizeToFitWidth),@(message.minimumScaleFactor),
        prefix.font ?: null,prefix.textColor ?: null,prefix.backgroundColor ?: null,prefix.highlightedTextColor ?: null,
        @(prefix.textAlignment),@(prefix.numberOfLines),@(prefix.lineBreakMode),@(prefix.adjustsFontSizeToFitWidth),@(prefix.minimumScaleFactor),
        item.traitCollection ?: null,message.traitCollection ?: null,margin,size];
}
static void CSFoldedReleaseNativeSummary(CSCloseFriendSessionCover *cover) {
    // Never restore a saved global digest. On ordinary reuse, preserve a fresh
    // native update; clear only our still-owned pair and geometry.
    if (cover.nativePrefix.superview && [cover.nativeMessage.text isEqual:cover.writtenMessage]) {
        cover.nativeMessage.text=nil;cover.nativeMessage.frame=cover.messageBaseFrame;
    }
    [cover.nativePrefix removeFromSuperview];
    cover.nativePrefix=nil;cover.nativeMessage=nil;cover.writtenMessage=nil;cover.nativeRenderState=nil;
}
static BOOL CSFoldedRenderNativeSummary(CSCloseFriendSessionCover *cover,UIView *item,UILabel *message,NSString *body,NSString *prefix) {
    SEL quote=NSSelectorFromString(@"quoteMessageLable:prefixText:"),remove=NSSelectorFromString(@"removeQuoteMessageLabel");
    NSMethodSignature *sig=[item methodSignatureForSelector:quote],*removeSig=[item methodSignatureForSelector:remove];
    if (!message || !body.length || !prefix.length || !sig || sig.numberOfArguments!=4 || strcmp(sig.methodReturnType,@encode(void)) ||
        [sig getArgumentTypeAtIndex:2][0]!='@' || [sig getArgumentTypeAtIndex:3][0]!='@' ||
        !removeSig || removeSig.numberOfArguments!=2 || strcmp(removeSig.methodReturnType,@encode(void))) return NO;
    @try {
        UIView *previous=CSFoldedNativePrefix(item);
        if (message==cover.nativeMessage && previous==cover.nativePrefix && previous.superview==item &&
            [message isDescendantOfView:item] && [message.text isEqual:body] && [((UILabel *)previous).text isEqual:prefix] &&
            cover.nativeRenderState && [cover.nativeRenderState isEqual:CSFoldedNativeRenderState(item,message,(UILabel *)previous)]) {
            CSFoldedKeepView(cover,message);CSFoldedKeepView(cover,previous);
            message.hidden=NO;previous.hidden=NO;
            return YES;
        }
        CGRect base=message.frame;
        // A native or our prior quote has already moved the message to the
        // right. Its prefix carries the real unquoted origin. Never quote an
        // already-quoted origin and accumulate indentation on repeated layout.
        if (previous) base.origin.x=previous.frame.origin.x;
        if (message==cover.nativeMessage && previous==cover.nativePrefix) base.origin.x=cover.messageBaseFrame.origin.x;
        if (!isfinite(base.origin.x) || !isfinite(base.origin.y) || base.size.height<=0) return NO;
        if (cover.nativeMessage!=message) CSFoldedReleaseNativeSummary(cover);
        ((void(*)(id,SEL))objc_msgSend)(item,remove);
        message.frame=base;message.text=body;
        ((void(*)(id,SEL,id,id))objc_msgSend)(item,quote,message,prefix);
        UIView *created=CSFoldedNativePrefix(item);
        if (!created || ![created isKindOfClass:UILabel.class] || ![((UILabel *)created).text isEqual:prefix]) {
            message.text=nil;[created removeFromSuperview];return NO;
        }
        cover.nativeMessage=message;cover.nativePrefix=created;cover.messageBaseFrame=base;cover.writtenMessage=[message.text copy];
        cover.nativeRenderState=CSFoldedNativeRenderState(item,message,(UILabel *)created);
        CSFoldedKeepView(cover,message);message.hidden=NO;created.hidden=NO;
        return YES;
    } @catch (__unused NSException *exception) {
        message.text=nil;CSFoldedReleaseNativeSummary(cover);return NO;
    }
}
void CSCloseFriendUpdateSessionCover(UITableViewCell *cell, CSGroupRow *row) {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL privacyCover=row.privacyMasked && row.kind==CSGroupRowKindAggregate && [row.userName isEqual:@"chatroom_session_box"] && (policy.blocked ||
        (policy.enabled && !policy.revealed && [policy.options[@"hideSessions"] boolValue] && policy.protectedUserNames.count));
    BOOL cover=privacyCover || row.foldedEntryScoped;
    CSCloseFriendSessionCover *view=objc_getAssociatedObject(cell,&CoverKey);
    if (!cover) {
        if (!view) return;
        CSFoldedReleaseNativeSummary(view);
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
    // A policy transition may precede the next projection. Never retain a digest
    // across accounts/revisions or read it from the global aggregate cell.
    BOOL currentSummary=row.foldedEntryScoped && !policy.blocked && [policy.accountID isEqual:row.foldedEntryAccountID] &&
        policy.revision==row.foldedEntryPrivacyRevision && row.foldedEntryCount.unsignedIntegerValue>0 && row.foldedEntrySummaryUserName.length &&
        ![policy hidesUserName:row.foldedEntrySummaryUserName surface:CSCloseFriendSurfaceSession];
    NSString *title=@"折叠的聊天";
    view.titleLabel.text=title;view.accessibilityLabel=title;
    view.summaryLabel.text=@"折叠的聊天";

    // Keep native content inside the shared card. Even an unknown native view
    // structure must not replace the configured card with a full-width slab.
    UIView *item=CSFoldedViewIvar(cell,"m_itemView",cell);
    if (!item) item=CSFoldedViewIvar(cell,"_itemView",cell);
    UIView *icon=CSFoldedViewIvar(item,"m_frameHeadView",item);
    UIView *name=CSFoldedViewIvar(item,"m_nameLabel",item);
    UIView *message=CSFoldedViewIvar(item,"m_messageLabel",item);
    BOOL nativeLayout=item && icon && name;
    NSNumber *nameWasHidden=name ? [view.hiddenStates objectForKey:name] : nil;
    BOOL nativeTitle=nativeLayout && [name isKindOfClass:UILabel.class] && [((UILabel *)name).text isEqual:title] &&
        !(nameWasHidden ? nameWasHidden.boolValue : name.hidden);
    view.titleLabel.hidden=nativeTitle;
    UIView *card=CSListCornerExistingSessionBackground(cell);
    UIView *container=nativeLayout ? item : (card ?: cell);
    if (view.superview!=container) {
        CSFoldedRestoreHiddenViews(view);
        [view removeFromSuperview]; [container addSubview:view];
    }
    view.frame=container.bounds;
    BOOL rendered=currentSummary && nativeLayout && [message isKindOfClass:UILabel.class] &&
        CSFoldedRenderNativeSummary(view,item,(UILabel *)message,row.foldedEntrySummary,row.foldedEntryPrefix);
    CSCloseFriendSnapshot *afterRender=CSCloseFriendCurrentSnapshot();
    if (rendered && (afterRender.blocked || ![afterRender.accountID isEqual:row.foldedEntryAccountID] ||
        afterRender.revision!=row.foldedEntryPrivacyRevision || [afterRender hidesUserName:row.foldedEntrySummaryUserName surface:CSCloseFriendSurfaceSession])) {
        rendered=NO;
    }
    if (!rendered) CSFoldedReleaseNativeSummary(view);
    view.summaryLabel.hidden=rendered;
    CGFloat x=18;
    if (nativeLayout) {
        CGRect nameFrame=[name convertRect:name.bounds toView:container];
        CGRect iconFrame=[icon convertRect:icon.bounds toView:container];
        x=CSFoldedValidFrame(nameFrame) ? nameFrame.origin.x : CGRectGetMaxX(iconFrame)+12;
        view.backgroundColor=UIColor.clearColor;
        // The real native title is already correct. Preserve its text, font,
        // frame and ancestors; only the global message/time/badges are masked.
        CSFoldedConcealItem(view,item,icon,nativeTitle ? name : nil);
        CSFoldedHideView(view,CSFoldedViewIvar(item,"m_unreadCountView",item));
    } else {
        // Unknown native structure: retain conservative privacy protection, with
        // a neutral two-line fallback. Never guess or display the global digest.
        view.backgroundColor=card ? UIColor.clearColor : UIColor.systemBackgroundColor;
        if (card) CSFoldedConcealItem(view,cell,card,nil);
        else for (UIView *child in cell.subviews) if (child!=view) CSFoldedHideView(view,child);
    }
    CGFloat middle=CGRectGetMidY(view.bounds),width=MAX(1,view.bounds.size.width-x-12);
    if (!nativeTitle) CSFoldedLayoutLabel(view.titleLabel,nativeLayout ? name : nil,container,CGRectMake(x,MAX(0,middle-24),width,22),NO);
    CSFoldedLayoutLabel(view.summaryLabel,nativeLayout ? message : nil,container,CGRectMake(x,middle+4,width,18),YES);
    if (container.subviews.lastObject!=view) [container bringSubviewToFront:view];
    cell.isAccessibilityElement=NO; cell.accessibilityLabel=nil; cell.accessibilityElements=@[view];
}

void CSCloseFriendRefreshSessionCover(UITableViewCell *cell) {
    CSCloseFriendSessionCover *cover=objc_getAssociatedObject(cell,&CoverKey);
    if (cover) CSCloseFriendUpdateSessionCover(cell,cover.row);
}
