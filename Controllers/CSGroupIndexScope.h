#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT BOOL CSGroupUsesNativeIndices(id table);
FOUNDATION_EXPORT void CSGroupWithNativeIndices(id table, void (NS_NOESCAPE ^block)(void));
FOUNDATION_EXPORT void CSGroupWithDisplayIndices(id table, void (NS_NOESCAPE ^block)(void));
NS_ASSUME_NONNULL_END
