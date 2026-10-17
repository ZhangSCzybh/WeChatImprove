#import "CSListCornerSessionAdapter.h"
#import "CSGroupListAdapter.h"
void CSListCornerSessionDecorate(UITableViewCell *cell, UITableView *table, NSIndexPath *path, id owner) {
    if (![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled || !(owner ? CSListCornerOwnsTable(owner,table,CSListCornerPageSession) : CSListCornerOwnerForTable(table,CSListCornerPageSession)!=nil)) return;
    if (!CSListCornerBeginOperation(cell)) return;
    @try {
        CSListCornerPageContext *context=[CSListCornerPageContext contextForCell:cell table:table indexPath:path page:CSListCornerPageSession owner:owner];
        if (!context) return;
        BOOL first=NO,last=NO;
        if (!CSGroupCardPosition(table,path,&first,&last)) {
            // Active grouping owns index domains. Invalid projected paths must never guess native roles.
            if ([CSGroupListAdapter adapterForTable:table].active || ![context nativeFirst:&first last:&last]) return;
        }
        [context renderFirst:first last:last];
        CGRect card=context.cardFrame;
        CGFloat leftMargin=card.origin.x, bgWidth=card.size.width;
        for (UIView *view in context.content.subviews) {
            NSString *name=NSStringFromClass(view.class);
            if ([name isEqualToString:@"MFBannerBtn"] || [name isEqualToString:@"MFWebMMBtn"]) {
                CGRect frame=view.frame; frame.origin.x=leftMargin; frame.size.width=bgWidth;
                view.backgroundColor=[UIColor clearColor]; CSListCornerSetFrame(view,frame);
            }
        }
    } @finally { CSListCornerEndOperation(cell); }
}

CGRect CSListCornerSessionItemFrame(UIView *view, CGRect frame) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    if (!configuration.enabled) return frame;
    UITableView *table=CSListCornerTableForView(view);
    if (!CSListCornerOwnerForTable(table,CSListCornerPageSession)) return frame;
    // Preserve native MainFrame/Fake nominal table width, repairing width even when x already matches.
    CGRect target=frame; target.origin.x=configuration.leftMargin;
    target.size.width=table.bounds.size.width-configuration.leftMargin-configuration.rightMargin;
    return CSListCornerValidRect(target) ? target : frame;
}
