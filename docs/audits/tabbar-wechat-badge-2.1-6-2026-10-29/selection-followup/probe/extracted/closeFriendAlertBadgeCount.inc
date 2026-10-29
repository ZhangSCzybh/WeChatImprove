+ (NSNumber *)closeFriendAlertBadgeCount {
    CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    BOOL filtering=[policy concealsSurface:CSCloseFriendSurfaceSession] || (policy.enabled && [policy.options[@"silenceMessages"] boolValue]);
    if(!policy.blocked && (!filtering || !policy.protectedUserNames.count))return nil;
    NSMutableSet *hidden=[policy.protectedUserNames mutableCopy];
    if(!NSThread.isMainThread || policy.blocked)return @0;
    NSUInteger epoch=CSCloseFriendAccountEpoch();
    for(CSGroupListAdapter *adapter in Adapters().allObjects) {
        if(CSGroupIsFoldedController(adapter.controller) || !adapter.cachedNativeSections || adapter.changeDepth || adapter.dirty ||
           adapter.snapshotRevision!=adapter.modelRevision || adapter.snapshotEpoch!=epoch || ![adapter.snapshotAccount isEqual:policy.accountID] ||
           ![policy.accountID isEqual:CSGroupCurrentAccountID()])continue;
        NSUInteger revision=adapter.modelRevision;
        NSArray *foldedNames=CSGroupCopyFoldedUserNames();
        NSArray *cacheKey=@[policy.accountID,@(epoch),@(revision),@(policy.revision),foldedNames ?: NSNull.null];
        if(adapter.alertBadge && [adapter.alertBadgeKey isEqual:cacheKey])return adapter.alertBadge;
        NSMutableSet *unmasked=[NSMutableSet set];
        CSGroupFoldedPrivacyState folded=CSGroupAssessFoldedUserNames(foldedNames,hidden);
        if(folded==CSGroupFoldedPrivacyAllHidden)[hidden addObject:@"chatroom_session_box"];
        else if(folded==CSGroupFoldedPrivacyNoHidden)[unmasked addObject:@"chatroom_session_box"];
        WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];
        CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:adapter.cachedNativeSections tabs:@[all] selectedTabID:all.tabId
            filterDuplicates:NO accountID:policy.accountID hiddenUserNames:hidden unmaskedAggregateUserNames:unmasked privacyRevision:policy.revision previousProjection:nil];
        if(!projection.isValid || revision!=adapter.modelRevision || epoch!=CSCloseFriendAccountEpoch() || policy.revision!=CSCloseFriendCurrentSnapshot().revision)return @0;
        adapter.alertBadgeKey=cacheKey; adapter.alertBadge=@([projection badgeForTabID:all.tabId].count);
        return adapter.alertBadge;
    }
    return @0;
}
