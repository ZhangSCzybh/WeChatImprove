#import "CSGroupPreferences.h"

static NSString *const CSProfilesKey = @"com.wechat.enhance.chat_group.account_profiles";
static NSString *const CSProfileBackupsKey = @"com.wechat.enhance.chat_group.profile_backups";
static NSString *const CSLegacyBackupKey = @"com.wechat.enhance.chat_group.legacy_backup";
static NSString *const CSLegacyPrefix = @"com.wechat.enhance.chat_group.";

static NSArray<NSString *> *CSPresetIDs(void) { return @[@"preset_0", @"preset_1", @"preset_2", @"preset_3"]; }
static NSDictionary *CSDictionary(id value) { return [value isKindOfClass:[NSDictionary class]] ? value : @{}; }
static NSArray *CSArray(id value) { return [value isKindOfClass:[NSArray class]] ? value : @[]; }
static NSString *CSString(id value) { return [value isKindOfClass:[NSString class]] ? value : nil; }
static NSArray<NSString *> *CSStrings(id values) {
    NSMutableOrderedSet *result = [NSMutableOrderedSet new];
    for (id value in CSArray(values)) if (CSString(value).length) [result addObject:value];
    return result.array;
}
static NSDictionary *CSNames(id values) {
    NSMutableDictionary *result = [NSMutableDictionary new];
    [CSDictionary(values) enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        (void)stop;
        if ([CSPresetIDs() containsObject:key] && CSString(value).length) result[key] = value;
    }];
    return result;
}
static WESessionTabItem *CSCustomFromRecord(id record) {
    NSDictionary *r = CSDictionary(record);
    NSString *tabID = CSString(r[@"id"]), *name = CSString(r[@"name"]);
    if (!tabID.length || [tabID hasPrefix:@"preset_"] || !name.length || ![r[@"members"] isKindOfClass:[NSArray class]]) return nil;
    WESessionTabItem *tab = [WESessionTabItem customTabWithName:name sessionUserNames:CSStrings(r[@"members"])];
    tab.tabId = tabID;
    if ([r[@"created"] isKindOfClass:[NSDate class]]) tab.createTime = r[@"created"];
    if ([r[@"updated"] isKindOfClass:[NSDate class]]) tab.updateTime = r[@"updated"];
    return tab;
}
static NSDictionary *CSRecordFromCustom(id object) {
    if (![object isKindOfClass:[WESessionTabItem class]]) return nil;
    WESessionTabItem *tab = object;
    if (tab.type != WETabTypeCustom || !CSString(tab.tabId).length || [tab.tabId hasPrefix:@"preset_"] || !CSString(tab.tabName).length || ![tab.sessionUserNames isKindOfClass:[NSArray class]]) return nil;
    NSMutableDictionary *r = [@{@"id": tab.tabId, @"name": tab.tabName, @"members": CSStrings(tab.sessionUserNames)} mutableCopy];
    if ([tab.createTime isKindOfClass:[NSDate class]]) r[@"created"] = tab.createTime;
    if ([tab.updateTime isKindOfClass:[NSDate class]]) r[@"updated"] = tab.updateTime;
    return r;
}
static NSArray *CSRecords(NSArray *objects) {
    NSMutableArray *records = [NSMutableArray new];
    NSMutableSet *seen = [NSMutableSet new];
    for (id object in CSArray(objects)) {
        NSDictionary *record = CSRecordFromCustom(object);
        if (record && ![seen containsObject:record[@"id"]]) { [records addObject:record]; [seen addObject:record[@"id"]]; }
    }
    return records;
}
static id CSLegacyUnarchive(id value) {
    if (![value isKindOfClass:[NSData class]]) return nil;
    @try {
        NSError *error = nil;
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingFromData:value error:&error];
        if (!decoder || error) return nil;
        decoder.requiresSecureCoding = NO; // Original WESessionTabItem archives implement NSCoding.
        id result = [decoder decodeObjectForKey:NSKeyedArchiveRootObjectKey];
        [decoder finishDecoding];
        return result;
    } @catch (NSException *exception) { return nil; }
}

@interface CSGroupPreferences ()
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, copy, readwrite) NSString *accountID;
@property (nonatomic, copy, readwrite) NSArray<WESessionTabItem *> *tabs;
@property (nonatomic, copy, readwrite) NSArray<WESessionTabItem *> *customTabs;
@property (nonatomic, copy, readwrite) NSDictionary<NSString *, NSString *> *presetNames;
@property (nonatomic, copy, readwrite) NSArray<NSString *> *tabOrder;
@property (nonatomic, copy, readwrite) NSSet<NSString *> *hiddenPresetTabs;
@property (nonatomic) BOOL legacyImported;
@property (nonatomic, copy) id loadedProfile;
@property (nonatomic) BOOL profileLoaded;
@property (nonatomic, copy) NSString *profileSelection;
@end

@implementation CSGroupPreferences
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(NSString *)accountID {
    if ((self = [super init])) { _defaults = defaults; _accountID = CSString(accountID).length ? [accountID copy] : nil; [self reload]; }
    return self;
}

- (NSDictionary *)storedProfile {
    return self.accountID ? CSDictionary([self.defaults objectForKey:CSProfilesKey])[self.accountID] : nil;
}

- (void)applyProfile:(NSDictionary *)profile priorOrder:(NSArray *)priorOrder {
    NSDictionary *p = CSDictionary(profile);
    // Future schemas are never interpreted or overwritten by this version.
    if (![p[@"version"] isKindOfClass:[NSNumber class]] || [p[@"version"] integerValue] != 1) p = @{};
    NSMutableArray *custom = [NSMutableArray new];
    NSMutableDictionary *byID = [NSMutableDictionary new];
    for (id record in CSArray(p[@"customTabs"])) {
        WESessionTabItem *tab = CSCustomFromRecord(record);
        if (tab && !byID[tab.tabId]) { [custom addObject:tab]; byID[tab.tabId] = tab; }
    }
    _customTabs = [custom copy]; _presetNames = [CSNames(p[@"presetNames"]) copy];
    NSMutableArray *allIDs = [CSPresetIDs() mutableCopy];
    for (WESessionTabItem *tab in custom) [allIDs addObject:tab.tabId];
    NSMutableArray *order = [NSMutableArray new];
    for (NSString *tabID in CSStrings(p[@"tabOrder"])) if ([allIDs containsObject:tabID]) [order addObject:tabID];
    for (NSString *tabID in allIDs) if (![order containsObject:tabID]) [order addObject:tabID];
    _tabOrder = [order copy];
    NSMutableSet *hidden = [NSMutableSet new];
    for (NSString *tabID in CSStrings(p[@"hiddenPresetTabs"])) if ([CSPresetIDs() containsObject:tabID]) [hidden addObject:tabID];
    _hiddenPresetTabs = [hidden copy];
    for (NSUInteger i = 0; i < 4; i++) {
        WESessionTabItem *preset = [WESessionTabItem tabWithType:(WETabType)i];
        if (_presetNames[preset.tabId]) preset.tabName = _presetNames[preset.tabId];
        byID[preset.tabId] = preset;
    }
    NSMutableArray *visible = [NSMutableArray new];
    for (NSString *tabID in order) if (![hidden containsObject:tabID]) [visible addObject:byID[tabID]];
    if (!visible.count) [visible addObject:byID[@"preset_0"]];
    _tabs = [visible copy];
    NSString *selection = CSString(p[@"selectedTabID"]);
    NSArray *visibleIDs = [_tabs valueForKey:@"tabId"];
    if (![visibleIDs containsObject:selection ?: @""]) {
        NSArray *fallbackOrder = priorOrder ?: order;
        NSUInteger oldIndex = selection ? [fallbackOrder indexOfObject:selection] : NSNotFound;
        selection = nil;
        if (oldIndex != NSNotFound) {
            for (NSUInteger i = oldIndex + 1; i < fallbackOrder.count; i++) if ([visibleIDs containsObject:fallbackOrder[i]]) { selection = fallbackOrder[i]; break; }
        }
        selection = selection ?: _tabs.firstObject.tabId;
    }
    _selectedTabID = [selection copy];
    _filterDuplicates = [p[@"filterDuplicates"] isKindOfClass:[NSNumber class]] ? [p[@"filterDuplicates"] boolValue] : NO;
    _legacyImported = [p[@"legacyImported"] isKindOfClass:[NSNumber class]] && [p[@"legacyImported"] boolValue];
}

- (NSString *)selectionKey {
    return self.accountID.length ? [@"com.wechat.enhance.chat_group.selection." stringByAppendingString:self.accountID] : nil;
}
- (void)reload {
    id current=[self storedProfile];
    if (!self.profileLoaded || !(current==self.loadedProfile || [current isEqual:self.loadedProfile])) {
        self.loadedProfile=[current copy];
        [self applyProfile:self.loadedProfile priorOrder:nil];
        self.profileSelection=self.selectedTabID; self.profileLoaded=YES;
    }
    _selectedTabID=[self.profileSelection copy];
    NSDictionary *selection=self.selectionKey ? CSDictionary([self.defaults objectForKey:self.selectionKey]) : @{};
    if ([selection[@"version"] isEqual:@1] && [CSArray([self.tabs valueForKey:@"tabId"]) containsObject:CSString(selection[@"tabID"]) ?: @""])
        _selectedTabID=[selection[@"tabID"] copy];
}

- (NSDictionary *)profileWithCustomTabs:(NSArray *)customTabs names:(NSDictionary *)names order:(NSArray *)order hidden:(NSSet *)hidden selected:(NSString *)selected filter:(BOOL)filter imported:(BOOL)imported {
    return @{@"version": @1, @"customTabs": CSRecords(customTabs), @"presetNames": CSNames(names), @"tabOrder": CSStrings(order), @"hiddenPresetTabs": [CSStrings([hidden isKindOfClass:[NSSet class]] ? [hidden allObjects] : @[]) sortedArrayUsingSelector:@selector(compare:)], @"selectedTabID": CSString(selected) ?: @"preset_0", @"filterDuplicates": @(filter), @"legacyImported": @(imported)};
}

- (BOOL)writeProfile:(NSDictionary *)profile {
    if (!self.accountID.length) return NO;
    id oldStore = [self.defaults objectForKey:CSProfilesKey];
    id oldSelection = [self.defaults objectForKey:self.selectionKey];
    id selectionVersion = CSDictionary(oldSelection)[@"version"];
    if ([selectionVersion isKindOfClass:NSNumber.class] && [selectionVersion integerValue]>1) return NO;
    id oldProfile = CSDictionary(oldStore)[self.accountID];
    NSDictionary *oldDictionary = CSDictionary(oldProfile);
    if ([oldDictionary[@"version"] isKindOfClass:[NSNumber class]] && [oldDictionary[@"version"] integerValue] > 1) return NO;
    if (![NSPropertyListSerialization propertyList:profile isValidForFormat:NSPropertyListBinaryFormat_v1_0]) return NO;
    // Persist the normalized successor/order too, so a subsequent reload makes the same choice.
    CSGroupPreferences *normalized = [[CSGroupPreferences alloc] init];
    [normalized applyProfile:profile priorOrder:self.tabOrder];
    profile = [normalized profileWithCustomTabs:normalized.customTabs names:normalized.presetNames order:normalized.tabOrder hidden:normalized.hiddenPresetTabs selected:normalized.selectedTabID filter:normalized.filterDuplicates imported:normalized.legacyImported];
    @try {
        // Preserve first observed legacy values as-is, including the original archive bytes.
        if (![self.defaults objectForKey:CSLegacyBackupKey]) {
            NSMutableDictionary *legacy = [NSMutableDictionary new];
            for (NSString *suffix in @[@"custom_tabs", @"preset_names", @"tab_order", @"hidden_preset_tabs", @"filter_duplicate_contacts", @"selected_tab_id", @"selected_tab_index", @"currentTabIndex"]) {
                NSString *key = [CSLegacyPrefix stringByAppendingString:suffix];
                id value = [self.defaults objectForKey:key]; if (value) legacy[key] = value;
            }
            NSDictionary *backup = @{@"version": @1, @"values": legacy};
            [self.defaults setObject:backup forKey:CSLegacyBackupKey];
            if (![[self.defaults objectForKey:CSLegacyBackupKey] isEqual:backup]) return NO;
        }
        if (oldProfile) {
            NSMutableDictionary *backups = [CSDictionary([self.defaults objectForKey:CSProfileBackupsKey]) mutableCopy];
            NSDictionary *existing = CSDictionary(backups[self.accountID]);
            backups[self.accountID] = @{@"version": @1, @"original": existing[@"original"] ?: oldProfile, @"previous": oldProfile};
            [self.defaults setObject:backups forKey:CSProfileBackupsKey];
            if (![[self.defaults objectForKey:CSProfileBackupsKey] isEqual:backups]) return NO;
        }
        NSMutableDictionary *profiles = [CSDictionary(oldStore) mutableCopy];
        profiles[self.accountID] = profile;
        [self.defaults setObject:profiles forKey:CSProfilesKey];
        BOOL synchronized = [self.defaults synchronize];
        if (!synchronized || ![[self.defaults objectForKey:CSProfilesKey] isEqual:profiles]) {
            if (oldStore) [self.defaults setObject:oldStore forKey:CSProfilesKey]; else [self.defaults removeObjectForKey:CSProfilesKey];
            return NO;
        }
        [self.defaults removeObjectForKey:self.selectionKey];
        NSArray *priorOrder = self.tabOrder;
        [self applyProfile:profile priorOrder:priorOrder];
        self.loadedProfile = profile; self.profileLoaded=YES; self.profileSelection=self.selectedTabID;
        return YES;
    } @catch (NSException *exception) {
        @try { if (oldSelection) [self.defaults setObject:oldSelection forKey:self.selectionKey]; else [self.defaults removeObjectForKey:self.selectionKey]; } @catch (__unused NSException *restoreSelectionException) {}
        @try { if (oldStore) [self.defaults setObject:oldStore forKey:CSProfilesKey]; else [self.defaults removeObjectForKey:CSProfilesKey]; } @catch (NSException *restoreException) {}
        return NO;
    }
}

- (BOOL)saveCustomTabs:(NSArray *)customTabs presetNames:(NSDictionary *)presetNames tabOrder:(NSArray *)tabOrder hiddenPresetTabs:(NSSet *)hiddenPresetTabs {
    // A stale settings form cannot overwrite another editor or revive its deleted groups.
    id current = [self storedProfile];
    if ((current || self.loadedProfile) && ![current isEqual:self.loadedProfile]) return NO;
    [self reload]; // A selection-only change must not stale a settings editor.
    return [self writeProfile:[self profileWithCustomTabs:customTabs names:presetNames order:tabOrder hidden:hiddenPresetTabs selected:self.selectedTabID filter:self.filterDuplicates imported:self.legacyImported]];
}
- (void)setSelectedTabID:(NSString *)selectedTabID {
    [self reload];
    if (!self.accountID.length || !CSString(selectedTabID).length || [self.selectedTabID isEqual:selectedTabID]) return;
    NSDictionary *profile=CSDictionary(self.loadedProfile);
    if (([profile[@"version"] isKindOfClass:NSNumber.class] && [profile[@"version"] integerValue]>1) || ![[self.tabs valueForKey:@"tabId"] containsObject:selectedTabID]) return;
    NSString *key=self.selectionKey;
    id previous=[self.defaults objectForKey:key];
    id selectionVersion=CSDictionary(previous)[@"version"];
    if ([selectionVersion isKindOfClass:NSNumber.class] && [selectionVersion integerValue]>1) return;
    NSDictionary *selection=@{@"version":@1,@"tabID":selectedTabID};
    @try {
        // NSUserDefaults persists this small value asynchronously. Definition
        // validation/backups remain in writeProfile; no full-profile rewrite.
        [self.defaults setObject:selection forKey:key];
        if (![[self.defaults objectForKey:key] isEqual:selection]) {
            if (previous) [self.defaults setObject:previous forKey:key]; else [self.defaults removeObjectForKey:key];
            return;
        }
        _selectedTabID=[selectedTabID copy];
    } @catch (__unused NSException *exception) {
        @try { if (previous) [self.defaults setObject:previous forKey:key]; else [self.defaults removeObjectForKey:key]; } @catch (__unused NSException *restoreException) {}
    }
}
- (void)setFilterDuplicates:(BOOL)filterDuplicates {
    [self reload];
    [self writeProfile:[self profileWithCustomTabs:self.customTabs names:self.presetNames order:self.tabOrder hidden:self.hiddenPresetTabs selected:self.selectedTabID filter:filterDuplicates imported:self.legacyImported]];
}
- (BOOL)hasLegacyData {
    for (NSString *suffix in @[@"custom_tabs", @"preset_names", @"tab_order", @"hidden_preset_tabs", @"filter_duplicate_contacts"]) if ([self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:suffix]]) return YES;
    return NO;
}
- (BOOL)importLegacy {
    if (!self.accountID.length || !self.hasLegacyData) return NO;
    [self reload];
    if (self.legacyImported) return YES;
    NSMutableArray *merged = [self.customTabs mutableCopy];
    NSMutableSet *IDs = [NSMutableSet setWithArray:[merged valueForKey:@"tabId"]];
    NSArray *legacyRecords = CSRecords(CSArray(CSLegacyUnarchive([self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:@"custom_tabs"]])));
    for (NSDictionary *record in legacyRecords) if (![IDs containsObject:record[@"id"]]) { [merged addObject:CSCustomFromRecord(record)]; [IDs addObject:record[@"id"]]; }
    NSMutableDictionary *names = [CSNames(CSLegacyUnarchive([self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:@"preset_names"]])) mutableCopy];
    [names addEntriesFromDictionary:self.presetNames];
    NSArray *legacyOrder = CSStrings([self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:@"tab_order"]]);
    BOOL hadProfile = [self storedProfile] != nil;
    NSMutableArray *order = [(hadProfile ? self.tabOrder : legacyOrder) mutableCopy];
    for (NSString *tabID in legacyOrder) if (![order containsObject:tabID]) [order addObject:tabID];
    NSMutableSet *hidden = [self.hiddenPresetTabs mutableCopy];
    [hidden addObjectsFromArray:CSStrings([self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:@"hidden_preset_tabs"]])];
    id legacyFilter = [self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:@"filter_duplicate_contacts"]];
    BOOL filter = hadProfile ? self.filterDuplicates : ([legacyFilter isKindOfClass:[NSNumber class]] && [legacyFilter boolValue]);
    NSMutableDictionary *profile = [[self profileWithCustomTabs:merged names:names order:order hidden:hidden selected:self.selectedTabID filter:filter imported:YES] mutableCopy];
    if (!hadProfile) {
        NSString *legacySelection = CSString([self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:@"selected_tab_id"]]);
        id legacyIndex = [self.defaults objectForKey:[CSLegacyPrefix stringByAppendingString:@"currentTabIndex"]];
        if (legacySelection.length) profile[@"selectedTabID"] = legacySelection;
        else if ([legacyIndex isKindOfClass:[NSNumber class]] && [legacyIndex integerValue] >= 0) {
            CSGroupPreferences *imported = [[CSGroupPreferences alloc] init];
            [imported applyProfile:profile priorOrder:nil];
            NSUInteger index = [legacyIndex unsignedIntegerValue];
            if (index < imported.tabs.count) profile[@"selectedTabID"] = imported.tabs[index].tabId;
        }
    }
    return [self writeProfile:profile];
}
@end
