- (BOOL)validateToken:(NSDictionary *)token {
    [self refreshAccount]; return !CSBackupAccountIsSuspended() && [token[@"epoch"] unsignedIntegerValue]==CSBackupAccountEpoch() && [self.runtime isTokenCurrent:token];
}
- (void)passwordPrompt:(UIViewController *)presenter token:(NSDictionary *)token setup:(BOOL)setup completion:(void (^)(BOOL))completion {
    NSString *reason=self.passwordFallbackReason; self.passwordFallbackReason=nil;
    NSString *message=setup?@"设置至少 6 位数字或 8 个字符的密码后才可启用（最长 128 个字符）。请妥善保存；无法通过普通备份恢复凭据。":@"验证后临时显示密友。后台、锁定或账号切换会立即失效。";
    if(reason.length && !setup)message=[NSString stringWithFormat:@"%@\n%@",reason,message];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:setup?@"设置密友密码":@"验证密友密码" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.secureTextEntry=YES; field.placeholder=@"密码"; field.textContentType=setup?UITextContentTypeNewPassword:UITextContentTypePassword; }];
    if(setup)[alert addTextFieldWithConfigurationHandler:^(UITextField *field){ field.secureTextEntry=YES; field.placeholder=@"再次输入密码"; }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action){ self.authenticating=NO; if(completion)completion(NO); }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action){
        self.authenticating=NO; __block NSError *error=nil; __block BOOL ok=NO;
        if([self validateToken:token]) {
            NSString *password=alert.textFields.firstObject.text?:@"";
            if(setup && ![password isEqual:alert.textFields.lastObject.text])error=[NSError errorWithDomain:@"CSCloseFriend" code:1 userInfo:@{NSLocalizedDescriptionKey:@"两次输入的密码不一致。"}];
            if(!error)CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
                if(CSBackupAccountIsSuspended())return;
                ok=setup?[self.runtime setPassword:password token:token error:&error]:[self.runtime authenticatePassword:password token:token error:&error];
            });
        }
        self.lastRevealed=CSCloseFriendCurrentSnapshot().revealed;
        if(completion)completion(ok);
        if(!ok)[self message:error.localizedDescription?:@"验证已失效，请重试。" presenter:presenter];
    }]];
    [presenter presentViewController:alert animated:YES completion:nil];
}
- (void)authenticateFrom:(UIViewController *)presenter completion:(void (^)(BOOL))completion {
    if(!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(),^{ [self authenticateFrom:presenter completion:completion]; }); return; }
    [self start]; [self refreshAccount];
    if(self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) { if(completion)completion(NO); return; }
    if([self.runtime isAuthorized]) { if(completion)completion(YES); return; }
    NSDictionary *token=self.runtime.authenticationToken;
    if(!token || self.authenticating || !presenter.view.window) {
        if(completion)completion(NO);
        if(!token && presenter.view.window)[self message:@"当前账号或密友安全数据不可用。现有数据已保留，请在解锁设备并进入微信首页后重试。" presenter:presenter];
        return;
    }
    self.authenticating=YES;
    BOOL setup=![self.runtime hasCredential];
    if(!setup && [self.runtime.currentProfile[@"options"][@"biometric"] boolValue]) {
        LAContext *context=[LAContext new]; self.authenticationContext=context;
        context.touchIDAuthenticationAllowableReuseDuration=0;
        context.localizedFallbackTitle=@"使用密友密码";
        NSError *error=nil; BOOL available=[context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        [self recordCapability:@"生物识别" available:available];
        if(available) {
            self.biometricCompletion=completion;
            __weak typeof(self) weakSelf=self;
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证后临时显示密友" reply:^(BOOL success,NSError *error){
                dispatch_async(dispatch_get_main_queue(),^{
                    [weakSelf finishBiometricContext:context token:token presenter:presenter success:success error:error];
                });
            }]; return;
        }
        self.authenticationContext=nil; [context invalidate];
        [self biometricPasswordFallbackFrom:presenter token:token reason:[self biometricFailureReason:error] domainState:nil completion:completion];
        return;
    }
    [self passwordPrompt:presenter token:token setup:setup completion:completion];
}
- (BOOL)settingsEntryVisible {
    [self start]; [self refreshAccount];
    return [self.entryState isEntryVisibleForSnapshot:CSCloseFriendCurrentSnapshot() hasCredential:self.runtime.hasCredential];
}
- (NSDictionary *)settingsEntryDiscoveryToken {
    [self start]; [self refreshAccount];
    if(self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive ||
       [self.entryState hasDiscoveredEntryForSnapshot:CSCloseFriendCurrentSnapshot() hasCredential:self.runtime.hasCredential])return nil;
    return self.runtime.authenticationToken;
}
- (BOOL)discoverSettingsEntryWithToken:(NSDictionary *)token {
    if(!NSThread.isMainThread || !token || self.backgroundCoverRequired || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive)return NO;
    __block BOOL discovered=NO;
    CSBackupPerformAtAccountEpoch([token[@"epoch"] unsignedIntegerValue],^{
        if(![self validateToken:token])return;
        discovered=[self.entryState discoverEntryForSnapshot:CSCloseFriendCurrentSnapshot() hasCredential:self.runtime.hasCredential];
    });
    return discovered;
}
- (void)presentSettingsFrom:(UIViewController *)presenter {
    if(![self settingsEntryVisible])return;
    [self authenticateFrom:presenter completion:^(BOOL success){
        if(!success)return;
        CSCloseFriendSettingsViewController *settings=[[CSCloseFriendSettingsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped];
        if(presenter.navigationController)[presenter.navigationController pushViewController:settings animated:YES];
        else [presenter presentViewController:[[UINavigationController alloc] initWithRootViewController:settings] animated:YES completion:nil];
    }];
}
