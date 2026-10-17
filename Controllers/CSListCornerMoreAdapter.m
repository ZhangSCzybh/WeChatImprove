#import "CSListCornerMoreAdapter.h"
#import "CSListCornerRenderer.h"
#import <objc/runtime.h>
void CSListCornerMoreDecorate(UITableViewCell *cell, UITableView *table, NSIndexPath *path, id owner) {
    if (![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled || !(owner ? CSListCornerOwnsTable(owner,table,CSListCornerPageMore) : CSListCornerOwnerForTable(table,CSListCornerPageMore)!=nil)) return;
    if (!CSListCornerBeginOperation(cell)) return;
    @try {
        CSListCornerPageContext *context=[CSListCornerPageContext contextForCell:cell table:table indexPath:path page:CSListCornerPageMore owner:owner];
        if (!context) return;
        BOOL first=NO,last=NO;
        if (![context nativeFirst:&first last:&last]) return;
        [context renderFirst:first last:last];
        CGRect card=context.cardFrame;
        CGFloat leftMargin=card.origin.x, bgWidth=card.size.width;
        CGFloat rightMargin=context.configuration.rightMargin;
        for (UIView *view in context.content.subviews) {
            NSString *name=NSStringFromClass(view.class); CGRect frame=CSListCornerNativeFrame(view);
            if ([name isEqualToString:@"UIView"] || view==CSListCornerNativeContent(cell) || [name isEqualToString:@"MMUIView"]) {
                // Existing native entry container: require a known content role before insetting.
                BOOL identified=NO;
                for (UIView *item in view.subviews) if ([item isKindOfClass:UILabel.class] || [item isKindOfClass:UIImageView.class]) { identified=YES; break; }
                if (!identified) continue;
                frame.origin.x=leftMargin; frame.size.width=bgWidth;
            } else if ([view isKindOfClass:UIImageView.class]) frame.origin.x=frame.origin.x>context.content.bounds.size.width/2 ? context.content.bounds.size.width-rightMargin-frame.size.width-16 : leftMargin+16;
            else if ([view isKindOfClass:UILabel.class]) { frame.origin.x=leftMargin+52; frame.size.width=bgWidth-68; }
            else continue;
            view.backgroundColor=[UIColor clearColor]; CSListCornerSetFrame(view,frame);
        }
    } @finally { CSListCornerEndOperation(cell); }
}

static UITableView *CSListCornerMoreHeaderTable(UIView *view) {
    UITableView *table=CSListCornerTableForView(view);
    return CSListCornerOwnerForTable(table,CSListCornerPageMore) && table.tableHeaderView==view ? table : nil;
}
CGRect CSListCornerMoreHeaderFrame(UIView *view, CGRect frame) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    if (!configuration.enabled) return frame;
    UITableView *table=CSListCornerMoreHeaderTable(view);
    if (!table) return frame;
    CGRect target=frame; target.origin.x=configuration.leftMargin;
    target.size.width=table.bounds.size.width-configuration.leftMargin-configuration.rightMargin;
    return CSListCornerValidRect(target) ? target : frame;
}
static char HeaderNativeColorKey;
void CSListCornerMoreDecorateHeader(UIView *view) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    if (!configuration.enabled) return;
    UITableView *table=CSListCornerMoreHeaderTable(view);
    if (!table || !CSListCornerValidRect(view.bounds) || !CSListCornerBeginOperation(view)) return;
    @try {
        CGRect target=CSListCornerMoreHeaderFrame(view,view.frame);
        if (!CGRectEqualToRect(target,view.frame)) { view.frame=target; [view setNeedsLayout]; }
        CGFloat cardWidth=view.bounds.size.width,buttonX=92;
        // Only the plugin background is masked; native status cards and touch targets remain intact.
        UIView *background=CSListCornerOwnedBackground(view);
        UIColor *nativeColor=objc_getAssociatedObject(view,&HeaderNativeColorKey);
        if (view.backgroundColor && ![view.backgroundColor isEqual:[UIColor clearColor]]) {
            nativeColor=view.backgroundColor;
            objc_setAssociatedObject(view,&HeaderNativeColorKey,nativeColor,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        view.backgroundColor=[UIColor clearColor];
        CSListApplyCardBackground(background,view.bounds,configuration.radius,YES,YES,nativeColor ?: [UIColor clearColor]);
        for (UIView *item in view.subviews) {
            if (item==background) continue;
            CGRect frame=CSListCornerNativeFrame(item); NSString *name=NSStringFromClass(item.class);
            if ([name isEqualToString:@"MMHeadImageView"]) frame.origin.x=16;
            else if ([item isKindOfClass:UIImageView.class] && frame.size.width<20 && frame.size.height>20) frame.origin.x=cardWidth-16-frame.size.width;
            else if ([name isEqualToString:@"MMCPLabel"]) { frame.origin.x=92; frame.size.width=cardWidth-92-62; }
            else if ([name isEqualToString:@"MMUILabel"]) { frame.origin.x=92; frame.size.width=cardWidth-92-66; }
            else if ([name isEqualToString:@"TextStatePublishEntryButton"] || [name isEqualToString:@"TextStateFriendTopicButton"]) { frame.origin.x=buttonX; buttonX+=frame.size.width+8; }
            else if ([name isEqualToString:@"MMUIButton"] && frame.size.width<30 && frame.size.height<30) frame.origin.x=cardWidth-66;
            else if ([name isEqualToString:@"TextStateProfileCardContentView"] || [name isEqualToString:@"MMUIView"] || [name isEqualToString:@"UIView"]) {
                // Only the established exact-UIView thin-line role is hidden.
                // Business state containers may begin at zero height and expand later.
                if ([name isEqualToString:@"UIView"] && frame.size.height<1) { item.hidden=YES; item.alpha=0; continue; }
                frame.origin.x=0; frame.size.width=cardWidth;
            } else continue;
            CSListCornerSetFrame(item,frame);
        }
    } @finally { CSListCornerEndOperation(view); }
}
