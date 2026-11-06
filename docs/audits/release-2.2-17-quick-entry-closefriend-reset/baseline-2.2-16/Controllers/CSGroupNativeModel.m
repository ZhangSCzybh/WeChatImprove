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
@property (nonatomic, strong) NSMapTable *sourceIndexByObject, *providerTopByObject;
@property (nonatomic, copy) NSDictionary<NSString *,NSArray *> *objectsByName;
@property (nonatomic, copy) NSDictionary<NSString *,NSArray<CSGroupRow *> *> *metadataByName;
@property (nonatomic, copy) NSDictionary<NSString *,NSNumber *> *sourceIndexByName;
/// One complete source boundary, never a cache of native arrays for every tab.
@property (nonatomic, copy) NSArray *sourceTopSessions, *sourceNormalSessions, *sourceAllTopSessions;
@property (nonatomic, copy) NSArray<WESessionTabItem *> *definitions;
@property (nonatomic, copy) NSSet<NSString *> *hiddenUserNames;
@property (nonatomic, copy) NSArray<CSGroupRow *> *foldedRows;
@property (nonatomic, strong) CSGroupProjection *foldedProjection;
@property (nonatomic) BOOL groupingEnabled, filterDuplicates, scopeFoldedEntry;
@property (nonatomic) NSUInteger privacyRevision;
@end
@implementation CSGroupNativeModelResult
- (instancetype)init {
    if ((self=[super init])) { _topSessions=@[]; _normalSessions=@[]; _selectedTabID=@""; _sourceRows=@[]; }
    return self;
}
- (CSGroupRow *)rowForSession:(id)session {
    NSNumber *index=session ? [self.sourceIndexByObject objectForKey:session] : nil;
    if (!index || index.unsignedIntegerValue>=self.sourceRows.count) return nil;
    CSGroupRow *source=self.sourceRows[index.unsignedIntegerValue];
    return [self.projection rowAtDisplayPath:[self.projection displayPathForNativePath:source.nativePath]];
}
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
static BOOL CSNativeStableMetadata(CSGroupRow *old, CSGroupRow *row) {
    return [row isKindOfClass:CSGroupRow.class] && [row.nativePath isEqual:old.nativePath] &&
        [row.userName isEqual:old.userName] && row.kind==old.kind && row.category==old.category && row.top==old.top &&
        !row.privacyMasked && !row.foldedEntryScoped &&
        (!row.nativePrefix || [row.nativePrefix isKindOfClass:NSString.class]) &&
        (!row.nativeSummary || [row.nativeSummary isKindOfClass:NSString.class]) &&
        (!row.nativeSortTime || [row.nativeSortTime isKindOfClass:NSNumber.class]);
}
static CSGroupRow *CSNativeCopiedMetadata(CSGroupRow *row) {
    if ([row isMemberOfClass:CSGroupRow.class]) return row;
    return [[CSGroupRow alloc] initWithNativePath:row.nativePath userName:row.userName kind:row.kind category:row.category
        top:row.top unreadCount:row.unreadCount redDot:row.redDot nativeSummary:row.nativeSummary
        sortTime:row.nativeSortTime nativePrefix:row.nativePrefix];
}
static BOOL CSNativeSameValue(id left,id right) { return left==right || [left isEqual:right]; }
static BOOL CSNativeSameFoldedRows(NSArray *left,NSArray *right) {
    if (!left || !right) return left==right;
    if (![right isKindOfClass:NSArray.class] || left.count!=right.count) return NO;
    for (NSUInteger i=0;i<left.count;i++) {
        CSGroupRow *a=left[i],*b=right[i];
        if (![b isKindOfClass:CSGroupRow.class] || !CSNativeSameValue(a.nativePath,b.nativePath) ||
            !CSNativeSameValue(a.userName,b.userName) || a.kind!=b.kind || a.category!=b.category || a.top!=b.top ||
            a.unreadCount!=b.unreadCount || a.redDot!=b.redDot || a.privacyMasked!=b.privacyMasked ||
            a.foldedEntryScoped!=b.foldedEntryScoped || !CSNativeSameValue(a.nativeSummary,b.nativeSummary) ||
            !CSNativeSameValue(a.nativePrefix,b.nativePrefix) || !CSNativeSameValue(a.nativeSortTime,b.nativeSortTime) ||
            !CSNativeSameValue(a.foldedEntryCount,b.foldedEntryCount) || !CSNativeSameValue(a.foldedEntryAccountID,b.foldedEntryAccountID) ||
            a.foldedEntryPrivacyRevision!=b.foldedEntryPrivacyRevision || !CSNativeSameValue(a.foldedEntrySummary,b.foldedEntrySummary) ||
            !CSNativeSameValue(a.foldedEntryPrefix,b.foldedEntryPrefix) || !CSNativeSameValue(a.foldedEntrySummaryUserName,b.foldedEntrySummaryUserName)) return NO;
    }
    return YES;
}
static NSArray *CSNativeFilterSource(NSArray *source,NSMapTable *indexes,NSSet *visible) {
    NSMutableArray *result=[NSMutableArray arrayWithCapacity:source.count];
    for (id object in source) {
        NSNumber *index=[indexes objectForKey:object];
        if (!index) return nil;
        if ([visible containsObject:index]) [result addObject:object];
    }
    return [result copy];
}
static void CSNativeCopySourceBoundary(CSGroupNativeModelResult *result,CSGroupNativeModelResult *previous) {
    result.sourceTopSessions=previous.sourceTopSessions;result.sourceNormalSessions=previous.sourceNormalSessions;
    result.sourceAllTopSessions=previous.sourceAllTopSessions;result.definitions=previous.definitions;
    result.hiddenUserNames=previous.hiddenUserNames;result.foldedRows=previous.foldedRows;
    result.foldedProjection=previous.foldedProjection;result.groupingEnabled=previous.groupingEnabled;
    result.filterDuplicates=previous.filterDuplicates;result.scopeFoldedEntry=previous.scopeFoldedEntry;result.privacyRevision=previous.privacyRevision;
}

@implementation CSGroupNativeModel
+ (CSGroupNativeModelResult *)modelBySelectingTabID:(NSString *)selectedTabID
                                       fromResult:(CSGroupNativeModelResult *)previous
                                       foldedRows:(NSArray<CSGroupRow *> *)foldedRows {
    @try {
        if (!previous.isValid || !previous.projection.isValid || !previous.sourceTopSessions || !previous.sourceNormalSessions ||
            !previous.sourceIndexByObject || !previous.definitions || ![selectedTabID isKindOfClass:NSString.class] ||
            !CSNativeSameFoldedRows(previous.foldedRows,foldedRows)) return nil;
        NSString *selected=previous.groupingEnabled ? selectedTabID : previous.selectedTabID;
        WESessionTabItem *definition=nil,*previousDefinition=nil;
        for (WESessionTabItem *tab in previous.definitions) {
            if ([tab.tabId isEqual:selected]) definition=tab;
            if ([tab.tabId isEqual:previous.selectedTabID]) previousDefinition=tab;
        }
        if (!definition || !previousDefinition) return nil;
        if ([previous.selectedTabID isEqual:selected]) return previous;
        CSGroupProjection *folded=previous.foldedProjection ?
            [previous.foldedProjection projectionBySelectingTabID:selected foldedProjection:nil] : nil;
        if (previous.foldedProjection && !folded) return nil;
        BOOL scoped=previous.groupingEnabled && definition.type!=WETabTypeAll && previous.scopeFoldedEntry;
        BOOL previousScoped=previous.groupingEnabled && previousDefinition.type!=WETabTypeAll && previous.scopeFoldedEntry;
        CSGroupProjection *projection=nil;
        // All uses the native aggregate presentation. A filtered tab scopes the
        // aggregate by child membership, so crossing that boundary recomputes
        // the projection from copied values rather than reusing incompatible maps.
        if (scoped!=previousScoped) {
            NSMutableSet *hidden=[previous.hiddenUserNames mutableCopy], *unmasked=[NSMutableSet set];
            if (!scoped && hidden.count && foldedRows.count) {
                NSUInteger count=0;for (CSGroupRow *row in foldedRows) if ([hidden containsObject:row.userName]) count++;
                if (count==foldedRows.count) [hidden addObject:@"chatroom_session_box"];
                else if (!count) [unmasked addObject:@"chatroom_session_box"];
            }
            projection=[[CSGroupProjection alloc] initWithSections:@[previous.sourceRows] tabs:previous.definitions selectedTabID:selected
                filterDuplicates:previous.filterDuplicates accountID:previous.projection.accountID hiddenUserNames:hidden
                unmaskedAggregateUserNames:unmasked privacyRevision:previous.privacyRevision scopeFoldedEntry:scoped
                foldedProjection:folded previousProjection:previous.projection];
        } else projection=[previous.projection projectionBySelectingTabID:selected foldedProjection:scoped ? folded : nil];
        if (!projection.isValid) return nil;
        NSMutableSet *visible=[NSMutableSet set];
        for (NSArray *section in projection.sections) for (CSGroupRow *row in section) {
            if (row.nativePath.length!=2 || [row.nativePath indexAtPosition:0]!=0 ||
                [row.nativePath indexAtPosition:1]>=previous.sourceRows.count) return nil;
            [visible addObject:@([row.nativePath indexAtPosition:1])];
        }
        CSGroupNativeModelResult *result=[CSGroupNativeModelResult new];
        CSNativeCopySourceBoundary(result,previous);result.foldedProjection=folded;
        result.topSessions=CSNativeFilterSource(previous.sourceTopSessions,previous.sourceIndexByObject,visible);
        result.normalSessions=CSNativeFilterSource(previous.sourceNormalSessions,previous.sourceIndexByObject,visible);
        result.allTopSessions=previous.sourceAllTopSessions ? CSNativeFilterSource(previous.sourceAllTopSessions,previous.sourceIndexByObject,visible) : nil;
        if (!result.topSessions || !result.normalSessions || (previous.sourceAllTopSessions && !result.allTopSessions)) return nil;
        result.totalTopSessionCount=result.allTopSessions ? result.allTopSessions.count : result.topSessions.count;
        result.selectedTabID=selected;result.projection=projection;result.sourceRows=previous.sourceRows;
        result.sourceIndexByObject=previous.sourceIndexByObject;result.providerTopByObject=previous.providerTopByObject;
        result.objectsByName=previous.objectsByName;result.metadataByName=previous.metadataByName;
        result.sourceIndexByName=previous.sourceIndexByName;result.valid=YES;
        return result;
    } @catch (__unused NSException *exception) { return nil; }
}
+ (CSGroupNativeModelResult *)modelByUpdatingResult:(CSGroupNativeModelResult *)previous
                                  changedUserNames:(NSSet<NSString *> *)changedUserNames
                                       rowProvider:(CSGroupNativeRowProvider)rowProvider {
    @try {
        if (!previous.isValid || !previous.projection.isValid || !previous.objectsByName || !previous.metadataByName ||
            !previous.sourceIndexByName || ![changedUserNames isKindOfClass:NSSet.class] || !rowProvider) return nil;
        if (!changedUserNames.count) return previous;
        NSMutableDictionary *metadata=[previous.metadataByName mutableCopy], *replacements=[NSMutableDictionary dictionary];
        NSMutableArray *sourceRows=[previous.sourceRows mutableCopy];
        for (id name in changedUserNames) {
            if (![name isKindOfClass:NSString.class] || ![name length]) return nil;
            NSArray *objects=previous.objectsByName[name], *oldRows=previous.metadataByName[name];
            NSNumber *sourceIndex=previous.sourceIndexByName[name];
            if (!objects.count || objects.count!=oldRows.count || !sourceIndex || sourceIndex.unsignedIntegerValue>=sourceRows.count) return nil;
            NSMutableArray *newRows=[NSMutableArray arrayWithCapacity:objects.count];
            for (NSUInteger i=0;i<objects.count;i++) {
                id object=objects[i];CSGroupRow *old=oldRows[i];
                CSGroupRow *row=rowProvider(object,old.nativePath,[[previous.providerTopByObject objectForKey:object] boolValue]);
                if (!CSNativeStableMetadata(old,row)) return nil;
                [newRows addObject:CSNativeCopiedMetadata(row)];
            }
            CSGroupRow *oldSource=sourceRows[sourceIndex.unsignedIntegerValue], *value=newRows[0];
            // All-source statistics were authoritative on the complete build;
            // the first distinct object for a name retains that same authority.
            CSGroupRow *row=[[CSGroupRow alloc] initWithNativePath:oldSource.nativePath userName:value.userName
                kind:value.kind category:value.category top:oldSource.top unreadCount:value.unreadCount redDot:value.redDot
                nativeSummary:value.nativeSummary sortTime:value.nativeSortTime nativePrefix:value.nativePrefix];
            replacements[row.nativePath]=row;sourceRows[sourceIndex.unsignedIntegerValue]=row;metadata[name]=[newRows copy];
        }
        CSGroupProjection *projection=[previous.projection projectionByReplacingRows:replacements];
        if (!projection) return nil;
        CSGroupNativeModelResult *result=[CSGroupNativeModelResult new];
        CSNativeCopySourceBoundary(result,previous);
        result.topSessions=previous.topSessions;result.normalSessions=previous.normalSessions;result.allTopSessions=previous.allTopSessions;
        result.totalTopSessionCount=previous.totalTopSessionCount;result.selectedTabID=previous.selectedTabID;
        result.projection=projection;result.sourceRows=[sourceRows copy];result.sourceIndexByObject=previous.sourceIndexByObject;
        result.providerTopByObject=previous.providerTopByObject;result.objectsByName=previous.objectsByName;
        result.metadataByName=[metadata copy];result.sourceIndexByName=previous.sourceIndexByName;result.valid=YES;
        return result;
    } @catch (__unused NSException *exception) { return nil; }
}
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
        NSMapTable *providerTopByObject=CSNativeIdentityMap();
        NSMutableDictionary<NSString *,NSMutableArray *> *objectsByName=[NSMutableDictionary dictionary], *metadataByName=[NSMutableDictionary dictionary];
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
                    [providerTopByObject setObject:@([topObjects containsObject:object]) forKey:object];
                    if (row.userName.length) {
                        if (!objectsByName[row.userName]) { objectsByName[row.userName]=[NSMutableArray array];metadataByName[row.userName]=[NSMutableArray array]; }
                        [objectsByName[row.userName] addObject:object];[metadataByName[row.userName] addObject:CSNativeCopiedMetadata(row)];
                    }
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

        NSHashTable *visibleEntries=CSNativeIdentitySet();
        for (NSArray<CSGroupRow *> *section in projection.sections) for (CSGroupRow *row in section) {
            NSUInteger index=[row.nativePath indexAtPosition:1];
            if (index>=entries.count) return CSNativeFailure(CSGroupNativeModelInvalidProjection,@"A projected identity is outside the native source.");
            [visibleEntries addObject:entries[index]];
        }
        CSGroupNativeModelResult *result=[CSGroupNativeModelResult new];
        result.topSessions=CSNativeFilter(top,entriesByObject,visibleEntries);
        result.normalSessions=CSNativeFilter(normal,entriesByObject,visibleEntries);
        result.allTopSessions=allTop ? CSNativeFilter(allTop,entriesByObject,visibleEntries) : nil;
        result.totalTopSessionCount=result.allTopSessions ? result.allTopSessions.count : result.topSessions.count;
        result.selectedTabID=selectedTabID; result.projection=projection; result.sourceRows=[rows copy];
        NSMapTable *sourceIndexByObject=CSNativeIdentityMap(), *indexByEntry=CSNativeIdentityMap();
        NSMutableDictionary *sourceIndexByName=[NSMutableDictionary dictionary];
        for (NSUInteger i=0;i<entries.count;i++) {
            CSGroupNativeEntry *entry=entries[i];[indexByEntry setObject:@(i) forKey:entry];
            if (entry.row.userName.length) sourceIndexByName[entry.row.userName]=@(i);
        }
        for (id object in entriesByObject) [sourceIndexByObject setObject:[indexByEntry objectForKey:[entriesByObject objectForKey:object]] forKey:object];
        NSMutableDictionary *copiedObjects=[NSMutableDictionary dictionary], *copiedMetadata=[NSMutableDictionary dictionary];
        for (NSString *name in objectsByName) { copiedObjects[name]=[objectsByName[name] copy];copiedMetadata[name]=[metadataByName[name] copy]; }
        result.sourceIndexByObject=sourceIndexByObject;result.providerTopByObject=providerTopByObject;
        result.sourceIndexByName=[sourceIndexByName copy];result.objectsByName=[copiedObjects copy];result.metadataByName=[copiedMetadata copy];
        result.sourceTopSessions=top;result.sourceNormalSessions=normal;result.sourceAllTopSessions=allTop;
        NSMutableArray *savedDefinitions=[NSMutableArray arrayWithCapacity:definitions.count];
        for (WESessionTabItem *tab in definitions) {
            WESessionTabItem *value=[WESessionTabItem new];value.tabId=tab.tabId;value.type=tab.type;
            value.tabName=tab.tabName;
            value.sessionUserNames=tab.type==WETabTypeCustom ? [[NSArray alloc] initWithArray:tab.sessionUserNames ?: @[] copyItems:YES] : @[];
            [savedDefinitions addObject:value];
        }
        result.definitions=[savedDefinitions copy];result.hiddenUserNames=[hiddenUserNames copy];
        if (foldedRows) {
            NSMutableArray *savedFolded=[NSMutableArray arrayWithCapacity:foldedRows.count];
            for (CSGroupRow *row in foldedRows) [savedFolded addObject:CSNativeCopiedMetadata(row)];
            result.foldedRows=[savedFolded copy];
        }
        result.foldedProjection=foldedProjection;result.groupingEnabled=groupingEnabled;
        result.filterDuplicates=filterDuplicates;result.scopeFoldedEntry=scopeFoldedEntry;result.privacyRevision=privacyRevision;
        result.valid=YES;
        return result;
    } @catch (__unused NSException *exception) {
        return CSNativeFailure(CSGroupNativeModelInvalidSnapshot,@"A native metadata read failed; no partial filtered result was published.");
    }
}
@end
