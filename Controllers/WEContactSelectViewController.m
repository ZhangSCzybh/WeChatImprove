#import "WEContactSelectViewController.h"
#import "CSServiceCenter.h"
#import "CSGroupNativeBridge.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface WEContactSelectViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) NSMutableSet<NSString *> *selectedUserNames;
@property (nonatomic, assign) WEContactSelectType selectType;
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *filteredContacts;
@property (nonatomic, assign) BOOL isSearching;

@end

@interface CContact : NSObject
@property (nonatomic, copy) NSString *m_nsUsrName;
@property (nonatomic, copy) NSString *m_nsNickName;
@property (nonatomic, copy) NSString *m_nsHeadImgUrl;
@property (nonatomic, copy) NSString *m_nsAliasName;
@property (nonatomic, copy) NSString *m_nsRemark;
@property (nonatomic, assign) int m_uiContactType;
@property (nonatomic, assign) int m_uiCertifyFlag;
- (NSString *)getContactDisplayName;
- (BOOL)isMyContact;
@end

@interface CContactMgr : NSObject
- (CContact *)getSelfContact;
- (NSArray *)getAllContactUserName;
- (CContact *)getContactForSearchByName:(NSString *)userName;
@end

@interface MMServiceCenter : NSObject
+ (instancetype)defaultCenter;
- (id)getService:(Class)serviceClass;
@end

@implementation WEContactSelectViewController

- (instancetype)initWithTitle:(NSString *)title selectedUserNames:(NSArray<NSString *> *)selectedUserNames selectType:(WEContactSelectType)selectType {
    return [self initWithTitle:title selectedUserNames:selectedUserNames selectType:selectType tagName:nil];
}

- (instancetype)initWithTitle:(NSString *)title selectedUserNames:(NSArray<NSString *> *)selectedUserNames selectType:(WEContactSelectType)selectType tagName:(NSString *)tagName {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _titleText = [title copy];
        _selectedUserNames = [NSMutableSet set];
        // This is the complete group membership, including names outside this picker category.
        for (id name in selectedUserNames) {
            if ([name isKindOfClass:NSString.class] && [name length]) [_selectedUserNames addObject:name];
        }
        _selectType = selectType;
        _tagName = [tagName copy];
        _isSearching = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleText ?: @"选择联系人";
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelButtonTapped)];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(doneButtonTapped)];
    
    if (self.selectType == WEContactSelectTypeTag) {
        UIBarButtonItem *selectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"全选"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(selectAllButtonTapped)];
        self.navigationItem.rightBarButtonItems = @[doneItem, selectAllItem];
    } else {
        self.navigationItem.rightBarButtonItem = doneItem;
    }
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"搜索";
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    [self loadContacts];
    [self updateRightBarButtonTitle];
    [self updateSelectAllButtonTitle];
}

- (void)loadContacts {
    NSMutableArray *contactList = [NSMutableArray array];
    
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self loadContactsInternal:contactList];
        });
    } else {
        [self loadContactsInternal:contactList];
    }
    
    self.contacts = [contactList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = [obj1 m_nsRemark];
        if (name1.length == 0) {
            name1 = [obj1 m_nsNickName];
        }
        NSString *name2 = [obj2 m_nsRemark];
        if (name2.length == 0) {
            name2 = [obj2 m_nsNickName];
        }
        
        if (!name1) name1 = @"";
        if (!name2) name2 = @"";
        
        BOOL isLetter1 = [self isFirstCharacterLetter:name1];
        BOOL isLetter2 = [self isFirstCharacterLetter:name2];
        
        if (isLetter1 && !isLetter2) {
            return NSOrderedAscending;
        } else if (!isLetter1 && isLetter2) {
            return NSOrderedDescending;
        }
        
        return [name1 localizedStandardCompare:name2];
    }];
    self.filteredContacts = self.contacts;
}

- (BOOL)isFirstCharacterLetter:(NSString *)string {
    if (string.length == 0) return NO;
    
    unichar firstChar = [string characterAtIndex:0];
    
    if ((firstChar >= 'a' && firstChar <= 'z') ||
        (firstChar >= 'A' && firstChar <= 'Z')) {
        return YES;
    }
    
    if (firstChar >= 0x4E00 && firstChar <= 0x9FA5) {
        return YES;
    }
    
    return NO;
}

- (void)loadContactsInternal:(NSMutableArray *)contactList {
    @try {
        Class contactMgrClass = objc_getClass("CContactMgr");
        
        if (!contactMgrClass) {
            return;
        }
        
        CContactMgr *contactMgr = CSGetService(contactMgrClass);
        if (!contactMgr) {
            return;
        }
        
        NSArray<NSString *> *contactSelectors = @[@"getContactByName:", @"getContactByNameFromDB:", @"getContactByNameFromCache:", @"getContactForSearchByName:"];
        
        if (self.selectType == WEContactSelectTypeTag && self.tagName.length > 0) {
            Class tagMgrClass = objc_getClass("ContactTagMgr");
            if (tagMgrClass) {
                id tagMgr = CSGetService(tagMgrClass);
                if (tagMgr) {
                    SEL getContactsForTagNameSel = NSSelectorFromString(@"getContactsForTagName:");
                    if ([tagMgr respondsToSelector:getContactsForTagNameSel]) {
                        NSArray *tagContacts = ((id (*)(id, SEL, id))objc_msgSend)(tagMgr, getContactsForTagNameSel, self.tagName);
                        if (tagContacts && tagContacts.count > 0) {
                            Class contactClass = NSClassFromString(@"CContact");
                            id firstItem = tagContacts.firstObject;
                            
                            if (contactClass && [firstItem isKindOfClass:contactClass]) {
                                for (id contact in tagContacts) {
                                    [contactList addObject:contact];
                                }
                            } else if ([firstItem isKindOfClass:[NSString class]]) {
                                for (NSString *userName in tagContacts) {
                                    CContact *contact = nil;
                                    for (NSString *selectorName in contactSelectors) {
                                        SEL selector = NSSelectorFromString(selectorName);
                                        if ([contactMgr respondsToSelector:selector]) {
                                            @try {
                                                contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, selector, userName);
                                                if (contact) break;
                                            } @catch (NSException *e) {
                                            }
                                        }
                                    }
                                    if (contact) {
                                        [contactList addObject:contact];
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return;
        }
        
        NSArray<NSString *> *selectors = @[@"getAllContactUserName", @"getAllContactUserNameFromCache"];
        NSArray *allUserNames = nil;
        
        for (NSString *selectorName in selectors) {
            SEL selector = NSSelectorFromString(selectorName);
            if ([contactMgr respondsToSelector:selector]) {
                allUserNames = ((id (*)(id, SEL))objc_msgSend)(contactMgr, selector);
                if (allUserNames.count > 0) {
                    break;
                }
            }
        }
        
        if (!allUserNames || allUserNames.count == 0) {
            return;
        }
        
        for (NSString *userName in allUserNames) {
            if (![userName isKindOfClass:NSString.class] || !userName.length) continue;
            CContact *contact = nil;
            for (NSString *selectorName in contactSelectors) {
                SEL selector = NSSelectorFromString(selectorName);
                if ([contactMgr respondsToSelector:selector]) {
                    @try {
                        contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, selector, userName);
                        if (contact) break;
                    } @catch (__unused NSException *exception) {}
                }
            }
            if (!contact) continue;
            CSGroupRowCategory category = CSGroupCategoryForContact(contact);
            BOOL shouldInclude = NO;
            
            switch (self.selectType) {
                case WEContactSelectTypeAll:
                    shouldInclude = YES;
                    break;
                case WEContactSelectTypeGroup:
                    shouldInclude = category == CSGroupRowCategoryGroup;
                    break;
                case WEContactSelectTypePrivate:
                    shouldInclude = category == CSGroupRowCategoryPrivate;
                    break;
                case WEContactSelectTypeOfficial:
                    shouldInclude = category == CSGroupRowCategoryService;
                    break;
                case WEContactSelectTypeTag:
                    shouldInclude = NO;
                    break;
            }
            
            if (shouldInclude) {
                [contactList addObject:contact];
            }
        }
        
    } @catch (NSException *exception) {
    }
}

- (NSSet<NSString *> *)visibleUserNames {
    NSArray *dataSource = self.isSearching ? self.filteredContacts : self.contacts;
    NSMutableSet *names = [NSMutableSet set];
    for (id contact in dataSource) {
        id name = CSGroupReadObject(contact, @"m_nsUsrName");
        if ([name isKindOfClass:NSString.class] && [name length]) [names addObject:name];
    }
    return [names copy];
}

- (void)selectAllButtonTapped {
    NSSet *visible = [self visibleUserNames];
    BOOL allSelected = visible.count > 0 && [visible isSubsetOfSet:self.selectedUserNames];
    // Mutate only visible members. Hidden categories, tags and search matches retain membership.
    if (allSelected) {
        [self.selectedUserNames minusSet:visible];
    } else {
        [self.selectedUserNames unionSet:visible];
    }
    
    [self.tableView reloadData];
    [self updateRightBarButtonTitle];
    [self updateSelectAllButtonTitle];
}

- (void)updateSelectAllButtonTitle {
    if (self.selectType != WEContactSelectTypeTag) return;
    
    NSSet *visible = [self visibleUserNames];
    BOOL allSelected = visible.count > 0 && [visible isSubsetOfSet:self.selectedUserNames];
    
    UIBarButtonItem *selectAllItem = nil;
    for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
        if (item.action == @selector(selectAllButtonTapped)) {
            selectAllItem = item;
            break;
        }
    }
    
    if (selectAllItem) {
        selectAllItem.title = allSelected ? @"取消全选" : @"全选";
    }
}

- (void)updateRightBarButtonTitle {
    NSUInteger count = self.selectedUserNames.count;
    if (count > 0) {
        self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"确定(%lu)", (unsigned long)count];
    } else {
        self.navigationItem.rightBarButtonItem.title = @"确定";
    }
}

- (void)cancelButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonTapped {
    NSArray *selected = [[self.selectedUserNames allObjects] sortedArrayUsingSelector:@selector(compare:)];
    
    if (self.completesAfterDismissal) {
        WEContactSelectCompletion completion = self.completion;
        [self dismissViewControllerAnimated:YES completion:^{
            if (completion) completion(selected);
        }];
        return;
    }
    if (self.completion) {
        self.completion(selected);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isSearching ? self.filteredContacts.count : self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    NSArray *dataSource = self.isSearching ? self.filteredContacts : self.contacts;
    
    if (indexPath.row >= 0 && (NSUInteger)indexPath.row < dataSource.count) {
        CContact *contact = dataSource[indexPath.row];
        NSString *displayName = nil;
        if (contact.m_nsRemark.length > 0) {
            displayName = contact.m_nsRemark;
        } else {
            displayName = contact.m_nsNickName ?: contact.m_nsUsrName;
        }
        
        cell.textLabel.text = displayName;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        
        NSString *subtitle = nil;
        if (contact.m_nsAliasName.length > 0) {
            subtitle = [NSString stringWithFormat:@"微信号: %@", contact.m_nsAliasName];
        } else {
            subtitle = contact.m_nsUsrName;
        }
        cell.detailTextLabel.text = subtitle;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        cell.detailTextLabel.textColor = [UIColor systemGrayColor];
        
        if ([self.selectedUserNames containsObject:contact.m_nsUsrName]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *dataSource = self.isSearching ? self.filteredContacts : self.contacts;
    
    if (indexPath.row >= 0 && (NSUInteger)indexPath.row < dataSource.count) {
        CContact *contact = dataSource[indexPath.row];
        NSString *userName = contact.m_nsUsrName;
        if (![userName isKindOfClass:NSString.class] || !userName.length) return;
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([self.selectedUserNames containsObject:userName]) {
            [self.selectedUserNames removeObject:userName];
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            [self.selectedUserNames addObject:userName];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        [self updateRightBarButtonTitle];
        [self updateSelectAllButtonTitle];
    }
}

#pragma mark - Search

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    
    if (searchText.length == 0) {
        self.isSearching = NO;
        self.filteredContacts = self.contacts;
    } else {
        self.isSearching = YES;
        NSMutableArray *results = [NSMutableArray array];
        for (id contact in self.contacts) {
            NSString *nickName = [contact m_nsNickName] ?: @"";
            NSString *remark = [contact m_nsRemark] ?: @"";
            NSString *userName = [contact m_nsUsrName] ?: @"";
            
            NSString *lowerSearch = [searchText lowercaseString];
            NSString *lowerNick = [nickName lowercaseString];
            NSString *lowerRemark = [remark lowercaseString];
            NSString *lowerUser = [userName lowercaseString];
            
            if ([lowerNick containsString:lowerSearch] ||
                [lowerRemark containsString:lowerSearch] ||
                [lowerUser containsString:lowerSearch]) {
                [results addObject:contact];
            }
        }
        self.filteredContacts = results;
    }
    
    [self.tableView reloadData];
    [self updateSelectAllButtonTitle];
}

@end
