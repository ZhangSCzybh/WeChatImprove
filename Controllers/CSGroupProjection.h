#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class WESessionTabItem;
/// Bounded diagnostic only: once per stage/reason/tab/source, at most 32 records/process.
/// Never logs message text, account IDs or session usernames, and never writes storage.
FOUNDATION_EXPORT void CSGroupLogFoldedDigest(NSString *stage, NSString *reason, NSString * _Nullable tabID, NSUInteger count, NSString * _Nullable source);

typedef NS_ENUM(NSUInteger, CSGroupRowKind) {
    CSGroupRowKindSession,
    CSGroupRowKindAggregate,
    CSGroupRowKindBusiness,
    CSGroupRowKindFake
};

typedef NS_ENUM(NSUInteger, CSGroupRowCategory) {
    CSGroupRowCategoryUnknown,
    CSGroupRowCategoryGroup,
    CSGroupRowCategoryPrivate,
    CSGroupRowCategoryService
};

/// Immutable Foundation values only. Paths contain two indexes: section, row.
@interface CSGroupRow : NSObject <NSCopying>
@property (nonatomic, copy, readonly) NSIndexPath *nativePath;
@property (nonatomic, copy, readonly, nullable) NSString *userName;
@property (nonatomic, readonly) CSGroupRowKind kind;
@property (nonatomic, readonly) CSGroupRowCategory category;
@property (nonatomic, readonly) BOOL top;
@property (nonatomic, readonly) NSUInteger unreadCount;
/// Raw native show-as-dot flag. A displayed unread dot also requires a positive count.
@property (nonatomic, readonly) BOOL redDot;
@property (nonatomic, readonly) BOOL privacyMasked;
/// Copied native folded-session digest; no native models retained.
@property (nonatomic, copy, readonly, nullable) NSString *nativeSummary;
/// Native aggregate name prefix, kept separate for the native two-label renderer.
@property (nonatomic, copy, readonly, nullable) NSString *nativePrefix, *nativeSummarySource;
/// Optional ordering metadata only. A missing value cannot invalidate a digest
/// and never controls a visible time/date label on the folded entry.
@property (nonatomic, copy, readonly, nullable) NSNumber *nativeSortTime;
@property (nonatomic, copy, readonly, nullable) NSString *nativeSummaryReason;
/// Presentation-only ChatBox summary. A nil count means its native children were unavailable.
@property (nonatomic, readonly) BOOL foldedEntryScoped;
@property (nonatomic, copy, readonly, nullable) NSNumber *foldedEntryCount;
@property (nonatomic, copy, readonly, nullable) NSString *foldedEntryAccountID;
@property (nonatomic, copy, readonly, nullable) NSString *foldedEntryTabID;
@property (nonatomic, readonly) NSUInteger foldedEntryPrivacyRevision;
@property (nonatomic, copy, readonly, nullable) NSString *foldedEntrySummary;
@property (nonatomic, copy, readonly, nullable) NSString *foldedEntryPrefix, *foldedEntrySummarySource;
@property (nonatomic, copy, readonly, nullable) NSString *foldedEntrySummaryUserName;
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath
                         userName:(nullable NSString *)userName
                             kind:(CSGroupRowKind)kind
                         category:(CSGroupRowCategory)category
                              top:(BOOL)top
                      unreadCount:(NSUInteger)unreadCount
                           redDot:(BOOL)redDot;
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath
                         userName:(nullable NSString *)userName
                             kind:(CSGroupRowKind)kind
                         category:(CSGroupRowCategory)category
                              top:(BOOL)top
                      unreadCount:(NSUInteger)unreadCount
                           redDot:(BOOL)redDot
                    nativeSummary:(nullable NSString *)nativeSummary
                         sortTime:(nullable NSNumber *)sortTime;
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath userName:(nullable NSString *)userName
                             kind:(CSGroupRowKind)kind category:(CSGroupRowCategory)category
                              top:(BOOL)top unreadCount:(NSUInteger)unreadCount redDot:(BOOL)redDot
                    nativeSummary:(nullable NSString *)nativeSummary sortTime:(nullable NSNumber *)sortTime
                    summaryReason:(nullable NSString *)summaryReason;
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath userName:(nullable NSString *)userName
                             kind:(CSGroupRowKind)kind category:(CSGroupRowCategory)category
                              top:(BOOL)top unreadCount:(NSUInteger)unreadCount redDot:(BOOL)redDot
                    nativeSummary:(nullable NSString *)nativeSummary sortTime:(nullable NSNumber *)sortTime
                    summaryReason:(nullable NSString *)summaryReason nativePrefix:(nullable NSString *)nativePrefix
                    summarySource:(nullable NSString *)summarySource NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end

@interface CSGroupBadge : NSObject
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) BOOL redDot;
@end

@interface CSGroupProjection : NSObject
@property (nonatomic, copy, readonly) NSArray<NSArray<CSGroupRow *> *> *sections;
@property (nonatomic, copy, readonly) NSString *accountID;
@property (nonatomic, readonly, getter=isValid) BOOL valid;
- (instancetype)initWithSections:(NSArray<NSArray<CSGroupRow *> *> *)sections
                            tabs:(NSArray<WESessionTabItem *> *)tabs
                   selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates
                       accountID:(NSString *)accountID;
/// Reuse only verified immutable values from the same account and definitions.
- (instancetype)initWithSections:(NSArray<NSArray<CSGroupRow *> *> *)sections
                            tabs:(NSArray<WESessionTabItem *> *)tabs
                   selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates
                       accountID:(NSString *)accountID
              previousProjection:(nullable CSGroupProjection *)previous;
/// Privacy runs after complete native validation, before any grouping or badge work.
/// A revision change invalidates reuse even when the hidden names are unchanged.
- (instancetype)initWithSections:(NSArray<NSArray<CSGroupRow *> *> *)sections
                            tabs:(NSArray<WESessionTabItem *> *)tabs
                   selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates
                       accountID:(NSString *)accountID
                 hiddenUserNames:(NSSet<NSString *> *)hiddenUserNames
                 privacyRevision:(NSUInteger)privacyRevision
              previousProjection:(nullable CSGroupProjection *)previous;
/// Verified aggregates containing no hidden child may retain their native presentation.
- (instancetype)initWithSections:(NSArray<NSArray<CSGroupRow *> *> *)sections
                            tabs:(NSArray<WESessionTabItem *> *)tabs
                   selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates
                       accountID:(NSString *)accountID
                 hiddenUserNames:(NSSet<NSString *> *)hiddenUserNames
       unmaskedAggregateUserNames:(NSSet<NSString *> *)unmaskedAggregateUserNames
                 privacyRevision:(NSUInteger)privacyRevision
              previousProjection:(nullable CSGroupProjection *)previous;
/// Scope only the ChatBox aggregate, using child membership computed by this same projection.
/// A nil child projection retains a neutral entry without claiming a precise count.
- (instancetype)initWithSections:(NSArray<NSArray<CSGroupRow *> *> *)sections
                            tabs:(NSArray<WESessionTabItem *> *)tabs
                   selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates
                       accountID:(NSString *)accountID
                 hiddenUserNames:(NSSet<NSString *> *)hiddenUserNames
       unmaskedAggregateUserNames:(NSSet<NSString *> *)unmaskedAggregateUserNames
                 privacyRevision:(NSUInteger)privacyRevision
                scopeFoldedEntry:(BOOL)scopeFoldedEntry
                foldedProjection:(nullable CSGroupProjection *)foldedProjection
              previousProjection:(nullable CSGroupProjection *)previous NS_DESIGNATED_INITIALIZER;
/// Number of ordinary session rows assigned to a tab, after the same privacy and membership rules.
- (NSUInteger)sessionCountForTabID:(NSString *)tabID;
- (BOOL)hasSameDisplayStructureAs:(nullable CSGroupProjection *)other;
- (NSArray<NSIndexPath *> *)changedUnreadPathsFrom:(CSGroupProjection *)other;
/// Release full-list computation caches when the list is not being presented.
- (void)discardComputationCache;
- (instancetype)init NS_UNAVAILABLE;
- (nullable NSIndexPath *)displayPathForNativePath:(NSIndexPath *)nativePath;
- (nullable CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)displayPath;
/// Snapshot-derived badge. Integration supplies the verified native All total.
- (CSGroupBadge *)badgeForTabID:(NSString *)tabID;
@end
NS_ASSUME_NONNULL_END
