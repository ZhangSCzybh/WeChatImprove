#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT BOOL CSGroupUsesNativeIndices(id table);
FOUNDATION_EXPORT void CSGroupWithNativeIndices(id table, void (NS_NOESCAPE ^block)(void));
FOUNDATION_EXPORT void CSGroupWithDisplayIndices(id table, void (NS_NOESCAPE ^block)(void));
// Header classification is independent of row/index domains, including while
// UIKit is installing the composite display header.
FOUNDATION_EXPORT BOOL CSGroupUsesNativeHeader(id table);
FOUNDATION_EXPORT void CSGroupWithNativeHeader(id table, void (NS_NOESCAPE ^block)(void));
NS_ASSUME_NONNULL_END
