#import <UIKit/UIKit.h>
#import "WESessionTabItem.h"

@interface WESessionTabContainerView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void(^onTabSelected)(NSInteger index);
@property (nonatomic, copy) void(^onAddButtonTapped)(void);
@property (nonatomic, copy) void(^onSearchButtonTapped)(void);

- (void)updateTabs:(NSArray<WESessionTabItem *> *)tabs;
- (void)updateUnreadCount:(NSInteger)count forTabIndex:(NSInteger)index;
- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
