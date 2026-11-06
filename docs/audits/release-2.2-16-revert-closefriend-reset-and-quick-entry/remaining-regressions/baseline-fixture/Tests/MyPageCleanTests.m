#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <assert.h>

@interface UITableView : NSObject
@property(nonatomic) NSUInteger reloadCount;
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData { self.reloadCount++; }
@end

@interface TestLeftConfig : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *displayTitle;
@end
@implementation TestLeftConfig
@synthesize title = _title;
- (NSString *)title { return self.displayTitle ?: _title; }
@end

@interface TestCellConfig : NSObject
@property(nonatomic, strong) TestLeftConfig *leftConfig;
@end
@implementation TestCellConfig @end

@interface WCTableViewNormalCellManager : NSObject
@property(nonatomic, strong) TestCellConfig *cellConfig;
@end
@implementation WCTableViewNormalCellManager @end

static id Cell(NSString *title, NSString *displayTitle) {
    WCTableViewNormalCellManager *cell = [WCTableViewNormalCellManager new];
    cell.cellConfig = [TestCellConfig new];
    cell.cellConfig.leftConfig = [TestLeftConfig new];
    cell.cellConfig.leftConfig.title = title;
    cell.cellConfig.leftConfig.displayTitle = displayTitle;
    return cell;
}

@interface TestSection : NSObject
@property(nonatomic, strong) NSMutableArray *cells;
- (void)removeCellAt:(unsigned long long)index;
@end
@implementation TestSection
- (void)removeCellAt:(unsigned long long)index { [self.cells removeObjectAtIndex:index]; }
@end

@interface TestTableManager : NSObject
@property(nonatomic, strong) NSMutableArray *sections;
@property(nonatomic, strong) UITableView *tableView;
@end
@implementation TestTableManager @end

@interface NativeMoreViewController : NSObject
@property(nonatomic, strong) TestTableManager *m_tableViewMgr;
@property(nonatomic) NSUInteger rebuildCount;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)reloadMoreView;
@end
@implementation NativeMoreViewController
- (void)viewDidLoad { [self reloadMoreView]; }
- (void)viewWillAppear:(BOOL)animated {}
- (void)reloadMoreView {
    self.rebuildCount++;
    TestSection *section = [TestSection new];
    section.cells = [@[Cell(@"收藏", nil), Cell(@"作品", nil), Cell(@"插件", nil),
                      Cell(@"视频号与公众号", nil)] mutableCopy];
    self.m_tableViewMgr = [TestTableManager new];
    self.m_tableViewMgr.sections = [@[section] mutableCopy];
    self.m_tableViewMgr.tableView = [UITableView new];
}
@end

#import "MyPageHookUnderTest.h"

static NSUserDefaults *isolatedDefaults;
static NSUserDefaults *TestDefaults(id self, SEL selector) { return isolatedDefaults; }
static NSArray *Titles(MoreViewController *controller) {
    TestSection *section = controller.m_tableViewMgr.sections.firstObject;
    return [section.cells valueForKeyPath:@"cellConfig.leftConfig.title"];
}

int main(void) { @autoreleasepool {
    NSString *suite = [@"com.wechatimprove.test.my-page." stringByAppendingString:NSUUID.UUID.UUIDString];
    isolatedDefaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
    Method method = class_getClassMethod(NSUserDefaults.class, @selector(standardUserDefaults));
    IMP original = method_setImplementation(method, (IMP)TestDefaults);
    @try {
        loadSettings();
        MoreViewController *controller = [MoreViewController new];
        [controller viewDidLoad];
        [controller viewWillAppear:NO];
        assert(([Titles(controller) isEqualToArray:@[@"收藏", @"作品", @"插件", @"视频号与公众号"]]));
        assert(!gHideWorksEnabled);

        // Loading on appearance also covers delayed settings notifications.
        [isolatedDefaults setBool:YES forKey:kWCHideWorksEnabledKey];
        [controller viewWillAppear:NO];
        assert(([Titles(controller) isEqualToArray:@[@"收藏", @"插件", @"视频号与公众号"]]));
        NSUInteger rebuilds = controller.rebuildCount;
        [controller viewWillAppear:NO];
        assert(controller.rebuildCount == rebuilds);
        [controller reloadMoreView];
        assert(([Titles(controller) isEqualToArray:@[@"收藏", @"插件", @"视频号与公众号"]]));

        // Disabling restores the native row in its original position without restarting.
        rebuilds = controller.rebuildCount;
        [isolatedDefaults setBool:NO forKey:kWCHideWorksEnabledKey];
        [controller viewWillAppear:NO];
        assert(controller.rebuildCount == rebuilds + 1);
        assert(([Titles(controller) isEqualToArray:@[@"收藏", @"作品", @"插件", @"视频号与公众号"]]));

        // The existing channels switch is independent of works.
        [isolatedDefaults setBool:YES forKey:kWCHideChannelsEnabledKey];
        [controller viewWillAppear:NO];
        assert(([Titles(controller) isEqualToArray:@[@"收藏", @"作品", @"插件"]]));
        [isolatedDefaults setBool:YES forKey:kWCHideWorksEnabledKey];
        [isolatedDefaults setBool:YES forKey:kWCHideFavoriteEnabledKey];
        [controller viewWillAppear:NO];
        assert(([Titles(controller) isEqualToArray:@[@"插件"]]));
        [isolatedDefaults setBool:NO forKey:kWCHideWorksEnabledKey];
        [controller viewWillAppear:NO];
        assert(([Titles(controller) isEqualToArray:@[@"作品", @"插件"]]));

        // Recognize original titles even when the text customization getter changes them.
        [isolatedDefaults setBool:NO forKey:kWCHideFavoriteEnabledKey];
        [isolatedDefaults setBool:NO forKey:kWCHideChannelsEnabledKey];
        [isolatedDefaults setBool:YES forKey:kWCHideWorksEnabledKey];
        loadSettings();
        TestSection *section = controller.m_tableViewMgr.sections.firstObject;
        id renamedWorks = Cell(@"作品", @"我的创作");
        id renamedFavorite = Cell(@"收藏", @"作品");
        id unrelated = Cell(@"作品集工具", nil);
        id unknown = [NSObject new];
        section.cells = [@[renamedWorks, renamedFavorite, unrelated, unknown] mutableCopy];
        hideCellsInSection(controller.m_tableViewMgr);
        assert(([section.cells isEqualToArray:@[renamedFavorite, unrelated, unknown]]));
        hideCellsInSection(controller.m_tableViewMgr);
        assert(section.cells.count == 3);
        hideCellsInSection(nil);
        assert(!shouldHideCell((id)@42));
        puts("PASS: defaults, hide/restore, reload idempotency, independent switches, renamed titles, unknown cells");
    } @finally {
        method_setImplementation(method, original);
        [isolatedDefaults removePersistentDomainForName:suite];
    }
    return 0;
} }
