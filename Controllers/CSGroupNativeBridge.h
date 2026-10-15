#import <Foundation/Foundation.h>
#import "CSGroupProjection.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString * _Nullable CSGroupCurrentAccountID(void);
FOUNDATION_EXPORT id _Nullable CSGroupReadObject(id _Nullable object, NSString *name);
FOUNDATION_EXPORT long long CSGroupReadInteger(id _Nullable object, NSString *name, long long fallback);
FOUNDATION_EXPORT CSGroupRowCategory CSGroupCategoryForContact(id _Nullable contact);
FOUNDATION_EXPORT NSArray<NSArray<CSGroupRow *> *> * _Nullable CSGroupBuildNativeSections(id controller, id table, id source);
/// Revalidates a snapshot identity against current host rows. Caller checks account.
/// Anonymous business rows additionally require verified bounds and a clean model.
FOUNDATION_EXPORT NSIndexPath * _Nullable CSGroupResolveNativeRowPath(id controller, CSGroupRow *row, BOOL modelDirty);
NS_ASSUME_NONNULL_END
