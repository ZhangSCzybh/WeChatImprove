#import "CSListCornerPageContext.h"
#import "CSListCornerRenderer.h"
#import "CSListCornerSessionRestore.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <math.h>
@interface UITableView (CSListCornerNativeFooter)
- (void)drawFooterLine:(BOOL)draw;
@end
@protocol CSListCornerNativeSelection <NSObject>
- (UIView *)selectedBackgroundView;
@end
static char OperationKey, BackgroundKey, PreviousBackgroundKey;
static char SessionStateKey;
static char SelectionStateKey;
@interface CSListCornerSelectionState : NSObject
@property(nonatomic,strong) UIView *surface;
@property(nonatomic,strong) CAShapeLayer *mask;
@end
@implementation CSListCornerSelectionState @end
@interface CSListCornerSessionState : NSObject
@property(nonatomic) BOOL preservesMargins;
@property(nonatomic) UIEdgeInsets separatorInset,layoutMargins;
@property(nonatomic,strong) NSMapTable<UIView *,NSMutableDictionary *> *paint;
@property(nonatomic,strong) NSMapTable<UIView *,NSArray *> *lines;
@end
@implementation CSListCornerSessionState @end
static UIColor *CSListCornerSessionCanvas(UIUserInterfaceStyle style) {
    return CSListCornerCanvasColorForStyle(style);
}
static void CSListCornerPaint(UITableViewCell *cell, UIView *view, UIColor *color) {
    if (!view) return;
    CSListCornerSessionState *state=objc_getAssociatedObject(cell,&SessionStateKey);
    if (state) {
        NSMutableDictionary *saved=[state.paint objectForKey:view];
        id current=view.backgroundColor ?: NSNull.null;
        if (!saved) { saved=[NSMutableDictionary dictionary]; [state.paint setObject:saved forKey:view]; }
        // Preserve a newer native paint rather than restoring a stale theme.
        if (!saved[@"applied"] || ![current isEqual:saved[@"applied"]]) saved[@"native"]=current;
        saved[@"applied"]=color ?: NSNull.null;
    }
    if (![view.backgroundColor isEqual:color]) view.backgroundColor=color;
}
static void CSListCornerRestoreFrames(UIView *view, BOOL restore);
UIView *CSListCornerExistingSessionBackground(UITableViewCell *cell) {
    return objc_getAssociatedObject(cell,&SessionStateKey) ? objc_getAssociatedObject(cell,&PreviousBackgroundKey) : nil;
}
void CSListCornerRemoveSessionAppearance(UITableViewCell *cell) {
    CSListCornerSessionState *state=objc_getAssociatedObject(cell,&SessionStateKey);
    if (!state) return;
    UIView *background=objc_getAssociatedObject(cell,&PreviousBackgroundKey);
    UIView *parent=background.superview;
    if (parent && objc_getAssociatedObject(parent,&BackgroundKey)==background) objc_setAssociatedObject(parent,&BackgroundKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [background removeFromSuperview];
    objc_setAssociatedObject(cell,&PreviousBackgroundKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell,&SessionStateKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIView *view in state.paint) {
        NSDictionary *saved=[state.paint objectForKey:view];
        if ([(view.backgroundColor ?: NSNull.null) isEqual:saved[@"applied"]]) view.backgroundColor=saved[@"native"]==NSNull.null ? nil : saved[@"native"];
    }
    for (UIView *view in state.lines) {
        NSArray *saved=[state.lines objectForKey:view];
        if (view.hidden && view.alpha==0) { view.hidden=[saved[0] boolValue]; view.alpha=[saved[1] doubleValue]; }
    }
    if (cell.separatorInset.left==cell.bounds.size.width) cell.separatorInset=state.separatorInset;
    if (UIEdgeInsetsEqualToEdgeInsets(cell.layoutMargins,UIEdgeInsetsZero)) cell.layoutMargins=state.layoutMargins;
    if (!cell.preservesSuperviewLayoutMargins) cell.preservesSuperviewLayoutMargins=state.preservesMargins;
    CSListCornerRestoreFrames(cell,![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled);
}
BOOL CSListCornerBeginOperation(id object) {
    if (!object || [objc_getAssociatedObject(object,&OperationKey) boolValue]) return NO;
    objc_setAssociatedObject(object,&OperationKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC); return YES;
}
void CSListCornerEndOperation(id object) { objc_setAssociatedObject(object,&OperationKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
BOOL CSListCornerValidRect(CGRect rect) {
    return isfinite(rect.origin.x) && isfinite(rect.origin.y) && isfinite(rect.size.width) && isfinite(rect.size.height) && rect.size.width>0 && rect.size.height>0;
}
UIColor *CSListCornerCanvasColor(void) { return [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1]; }
UIColor *CSListCornerCanvasColorForStyle(UIUserInterfaceStyle style) {
    return style==UIUserInterfaceStyleDark ? UIColor.blackColor : CSListCornerCanvasColor();
}
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
static void CSListCornerHideEdgeLines(UIView *container, CGFloat cellWidth, NSUInteger depth, CSListCornerSessionState *state) {
    // Only inspect the cell's structural containers, never arbitrary business content.
    for (UIView *view in container.subviews) {
        NSString *name=NSStringFromClass(view.class);
        CGRect frame=view.frame;
        BOOL plain=[name isEqualToString:@"UIView"] || [name isEqualToString:@"MMUIView"];
        BOOL named=[name isEqualToString:@"_UITableViewCellSeparatorView"] || [name isEqualToString:@"MMTableViewCellSeparatorView"];
        BOOL edge=CGRectGetMinY(frame)<=CGRectGetMinY(container.bounds)+1 || CGRectGetMaxY(frame)>=CGRectGetMaxY(container.bounds)-1;
        BOOL thin=plain && view.subviews.count==0 && CSListCornerValidRect(frame) && frame.size.height<=1 && frame.size.width>=MAX(20,cellWidth/2) && edge;
        if (named || thin) {
            if (state && ![state.lines objectForKey:view]) [state.lines setObject:@[@(view.hidden),@(view.alpha)] forKey:view];
            view.hidden=YES; view.alpha=0; continue;
        }
        BOOL structural=plain || [name isEqualToString:@"UITableViewCellContentView"] || [name isEqualToString:@"ContactsItemView"];
        if (structural && depth<3) CSListCornerHideEdgeLines(view,cellWidth,depth+1,state);
    }
}
static void CSListCornerHideSeparator(UITableViewCell *cell) {
    UIEdgeInsets inset=UIEdgeInsetsMake(0,cell.bounds.size.width,0,0);
    if (!UIEdgeInsetsEqualToEdgeInsets(cell.separatorInset,inset)) cell.separatorInset=inset;
    if (!UIEdgeInsetsEqualToEdgeInsets(cell.layoutMargins,UIEdgeInsetsZero)) cell.layoutMargins=UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins=NO;
    CSListCornerHideEdgeLines(cell,cell.bounds.size.width,0,objc_getAssociatedObject(cell,&SessionStateKey));
}
void CSListCornerRepairCellSeparators(UITableViewCell *cell, UITableView *table) {
    if (![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled) return;
    if (!CSListCornerOwnerForTable(table,CSListCornerPageContacts) && !CSListCornerOwnerForTable(table,CSListCornerPageDiscover) && !CSListCornerOwnerForTable(table,CSListCornerPageMore)) return;
    if (!CSListCornerBeginOperation(cell)) return;
    @try { CSListCornerHideSeparator(cell); }
    @finally { CSListCornerEndOperation(cell); }
}
static void CSListCornerRestoreCellSelection(UITableViewCell *cell) {
    CSListCornerSelectionState *state=objc_getAssociatedObject(cell,&SelectionStateKey);
    if (state.surface.layer.mask==state.mask) state.surface.layer.mask=nil;
    objc_setAssociatedObject(cell,&SelectionStateKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
void CSListCornerRepairCellSelection(UITableViewCell *cell, UITableView *table) {
    BOOL owned=CSListCornerOwnerForTable(table,CSListCornerPageDiscover)!=nil || CSListCornerOwnerForTable(table,CSListCornerPageMore)!=nil;
    if (![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled || !owned) {
        CSListCornerRestoreCellSelection(cell); return;
    }
    if (!CSListCornerBeginOperation(cell)) return;
    @try {
        CSListCornerHideSeparator(cell);
        UIView *card=objc_getAssociatedObject(cell,&PreviousBackgroundKey);
        UIView *surface=[cell respondsToSelector:@selector(selectedBackgroundView)] ? [(id<CSListCornerNativeSelection>)cell selectedBackgroundView] : nil;
        CSListCornerSelectionState *state=objc_getAssociatedObject(cell,&SelectionStateKey);
        if (state.surface!=surface) { CSListCornerRestoreCellSelection(cell); state=nil; }
        NSString *name=surface ? NSStringFromClass(surface.class) : nil;
        BOOL plain=[name isEqualToString:@"UIView"] || [name isEqualToString:@"MMUIView"];
        CAShapeLayer *cardMask=[card.layer.mask isKindOfClass:CAShapeLayer.class] ? (CAShapeLayer *)card.layer.mask : nil;
        if (!card || card.superview!=cell.contentView || !cardMask.path || !plain || surface.subviews.count ||
            ![surface isDescendantOfView:cell] || !CSListCornerValidRect(surface.bounds) ||
            (surface.layer.mask && surface.layer.mask!=state.mask)) {
            CSListCornerRestoreCellSelection(cell); return;
        }
        // Native layout/highlighting can extend its rectangular fill beyond the cell.
        // Reuse the rendered card's actual role and coordinates without querying rows.
        CGRect frame=[card convertRect:card.bounds toView:surface];
        if (!CSListCornerValidRect(frame)) { CSListCornerRestoreCellSelection(cell); return; }
        if (!state) {
            state=[CSListCornerSelectionState new]; state.surface=surface; state.mask=[CAShapeLayer layer];
            state.mask.actions=@{@"position":NSNull.null,@"bounds":NSNull.null,@"path":NSNull.null};
            objc_setAssociatedObject(cell,&SelectionStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        if (!CGRectEqualToRect(state.mask.frame,frame)) state.mask.frame=frame;
        if (!state.mask.path || !CGPathEqualToPath(state.mask.path,cardMask.path)) state.mask.path=cardMask.path;
        if (surface.layer.mask!=state.mask) surface.layer.mask=state.mask;
    } @finally { CSListCornerEndOperation(cell); }
}
UIColor *CSListCornerSessionTableColor(UITableView *table) {
    CSListCornerSnapshot *configuration=CSListCornerConfiguration.sharedConfiguration.snapshot;
    UIUserInterfaceStyle style=table.traitCollection.userInterfaceStyle;
    return configuration.enabled ? CSListCornerSessionCanvas(style) : [configuration backgroundForStyle:style];
}
void CSListCornerPrepareTable(id owner, CSListCornerPage page, BOOL initial) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    // Session appearance historically applies these three properties even when disabled.
    // Cell/layout decoration keeps its independent enabled gate.
    if (!configuration.enabled && page!=CSListCornerPageSession) return;
    UITableView *table=CSListCornerOwnedTable(owner,page); if (!table) return;
    UIColor *background=page==CSListCornerPageSession ? CSListCornerSessionTableColor(table) : CSListCornerCanvasColorForStyle(table.traitCollection.userInterfaceStyle);
    if (![table.backgroundColor isEqual:background]) table.backgroundColor=background;
    // Native appearance updates can replace this backing view after viewDidLoad.
    if (![table.backgroundView.backgroundColor isEqual:background]) table.backgroundView.backgroundColor=background;
    if (page==CSListCornerPageContacts) {
        table.sectionIndexBackgroundColor=[UIColor clearColor];
        table.sectionIndexTrackingBackgroundColor=[UIColor clearColor];
    }
    if (page==CSListCornerPageContacts || page==CSListCornerPageDiscover || page==CSListCornerPageMore) {
        table.separatorStyle=UITableViewCellSeparatorStyleNone;
        if ([table respondsToSelector:@selector(drawFooterLine:)]) [table drawFooterLine:NO];
    }
    if (initial || page==CSListCornerPageSession) {
        // With cards enabled this is the canvas visible around and below them.
        table.showsVerticalScrollIndicator=NO;
        if (page==CSListCornerPageContacts) { table.sectionHeaderHeight=0; table.sectionFooterHeight=0; }
    }
    if (page==CSListCornerPageSession) CSListCornerTrackSessionTable(table);
}
static void CSListCornerPrepareCellPaint(UITableViewCell *cell, UIView *content, UIUserInterfaceStyle style) {
    CSListCornerPaint(cell,cell,UIColor.clearColor);
    CSListCornerPaint(cell,content,CSListCornerCanvasColorForStyle(style));
    CSListCornerHideSeparator(cell);
    // Native MMTableViewCell's dedicated content container may have an opaque fill.
    UIView *native=CSListCornerNativeContent(cell);
    CSListCornerPaint(cell,native,UIColor.clearColor);
    for (UIView *view in content.subviews) {
        NSString *name=NSStringFromClass(view.class);
        if ([name isEqualToString:@"MainFrameItemView"] || [name isEqualToString:@"FakeMainFrameItemView"] || [name isEqualToString:@"MMUIView"]) CSListCornerPaint(cell,view,UIColor.clearColor);
    }
}
@interface CSListCornerPageAppearance : NSObject
@property(nonatomic,strong) CSListCornerSnapshot *configuration;
@property(nonatomic) UIUserInterfaceStyle style;
@end
@implementation CSListCornerPageAppearance @end
static char PageAppearanceKey;
static char PageCanvasViewsKey;
void CSListCornerTrackPageCanvas(UITableView *table, UIView *view) {
    if (!view || !table) return;
    NSHashTable *views=objc_getAssociatedObject(table,&PageCanvasViewsKey);
    if (!views) {
        views=[NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(table,&PageCanvasViewsKey,views,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [views addObject:view];
    view.backgroundColor=CSListCornerCanvasColorForStyle(table.traitCollection.userInterfaceStyle);
}
BOOL CSListCornerRefreshPageAppearance(id owner, CSListCornerPage page) {
    CSListCornerSnapshot *configuration=CSListCornerConfiguration.sharedConfiguration.snapshot;
    if (!configuration.enabled || page==CSListCornerPageSession) return NO;
    UITableView *table=CSListCornerOwnedTable(owner,page);
    if (!table || !CSListCornerBeginOperation(table)) return NO;
    @try {
        CSListCornerPrepareTable(owner,page,NO);
        UIUserInterfaceStyle style=table.traitCollection.userInterfaceStyle;
        CSListCornerPageAppearance *state=objc_getAssociatedObject(table,&PageAppearanceKey);
        if (state && state.style==style && state.configuration==configuration) return NO;
        if (!state) {
            state=[CSListCornerPageAppearance new];
            objc_setAssociatedObject(table,&PageAppearanceKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        state.style=style; state.configuration=configuration;
        NSHashTable *canvasViews=objc_getAssociatedObject(table,&PageCanvasViewsKey);
        for (UIView *view in canvasViews.allObjects) {
            // UITableView can retain an offscreen footer without redelivering it.
            // Keep our own cached paint current, but exclude a view moved to another table.
            UITableView *currentTable=CSListCornerTableForView(view);
            if (currentTable && currentTable!=table) continue;
            UIColor *canvas=CSListCornerCanvasColorForStyle(style);
            if (![view.backgroundColor isEqual:canvas]) view.backgroundColor=canvas;
        }
        for (UITableViewCell *cell in table.visibleCells) {
            UIView *background=objc_getAssociatedObject(cell,&PreviousBackgroundKey);
            UIView *content=cell.contentView;
            // Only repair cards already delivered by the native table callbacks.
            if (background.superview!=content || !CSListCornerBeginOperation(cell)) continue;
            @try {
                if (CSListRefreshCardBackground(background,background.frame,configuration.radius,[configuration backgroundForStyle:style]))
                    CSListCornerPrepareCellPaint(cell,content,style);
            } @finally { CSListCornerEndOperation(cell); }
        }
        return YES;
    } @finally { CSListCornerEndOperation(table); }
}
@interface CSListCornerPageContext ()
@property(nonatomic, strong) UITableViewCell *cell;
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIView *content;
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, strong) CSListCornerSnapshot *configuration;
@property(nonatomic) CGRect cardFrame;
@property(nonatomic) UIUserInterfaceStyle style;
@property(nonatomic) CSListCornerPage page;
@end
static void CSListCornerAlignSessionItems(UITableViewCell *cell, UIView *content, UIView *background) {
    const char *keys[]={"m_itemView","_itemView",NULL};
    for (const char **key=keys;*key;key++) {
        UIView *item=CSListCornerViewIvar(cell,*key,content);
        if (item && item.superview) CSListCornerSetFrame(item,[background convertRect:background.bounds toView:item.superview]);
    }
}
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
    context.indexPath=path; context.configuration=configuration; context.cardFrame=frame; context.style=content.traitCollection.userInterfaceStyle; context.page=page;
    if (page!=CSListCornerPageSession && table.traitCollection.userInterfaceStyle!=UIUserInterfaceStyleUnspecified)
        context.style=table.traitCollection.userInterfaceStyle;
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
    if (self.page==CSListCornerPageSession) {
        CSListCornerSessionState *state=objc_getAssociatedObject(self.cell,&SessionStateKey);
        if (!state) {
            state=[CSListCornerSessionState new];state.paint=[NSMapTable weakToStrongObjectsMapTable];state.lines=[NSMapTable weakToStrongObjectsMapTable];
            state.separatorInset=self.cell.separatorInset;state.layoutMargins=self.cell.layoutMargins;state.preservesMargins=self.cell.preservesSuperviewLayoutMargins;
            objc_setAssociatedObject(self.cell,&SessionStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    CSListCornerPrepareCellPaint(self.cell,self.content,self.style);
    UIView *previous=objc_getAssociatedObject(self.cell,&PreviousBackgroundKey);
    if (previous && previous.superview!=self.content) [previous removeFromSuperview];
    UIView *background=CSListCornerOwnedBackground(self.content);
    objc_setAssociatedObject(self.cell,&PreviousBackgroundKey,background,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSListApplyCardBackground(background,self.cardFrame,self.configuration.radius,first,last,[self.configuration backgroundForStyle:self.style]);
    if (self.page==CSListCornerPageSession) CSListCornerAlignSessionItems(self.cell,self.content,background);
}
@end
void CSListCornerRefreshSessionGeometry(UITableViewCell *cell) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    if (!configuration.enabled) { CSListCornerRemoveSessionAppearance(cell); return; }
    UITableView *table=CSListCornerTableForView(cell);
    if (CSListCornerSessionTableLayoutInProgress(table)) return;
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
        CSListCornerPrepareCellPaint(cell,content,content.traitCollection.userInterfaceStyle);
        CSListCornerAlignSessionItems(cell,content,background);
    } @finally { CSListCornerEndOperation(cell); }
}
@interface CSListCornerFrameState : NSObject
@property(nonatomic) CGRect nativeFrame, appliedFrame;
@end
@implementation CSListCornerFrameState @end
static char FrameStateKey;
static void CSListCornerRestoreFrames(UIView *view, BOOL restore) {
    CSListCornerFrameState *state=objc_getAssociatedObject(view,&FrameStateKey);
    if (state && restore && CGRectEqualToRect(view.frame,state.appliedFrame)) view.frame=state.nativeFrame;
    objc_setAssociatedObject(view,&FrameStateKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIView *child in view.subviews) CSListCornerRestoreFrames(child,restore);
}
CGRect CSListCornerNativeFrame(UIView *view) {
    CSListCornerFrameState *state=objc_getAssociatedObject(view,&FrameStateKey);
    if (!state || !CGRectEqualToRect(view.frame,state.appliedFrame)) return view.frame;
    return state.nativeFrame;
}
void CSListCornerSetFrame(UIView *view, CGRect frame) {
    if (!CSListCornerValidRect(frame)) return;
    CGRect native=CSListCornerNativeFrame(view);
    CSListCornerRecordFrame(view,native,frame);
    if (!CGRectEqualToRect(view.frame,frame)) view.frame=frame;
}
void CSListCornerRecordFrame(UIView *view, CGRect native, CGRect frame) {
    CSListCornerFrameState *state=objc_getAssociatedObject(view,&FrameStateKey);
    if (state && CGRectEqualToRect(native,state.appliedFrame)) native=state.nativeFrame;
    if (!state) { state=[CSListCornerFrameState new]; objc_setAssociatedObject(view,&FrameStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    state.nativeFrame=native; state.appliedFrame=frame;
}
