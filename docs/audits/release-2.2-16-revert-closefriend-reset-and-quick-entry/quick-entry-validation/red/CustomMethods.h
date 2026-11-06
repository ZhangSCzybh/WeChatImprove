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
}
- (BOOL)canDiscoverCloseFriendEntry {
    UIViewController *host=CSNativeSettingsHostForContent(self);
    return self.isAuthorized && self.view.window && !self.authorizationPromptInFlight &&
        UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        (!host.navigationController || host.navigationController.topViewController==host) &&
        !host.presentedViewController && !self.presentedViewController;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
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
    if(![self canDiscoverCloseFriendEntry] || ![CSCloseFriendManager.sharedManager discoverSettingsEntryWithToken:token])return;
    [self setupData];
    [self.tableView reloadData];
    [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred];
}