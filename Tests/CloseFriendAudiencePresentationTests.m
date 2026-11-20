#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendContactProjection.h"
#import "CSCloseFriendSignatures.h"

static CSCloseFriendSnapshot *Snapshot;
static NSUInteger Epoch=1, Revision, Checks, TableRefreshes;
static NSString *CaseName;
static char EpochKey;
static NSMapTable *Refreshes;
static NSMutableSet *InstalledHooks;
static NSMutableDictionary *Capabilities;
NSString *const CSCloseFriendPolicyDidChangeNotification=@"CSCloseFriendPolicyDidChange";
#define Check(x) do {Checks++;if(!(x)){fprintf(stderr,"FAIL %s:%d [%s]: %s\n",__FILE__,__LINE__,CaseName.UTF8String,#x);return 1;}}while(0)

@interface UIView : NSObject
@property(nonatomic) BOOL hidden, accessibilityElementsHidden, userInteractionEnabled, isAccessibilityElement;
@property(nonatomic,strong) id window;
- (void)setNeedsLayout;
@end
@implementation UIView
- (void)setNeedsLayout {}
@end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic,getter=isViewLoaded) BOOL viewLoaded;
@end
@implementation UIViewController @end
@interface UITableViewCell : UIView @end
@implementation UITableViewCell @end
@interface UILabel : UIView
@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSAttributedString *attributedText;
@end
@implementation UILabel @end
@interface NSIndexPath (AudienceFixture)
@property(nonatomic,readonly) NSInteger row, section;
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (AudienceFixture)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:indexes length:2];}
- (NSInteger)row {return (NSInteger)[self indexAtPosition:1];}
- (NSInteger)section {return (NSInteger)[self indexAtPosition:0];}
@end

static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Snapshot;}
static NSUInteger CSCloseFriendAccountEpoch(void) {return Epoch;}
static BOOL CSCFPageIsCurrent(id owner) {
    if(!owner)return NO;
    NSNumber *epoch=objc_getAssociatedObject(owner,&EpochKey);
    if(!epoch) {epoch=@(Epoch);objc_setAssociatedObject(owner,&EpochKey,epoch,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
    return epoch.unsignedIntegerValue==Epoch;
}
static BOOL CSCFIsClass(id object,NSString *name) {return [object isKindOfClass:NSClassFromString(name)];}
static id CSCloseFriendRead(id object,NSString *key) {
    if([object isKindOfClass:NSDictionary.class])return object[key];
    SEL selector=NSSelectorFromString(key);
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"@@:"))return ((id(*)(id,SEL))objc_msgSend)(object,selector);
    Ivar ivar=class_getInstanceVariable([object class],key.UTF8String);
    return ivar && ivar_getTypeEncoding(ivar)[0]=='@' ? object_getIvar(object,ivar) : nil;
}
static NSString *CSCloseFriendUserName(id object) {
    if([object isKindOfClass:NSString.class])return object;
    for(NSString *key in @[@"m_nsUsrName",@"m_nsUserName",@"userName",@"username"]){id value=CSCloseFriendRead(object,key);if([value isKindOfClass:NSString.class] && [value length])return value;}
    return nil;
}
static BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) {return [Snapshot hidesUserName:name surface:surface];}
static NSArray *CSCFVisible(NSArray *source,CSCloseFriendSurface surface) {return CSCloseFriendVisibleContacts(source,Snapshot,surface,^NSString *(id item){return CSCloseFriendUserName(item);});}
static NSArray<NSString *> *CSCFContactNames(NSArray *source) {
    NSMutableArray *names=[NSMutableArray array];
    for(id contact in source){NSString *name=CSCloseFriendRead(contact,@"displayName") ?: CSCloseFriendUserName(contact);if(name.length)[names addObject:name];}
    return names;
}
static void CSCloseFriendRecordCapability(NSString *name,BOOL available) {if(!Capabilities)Capabilities=[NSMutableDictionary dictionary];Capabilities[name]=@(available);}
static BOOL CSCloseFriendInstallHook(NSString *className,NSString *name,IMP replacement,IMP *original,const char *types) {
    Class cls=NSClassFromString(className);SEL selector=NSSelectorFromString(name);Method method=class_getInstanceMethod(cls,selector);
    if(!CSCloseFriendMethodMatches(method,types))return NO;
    *original=method_getImplementation(method);class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));
    if(!InstalledHooks)InstalledHooks=[NSMutableSet set];[InstalledHooks addObject:[className stringByAppendingFormat:@".%@",name]];return *original!=NULL;
}
static void CSCFSocialHook0(NSString *cls,NSString *name,void(^body)(id,void(^)(void))) {
    __block IMP original=NULL;SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner){body(owner,^{((void(*)(id,SEL))original)(owner,selector);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:"))imp_removeBlock(replacement);
}
static void CSCFSocialHook1(NSString *cls,NSString *name,void(^body)(id,id,void(^)(id))) {
    __block IMP original=NULL;SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner,id argument){body(owner,argument,^(id value){((void(*)(id,SEL,id))original)(owner,selector,value);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@"))imp_removeBlock(replacement);
}
static BOOL CSCFCallVoid(id owner,NSString *name) {SEL selector=NSSelectorFromString(name);if(!CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],selector),"v@:"))return NO;((void(*)(id,SEL))objc_msgSend)(owner,selector);return YES;}
static BOOL CSCFSetObject(id owner,NSString *name,id value) {SEL selector=NSSelectorFromString(name);if(!CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],selector),"v@:@"))return NO;((void(*)(id,SEL,id))objc_msgSend)(owner,selector,value);return YES;}
static void CSCFSocialTrack(id owner,void(^refresh)(id)) {if(!Refreshes)Refreshes=[NSMapTable weakToStrongObjectsMapTable];[Refreshes setObject:[refresh copy] forKey:owner];}
static void CSCFReloadTables(__unused id owner) {TableRefreshes++;}

@interface UITableView : UIView
@property(nonatomic,strong) NSIndexPath *lastDeselectedPath;
@property(nonatomic) NSUInteger deselections,reloads;
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(BOOL)animated;
- (void)reloadData;
@end
@implementation UITableView
- (void)deselectRowAtIndexPath:(NSIndexPath *)path animated:(__unused BOOL)animated {self.lastDeselectedPath=path;self.deselections++;}
- (void)reloadData {self.reloads++;}
@end

@interface Contact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName,*displayName;
@end
@implementation Contact @end
@interface WCMomentsPrivacyItem : NSObject
@property(nonatomic,strong) NSMutableSet *selectedContacts,*contacts;
@property(nonatomic,copy) NSString *selectContactDescription;
@end
@implementation WCMomentsPrivacyItem @end
@interface WCMomentsPrivacyParams : NSObject
@property(nonatomic,strong) NSArray *table;
- (id)itemAtIndexPath:(NSIndexPath *)path;
@end
@implementation WCMomentsPrivacyParams
- (id)itemAtIndexPath:(NSIndexPath *)path {return self.table[(NSUInteger)path.section];}
@end
@interface WCMomentsPrivacyViewController : UIViewController
@property(nonatomic,strong) WCMomentsPrivacyItem *currentItem;
@property(nonatomic,strong) WCMomentsPrivacyParams *params;
@property(nonatomic,copy) NSString *displayedDescription;
@property(nonatomic,copy) void(^renderProbe)(void);
@property(nonatomic) BOOL throwsDuringRender;
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
- (double)tableView:(id)table heightForRowAtIndexPath:(NSIndexPath *)path;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
- (void)reloadTableView;
@end
@implementation WCMomentsPrivacyViewController
- (id)tableView:(__unused id)table cellForRowAtIndexPath:(NSIndexPath *)path {
    WCMomentsPrivacyItem *item=[self.params itemAtIndexPath:path];
    NSArray *names=CSCFContactNames(item.selectedContacts.allObjects);
    // Native WCUIUtil uses selectedContacts for the primary label; the cached
    // selectContactDescription is only the backup when that collection is empty.
    self.displayedDescription=names.count ? [names componentsJoinedByString:@", "] : item.selectContactDescription;
    if(self.renderProbe)self.renderProbe();if(self.throwsDuringRender)@throw [NSException exceptionWithName:@"NativeRenderFailure" reason:nil userInfo:nil];return self.displayedDescription;
}
- (double)tableView:(__unused id)table heightForRowAtIndexPath:(NSIndexPath *)path {
    WCMomentsPrivacyItem *item=[self.params itemAtIndexPath:path];NSArray *names=CSCFContactNames(item.selectedContacts.allObjects);
    return [names.count ? [names componentsJoinedByString:@", "] : item.selectContactDescription length];
}
- (void)viewDidLoad {}
- (void)viewDidLayoutSubviews {}
- (void)reloadTableView {}
@end
@interface WCCommitPrivacySetting : NSObject
@property(nonatomic,strong) NSArray *selectContacts,*selectTags;
@end
@implementation WCCommitPrivacySetting @end
@interface WCNewCommitViewController : UIViewController
@property(nonatomic,strong) WCCommitPrivacySetting *lastPostPrivacySetting;
@property(nonatomic,strong) id contactsSelectorController;
@property(nonatomic,strong) NSArray *displayedContacts;
@property(nonatomic,copy) NSString *displayedSummary;
@property(nonatomic,copy) void(^renderProbe)(void);
@property(nonatomic) BOOL throwsDuringRender;
- (void)makeLastSelectTagCell:(id)cell;
- (void)makeLastSelectTagCell:(id)cell cellManager:(id)manager;
- (void)makeLastSelectTagSummaryCell:(id)cell cellManager:(id)manager;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
@end
@implementation WCNewCommitViewController
- (void)makeLastSelectTagCell:(__unused id)cell {self.displayedContacts=self.lastPostPrivacySetting.selectContacts;self.displayedSummary=[CSCFContactNames(self.displayedContacts) componentsJoinedByString:@", "];if(self.renderProbe)self.renderProbe();if(self.throwsDuringRender)@throw [NSException exceptionWithName:@"NativeRenderFailure" reason:nil userInfo:nil];}
- (void)makeLastSelectTagCell:(__unused id)cell cellManager:(__unused id)manager {self.displayedContacts=self.lastPostPrivacySetting.selectContacts;self.displayedSummary=[CSCFContactNames(self.displayedContacts) componentsJoinedByString:@", "];}
- (void)makeLastSelectTagSummaryCell:(__unused id)cell cellManager:(__unused id)manager {self.displayedContacts=self.lastPostPrivacySetting.selectContacts;self.displayedSummary=[CSCFContactNames(self.displayedContacts) componentsJoinedByString:@", "];}
- (void)viewDidLoad {}
- (void)viewDidLayoutSubviews {}
@end
@interface ContactsSelectorController : NSObject
@property(nonatomic,weak) id delegate;
@end
@implementation ContactsSelectorController @end
@interface ContactSelectToolView : UIView
@property(nonatomic,strong) NSArray *selectedContacts;
@property(nonatomic) NSUInteger updates;
- (void)updateSelectedContacts:(id)contacts;
- (void)updateHeadImageViews;
- (void)layoutSubviews;
@end
@implementation ContactSelectToolView
- (void)updateSelectedContacts:(id)contacts {self.selectedContacts=[contacts copy];self.updates++;}
- (void)updateHeadImageViews {}
- (void)layoutSubviews {}
@end
@interface ContactSelectView : UIView
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) id m_contactsDataLogic;
@property(nonatomic,strong) NSMutableDictionary *m_dicMultiSelect;
@end
@implementation ContactSelectView @end
@interface ContactsDataLogic : NSObject
@property(nonatomic,weak) id m_delegate;
@end
@implementation ContactsDataLogic @end
@interface ContactsSelectionPreviewViewController : UIViewController
@property(nonatomic,weak) id delegate;
@property(nonatomic,strong) NSArray *selectedContacts;
@property(nonatomic,strong) id selectedContact;
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section;
- (id)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path;
- (double)tableView:(id)table heightForRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation ContactsSelectionPreviewViewController
- (NSInteger)tableView:(__unused id)table numberOfRowsInSection:(__unused NSInteger)section {return (NSInteger)self.selectedContacts.count;}
- (id)tableView:(__unused id)table cellForRowAtIndexPath:(NSIndexPath *)path {return self.selectedContacts[(NSUInteger)path.row];}
- (void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)path {
    [table deselectRowAtIndexPath:path animated:YES];
    self.selectedContact=self.selectedContacts[(NSUInteger)path.row];
    SEL callback=NSSelectorFromString(@"didSelectionPreviewViewTableSelectContact:");
    if([self.delegate respondsToSelector:callback])((void(*)(id,SEL,id))objc_msgSend)(self.delegate,callback,self.selectedContact);
    [table reloadData];
}
- (double)tableView:(__unused id)table heightForRowAtIndexPath:(__unused NSIndexPath *)path {return 44;}
@end
@interface MultiSelectContactsViewController : UIViewController
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) ContactSelectToolView *m_toolView;
@property(nonatomic,strong) ContactSelectView *m_selectView;
@property(nonatomic,strong) ContactsSelectionPreviewViewController *selectionPreviewViewController;
@property(nonatomic,strong) NSArray *source;
@property(nonatomic,strong) id previewSelectedContact;
@property(nonatomic) NSUInteger previewCallbacks;
- (void)didSelectionPreviewViewTableSelectContact:(id)contact;
- (void)updateToolViewSelectedContacts;
- (void)updateSelectedHeadImgView;
- (void)updatePanelBtnAndToolViewSelectedContacts;
- (void)updateMultiSelectView;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
@end
@implementation MultiSelectContactsViewController
- (void)didSelectionPreviewViewTableSelectContact:(id)contact {self.previewSelectedContact=contact;self.previewCallbacks++;}
- (void)updateToolViewSelectedContacts {[self.m_toolView updateSelectedContacts:self.source];}
- (void)updateSelectedHeadImgView {[self updateToolViewSelectedContacts];}
- (void)updatePanelBtnAndToolViewSelectedContacts {[self updateToolViewSelectedContacts];}
- (void)updateMultiSelectView {[self updateToolViewSelectedContacts];}
- (void)viewDidLoad {}
- (void)viewDidLayoutSubviews {}
@end
#include "AudienceOwnerProduction.h"

#include "AudiencePresentationProduction.h"

static Contact *Person(NSString *username,NSString *displayName) {Contact *contact=[Contact new];contact.m_nsUsrName=username;contact.displayName=displayName;return contact;}
static void Policy(BOOL revealed,BOOL enabled) {
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@(enabled),@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:++Revision blocked:NO];
}
static void RefreshPolicy(void) {for(id page in Refreshes.keyEnumerator.allObjects){void(^refresh)(id)=[Refreshes objectForKey:page];if(refresh)refresh(page);}}
static MultiSelectContactsViewController *Picker(id owner,NSArray *source) {
    MultiSelectContactsViewController *controller=[MultiSelectContactsViewController new];controller.m_delegate=owner;controller.source=source;
    controller.m_toolView=[ContactSelectToolView new];controller.m_selectView=[ContactSelectView new];controller.m_selectView.m_delegate=controller;
    controller.m_selectView.m_contactsDataLogic=[ContactsDataLogic new];[controller.m_selectView.m_contactsDataLogic setM_delegate:controller.m_selectView];
    controller.m_selectView.m_dicMultiSelect=[NSMutableDictionary dictionary];for(Contact *contact in source)controller.m_selectView.m_dicMultiSelect[contact.m_nsUsrName]=contact;
    return controller;
}
static int ToolCases(Contact *ordinary,Contact *hidden,Contact *other) {
    CaseName=@"selected-avatar-mixed-native-selection-preserved";Policy(NO,YES);
    WCMomentsPrivacyViewController *owner=[WCMomentsPrivacyViewController new];
    NSArray *source=@[ordinary,hidden,other];MultiSelectContactsViewController *picker=Picker(owner,source);
    NSDictionary *selection=[picker.m_selectView.m_dicMultiSelect copy];
    [picker updateToolViewSelectedContacts];
    Check([picker.m_toolView.selectedContacts isEqual:(@[ordinary,other])]);
    Check([picker.source isEqual:source] && [picker.m_selectView.m_dicMultiSelect isEqual:selection]);
    CaseName=@"avatar-restored-after-unlock";Policy(YES,YES);RefreshPolicy();
    Check([picker.m_toolView.selectedContacts isEqual:source]);
    CaseName=@"avatar-refiltered-after-lock";Policy(NO,YES);RefreshPolicy();
    Check([picker.m_toolView.selectedContacts isEqual:(@[ordinary,other])]);
    CaseName=@"live-native-selection-replaces-old-source";picker.source=@[hidden,other];[picker updatePanelBtnAndToolViewSelectedContacts];
    Check([picker.m_toolView.selectedContacts isEqual:@[other]]);
    Policy(YES,YES);RefreshPolicy();Check([picker.m_toolView.selectedContacts isEqual:(@[hidden,other])]);
    CaseName=@"all-hidden-selection";Policy(NO,YES);picker.source=@[hidden];[picker updateSelectedHeadImgView];Check(picker.m_toolView.selectedContacts.count==0);
    CaseName=@"ordinary-picker-unaffected";MultiSelectContactsViewController *unrelated=Picker([NSObject new],source);[unrelated updateToolViewSelectedContacts];Check([unrelated.m_toolView.selectedContacts isEqual:source]);
    CaseName=@"disabled-feature-restores-all-avatars";Policy(NO,NO);RefreshPolicy();Check([picker.m_toolView.selectedContacts isEqual:@[hidden]]);
    return 0;
}
static int PreviewCases(Contact *ordinary,Contact *hidden,Contact *other) {
    CaseName=@"preview-maps-visible-rows-to-untouched-source";Policy(NO,YES);
    WCMomentsPrivacyViewController *owner=[WCMomentsPrivacyViewController new];
    NSArray *source=@[hidden,ordinary,other];MultiSelectContactsViewController *picker=Picker(owner,source);
    ContactsSelectionPreviewViewController *preview=[ContactsSelectionPreviewViewController new];preview.delegate=picker;preview.selectedContacts=source;
    NSIndexPath *first=[NSIndexPath indexPathForRow:0 inSection:0],*second=[NSIndexPath indexPathForRow:1 inSection:0];
    @autoreleasepool {
    Check([preview tableView:nil numberOfRowsInSection:0]==2);
    Check([preview tableView:nil cellForRowAtIndexPath:first]==ordinary && [preview tableView:nil cellForRowAtIndexPath:second]==other);
    UITableView *table=[UITableView new];[preview tableView:table didSelectRowAtIndexPath:first];Check(preview.selectedContact==ordinary);
    Check(picker.previewSelectedContact==ordinary && picker.previewCallbacks==1);
    Check(table.lastDeselectedPath==first && table.lastDeselectedPath.row==0 && table.deselections==1 && table.reloads==1);
    Check(preview.selectedContacts==source && picker.m_selectView.m_dicMultiSelect.count==3);
    CaseName=@"preview-unlock-restores-original-indices";Policy(YES,YES);RefreshPolicy();
    Check([preview tableView:nil numberOfRowsInSection:0]==3 && [preview tableView:nil cellForRowAtIndexPath:first]==hidden);
    [preview tableView:nil didSelectRowAtIndexPath:first];Check(preview.selectedContact==hidden);
    CaseName=@"preview-invalid-projected-row-does-not-select";Policy(NO,YES);preview.selectedContact=nil;
    NSIndexPath *invalid=[NSIndexPath indexPathForRow:2 inSection:0];[preview tableView:table didSelectRowAtIndexPath:invalid];Check(!preview.selectedContact);
    Check(table.deselections==1 && table.reloads==1);
    CaseName=@"preview-unrelated-picker-keeps-native-rows";NSObject *unrelatedOwner=[NSObject new];MultiSelectContactsViewController *unrelated=Picker(unrelatedOwner,source);
    ContactsSelectionPreviewViewController *unrelatedPreview=[ContactsSelectionPreviewViewController new];unrelatedPreview.delegate=unrelated;unrelatedPreview.selectedContacts=source;
    Check([unrelatedPreview tableView:nil numberOfRowsInSection:0]==3 && [unrelatedPreview tableView:nil cellForRowAtIndexPath:first]==hidden);
    CaseName=@"bound-preview-cannot-revive-through-unrelated-delegate";preview.delegate=unrelated;
    Check([preview tableView:nil numberOfRowsInSection:0]==2 && [preview tableView:nil cellForRowAtIndexPath:first]==ordinary);
    CaseName=@"bound-preview-account-epoch-retirement";Epoch++;preview.selectedContact=nil;
    Check([preview tableView:nil numberOfRowsInSection:0]==0);[preview tableView:nil didSelectRowAtIndexPath:first];Check(!preview.selectedContact);Epoch--;
    CaseName=@"bound-preview-owner-and-picker-release";owner=nil;picker=nil;preview.selectedContact=nil;
    } // Drain autoreleased weak loads from synchronous native render callbacks.
    Check([preview tableView:nil numberOfRowsInSection:0]==0);[preview tableView:nil didSelectRowAtIndexPath:first];Check(!preview.selectedContact && preview.selectedContacts==source);
    CaseName=@"reminder-picker-positive-origin";
    WCNewCommitViewController *editor=[WCNewCommitViewController new];ContactsSelectorController *selector=[ContactsSelectorController new];selector.delegate=editor;editor.contactsSelectorController=selector;
    MultiSelectContactsViewController *reminder=Picker(selector,source);BindReminderPicker(selector,reminder);
    [reminder updateToolViewSelectedContacts];Check([reminder.m_toolView.selectedContacts isEqual:(@[ordinary,other])]);
    CaseName=@"account-change-clears-retired-tool";Epoch++;RefreshPolicy();Check(reminder.m_toolView.selectedContacts.count==0);Epoch--;
    return 0;
}
static WCMomentsPrivacyViewController *PrivacyPage(NSArray *contacts) {
    WCMomentsPrivacyViewController *page=[WCMomentsPrivacyViewController new];page.currentItem=[WCMomentsPrivacyItem new];
    page.currentItem.selectedContacts=[NSMutableSet setWithArray:contacts];page.currentItem.contacts=[page.currentItem.selectedContacts mutableCopy];
    page.currentItem.selectContactDescription=[CSCFContactNames(contacts) componentsJoinedByString:@", "];
    page.params=[WCMomentsPrivacyParams new];page.params.table=@[page.currentItem];return page;
}
static int PrivacyCases(Contact *ordinary,Contact *hidden) {
    CaseName=@"privacy-description-scoped-render";Policy(NO,YES);
    WCMomentsPrivacyViewController *page=PrivacyPage(@[ordinary,hidden]);NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
    NSString *raw=page.currentItem.selectContactDescription;NSSet *selectedSource=page.currentItem.selectedContacts,*selected=[selectedSource copy];
    [page tableView:nil cellForRowAtIndexPath:path];
    Check([page.displayedDescription isEqual:ordinary.displayName]);
    Check([page.currentItem.selectContactDescription isEqual:raw] && page.currentItem.selectedContacts==selectedSource && [page.currentItem.selectedContacts isEqual:selected]);
    Check([page tableView:nil heightForRowAtIndexPath:path]==ordinary.displayName.length);
    CaseName=@"privacy-background-getter-keeps-native-description";
    __block NSString *backgroundDescription=nil;__block NSSet *backgroundSelection=nil;__block BOOL backgroundMain=YES;__block long backgroundWait=-1;
    __weak WCMomentsPrivacyViewController *weakPage=page;
    page.renderProbe=^{
        dispatch_group_t group=dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{backgroundMain=NSThread.isMainThread;backgroundDescription=weakPage.currentItem.selectContactDescription;backgroundSelection=weakPage.currentItem.selectedContacts;});
        backgroundWait=dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC));
    };
    [page tableView:nil cellForRowAtIndexPath:path];page.renderProbe=nil;
    Check(backgroundWait==0 && !backgroundMain && [backgroundDescription isEqual:raw] && [page.displayedDescription isEqual:ordinary.displayName]);
    Check(backgroundSelection==selectedSource && [backgroundSelection isEqual:selected] && page.currentItem.selectedContacts==selectedSource);
    CaseName=@"ordinary-name-containing-comma-is-preserved";
    Check([page.displayedDescription isEqual:@"Alice, ordinary"]);
    CaseName=@"privacy-description-unlock-restoration";Policy(YES,YES);[page tableView:nil cellForRowAtIndexPath:path];Check([page.displayedDescription containsString:ordinary.displayName] && [page.displayedDescription containsString:hidden.displayName]);
    CaseName=@"privacy-full-hidden-description";Policy(NO,YES);WCMomentsPrivacyViewController *allHidden=PrivacyPage(@[hidden]);[allHidden tableView:nil cellForRowAtIndexPath:path];Check(allHidden.displayedDescription.length==0 && allHidden.currentItem.selectedContacts.count==1);
    CaseName=@"privacy-exception-restores-scope";page.throwsDuringRender=YES;
    @try {[page tableView:nil cellForRowAtIndexPath:path];} @catch(__unused NSException *exception) {}
    Check([page.currentItem.selectContactDescription isEqual:raw] && page.currentItem.selectedContacts==selectedSource);
    return 0;
}
static int LastGroupCases(Contact *ordinary,Contact *hidden,Contact *other) {
    CaseName=@"last-group-scoped-render-native-setting-preserved";Policy(NO,YES);
    WCNewCommitViewController *editor=[WCNewCommitViewController new];editor.lastPostPrivacySetting=[WCCommitPrivacySetting new];
    NSArray *source=@[ordinary,hidden,other];editor.lastPostPrivacySetting.selectContacts=source;editor.lastPostPrivacySetting.selectTags=@[@"native-tag"];
    [editor makeLastSelectTagCell:nil];
    Check([editor.displayedContacts isEqual:(@[ordinary,other])]);
    Check([editor.lastPostPrivacySetting.selectContacts isEqual:source] && [editor.lastPostPrivacySetting.selectTags isEqual:@[@"native-tag"]]);
    Check([editor.displayedSummary isEqual:@"Alice, ordinary, Bob"]);
    CaseName=@"last-group-8.0.80-cell-manager-entry-points";
    [editor makeLastSelectTagCell:nil cellManager:nil];Check([editor.displayedContacts isEqual:(@[ordinary,other])]);
    [editor makeLastSelectTagSummaryCell:nil cellManager:nil];Check([editor.displayedContacts isEqual:(@[ordinary,other])]);
    Check(editor.lastPostPrivacySetting.selectContacts==source);
    CaseName=@"last-group-nested-and-background-model-read-isolation";
    WCNewCommitViewController *nested=[WCNewCommitViewController new];nested.lastPostPrivacySetting=[WCCommitPrivacySetting new];nested.lastPostPrivacySetting.selectContacts=@[hidden,other];
    WCCommitPrivacySetting *unrelated=[WCCommitPrivacySetting new];unrelated.selectContacts=@[hidden];
    __block NSArray *outerAfterNested=nil,*unrelatedDuringRender=nil,*backgroundContacts=nil;__block long backgroundWait=-1;
    __weak WCNewCommitViewController *weakEditor=editor;
    editor.renderProbe=^{
        [nested makeLastSelectTagCell:nil];outerAfterNested=weakEditor.lastPostPrivacySetting.selectContacts;unrelatedDuringRender=unrelated.selectContacts;
        dispatch_group_t group=dispatch_group_create();dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{backgroundContacts=weakEditor.lastPostPrivacySetting.selectContacts;});
        backgroundWait=dispatch_group_wait(group,dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC));
    };
    [editor makeLastSelectTagCell:nil];editor.renderProbe=nil;
    Check([nested.displayedContacts isEqual:@[other]] && [outerAfterNested isEqual:(@[ordinary,other])]);
    Check([unrelatedDuringRender isEqual:@[hidden]] && backgroundWait==0 && [backgroundContacts isEqual:source]);
    CaseName=@"last-group-unlock-and-disabled-restoration";Policy(YES,YES);[editor makeLastSelectTagCell:nil];Check([editor.displayedContacts isEqual:source]);
    Policy(NO,NO);[editor makeLastSelectTagCell:nil];Check([editor.displayedContacts isEqual:source]);
    CaseName=@"last-group-all-hidden";Policy(NO,YES);editor.lastPostPrivacySetting.selectContacts=@[hidden];[editor makeLastSelectTagCell:nil];Check(editor.displayedContacts.count==0 && editor.lastPostPrivacySetting.selectContacts.count==1);
    CaseName=@"last-group-exception-restores-scope";editor.throwsDuringRender=YES;
    @try {[editor makeLastSelectTagCell:nil];} @catch(__unused NSException *exception) {}
    Check([editor.lastPostPrivacySetting.selectContacts isEqual:@[hidden]]);
    return 0;
}
int main(void) { @autoreleasepool {
    CaseName=@"production-hook-registration";Policy(NO,YES);CSCFAudiencePresentationInstall();
    Contact *ordinary=Person(@"alice",@"Alice, ordinary"),*hidden=Person(@"secret",@"Hidden friend"),*other=Person(@"bob",@"Bob");
    Check(ToolCases(ordinary,hidden,other)==0);Check(PreviewCases(ordinary,hidden,other)==0);Check(PrivacyCases(ordinary,hidden)==0);Check(LastGroupCases(ordinary,hidden,other)==0);
    printf("Audience presentation: %lu checks passed with the complete production adapter (mixed avatars and nicknames, last group, lock/unlock, ordinary-picker isolation and unchanged native selections)\n",(unsigned long)Checks);
    return 0;
} }
