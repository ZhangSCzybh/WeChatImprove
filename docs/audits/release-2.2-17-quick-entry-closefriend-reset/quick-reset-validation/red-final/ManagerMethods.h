- (void)refreshAccount {
    NSAssert(NSThread.isMainThread,@"Account service on main");
    NSUInteger epoch=CSBackupAccountEpoch(); BOOL suspended=CSBackupAccountIsSuspended(); NSString *account=@"";
    if(!suspended) {
        account=CSCloseFriendResolveAccount(^Class(NSString *name){ return NSClassFromString(name); })?:@"";
        [self recordCapability:@"当前账号读取" available:account.length>0];
    }
    if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended()) { suspended=YES; account=@""; }
    // Recovery can finish a confirmed reset, so loading shares the account mutation lock.
    BOOL ran=CSBackupPerformAtAccountEpoch(epoch,^{
        BOOL unavailable=suspended || CSBackupAccountIsSuspended();
        [self.runtime synchronizeAccount:unavailable?@"":account epoch:epoch suspended:unavailable];
    });
    if(!ran)[self.runtime synchronizeAccount:@"" epoch:CSBackupAccountEpoch() suspended:YES];
}
- (BOOL)validateToken:(NSDictionary *)token {
    [self refreshAccount]; return !CSBackupAccountIsSuspended() && [token[@"epoch"] unsignedIntegerValue]==CSBackupAccountEpoch() && [self.runtime isTokenCurrent:token];
}
- (BOOL)canResetFrom:(UIViewController *)presenter token:(NSDictionary *)token {
    return !self.backgroundCoverRequired && UIApplication.sharedApplication.applicationState==UIApplicationStateActive &&
        presenter.view.window && [self validateToken:token] && self.runtime.isAuthorized &&
        (!presenter.navigationController || presenter.navigationController.topViewController==presenter);
}
- (void)finishResetAlert:(UIAlertController *)alert presenter:(UIViewController *)presenter completion:(void (^)(void))completion {
    // UIAlertAction may already be dismissing its alert. Never dismiss the settings
    // navigation controller or a newer modal when a stale action finishes.
    id<UIViewControllerTransitionCoordinator> transition=alert.transitionCoordinator;
    if(alert.isBeingDismissed && transition && [transition animateAlongsideTransition:nil completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context){ completion(); }])return;
    if(alert && presenter.presentedViewController==alert)[alert dismissViewControllerAnimated:YES completion:completion];
    else completion();
}
- (void)confirmResetFrom:(UIViewController *)presenter token:(NSDictionary *)token completion:(void (^)(BOOL))completion {
    if(![self canResetFrom:presenter token:token]) { [self.runtime cancelResetWithToken:token]; if(completion)completion(NO); return; }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"重置当前账号的密友？"
        message:@"将清空密友和密群名单、全部保护选项、密友密码、生物识别记录及入口发现记录。保护将关闭，“捉迷藏呀”重新隐藏。\n微信好友、聊天记录、免打扰设置和其他账号不受影响。此操作无法撤销。"
        preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlert=alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){
        [self.runtime cancelResetWithToken:token]; if(completion)completion(NO);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"重置密友" style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action){
        __block BOOL ok=NO; __block NSError *error=nil;
        if([self canResetFrom:presenter token:token])CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
            if(!CSBackupAccountIsSuspended() && [self.runtime isTokenCurrent:token])ok=[self.runtime resetWithToken:token error:&error];
        });
        [self.runtime cancelResetWithToken:token];
        self.lastRevealed=self.runtime.isAuthorized;
        [self flushPolicyRefresh];
        [self finishResetAlert:weakAlert presenter:presenter completion:^{
            if(completion)completion(ok);
            if(!ok && presenter.view.window)[self message:error.localizedDescription?:@"重置已取消，当前验证或页面已失效。请重新进入密友设置。" presenter:presenter];
        }];
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}
- (void)resetFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion {
    NSAssert(NSThread.isMainThread,@"Reset UI on main");
    [self refreshAccount]; NSDictionary *token=self.runtime.authenticationToken;
    if(![self canResetFrom:presenter token:token] || presenter.presentedViewController || self.authenticating) { if(completion)completion(NO); return; }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"验证密友密码" message:@"重置前需输入当前密友密码。验证后仍需确认才会清空。" preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlert=alert;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.secureTextEntry=YES; field.textContentType=UITextContentTypePassword; field.placeholder=@"当前密友密码"; }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){ if(completion)completion(NO); }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"验证" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        __block NSDictionary *proof=nil; __block NSError *error=nil;
        if([self canResetFrom:presenter token:token])CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
            if(!CSBackupAccountIsSuspended())proof=[self.runtime prepareResetWithPassword:weakAlert.textFields.firstObject.text?:@"" token:token error:&error];
        });
        weakAlert.textFields.firstObject.text=@"";
        [self finishResetAlert:weakAlert presenter:presenter completion:^{
            if(proof)[self confirmResetFrom:presenter token:proof completion:completion];
            else { if(completion)completion(NO); if(presenter.view.window)[self message:error.localizedDescription?:@"验证已失效，请重试。" presenter:presenter]; }
        }];
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}