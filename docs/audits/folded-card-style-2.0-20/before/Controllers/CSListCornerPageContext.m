#import "CSListCornerPageContext.h"
#import "CSListCornerRenderer.h"
#import <objc/runtime.h>
#import <math.h>
@interface UITableView (CSListCornerNativeFooter)
- (void)drawFooterLine:(BOOL)draw;
@end
static char OperationKey, BackgroundKey, PreviousBackgroundKey;
BOOL CSListCornerBeginOperation(id object) {
    if (!object || [objc_getAssociatedObject(object,&OperationKey) boolValue]) return NO;
    objc_setAssociatedObject(object,&OperationKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC); return YES;
}
void CSListCornerEndOperation(id object) { objc_setAssociatedObject(object,&OperationKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
BOOL CSListCornerValidRect(CGRect rect) {
    return isfinite(rect.origin.x) && isfinite(rect.origin.y) && isfinite(rect.size.width) && isfinite(rect.size.height) && rect.size.width>0 && rect.size.height>0;
}
UIColor *CSListCornerCanvasColor(void) { return [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1]; }
static NSString *CSListCornerOwnerName(CSListCornerPage page) {
    switch (page) {
        case CSListCornerPageSession:return @"NewMainFrameViewController";
        case CSListCornerPageContacts:return @"ContactsViewController";
        case CSListCornerPageDiscover:return @"FindFriendEntryViewController";
        case CSListCornerPageMore:return @"MoreViewController";
    } return @"";
}
static id CSListCornerObjectIvar(id object, const char *name) {
    Ivar ivar=class_getInstanceVariable([object class],name);
    // Reject non-object ivars before using ARC's object_getIvar.
    const char *type=ivar ? ivar_getTypeEncoding(ivar) : NULL;
    return type && type[0]=='@' ? object_getIvar(object,ivar) : nil;
}
UITableView *CSListCornerOwnedTable(id owner, CSListCornerPage page) {
    Class cls=NSClassFromString(CSListCornerOwnerName(page));
    if (!cls || ![owner isKindOfClass:cls]) return nil;
    id table=CSListCornerObjectIvar(owner,page==CSListCornerPageMore ? "_frontTableView" : "m_tableView");
    return [table isKindOfClass:UITableView.class] ? table : nil;
}
BOOL CSListCornerOwnsTable(id owner, UITableView *table, CSListCornerPage page) { return table && CSListCornerOwnedTable(owner,page)==table; }
id CSListCornerOwnerForTable(UITableView *table, CSListCornerPage page) {
    // Follow the responder chain, then verify the owner's actual main-table ivar.
    id responder=table;
    for (NSUInteger depth=0; responder && depth<128; depth++) {
        if (CSListCornerOwnsTable(responder,table,page)) return responder;
        if (![responder respondsToSelector:@selector(nextResponder)]) break;
        id next=[responder nextResponder]; if (next==responder) break; responder=next;
    } return nil;
}
UITableView *CSListCornerTableForView(UIView *view) {
    for (UIView *parent=view.superview;parent;parent=parent.superview) if ([parent isKindOfClass:UITableView.class]) return (UITableView *)parent;
    return nil;
}
UIView *CSListCornerOwnedBackground(UIView *container) {
    UIView *background=objc_getAssociatedObject(container,&BackgroundKey);
    if (!background || background.superview!=container) {
        [background removeFromSuperview]; background=[UIView new];
        background.userInteractionEnabled=NO;
        objc_setAssociatedObject(container,&BackgroundKey,background,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [container insertSubview:background atIndex:0];
    }
    background.userInteractionEnabled=NO; background.hidden=NO;
    if (container.subviews.firstObject!=background) [container insertSubview:background atIndex:0];
    return background;
}
UIView *CSListCornerNativeContent(UITableViewCell *cell) {
    id native=CSListCornerObjectIvar(cell,"m_subContentView");
    // Preserve short-circuiting: contentView may itself enter native layout.
    return [native isKindOfClass:UIView.class] && [native isDescendantOfView:cell.contentView] ? native : nil;
}
UIView *CSListCornerViewIvar(id object, const char *name, UIView *container) {
    id view=CSListCornerObjectIvar(object,name);
    return [view isKindOfClass:UIView.class] && [view isDescendantOfView:container] ? view : nil;
}
static void CSListCornerHideEdgeLines(UIView *container, CGFloat cellWidth, NSUInteger depth) {
    // Only inspect the cell's structural containers, never arbitrary business content.
    for (UIView *view in container.subviews) {
        NSString *name=NSStringFromClass(view.class);
        CGRect frame=view.frame;
        BOOL plain=[name isEqualToString:@"UIView"] || [name isEqualToString:@"MMUIView"];
        BOOL named=[name isEqualToString:@"_UITableViewCellSeparatorView"] || [name isEqualToString:@"MMTableViewCellSeparatorView"];
        BOOL edge=CGRectGetMinY(frame)<=CGRectGetMinY(container.bounds)+1 || CGRectGetMaxY(frame)>=CGRectGetMaxY(container.bounds)-1;
        BOOL thin=plain && view.subviews.count==0 && CSListCornerValidRect(frame) && frame.size.height<=1 && frame.size.width>=MAX(20,cellWidth/2) && edge;
        if (named || thin) { view.hidden=YES; view.alpha=0; continue; }
        BOOL structural=plain || [name isEqualToString:@"UITableViewCellContentView"] || [name isEqualToString:@"ContactsItemView"];
        if (structural && depth<3) CSListCornerHideEdgeLines(view,cellWidth,depth+1);
    }
}
static void CSListCornerHideSeparator(UITableViewCell *cell) {
    UIEdgeInsets inset=UIEdgeInsetsMake(0,cell.bounds.size.width,0,0);
    if (!UIEdgeInsetsEqualToEdgeInsets(cell.separatorInset,inset)) cell.separatorInset=inset;
    if (!UIEdgeInsetsEqualToEdgeInsets(cell.layoutMargins,UIEdgeInsetsZero)) cell.layoutMargins=UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins=NO;
    CSListCornerHideEdgeLines(cell,cell.bounds.size.width,0);
}
void CSListCornerRepairCellSeparators(UITableViewCell *cell, UITableView *table) {
    if (![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled) return;
    if (!CSListCornerOwnerForTable(table,CSListCornerPageContacts) && !CSListCornerOwnerForTable(table,CSListCornerPageMore)) return;
    if (!CSListCornerBeginOperation(cell)) return;
    @try { CSListCornerHideSeparator(cell); }
    @finally { CSListCornerEndOperation(cell); }
}
void CSListCornerPrepareTable(id owner, CSListCornerPage page, BOOL initial) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    // Session appearance historically applies these three properties even when disabled.
    // Cell/layout decoration keeps its independent enabled gate.
    if (!configuration.enabled && page!=CSListCornerPageSession) return;
    UITableView *table=CSListCornerOwnedTable(owner,page); if (!table) return;
    UIColor *background=page==CSListCornerPageSession ? [configuration backgroundForStyle:table.traitCollection.userInterfaceStyle] : CSListCornerCanvasColor();
    if (![table.backgroundColor isEqual:background]) table.backgroundColor=background;
    if (page==CSListCornerPageContacts) {
        table.sectionIndexBackgroundColor=[UIColor clearColor];
        table.sectionIndexTrackingBackgroundColor=[UIColor clearColor];
    }
    if (page==CSListCornerPageContacts || page==CSListCornerPageMore) {
        table.separatorStyle=UITableViewCellSeparatorStyleNone;
        if ([table respondsToSelector:@selector(drawFooterLine:)]) [table drawFooterLine:NO];
    }
    if (initial || page==CSListCornerPageSession) {
        // backgroundView covers the entire viewport, including below a short or
        // empty filtered list. It must use the same session paint as the cards.
        if (![table.backgroundView.backgroundColor isEqual:background]) table.backgroundView.backgroundColor=background;
        table.showsVerticalScrollIndicator=NO;
        if (page==CSListCornerPageContacts) { table.sectionHeaderHeight=0; table.sectionFooterHeight=0; }
    }
}
static void CSListCornerPrepareCellPaint(UITableViewCell *cell, UIView *content) {
    cell.backgroundColor=[UIColor clearColor]; content.backgroundColor=CSListCornerCanvasColor();
    CSListCornerHideSeparator(cell);
    // Native MMTableViewCell's dedicated content container may have an opaque fill.
    UIView *native=CSListCornerNativeContent(cell);
    native.backgroundColor=[UIColor clearColor];
    for (UIView *view in content.subviews) {
        NSString *name=NSStringFromClass(view.class);
        if ([name isEqualToString:@"MainFrameItemView"] || [name isEqualToString:@"FakeMainFrameItemView"] || [name isEqualToString:@"MMUIView"]) view.backgroundColor=[UIColor clearColor];
    }
}
@interface CSListCornerPageContext ()
@property(nonatomic, strong) UITableViewCell *cell;
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIView *content;
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, strong) CSListCornerSnapshot *configuration;
@property(nonatomic) CGRect cardFrame;
@property(nonatomic) UIUserInterfaceStyle style;
@end
@implementation CSListCornerPageContext
+ (instancetype)contextForCell:(UITableViewCell *)cell table:(UITableView *)table indexPath:(NSIndexPath *)path page:(CSListCornerPage)page owner:(id)owner {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    if (!configuration.enabled || !cell || !table || !path || path.section<0 || path.row<0) return nil;
    if (!(owner ? CSListCornerOwnsTable(owner,table,page) : CSListCornerOwnerForTable(table,page)!=nil)) return nil;
    UIView *content=cell.contentView; // Re-read: MMBaseMultiMenuTableViewCell may replace _actualContentView.
    CGRect bounds=content.bounds;
    CGRect frame=CGRectMake(configuration.leftMargin,0,bounds.size.width-configuration.leftMargin-configuration.rightMargin,bounds.size.height);
    if (!CSListCornerValidRect(bounds) || !CSListCornerValidRect(frame)) return nil;
    CSListCornerPageContext *context=[self new]; context.cell=cell; context.table=table; context.content=content;
    context.indexPath=path; context.configuration=configuration; context.cardFrame=frame; context.style=content.traitCollection.userInterfaceStyle;
    return context;
}
- (BOOL)nativeFirst:(BOOL *)first last:(BOOL *)last {
    NSInteger section=self.indexPath.section;
    if (section<0 || section>=self.table.numberOfSections) return NO;
    NSInteger rows=[self.table numberOfRowsInSection:section];
    if (self.indexPath.row<0 || self.indexPath.row>=rows) return NO;
    *first=self.indexPath.row==0; *last=self.indexPath.row==rows-1; return YES;
}
- (void)renderFirst:(BOOL)first last:(BOOL)last {
    CSListCornerPrepareCellPaint(self.cell,self.content);
    UIView *previous=objc_getAssociatedObject(self.cell,&PreviousBackgroundKey);
    if (previous && previous.superview!=self.content) [previous removeFromSuperview];
    UIView *background=CSListCornerOwnedBackground(self.content);
    objc_setAssociatedObject(self.cell,&PreviousBackgroundKey,background,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSListApplyCardBackground(background,self.cardFrame,self.configuration.radius,first,last,[self.configuration backgroundForStyle:self.style]);
}
@end
void CSListCornerRefreshSessionGeometry(UITableViewCell *cell) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    if (!configuration.enabled) return;
    UITableView *table=CSListCornerTableForView(cell);
    if (!CSListCornerOwnerForTable(table,CSListCornerPageSession) || !CSListCornerBeginOperation(cell)) return;
    @try {
        UIView *background=objc_getAssociatedObject(cell,&PreviousBackgroundKey);
        if (!background) return; // Row roles are established only by normal display callbacks.
        UIView *content=cell.contentView;
        CGRect bounds=content.bounds;
        CGRect frame=CGRectMake(configuration.leftMargin,0,bounds.size.width-configuration.leftMargin-configuration.rightMargin,bounds.size.height);
        if (!CSListCornerValidRect(bounds) || !CSListCornerValidRect(frame)) return;
        if (!CSListRefreshCardBackground(background,frame,configuration.radius,[configuration backgroundForStyle:content.traitCollection.userInterfaceStyle])) return;
        if (background.superview!=content) {
            // MMBaseMultiMenuTableViewCell may switch its actual content container.
            UIView *oldParent=background.superview;
            if (oldParent && objc_getAssociatedObject(oldParent,&BackgroundKey)==background) objc_setAssociatedObject(oldParent,&BackgroundKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            UIView *other=objc_getAssociatedObject(content,&BackgroundKey);
            if (other && other!=background) [other removeFromSuperview];
            objc_setAssociatedObject(content,&BackgroundKey,background,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        if (content.subviews.firstObject!=background) [content insertSubview:background atIndex:0];
        background.hidden=NO;
        CSListCornerPrepareCellPaint(cell,content);
    } @finally { CSListCornerEndOperation(cell); }
}
@interface CSListCornerFrameState : NSObject
@property(nonatomic) CGRect nativeFrame, appliedFrame;
@end
@implementation CSListCornerFrameState @end
static char FrameStateKey;
CGRect CSListCornerNativeFrame(UIView *view) {
    CSListCornerFrameState *state=objc_getAssociatedObject(view,&FrameStateKey);
    if (!state || !CGRectEqualToRect(view.frame,state.appliedFrame)) return view.frame;
    return state.nativeFrame;
}
void CSListCornerSetFrame(UIView *view, CGRect frame) {
    if (!CSListCornerValidRect(frame)) return;
    CGRect native=CSListCornerNativeFrame(view);
    CSListCornerFrameState *state=objc_getAssociatedObject(view,&FrameStateKey);
    if (!state) { state=[CSListCornerFrameState new]; objc_setAssociatedObject(view,&FrameStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    state.nativeFrame=native; state.appliedFrame=frame;
    if (!CGRectEqualToRect(view.frame,frame)) view.frame=frame;
}
