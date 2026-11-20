#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Four homepage categories and a search field sharing one vertical row.
@interface CSSettingsTabBar : UIView
@property(nonatomic) NSUInteger selectedIndex;
@property(nonatomic) CGFloat horizontalInset;
@property(nonatomic, readonly, getter=isSearching) BOOL searching;
@property(nonatomic, copy, nullable) void (^selectionChanged)(NSUInteger index);
@property(nonatomic, copy, nullable) void (^searchOpened)(void);
@property(nonatomic, copy, nullable) void (^queryChanged)(NSString *query);
@property(nonatomic, copy, nullable) void (^searchClosed)(void);
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSearching:(BOOL)searching animated:(BOOL)animated;
/// Account/lifecycle reset: clears the field and dismisses its keyboard without callbacks.
- (void)resetSearch;
- (void)reloadTheme;
@end

NS_ASSUME_NONNULL_END
