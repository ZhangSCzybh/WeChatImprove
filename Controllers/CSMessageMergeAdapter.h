#import <UIKit/UIKit.h>
#import "CSChatNativeBridge.h"

// Main-thread entry points. No ownership of native messages or database records.
FOUNDATION_EXPORT void CSMessageMergeActivate(id controller);
FOUNDATION_EXPORT void CSMessageMergeDeactivate(id controller);
FOUNDATION_EXPORT void CSMessageMergePrepare(id controller, UITableView *table, NSIndexPath *path);
FOUNDATION_EXPORT CGFloat CSMessageMergeRowHeight(id controller, UITableView *table, NSIndexPath *path, CGFloat nativeHeight);
FOUNDATION_EXPORT void CSMessageMergeBind(id controller, UITableView *table, NSIndexPath *path, id cell);
FOUNDATION_EXPORT void CSMessageMergeWillMutate(id controller);
FOUNDATION_EXPORT void CSMessageMergeInvalidateLayout(id controller);
FOUNDATION_EXPORT void CSMessageMergeDidMutate(id controller);
FOUNDATION_EXPORT void CSMessageMergeFlush(id controller);
FOUNDATION_EXPORT void CSMessageMergeRestore(UIView *cellView);
FOUNDATION_EXPORT void CSMessageMergeRender(UIView *cellView);
FOUNDATION_EXPORT void CSMessageMergeReuse(UIView *cellView);
FOUNDATION_EXPORT BOOL CSMessageMergeHidesName(id model);
FOUNDATION_EXPORT CGSize CSMessageMergeMeasure(id model, CGSize nativeSize);
FOUNDATION_EXPORT void CSMessageMergeResetGeometry(id model);
FOUNDATION_EXPORT NSString *CSMessageModelChatName(id model);
FOUNDATION_EXPORT id CSMessageNativeObject(id object, NSString *selector);
FOUNDATION_EXPORT UITableView *CSMessageNativeTable(id controller);
FOUNDATION_EXPORT NSString *CSMessageCurrentAccount(void);
FOUNDATION_EXPORT NSString *CSMessageNativeIdentity(id model);

FOUNDATION_EXPORT BOOL CSMessageMergeLayoutSettled(id controller);
