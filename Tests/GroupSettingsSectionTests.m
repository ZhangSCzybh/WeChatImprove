#import <Foundation/Foundation.h>
#import "WESessionTabItem.h"

@interface NSIndexPath (TableRows)
@property(nonatomic,readonly) NSInteger section,row;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (TableRows)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};
    return [self indexPathWithIndexes:indexes length:2];
}
- (NSInteger)section { return (NSInteger)[self indexAtPosition:0]; }
- (NSInteger)row { return (NSInteger)[self indexAtPosition:1]; }
@end

@interface UITableView : NSObject
@property(nonatomic) NSUInteger deselections;
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated;
@end
@implementation UITableView
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated { (void)path;(void)animated;self.deselections++; }
@end
@interface UISwipeActionsConfiguration : NSObject @end
@implementation UISwipeActionsConfiguration @end
@interface CSSettingItem : NSObject
@property(nonatomic,copy) void (^actionBlock)(void);
@end
@implementation CSSettingItem @end
@interface CSSettingSection : NSObject
@property(nonatomic,strong) NSArray<CSSettingItem *> *items;
@end
@implementation CSSettingSection @end
@interface TestGroupPreferences : NSObject
@property(nonatomic,copy) NSString *accountID;
@end
@implementation TestGroupPreferences @end

@interface CSChatGroupSettingsViewController : NSObject
@property(nonatomic,strong) NSArray<CSSettingSection *> *sections;
@property(nonatomic,strong) CSSettingSection *groupSection;
@property(nonatomic,strong) TestGroupPreferences *groupPreferences;
@property(nonatomic,strong) NSMutableArray<NSString *> *tabOrder;
@property(nonatomic,strong) NSArray<WESessionTabItem *> *customTabs;
@property(nonatomic) BOOL accountChanged;
@property(nonatomic) NSUInteger setups,memberPicks;
@property(nonatomic,strong) WESessionTabItem *pickedTab;
- (BOOL)refreshAccountIfNeeded;
- (void)setupData;
- (void)showContactSelectForTab:(WESessionTabItem *)tab;
@end
@implementation CSChatGroupSettingsViewController
- (BOOL)refreshAccountIfNeeded { return self.accountChanged; }
- (void)setupData { self.setups++; }
- (void)showContactSelectForTab:(WESessionTabItem *)tab { self.memberPicks++;self.pickedTab=tab; }
#include "GroupSettingsSectionBodies.h"
@end

static NSUInteger checks;
static void Check(BOOL ok,NSString *message) {
    checks++;
    if (!ok) { fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1); }
}
static NSIndexPath *Path(NSInteger section,NSInteger row) { return [NSIndexPath indexPathForRow:row inSection:section]; }

int main(void) { @autoreleasepool {
    CSChatGroupSettingsViewController *vc=[CSChatGroupSettingsViewController new];
    vc.groupPreferences=[TestGroupPreferences new]; vc.groupPreferences.accountID=@"account-A";
    WESessionTabItem *custom=[WESessionTabItem customTabWithName:@"测试分组" sessionUserNames:@[@"member"]];
    custom.tabId=@"custom-A";vc.customTabs=@[custom];
    UITableView *table=[UITableView new];
    __block NSUInteger actions=0;
    for (NSNumber *position in @[@2,@4]) {
        NSInteger groupIndex=position.integerValue;
        vc.tabOrder=[@[@"preset_0",@"custom-A",@"preset_1"] mutableCopy];
        vc.groupSection=[CSSettingSection new];
        NSMutableArray *items=[NSMutableArray array];
        for (NSUInteger i=0;i<4;i++) { CSSettingItem *item=[CSSettingItem new];item.actionBlock=^{actions++;};[items addObject:item]; }
        vc.groupSection.items=items;
        NSMutableArray *sections=[NSMutableArray array];
        for (NSInteger i=0;i<7;i++) {
            CSSettingSection *section=[CSSettingSection new];section.items=@[[CSSettingItem new]];
            [sections addObject:i==groupIndex ? vc.groupSection : section];
        }
        vc.sections=sections;
        Check(![vc isGroupSectionAtIndex:-1] && ![vc isGroupSectionAtIndex:7],@"invalid sections are rejected");
        for (NSInteger i=0;i<7;i++) {
            BOOL group=i==groupIndex;
            Check([vc tableView:table canMoveRowAtIndexPath:Path(i,0)]==group,@"only actual group section permits sorting");
            Check([vc tableView:table canEditRowAtIndexPath:Path(i,0)]==group,@"only actual group section permits editing");
            Check(([vc tableView:table trailingSwipeActionsConfigurationForRowAtIndexPath:Path(i,0)]!=nil)==group,@"preview and setting sections cannot expose group swipe actions");
        }
        Check(![vc tableView:table canMoveRowAtIndexPath:Path(groupIndex,3)] && ![vc tableView:table canEditRowAtIndexPath:Path(groupIndex,3)],@"add/import rows cannot be sorted or edited");
        Check(![vc tableView:table trailingSwipeActionsConfigurationForRowAtIndexPath:Path(groupIndex,3)],@"add row has no member swipe actions");
        NSIndexPath *origin=Path(groupIndex,0);
        Check([vc tableView:table targetIndexPathForMoveFromRowAtIndexPath:origin toProposedIndexPath:Path(1,0)]==origin,@"drag to preview returns original row");
        NSIndexPath *target=[vc tableView:table targetIndexPathForMoveFromRowAtIndexPath:origin toProposedIndexPath:Path(groupIndex,3)];
        Check(target.section==groupIndex && target.row==2,@"drag onto add row clamps within dynamic group section");
        [vc tableView:table moveRowAtIndexPath:Path(1,0) toIndexPath:Path(groupIndex,1)];
        Check([vc.tabOrder isEqual:@[@"preset_0",@"custom-A",@"preset_1"]],@"preview cannot mutate group order");
        [vc tableView:table moveRowAtIndexPath:origin toIndexPath:Path(groupIndex,2)];
        Check([vc.tabOrder isEqual:@[@"custom-A",@"preset_1",@"preset_0"]],@"actual group drag changes stable ID order");
        NSUInteger picked=vc.memberPicks;
        [vc tableView:table didSelectRowAtIndexPath:Path(1,0)];
        Check(vc.memberPicks==picked,@"selecting preview does not open member picker");
        [vc tableView:table didSelectRowAtIndexPath:Path(groupIndex,0)];
        Check(vc.memberPicks==picked+1 && vc.pickedTab==custom,@"custom group still opens its member picker after move");
        NSUInteger priorActions=actions;
        [vc tableView:table didSelectRowAtIndexPath:Path(groupIndex,3)];
        Check(actions==priorActions+1,@"add/import action row remains usable");
        vc.groupPreferences.accountID=nil;
        Check(![vc tableView:table canMoveRowAtIndexPath:Path(groupIndex,0)] && ![vc tableView:table canEditRowAtIndexPath:Path(groupIndex,0)],@"unknown account retains edit protection");
        Check(![vc tableView:table trailingSwipeActionsConfigurationForRowAtIndexPath:Path(groupIndex,0)],@"unknown account retains swipe protection");
        vc.groupPreferences.accountID=@"account-A";vc.accountChanged=YES;
        NSArray *before=[vc.tabOrder copy];picked=vc.memberPicks;
        [vc tableView:table moveRowAtIndexPath:Path(groupIndex,0) toIndexPath:Path(groupIndex,1)];
        [vc tableView:table didSelectRowAtIndexPath:Path(groupIndex,0)];
        Check([vc.tabOrder isEqual:before] && vc.memberPicks==picked,@"account switch rejects stale move and picker selection");
        Check(![vc tableView:table trailingSwipeActionsConfigurationForRowAtIndexPath:Path(groupIndex,0)],@"account switch rejects stale swipe");
        vc.accountChanged=NO;vc.tabOrder=[NSMutableArray array];
        Check([vc tableView:table targetIndexPathForMoveFromRowAtIndexPath:origin toProposedIndexPath:Path(groupIndex,1)]==origin,@"empty group cannot produce a negative row");
    }
    printf("Group settings section routing: %lu checks passed\n",(unsigned long)checks);
    return 0;
} }
