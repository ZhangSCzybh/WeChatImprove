#import "CSBackupMutation.h"
#import "CSContactSeparatorSettingsViewController.h"
#import "CSSettingTableViewCell.h"
#import "CSContactSeparatorManager.h"
#import "CSNavigationTitleSettingsViewController.h"
#import "CSNavigationImageLoader.h"
#import "CSChatNativeBridge.h"

@interface CSContactSeparatorSettingsViewController ()

@property (nonatomic, strong) NSArray<CSSettingSection *> *sections;
@property (nonatomic, assign) BOOL customEnabled;
@property (nonatomic, copy) NSString *separatorText;
@property (nonatomic, strong) UIImage *separatorImage;
@property (nonatomic, copy) NSString *separatorImagePath;
@property (nonatomic, assign) CGFloat separatorSize;
@property (nonatomic, assign) CGFloat avatarSpacing;
@property (nonatomic, assign) CGFloat verticalOffset;
@property (nonatomic, strong) CSNavigationImageBinding *avatarBinding;
@property (nonatomic, copy) NSString *avatarURL, *avatarAccount;
@property (nonatomic, weak) UIImageView *avatarImageView;
@property (nonatomic, assign) BOOL avatarActive;

@end

@implementation CSContactSeparatorSettingsViewController

- (void)configureContactAvatarURL:(NSString *)url account:(NSString *)account {
    [self.avatarBinding cancel];
    self.avatarURL=[url copy];self.avatarAccount=[account copy];
    [self loadContactAvatar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];self.avatarActive=YES;[self loadContactAvatar];
}
- (void)viewWillDisappear:(BOOL)animated {
    self.avatarActive=NO;[self.avatarBinding cancel];[super viewWillDisappear:animated];
}
- (void)loadContactAvatar {
    UIImageView *view=self.avatarImageView;
    if (!view) return;
    if (!self.avatarURL.length) {
        [self.avatarBinding cancel];view.image=self.contactAvatar ?: [UIImage imageNamed:@"DefaultProfileHead_phone"];return;
    }
    if (!self.avatarBinding) self.avatarBinding=[CSNavigationImageBinding new];
    NSString *account=[self.avatarAccount copy] ?: @"", *contactID=[self.contactId copy] ?: @"", *url=[self.avatarURL copy];
    __weak typeof(self) weakSelf=self;
    __weak UIImageView *weakView=view;
    [self.avatarBinding displayURL:[NSURL URLWithString:url] scope:account identity:@[contactID]
        maxPixelSize:(NSUInteger)ceil(40*UIScreen.mainScreen.scale) inImageView:view ifCurrent:^BOOL {
            CSContactSeparatorSettingsViewController *live=weakSelf;
            return live && live.avatarActive && live.viewIfLoaded.window && weakView.window &&
                live.avatarImageView==weakView && [account isEqual:CSMessageCurrentAccount()] &&
                [account isEqual:live.avatarAccount] && [contactID isEqual:live.contactId] && [url isEqual:live.avatarURL];
        }];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section==0 && self.avatarImageView.superview==view) {
        [self.avatarBinding cancel];self.avatarImageView=nil;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section!=0) return;
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(),^{ [weakSelf loadContactAvatar]; });
}

- (instancetype)initWithContactId:(NSString *)contactId contactName:(nullable NSString *)contactName contactAvatar:(nullable UIImage *)contactAvatar {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        _contactId = [contactId copy];
        _contactName = [contactName copy];
        _contactAvatar = contactAvatar;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = self.contactName ?: @"个性化分隔符";
    self.title = [NSString stringWithFormat:@"%@ 的分隔符", title];
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 54, 0, 0);
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    
    [CSSettingTableViewCell registerToTableView:self.tableView];
    
    [self loadSettings];
    [self setupData];
}

- (void)loadSettings {
    CSContactSeparatorManager *manager = [CSContactSeparatorManager sharedManager];
    CSContactSeparatorConfig *config = [manager configForContactId:self.contactId];
    
    if (config) {
        self.customEnabled = config.enabled;
        self.separatorText = config.separatorText ?: @"💗";
        self.separatorSize = config.separatorSize > 0 ? config.separatorSize : kDefaultSeparatorSize;
        self.avatarSpacing = config.avatarSpacing > 0 ? config.avatarSpacing : kDefaultAvatarSpacing;
        self.verticalOffset = config.verticalOffset;
        
        if (config.separatorImagePath.length > 0) {
            self.separatorImagePath = config.separatorImagePath;
            if ([[NSFileManager defaultManager] fileExistsAtPath:config.separatorImagePath]) {
                NSData *imageData = [NSData dataWithContentsOfFile:config.separatorImagePath];
                self.separatorImage = [UIImage imageWithData:imageData];
            }
        }
    } else {
        self.customEnabled = NO;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.separatorText = [defaults objectForKey:kNavigationSeparatorTextKey] ?
                            [defaults stringForKey:kNavigationSeparatorTextKey] : @"💗";
        self.separatorSize = [defaults objectForKey:kNavigationSeparatorSizeKey] ?
                            [defaults floatForKey:kNavigationSeparatorSizeKey] : kDefaultSeparatorSize;
        self.avatarSpacing = [defaults objectForKey:kNavigationAvatarSpacingKey] ?
                            [defaults floatForKey:kNavigationAvatarSpacingKey] : kDefaultAvatarSpacing;
        self.verticalOffset = [defaults objectForKey:kNavigationVerticalOffsetKey] ?
                            [defaults floatForKey:kNavigationVerticalOffsetKey] : kDefaultVerticalOffset;
        
        NSString *imagePath = [defaults objectForKey:kNavigationSeparatorImageKey];
        if (imagePath && [[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
            self.separatorImagePath = imagePath;
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            self.separatorImage = [UIImage imageWithData:imageData];
        }
    }
}

- (void)saveSettings {
    CSContactSeparatorConfig *config = [[CSContactSeparatorConfig alloc] init];
    config.enabled = self.customEnabled;
    config.separatorText = self.separatorText;
    config.separatorImagePath = self.separatorImagePath;
    config.separatorSize = self.separatorSize;
    config.avatarSpacing = self.avatarSpacing;
    config.verticalOffset = self.verticalOffset;
    
    CSContactSeparatorManager *manager = [CSContactSeparatorManager sharedManager];
    [manager setConfig:config forContactId:self.contactId];
}

- (void)setupData {
    __weak typeof(self) weakSelf = self;
    
    CSSettingItem *enableItem = [CSSettingItem switchItemWithTitle:@"启用个性化分隔符"
                                                         iconName:@"person.crop.circle.badge.checkmark"
                                                        iconColor:[UIColor systemBlueColor]
                                                       switchValue:self.customEnabled
                                                  valueChangedBlock:^(BOOL isOn) {
        weakSelf.customEnabled = isOn;
        [weakSelf saveSettings];
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
    }];
    
    CSSettingSection *enableSection = [CSSettingSection sectionWithHeader:@"设置状态"
                                                                  items:@[enableItem]];
    
    if (!self.customEnabled) {
        self.sections = @[enableSection];
        return;
    }
    
    NSMutableArray<CSSettingItem *> *separatorItems = [NSMutableArray array];
    
    CSSettingItem *textItem = [CSSettingItem inputItemWithTitle:@"分隔符文本"
                                                      iconName:@"textformat"
                                                     iconColor:[UIColor systemOrangeColor]
                                                     inputValue:self.separatorText
                                                 inputPlaceholder:@"输入分隔符文本，如💗"
                                                valueChangedBlock:^(NSString *value) {
        weakSelf.separatorText = value.length > 0 ? value : @"💗";
        weakSelf.separatorImagePath = nil;
        weakSelf.separatorImage = nil;
        [weakSelf saveSettings];
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
    }];
    [separatorItems addObject:textItem];
    
    NSString *imageDetail = self.separatorImage ? @"已设置" : @"点击选择";
    CSSettingItem *imageItem = [CSSettingItem itemWithTitle:@"分隔符图片"
                                                  iconName:@"photo"
                                                 iconColor:[UIColor systemPurpleColor]
                                                    detail:imageDetail];
    imageItem.actionBlock = ^{
        [weakSelf showImagePicker];
    };
    [separatorItems addObject:imageItem];
    
    if (self.separatorImage || self.separatorImagePath.length) {
        CSSettingItem *clearImageItem = [CSSettingItem actionItemWithTitle:@"清除分隔符图片"
                                                                 iconName:@"xmark.circle"
                                                                iconColor:[UIColor systemRedColor]];
        clearImageItem.actionBlock = ^{
            weakSelf.separatorImage = nil;
            weakSelf.separatorImagePath = nil;
            [weakSelf saveSettings];
            [weakSelf setupData];
            [weakSelf.tableView reloadData];
        };
        [separatorItems addObject:clearImageItem];
    }
    
    CSSettingSection *separatorSection = [CSSettingSection sectionWithHeader:@"分隔符设置"
                                                                      items:separatorItems];
    
    NSMutableArray<CSSettingItem *> *styleItems = [NSMutableArray array];
    
    CSSettingItem *sizeItem = [CSSettingItem inputItemWithTitle:@"分隔符大小"
                                                      iconName:@"arrow.up.left.and.arrow.down.right"
                                                     iconColor:[UIColor systemGreenColor]
                                                     inputValue:[NSString stringWithFormat:@"%.1f", self.separatorSize]
                                                 inputPlaceholder:@"默认22"
                                                valueChangedBlock:^(NSString *value) {
        CGFloat size = [value floatValue];
        if (size < 5) size = 5;
        if (size > 50) size = 50;
        weakSelf.separatorSize = size;
        [weakSelf saveSettings];
    }];
    [styleItems addObject:sizeItem];
    
    CSSettingItem *spacingItem = [CSSettingItem inputItemWithTitle:@"头像间距"
                                                         iconName:@"arrow.left.and.right"
                                                        iconColor:[UIColor systemTealColor]
                                                        inputValue:[NSString stringWithFormat:@"%.1f", self.avatarSpacing]
                                                    inputPlaceholder:@"默认4"
                                                   valueChangedBlock:^(NSString *value) {
        CGFloat spacing = [value floatValue];
        if (spacing < 0) spacing = 0;
        if (spacing > 20) spacing = 20;
        weakSelf.avatarSpacing = spacing;
        [weakSelf saveSettings];
    }];
    [styleItems addObject:spacingItem];
    
    CSSettingItem *offsetItem = [CSSettingItem inputItemWithTitle:@"垂直偏移"
                                                        iconName:@"arrow.up.and.down"
                                                       iconColor:[UIColor systemIndigoColor]
                                                       inputValue:[NSString stringWithFormat:@"%.1f", self.verticalOffset]
                                                   inputPlaceholder:@"默认0"
                                                  valueChangedBlock:^(NSString *value) {
        weakSelf.verticalOffset = [value floatValue];
        [weakSelf saveSettings];
    }];
    [styleItems addObject:offsetItem];
    
    CSSettingSection *styleSection = [CSSettingSection sectionWithHeader:@"样式设置"
                                                                  items:styleItems];
    
    CSSettingItem *resetItem = [CSSettingItem actionItemWithTitle:@"重置为全局设置"
                                                        iconName:@"arrow.counterclockwise"
                                                       iconColor:[UIColor systemRedColor]];
    resetItem.actionBlock = ^{
        [weakSelf resetToGlobal];
    };
    
    CSSettingSection *resetSection = [CSSettingSection sectionWithHeader:@"重置"
                                                                  items:@[resetItem]];
    
    self.sections = @[enableSection, separatorSection, styleSection, resetSection];
}

- (void)resetToGlobal {
    CSContactSeparatorManager *manager = [CSContactSeparatorManager sharedManager];
    [manager removeConfigForContactId:self.contactId];
    
    [self loadSettings];
    [self setupData];
    [self.tableView reloadData];
}

- (void)showImagePicker {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择分隔符图片"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
        [self presentImagePickerWithSource:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"从相册选择"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
        [self presentImagePickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alert addAction:cameraAction];
    }
    [alert addAction:libraryAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)presentImagePickerWithSource:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    
    if (selectedImage) {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self saveSeparatorImage:selectedImage];
        }];
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveSeparatorImage:(UIImage *)image {
    CSBackupResourceMutationScope();
    NSString *prefsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    prefsPath = [prefsPath stringByAppendingPathComponent:@"Preferences"];
    NSString *enhanceFolderPath = [prefsPath stringByAppendingPathComponent:@"WeChatImprove"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:enhanceFolderPath]) {
        [fileManager createDirectoryAtPath:enhanceFolderPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"separator_%@.png", self.contactId];
    NSString *filePath = [enhanceFolderPath stringByAppendingPathComponent:fileName];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if ([imageData writeToFile:filePath atomically:YES]) {
        self.separatorImage = image;
        self.separatorImagePath = filePath;
        [self saveSettings];
        [self setupData];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSettingTableViewCell reuseIdentifier]
                                                                forIndexPath:indexPath];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    [cell configureWithItem:item];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSSettingItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    if (item.itemType == CSSettingItemTypeAction || item.itemType == CSSettingItemTypeNormal) {
        if (item.actionBlock) {
            item.actionBlock();
        }
    } else if (item.itemType == CSSettingItemTypeInput) {
        [self showInputAlertForItem:item];
    }
}

- (void)showInputAlertForItem:(CSSettingItem *)item {
    [CSUIHelper showInputAlertWithTitle:item.title
                                message:nil
                            initialValue:item.inputValue
                            placeholder:item.inputPlaceholder
                       inViewController:self
                               completion:^(NSString *value) {
        if (item.inputValueChanged) {
            item.inputValueChanged(value);
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 60;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.contactName) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
        
        UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        avatarView.layer.cornerRadius = 20;
        avatarView.layer.masksToBounds = YES;
        avatarView.contentMode = UIViewContentModeScaleAspectFill;
        
        if (self.contactAvatar) {
            avatarView.image = self.contactAvatar;
        } else {
            avatarView.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
            avatarView.backgroundColor = [UIColor systemGray5Color];
        }
        [headerView addSubview:avatarView];
        self.avatarImageView=avatarView;
        [self loadContactAvatar];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, tableView.bounds.size.width - 90, 30)];
        nameLabel.text = self.contactName;
        nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        nameLabel.textColor = [UIColor labelColor];
        [headerView addSubview:nameLabel];
        
        return headerView;
    }
    return nil;
}

@end
