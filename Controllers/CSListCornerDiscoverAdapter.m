#import "CSListCornerDiscoverAdapter.h"
#import <math.h>

// Frames stay in their native parent coordinates. Full-row structural wrappers
// are traversed, never resized; an unread composite is handled as one unit.
@interface CSListDiscoverElement : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic) CGRect nativeFrame;
@property(nonatomic) CGFloat parentX;
@end
@implementation CSListDiscoverElement @end

static BOOL CSDiscoverPlainContainer(UIView *view) {
    NSString *name=NSStringFromClass(view.class);
    return [name isEqualToString:@"UIView"] || [name isEqualToString:@"MMUIView"];
}
static BOOL CSDiscoverText(UIView *view) {
    return [view isKindOfClass:UILabel.class] || [NSStringFromClass(view.class) containsString:@"RichTextView"];
}
static void CSDiscoverCollect(UIView *container, UIView *background, CGFloat width, CGFloat parentX, NSUInteger depth, NSMutableArray *elements) {
    for (UIView *view in container.subviews) {
        if (view==background) continue;
        CGRect frame=CSListCornerNativeFrame(view);
        if (!CSListCornerValidRect(frame) || frame.size.height<=1) continue;
        if (depth<2 && CSDiscoverPlainContainer(view) && view.subviews.count &&
            fabs(frame.origin.x)<1 && fabs(frame.size.width-width)<1) {
            CSDiscoverCollect(view,background,width,parentX+frame.origin.x-view.bounds.origin.x,depth+1,elements);
            continue;
        }
        CSListDiscoverElement *element=[CSListDiscoverElement new];
        element.view=view; element.nativeFrame=frame; element.parentX=parentX;
        [elements addObject:element];
    }
}
// A plain composite may contain text followed by an avatar/dot. Remove only
// leading text space; translate the other children together, preserving their
// spacing and sizes. Unknown custom layouts retain native geometry on overflow.
static BOOL CSDiscoverCanTrim(UIView *view, CGFloat amount) {
    if (CSListCornerNativeFrame(view).size.width<=amount) return NO;
    if (CSDiscoverText(view)) return YES;
    if (!CSDiscoverPlainContainer(view) || !view.subviews.count || view.bounds.origin.x!=0) return NO;
    for (UIView *child in view.subviews) {
        CGRect frame=CSListCornerNativeFrame(child);
        if (!CSListCornerValidRect(frame)) return NO;
        if (frame.origin.x<amount && (!CSDiscoverText(child) || CGRectGetMaxX(frame)<=amount)) return NO;
    }
    return YES;
}
static void CSDiscoverTrimChildren(UIView *view, CGFloat amount) {
    if (CSDiscoverText(view)) return;
    for (UIView *child in view.subviews) {
        CGRect frame=CSListCornerNativeFrame(child);
        if (amount<=0) { CSListCornerSetFrame(child,frame); continue; }
        CGFloat right=CGRectGetMaxX(frame)-amount;
        frame.origin.x=MAX(0,frame.origin.x-amount);
        frame.size.width=right-frame.origin.x;
        CSListCornerSetFrame(child,frame);
    }
}
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
        NSMutableArray<CSListDiscoverElement *> *elements=[NSMutableArray array];
        CSDiscoverCollect(context.content,CSListCornerOwnedBackground(context.content),context.content.bounds.size.width,0,0,elements);
        CSListDiscoverElement *title=nil;
        // Native makeEntryCell tags the size-to-fit title with 1000 + rowType.
        // Prefer this role; older layouts fall back to the leading native label.
        for (CSListDiscoverElement *element in elements) {
            if (![element.view isKindOfClass:UILabel.class]) continue;
            CGFloat x=element.parentX+element.nativeFrame.origin.x;
            if (x>=context.content.bounds.size.width/2) continue;
            BOOL tagged=element.view.tag>=1000 && element.view.tag<2000;
            BOOL titleTagged=title.view.tag>=1000 && title.view.tag<2000;
            if (!title || (tagged && !titleTagged) || (tagged==titleTagged && x<title.parentX+title.nativeFrame.origin.x)) title=element;
        }
        if (!title) return; // Unrecognized native cell: decorate its background only.
        CGFloat left=context.configuration.leftMargin,right=context.configuration.rightMargin;
        CGFloat titleLeft=title.parentX+title.nativeFrame.origin.x;
        CGFloat titleRight=title.parentX+CGRectGetMaxX(title.nativeFrame);
        CGFloat leadingRight=titleRight;
        Class badgeClass=NSClassFromString(@"MMBadgeView");
        NSMutableArray<CSListDiscoverElement *> *leading=[NSMutableArray array];
        for (CSListDiscoverElement *element in elements) {
            CGFloat x=element.parentX+element.nativeFrame.origin.x;
            CGFloat edge=element.parentX+CGRectGetMaxX(element.nativeFrame);
            BOOL badge=badgeClass && [element.view isKindOfClass:badgeClass];
            BOOL titleBadge=badge && (element.view.tag==title.view.tag+1000 ||
                (element.view.tag==0 && x>=titleRight && x<=titleRight+16));
            BOOL icon=[element.view isKindOfClass:UIImageView.class] && !badge && edge<=titleLeft;
            if (element==title || titleBadge || icon) {
                [leading addObject:element];
                if (!element.view.hidden) leadingRight=MAX(leadingRight,edge);
            }
        }
        CGFloat minimumRightX=leadingRight+left+8;
        // Validate before moving anything: don't partially rewrite an unknown
        // composite if the requested margins leave too little space for it.
        for (CSListDiscoverElement *element in elements) {
            if ([leading containsObject:element]) continue;
            CGFloat x=element.parentX+element.nativeFrame.origin.x;
            if (x<titleRight) continue;
            CGFloat trim=MAX(0,minimumRightX-(x-right));
            if (trim>0 && !CSDiscoverCanTrim(element.view,trim)) return;
        }
        for (CSListDiscoverElement *element in elements) {
            CGRect frame=element.nativeFrame;
            if ([leading containsObject:element]) frame.origin.x+=left;
            else {
                CGFloat x=element.parentX+frame.origin.x;
                if (x<titleRight) continue;
                CGFloat trim=MAX(0,minimumRightX-(x-right));
                frame.origin.x+=trim-right; frame.size.width-=trim;
                if (CSDiscoverPlainContainer(element.view)) {
                    // UIKit springs/struts must not adjust children a second time
                    // when this plain wrapper loses leading text space.
                    BOOL autoresizes=element.view.autoresizesSubviews;
                    element.view.autoresizesSubviews=NO;
                    CSListCornerSetFrame(element.view,frame);
                    CSDiscoverTrimChildren(element.view,trim);
                    element.view.autoresizesSubviews=autoresizes;
                    continue;
                }
            }
            CSListCornerSetFrame(element.view,frame);
        }
    } @finally { CSListCornerEndOperation(cell); }
}
