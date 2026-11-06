#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef struct { CGFloat top, left, bottom, right; } UIEdgeInsets;
static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat t, CGFloat l, CGFloat b, CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
typedef NS_OPTIONS(NSUInteger, UIRectEdge) { UIRectEdgeNone=0, UIRectEdgeTop=1, UIRectEdgeBottom=4, UIRectEdgeAll=15 };
typedef NS_ENUM(NSInteger, UITableViewStyle) { UITableViewStylePlain, UITableViewStyleGrouped, UITableViewStyleInsetGrouped };
typedef NS_ENUM(NSInteger, UIScrollViewContentInsetAdjustmentBehavior) { UIScrollViewContentInsetAdjustmentAutomatic, UIScrollViewContentInsetAdjustmentScrollableAxes, UIScrollViewContentInsetAdjustmentNever, UIScrollViewContentInsetAdjustmentAlways };
typedef NS_ENUM(NSInteger, UINavigationItemLargeTitleDisplayMode) { UINavigationItemLargeTitleDisplayModeAutomatic, UINavigationItemLargeTitleDisplayModeAlways, UINavigationItemLargeTitleDisplayModeNever };

@interface UIView : NSObject
@property(nonatomic) UIEdgeInsets safeAreaInsets;
@end

@interface UITableView : UIView
@property(nonatomic) UIScrollViewContentInsetAdjustmentBehavior contentInsetAdjustmentBehavior;
@property(nonatomic) BOOL automaticallyAdjustsScrollIndicatorInsets;
@property(nonatomic) UIEdgeInsets contentInset;
@property(nonatomic) UIEdgeInsets verticalScrollIndicatorInsets;
@property(nonatomic) CGPoint contentOffset;
@property(nonatomic,readonly) UIEdgeInsets adjustedContentInset;
// Test-only boundary: supplied UIKit automatic inset, independent from contentInset.
@property(nonatomic) UIEdgeInsets testAutomaticInsets;
@property(nonatomic) BOOL testCorrectsOffsetWhenDisablingAdjustment;
@property(nonatomic) CGPoint testCorrectedOffset;
@property(nonatomic) NSUInteger testInsetWrites, testIndicatorWrites, testOffsetWrites;
@end

@interface UINavigationItem : NSObject
@property(nonatomic) UINavigationItemLargeTitleDisplayMode largeTitleDisplayMode;
@end

@interface UIViewController : NSObject
@property(nonatomic) UIRectEdge edgesForExtendedLayout;
@property(nonatomic) BOOL extendedLayoutIncludesOpaqueBars;
@property(nonatomic) BOOL automaticallyAdjustsScrollViewInsets;
@property(nonatomic,strong) UINavigationItem *navigationItem;
@property(nonatomic,strong) UIView *view;
@property(nonatomic,readonly) BOOL isViewLoaded;
@property(nonatomic) BOOL hidesBottomBarWhenPushed;
@property(nonatomic) NSUInteger testDidLoadCalls, testLayoutCalls, testSafeAreaCalls;
- (instancetype)initWithCoder:(NSCoder *)coder;
- (void)loadView;
- (void)loadViewIfNeeded;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewSafeAreaInsetsDidChange;
- (void)viewDidLayoutSubviews;
@end

@interface UITableViewController : UIViewController
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UITableView *testPreparedTable;
- (instancetype)initWithStyle:(UITableViewStyle)style;
@end
