- (void)setupUI {
    // 设置背景颜色
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    
    // 创建并配置tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    // Resolve section titles before the first return frame; reloads must not
    // temporarily replace their measured heights with estimates.
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    
    // 设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    
    // 设置tableView的头部视图
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册通用设置cell
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Rebuild before the first frame, including when returning under a different account.
    [self setupData];
    [self.tableView reloadData];
    // Covers direct third-party plugin registration routes before any settings content appears.
    UIView *cover=[self.view viewWithTag:871042];
    if(CSCloseFriendPluginEntryHidden() && !cover) {
        cover=[[UIView alloc] initWithFrame:self.view.bounds]; cover.tag=871042;
        cover.backgroundColor=UIColor.systemBackgroundColor; cover.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:cover];
    } else if(!CSCloseFriendPluginEntryHidden())[cover removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.returningFromAuthorization || self.authorizationPromptInFlight) return;
    if(CSCloseFriendPluginEntryHidden()) {
        CSCloseFriendAuthenticate(self,^(BOOL success){
            if(success && !CSCloseFriendPluginEntryHidden()) { [[self.view viewWithTag:871042] removeFromSuperview]; [self viewDidAppear:NO]; }
            else [self dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    [[self.view viewWithTag:871042] removeFromSuperview];

    [self setupData];
    [self.tableView reloadData];

    CSAuthorizationManager *authManager = [CSAuthorizationManager sharedManager];
    self.isAuthorized = [authManager isAuthorized];
    self.tableView.userInteractionEnabled = self.isAuthorized;
    if (!self.isAuthorized) {
        UIViewController *host = CSNativeSettingsHostForContent(self);
        if (host.presentedViewController) return;
        self.authorizationPromptInFlight = YES;
        __weak typeof(self) weakSelf = self;
        [authManager requestAuthorizationWithPresentingViewController:host completion:^(BOOL success, NSString *message) {
            typeof(self) self = weakSelf;
            if (!self) return;
            self.authorizationPromptInFlight = NO;
            self.isAuthorized = success;
            self.tableView.userInteractionEnabled = success;
            if (success) {
                [self checkUserAgreement];
            } else if ([message isEqualToString:@"用户取消授权"]) {
                [self returnFromUnauthorizedSettings];
            }
        }];
        return;
    }
    [self checkUserAgreement];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resetCloseFriendQuickEntry];
}
