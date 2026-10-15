#import "CSGroupProjection.h"
#import "WESessionTabItem.h"

@implementation CSGroupRow
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath userName:(NSString *)userName
                             kind:(CSGroupRowKind)kind category:(CSGroupRowCategory)category
                              top:(BOOL)top unreadCount:(NSUInteger)unreadCount redDot:(BOOL)redDot {
    if ((self = [super init])) {
        _nativePath = [nativePath copy]; _userName = [userName copy]; _kind = kind;
        _category = category; _top = top; _unreadCount = unreadCount; _redDot = redDot;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone { (void)zone; return self; }
@end

@implementation CSGroupBadge
- (instancetype)initWithCount:(NSUInteger)count redDot:(BOOL)redDot {
    if ((self = [super init])) { _count = count; _redDot = redDot; }
    return self;
}
@end
@implementation CSGroupActionToken
- (instancetype)initWithAccountID:(NSString *)accountID userName:(NSString *)userName
                             kind:(CSGroupRowKind)kind revision:(NSUInteger)revision {
    if ((self = [super init])) {
        _accountID = [accountID copy]; _userName = [userName copy]; _kind = kind; _revision = revision;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone { (void)zone; return self; }
@end

static BOOL CSGroupIsPath(id path) {
    return [path isKindOfClass:[NSIndexPath class]] && [path length] == 2;
}

static NSIndexPath *CSGroupPath(NSUInteger section, NSUInteger row) {
    NSUInteger indexes[] = {section, row};
    return [NSIndexPath indexPathWithIndexes:indexes length:2];
}

static BOOL CSGroupRetainsEveryTab(CSGroupRow *row) {
    // Known service containers follow service/custom membership just like their sessions.
    if (row.category == CSGroupRowCategoryService) return NO;
    return row.kind == CSGroupRowKindAggregate || row.kind == CSGroupRowKindBusiness ||
           row.category == CSGroupRowCategoryUnknown;
}

static NSUInteger CSGroupSaturatedAdd(NSUInteger left, NSUInteger right) {
    return NSUIntegerMax - left < right ? NSUIntegerMax : left + right;
}

static NSUInteger CSGroupNumericUnread(CSGroupRow *row) {
    if (row.redDot || row.kind == CSGroupRowKindAggregate || row.kind == CSGroupRowKindBusiness) return 0;
    return row.unreadCount;
}

static BOOL CSGroupDotUnread(CSGroupRow *row) {
    return row.redDot || ((row.kind == CSGroupRowKindAggregate || row.kind == CSGroupRowKindBusiness) && row.unreadCount > 0);
}

static NSArray *CSGroupActionKey(NSString *name, CSGroupRowKind kind) {
    return @[name, @(kind)];
}

@interface CSGroupProjection ()
@property (nonatomic, copy) NSDictionary<NSIndexPath *, NSIndexPath *> *displayToNative;
@property (nonatomic, copy) NSDictionary<NSIndexPath *, NSIndexPath *> *nativeToDisplay;
@property (nonatomic, copy) NSDictionary<NSString *, CSGroupBadge *> *badges;
@property (nonatomic, copy) NSDictionary<NSArray *, id> *actionRows;
@end

@implementation CSGroupProjection
- (instancetype)initWithSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates accountID:(NSString *)accountID revision:(NSUInteger)revision {
    if ((self = [super init])) {
        // Until every value is validated, no partial map, badge, or row is published.
        _sections = @[]; _accountID = [accountID isKindOfClass:[NSString class]] ? [accountID copy] : @"";
        _revision = revision; _valid = NO;
        _displayToNative = @{}; _nativeToDisplay = @{}; _badges = @{}; _actionRows = @{};
        if (!_accountID.length || ![sections isKindOfClass:[NSArray class]] ||
            ![tabs isKindOfClass:[NSArray class]] || ![selectedTabID isKindOfClass:[NSString class]]) return self;

        NSMutableDictionary<NSString *, NSNumber *> *types = [NSMutableDictionary dictionary];
        NSMutableDictionary<NSNumber *, NSMutableArray<NSString *> *> *presetIDs = [NSMutableDictionary dictionary];
        NSMutableDictionary<NSString *, NSMutableSet<NSString *> *> *memberTabIDs = [NSMutableDictionary dictionary];
        for (id candidate in tabs) {
            if (![candidate isKindOfClass:[WESessionTabItem class]]) return self;
            WESessionTabItem *tab = candidate;
            if (![tab.tabId isKindOfClass:[NSString class]] || !tab.tabId.length || types[tab.tabId] ||
                tab.type < WETabTypeAll || tab.type > WETabTypeCustom) return self;
            NSString *tabID = [tab.tabId copy];
            types[tabID] = @(tab.type);
            if (tab.type == WETabTypeCustom) {
                if (tab.sessionUserNames && ![tab.sessionUserNames isKindOfClass:[NSArray class]]) return self;
                for (id member in tab.sessionUserNames) {
                    if (![member isKindOfClass:[NSString class]] || ![member length]) return self;
                    NSString *name = [member copy];
                    if (!memberTabIDs[name]) memberTabIDs[name] = [NSMutableSet set];
                    [memberTabIDs[name] addObject:tabID];
                }
            } else {
                if (!presetIDs[@(tab.type)]) presetIDs[@(tab.type)] = [NSMutableArray array];
                [presetIDs[@(tab.type)] addObject:tabID];
            }
        }
        if (!types[selectedTabID]) return self;

        NSMutableSet<NSString *> *ordinaryNames = [NSMutableSet set];
        NSMutableSet<NSIndexPath *> *nativePaths = [NSMutableSet set];
        NSMutableDictionary<NSArray *, id> *actionRows = [NSMutableDictionary dictionary];
        NSMutableArray<NSArray<CSGroupRow *> *> *copiedSections = [NSMutableArray arrayWithCapacity:sections.count];
        for (NSUInteger sectionIndex = 0; sectionIndex < sections.count; sectionIndex++) {
            id section = sections[sectionIndex];
            if (![section isKindOfClass:[NSArray class]]) return self;
            NSMutableArray<CSGroupRow *> *copiedRows = [NSMutableArray arrayWithCapacity:[section count]];
            for (NSUInteger rowIndex = 0; rowIndex < [section count]; rowIndex++) {
                id candidate = section[rowIndex];
                if (![candidate isKindOfClass:[CSGroupRow class]]) return self;
                CSGroupRow *row = candidate;
                if (!CSGroupIsPath(row.nativePath) || [row.nativePath indexAtPosition:0] != sectionIndex ||
                    [row.nativePath indexAtPosition:1] != rowIndex || [nativePaths containsObject:row.nativePath] ||
                    row.kind > CSGroupRowKindFake || row.category > CSGroupRowCategoryService ||
                    (row.userName && ![row.userName isKindOfClass:[NSString class]])) return self;
                [nativePaths addObject:row.nativePath];
                if (row.kind == CSGroupRowKindSession || row.kind == CSGroupRowKindFake) {
                    if (!row.userName.length || [ordinaryNames containsObject:row.userName]) return self;
                    [ordinaryNames addObject:row.userName];
                }
                // Materialize a fresh value, so subclasses cannot leak a mutable host object.
                CSGroupRow *value = [[CSGroupRow alloc] initWithNativePath:row.nativePath userName:row.userName
                    kind:row.kind category:row.category top:row.top unreadCount:row.unreadCount redDot:row.redDot];
                [copiedRows addObject:value];
                if (value.userName.length) {
                    NSArray *key = CSGroupActionKey(value.userName, value.kind);
                    // Business duplicates may remain visible, but cannot authorize an ambiguous action.
                    actionRows[key] = actionRows[key] ? (id)[NSNull null] : value;
                }
            }
            [copiedSections addObject:[copiedRows copy]];
        }

        NSMutableDictionary<NSString *, NSNumber *> *counts = [NSMutableDictionary dictionary];
        NSMutableSet<NSString *> *dotTabs = [NSMutableSet set];
        NSMutableDictionary<NSIndexPath *, NSIndexPath *> *displayToNative = [NSMutableDictionary dictionary];
        NSMutableDictionary<NSIndexPath *, NSIndexPath *> *nativeToDisplay = [NSMutableDictionary dictionary];
        NSMutableArray<NSArray<CSGroupRow *> *> *displaySections = [NSMutableArray arrayWithCapacity:sections.count];
        NSUInteger retainedCount = 0; BOOL retainedDot = NO;
        for (NSUInteger sectionIndex = 0; sectionIndex < copiedSections.count; sectionIndex++) {
            NSMutableArray<CSGroupRow *> *visible = [NSMutableArray array];
            for (CSGroupRow *row in copiedSections[sectionIndex]) {
                BOOL retained = CSGroupRetainsEveryTab(row);
                NSMutableSet<NSString *> *destinations = [NSMutableSet set];
                if (retained) {
                    retainedCount = CSGroupSaturatedAdd(retainedCount, CSGroupNumericUnread(row));
                    retainedDot |= CSGroupDotUnread(row);
                } else {
                    [destinations addObjectsFromArray:presetIDs[@(WETabTypeAll)] ?: @[]];
                    NSSet<NSString *> *customIDs = row.userName.length ? memberTabIDs[row.userName] : nil;
                    if (customIDs) [destinations unionSet:customIDs];
                    WETabType categoryType = WETabTypeOfficial;
                    if (row.category == CSGroupRowCategoryGroup) categoryType = WETabTypeGroup;
                    else if (row.category == CSGroupRowCategoryPrivate) categoryType = WETabTypePrivate;
                    if (!(filterDuplicates && customIDs.count &&
                          (categoryType == WETabTypeGroup || categoryType == WETabTypePrivate))) {
                        [destinations addObjectsFromArray:presetIDs[@(categoryType)] ?: @[]];
                    }
                    for (NSString *tabID in destinations) {
                        counts[tabID] = @(CSGroupSaturatedAdd([counts[tabID] unsignedIntegerValue], CSGroupNumericUnread(row)));
                        if (CSGroupDotUnread(row)) [dotTabs addObject:tabID];
                    }
                }
                if (retained || [destinations containsObject:selectedTabID]) {
                    NSIndexPath *displayPath = CSGroupPath(sectionIndex, visible.count);
                    [visible addObject:row]; displayToNative[displayPath] = row.nativePath;
                    nativeToDisplay[row.nativePath] = displayPath;
                }
            }
            [displaySections addObject:[visible copy]];
        }
        NSMutableDictionary<NSString *, CSGroupBadge *> *badges = [NSMutableDictionary dictionary];
        for (NSString *tabID in types) {
            NSUInteger count = CSGroupSaturatedAdd([counts[tabID] unsignedIntegerValue], retainedCount);
            badges[tabID] = [[CSGroupBadge alloc] initWithCount:count redDot:retainedDot || [dotTabs containsObject:tabID]];
        }
        _sections = [displaySections copy]; _displayToNative = [displayToNative copy];
        _nativeToDisplay = [nativeToDisplay copy]; _badges = [badges copy];
        _actionRows = [actionRows copy]; _valid = YES;
    }
    return self;
}
- (NSIndexPath *)nativePathForDisplayPath:(NSIndexPath *)displayPath {
    return self.valid && CSGroupIsPath(displayPath) ? self.displayToNative[displayPath] : nil;
}
- (NSIndexPath *)displayPathForNativePath:(NSIndexPath *)nativePath {
    return self.valid && CSGroupIsPath(nativePath) ? self.nativeToDisplay[nativePath] : nil;
}
- (CSGroupRow *)rowAtDisplayPath:(NSIndexPath *)displayPath {
    if (![self nativePathForDisplayPath:displayPath]) return nil;
    return self.sections[[displayPath indexAtPosition:0]][[displayPath indexAtPosition:1]];
}
- (CSGroupBadge *)badgeForTabID:(NSString *)tabID {
    CSGroupBadge *badge = [tabID isKindOfClass:[NSString class]] ? self.badges[tabID] : nil;
    return badge ?: [[CSGroupBadge alloc] initWithCount:0 redDot:NO];
}
- (CSGroupActionToken *)actionTokenForDisplayPath:(NSIndexPath *)displayPath {
    CSGroupRow *row = [self rowAtDisplayPath:displayPath];
    if (!row.userName.length || self.actionRows[CSGroupActionKey(row.userName,row.kind)] != row) return nil;
    return [[CSGroupActionToken alloc] initWithAccountID:self.accountID userName:row.userName
                                                  kind:row.kind revision:self.revision];
}
- (CSGroupRow *)rowForActionToken:(CSGroupActionToken *)token {
    if (!self.valid || ![token isKindOfClass:[CSGroupActionToken class]] ||
        ![token.accountID isEqualToString:self.accountID] || token.revision > self.revision) return nil;
    id row = self.actionRows[CSGroupActionKey(token.userName,token.kind)];
    return [row isKindOfClass:[CSGroupRow class]] ? row : nil;
}
@end
