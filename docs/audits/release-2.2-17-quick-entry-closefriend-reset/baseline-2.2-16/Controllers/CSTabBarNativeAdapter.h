#import <UIKit/UIKit.h>

// Minimal declarations verified against the local 8.0.78.34 and 8.0.80 inventories.
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
// 8.0.80 uses a UIView/UIControl based hierarchy and retains the legacy item
// renderer inside MMMainTabBarItemView. Do not assume its UIKit compatibility
// isKindOfClass: result means that MMTabBar's selectors are implemented.
@interface WCTabBarView : UIView
@property(nonatomic, copy) NSArray *items;
@property(nonatomic, copy) NSArray *itemViews;
@property(nonatomic, strong) UIView *backgroundContentView;
@property(nonatomic, strong) UIView *separatorView;
@property(nonatomic, weak) id visibilityDelegate;
@end
@interface WCTabBarItemView : UIControl
@end
@interface MMMainTabBarItemView : WCTabBarItemView
@property(nonatomic, readonly) MMTabBarItemView *itemView;
@property(nonatomic, readonly) MMTabbarItem *legacyItem;
@end
@interface WCTabBarController : UIViewController
@property(nonatomic, readonly) WCTabBarView *tabBarView;
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
void CSTabBarBeginControllerLayout(MMTabBarController *controller);
void CSTabBarEndControllerLayout(MMTabBarController *controller);
void CSTabBarUpdate(MMTabBar *bar);
MMTabBar *CSTabBarForController(MMTabBarController *controller);
UIView *CSTabBarStyleSnapshot(MMTabBar *bar, UIView *nativeSnapshot);
void CSTabBarBeginItemUpdate(MMTabBarItemView *item);
void CSTabBarEndItemUpdate(MMTabBarItemView *item);
BOOL CSTabBarContainsPoint(MMTabBar *bar, CGPoint point, BOOL *handled);
UIView *CSTabBarHitTest(MMTabBar *bar, CGPoint point, UIEvent *event, BOOL *handled);
void CSTabBarInstallObservers(void);

#ifdef __cplusplus
}
#endif
