#import "CSGroupProjection.h"
#import "WESessionTabItem.h"

@interface CSGroupRow ()
@property (nonatomic, readwrite) BOOL privacyMasked;
@property (nonatomic, readwrite) BOOL foldedEntryScoped;
@property (nonatomic, copy, readwrite) NSNumber *foldedEntryCount;
@property (nonatomic, copy, readwrite) NSString *foldedEntryAccountID;
@property (nonatomic, readwrite) NSUInteger foldedEntryPrivacyRevision;
@property (nonatomic, copy, readwrite) NSString *foldedEntrySummary, *foldedEntrySummaryUserName, *foldedEntryPrefix;
@end
@implementation CSGroupRow
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath userName:(NSString *)userName
                             kind:(CSGroupRowKind)kind category:(CSGroupRowCategory)category
                              top:(BOOL)top unreadCount:(NSUInteger)unreadCount redDot:(BOOL)redDot {
    return [self initWithNativePath:nativePath userName:userName kind:kind category:category top:top
        unreadCount:unreadCount redDot:redDot nativeSummary:nil sortTime:nil];
}
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath userName:(NSString *)userName
                             kind:(CSGroupRowKind)kind category:(CSGroupRowCategory)category
                              top:(BOOL)top unreadCount:(NSUInteger)unreadCount redDot:(BOOL)redDot
                    nativeSummary:(NSString *)nativeSummary sortTime:(NSNumber *)sortTime {
    return [self initWithNativePath:nativePath userName:userName kind:kind category:category top:top unreadCount:unreadCount
        redDot:redDot nativeSummary:nativeSummary sortTime:sortTime nativePrefix:nil];
}
- (instancetype)initWithNativePath:(NSIndexPath *)nativePath userName:(NSString *)userName
                             kind:(CSGroupRowKind)kind category:(CSGroupRowCategory)category
                              top:(BOOL)top unreadCount:(NSUInteger)unreadCount redDot:(BOOL)redDot
                    nativeSummary:(NSString *)nativeSummary sortTime:(NSNumber *)sortTime nativePrefix:(NSString *)nativePrefix {
    if ((self = [super init])) {
        _nativePrefix=[nativePrefix copy];
        _nativePath = [nativePath copy]; _userName = [userName copy]; _kind = kind;
        _category = category; _top = top; _unreadCount = unreadCount; _redDot = redDot;
        _nativeSummary=[nativeSummary isKindOfClass:NSString.class] && nativeSummary.length ? [nativeSummary copy] : nil;
        _nativeSortTime=[sortTime isKindOfClass:NSNumber.class] && sortTime.doubleValue>0 ? [sortTime copy] : nil;
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
    // The native show-as-dot flag is a presentation mode, not proof of unread.
    // Aggregate/business counters have unknown coverage and may outlive their
    // visible badge; never manufacture a dot from those counters alone.
    return row.unreadCount > 0 && row.redDot;
}

static BOOL CSGroupValueEqual(id a,id b) { return a==b || [a isEqual:b]; }
static BOOL CSGroupRowsMatch(CSGroupRow *a, CSGroupRow *b, BOOL unread) {
    if (a && a==b) return YES; // Published base rows are immutable.
    return a && b && [a.nativePath isEqual:b.nativePath] &&
        (a.userName==b.userName || [a.userName isEqual:b.userName]) &&
        a.kind==b.kind && a.category==b.category && a.top==b.top && a.privacyMasked==b.privacyMasked &&
        CSGroupValueEqual(a.nativePrefix,b.nativePrefix) && CSGroupValueEqual(a.foldedEntryPrefix,b.foldedEntryPrefix) &&
        CSGroupValueEqual(a.nativeSummary,b.nativeSummary) && CSGroupValueEqual(a.nativeSortTime,b.nativeSortTime) &&
        CSGroupValueEqual(a.foldedEntrySummary,b.foldedEntrySummary) && CSGroupValueEqual(a.foldedEntrySummaryUserName,b.foldedEntrySummaryUserName) &&
        a.foldedEntryScoped==b.foldedEntryScoped && (a.foldedEntryCount==b.foldedEntryCount || [a.foldedEntryCount isEqual:b.foldedEntryCount]) &&
        a.foldedEntryPrivacyRevision==b.foldedEntryPrivacyRevision &&
        (a.foldedEntryAccountID==b.foldedEntryAccountID || [a.foldedEntryAccountID isEqual:b.foldedEntryAccountID]) &&
        (!unread || (a.unreadCount==b.unreadCount && a.redDot==b.redDot));
}
static BOOL CSGroupSectionsMatch(NSArray *a, NSArray *b, BOOL unread) {
    if (!a || !b || a.count!=b.count) return NO;
    for (NSUInteger s=0;s<a.count;s++) {
        NSArray *left=a[s], *right=b[s]; if (left.count!=right.count) return NO;
        if (left==right) continue;
        for (NSUInteger r=0;r<left.count;r++) if (!CSGroupRowsMatch(left[r],right[r],unread)) return NO;
    }
    return YES;
}

@interface CSGroupProjection ()
@property (nonatomic, copy) NSDictionary<NSIndexPath *, NSIndexPath *> *displayToNative;
@property (nonatomic, copy) NSDictionary<NSIndexPath *, NSIndexPath *> *nativeToDisplay;
@property (nonatomic, copy) NSDictionary<NSString *, CSGroupBadge *> *badges;
@property (nonatomic, copy) NSArray *definitionRecords, *inputSections;
@property (nonatomic, copy) NSDictionary *memberTabIDs, *presetIDs, *destinationsByPath;
@property (nonatomic, copy) NSString *selectedTabID;
@property (nonatomic) BOOL filterDuplicates;
@property (nonatomic, copy) NSSet<NSString *> *hiddenUserNames, *unmaskedAggregateUserNames;
@property (nonatomic) NSUInteger privacyRevision;
@property (nonatomic, copy) NSDictionary<NSString *,NSNumber *> *sessionCounts, *foldedCounts;
@property (nonatomic, copy) NSSet<NSString *> *foldedUnreadTabs;
@property (nonatomic) BOOL scopeFoldedEntry;
@property (nonatomic, strong) CSGroupRow *foldedSummaryRow;
- (nullable NSIndexPath *)nativePathForDisplayPath:(NSIndexPath *)displayPath;
- (instancetype)initWithProjection:(CSGroupProjection *)projection summaryRow:(CSGroupRow *)row NS_DESIGNATED_INITIALIZER;
@end

@implementation CSGroupProjection
- (instancetype)initWithSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates accountID:(NSString *)accountID {
    return [self initWithSections:sections tabs:tabs selectedTabID:selectedTabID filterDuplicates:filterDuplicates accountID:accountID previousProjection:nil];
}
- (instancetype)initWithSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates accountID:(NSString *)accountID previousProjection:(CSGroupProjection *)previous {
    return [self initWithSections:sections tabs:tabs selectedTabID:selectedTabID filterDuplicates:filterDuplicates accountID:accountID hiddenUserNames:[NSSet set] privacyRevision:0 previousProjection:previous];
}
- (instancetype)initWithSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates accountID:(NSString *)accountID hiddenUserNames:(NSSet *)hiddenUserNames
                 privacyRevision:(NSUInteger)privacyRevision previousProjection:(CSGroupProjection *)previous {
    return [self initWithSections:sections tabs:tabs selectedTabID:selectedTabID filterDuplicates:filterDuplicates accountID:accountID hiddenUserNames:hiddenUserNames unmaskedAggregateUserNames:[NSSet set] privacyRevision:privacyRevision previousProjection:previous];
}
- (instancetype)initWithSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates accountID:(NSString *)accountID hiddenUserNames:(NSSet *)hiddenUserNames
      unmaskedAggregateUserNames:(NSSet *)unmaskedAggregateUserNames privacyRevision:(NSUInteger)privacyRevision previousProjection:(CSGroupProjection *)previous {
    return [self initWithSections:sections tabs:tabs selectedTabID:selectedTabID filterDuplicates:filterDuplicates accountID:accountID
        hiddenUserNames:hiddenUserNames unmaskedAggregateUserNames:unmaskedAggregateUserNames privacyRevision:privacyRevision
        scopeFoldedEntry:NO foldedProjection:nil previousProjection:previous];
}
- (instancetype)initWithSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selectedTabID
                filterDuplicates:(BOOL)filterDuplicates accountID:(NSString *)accountID hiddenUserNames:(NSSet *)hiddenUserNames
      unmaskedAggregateUserNames:(NSSet *)unmaskedAggregateUserNames privacyRevision:(NSUInteger)privacyRevision
                scopeFoldedEntry:(BOOL)scopeFoldedEntry foldedProjection:(CSGroupProjection *)foldedProjection previousProjection:(CSGroupProjection *)previous {
    if ((self = [super init])) {
        // Until every value is validated, no partial map, badge, or row is published.
        _sections = @[]; _accountID = [accountID isKindOfClass:[NSString class]] ? [accountID copy] : @"";
        _valid = NO;
        _displayToNative = @{}; _nativeToDisplay = @{}; _badges = @{}; _sessionCounts=@{};
        if (!_accountID.length || ![sections isKindOfClass:[NSArray class]] ||
            ![tabs isKindOfClass:[NSArray class]] || ![selectedTabID isKindOfClass:[NSString class]]) return self;

        if (![hiddenUserNames isKindOfClass:NSSet.class]) return self;
        for (id name in hiddenUserNames) if (![name isKindOfClass:NSString.class] || ![name length]) return self;
        if (![unmaskedAggregateUserNames isKindOfClass:NSSet.class]) return self;
        for (id name in unmaskedAggregateUserNames) if (![name isKindOfClass:NSString.class] || ![name length]) return self;
        _hiddenUserNames=[hiddenUserNames copy]; _unmaskedAggregateUserNames=[unmaskedAggregateUserNames copy]; _privacyRevision=privacyRevision;
        NSMutableDictionary<NSString *, NSNumber *> *types = [NSMutableDictionary dictionary];
        NSMutableArray *records=[NSMutableArray array];
        for (id candidate in tabs) {
            if (![candidate isKindOfClass:WESessionTabItem.class]) return self;
            WESessionTabItem *tab=candidate;
            if (![tab.tabId isKindOfClass:NSString.class] || !tab.tabId.length || types[tab.tabId] ||
                tab.type<WETabTypeAll || tab.type>WETabTypeCustom) return self;
            NSString *tabID=[tab.tabId copy]; types[tabID]=@(tab.type);
            NSMutableArray *members=[NSMutableArray array];
            if (tab.type==WETabTypeCustom) {
                if (tab.sessionUserNames && ![tab.sessionUserNames isKindOfClass:NSArray.class]) return self;
                for (id member in tab.sessionUserNames) {
                    if (![member isKindOfClass:NSString.class] || ![member length]) return self;
                    [members addObject:[member copy]];
                }
            }
            [records addObject:@[tabID,@(tab.type),[members copy]]];
        }
        if (!types[selectedTabID]) return self;
        if (foldedProjection && (!foldedProjection.isValid || ![foldedProjection.accountID isEqual:accountID])) return self;
        _scopeFoldedEntry=scopeFoldedEntry;
        _foldedCounts=scopeFoldedEntry ? foldedProjection.sessionCounts : nil;
        NSMutableSet *foldedUnread=[NSMutableSet set];
        if (scopeFoldedEntry && foldedProjection) for (NSString *tabID in types) {
            CSGroupBadge *badge=[foldedProjection badgeForTabID:tabID];
            if (badge.count || badge.redDot) [foldedUnread addObject:tabID];
        }
        _foldedUnreadTabs=[foldedUnread copy];
        // The child has already applied the ordinary group and privacy rules.
        // Only consume its digest when its entire provenance matches this view.
        BOOL currentFolded=scopeFoldedEntry && foldedProjection &&
            foldedProjection.privacyRevision==privacyRevision &&
            [foldedProjection.hiddenUserNames isEqual:hiddenUserNames] &&
            [foldedProjection.selectedTabID isEqual:selectedTabID] &&
            [foldedProjection.definitionRecords isEqual:records] && foldedProjection.filterDuplicates==filterDuplicates;
        if (currentFolded) {
            CSGroupRow *latest=nil;
            for (NSArray *visibleRows in foldedProjection.sections) for (CSGroupRow *child in visibleRows) {
                if (child.kind!=CSGroupRowKindSession) continue;
                if (!latest || child.nativeSortTime.unsignedLongLongValue>latest.nativeSortTime.unsignedLongLongValue) latest=child;
            }
            // Time ranks candidates only; a missing value is a zero-rank tie,
            // not a veto of this child's text or other visible children's text.
            // Missing text on the selected child still never borrows a global digest.
            if (latest.nativeSummary.length) _foldedSummaryRow=latest;
        }
        BOOL sameFolded=previous.scopeFoldedEntry==scopeFoldedEntry &&
            (previous.foldedCounts==_foldedCounts || [previous.foldedCounts isEqual:_foldedCounts]) &&
            [previous.foldedUnreadTabs isEqual:_foldedUnreadTabs] &&
            ((_foldedSummaryRow==nil && previous.foldedSummaryRow==nil) || CSGroupRowsMatch(_foldedSummaryRow,previous.foldedSummaryRow,NO));
        BOOL sameDefinitions=previous.isValid && [previous.accountID isEqual:accountID] && [previous.definitionRecords isEqual:records];
        NSDictionary *presetIDs=previous.presetIDs, *memberTabIDs=previous.memberTabIDs;
        if (!sameDefinitions) {
            NSMutableDictionary *presets=[NSMutableDictionary dictionary], *members=[NSMutableDictionary dictionary];
            for (NSArray *record in records) {
                NSString *tabID=record[0]; NSNumber *type=record[1];
                if (type.unsignedIntegerValue==WETabTypeCustom) {
                    for (NSString *name in record[2]) {
                        if (!members[name]) members[name]=[NSMutableSet set];
                        [members[name] addObject:tabID];
                    }
                } else {
                    if (!presets[type]) presets[type]=[NSMutableArray array];
                    [presets[type] addObject:tabID];
                }
            }
            presetIDs=[presets copy]; memberTabIDs=[members copy];
        }
        _definitionRecords=[records copy]; _presetIDs=presetIDs; _memberTabIDs=memberTabIDs;
        _selectedTabID=[selectedTabID copy]; _filterDuplicates=filterDuplicates;

        NSMutableSet<NSString *> *ordinaryNames = [NSMutableSet set];
        NSMutableSet<NSIndexPath *> *nativePaths = [NSMutableSet set];
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
                // Base rows are immutable; materialize subclasses so mutable host values cannot leak.
                CSGroupRow *value = [row isMemberOfClass:CSGroupRow.class] ? row : [[CSGroupRow alloc] initWithNativePath:row.nativePath userName:row.userName
                    kind:row.kind category:row.category top:row.top unreadCount:row.unreadCount redDot:row.redDot nativeSummary:row.nativeSummary sortTime:row.nativeSortTime nativePrefix:row.nativePrefix];
                [copiedRows addObject:value];
            }
            [copiedSections addObject:[copiedRows copy]];
        }

        BOOL samePrivacy=previous.privacyRevision==privacyRevision && [previous.hiddenUserNames isEqual:hiddenUserNames] && [previous.unmaskedAggregateUserNames isEqual:unmaskedAggregateUserNames];
        BOOL sameStructure=sameDefinitions && samePrivacy && sameFolded && previous.filterDuplicates==filterDuplicates && CSGroupSectionsMatch(copiedSections,previous.inputSections,NO);
        BOOL sameValues=sameStructure && CSGroupSectionsMatch(copiedSections,previous.inputSections,YES);
        if (sameValues && [previous.selectedTabID isEqual:selectedTabID]) return previous;
        BOOL sameDisplay=sameStructure && [previous.selectedTabID isEqual:selectedTabID];
        _inputSections=sameValues ? previous.inputSections : [copiedSections copy];
        NSMutableDictionary *destinationsByPath=sameStructure ? nil : [NSMutableDictionary dictionary];

        NSMutableDictionary<NSString *, NSNumber *> *counts = [NSMutableDictionary dictionary];
        NSMutableDictionary<NSString *, NSNumber *> *sessionCounts = [NSMutableDictionary dictionary];
        NSMutableSet<NSString *> *dotTabs = [NSMutableSet set];
        NSMutableDictionary<NSIndexPath *, NSIndexPath *> *displayToNative = sameDisplay ? nil : [NSMutableDictionary dictionary];
        NSMutableDictionary<NSIndexPath *, NSIndexPath *> *nativeToDisplay = sameDisplay ? nil : [NSMutableDictionary dictionary];
        NSMutableArray<NSArray<CSGroupRow *> *> *displaySections = [NSMutableArray arrayWithCapacity:sections.count];
        NSUInteger retainedCount = 0, retainedSessions=0; BOOL retainedDot = NO;
        for (NSUInteger sectionIndex = 0; sectionIndex < copiedSections.count; sectionIndex++) {
            NSMutableArray<CSGroupRow *> *visible = [NSMutableArray array];
            for (CSGroupRow * __strong row in copiedSections[sectionIndex]) {
                if (row.userName.length && [hiddenUserNames containsObject:row.userName]) continue;
                // Aggregate preview/dot attribution is not a sum of visible sessions.
                // Keep its navigation entry but publish no unverified unread contribution.
                // Only folded chats can summarize protected friends/groups. Service-account
                // containers keep their native title, layout and unread semantics.
                if (hiddenUserNames.count && row.kind==CSGroupRowKindAggregate && [row.userName isEqual:@"chatroom_session_box"] && ![unmaskedAggregateUserNames containsObject:row.userName]) {
                    row=[[CSGroupRow alloc] initWithNativePath:row.nativePath userName:row.userName kind:row.kind category:row.category top:row.top unreadCount:0 redDot:NO];
                    row.privacyMasked=YES;
                }
                BOOL scopedFolded=scopeFoldedEntry && row.kind==CSGroupRowKindAggregate && [row.userName isEqual:@"chatroom_session_box"];
                BOOL retained = !scopedFolded && CSGroupRetainsEveryTab(row);
                NSMutableSet<NSString *> *destinations = sameStructure ? previous.destinationsByPath[row.nativePath] : [NSMutableSet set];
                if (scopedFolded) {
                    if (!sameStructure) {
                        for (NSString *tabID in types) if (!_foldedCounts || [_foldedCounts[tabID] unsignedIntegerValue]>0) [destinations addObject:tabID];
                        destinationsByPath[row.nativePath]=[destinations copy];
                    }
                    if (!sameValues) for (NSString *tabID in destinations) if ([_foldedUnreadTabs containsObject:tabID]) [dotTabs addObject:tabID];
                    BOOL masked=row.privacyMasked;
                    row=[[CSGroupRow alloc] initWithNativePath:row.nativePath userName:row.userName kind:row.kind category:row.category top:row.top unreadCount:0 redDot:NO];
                    row.privacyMasked=masked;row.foldedEntryScoped=YES;row.foldedEntryCount=_foldedCounts[selectedTabID];
                    row.foldedEntryAccountID=accountID;row.foldedEntryPrivacyRevision=privacyRevision;
                    row.foldedEntryPrefix=_foldedSummaryRow.nativePrefix;
                    row.foldedEntrySummary=_foldedSummaryRow.nativeSummary;row.foldedEntrySummaryUserName=_foldedSummaryRow.userName;
                } else if (retained) {
                    retainedCount = CSGroupSaturatedAdd(retainedCount, CSGroupNumericUnread(row));
                    retainedDot |= CSGroupDotUnread(row);
                    if (row.kind==CSGroupRowKindSession || row.kind==CSGroupRowKindFake) retainedSessions++;
                } else {
                    if (!sameStructure) {
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
                        destinationsByPath[row.nativePath]=[destinations copy];
                    }
                    if (!sameValues) for (NSString *tabID in destinations) {
                        counts[tabID] = @(CSGroupSaturatedAdd([counts[tabID] unsignedIntegerValue], CSGroupNumericUnread(row)));
                        if (row.kind==CSGroupRowKindSession || row.kind==CSGroupRowKindFake) sessionCounts[tabID]=@([sessionCounts[tabID] unsignedIntegerValue]+1);
                        if (CSGroupDotUnread(row)) [dotTabs addObject:tabID];
                    }
                }
                if (retained || [destinations containsObject:selectedTabID]) {
                    if (!sameDisplay) {
                        NSIndexPath *displayPath = CSGroupPath(sectionIndex, visible.count);
                        displayToNative[displayPath] = row.nativePath;
                        nativeToDisplay[row.nativePath] = displayPath;
                    }
                    [visible addObject:row];
                }
            }
            NSArray *oldDisplay=sameDisplay ? previous.sections[sectionIndex] : nil;
            [displaySections addObject:[visible isEqualToArray:oldDisplay] ? oldDisplay : [visible copy]];
        }
        NSMutableDictionary<NSString *, CSGroupBadge *> *badges = [NSMutableDictionary dictionary];
        for (NSString *tabID in types) {
            NSUInteger count = CSGroupSaturatedAdd([counts[tabID] unsignedIntegerValue], retainedCount);
            badges[tabID] = [[CSGroupBadge alloc] initWithCount:count redDot:retainedDot || [dotTabs containsObject:tabID]];
            sessionCounts[tabID]=@([sessionCounts[tabID] unsignedIntegerValue]+retainedSessions);
        }
        _destinationsByPath=sameStructure ? previous.destinationsByPath : [destinationsByPath copy];
        _sections = [displaySections copy]; _displayToNative = sameDisplay ? previous.displayToNative : [displayToNative copy];
        _nativeToDisplay = sameDisplay ? previous.nativeToDisplay : [nativeToDisplay copy]; _badges = sameValues ? previous.badges : [badges copy];
        _sessionCounts=sameValues ? previous.sessionCounts : [sessionCounts copy];
        _valid = YES;
    }
    return self;
}
- (NSUInteger)sessionCountForTabID:(NSString *)tabID { return [self.sessionCounts[tabID] unsignedIntegerValue]; }
- (CSGroupProjection *)projectionByAttachingNativeSummaryRow:(CSGroupRow *)row {
    if (!self.valid || self.scopeFoldedEntry || !self.inputSections || ![row isMemberOfClass:CSGroupRow.class] ||
        row.kind!=CSGroupRowKindSession || (row.nativeSummary && ![row.nativeSummary isKindOfClass:NSString.class]) ||
        (row.nativePrefix && ![row.nativePrefix isKindOfClass:NSString.class])) return nil;
    NSIndexPath *display=[self displayPathForNativePath:row.nativePath];
    CSGroupRow *original=[self rowAtDisplayPath:display], *latest=nil;
    for (NSArray *section in self.sections) for (CSGroupRow *candidate in section)
        if (candidate.kind==CSGroupRowKindSession && (!latest || candidate.nativeSortTime.unsignedLongLongValue>latest.nativeSortTime.unsignedLongLongValue)) latest=candidate;
    if (!original || original!=latest || original.privacyMasked || row.privacyMasked || original.foldedEntryScoped || row.foldedEntryScoped ||
        row.foldedEntryCount || row.foldedEntryAccountID || row.foldedEntryPrivacyRevision || row.foldedEntrySummary || row.foldedEntryPrefix || row.foldedEntrySummaryUserName) return nil;
    CSGroupRow *metadata=[[CSGroupRow alloc] initWithNativePath:row.nativePath userName:row.userName kind:row.kind category:row.category
        top:row.top unreadCount:row.unreadCount redDot:row.redDot nativeSummary:original.nativeSummary sortTime:row.nativeSortTime nativePrefix:original.nativePrefix];
    if (!CSGroupRowsMatch(original,metadata,YES)) return nil;
    if (CSGroupRowsMatch(original,row,YES)) return self;
    return [[CSGroupProjection alloc] initWithProjection:self summaryRow:row];
}
- (instancetype)initWithProjection:(CSGroupProjection *)projection summaryRow:(CSGroupRow *)row {
    if ((self=[super init])) {
        _accountID=projection.accountID; _valid=projection.valid;
        _displayToNative=projection.displayToNative; _nativeToDisplay=projection.nativeToDisplay; _badges=projection.badges;
        _definitionRecords=projection.definitionRecords; _memberTabIDs=projection.memberTabIDs; _presetIDs=projection.presetIDs;
        _destinationsByPath=projection.destinationsByPath; _selectedTabID=projection.selectedTabID; _filterDuplicates=projection.filterDuplicates;
        _hiddenUserNames=projection.hiddenUserNames; _unmaskedAggregateUserNames=projection.unmaskedAggregateUserNames; _privacyRevision=projection.privacyRevision;
        _sessionCounts=projection.sessionCounts; _foldedCounts=projection.foldedCounts; _foldedUnreadTabs=projection.foldedUnreadTabs;
        _scopeFoldedEntry=projection.scopeFoldedEntry; _foldedSummaryRow=projection.foldedSummaryRow;
        NSUInteger sourceSection=[row.nativePath indexAtPosition:0], sourceRow=[row.nativePath indexAtPosition:1];
        NSMutableArray *input=[projection.inputSections mutableCopy], *inputRows=[input[sourceSection] mutableCopy];
        inputRows[sourceRow]=row; input[sourceSection]=[inputRows copy]; _inputSections=[input copy];
        NSIndexPath *display=projection.nativeToDisplay[row.nativePath]; NSUInteger section=[display indexAtPosition:0], index=[display indexAtPosition:1];
        NSMutableArray *visible=[projection.sections mutableCopy], *visibleRows=[visible[section] mutableCopy];
        visibleRows[index]=row; visible[section]=[visibleRows copy]; _sections=[visible copy];
    }
    return self;
}
- (BOOL)hasSameDisplayStructureAs:(CSGroupProjection *)other {
    return self.valid && other.valid && [self.accountID isEqual:other.accountID] &&
        [self.selectedTabID isEqual:other.selectedTabID] && CSGroupSectionsMatch(self.sections,other.sections,NO);
}
- (NSArray<NSIndexPath *> *)changedUnreadPathsFrom:(CSGroupProjection *)other {
    if (![self hasSameDisplayStructureAs:other]) return @[];
    NSMutableArray *paths=[NSMutableArray array];
    for (NSUInteger s=0;s<self.sections.count;s++)
        for (NSUInteger r=0;r<self.sections[s].count;r++)
            if (!CSGroupRowsMatch(self.sections[s][r],other.sections[s][r],YES)) [paths addObject:CSGroupPath(s,r)];
    return paths;
}
- (void)discardComputationCache {
    self.inputSections=nil; self.destinationsByPath=nil;
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
@end
