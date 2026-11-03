#import <Foundation/Foundation.h>
#import "CSGroupProjection.h"

NS_ASSUME_NONNULL_BEGIN
@class WESessionTabItem;

FOUNDATION_EXPORT NSErrorDomain const CSGroupNativeModelErrorDomain;
typedef NS_ERROR_ENUM(CSGroupNativeModelErrorDomain, CSGroupNativeModelErrorCode) {
    CSGroupNativeModelInvalidInput = 1,
    CSGroupNativeModelInvalidSnapshot,
    CSGroupNativeModelInvalidProjection
};

/// Read a native object once into copied values. The path is a synthetic model
/// coordinate, not a host table coordinate; top reflects its native partition.
typedef CSGroupRow * _Nullable (^CSGroupNativeRowProvider)(id session, NSIndexPath *path, BOOL top);

/// Native arrays contain only the original input objects, in each input's order.
/// projection contains synthetic full-source coordinates and must never be used
/// to map the host UITableView. It supplies badges and presentation metadata only.
@interface CSGroupNativeModelResult : NSObject
@property (nonatomic, readonly, getter=isValid) BOOL valid;
@property (nonatomic, strong, readonly, nullable) NSError *error;
@property (nonatomic, copy, readonly) NSArray *topSessions;
@property (nonatomic, copy, readonly) NSArray *normalSessions;
@property (nonatomic, copy, readonly, nullable) NSArray *allTopSessions;
@property (nonatomic, readonly) NSUInteger totalTopSessionCount;
@property (nonatomic, copy, readonly) NSString *selectedTabID;
@property (nonatomic, strong, readonly, nullable) CSGroupProjection *projection;
/// Complete copied statistics source before group/privacy filtering. Synthetic
/// coordinates remain internal; consumers may recompute badges from these values.
@property (nonatomic, copy, readonly) NSArray<CSGroupRow *> *sourceRows;
/// Metadata for an input object, including distinct native instances sharing a
/// verified username. Returns nil for objects outside the selected result.
- (nullable CSGroupRow *)rowForSession:(id)session;
@end

@interface CSGroupNativeModel : NSObject
/// Fast path for a verified unchanged source/configuration boundary. Only named
/// objects are read; identity/category/top changes or unsupported metadata return
/// nil so the coordinator can perform its complete-source build. The caller must
/// prove that all original input object arrays and folded-child values are still
/// current, and that changedUserNames includes every changed source identity.
+ (nullable CSGroupNativeModelResult *)modelByUpdatingResult:(CSGroupNativeModelResult *)previous
                                          changedUserNames:(NSSet<NSString *> *)changedUserNames
                                               rowProvider:(CSGroupNativeRowProvider)rowProvider;
/// allSessions is the complete eligible statistics source, before selected-group
/// and plugin privacy filtering. The host coordinator proves eligibility against
/// its complete native presentation; raw native-hidden records and unrepresented
/// container children must not be promoted into statistics. Native cached objects
/// absent from it (for example an aggregate entry) are also classified. Cross-source native
/// instances of one username use the full source's unread presentation values;
/// their conversation kind/category must agree. Container aggregate counters may
/// differ from the underlying session and never replace the full source's count.
/// duplicates within a source and top/normal overlap are invalid snapshots.
///
/// Disabling grouping selects All, retaining privacy filtering. With no hidden
/// names, All/disabled returns the complete native arrays. allTopSessions=nil
/// preserves absence of that private capability and counts topSessions instead.
/// foldedRows=nil means unavailable; @[] means confirmed empty. The same folded
/// and privacy rules as CSGroupProjection apply to filtered groups. No native
/// session is mutated, created, reordered or inserted into an output array.
+ (CSGroupNativeModelResult *)buildWithTopSessions:(NSArray *)topSessions
                                  normalSessions:(NSArray *)normalSessions
                                  allTopSessions:(nullable NSArray *)allTopSessions
                                     allSessions:(nullable NSArray *)allSessions
                                            tabs:(NSArray<WESessionTabItem *> *)tabs
                                   selectedTabID:(NSString *)selectedTabID
                                 groupingEnabled:(BOOL)groupingEnabled
                                filterDuplicates:(BOOL)filterDuplicates
                                       accountID:(NSString *)accountID
                                 hiddenUserNames:(NSSet<NSString *> *)hiddenUserNames
                                 privacyRevision:(NSUInteger)privacyRevision
                                scopeFoldedEntry:(BOOL)scopeFoldedEntry
                                      foldedRows:(nullable NSArray<CSGroupRow *> *)foldedRows
                                     rowProvider:(CSGroupNativeRowProvider)rowProvider;
@end
NS_ASSUME_NONNULL_END
