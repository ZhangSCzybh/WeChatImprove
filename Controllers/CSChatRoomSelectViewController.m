//
// CSChatRoomSelectViewController.m
// 群聊选择器界面实现
//

#import "CSChatRoomSelectViewController.h"
#import "CSServiceCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface CSChatRoomSelectViewController ()

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) NSMutableSet<NSString *> *selectedUserNames;
@property (nonatomic, strong) NSArray *chatRooms;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *filteredChatRooms;
@property (nonatomic, assign) BOOL isSearching;

@end

@interface CContact : NSObject
@property (nonatomic, copy) NSString *m_nsUsrName;
@property (nonatomic, copy) NSString *m_nsNickName;
@property (nonatomic, copy) NSString *m_nsHeadImgUrl;
- (NSString *)getContactDisplayName;
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

static BOOL CSIsChatRoomName(NSString *name) {
    if (!name || name.length == 0) return NO;
    return [name hasSuffix:@"@chatroom"];
}

@implementation CSChatRoomSelectViewController

- (instancetype)initWithTitle:(NSString *)title selectedUserNames:(NSArray<NSString *> *)selectedUserNames {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _titleText = [title copy];
        _selectedUserNames = [NSMutableSet setWithArray:selectedUserNames ?: @[]];
        _isSearching = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleText ?: @"选择群聊";
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelButtonTapped)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(doneButtonTapped)];
    
    [self loadChatRooms];
    [self updateRightBarButtonTitle];
}

- (void)loadChatRooms {
    NSMutableArray *rooms = [NSMutableArray array];
    
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self loadChatRoomsInternal:rooms];
        });
    } else {
        [self loadChatRoomsInternal:rooms];
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"m_nsNickName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    self.chatRooms = [rooms sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.filteredChatRooms = self.chatRooms;
    
}

- (void)loadChatRoomsInternal:(NSMutableArray *)rooms {
    @try {
        Class contactMgrClass = objc_getClass("CContactMgr");
        
        if (!contactMgrClass) {
            NSLog(@"[红包] 无法获取CContactMgr类");
            return;
        }
        
        CContactMgr *contactMgr = CSGetService(contactMgrClass);
        if (!contactMgr) {
            NSLog(@"[红包] 无法获取CContactMgr实例");
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
            NSLog(@"[红包] 无法获取联系人列表");
            return;
        }
        
        NSArray<NSString *> *contactSelectors = @[@"getContactByName:", @"getContactByNameFromDB:", @"getContactByNameFromCache:", @"getContactForSearchByName:"];
        
        for (NSString *userName in allUserNames) {
            if (CSIsChatRoomName(userName)) {
                CContact *contact = nil;
                
                for (NSString *selectorName in contactSelectors) {
                    SEL selector = NSSelectorFromString(selectorName);
                    if ([contactMgr respondsToSelector:selector]) {
                        @try {
                            contact = ((id (*)(id, SEL, id))objc_msgSend)(contactMgr, selector, userName);
                            if (contact) break;
                        } @catch (NSException *e) {
                            // 继续尝试下一个方法
                        }
                    }
                }
                
                if (contact) {
                    [rooms addObject:contact];
                }
            }
        }
        
        
    } @catch (NSException *exception) {
        NSLog(@"[红包] 加载群聊列表异常: %@", exception);
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
    NSArray *selected = [self.selectedUserNames allObjects];
    
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
    return self.isSearching ? self.filteredChatRooms.count : self.chatRooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ChatRoomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    NSArray *dataSource = self.isSearching ? self.filteredChatRooms : self.chatRooms;
    
    if (indexPath.row < dataSource.count) {
        CContact *contact = dataSource[indexPath.row];
        NSString *displayName = [contact getContactDisplayName] ?: contact.m_nsNickName ?: contact.m_nsUsrName;
        
        cell.textLabel.text = displayName;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.detailTextLabel.text = contact.m_nsUsrName;
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
    
    NSArray *dataSource = self.isSearching ? self.filteredChatRooms : self.chatRooms;
    
    if (indexPath.row < dataSource.count) {
        CContact *contact = dataSource[indexPath.row];
        NSString *userName = contact.m_nsUsrName;
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([self.selectedUserNames containsObject:userName]) {
            [self.selectedUserNames removeObject:userName];
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            [self.selectedUserNames addObject:userName];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        [self updateRightBarButtonTitle];
    }
}

#pragma mark - Search

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    
    if (searchText.length == 0) {
        self.isSearching = NO;
        self.filteredChatRooms = self.chatRooms;
    } else {
        self.isSearching = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"m_nsNickName CONTAINS[cd] %@ OR m_nsUsrName CONTAINS[cd] %@", searchText, searchText];
        self.filteredChatRooms = [self.chatRooms filteredArrayUsingPredicate:predicate];
    }
    
    [self.tableView reloadData];
}

@end
