#import <UIKit/UIKit.h>
#import "CSListCornerConfiguration.h"
#import "CSListCornerSectionPolicy.h"
#import "CSListCornerPageContext.h"
#import "CSListCornerSessionAdapter.h"
#import "CSListCornerContactsAdapter.h"
#import "CSListCornerDiscoverAdapter.h"
#import "CSListCornerMoreAdapter.h"

static UIView *CSListCornerSectionView(id owner, UITableView *table, UIView *original, NSInteger section, CSListCornerPage page, BOOL footer) {
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    if (!configuration.enabled || !CSListCornerOwnsTable(owner,table,page)) return original;
    if (CSListCornerHidesSection(page,section)) return nil;
    if (page==CSListCornerPageContacts) {
        CSListCornerContactsDecorateSection(original,table,owner);
        return original;
    }
    CGFloat height=footer ? 0 : CSListCornerSectionGap(page,section,configuration.pinnedGap,configuration.normalGap);
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0,0,table.bounds.size.width,height)];
    view.userInteractionEnabled=NO;
    view.backgroundColor=footer ? CSListCornerCanvasColor() : [UIColor clearColor];
    if (!footer && page==CSListCornerPageSession) {
        UIUserInterfaceStyle style=table.traitCollection.userInterfaceStyle;
        view.backgroundColor=section==0 ? [configuration pinnedColorForStyle:style] : (section==1 || section==2 ? [configuration normalColorForStyle:style] : [UIColor clearColor]);
    }
    return view;
}

%hook MainFrameItemView
- (void)setFrame:(CGRect)frame {
    frame=CSListCornerSessionItemFrame((UIView *)self,frame);
    %orig(frame);
}
%end
%hook FakeMainFrameItemView
- (void)setFrame:(CGRect)frame {
    frame=CSListCornerSessionItemFrame((UIView *)self,frame);
    %orig(frame);
}
%end
%hook NewContactsItemCell
- (void)layoutSubviews {
    %orig;
    UITableViewCell *cell=(UITableViewCell *)self;
    UITableView *table=CSListCornerTableForView(cell);
    CSListCornerContactsDecorate(cell,table,nil,nil);
}
%end
%hook MMTableViewCell
- (void)layoutSubviews {
    %orig;
    UITableViewCell *cell=(UITableViewCell *)self;
    UITableView *table=CSListCornerTableForView(cell);
    CSListCornerDiscoverDecorate(cell,table,nil,nil);
    CSListCornerRepairCellSeparators(cell,table);
}
%end
%hook MMTableSectionHeaderView
- (void)layoutSubviews {
    %orig;
    UIView *view=(UIView *)self;
    CSListCornerContactsDecorateSection(view,CSListCornerTableForView(view),nil);
}
%end
%hook MMUIButton
- (void)setFrame:(CGRect)frame {
    CGRect target=CSListCornerMoreHeaderFrame((UIView *)self,frame);
    %orig(target);
    if (!CGRectEqualToRect(target,frame)) [(UIView *)self setNeedsLayout];
    CSListCornerMoreDecorateHeader((UIView *)self);
}
- (void)layoutSubviews {
    %orig;
    CSListCornerMoreDecorateHeader((UIView *)self);
}
%end

%hook ContactsViewController
- (void)initCountLabel:(id)arg1 {
    %orig;
    if (CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageContacts)) CSListCornerContactsDecorateCountFooter(self);
}
- (void)viewDidLayoutSubviews {
    %orig;
    CSListCornerContactsDecorateCountFooter(self);
}
- (void)viewDidLoad {
    %orig;
    CSListCornerPrepareTable(self,CSListCornerPageContacts,YES);
    CSListCornerContactsDecorateCountFooter(self);
}
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    CSListCornerPrepareTable(self,CSListCornerPageContacts,NO);
    CSListCornerContactsDecorateCountFooter(self);
}
- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerHeaderHeight(CSListCornerPageContacts,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageContacts),originalHeight,arg2,configuration.pinnedGap,configuration.normalGap);
}
- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageContacts,NO);
}
- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerFooterHeight(CSListCornerPageContacts,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageContacts),originalHeight);
}
- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageContacts,YES);
}
%end

%hook FindFriendEntryViewController
- (void)viewDidLoad {
    %orig;
    CSListCornerPrepareTable(self,CSListCornerPageDiscover,YES);
}
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    CSListCornerPrepareTable(self,CSListCornerPageDiscover,NO);
    // Retain the established one-shot appearance refresh until device evidence proves it unnecessary.
    UITableView *table=CSListCornerOwnedTable(self,CSListCornerPageDiscover);
    if ([[CSListCornerConfiguration sharedConfiguration] snapshot].enabled && table) {
        dispatch_async(dispatch_get_main_queue(), ^{ [table reloadData]; });
    }
}
- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerHeaderHeight(CSListCornerPageDiscover,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageDiscover),originalHeight,arg2,configuration.pinnedGap,configuration.normalGap);
}
- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageDiscover,NO);
}
- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerFooterHeight(CSListCornerPageDiscover,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageDiscover),originalHeight);
}
- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageDiscover,YES);
}
%end

%hook NewMainFrameViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    CSListCornerPrepareTable(self,CSListCornerPageSession,YES);
}
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    UITableViewCell *cell=%orig;
    CSListCornerSessionDecorate(cell,(UITableView *)arg1,(NSIndexPath *)arg2,self);
    return cell;
}
- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3 {
    %orig;
    CSListCornerSessionDecorate((UITableViewCell *)arg2,(UITableView *)arg1,(NSIndexPath *)arg3,self);
}
- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerHeaderHeight(CSListCornerPageSession,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageSession),originalHeight,arg2,configuration.pinnedGap,configuration.normalGap);
}
- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageSession,NO);
}
- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerFooterHeight(CSListCornerPageSession,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageSession),originalHeight);
}
- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageSession,YES);
}
%end

%hook MoreViewController
- (void)viewDidLoad {
    %orig;
    CSListCornerPrepareTable(self,CSListCornerPageMore,YES);
}
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    CSListCornerPrepareTable(self,CSListCornerPageMore,NO);
}
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    UITableViewCell *cell=%orig;
    CSListCornerMoreDecorate(cell,(UITableView *)arg1,(NSIndexPath *)arg2,self);
    return cell;
}
- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3 {
    %orig;
    CSListCornerMoreDecorate((UITableViewCell *)arg2,(UITableView *)arg1,(NSIndexPath *)arg3,self);
}
- (CGFloat)tableView:(id)arg1 heightForHeaderInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerHeaderHeight(CSListCornerPageMore,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageMore),originalHeight,arg2,configuration.pinnedGap,configuration.normalGap);
}
- (UIView *)tableView:(id)arg1 viewForHeaderInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageMore,NO);
}
- (CGFloat)tableView:(id)arg1 heightForFooterInSection:(NSInteger)arg2 {
    CGFloat originalHeight=%orig;
    CSListCornerSnapshot *configuration=[[CSListCornerConfiguration sharedConfiguration] snapshot];
    return CSListCornerFooterHeight(CSListCornerPageMore,configuration.enabled && CSListCornerOwnsTable(self,(UITableView *)arg1,CSListCornerPageMore),originalHeight);
}
- (UIView *)tableView:(id)arg1 viewForFooterInSection:(NSInteger)arg2 {
    UIView *originalView=%orig;
    return CSListCornerSectionView(self,(UITableView *)arg1,originalView,arg2,CSListCornerPageMore,YES);
}
%end

%hook WCTableViewManager
- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3 {
    %orig;
    CSListCornerMoreDecorate((UITableViewCell *)arg2,(UITableView *)arg1,(NSIndexPath *)arg3,nil);
}
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    UITableViewCell *cell=%orig;
    CSListCornerMoreDecorate(cell,(UITableView *)arg1,(NSIndexPath *)arg2,nil);
    return cell;
}
%end
