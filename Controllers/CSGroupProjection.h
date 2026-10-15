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

/// Only named, unambiguous rows can create action tokens. Revalidate before use.
@interface CSGroupActionToken : NSObject <NSCopying>
@property (nonatomic, copy, readonly) NSString *accountID;
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, readonly) CSGroupRowKind kind;
@property (nonatomic, readonly) NSUInteger revision;
- (instancetype)init NS_UNAVAILABLE;
@end

@interface CSGroupProjection : NSObject
@property (nonatomic, copy, readonly) NSArray<NSArray<CSGroupRow *> *> *sections;
@property (nonatomic, copy, readonly) NSString *accountID;
@property (nonatomic, readonly) NSUInteger revision;
@property (nonatomic, readonly, getter=isValid) BOOL valid;
- (instancetype)initWithSections:(NSArray<NSArray<CSGroupRow *> *> *)sections
                            tabs:(NSArray<WESessionTabItem *> *)tabs
                   selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates
                       accountID:(NSString *)accountID
                        revision:(NSUInteger)revision NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (nullable NSIndexPath *)nativePathForDisplayPath:(NSIndexPath *)displayPath;
- (nullable NSIndexPath *)displayPathForNativePath:(NSIndexPath *)nativePath;
- (nullable CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)displayPath;
/// Snapshot-derived badge. Integration supplies the verified native All total.
- (CSGroupBadge *)badgeForTabID:(NSString *)tabID;
- (nullable CSGroupActionToken *)actionTokenForDisplayPath:(NSIndexPath *)displayPath;
/// Resolves the current native row, including a target outside the selected tab.
/// Accepts an older revision after identity lookup; rejects future revisions.
- (nullable CSGroupRow *)rowForActionToken:(CSGroupActionToken *)token;
@end
NS_ASSUME_NONNULL_END
