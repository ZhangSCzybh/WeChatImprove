#import <UIKit/UIKit.h>
#import "WESessionTabItem.h"

@interface WESessionTabContainerView : UIView

@property (nonatomic, strong, readonly, nonnull) UIScrollView *scrollView;
/// NSNotFound when no tabs are visible.
@property (nonatomic, assign) NSInteger selectedIndex;
/// Stable selection identity. May be set before the first updateTabs: call.
@property (nonatomic, copy, nullable) NSString *selectedTabID;
@property (nonatomic, copy, nullable) void(^onTabSelected)(NSInteger index);
@property (nonatomic, copy, nullable) void(^onSearchButtonTapped)(void);

/// Base font size before Dynamic Type scaling; hiding search releases its full width.
- (void)applyAppearanceWithFontSize:(CGFloat)fontSize showsSearchButton:(BOOL)showsSearchButton;
- (void)refreshAppearance;
- (void)updateTabs:(NSArray<WESessionTabItem *> * _Nullable)tabs;
/// A positive number takes precedence over a red dot. Zero/NO hides the badge.
- (void)updateUnreadCount:(NSInteger)count hasRedDot:(BOOL)hasRedDot forTabIndex:(NSInteger)index;
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;

/// Preview an adjacent selection without changing the selected group or sending haptics.
- (void)updateInteractiveTransitionToIndex:(NSInteger)index progress:(CGFloat)progress;
- (void)cancelInteractiveTransition;

@end
