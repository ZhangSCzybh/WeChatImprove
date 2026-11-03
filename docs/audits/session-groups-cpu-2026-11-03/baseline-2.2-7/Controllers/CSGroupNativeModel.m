#import "CSGroupNativeModel.h"
#import "WESessionTabItem.h"

NSErrorDomain const CSGroupNativeModelErrorDomain = @"CSGroupNativeModelErrorDomain";

@interface CSGroupNativeModelResult ()
@property (nonatomic, readwrite, getter=isValid) BOOL valid;
@property (nonatomic, strong, readwrite) NSError *error;
@property (nonatomic, copy, readwrite) NSArray *topSessions, *normalSessions, *allTopSessions;
@property (nonatomic, readwrite) NSUInteger totalTopSessionCount;
@property (nonatomic, copy, readwrite) NSString *selectedTabID;
@property (nonatomic, strong, readwrite) CSGroupProjection *projection;
@property (nonatomic, copy, readwrite) NSArray<CSGroupRow *> *sourceRows;
@property (nonatomic, strong) NSMapTable *visibleRows;
@end
@implementation CSGroupNativeModelResult
- (instancetype)init {
    if ((self=[super init])) { _topSessions=@[]; _normalSessions=@[]; _selectedTabID=@""; _sourceRows=@[]; }
    return self;
}
- (CSGroupRow *)rowForSession:(id)session { return session ? [self.visibleRows objectForKey:session] : nil; }
@end

@interface CSGroupNativeEntry : NSObject
@property (nonatomic, strong) CSGroupRow *row;
@end
@implementation CSGroupNativeEntry @end

static NSMapTable *CSNativeIdentityMap(void) {
    return [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality
                               valueOptions:NSPointerFunctionsStrongMemory];
}
static NSHashTable *CSNativeIdentitySet(void) {
    return [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality];
}
static NSIndexPath *CSNativeModelPath(NSUInteger row) {
    NSUInteger values[]={0,row}; return [NSIndexPath indexPathWithIndexes:values length:2];
}
static CSGroupNativeModelResult *CSNativeFailure(CSGroupNativeModelErrorCode code, NSString *reason) {
    CSGroupNativeModelResult *result=[CSGroupNativeModelResult new];
    result.error=[NSError errorWithDomain:CSGroupNativeModelErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:reason}];
    return result;
}
static BOOL CSNativeMetadataMatches(CSGroupRow *a, CSGroupRow *b) {
    // The full-source record is authoritative. Wrapper mainUnReadCount and
    // showAsRedDot are aggregate presentation values and can legitimately differ
    // from their underlying session. They must not poison source statistics.
    return a.kind==b.kind && a.category==b.category;
}
static NSArray *CSNativeFilter(NSArray *source, NSMapTable *entries, NSHashTable *visible) {
    NSMutableArray *output=[NSMutableArray arrayWithCapacity:source.count];
    for (id object in source) if ([visible containsObject:[entries objectForKey:object]]) [output addObject:object];
    return [output copy];
}

@implementation CSGroupNativeModel
+ (CSGroupNativeModelResult *)buildWithTopSessions:(NSArray *)topSessions
                                  normalSessions:(NSArray *)normalSessions
                                  allTopSessions:(NSArray *)allTopSessions
                                     allSessions:(NSArray *)allSessions
                                            tabs:(NSArray<WESessionTabItem *> *)tabs
                                   selectedTabID:(NSString *)selectedTabID
                                 groupingEnabled:(BOOL)groupingEnabled
                                filterDuplicates:(BOOL)filterDuplicates
                                       accountID:(NSString *)accountID
                                 hiddenUserNames:(NSSet<NSString *> *)hiddenUserNames
                                 privacyRevision:(NSUInteger)privacyRevision
                                scopeFoldedEntry:(BOOL)scopeFoldedEntry
                                      foldedRows:(NSArray<CSGroupRow *> *)foldedRows
                                     rowProvider:(CSGroupNativeRowProvider)rowProvider {
    @try {
        if (![topSessions isKindOfClass:NSArray.class] || ![normalSessions isKindOfClass:NSArray.class] ||
            (allTopSessions && ![allTopSessions isKindOfClass:NSArray.class]) ||
            (allSessions && ![allSessions isKindOfClass:NSArray.class]) ||
            ![tabs isKindOfClass:NSArray.class] || ![selectedTabID isKindOfClass:NSString.class] ||
            ![accountID isKindOfClass:NSString.class] || !accountID.length ||
            ![hiddenUserNames isKindOfClass:NSSet.class] || !rowProvider ||
            (foldedRows && ![foldedRows isKindOfClass:NSArray.class]))
            return CSNativeFailure(CSGroupNativeModelInvalidInput,@"Native group input is incomplete or has an unsupported type.");
        for (id name in hiddenUserNames) if (![name isKindOfClass:NSString.class] || ![name length])
            return CSNativeFailure(CSGroupNativeModelInvalidInput,@"A hidden identity is invalid.");

        NSArray *top=[topSessions copy], *normal=[normalSessions copy], *allTop=[allTopSessions copy], *all=[allSessions copy];
        NSArray *sources=@[all ?: @[],top,normal,allTop ?: @[]];
        NSMapTable *entriesByObject=CSNativeIdentityMap();
        NSMutableDictionary<NSString *,CSGroupNativeEntry *> *entriesByName=[NSMutableDictionary dictionary];
        NSMutableArray<CSGroupNativeEntry *> *entries=[NSMutableArray array];
        NSHashTable *topObjects=CSNativeIdentitySet();
        for (id object in top) [topObjects addObject:object];
        for (id object in allTop) [topObjects addObject:object];

        for (NSArray *source in sources) {
            NSHashTable *seenObjects=CSNativeIdentitySet(); NSMutableSet *seenNames=[NSMutableSet set];
            for (id object in source) {
                if (object==NSNull.null || [seenObjects containsObject:object])
                    return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"A native source contains a duplicate or missing object.");
                [seenObjects addObject:object];
                CSGroupNativeEntry *entry=[entriesByObject objectForKey:object];
                if (!entry) {
                    NSIndexPath *path=CSNativeModelPath(entries.count);
                    CSGroupRow *row=rowProvider(object,path,[topObjects containsObject:object]);
                    if (![row isKindOfClass:CSGroupRow.class] || ![row.nativePath isEqual:path] ||
                        row.kind>CSGroupRowKindFake || row.category>CSGroupRowCategoryService ||
                        (row.userName && ![row.userName isKindOfClass:NSString.class]) ||
                        ((row.kind==CSGroupRowKindSession || row.kind==CSGroupRowKindFake) && !row.userName.length))
                        return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"A native object's identity or copied metadata is invalid.");
                    entry=row.userName.length ? entriesByName[row.userName] : nil;
                    if (entry && !CSNativeMetadataMatches(entry.row,row))
                        return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"Native sources disagree about one conversation's copied metadata.");
                    if (!entry) {
                        entry=[CSGroupNativeEntry new]; entry.row=row; [entries addObject:entry];
                        if (row.userName.length) entriesByName[row.userName]=entry;
                    }
                    [entriesByObject setObject:entry forKey:object];
                }
                if (entry.row.userName.length) {
                    if ([seenNames containsObject:entry.row.userName])
                        return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"A native source contains an ambiguous conversation identity.");
                    [seenNames addObject:entry.row.userName];
                }
            }
        }

        NSHashTable *topEntries=CSNativeIdentitySet(), *allTopEntries=CSNativeIdentitySet();
        for (id object in top) [topEntries addObject:[entriesByObject objectForKey:object]];
        for (id object in allTop) [allTopEntries addObject:[entriesByObject objectForKey:object]];
        for (id object in normal) if ([topEntries containsObject:[entriesByObject objectForKey:object]])
            return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"The native top and normal partitions overlap.");

        NSMutableArray<CSGroupRow *> *rows=[NSMutableArray arrayWithCapacity:entries.count];
        for (CSGroupNativeEntry *entry in entries) {
            CSGroupRow *value=entry.row;
            CSGroupRow *row=[[CSGroupRow alloc] initWithNativePath:CSNativeModelPath(rows.count) userName:value.userName
                kind:value.kind category:value.category top:[topEntries containsObject:entry] || [allTopEntries containsObject:entry]
                unreadCount:value.unreadCount redDot:value.redDot nativeSummary:value.nativeSummary
                sortTime:value.nativeSortTime nativePrefix:value.nativePrefix];
            [rows addObject:row];
        }

        NSMutableArray<WESessionTabItem *> *definitions=[tabs mutableCopy];
        WESessionTabItem *allTab=nil, *selectedTab=nil;
        for (id value in definitions) {
            if (![value isKindOfClass:WESessionTabItem.class])
                return CSNativeFailure(CSGroupNativeModelInvalidInput,@"A group definition is invalid.");
            WESessionTabItem *tab=value;
            if (tab.type==WETabTypeAll && !allTab) allTab=tab;
            if ([tab.tabId isEqual:selectedTabID]) selectedTab=tab;
        }
        if (!groupingEnabled) {
            if (!allTab) { allTab=[WESessionTabItem tabWithType:WETabTypeAll]; [definitions insertObject:allTab atIndex:0]; }
            selectedTab=allTab; selectedTabID=allTab.tabId;
        }
        if (!selectedTab)
            return CSNativeFailure(CSGroupNativeModelInvalidProjection,@"The selected group is not present in the current definitions.");

        NSMutableSet<NSString *> *hidden=[hiddenUserNames mutableCopy], *unmasked=[NSMutableSet set];
        BOOL scoped=groupingEnabled && selectedTab.type!=WETabTypeAll && scopeFoldedEntry;
        CSGroupProjection *foldedProjection=nil;
        if (foldedRows) {
            foldedProjection=[[CSGroupProjection alloc] initWithSections:@[[foldedRows copy]] tabs:definitions
                selectedTabID:selectedTabID filterDuplicates:filterDuplicates accountID:accountID
                hiddenUserNames:hidden privacyRevision:privacyRevision previousProjection:nil];
            if (!foldedProjection.isValid)
                return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"The folded conversation snapshot is invalid.");
            if (!scoped && hidden.count && foldedRows.count) {
                NSUInteger hiddenCount=0;
                for (CSGroupRow *row in foldedRows) if ([hidden containsObject:row.userName]) hiddenCount++;
                if (hiddenCount==foldedRows.count) [hidden addObject:@"chatroom_session_box"];
                else if (!hiddenCount) [unmasked addObject:@"chatroom_session_box"];
            }
        }
        CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:@[[rows copy]] tabs:definitions
            selectedTabID:selectedTabID filterDuplicates:filterDuplicates accountID:accountID hiddenUserNames:hidden
            unmaskedAggregateUserNames:unmasked privacyRevision:privacyRevision scopeFoldedEntry:scoped
            foldedProjection:foldedProjection previousProjection:nil];
        if (!projection.isValid)
            return CSNativeFailure(CSGroupNativeModelInvalidProjection,@"The complete native group projection could not be validated.");

        NSHashTable *visibleEntries=CSNativeIdentitySet(); NSMapTable *visibleRows=CSNativeIdentityMap();
        NSMutableDictionary<NSNumber *,CSGroupRow *> *rowsByIndex=[NSMutableDictionary dictionary];
        for (NSArray<CSGroupRow *> *section in projection.sections) for (CSGroupRow *row in section) {
            NSUInteger index=[row.nativePath indexAtPosition:1];
            if (index>=entries.count) return CSNativeFailure(CSGroupNativeModelInvalidProjection,@"A projected identity is outside the native source.");
            [visibleEntries addObject:entries[index]]; rowsByIndex[@(index)]=row;
        }
        NSMapTable *projectedRowsByEntry=CSNativeIdentityMap();
        [rowsByIndex enumerateKeysAndObjectsUsingBlock:^(NSNumber *index,CSGroupRow *row,BOOL *stop) {
            (void)stop; [projectedRowsByEntry setObject:row forKey:entries[index.unsignedIntegerValue]];
        }];
        for (id object in entriesByObject) {
            CSGroupRow *row=[projectedRowsByEntry objectForKey:[entriesByObject objectForKey:object]];
            if (row) [visibleRows setObject:row forKey:object];
        }
        CSGroupNativeModelResult *result=[CSGroupNativeModelResult new];
        result.topSessions=CSNativeFilter(top,entriesByObject,visibleEntries);
        result.normalSessions=CSNativeFilter(normal,entriesByObject,visibleEntries);
        result.allTopSessions=allTop ? CSNativeFilter(allTop,entriesByObject,visibleEntries) : nil;
        result.totalTopSessionCount=result.allTopSessions ? result.allTopSessions.count : result.topSessions.count;
        result.selectedTabID=selectedTabID; result.projection=projection; result.sourceRows=[rows copy];
        result.visibleRows=visibleRows; result.valid=YES;
        return result;
    } @catch (__unused NSException *exception) {
        return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"A native metadata read failed; no partial filtered result was published.");
    }
}
@end
