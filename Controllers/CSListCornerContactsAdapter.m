#import "CSListCornerContactsAdapter.h"
static void CSListCornerContactsSectionSurface(UIView *surface, UIView *selection, NSUInteger depth) {
    for (UIView *child in surface.subviews) {
        if (child==selection) continue;
        if ([child isKindOfClass:UILabel.class]) {
            child.backgroundColor=[UIColor clearColor];
            continue;
        }
        NSString *name=NSStringFromClass(child.class);
        BOOL plain=[name isEqualToString:@"UIView"] || [name isEqualToString:@"MMUIView"];
        CGRect frame=child.frame;
        if (!plain || !CSListCornerValidRect(frame) || frame.size.width<surface.bounds.size.width/2) continue;
        BOOL edge=CGRectGetMinY(frame)<=CGRectGetMinY(surface.bounds)+1 || CGRectGetMaxY(frame)>=CGRectGetMaxY(surface.bounds)-1;
        if (frame.size.height<=1 && child.subviews.count==0 && edge) { child.hidden=YES; child.alpha=0; }
        else {
            child.backgroundColor=CSListCornerCanvasColor();
            if (depth<1) CSListCornerContactsSectionSurface(child,selection,depth+1);
        }
    }
}
void CSListCornerContactsDecorateSection(UIView *view, UITableView *table, id owner) {
    if (!view || ![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled) return;
    if (!(owner ? CSListCornerOwnsTable(owner,table,CSListCornerPageContacts) : CSListCornerOwnerForTable(table,CSListCornerPageContacts)!=nil)) return;
    if (!CSListCornerBeginOperation(view)) return;
    @try {
        UIColor *canvas=CSListCornerCanvasColor();
        view.backgroundColor=canvas;
        UIView *selection=CSListCornerViewIvar(view,"_selectedBackgroundView",view);
        UIView *content=view;
        if ([view isKindOfClass:UITableViewHeaderFooterView.class]) {
            UITableViewHeaderFooterView *header=(UITableViewHeaderFooterView *)view;
            content=header.contentView;
            header.contentView.backgroundColor=canvas;
            header.backgroundView.backgroundColor=canvas;
            if ([header.backgroundView isKindOfClass:UIImageView.class]) ((UIImageView *)header.backgroundView).image=nil;
        }
        CSListCornerContactsSectionSurface(content,selection,0);
        // MMTableSectionHeaderView paints behind its title/star with an image view.
        // Keep title, star, selection state and hit targets; replace only the backing paint.
        UIView *paint=CSListCornerViewIvar(view,"_backgroundImageView",view);
        if ([paint isKindOfClass:UIImageView.class]) {
            ((UIImageView *)paint).image=nil;
            paint.backgroundColor=canvas;
        }
        for (NSString *name in @[@"_topLineView",@"_bottomLineView"]) {
            UIView *line=CSListCornerViewIvar(view,name.UTF8String,view);
            line.hidden=YES; line.alpha=0;
        }
    } @finally { CSListCornerEndOperation(view); }
}
void CSListCornerContactsDecorate(UITableViewCell *cell, UITableView *table, NSIndexPath *path, id owner) {
    if (![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled || !(owner ? CSListCornerOwnsTable(owner,table,CSListCornerPageContacts) : CSListCornerOwnerForTable(table,CSListCornerPageContacts)!=nil)) return;
    if (!CSListCornerBeginOperation(cell)) return;
    @try {
        if (!path) path=[table indexPathForCell:cell];
        CSListCornerPageContext *context=[CSListCornerPageContext contextForCell:cell table:table indexPath:path page:CSListCornerPageContacts owner:owner];
        if (!context) return;
        BOOL first=NO,last=NO;
        if (![context nativeFirst:&first last:&last]) return;
        if (path.section<=3) {
            NSInteger sections=MIN((NSInteger)4,table.numberOfSections), total=0, absolute=path.row;
            for (NSInteger section=0;section<sections;section++) {
                NSInteger rows=[table numberOfRowsInSection:section]; total+=rows;
                if (section<path.section) absolute+=rows;
            }
            first=absolute==0; last=absolute==total-1;
        }
        [context renderFirst:first last:last];
        CGRect card=context.cardFrame;
        CGFloat leftMargin=card.origin.x, bgWidth=card.size.width;
        // ContactsItemView retains native avatar/text/enterprise and multiline layout.
        BOOL hasItem=NO;
        for (UIView *view in context.content.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"ContactsItemView")]) {
                CGRect frame=view.frame; frame.origin.x=leftMargin; frame.size.width=bgWidth;
                view.backgroundColor=[UIColor clearColor]; CSListCornerSetFrame(view,frame); hasItem=YES;
            } else if ([NSStringFromClass(view.class) isEqualToString:@"UIView"]) {
                for (UIView *item in view.subviews) if ([item isKindOfClass:NSClassFromString(@"ContactsItemView")]) {
                    // Convert content-local geometry only; a nested parent may already be inset.
                    CGRect target=[context.content convertRect:card toView:view];
                    CGRect frame=item.frame; frame.origin.x=target.origin.x; frame.size.width=target.size.width;
                    view.backgroundColor=[UIColor clearColor]; item.backgroundColor=[UIColor clearColor];
                    CSListCornerSetFrame(item,frame); hasItem=YES;
                }
            }
        }
        if (!hasItem) {
            // Compatibility fallback for the native plain entry cells in the first four sections.
            for (UIView *view in context.content.subviews) {
                CGRect frame=CSListCornerNativeFrame(view);
                if ([view isKindOfClass:UIImageView.class]) frame.origin.x=frame.origin.x>context.content.bounds.size.width/2 ? leftMargin+bgWidth-16-frame.size.width : leftMargin+16;
                else if ([view isKindOfClass:UILabel.class]) { frame.origin.x=leftMargin+52; frame.size.width=bgWidth-68; }
                else continue;
                view.backgroundColor=[UIColor clearColor]; CSListCornerSetFrame(view,frame);
            }
        }
    } @finally { CSListCornerEndOperation(cell); }
}
