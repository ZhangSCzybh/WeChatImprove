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
- (NSTimeInterval)closeFriendQuickEntryTimestamp { return NSProcessInfo.processInfo.systemUptime; }
- (void)tapCloseFriendQuickEntry:(UITapGestureRecognizer *)gesture {
    if(gesture!=self.closeFriendQuickEntryGesture || gesture.state!=UIGestureRecognizerStateEnded)return;
    if(![self canDiscoverCloseFriendEntry] || ![self closeFriendQuickEntryTokenIsCurrent:self.closeFriendQuickEntryToken]) { [self resetCloseFriendQuickEntry]; return; }
    NSTimeInterval now=[self closeFriendQuickEntryTimestamp];
    if(!self.closeFriendQuickEntryCount || now<self.closeFriendQuickEntryLastTap || now>self.closeFriendQuickEntryLastTap+0.8)self.closeFriendQuickEntryCount=0;
    self.closeFriendQuickEntryLastTap=now;
    if(++self.closeFriendQuickEntryCount<5)return;
    self.closeFriendQuickEntryCount=0;
    self.closeFriendQuickEntryLastTap=0;
    [self confirmCloseFriendQuickEntryWithToken:self.closeFriendQuickEntryToken];
}
- (void)confirmCloseFriendQuickEntryWithToken:(NSDictionary *)token {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"无密码进入密友设置" message:@"此入口无需密码，可查看和修改当前账号的密友、密群名单及保护选项。任何能操作这台已解锁手机的人，连续点击头像 5 次也能进入。进入本身不会解锁微信列表中的密友；主动修改保护选项会影响隐藏规则。离开设置流程、进入后台或切换账号后入口失效。修改密码和重置密友仍须原密码验证。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){ [self resetCloseFriendQuickEntry]; }]];
    __weak UIAlertController *weakAlert=alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"进入密友设置" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action){
        [self finishCloseFriendQuickEntryAlert:weakAlert completion:^{
            CSCloseFriendManager *manager=CSCloseFriendManager.sharedManager;
            [manager refreshAccount];
            if(![self canDiscoverCloseFriendEntry] || ![self closeFriendQuickEntryTokenIsCurrent:token]) { [self resetCloseFriendQuickEntry]; return; }
            CSCloseFriendSettingsViewController *settings=[[CSCloseFriendSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
            settings.quickEntry=YES;
            settings.quickEntryToken=token;
            self.closeFriendQuickEntryToken=nil;
            UIViewController *host=CSNativeSettingsHostForContent(self);
            if(host.navigationController)[host.navigationController pushViewController:settings animated:YES];
            else [host presentViewController:[[UINavigationController alloc] initWithRootViewController:settings] animated:YES completion:nil];
        }];
    }]];
    [CSNativeSettingsHostForContent(self) presentViewController:alert animated:YES completion:nil];
}
- (void)finishCloseFriendQuickEntryAlert:(UIAlertController *)alert completion:(void (^)(void))completion {
    id<UIViewControllerTransitionCoordinator> transition=alert.transitionCoordinator;
    if(alert.isBeingDismissed && transition && [transition animateAlongsideTransition:nil completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context){ completion(); }])return;
    UIViewController *host=CSNativeSettingsHostForContent(self);
    if(alert && host.presentedViewController==alert)[alert dismissViewControllerAnimated:YES completion:completion];
    else completion();
}
- (BOOL)closeFriendQuickEntryTokenIsCurrent:(NSDictionary *)token {
    return token && !CSBackupAccountIsSuspended() && [token[@"epoch"] isEqual:@(CSCloseFriendAccountEpoch())] && [CSCloseFriendManager.sharedManager.runtime isSettingsTokenCurrent:token];
}