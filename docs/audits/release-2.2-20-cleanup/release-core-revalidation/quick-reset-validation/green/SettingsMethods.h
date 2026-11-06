- (BOOL)authorized { return self.quickEntry?[self settingsTokenIsCurrent:self.quickEntryToken]:!CSCloseFriendCurrentSnapshot().blocked && CSCloseFriendManager.sharedManager.runtime.isAuthorized; }
- (BOOL)settingsTokenIsCurrent:(NSDictionary *)token { return self.quickEntry?(token && !CSBackupAccountIsSuspended() && [token[@"epoch"] isEqual:@(CSCloseFriendAccountEpoch())] && (!self.navigationController || self.navigationController.topViewController==self) && [CSCloseFriendManager.sharedManager.runtime isSettingsTokenCurrent:token]):[CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token]; }
- (void)invalidateQuickEntry {
    if(!self.quickEntry)return;
    [CSCloseFriendManager.sharedManager.runtime invalidateSettingsAccessToken:self.quickEntryToken];
    self.quickEntryToken=nil;
    CSNativeContactPickerRevalidate(self);
    [self.tableView reloadData];
}
- (void)resetCloseFriends {
    if(self.requestingAuthentication || ![self authorized])return;
    self.requestingAuthentication=YES;
    __weak typeof(self) weakSelf=self;
    void (^completion)(BOOL)=^(BOOL success){
        typeof(self) self=weakSelf; if(!self)return;
        self.requestingAuthentication=NO;
        if(!success) { [self.tableView reloadData]; return; }
        [self invalidateQuickEntry];
        self.resetFinished=YES;
        [self.tableView reloadData];
        [self leaveAfterReset];
    };
    if(self.quickEntry)[CSCloseFriendManager.sharedManager resetFrom:self settingsToken:self.quickEntryToken completion:completion];
    else [CSCloseFriendManager.sharedManager resetFrom:self completion:completion];
}
- (void)tableView:(TableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; if(![self authorized])return;
    if(indexPath.section==0 && indexPath.row==3 && self.quickEntry) {
        [self showError:[NSError errorWithDomain:@"CSCloseFriendSettings" code:3 userInfo:@{NSLocalizedDescriptionKey:@"修改密码须从普通入口验证当前密友密码；快捷入口不提供凭据验证。"}]]; return;
    }
    if(indexPath.section==2) { [self resetCloseFriends]; return; }
    }