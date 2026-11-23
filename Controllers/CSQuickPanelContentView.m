#import "CSQuickPanelContentView.h"
#import "CSQuickPanelPreferences.h"
#import "CSQuickPanelAppearance.h"
#import "CSSettingsHomeTheme.h"
#import "CSNavigationImageLoader.h"
#import "CSBackupBootstrap.h"
#import "../Headers/CSUserInfoHelper.h"
#import <math.h>

static UIFont *CSQuickPanelFont(CGFloat size, UIFontWeight weight, UIFontTextStyle style, CGFloat maximum) {
    return [[UIFontMetrics metricsForTextStyle:style] scaledFontForFont:[UIFont systemFontOfSize:size weight:weight]
        maximumPointSize:maximum];
}

@interface CSQuickPanelActionCell : UICollectionViewCell
@property(nonatomic, strong) UIView *iconTile;
@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *titleLabel;
- (void)configureWithIdentifier:(NSString *)identifier lightContent:(BOOL)lightContent;
@end

@implementation CSQuickPanelActionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        _iconTile=[UIView new];
        _iconTile.layer.cornerRadius=16;
        _iconTile.isAccessibilityElement=NO;
        [self.contentView addSubview:_iconTile];
        _iconView=[UIImageView new];
        _iconView.contentMode=UIViewContentModeScaleAspectFit;
        _iconView.isAccessibilityElement=NO;
        [_iconTile addSubview:_iconView];
        _titleLabel=[UILabel new];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=UIColor.labelColor;
        _titleLabel.numberOfLines=2;
        _titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        _titleLabel.isAccessibilityElement=NO;
        [self.contentView addSubview:_titleLabel];
        self.isAccessibilityElement=YES;
        self.accessibilityTraits=UIAccessibilityTraitButton;
    }
    return self;
}
- (void)configureWithIdentifier:(NSString *)identifier lightContent:(BOOL)lightContent {
    NSString *title=[CSQuickPanelPreferences titleForActionIdentifier:identifier] ?: @"快捷入口";
    NSString *symbol=[CSQuickPanelPreferences symbolNameForActionIdentifier:identifier] ?: @"square.grid.2x2";
    UIColor *accent=CSQuickPanelAppearance.iconColor;
    self.iconView.image=[UIImage systemImageNamed:symbol withConfiguration:
        [UIImageSymbolConfiguration configurationWithPointSize:25 weight:UIImageSymbolWeightRegular]];
    if (!self.iconView.image) self.iconView.image=[UIImage systemImageNamed:@"square.grid.2x2"];
    self.iconView.tintColor=accent;
    self.iconTile.backgroundColor=[CSQuickPanelAppearance iconTileColorForLightContent:lightContent];
    self.titleLabel.text=title;
    self.titleLabel.textColor=[CSQuickPanelAppearance primaryTextColorForLightContent:lightContent];
    self.titleLabel.shadowColor=[(lightContent ? UIColor.blackColor : UIColor.whiteColor) colorWithAlphaComponent:.25];
    self.titleLabel.shadowOffset=CGSizeMake(0,1);
    self.titleLabel.font=CSQuickPanelFont(12,UIFontWeightRegular,UIFontTextStyleCaption1,17);
    self.accessibilityLabel=title;
    [self setNeedsLayout];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.iconTile.transform=CGAffineTransformIdentity;
    self.iconView.image=nil;
    self.titleLabel.text=nil;
    self.accessibilityLabel=nil;
}
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    CGAffineTransform transform=highlighted ? CGAffineTransformMakeScale(.92,.92) : CGAffineTransformIdentity;
    if (UIAccessibilityIsReduceMotionEnabled()) self.iconTile.transform=transform;
    else [UIView animateWithDuration:.12 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction
        animations:^{ self.iconTile.transform=transform; } completion:nil];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.contentView.bounds);
    CGFloat tile=MIN(52,MAX(36,width-8));
    self.iconTile.frame=CGRectMake(floor((width-tile)/2),2,tile,tile);
    self.iconView.frame=CGRectMake((tile-27)/2,(tile-27)/2,27,27);
    CGFloat labelTop=CGRectGetMaxY(self.iconTile.frame)+9;
    CGFloat labelHeight=MIN(ceil(self.titleLabel.font.lineHeight*2),MAX(0,CGRectGetHeight(self.contentView.bounds)-labelTop));
    self.titleLabel.frame=CGRectMake(0,labelTop,width,labelHeight);
}
@end

@interface CSQuickPanelContentView () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UIImageView *avatarView;
@property(nonatomic, strong) UILabel *nicknameLabel;
@property(nonatomic, strong) UILabel *wechatIDLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) UIView *separator;
@property(nonatomic, strong) UICollectionView *collection;
@property(nonatomic, strong) UILabel *emptyLabel;
@property(nonatomic, strong) UIButton *emptySettingsButton;
@property(nonatomic, copy) NSArray<NSString *> *identifiers;
@property(nonatomic, strong) NSDateFormatter *timeFormatter;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSTimer *clockTimer;
@property(nonatomic, strong) CSNavigationImageRequest *avatarRequest;
@property(nonatomic, copy) NSString *displayedAccount;
@property(nonatomic, copy) NSString *displayedAvatarURL;
@property(nonatomic) NSUInteger displayedEpoch;
@property(nonatomic) NSUInteger identityGeneration;
@property(nonatomic) BOOL applicationInactive;
@property(nonatomic, weak) UIWindowScene *inactiveScene;
@end

@implementation CSQuickPanelContentView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) [self prepareContent];
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if ((self=[super initWithCoder:coder])) [self prepareContent];
    return self;
}
- (void)prepareContent {
    self.backgroundColor=UIColor.clearColor;
    _identifiers=@[];
    _applicationInactive=UIApplication.sharedApplication.applicationState!=UIApplicationStateActive;
    _avatarView=[UIImageView new];
    _avatarView.contentMode=UIViewContentModeScaleAspectFill;
    _avatarView.clipsToBounds=YES;
    _avatarView.layer.cornerRadius=14;
    _avatarView.backgroundColor=UIColor.tertiarySystemFillColor;
    _avatarView.tintColor=UIColor.tertiaryLabelColor;
    _avatarView.isAccessibilityElement=NO;
    [self addSubview:_avatarView];
    _nicknameLabel=[UILabel new];
    _nicknameLabel.textColor=UIColor.labelColor;
    _nicknameLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [self addSubview:_nicknameLabel];
    _wechatIDLabel=[UILabel new];
    _wechatIDLabel.textColor=UIColor.secondaryLabelColor;
    _wechatIDLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;
    [self addSubview:_wechatIDLabel];
    _timeLabel=[UILabel new];
    _timeLabel.textColor=UIColor.labelColor;
    _timeLabel.textAlignment=NSTextAlignmentRight;
    _timeLabel.adjustsFontSizeToFitWidth=YES;
    _timeLabel.minimumScaleFactor=.85;
    [self addSubview:_timeLabel];
    _dateLabel=[UILabel new];
    _dateLabel.textColor=UIColor.secondaryLabelColor;
    _dateLabel.textAlignment=NSTextAlignmentRight;
    _dateLabel.adjustsFontSizeToFitWidth=YES;
    _dateLabel.minimumScaleFactor=.8;
    [self addSubview:_dateLabel];
    _separator=[UIView new];
    _separator.backgroundColor=UIColor.separatorColor;
    _separator.alpha=.45;
    [self addSubview:_separator];
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing=6;
    layout.minimumLineSpacing=16;
    _collection=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collection.backgroundColor=UIColor.clearColor;
    _collection.scrollEnabled=NO;
    _collection.alwaysBounceVertical=NO;
    _collection.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    _collection.dataSource=self;
    _collection.delegate=self;
    [_collection registerClass:CSQuickPanelActionCell.class forCellWithReuseIdentifier:@"CSQuickPanelAction"];
    [self addSubview:_collection];
    _emptyLabel=[UILabel new];
    _emptyLabel.text=@"还没有快捷入口";
    _emptyLabel.font=CSQuickPanelFont(14,UIFontWeightRegular,UIFontTextStyleSubheadline,20);
    _emptyLabel.textAlignment=NSTextAlignmentCenter;
    _emptyLabel.textColor=UIColor.secondaryLabelColor;
    _emptyLabel.numberOfLines=0;
    [self addSubview:_emptyLabel];
    _emptySettingsButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [_emptySettingsButton setTitle:@"设置快捷入口" forState:UIControlStateNormal];
    _emptySettingsButton.titleLabel.font=CSQuickPanelFont(14,UIFontWeightMedium,UIFontTextStyleSubheadline,20);
    _emptySettingsButton.layer.cornerRadius=12;
    [_emptySettingsButton addTarget:self action:@selector(openPanelSettings) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_emptySettingsButton];
    NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
    for (NSString *name in @[CSQuickPanelPreferencesDidChangeNotification,CSSettingsHomeThemeDidChangeNotification,
                            UIContentSizeCategoryDidChangeNotification,@"CSBackupAccountChanged"])
        [center addObserver:self selector:@selector(contentDidChange:) name:name object:nil];
    for (NSString *name in @[UIApplicationWillResignActiveNotification,UIApplicationDidEnterBackgroundNotification,
                            UISceneWillDeactivateNotification,UISceneDidEnterBackgroundNotification,UISceneDidDisconnectNotification])
        [center addObserver:self selector:@selector(becameInactive:) name:name object:nil];
    for (NSString *name in @[UIApplicationDidBecomeActiveNotification,UISceneDidActivateNotification])
        [center addObserver:self selector:@selector(becameActive:) name:name object:nil];
    for (NSString *name in @[UIApplicationSignificantTimeChangeNotification,NSSystemTimeZoneDidChangeNotification,NSCurrentLocaleDidChangeNotification])
        [center addObserver:self selector:@selector(clockEnvironmentDidChange:) name:name object:nil];
    [self updateFonts];
    [self rebuildFormatters];
    [self reloadContent];
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [_clockTimer invalidate];
    [_avatarRequest cancel];
}
- (BOOL)isVisibleAndActive {
    if (!self.window || self.hidden || self.alpha<=0 || self.applicationInactive ||
        UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) return NO;
    UIWindowScene *scene=self.window.windowScene;
    return !scene || (scene!=self.inactiveScene && scene.activationState==UISceneActivationStateForegroundActive);
}
- (BOOL)canPrepareIdentity {
    if (self.applicationInactive || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) return NO;
    UIWindowScene *scene=self.window.windowScene;
    return !scene || (scene!=self.inactiveScene && scene.activationState==UISceneActivationStateForegroundActive);
}
- (BOOL)notificationMatchesScene:(NSNotification *)notification {
    if (![notification.object isKindOfClass:UIWindowScene.class]) return YES;
    return self.window && notification.object==self.window.windowScene;
}
- (void)didMoveToWindow {
    [super didMoveToWindow];
    if ([self isVisibleAndActive]) [self reloadContent];
    else { [self stopClock]; [self clearIdentity]; }
}
- (void)contentDidChange:(NSNotification *)notification {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf contentDidChange:notification]; });
        return;
    }
    [self reloadContent];
}
- (void)becameInactive:(NSNotification *)notification {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf becameInactive:notification]; });
        return;
    }
    if (![self notificationMatchesScene:notification]) return;
    // Will-deactivate/resign notifications can precede UIKit's state property update.
    if ([notification.object isKindOfClass:UIWindowScene.class]) self.inactiveScene=notification.object;
    else self.applicationInactive=YES;
    [self stopClock];
    [self clearIdentity];
}
- (void)becameActive:(NSNotification *)notification {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf becameActive:notification]; });
        return;
    }
    if (![self notificationMatchesScene:notification]) return;
    if ([notification.object isKindOfClass:UIWindowScene.class]) self.inactiveScene=nil;
    else self.applicationInactive=NO;
    if ([self isVisibleAndActive]) [self reloadContent];
}
- (void)clearIdentity {
    self.identityGeneration++;
    [self.avatarRequest cancel];
    self.avatarRequest=nil;
    self.displayedAccount=nil;
    self.displayedAvatarURL=nil;
    self.displayedEpoch=0;
    self.avatarView.image=[UIImage imageNamed:@"DefaultProfileHead_phone"] ?: [UIImage systemImageNamed:@"person.crop.square.fill"];
    self.nicknameLabel.text=@"微信用户";
    self.wechatIDLabel.text=@"微信号暂未获取";
    self.nicknameLabel.accessibilityLabel=nil;
    self.wechatIDLabel.accessibilityLabel=nil;
}
- (void)reloadContent {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf reloadContent]; });
        return;
    }
    [self clearIdentity];
    self.identifiers=[CSQuickPanelPreferences selectedActionIdentifiers];
    self.collection.hidden=!self.identifiers.count;
    self.emptyLabel.hidden=self.identifiers.count>0;
    self.emptySettingsButton.hidden=self.identifiers.count>0;
    [self updateFonts];
    [self updateTheme];
    [self.collection.collectionViewLayout invalidateLayout];
    [self.collection reloadData];
    if ([self canPrepareIdentity]) [self reloadIdentity];
    if ([self isVisibleAndActive]) { [self updateClock]; [self startClock]; }
    else [self stopClock];
    [self setNeedsLayout];
    [self invalidateIntrinsicContentSize];
}
- (void)reloadIdentity {
    if (!CSBackupIsReady() || CSBackupAccountIsSuspended()) return;
    NSUInteger epoch=CSBackupAccountEpoch(),generation=self.identityGeneration;
    NSString *account=[CSUserInfoHelper getUserWXID];
    if (!account.length) return;
    NSString *nickname=[CSUserInfoHelper getUserNickname];
    NSString *alias=[CSUserInfoHelper getUserAliasName];
    NSString *URLString=[CSUserInfoHelper getUserAvatarURL];
    if (!CSBackupIsReady() || CSBackupAccountIsSuspended() || CSBackupAccountEpoch()!=epoch ||
        ![[CSUserInfoHelper getUserWXID] isEqual:account]) return;
    CSBackupPerformAtAccountEpoch(epoch, ^{
        if (CSBackupAccountIsSuspended() || generation!=self.identityGeneration || ![self canPrepareIdentity]) return;
        self.displayedEpoch=epoch;
        self.displayedAccount=account;
        self.displayedAvatarURL=URLString;
        self.nicknameLabel.text=nickname.length ? nickname : @"微信用户";
        BOOL hasAlias=alias.length && ![alias isEqualToString:@"未知"];
        self.wechatIDLabel.text=hasAlias ? [@"微信号：" stringByAppendingString:alias] : @"微信号暂未获取";
        self.nicknameLabel.accessibilityLabel=self.nicknameLabel.text;
        self.wechatIDLabel.accessibilityLabel=self.wechatIDLabel.text;
    });
    NSURL *URL=URLString.length ? [NSURL URLWithString:URLString] : nil;
    if (![self isVisibleAndActive] || ![self.displayedAccount isEqual:account] ||
        !URL || ![@[@"http",@"https"] containsObject:URL.scheme.lowercaseString]) return;
    __weak typeof(self) weakSelf=self;
    self.avatarRequest=[CSNavigationImageLoader.sharedLoader loadURL:URL fallbackFileURL:nil scope:account
        maxPixelSize:(NSUInteger)(52*MAX(2,self.traitCollection.displayScale)) completion:^(UIImage *image,__unused NSURL *resolvedURL) {
        CSQuickPanelContentView *live=weakSelf;
        if (!live || generation!=live.identityGeneration) return;
        live.avatarRequest=nil;
        if (![live isVisibleAndActive] || !CSBackupIsReady() || CSBackupAccountIsSuspended() ||
            CSBackupAccountEpoch()!=epoch || ![live.displayedAccount isEqual:account] ||
            ![live.displayedAvatarURL isEqual:URLString] || ![[CSUserInfoHelper getUserWXID] isEqual:account] ||
            ![[CSUserInfoHelper getUserAvatarURL] isEqual:URLString]) return;
        CSBackupPerformAtAccountEpoch(epoch, ^{
            if (!CSBackupAccountIsSuspended() && generation==live.identityGeneration && [live isVisibleAndActive] && image)
                live.avatarView.image=image;
        });
    }];
}
- (void)updateFonts {
    self.nicknameLabel.font=[CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontNickname];
    self.wechatIDLabel.font=[CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontWeChatID];
    self.timeLabel.font=[CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontTime];
    self.dateLabel.font=[CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontDate];
    self.emptyLabel.font=CSQuickPanelFont(14,UIFontWeightRegular,UIFontTextStyleSubheadline,20);
    self.emptySettingsButton.titleLabel.font=CSQuickPanelFont(14,UIFontWeightMedium,UIFontTextStyleSubheadline,20);
}
- (void)updateTheme {
    UIColor *accent=CSQuickPanelAppearance.iconColor;
    UIColor *primary=[CSQuickPanelAppearance primaryTextColorForLightContent:self.backgroundUsesLightContent];
    UIColor *secondary=[CSQuickPanelAppearance secondaryTextColorForLightContent:self.backgroundUsesLightContent];
    for (UILabel *label in @[self.nicknameLabel,self.timeLabel]) label.textColor=primary;
    for (UILabel *label in @[self.wechatIDLabel,self.dateLabel,self.emptyLabel]) label.textColor=secondary;
    for (UILabel *label in @[self.nicknameLabel,self.wechatIDLabel,self.timeLabel,self.dateLabel,self.emptyLabel]) {
        label.shadowColor=[(self.backgroundUsesLightContent ? UIColor.blackColor : UIColor.whiteColor) colorWithAlphaComponent:.22];
        label.shadowOffset=CGSizeMake(0,1);
    }
    self.separator.backgroundColor=[primary colorWithAlphaComponent:.25];
    self.tintColor=accent;
    self.avatarView.tintColor=accent;
    self.emptySettingsButton.tintColor=primary;
    [self.emptySettingsButton setTitleColor:primary forState:UIControlStateNormal];
    self.emptySettingsButton.backgroundColor=[CSQuickPanelAppearance iconTileColorForLightContent:self.backgroundUsesLightContent];
    for (CSQuickPanelActionCell *cell in self.collection.visibleCells) {
        NSIndexPath *path=[self.collection indexPathForCell:cell];
        if (path && path.item>=0 && (NSUInteger)path.item<self.identifiers.count) [cell configureWithIdentifier:self.identifiers[path.item] lightContent:self.backgroundUsesLightContent];
    }
}
- (void)setBackgroundUsesLightContent:(BOOL)backgroundUsesLightContent {
    if (_backgroundUsesLightContent==backgroundUsesLightContent) return;
    _backgroundUsesLightContent=backgroundUsesLightContent;
    [self updateTheme];
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateTheme];
    [self setNeedsLayout];
}
- (void)rebuildFormatters {
    self.timeFormatter=[NSDateFormatter new];
    self.timeFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    self.timeFormatter.timeZone=NSTimeZone.localTimeZone;
    self.timeFormatter.dateFormat=@"HH:mm";
    self.dateFormatter=[NSDateFormatter new];
    self.dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    self.dateFormatter.timeZone=NSTimeZone.localTimeZone;
    self.dateFormatter.dateFormat=@"M月d日 EEE";
}
- (void)clockEnvironmentDidChange:(NSNotification *)notification {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf clockEnvironmentDidChange:notification]; });
        return;
    }
    [self rebuildFormatters];
    if ([self isVisibleAndActive]) { [self updateClock]; [self startClock]; }
}
- (void)updateClock {
    if (![self isVisibleAndActive]) { [self stopClock]; return; }
    if (self.displayedAccount.length && (!CSBackupIsReady() || CSBackupAccountIsSuspended() || CSBackupAccountEpoch()!=self.displayedEpoch))
        [self clearIdentity];
    NSDate *now=NSDate.date;
    self.timeLabel.text=[self.timeFormatter stringFromDate:now];
    self.dateLabel.text=[self.dateFormatter stringFromDate:now];
}
- (void)startClock {
    [self stopClock];
    if (![self isVisibleAndActive]) return;
    __weak typeof(self) weakSelf=self;
    self.clockTimer=[NSTimer timerWithTimeInterval:60 repeats:YES block:^(__unused NSTimer *timer) { [weakSelf updateClock]; }];
    NSTimeInterval now=NSDate.date.timeIntervalSince1970;
    self.clockTimer.fireDate=[NSDate dateWithTimeIntervalSince1970:floor(now/60)*60+60];
    self.clockTimer.tolerance=.4;
    [NSRunLoop.mainRunLoop addTimer:self.clockTimer forMode:NSRunLoopCommonModes];
}
- (void)stopClock {
    [self.clockTimer invalidate];
    self.clockTimer=nil;
}
- (CGFloat)headerHeight {
    CGFloat identityHeight=ceil(self.nicknameLabel.font.lineHeight)+5+ceil(self.wechatIDLabel.font.lineHeight);
    CGFloat clockHeight=ceil(self.timeLabel.font.lineHeight)+2+ceil(self.dateLabel.font.lineHeight);
    return MAX(52,MAX(identityHeight,clockHeight));
}
- (CGFloat)itemHeight {
    UIFont *font=CSQuickPanelFont(12,UIFontWeightRegular,UIFontTextStyleCaption1,17);
    return ceil(2+52+9+font.lineHeight*2+4);
}
- (CGFloat)gridTop {
    return 20+[self headerHeight]+18+1+20;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)width {
    CGFloat rows=ceil(self.identifiers.count/4.0);
    CGFloat body=rows>0 ? rows*[self itemHeight]+MAX(0,rows-1)*16 : 112;
    return ceil([self gridTop]+body+12);
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric,[self preferredHeightForWidth:CGRectGetWidth(self.bounds)]);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.bounds),inset=width<300 ? 14 : 20;
    CGFloat available=MAX(0,width-2*inset),headerHeight=[self headerHeight];
    CGFloat avatar=width<320 ? 46 : 52;
    CGFloat clockWidth=MIN(104,MAX(82,available*.32));
    CGFloat clockX=MAX(inset,width-inset-clockWidth);
    CGFloat identityX=inset+avatar+11;
    CGFloat identityWidth=MAX(0,clockX-12-identityX);
    self.avatarView.frame=CGRectMake(inset,20+(headerHeight-avatar)/2,avatar,avatar);
    CGFloat identityHeight=ceil(self.nicknameLabel.font.lineHeight)+5+ceil(self.wechatIDLabel.font.lineHeight);
    CGFloat identityY=20+(headerHeight-identityHeight)/2;
    self.nicknameLabel.frame=CGRectMake(identityX,identityY,identityWidth,ceil(self.nicknameLabel.font.lineHeight));
    self.wechatIDLabel.frame=CGRectMake(identityX,CGRectGetMaxY(self.nicknameLabel.frame)+5,identityWidth,ceil(self.wechatIDLabel.font.lineHeight));
    CGFloat timeHeight=ceil(self.timeLabel.font.lineHeight),dateHeight=ceil(self.dateLabel.font.lineHeight);
    CGFloat clockY=20+(headerHeight-timeHeight-dateHeight-2)/2;
    self.timeLabel.frame=CGRectMake(clockX,clockY,clockWidth,timeHeight);
    self.dateLabel.frame=CGRectMake(clockX,CGRectGetMaxY(self.timeLabel.frame)+2,clockWidth,dateHeight);
    CGFloat separatorY=20+headerHeight+18;
    self.separator.frame=CGRectMake(inset,separatorY,available,1/MAX(1,self.traitCollection.displayScale));
    CGFloat top=[self gridTop];
    CGFloat rows=ceil(self.identifiers.count/4.0);
    CGFloat gridHeight=rows*[self itemHeight]+MAX(0,rows-1)*16;
    CGRect collectionFrame=CGRectMake(inset,top,available,gridHeight);
    BOOL changed=!CGSizeEqualToSize(self.collection.bounds.size,collectionFrame.size);
    self.collection.frame=collectionFrame;
    if (changed) [self.collection.collectionViewLayout invalidateLayout];
    self.emptyLabel.frame=CGRectMake(inset,top+2,available,40);
    CGFloat buttonWidth=MIN(180,available);
    self.emptySettingsButton.frame=CGRectMake((width-buttonWidth)/2,top+54,buttonWidth,44);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.identifiers.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CSQuickPanelActionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CSQuickPanelAction" forIndexPath:indexPath];
    if (indexPath.item>=0 && (NSUInteger)indexPath.item<self.identifiers.count) [cell configureWithIdentifier:self.identifiers[indexPath.item] lightContent:self.backgroundUsesLightContent];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width=MAX(0,CGRectGetWidth(collectionView.bounds)-18);
    return CGSizeMake(floor(width/4),[self itemHeight]);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (![self isVisibleAndActive] || indexPath.item<0 || (NSUInteger)indexPath.item>=self.identifiers.count) return;
    if (self.actionHandler) self.actionHandler(self.identifiers[indexPath.item]);
}
- (void)openPanelSettings {
    if ([self isVisibleAndActive] && self.actionHandler) self.actionHandler(@"panel_settings");
}
@end
