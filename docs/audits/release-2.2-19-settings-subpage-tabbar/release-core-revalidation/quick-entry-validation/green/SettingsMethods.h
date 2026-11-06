- (BOOL)authorized { return self.quickEntry?[self settingsTokenIsCurrent:self.quickEntryToken]:!CSCloseFriendCurrentSnapshot().blocked && CSCloseFriendManager.sharedManager.runtime.isAuthorized; }
- (NSDictionary *)settingsProfile { return self.quickEntry?([self settingsTokenIsCurrent:self.quickEntryToken]?[CSCloseFriendManager.sharedManager.runtime profileForSettingsToken:self.quickEntryToken]:nil):CSCloseFriendCurrentProfile(); }
- (void)invalidateQuickEntry {
    if(!self.quickEntry)return;
    [CSCloseFriendManager.sharedManager.runtime invalidateSettingsAccessToken:self.quickEntryToken];
    self.quickEntryToken=nil;
    CSNativeContactPickerRevalidate(self);
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // The native member picker is a child operation of this visit. Popping or
    // replacing the settings page ends it; presenting its picker does not.
    if(self.isMovingFromParentViewController || self.isBeingDismissed || self.navigationController.isBeingDismissed ||
       (self.navigationController && self.navigationController.topViewController!=self))[self invalidateQuickEntry];
}
- (BOOL)settingsTokenIsCurrent:(NSDictionary *)token { return self.quickEntry?(token && !CSBackupAccountIsSuspended() && [token[@"epoch"] isEqual:@(CSCloseFriendAccountEpoch())] && (!self.navigationController || self.navigationController.topViewController==self) && [CSCloseFriendManager.sharedManager.runtime isSettingsTokenCurrent:token]):[CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token]; }
- (void)willMoveToParentViewController:(UIViewController *)parent {
    if(!parent)[self invalidateQuickEntry];
    [super willMoveToParentViewController:parent];
}
- (void)save:(NSDictionary *)profile {
    __block NSError *error=nil;
    __block BOOL saved=NO;
    if(self.quickEntry) {
        NSDictionary *token=self.quickEntryToken;
        CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
            if(CSBackupAccountIsSuspended())return;
            CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;
            [manager refreshAccount];
            if([self settingsTokenIsCurrent:token])saved=[manager.runtime updateProfile:profile settingsToken:token error:&error];
        });
    } else saved=CSCloseFriendUpdateCurrentProfile(profile,&error);
    if(!saved)[self showError:error];
    [self.tableView reloadData];
}