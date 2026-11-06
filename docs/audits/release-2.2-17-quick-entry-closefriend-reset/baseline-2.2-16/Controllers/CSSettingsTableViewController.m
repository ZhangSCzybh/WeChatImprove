#import "CSSettingsTableViewController.h"
#import <math.h>

@interface CSSettingsTableViewController ()
@property (nonatomic, assign) CGFloat cs_bottomSafeArea;
@end

@implementation CSSettingsTableViewController

- (void)cs_prepareControllerLayout {
    // Give the table its final navigation-bar boundary before the push starts.
    // An extending root table can otherwise acquire a temporary top safe-area
    // inset during a sheet/navigation transition, then lose it after appearing.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) [self cs_prepareControllerLayout];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if ((self = [super initWithCoder:coder])) [self cs_prepareControllerLayout];
    return self;
}

- (void)viewDidLoad {
    [self cs_prepareControllerLayout];
    [super viewDidLoad];
    UITableView *table = self.tableView;
    UIEdgeInsets initialAdjustedInset = table.adjustedContentInset;
    CGPoint initialOffset = table.contentOffset;
    BOOL initiallyPinnedToInset = isfinite(initialOffset.y) && isfinite(initialAdjustedInset.top) &&
        initialOffset.y < 0 && initialAdjustedInset.top > 0 &&
        fabs(initialOffset.y + initialAdjustedInset.top) < 0.5;
    table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    table.automaticallyAdjustsScrollIndicatorInsets = NO;
    // These are new plugin-owned tables. UIKit must not carry a provisional
    // navigation inset into their first frame. Subsequent layouts never reset
    // the top inset or scroll position, including when returning from a child.
    UIEdgeInsets content = table.contentInset;
    content.top = 0;
    table.contentInset = content;
    UIEdgeInsets indicator = table.verticalScrollIndicatorInsets;
    indicator.top = 0;
    table.verticalScrollIndicatorInsets = indicator;
    [self cs_updateBottomSafeArea];
    // Only a new table's first load may normalize an old inset's top boundary.
    // A preloaded table can already have offset=-adjustedInset.top; clearing the
    // inset alone leaves that empty region visible. Retain restored scroll
    // positions, current UIKit corrections, and all subsequent return/bounce offsets.
    CGPoint currentOffset = table.contentOffset;
    if (initiallyPinnedToInset && isfinite(currentOffset.y) && currentOffset.y < 0) {
        currentOffset.y = 0;
        table.contentOffset = currentOffset;
    }
}

- (void)cs_updateBottomSafeArea {
    CGFloat bottom = MAX(0, self.view.safeAreaInsets.bottom);
    CGFloat delta = bottom - self.cs_bottomSafeArea;
    if (fabs(delta) < 0.01) return;
    self.cs_bottomSafeArea = bottom;
    // Own only the safe-area contribution; retain keyboard/editor additions.
    UIEdgeInsets content = self.tableView.contentInset;
    content.bottom = MAX(0, content.bottom + delta);
    self.tableView.contentInset = content;
    UIEdgeInsets indicator = self.tableView.verticalScrollIndicatorInsets;
    indicator.bottom = MAX(0, indicator.bottom + delta);
    self.tableView.verticalScrollIndicatorInsets = indicator;
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    [self cs_updateBottomSafeArea];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self cs_updateBottomSafeArea];
}

@end
