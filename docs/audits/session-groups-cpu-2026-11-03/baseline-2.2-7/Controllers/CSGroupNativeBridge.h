#import <Foundation/Foundation.h>
#import "CSGroupProjection.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, CSGroupFoldedPrivacyState) {
    CSGroupFoldedPrivacyUnknown, CSGroupFoldedPrivacyNoHidden,
    CSGroupFoldedPrivacyMixed, CSGroupFoldedPrivacyAllHidden
};
FOUNDATION_EXPORT NSArray<NSString *> * _Nullable CSGroupCopyFoldedUserNames(void);
/// Immutable native child rows; nil means unavailable, an empty array means confirmed empty.
FOUNDATION_EXPORT NSArray<CSGroupRow *> * _Nullable CSGroupCopyFoldedRows(void);
/// Read ranking metadata first, then format only the selected immutable row.
/// The selector applies the caller's current group/privacy rules; nil selects no summary.
FOUNDATION_EXPORT NSArray<CSGroupRow *> * _Nullable CSGroupCopyFoldedRowsSelectingSummary(CSGroupRow * _Nullable (^selector)(NSArray<CSGroupRow *> *rows));
FOUNDATION_EXPORT CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray<NSString *> * _Nullable names, NSSet<NSString *> *hiddenNames);
FOUNDATION_EXPORT BOOL CSGroupIsFoldedController(id _Nullable controller);
FOUNDATION_EXPORT id _Nullable CSGroupNativeLogic(id controller);
FOUNDATION_EXPORT NSString * _Nullable CSGroupNativeUserNameAtPath(id controller, NSIndexPath *path);
FOUNDATION_EXPORT NSString * _Nullable CSGroupCurrentAccountID(void);
FOUNDATION_EXPORT id _Nullable CSGroupReadObject(id _Nullable object, NSString *name);
FOUNDATION_EXPORT long long CSGroupReadInteger(id _Nullable object, NSString *name, long long fallback);
FOUNDATION_EXPORT CSGroupRowCategory CSGroupCategoryForContact(id _Nullable contact);
/// Copies metadata from MMSessionInfo, MainSessionInfoItem or MMBaseSessionInfo.
/// The supplied path is owned by the caller; this never retains a host session.
FOUNDATION_EXPORT CSGroupRow * _Nullable CSGroupRowForNativeSession(id _Nullable session, NSIndexPath *path, BOOL top);
FOUNDATION_EXPORT NSArray<NSArray<CSGroupRow *> *> * _Nullable CSGroupBuildNativeSections(id controller, id table, id source);
/// Re-read native values, then share unchanged immutable rows/sections. Caller enforces the account boundary.
FOUNDATION_EXPORT NSArray<NSArray<CSGroupRow *> *> * _Nullable CSGroupBuildNativeSectionsReusing(id controller, id table, id source, NSArray<NSArray<CSGroupRow *> *> * _Nullable previous);
/// Revalidates a snapshot identity against current host rows. Caller checks account.
/// Anonymous business rows require verified bounds; a dirty model also requires
/// proving the slot still has no native session or named fake row. This permits
/// rendering, not identity-based editing (callers must still require a username).
FOUNDATION_EXPORT NSIndexPath * _Nullable CSGroupResolveNativeRowPath(id controller, CSGroupRow *row, BOOL modelDirty);
/// sourceVersion is the caller's immutable account/epoch/model revision. The
/// folded-only index owns names/coordinates, never native sessions. Every hit
/// revalidates native identity; misses or changed coordinates rebuild it.
FOUNDATION_EXPORT NSIndexPath * _Nullable CSGroupResolveNativeRowPathReusing(id controller, CSGroupRow *row, BOOL modelDirty, NSArray *sourceVersion);
NS_ASSUME_NONNULL_END
