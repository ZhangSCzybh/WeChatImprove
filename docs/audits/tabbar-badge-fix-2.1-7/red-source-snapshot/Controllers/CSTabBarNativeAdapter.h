#import <UIKit/UIKit.h>

// Minimal declarations verified against the local 8.0.78.34 method inventory.
@interface MMTabbarItem : UITabBarItem
@property(nonatomic) long long index;
@end
@interface MMTabBarItemView : UIView
@property(nonatomic, strong) MMTabbarItem *item;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIView *badgeView;
@property(nonatomic) BOOL isSelected;
- (void)layoutIcon;
- (void)layoutBadgeView;
- (void)reloadIconImage;
@end
@interface MMTabBar : UITabBar
@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) NSMutableArray *tabBarItemViews;
@property(nonatomic, weak) id customDelegate;
- (void)relayoutTabBarItems;
@end
@interface MMTabBarController : UITabBarController
- (id)getTabBarBtnForIndex:(unsigned long long)index;
- (void)onTabBarItemViewsRelayout;
@end

#ifdef __cplusplus
extern "C" {
#endif

void CSTabBarBeginLayout(MMTabBar *bar);
void CSTabBarEndLayout(MMTabBar *bar);
void CSTabBarUpdate(MMTabBar *bar);
UIView *CSTabBarStyleSnapshot(MMTabBar *bar, UIView *nativeSnapshot);
void CSTabBarBeginItemUpdate(MMTabBarItemView *item);
void CSTabBarEndItemUpdate(MMTabBarItemView *item);
BOOL CSTabBarContainsPoint(MMTabBar *bar, CGPoint point, BOOL *handled);
UIView *CSTabBarHitTest(MMTabBar *bar, CGPoint point, UIEvent *event, BOOL *handled);
void CSTabBarInstallObservers(void);

#ifdef __cplusplus
}
#endif
