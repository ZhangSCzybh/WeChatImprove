#import <UIKit/UIKit.h>

@implementation UIView @end
@implementation UINavigationItem @end
@implementation UITableView
- (instancetype)init {
    if ((self=[super init])) _automaticallyAdjustsScrollIndicatorInsets=YES;
    return self;
}
- (void)setContentInset:(UIEdgeInsets)value { _contentInset=value;self.testInsetWrites++; }
- (void)setVerticalScrollIndicatorInsets:(UIEdgeInsets)value { _verticalScrollIndicatorInsets=value;self.testIndicatorWrites++; }
- (void)setContentOffset:(CGPoint)value { _contentOffset=value;self.testOffsetWrites++; }
- (void)setContentInsetAdjustmentBehavior:(UIScrollViewContentInsetAdjustmentBehavior)value {
    _contentInsetAdjustmentBehavior=value;
    if (value==UIScrollViewContentInsetAdjustmentNever && self.testCorrectsOffsetWhenDisablingAdjustment)
        self.contentOffset=self.testCorrectedOffset;
}
- (UIEdgeInsets)adjustedContentInset {
    UIEdgeInsets value=self.contentInset;
    if (self.contentInsetAdjustmentBehavior!=UIScrollViewContentInsetAdjustmentNever) {
        value.top+=self.testAutomaticInsets.top;value.bottom+=self.testAutomaticInsets.bottom;
        value.left+=self.testAutomaticInsets.left;value.right+=self.testAutomaticInsets.right;
    }
    return value;
}
@end

@implementation UIViewController
@synthesize view=_view;
- (instancetype)init {
    if ((self=[super init])) {
        _edgesForExtendedLayout=UIRectEdgeAll;
        _automaticallyAdjustsScrollViewInsets=YES;
        _navigationItem=[UINavigationItem new];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder { (void)coder;return [self init]; }
- (UIView *)view { [self loadViewIfNeeded];return _view; }
- (void)setView:(UIView *)view { _view=view; }
- (BOOL)isViewLoaded { return _view!=nil; }
- (void)loadView { _view=[UIView new]; }
- (void)loadViewIfNeeded { if (!_view) { [self loadView];[self viewDidLoad]; } }
- (void)viewDidLoad { self.testDidLoadCalls++; }
- (void)viewWillAppear:(BOOL)animated { (void)animated; }
- (void)viewDidAppear:(BOOL)animated { (void)animated; }
- (void)viewWillDisappear:(BOOL)animated { (void)animated; }
- (void)viewDidDisappear:(BOOL)animated { (void)animated; }
- (void)viewSafeAreaInsetsDidChange { self.testSafeAreaCalls++; }
- (void)viewDidLayoutSubviews { self.testLayoutCalls++; }
@end

@implementation UITableViewController
- (instancetype)initWithStyle:(UITableViewStyle)style { (void)style;return [super init]; }
- (void)loadView {
    self.tableView=self.testPreparedTable ?: [UITableView new];
    self.view=self.tableView;
}
@end
