#import "CSListCornerSessionRestore.h"
#import "CSListCornerPageContext.h"
#import <objc/runtime.h>

static char RestoreKey;

@interface CSListCornerSessionGap : UIView
@property(nonatomic,weak) UITableView *table;
@property(nonatomic) NSInteger section;
@property(nonatomic) BOOL footer;
- (UIColor *)expectedColor;
- (void)repairPaint;
@end
@implementation CSListCornerSessionGap
- (UIColor *)expectedColor {
    CSListCornerSnapshot *configuration=CSListCornerConfiguration.sharedConfiguration.snapshot;
    if (!configuration.enabled) return UIColor.clearColor;
    // Identical section/color policy to CSListCornerSectionView; no new spacing or colors.
    if (self.footer) return CSListCornerCanvasColor();
    UIUserInterfaceStyle style=self.table.traitCollection.userInterfaceStyle;
    return self.section==0 ? [configuration pinnedColorForStyle:style] :
        (self.section==1 || self.section==2 ? [configuration normalColorForStyle:style] : UIColor.clearColor);
}
- (void)repairPaint {
    if (!CSListCornerOwnerForTable(self.table,CSListCornerPageSession)) return;
    UIColor *color=self.expectedColor;
    if (![self.backgroundColor isEqual:color]) self.backgroundColor=color;
}
- (void)layoutSubviews { [super layoutSubviews]; [self repairPaint]; }
@end

@interface CSListCornerSessionRestore : NSObject
@property(nonatomic,weak) UITableView *table;
@property(nonatomic,strong) NSHashTable<CSListCornerSessionGap *> *gaps;
@property(nonatomic) BOOL restoring,inactive;
- (void)activityChanged:(NSNotification *)notification;
@end
@implementation CSListCornerSessionRestore
- (instancetype)init {
    if ((self=[super init])) {
        _gaps=[NSHashTable weakObjectsHashTable];
        for (NSString *name in @[UIApplicationWillResignActiveNotification,UIApplicationDidEnterBackgroundNotification,
                                UIApplicationWillEnterForegroundNotification,UIApplicationDidBecomeActiveNotification,
                                UISceneWillDeactivateNotification,UISceneDidEnterBackgroundNotification,
                                UISceneWillEnterForegroundNotification,UISceneDidActivateNotification]) {
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(activityChanged:) name:name object:nil];
        }
    }
    return self;
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)activityChanged:(NSNotification *)notification {
    if (!NSThread.isMainThread) return;
    UITableView *table=self.table;
    if (!CSListCornerOwnerForTable(table,CSListCornerPageSession)) return;
    NSString *name=notification.name;
    BOOL scene=[name isEqual:UISceneWillDeactivateNotification] || [name isEqual:UISceneDidEnterBackgroundNotification] ||
               [name isEqual:UISceneWillEnterForegroundNotification] || [name isEqual:UISceneDidActivateNotification];
    if (scene && (!notification.object || notification.object!=table.window.windowScene)) return;
    BOOL returning=[name isEqual:UIApplicationWillEnterForegroundNotification] || [name isEqual:UIApplicationDidBecomeActiveNotification] ||
                   [name isEqual:UISceneWillEnterForegroundNotification] || [name isEqual:UISceneDidActivateNotification];
    if (!returning) { self.inactive=YES;return; }
    self.inactive=NO;
    if (!table.window) return;
    CSListCornerRestoreSessionTable(table,YES);
    // A retained layer can need repaint even when its model color still matches.
    // Invalidate existing surfaces without replacing views or rebuilding the list.
    [table setNeedsDisplay];[table.backgroundView setNeedsDisplay];
    for (CSListCornerSessionGap *gap in self.gaps) if ([gap isDescendantOfView:table]) [gap setNeedsDisplay];
    for (UITableViewCell *cell in table.visibleCells) {
        [cell.contentView setNeedsDisplay];
        [CSListCornerExistingSessionBackground(cell) setNeedsDisplay];
    }
    // Invalidation only: UIKit performs native table layout before the frame is committed.
    // The post-original table hook closes ordering with later notification observers.
    // No reload, forced layout, timer, or contentOffset/contentInset assignment.
    [table setNeedsLayout];
}
@end

void CSListCornerTrackSessionTable(UITableView *table) {
    if (!NSThread.isMainThread || !CSListCornerOwnerForTable(table,CSListCornerPageSession)) return;
    CSListCornerSessionRestore *state=objc_getAssociatedObject(table,&RestoreKey);
    if (!state) {
        state=[CSListCornerSessionRestore new];state.table=table;
        objc_setAssociatedObject(table,&RestoreKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

UIView *CSListCornerCreateSessionGap(UITableView *table, NSInteger section, BOOL footer, CGRect frame) {
    CSListCornerSessionGap *view=[[CSListCornerSessionGap alloc] initWithFrame:frame];
    view.table=table;view.section=section;view.footer=footer;view.userInteractionEnabled=NO;
    CSListCornerTrackSessionTable(table);
    CSListCornerSessionRestore *state=objc_getAssociatedObject(table,&RestoreKey);
    [state.gaps addObject:view];[view repairPaint];
    return view;
}

void CSListCornerRestoreSessionTable(UITableView *table, BOOL refreshGeometry) {
    if (!NSThread.isMainThread) return;
    // Setters also run during table construction and in unrelated pages. Fast exclusion.
    CSListCornerSessionRestore *state=objc_getAssociatedObject(table,&RestoreKey);
    if (!state || state.restoring || state.inactive) return;
    id owner=CSListCornerOwnerForTable(table,CSListCornerPageSession);
    if (!owner || !table.window) return;
    if (!refreshGeometry) {
        UIColor *expected=CSListCornerSessionTableColor(table);
        BOOL mismatch=![table.backgroundColor isEqual:expected] || (table.backgroundView && ![table.backgroundView.backgroundColor isEqual:expected]);
        for (CSListCornerSessionGap *gap in state.gaps) {
            if (mismatch) break;
            if ([gap isDescendantOfView:table] && ![gap.backgroundColor isEqual:gap.expectedColor]) mismatch=YES;
        }
        if (!mismatch) return;
    }
    state.restoring=YES;
    @try {
        CSListCornerPrepareTable(owner,CSListCornerPageSession,NO);
        for (CSListCornerSessionGap *gap in state.gaps) if ([gap isDescendantOfView:table]) [gap repairPaint];
        if (refreshGeometry) {
            for (UITableViewCell *cell in table.visibleCells) {
                // Reuse the last native-delivered row role; never query rows or projection here.
                CSListCornerRefreshSessionGeometry(cell);
            }
        }
    } @finally { state.restoring=NO; }
}
