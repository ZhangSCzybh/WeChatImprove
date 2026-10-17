#import "CSListCornerContactsAdapter.h"
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
