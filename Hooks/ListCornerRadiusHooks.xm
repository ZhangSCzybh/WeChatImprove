#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "../HeadersFile/NewMainFrameViewController.h"

#import "CSGroupListAdapter.h"
#import "CSListCornerRenderer.h"

static NSString * const kListCornerRadiusEnabledKey = @"com.wechat.enhance.list_corner_radius.enabled";
static NSString * const kListCornerRadiusKey = @"com.wechat.enhance.list_corner_radius.radius";
static NSString * const kListLeftMarginKey = @"com.wechat.enhance.list_corner_radius.left_margin";
static NSString * const kListRightMarginKey = @"com.wechat.enhance.list_corner_radius.right_margin";
static NSString * const kListTopSessionTopMarginKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin";
static NSString * const kListNormalSessionTopMarginKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin";

static NSString * const kListLightModeBgColorRedKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.red";
static NSString * const kListLightModeBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.green";
static NSString * const kListLightModeBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.blue";
static NSString * const kListLightModeBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.light_bg_color.alpha";

static NSString * const kListDarkModeBgColorRedKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.red";
static NSString * const kListDarkModeBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.green";
static NSString * const kListDarkModeBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.blue";
static NSString * const kListDarkModeBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.dark_bg_color.alpha";

static NSString * const kTopSessionTopMarginLightBgColorRedKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.red";
static NSString * const kTopSessionTopMarginLightBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.green";
static NSString * const kTopSessionTopMarginLightBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.blue";
static NSString * const kTopSessionTopMarginLightBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_light_bg_color.alpha";

static NSString * const kTopSessionTopMarginDarkBgColorRedKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.red";
static NSString * const kTopSessionTopMarginDarkBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.green";
static NSString * const kTopSessionTopMarginDarkBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.blue";
static NSString * const kTopSessionTopMarginDarkBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.top_session_top_margin_dark_bg_color.alpha";

static NSString * const kNormalSessionTopMarginLightBgColorRedKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.red";
static NSString * const kNormalSessionTopMarginLightBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.green";
static NSString * const kNormalSessionTopMarginLightBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.blue";
static NSString * const kNormalSessionTopMarginLightBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_light_bg_color.alpha";

static NSString * const kNormalSessionTopMarginDarkBgColorRedKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.red";
static NSString * const kNormalSessionTopMarginDarkBgColorGreenKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.green";
static NSString * const kNormalSessionTopMarginDarkBgColorBlueKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.blue";
static NSString * const kNormalSessionTopMarginDarkBgColorAlphaKey = @"com.wechat.enhance.list_corner_radius.normal_session_top_margin_dark_bg_color.alpha";

static BOOL isEnabled() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kListCornerRadiusEnabledKey];
}

static CGFloat getCornerRadius() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [defaults floatForKey:kListCornerRadiusKey];
    return radius > 0 ? radius : 10.0;
}

static CGFloat getLeftMargin() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat margin = [defaults floatForKey:kListLeftMarginKey];
    return margin > 0 ? margin : 15.0;
}

static CGFloat getRightMargin() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat margin = [defaults floatForKey:kListRightMarginKey];
    return margin > 0 ? margin : 15.0;
}

static CGFloat getTopSessionTopMargin() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:kListTopSessionTopMarginKey] != nil) {
        return [defaults floatForKey:kListTopSessionTopMarginKey];
    }
    return 10.0;
}

static CGFloat getNormalSessionTopMargin() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:kListNormalSessionTopMarginKey] != nil) {
        return [defaults floatForKey:kListNormalSessionTopMarginKey];
    }
    return 10.0;
}

static UIColor *getBackgroundColor() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isDarkMode = NO;
    if (@available(iOS 13.0, *)) {
        isDarkMode = [UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    
    NSString *redKey = isDarkMode ? kListDarkModeBgColorRedKey : kListLightModeBgColorRedKey;
    NSString *greenKey = isDarkMode ? kListDarkModeBgColorGreenKey : kListLightModeBgColorGreenKey;
    NSString *blueKey = isDarkMode ? kListDarkModeBgColorBlueKey : kListLightModeBgColorBlueKey;
    NSString *alphaKey = isDarkMode ? kListDarkModeBgColorAlphaKey : kListLightModeBgColorAlphaKey;
    
    CGFloat red = [defaults floatForKey:redKey];
    CGFloat green = [defaults floatForKey:greenKey];
    CGFloat blue = [defaults floatForKey:blueKey];
    CGFloat alpha = [defaults floatForKey:alphaKey];
    
    if (red == 0 && green == 0 && blue == 0 && alpha == 0) {
        return isDarkMode ? [UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:1.0] : [UIColor whiteColor];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

static UIColor *getTopSessionTopMarginBgColor() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isDarkMode = NO;
    if (@available(iOS 13.0, *)) {
        isDarkMode = [UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    
    NSString *redKey = isDarkMode ? kTopSessionTopMarginDarkBgColorRedKey : kTopSessionTopMarginLightBgColorRedKey;
    NSString *greenKey = isDarkMode ? kTopSessionTopMarginDarkBgColorGreenKey : kTopSessionTopMarginLightBgColorGreenKey;
    NSString *blueKey = isDarkMode ? kTopSessionTopMarginDarkBgColorBlueKey : kTopSessionTopMarginLightBgColorBlueKey;
    NSString *alphaKey = isDarkMode ? kTopSessionTopMarginDarkBgColorAlphaKey : kTopSessionTopMarginLightBgColorAlphaKey;
    
    CGFloat red = [defaults floatForKey:redKey];
    CGFloat green = [defaults floatForKey:greenKey];
    CGFloat blue = [defaults floatForKey:blueKey];
    CGFloat alpha = [defaults floatForKey:alphaKey];
    
    if (red == 0 && green == 0 && blue == 0 && alpha == 0) {
        return [UIColor clearColor];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

static UIColor *getNormalSessionTopMarginBgColor() {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isDarkMode = NO;
    if (@available(iOS 13.0, *)) {
        isDarkMode = [UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    
    NSString *redKey = isDarkMode ? kNormalSessionTopMarginDarkBgColorRedKey : kNormalSessionTopMarginLightBgColorRedKey;
    NSString *greenKey = isDarkMode ? kNormalSessionTopMarginDarkBgColorGreenKey : kNormalSessionTopMarginLightBgColorGreenKey;
    NSString *blueKey = isDarkMode ? kNormalSessionTopMarginDarkBgColorBlueKey : kNormalSessionTopMarginLightBgColorBlueKey;
    NSString *alphaKey = isDarkMode ? kNormalSessionTopMarginDarkBgColorAlphaKey : kNormalSessionTopMarginLightBgColorAlphaKey;
    
    CGFloat red = [defaults floatForKey:redKey];
    CGFloat green = [defaults floatForKey:greenKey];
    CGFloat blue = [defaults floatForKey:blueKey];
    CGFloat alpha = [defaults floatForKey:alphaKey];
    
    if (red == 0 && green == 0 && blue == 0 && alpha == 0) {
        return [UIColor clearColor];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

static void setBackgroundColorIfNeeded(UIView *view, UIColor *color) {
    if (![view.backgroundColor isEqual:color]) view.backgroundColor = color;
}

static void hideCellSeparator(UITableViewCell *cell) {
    UIEdgeInsets inset = UIEdgeInsetsMake(0, cell.superview.bounds.size.width, 0, 0);
    if (!UIEdgeInsetsEqualToEdgeInsets(cell.separatorInset, inset)) cell.separatorInset = inset;
    if (!UIEdgeInsetsEqualToEdgeInsets(cell.layoutMargins, UIEdgeInsetsZero)) cell.layoutMargins = UIEdgeInsetsZero;
    if (cell.preservesSuperviewLayoutMargins) cell.preservesSuperviewLayoutMargins = NO;

    // Still inspect actual subviews: native cell reuse can recreate or reset a separator.
    for (UIView *subview in cell.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")] ||
            [NSStringFromClass([subview class]) containsString:@"Separator"]) {
            if (!subview.hidden) subview.hidden = YES;
            if (subview.alpha != 0) subview.alpha = 0;
        }
    }
}

%hook MainFrameItemView

- (void)setFrame:(CGRect)frame {
    if (isEnabled()) {
        UIView *selfView = (UIView *)self;
        UITableView *tableView = nil;
        UIView *parentView = selfView.superview;
        while (parentView) {
            if ([parentView isKindOfClass:[UITableView class]]) {
                tableView = (UITableView *)parentView;
                break;
            }
            parentView = parentView.superview;
        }
        
        if (tableView && frame.origin.x != getLeftMargin()) {
            CGFloat leftMargin = getLeftMargin();
            CGFloat rightMargin = getRightMargin();
            
            frame.origin.x = leftMargin;
            frame.size.width = tableView.bounds.size.width - leftMargin - rightMargin;
        }
    }
    
    %orig(frame);
}

%end

#pragma mark - NewContactsItemCell (通讯录页面 Cell)

%hook NewContactsItemCell

- (void)layoutSubviews {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    UITableViewCell *cell = (UITableViewCell *)self;
    UITableView *tableView = (UITableView *)cell.superview;
    
    if (![tableView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    UIViewController *viewController = nil;
    UIView *parentView = tableView.superview;
    while (parentView) {
        if ([parentView.nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)parentView.nextResponder;
            break;
        }
        parentView = parentView.superview;
    }
    
    if (!viewController || ![NSStringFromClass([viewController class]) isEqualToString:@"ContactsViewController"]) {
        return;
    }
    
    CGFloat cornerRadius = getCornerRadius();
    CGFloat leftMargin = getLeftMargin();
    CGFloat rightMargin = getRightMargin();
    
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    if (!indexPath) {
        return;
    }
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger numberOfRowsInSection = [tableView numberOfRowsInSection:section];

    BOOL isFirstRow = (row == 0);
    BOOL isLastRow = (row == numberOfRowsInSection - 1);

    BOOL isTopSection = (section >= 0 && section <= 3);

    if (isTopSection) {
        NSInteger totalRowsInTopSections = 0;
        for (NSInteger s = 0; s <= 3; s++) {
            totalRowsInTopSections += [tableView numberOfRowsInSection:s];
        }

        NSInteger absoluteRow = 0;
        for (NSInteger s = 0; s < section; s++) {
            absoluteRow += [tableView numberOfRowsInSection:s];
        }
        absoluteRow += row;

        isFirstRow = (absoluteRow == 0);
        isLastRow = (absoluteRow == totalRowsInTopSections - 1);
    }

    setBackgroundColorIfNeeded(cell, [UIColor clearColor]);
    setBackgroundColorIfNeeded(cell.contentView, [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0]);

    for (UIView *subview in cell.subviews) {
        NSString *className = NSStringFromClass([subview class]);

        if ([className containsString:@"Separator"] || [className containsString:@"Line"]) {
            subview.hidden = YES;
            subview.alpha = 0;
        }

        if ([className isEqualToString:@"UIView"] && subview.frame.size.height < 1.0) {
            subview.hidden = YES;
            subview.alpha = 0;
        }
    }

    hideCellSeparator(cell);

    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIView class]] && subview.tag != 9996) {
            setBackgroundColorIfNeeded(subview, [UIColor clearColor]);
        }
    }
    
    UIView *bgView = [cell.contentView viewWithTag:9996];
    if (!bgView) {
        bgView = [[UIView alloc] init];
        bgView.tag = 9996;
        [cell.contentView insertSubview:bgView atIndex:0];
    }
    
    CGFloat bgWidth = tableView.bounds.size.width - leftMargin - rightMargin;
    CGRect bgFrame = CGRectMake(leftMargin, 0, bgWidth, cell.bounds.size.height);
    CSListApplyCardBackground(bgView, bgFrame, cornerRadius, isFirstRow, isLastRow, getBackgroundColor());
    
    for (UIView *subview in cell.contentView.subviews) {
        if (subview.tag == 9996) continue;
        
        NSString *className = NSStringFromClass([subview class]);
        
        if (![className containsString:@"UITableViewCellContentView"]) {
            CGRect frame = subview.frame;
            
            if ([className containsString:@"ContactsItemView"]) {
                frame.origin.x = leftMargin;
                frame.size.width = bgWidth;
            } else if ([className isEqualToString:@"UIView"]) {
                for (UIView *subSubview in subview.subviews) {
                    NSString *subClassName = NSStringFromClass([subSubview class]);
                    if ([subClassName containsString:@"ContactsItemView"]) {
                        CGRect subFrame = subSubview.frame;
                        subFrame.origin.x = leftMargin;
                        subFrame.size.width = bgWidth;
                        subSubview.frame = subFrame;
                    }
                }
            } else if ([className containsString:@"UIImageView"]) {
                if (frame.origin.x > tableView.bounds.size.width / 2) {
                    frame.origin.x = leftMargin + bgWidth - 16 - frame.size.width;
                } else {
                    frame.origin.x = leftMargin + 16;
                }
            } else if ([className containsString:@"UILabel"]) {
                frame.origin.x = leftMargin + 16 + 24 + 12;
                frame.size.width = bgWidth - 16 - 24 - 12 - 16;
            }
            
            subview.frame = frame;
        }
    }
}

%end

#pragma mark - ContactsViewController (通讯录页面)

%hook ContactsViewController

- (void)viewDidLoad {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    Ivar tableViewIvar = class_getInstanceVariable(object_getClass(self), "m_tableView");
    if (tableViewIvar) {
        UITableView *tableView = object_getIvar(self, tableViewIvar);
        
        if (tableView) {
            tableView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            
            if (tableView.backgroundView) {
                tableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            }
            
            tableView.showsVerticalScrollIndicator = NO;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            tableView.sectionHeaderHeight = 0;
            tableView.sectionFooterHeight = 0;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    Ivar tableViewIvar = class_getInstanceVariable(object_getClass(self), "m_tableView");
    if (tableViewIvar) {
        UITableView *tableView = object_getIvar(self, tableViewIvar);
        
        if (tableView) {
            tableView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
        }
    }
}

- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) return originalHeight;
    
    if (arg2 >= 0 && arg2 <= 3) {
        return 0;
    }
    
    return originalHeight + 10.0;
}

- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    if (arg2 >= 0 && arg2 <= 3) {
        return nil;
    }
    
    if (originalView) {
        originalView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
        
        for (UIView *subview in originalView.subviews) {
            NSString *className = NSStringFromClass([subview class]);
            
            if ([className containsString:@"Separator"] || [className containsString:@"Line"]) {
                subview.hidden = YES;
                subview.alpha = 0;
            } else {
                subview.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            }
            
            if ([className isEqualToString:@"UIView"] && subview.frame.size.height < 1.0) {
                subview.hidden = YES;
                subview.alpha = 0;
            }
        }
    }
    
    return originalView;
}

- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) {
        return originalHeight;
    }
    
    if (arg2 >= 0 && arg2 <= 3) {
        return 0;
    }
    
    return 0;
}

- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    if (arg2 >= 0 && arg2 <= 3) {
        return nil;
    }
    
    if (originalView) {
        originalView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
        
        for (UIView *subview in originalView.subviews) {
            NSString *className = NSStringFromClass([subview class]);
            
            if ([className containsString:@"Separator"] || [className containsString:@"Line"]) {
                subview.hidden = YES;
                subview.alpha = 0;
            } else {
                subview.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            }
            
            if ([className isEqualToString:@"UIView"] && subview.frame.size.height < 1.0) {
                subview.hidden = YES;
                subview.alpha = 0;
            }
        }
    }
    
    return originalView;
}

%end

#pragma mark - MMTableViewCell (发现页面 Cell)

%hook MMTableViewCell

- (void)layoutSubviews {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    UITableViewCell *cell = (UITableViewCell *)self;
    UITableView *tableView = (UITableView *)cell.superview;
    
    if (![tableView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    UIViewController *viewController = nil;
    UIView *parentView = tableView.superview;
    while (parentView) {
        if ([parentView.nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)parentView.nextResponder;
            break;
        }
        parentView = parentView.superview;
    }
    
    if (!viewController || ![NSStringFromClass([viewController class]) isEqualToString:@"FindFriendEntryViewController"]) {
        return;
    }
    
    CGFloat cornerRadius = getCornerRadius();
    CGFloat leftMargin = getLeftMargin();
    CGFloat rightMargin = getRightMargin();
    
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    if (!indexPath) {
        return;
    }
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger numberOfRowsInSection = [tableView numberOfRowsInSection:section];
    
    BOOL isFirstRow = (row == 0);
    BOOL isLastRow = (row == numberOfRowsInSection - 1);
    
    setBackgroundColorIfNeeded(cell, [UIColor clearColor]);
    setBackgroundColorIfNeeded(cell.contentView, [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0]);
    
    hideCellSeparator(cell);
    
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIView class]] && subview.tag != 9997) {
            setBackgroundColorIfNeeded(subview, [UIColor clearColor]);
        }
    }
    
    UIView *bgView = [cell.contentView viewWithTag:9997];
    if (!bgView) {
        bgView = [[UIView alloc] init];
        bgView.tag = 9997;
        [cell.contentView insertSubview:bgView atIndex:0];
    }
    
    CGFloat bgWidth = tableView.bounds.size.width - leftMargin - rightMargin;
    CGRect bgFrame = CGRectMake(leftMargin, 0, bgWidth, cell.bounds.size.height);
    CSListApplyCardBackground(bgView, bgFrame, cornerRadius, isFirstRow, isLastRow, getBackgroundColor());

    CGFloat labelY = 0;
    CGFloat labelHeight = 20.0;
    CGFloat labelOriginalRightEdge = 0;
    
    for (UIView *subview in cell.contentView.subviews) {
        if (subview.tag == 9997) continue;
        
        NSString *className = NSStringFromClass([subview class]);
        CGRect frame = subview.frame;
        
        if ([className containsString:@"UILabel"]) {
            labelOriginalRightEdge = frame.origin.x + frame.size.width;
            labelY = frame.origin.y;
            labelHeight = frame.size.height;
        }
    }
    
    for (UIView *subview in cell.contentView.subviews) {
        if (subview.tag == 9997) continue;
        
        NSString *className = NSStringFromClass([subview class]);
        
        if (![className containsString:@"UITableViewCellContentView"]) {
            CGRect frame = subview.frame;
            CGFloat originalX = frame.origin.x;
            
            if ([className containsString:@"MMBadgeView"] && labelOriginalRightEdge > 0) {
                CGFloat originalBadgeSpacing = frame.origin.x - labelOriginalRightEdge;
                CGFloat adjustedX = leftMargin + (labelOriginalRightEdge - 16) + originalBadgeSpacing;
                
                frame.origin.x = adjustedX;
                frame.origin.y = labelY + (labelHeight - frame.size.height) / 2.0;
                subview.frame = frame;
                continue;
            }
            
            if ([className isEqualToString:@"UIView"]) {
                
                CGFloat iconWidth = 24;
                CGFloat iconSpacing = 12;
                
                for (UIView *subSubview in subview.subviews) {
                    NSString *subClassName = NSStringFromClass([subSubview class]);
                    CGRect subFrame = subSubview.frame;
                    
                    if ([subClassName containsString:@"UIImageView"]) {
                        iconWidth = subFrame.size.width;
                    }
                }
                
                for (UIView *subSubview in subview.subviews) {
                    NSString *subClassName = NSStringFromClass([subSubview class]);
                    CGRect subFrame = subSubview.frame;
                    
                    CGFloat absoluteCenterX = originalX + subFrame.origin.x + subFrame.size.width / 2;
                    CGFloat bgCenterX = leftMargin + bgWidth / 2;
                    
                    if ([subClassName containsString:@"UIImageView"]) {
                        if (absoluteCenterX > bgCenterX) {
                            subFrame.origin.x = bgWidth - rightMargin - subFrame.size.width;
                        } else {
                            subFrame.origin.x = leftMargin;
                        }
                    } else if ([subClassName containsString:@"UILabel"]) {
                        subFrame.origin.x = leftMargin + iconWidth + iconSpacing;
                        subFrame.size.width = bgWidth - iconWidth - iconSpacing - rightMargin;
                    } else if ([subClassName containsString:@"RichTextView"] || 
                               [subClassName containsString:@"WCFinderRedDotRichTextView"]) {
                        if (absoluteCenterX > bgCenterX) {
                            subFrame.origin.x = bgWidth - rightMargin - subFrame.size.width;
                        } else {
                            subFrame.origin.x = leftMargin + iconWidth + iconSpacing;
                            subFrame.size.width = bgWidth - iconWidth - iconSpacing - rightMargin;
                        }
                    }
                    
                    subSubview.frame = subFrame;
                }
                
                frame.origin.x = leftMargin;
                frame.size.width = bgWidth;
            } else if ([className containsString:@"UIImageView"]) {
                if (frame.origin.x > tableView.bounds.size.width / 2) {
                    frame.origin.x = leftMargin + bgWidth - 16 - frame.size.width;
                } else {
                    frame.origin.x = leftMargin + 16;
                }
            } else if ([className containsString:@"UILabel"]) {
                frame.origin.x = leftMargin + 16 + 24 + 12;
                frame.size.width = bgWidth - 16 - 24 - 12 - 16;
            }
            
            subview.frame = frame;
        }
    }
}

%end

#pragma mark - FindFriendEntryViewController (发现页面)

%hook FindFriendEntryViewController

- (void)viewDidLoad {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    Ivar tableViewIvar = class_getInstanceVariable(object_getClass(self), "m_tableView");
    if (tableViewIvar) {
        UITableView *tableView = object_getIvar(self, tableViewIvar);
        
        if (tableView) {
            tableView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            
            if (tableView.backgroundView) {
                tableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            }
            
            tableView.showsVerticalScrollIndicator = NO;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    Ivar tableViewIvar = class_getInstanceVariable(object_getClass(self), "m_tableView");
    if (tableViewIvar) {
        UITableView *tableView = object_getIvar(self, tableViewIvar);
        
        if (tableView) {
            tableView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadData];
            });
        }
    }
}

- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) return originalHeight;
    
    return originalHeight + 10.0;
}

- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    if (originalView) {
        for (UIView *subview in originalView.subviews) {
            if ([NSStringFromClass([subview class]) containsString:@"Separator"] ||
                [NSStringFromClass([subview class]) containsString:@"Line"] ||
                [subview isKindOfClass:[UIView class]]) {
                subview.hidden = YES;
                subview.alpha = 0;
            }
        }
    }
    
    UITableView *tableView = (UITableView *)arg1;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10.0)];
    headerView.backgroundColor = [UIColor clearColor];
    
    return headerView;
}

- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) {
        return originalHeight;
    }
    
    return 0.01;
}

- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
    return footerView;
}

%end

%hook FakeMainFrameItemView

- (void)setFrame:(CGRect)frame {
    if (isEnabled()) {
        UIView *selfView = (UIView *)self;
        UITableView *tableView = nil;
        UIView *parentView = selfView.superview;
        while (parentView) {
            if ([parentView isKindOfClass:[UITableView class]]) {
                tableView = (UITableView *)parentView;
                break;
            }
            parentView = parentView.superview;
        }
        
        if (tableView && frame.origin.x != getLeftMargin()) {
            CGFloat leftMargin = getLeftMargin();
            CGFloat rightMargin = getRightMargin();
            
            frame.origin.x = leftMargin;
            frame.size.width = tableView.bounds.size.width - leftMargin - rightMargin;
        }
    }
    
    %orig(frame);
}

%end

static void styleCell(UITableViewCell *cell, UITableView *tableView, NSIndexPath *indexPath) {
    if (!isEnabled() || !cell || !tableView || !indexPath) {
        return;
    }
    
    CGFloat cornerRadius = getCornerRadius();
    CGFloat leftMargin = getLeftMargin();
    CGFloat rightMargin = getRightMargin();
    
    BOOL isFirstRow = NO;
    BOOL isLastRow = NO;
    if (!CSGroupCardPosition(tableView, indexPath, &isFirstRow, &isLastRow)) {
        NSInteger numberOfRowsInSection = [tableView numberOfRowsInSection:indexPath.section];
        isFirstRow = indexPath.row == 0;
        isLastRow = indexPath.row == numberOfRowsInSection - 1;
    }
    
    for (UIView *subview in cell.contentView.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        
        if ([className isEqualToString:@"MFBannerBtn"] || [className isEqualToString:@"MFWebMMBtn"]) {
            CGRect frame = subview.frame;
            frame.origin.x = leftMargin;
            frame.size.width = tableView.bounds.size.width - leftMargin - rightMargin;
            subview.frame = frame;
        }
    }
    
    setBackgroundColorIfNeeded(cell, [UIColor clearColor]);
    setBackgroundColorIfNeeded(cell.contentView, [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0]);
    
    hideCellSeparator(cell);
    
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIView class]] && subview.tag != 9999) {
            setBackgroundColorIfNeeded(subview, [UIColor clearColor]);
        }
    }
    
    UIView *bgView = [cell.contentView viewWithTag:9999];
    if (!bgView) {
        bgView = [[UIView alloc] init];
        bgView.tag = 9999;
        [cell.contentView insertSubview:bgView atIndex:0];
    }
    
    CGFloat bgWidth = tableView.bounds.size.width - leftMargin - rightMargin;
    CGRect bgFrame = CGRectMake(leftMargin, 0, bgWidth, cell.bounds.size.height);
    CSListApplyCardBackground(bgView, bgFrame, cornerRadius, isFirstRow, isLastRow, getBackgroundColor());
}

%hook NewMainFrameViewController

- (void)viewDidAppear:(BOOL)animated {
    %orig;
    
    Ivar tableViewIvar = class_getInstanceVariable(object_getClass(self), "m_tableView");
    if (tableViewIvar) {
        UITableView *tableView = object_getIvar(self, tableViewIvar);
        
        if (tableView) {
            tableView.backgroundColor = getBackgroundColor();
            
            if (tableView.backgroundView) {
                tableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            }
            
            tableView.showsVerticalScrollIndicator = NO;
        }
    }
}

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    UITableViewCell *cell = %orig;
    
    UITableView *tableView = (UITableView *)arg1;
    NSIndexPath *indexPath = (NSIndexPath *)arg2;
    
    styleCell(cell, tableView, indexPath);
    
    return cell;
}

- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3 {
    %orig;
    
    UITableViewCell *cell = (UITableViewCell *)arg2;
    UITableView *tableView = (UITableView *)arg1;
    NSIndexPath *indexPath = (NSIndexPath *)arg3;
    
    styleCell(cell, tableView, indexPath);
}

- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) return originalHeight;
    
    if (arg2 == 0) {
        return originalHeight + getTopSessionTopMargin();
    } else if (arg2 == 1) {
        return originalHeight + getNormalSessionTopMargin();
    } else if (arg2 == 2) {
        return originalHeight + getNormalSessionTopMargin();
    }
    
    return originalHeight;
}

- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    if (originalView) {
        for (UIView *subview in originalView.subviews) {
            NSString *className = NSStringFromClass([subview class]);
            
            if ([className containsString:@"Separator"] || [className containsString:@"Line"]) {
                subview.hidden = YES;
                subview.alpha = 0;
            }
        }
    }
    
    UITableView *tableView = (UITableView *)arg1;
    CGFloat headerHeight = 0.0;
    UIColor *headerBgColor = [UIColor clearColor];
    if (arg2 == 0) {
        headerHeight = getTopSessionTopMargin();
        headerBgColor = getTopSessionTopMarginBgColor();
    } else if (arg2 == 1 || arg2 == 2) {
        headerHeight = getNormalSessionTopMargin();
        headerBgColor = getNormalSessionTopMarginBgColor();
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, headerHeight)];
    headerView.backgroundColor = headerBgColor;
    
    return headerView;
}

- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) {
        return originalHeight;
    }
    
    return 0.01;
}

- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
    return footerView;
}

%end

#pragma mark - MoreViewController (我的页面)

static void styleMoreViewControllerCell(UITableViewCell *cell, UITableView *tableView, NSIndexPath *indexPath) {
    if (!isEnabled() || !cell || !tableView || !indexPath) {
        return;
    }
    
    CGFloat cornerRadius = getCornerRadius();
    CGFloat leftMargin = getLeftMargin();
    CGFloat rightMargin = getRightMargin();
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger numberOfRowsInSection = [tableView numberOfRowsInSection:section];
    
    BOOL isFirstRow = (row == 0);
    BOOL isLastRow = (row == numberOfRowsInSection - 1);
    
    setBackgroundColorIfNeeded(cell, [UIColor clearColor]);
    setBackgroundColorIfNeeded(cell.contentView, [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0]);
    
    for (UIView *subview in cell.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        
        if ([className containsString:@"Separator"] || [className containsString:@"Line"]) {
            subview.hidden = YES;
            subview.alpha = 0;
        }
        
        if ([className isEqualToString:@"UIView"] && subview.frame.size.height < 1.0) {
            subview.hidden = YES;
            subview.alpha = 0;
        }
    }
    
    hideCellSeparator(cell);
    
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UIView class]] && subview.tag != 9998) {
            setBackgroundColorIfNeeded(subview, [UIColor clearColor]);
        }
    }
    
    UIView *bgView = [cell.contentView viewWithTag:9998];
    if (!bgView) {
        bgView = [[UIView alloc] init];
        bgView.tag = 9998;
        [cell.contentView insertSubview:bgView atIndex:0];
    }
    
    CGFloat bgWidth = tableView.bounds.size.width - leftMargin - rightMargin;
    CGRect bgFrame = CGRectMake(leftMargin, 0, bgWidth, cell.bounds.size.height);
    CSListApplyCardBackground(bgView, bgFrame, cornerRadius, isFirstRow, isLastRow, getBackgroundColor());
    
    for (UIView *subview in cell.contentView.subviews) {
        if (subview.tag == 9998) continue;
        
        NSString *className = NSStringFromClass([subview class]);
        
        if (![className containsString:@"UITableViewCellContentView"]) {
            CGRect frame = subview.frame;
            
            if ([className isEqualToString:@"UIView"]) {
                frame.origin.x = leftMargin;
                frame.size.width = bgWidth;
            } else if ([className containsString:@"UIImageView"]) {
                if (frame.origin.x > tableView.bounds.size.width / 2) {
                    frame.origin.x = tableView.bounds.size.width - rightMargin - frame.size.width - 16;
                } else {
                    frame.origin.x = leftMargin + 16;
                }
            } else if ([className containsString:@"UILabel"]) {
                frame.origin.x = leftMargin + 16 + 24 + 12;
                frame.size.width = bgWidth - 16 - 24 - 12 - 16;
            }
            
            subview.frame = frame;
        }
    }
}

#pragma mark - MMUIButton (我的页面个人资料卡片)

%hook MMUIButton

- (void)setFrame:(CGRect)frame {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    UIView *view = (UIView *)self;
    UIView *superview = view.superview;
    if (superview && [superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)superview;
        if (tableView.tableHeaderView == view) {
            UIViewController *viewController = nil;
            UIView *parentView = tableView.superview;
            while (parentView) {
                if ([parentView.nextResponder isKindOfClass:[UIViewController class]]) {
                    viewController = (UIViewController *)parentView.nextResponder;
                    break;
                }
                parentView = parentView.superview;
            }
            
            if (viewController && [NSStringFromClass([viewController class]) isEqualToString:@"MoreViewController"]) {
                CGFloat leftMargin = getLeftMargin();
                CGFloat rightMargin = getRightMargin();
                CGFloat cardWidth = [UIScreen mainScreen].bounds.size.width - leftMargin - rightMargin;
                
                if (frame.origin.x != leftMargin || frame.size.width != cardWidth) {
                    frame.origin.x = leftMargin;
                    frame.size.width = cardWidth;
                    
                    %orig(frame);
                    
                    view.layer.cornerRadius = getCornerRadius();
                    view.layer.masksToBounds = YES;
                    
                    static dispatch_once_t onceToken;
                    dispatch_once(&onceToken, ^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [view layoutSubviews];
                        });
                    });
                }
            }
        }
    }
}

- (void)layoutSubviews {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    UIView *view = (UIView *)self;
    UIView *superview = view.superview;
    if (superview && [superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)superview;
        if (tableView.tableHeaderView == view) {
            UIViewController *viewController = nil;
            UIView *parentView = tableView.superview;
            while (parentView) {
                if ([parentView.nextResponder isKindOfClass:[UIViewController class]]) {
                    viewController = (UIViewController *)parentView.nextResponder;
                    break;
                }
                parentView = parentView.superview;
            }
            
            if (viewController && [NSStringFromClass([viewController class]) isEqualToString:@"MoreViewController"]) {
    CGFloat leftMargin = getLeftMargin();
CGFloat rightMargin = getRightMargin();
CGFloat cardWidth = [UIScreen mainScreen].bounds.size.width - leftMargin - rightMargin;

CGFloat buttonX = 16 + 60 + 16;

for (UIView *subview in view.subviews) {
    CGRect subviewFrame = subview.frame;
    NSString *className = NSStringFromClass([subview class]);
    
    if ([className isEqualToString:@"UIView"] && subviewFrame.size.height < 1.0) {
        subview.hidden = YES;
        subview.alpha = 0;
        continue;
    }
    
    if ([className isEqualToString:@"MMHeadImageView"]) {
        subviewFrame.origin.x = 16;
    } else if ([className containsString:@"UIImageView"]) {
        if (subviewFrame.size.width < 20 && subviewFrame.size.height > 20) {
            subviewFrame.origin.x = cardWidth - 16 - subviewFrame.size.width;
        }
    } else if ([className isEqualToString:@"MMCPLabel"]) {
        subviewFrame.origin.x = 16 + 60 + 16;
        CGFloat rightSpace = 16 + 22 + 12 + 12;
        subviewFrame.size.width = cardWidth - 16 - 60 - 16 - rightSpace;
    } else if ([className isEqualToString:@"MMUILabel"]) {
        subviewFrame.origin.x = 16 + 60 + 16;
        CGFloat rightSpace = 16 + 20 + 30;
        subviewFrame.size.width = cardWidth - 16 - 60 - 16 - rightSpace;
    } else if ([className isEqualToString:@"TextStatePublishEntryButton"]) {
        subviewFrame.origin.x = buttonX;
        buttonX += subviewFrame.size.width + 8;
    } else if ([className isEqualToString:@"TextStateFriendTopicButton"]) {
        subviewFrame.origin.x = buttonX;
        buttonX += subviewFrame.size.width + 8;
    } else if ([className isEqualToString:@"MMUIButton"]) {
        if (subviewFrame.size.width < 30 && subviewFrame.size.height < 30) {
            subviewFrame.origin.x = cardWidth - 16 - 30 - 20;
        }
    } else if ([subview isKindOfClass:[UIView class]] && ![className containsString:@"Button"]) {
        subviewFrame.origin.x = 0;
        subviewFrame.size.width = cardWidth;
    }
    
    subview.frame = subviewFrame;
}
}
        }
    }
}

%end

%hook MoreViewController

- (void)viewDidLoad {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    Ivar tableViewIvar = class_getInstanceVariable(object_getClass(self), "_frontTableView");
    if (tableViewIvar) {
        UITableView *tableView = object_getIvar(self, tableViewIvar);
        
        if (tableView) {
            tableView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            
            if (tableView.backgroundView) {
                tableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
            }
            
            tableView.showsVerticalScrollIndicator = NO;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    Ivar tableViewIvar = class_getInstanceVariable(object_getClass(self), "_frontTableView");
    if (tableViewIvar) {
        UITableView *tableView = object_getIvar(self, tableViewIvar);
        
        if (tableView) {
            tableView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
        }
    }
}

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    UITableViewCell *cell = %orig;
    
    if (!isEnabled()) {
        return cell;
    }
    
    UITableView *tableView = (UITableView *)arg1;
    NSIndexPath *indexPath = (NSIndexPath *)arg2;
    
    styleMoreViewControllerCell(cell, tableView, indexPath);
    
    return cell;
}

- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3 {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    UITableViewCell *cell = (UITableViewCell *)arg2;
    UITableView *tableView = (UITableView *)arg1;
    NSIndexPath *indexPath = (NSIndexPath *)arg3;
    
    styleMoreViewControllerCell(cell, tableView, indexPath);
}

- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) return originalHeight;
    
    return originalHeight + 10.0;
}

- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    if (originalView) {
        for (UIView *subview in originalView.subviews) {
            if ([NSStringFromClass([subview class]) containsString:@"Separator"] ||
                [NSStringFromClass([subview class]) containsString:@"Line"]) {
                subview.hidden = YES;
                subview.alpha = 0;
            }
        }
    }
    
    UITableView *tableView = (UITableView *)arg1;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10.0)];
    headerView.backgroundColor = [UIColor clearColor];
    
    return headerView;
}

- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight = %orig;
    
    if (!isEnabled()) {
        return originalHeight;
    }
    
    return 0.01;
}

- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView = %orig;
    
    if (!isEnabled()) {
        return originalView;
    }
    
    if (originalView) {
        for (UIView *subview in originalView.subviews) {
            NSString *className = NSStringFromClass([subview class]);
            
            if ([className containsString:@"Separator"] || [className containsString:@"Line"]) {
                subview.hidden = YES;
                subview.alpha = 0;
            }
        }
    }
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1.0];
    return footerView;
}

%end

#pragma mark - WCTableViewManager (我的页面)

%hook WCTableViewManager

- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3 {
    %orig;
    
    if (!isEnabled()) {
        return;
    }
    
    UITableView *tableView = (UITableView *)arg1;
    UITableViewCell *cell = (UITableViewCell *)arg2;
    NSIndexPath *indexPath = (NSIndexPath *)arg3;
    
    UIViewController *viewController = nil;
    UIView *parentView = tableView.superview;
    while (parentView) {
        if ([parentView.nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)parentView.nextResponder;
            break;
        }
        parentView = parentView.superview;
    }
    
    if (viewController && [NSStringFromClass([viewController class]) isEqualToString:@"MoreViewController"]) {
        styleMoreViewControllerCell(cell, tableView, indexPath);
    }
}

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    UITableViewCell *cell = %orig;
    
    if (!isEnabled()) {
        return cell;
    }
    
    UITableView *tableView = (UITableView *)arg1;
    NSIndexPath *indexPath = (NSIndexPath *)arg2;
    
    UIViewController *viewController = nil;
    UIView *parentView = tableView.superview;
    while (parentView) {
        if ([parentView.nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)parentView.nextResponder;
            break;
        }
        parentView = parentView.superview;
    }
    
    if (viewController && [NSStringFromClass([viewController class]) isEqualToString:@"MoreViewController"]) {
        styleMoreViewControllerCell(cell, tableView, indexPath);
    }
    
    return cell;
}

%end
