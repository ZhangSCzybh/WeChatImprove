#import "CSListCornerDiscoverAdapter.h"
void CSListCornerDiscoverDecorate(UITableViewCell *cell, UITableView *table, NSIndexPath *path, id owner) {
    if (![[CSListCornerConfiguration sharedConfiguration] snapshot].enabled || !(owner ? CSListCornerOwnsTable(owner,table,CSListCornerPageDiscover) : CSListCornerOwnerForTable(table,CSListCornerPageDiscover)!=nil)) return;
    if (!CSListCornerBeginOperation(cell)) return;
    @try {
        if (!path) path=[table indexPathForCell:cell];
        CSListCornerPageContext *context=[CSListCornerPageContext contextForCell:cell table:table indexPath:path page:CSListCornerPageDiscover owner:owner];
        if (!context) return;
        BOOL first=NO,last=NO;
        if (![context nativeFirst:&first last:&last]) return;
        [context renderFirst:first last:last];
        CGRect card=context.cardFrame;
        CGFloat leftMargin=card.origin.x, bgWidth=card.size.width;
        CGFloat rightMargin=context.configuration.rightMargin;
        CGFloat labelY=0,labelHeight=20,labelRight=0;
        for (UIView *view in context.content.subviews) if ([view isKindOfClass:UILabel.class]) {
            CGRect frame=CSListCornerNativeFrame(view); labelY=frame.origin.y; labelHeight=frame.size.height; labelRight=CGRectGetMaxX(frame);
        }
        for (UIView *view in context.content.subviews) {
            NSString *name=NSStringFromClass(view.class);
            CGRect frame=CSListCornerNativeFrame(view);
            if ([name isEqualToString:@"MMBadgeView"] && labelRight>0) {
                // Apply the old badge offset once, with spacing measured in the native frame domain.
                frame.origin.x=leftMargin+labelRight-16+(frame.origin.x-labelRight);
                frame.origin.y=labelY+(labelHeight-frame.size.height)/2;
            } else if ([name isEqualToString:@"UIView"] || view==CSListCornerNativeContent(cell) || [name isEqualToString:@"MMUIView"]) {
                BOOL identified=NO; CGFloat iconWidth=24,iconSpacing=12;
                for (UIView *item in view.subviews) {
                    if ([item isKindOfClass:UIImageView.class]) { iconWidth=CSListCornerNativeFrame(item).size.width; identified=YES; }
                    if ([item isKindOfClass:UILabel.class]) identified=YES;
                }
                if (!identified) continue; // Never rewrite an unrelated nested container.
                for (UIView *item in view.subviews) {
                    NSString *itemName=NSStringFromClass(item.class); CGRect itemFrame=CSListCornerNativeFrame(item);
                    CGFloat center=frame.origin.x+CGRectGetMidX(itemFrame), cardCenter=leftMargin+bgWidth/2;
                    if ([item isKindOfClass:UIImageView.class]) itemFrame.origin.x=center>cardCenter ? bgWidth-rightMargin-itemFrame.size.width : leftMargin;
                    else if ([item isKindOfClass:UILabel.class]) { itemFrame.origin.x=leftMargin+iconWidth+iconSpacing; itemFrame.size.width=bgWidth-iconWidth-iconSpacing-rightMargin; }
                    else if ([itemName containsString:@"RichTextView"]) {
                        itemFrame.origin.x=center>cardCenter ? bgWidth-rightMargin-itemFrame.size.width : leftMargin+iconWidth+iconSpacing;
                        if (center<=cardCenter) itemFrame.size.width=bgWidth-iconWidth-iconSpacing-rightMargin;
                    } else continue;
                    CSListCornerSetFrame(item,itemFrame);
                }
                frame.origin.x=leftMargin; frame.size.width=bgWidth;
            } else if ([view isKindOfClass:UIImageView.class]) frame.origin.x=frame.origin.x>context.content.bounds.size.width/2 ? leftMargin+bgWidth-16-frame.size.width : leftMargin+16;
            else if ([view isKindOfClass:UILabel.class]) { frame.origin.x=leftMargin+52; frame.size.width=bgWidth-68; }
            else continue;
            view.backgroundColor=[UIColor clearColor]; CSListCornerSetFrame(view,frame);
        }
    } @finally { CSListCornerEndOperation(cell); }
}
