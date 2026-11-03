#import "CSGroupPerformanceObservation.h"
#import "CSGroupRefreshState.h"
#import <objc/runtime.h>
#import <stdatomic.h>

static _Atomic NSUInteger Checks;
#define CHECK(value) do { atomic_fetch_add(&Checks,1); if (!(value)) { fprintf(stderr,"FAIL line %u: %s\n",__LINE__,#value); exit(1); } } while (0)

@implementation UITableView
- (void)reloadData {}
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {(void)paths;(void)animation;}
@end
@interface InheritedTable : UITableView @end
@implementation InheritedTable @end
@interface OverrideDataTable : UITableView @end
@implementation OverrideDataTable
- (void)reloadData { [super reloadData]; }
@end
@interface OverrideRowsTable : UITableView @end
@implementation OverrideRowsTable
- (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation { [super reloadRowsAtIndexPaths:paths withRowAnimation:animation]; }
@end

// The host owner deliberately derives from NSObject. The runtime ownership test
// must not assume the private host owner is a public UIViewController subclass.
@interface NewMainFrameViewController : NSObject @end
@implementation NewMainFrameViewController @end
@interface FoldedFrame : NewMainFrameViewController @end
@implementation FoldedFrame @end
static BOOL CSGroupIsFoldedController(id owner) { return [owner isKindOfClass:FoldedFrame.class]; }

@interface CSGroupNativeSessionCoordinator : NSObject
@property(nonatomic) BOOL compatibilityFallback;
+ (instancetype)sharedCoordinator;
@end
@implementation CSGroupNativeSessionCoordinator
+ (instancetype)sharedCoordinator { static id value; static dispatch_once_t once; dispatch_once(&once,^{value=[self new];});return value; }
@end

static NSMapTable *Owners,*Tables;
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) id controller;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic) BOOL usesNativeSessionModel;
+ (instancetype)adapterForTable:(UITableView *)table;
+ (instancetype)adapterForController:(id)owner;
@end
@implementation CSGroupListAdapter
+ (instancetype)adapterForTable:(UITableView *)table { return table ? [Tables objectForKey:table] : nil; }
+ (instancetype)adapterForController:(id)owner { return owner ? [Owners objectForKey:owner] : nil; }
@end

