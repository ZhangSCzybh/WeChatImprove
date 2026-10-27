#import <Foundation/Foundation.h>
#import "CSCloseFriendAutomationProjection.h"

static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)

// Run the real table deletion handlers with a recording manager, without UIKit or a user store.
@class UITableView;
typedef NSInteger UITableViewCellEditingStyle;
static const UITableViewCellEditingStyle UITableViewCellEditingStyleDelete=1;
@interface NSIndexPath (TablePath)
@property(nonatomic,readonly) NSInteger section, row;
@end
@implementation NSIndexPath (TablePath)
- (NSInteger)section { return [self indexAtPosition:0]; }
- (NSInteger)row { return [self indexAtPosition:1]; }
@end
static NSIndexPath *Path(NSUInteger row) { NSUInteger indices[]={1,row}; return [NSIndexPath indexPathWithIndexes:indices length:2]; }
static CSCloseFriendSnapshot *currentSnapshot;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return currentSnapshot; }
static NSString *removedID, *removedAccount;
@interface CSScheduledTaskManager : NSObject
+ (instancetype)sharedManager;
- (BOOL)removeTask:(NSString *)identifier account:(NSString *)account error:(NSError **)error;
@end
@implementation CSScheduledTaskManager
+ (instancetype)sharedManager { static id manager; if(!manager)manager=[self new]; return manager; }
- (BOOL)removeTask:(NSString *)identifier account:(NSString *)account error:(NSError **)error {
    removedID=identifier; removedAccount=account; return YES;
}
@end
static void CSTaskAlert(id page,NSString *message) { CHECK(NO); }
@interface CSScheduledTaskSettingsViewController : NSObject
@property(nonatomic,copy) NSArray<NSDictionary *> *displayedTasks;
@property(nonatomic,copy) NSString *displayedAccount;
@property(nonatomic) NSUInteger reloads;
@end
@implementation CSScheduledTaskSettingsViewController
- (void)reload { self.reloads++; }
#import "ScheduledTaskListActionsUnderTest.h"
@end

static CSCloseFriendSnapshot *Snapshot(BOOL enabled, BOOL revealed, BOOL tasks, BOOL ai, BOOL sessions) {
    NSDictionary *profile=@{@"enabled":@(enabled),@"friends":@[@"alice"],@"groups":@[@"room@chatroom"],
        @"options":@{@"hideScheduledTasks":@(tasks),@"hideAIReply":@(ai),@"hideSessions":@(sessions)}};
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:profile revealed:revealed revision:1 blocked:NO];
}

int main(void) { @autoreleasepool {
    // Deliberately interleave protected and ordinary targets; disabled tasks remain list entries.
    NSArray *tasks=@[
        @{@"id":@"a1",@"target":@"alice",@"enabled":@YES},
        @{@"id":@"b1",@"target":@"bob",@"enabled":@YES},
        @{@"id":@"r1",@"target":@"room@chatroom",@"enabled":@YES},
        @{@"id":@"a2",@"target":@"alice",@"enabled":@NO},
        @{@"id":@"f1",@"target":@"filehelper",@"enabled":@NO},
        @{@"id":@"g1",@"target":@"other@chatroom",@"enabled":@YES}
    ];
    NSDictionary *conversations=@{
        @"alice":@{@"enabled":@YES,@"presetID":@"personal"},
        @"bob":@{@"enabled":@YES,@"presetID":@""},
        @"room@chatroom":@{@"enabled":@YES,@"presetID":@"group"},
        @"other@chatroom":@{@"enabled":@YES,@"presetID":@""},
        @"disabled":@{@"enabled":@NO,@"presetID":@""}
    };
    NSData *original=[NSPropertyListSerialization dataWithPropertyList:@[tasks,conversations] format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
    NSArray *allTaskIDs=@[@"a1",@"b1",@"r1",@"a2",@"f1",@"g1"], *ordinaryTaskIDs=@[@"b1",@"f1",@"g1"];
    NSArray *allAI=@[@"alice",@"bob",@"other@chatroom",@"room@chatroom"], *ordinaryAI=@[@"bob",@"other@chatroom"];

    // Each list switch is independent of the other and of hideSessions.
    for(NSNumber *enabled in @[@NO,@YES]) for(NSNumber *revealed in @[@NO,@YES])
    for(NSNumber *hideTasks in @[@NO,@YES]) for(NSNumber *hideAI in @[@NO,@YES]) for(NSNumber *sessions in @[@NO,@YES]) {
        CSCloseFriendSnapshot *snapshot=Snapshot(enabled.boolValue,revealed.boolValue,hideTasks.boolValue,hideAI.boolValue,sessions.boolValue);
        BOOL locked=enabled.boolValue && !revealed.boolValue;
        NSArray *visibleTasks=CSCloseFriendVisibleScheduledTasks(tasks,@"one",snapshot);
        NSArray *visibleAI=CSCloseFriendVisibleAIConversations(conversations,@"one",snapshot);
        CHECK([[visibleTasks valueForKey:@"id"] isEqual:locked && hideTasks.boolValue?ordinaryTaskIDs:allTaskIDs]);
        CHECK([visibleAI isEqual:locked && hideAI.boolValue?ordinaryAI:allAI]);
        CHECK(visibleTasks.count==(locked && hideTasks.boolValue?3:6));
        CHECK(visibleAI.count==(locked && hideAI.boolValue?2:4));
        CHECK(![visibleTasks isKindOfClass:NSMutableArray.class] && ![visibleAI isKindOfClass:NSMutableArray.class]);
    }

    CSCloseFriendSnapshot *locked=Snapshot(YES,NO,YES,YES,NO), *open=Snapshot(YES,YES,YES,YES,NO);
    // Unlock and relock rebuild from the unchanged store, preserving identity, order and preset selection.
    CHECK([CSCloseFriendVisibleScheduledTasks(tasks,@"one",open) isEqual:tasks]);
    CHECK([[CSCloseFriendVisibleScheduledTasks(tasks,@"one",locked) valueForKey:@"id"] isEqual:ordinaryTaskIDs]);
    CHECK([CSCloseFriendVisibleAIConversations(conversations,@"one",open) isEqual:allAI]);
    CHECK([CSCloseFriendVisibleAIConversations(conversations,@"one",locked) isEqual:ordinaryAI]);
    CHECK([original isEqual:[NSPropertyListSerialization dataWithPropertyList:@[tasks,conversations] format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL]]);
    // An all-protected list produces the same empty projection as no configured entries, with no hidden count.
    CHECK(!CSCloseFriendVisibleScheduledTasks(@[tasks[0],tasks[2],tasks[3]],@"one",locked).count);
    CHECK(!CSCloseFriendVisibleAIConversations(@{@"alice":conversations[@"alice"],@"room@chatroom":conversations[@"room@chatroom"]},@"one",locked).count);
    CHECK(!CSCloseFriendVisibleScheduledTasks(nil,@"one",open).count);
    CHECK(!CSCloseFriendVisibleAIConversations(nil,@"one",open).count);
    // A policy from another account must never be used to expose names from a stale store.
    for(NSString *account in @[@"two",@""]) {
        CHECK(!CSCloseFriendVisibleScheduledTasks(tasks,account,open).count);
        CHECK(!CSCloseFriendVisibleAIConversations(conversations,account,open).count);
    }
    CSCloseFriendSnapshot *blocked=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"one" profile:@{} revealed:YES revision:2 blocked:YES];
    CHECK(!CSCloseFriendVisibleScheduledTasks(tasks,@"one",blocked).count);
    CHECK(!CSCloseFriendVisibleAIConversations(conversations,@"one",blocked).count);
    CHECK(!CSCloseFriendVisibleScheduledTasks(tasks,@"one",nil).count);
    CHECK(!CSCloseFriendVisibleAIConversations(conversations,@"one",nil).count);

    currentSnapshot=locked;
    CSScheduledTaskSettingsViewController *page=[CSScheduledTaskSettingsViewController new];page.displayedAccount=@"one";
    page.displayedTasks=CSCloseFriendVisibleScheduledTasks(tasks,@"one",currentSnapshot);
    [page tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:Path(0)];
    CHECK([removedID isEqual:@"b1"] && [removedAccount isEqual:@"one"]);
    [page tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:Path(1)];
    CHECK([removedID isEqual:@"f1"]); // second visible row is not the second stored task
    CHECK(![page tableView:nil canEditRowAtIndexPath:Path(3)]);
    removedID=nil;
    [page tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:Path(3)];
    CHECK(!removedID);
    // A callback retained across relock or account switch cannot delete a newly hidden row.
    page.displayedTasks=tasks;
    [page tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:Path(0)];
    CHECK(!removedID && page.reloads==1);
    page.displayedAccount=@"two";
    [page tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:Path(1)];
    CHECK(!removedID && page.reloads==2);
    page.displayedAccount=@"one";currentSnapshot=open;
    [page tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:Path(0)];
    CHECK([removedID isEqual:@"a1"]);
    page.displayedTasks=@[];
    CHECK(![page tableView:nil canEditRowAtIndexPath:Path(0)]);
    printf("PASS: %lu close-friend automation checks (production policy/projections/deletion handlers, no sends or user data)\n",(unsigned long)checks);
} return 0; }
