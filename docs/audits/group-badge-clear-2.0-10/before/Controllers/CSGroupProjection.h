#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class WESessionTabItem;

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
@property (nonatomic, readonly) BOOL redDot;
@property (nonatomic, readonly) BOOL privacyMasked;
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath
                         userName:(nullable NSString *)userName
                             kind:(CSGroupRowKind)kind
                         category:(CSGroupRowCategory)category
                              top:(BOOL)top
                      unreadCount:(NSUInteger)unreadCount
                           redDot:(BOOL)redDot NS_DESIGNATED_INITIALIZER;
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
              previousProjection:(nullable CSGroupProjection *)previous NS_DESIGNATED_INITIALIZER;
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
