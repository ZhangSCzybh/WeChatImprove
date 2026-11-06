- (void)installCloseFriendEntryGesture {
    if(self.closeFriendEntryGesture)return;
    self.avatarImageView.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *gesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(discoverCloseFriendEntry:)];
    gesture.minimumPressDuration=2.0;
    gesture.allowableMovement=10.0;
    gesture.numberOfTouchesRequired=1;
    gesture.cancelsTouchesInView=NO;
    gesture.delegate=self;
    [self.avatarImageView addGestureRecognizer:gesture];
    self.closeFriendEntryGesture=gesture;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCloseFriendQuickEntry:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    tap.cancelsTouchesInView=NO;
    tap.delegate=self;
    // A short release fails long-press immediately; a recognized long-press suppresses tap.
    [tap requireGestureRecognizerToFail:gesture];
    [self.avatarImageView addGestureRecognizer:tap];
    self.closeFriendQuickEntryGesture=tap;
}
- (BOOL)canDiscoverCloseFriendEntry {
    UIViewController *host=CSNativeSettingsHostForContent(self);
    return self.isAuthorized && self.view.window && !self.authorizationPromptInFlight &&
        UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        (!host.navigationController || host.navigationController.topViewController==host) &&
        !host.presentedViewController && !self.presentedViewController;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    if(gesture==self.closeFriendQuickEntryGesture) {
        if(![self canDiscoverCloseFriendEntry]) { [self resetCloseFriendQuickEntry]; return NO; }
        CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;
        [manager refreshAccount];
        CSCloseFriendRuntime *runtime=manager.runtime;
        if(![self closeFriendQuickEntryTokenIsCurrent:self.closeFriendQuickEntryToken]) {
            [self resetCloseFriendQuickEntry];
            self.closeFriendQuickEntryToken=runtime.settingsAccessToken;
        }
        return [self closeFriendQuickEntryTokenIsCurrent:self.closeFriendQuickEntryToken];
    }
    if(gesture!=self.closeFriendEntryGesture)return YES;
    self.closeFriendEntryToken=nil;
    if(![self canDiscoverCloseFriendEntry])return NO;
    self.closeFriendEntryToken=[CSCloseFriendManager.sharedManager settingsEntryDiscoveryToken];
    return self.closeFriendEntryToken!=nil;
}
- (void)discoverCloseFriendEntry:(UILongPressGestureRecognizer *)gesture {
    if(gesture!=self.closeFriendEntryGesture)return;
    if(gesture.state!=UIGestureRecognizerStateBegan) {
        if(gesture.state==UIGestureRecognizerStateEnded || gesture.state==UIGestureRecognizerStateCancelled || gesture.state==UIGestureRecognizerStateFailed)self.closeFriendEntryToken=nil;
        return;
    }
    NSDictionary *token=self.closeFriendEntryToken;
    self.closeFriendEntryToken=nil;
    [self resetCloseFriendQuickEntry];
    if(![self canDiscoverCloseFriendEntry] || ![CSCloseFriendManager.sharedManager discoverSettingsEntryWithToken:token])return;
    [self setupData];
    [self.tableView reloadData];
    [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred];
}
- (void)resetCloseFriendQuickEntry {
    [CSCloseFriendManager.sharedManager.runtime invalidateSettingsAccessToken:self.closeFriendQuickEntryToken];
    self.closeFriendQuickEntryToken=nil;
    self.closeFriendQuickEntryCount=0;
    self.closeFriendQuickEntryLastTap=0;
}
- (BOOL)closeFriendQuickEntryTokenIsCurrent:(NSDictionary *)token {
    return token && !CSBackupAccountIsSuspended() && [token[@"epoch"] isEqual:@(CSCloseFriendAccountEpoch())] && [CSCloseFriendManager.sharedManager.runtime isSettingsTokenCurrent:token];
}
