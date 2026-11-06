#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "CSAIMessageAdapter.h"
#import "CSAIChatDetailAdapter.h"
#import "CSAIReplyManager.h"
#import "CSAIReplySettingsViewController.h"
#import "AINativeDispatchUnderTest.m"
static NSUInteger checks,mutations,unmentionedMutations,pickerCalls,searchCalls,muteCalls;
static NSString *unmentionedTarget;
static BOOL unmentionedValue,unsupportedSimpleUnmentioned;
#define CHECK(c) do{checks++;if(!(c)){NSLog(@"FAIL %d %s",__LINE__,#c);exit(1);}}while(0)
@implementation UIView @end
@implementation UISwitch @end
@implementation UITableView
- (void)reloadData{self.reloadCount++;}
@end
@implementation UIViewController
- (instancetype)init{if((self=[super init])){_view=[UIView new];_view.window=[NSObject new];}return self;}
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void(^)(void))completion{(void)animated;self.presentedViewController=controller;if(completion)completion();}
@end
@implementation UITableViewController @end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void(^)(UIAlertAction *))handler{(void)title;(void)style;(void)handler;return [self new];}
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style{(void)title;(void)message;(void)style;return [self new];}
- (void)addAction:(UIAlertAction *)action{(void)action;}
@end
@interface TestWrap : NSObject
@property NSString *m_nsFromUsr,*m_nsToUsr,*m_nsRealChatUsr,*m_nsContent,*m_nsMsgSource,*m_nsAtUserList;
@property unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime;
@property long long m_n64MesSvrID;
@property BOOL m_nsAtAll;
@end
@implementation TestWrap @end
@interface TestContact : NSObject
@property NSString *m_nsUsrName;
@end
@implementation TestContact @end
@interface TestLeftConfig : NSObject
@property NSString *title;
@end
@implementation TestLeftConfig @end
@interface TestCellConfig : NSObject
@property SEL clickAction;
@property TestLeftConfig *leftConfig;
@end
@implementation TestCellConfig @end
@interface WCTableViewCellManager : NSObject
@property SEL action;
@property id target;
@property NSString *title;
@property BOOL on;
@property TestCellConfig *cellConfig;
@property NSString *detail;
+ (id)switchCellForSel:(SEL)sel target:(id)target title:(id)title on:(BOOL)on;
+ (id)switchCellForSel:(SEL)sel target:(id)target leftImage:(id)image title:(id)title desc:(id)detail on:(BOOL)on;
+ (id)normalCellForSel:(SEL)sel target:(id)target title:(id)title rightValue:(id)value;
@end
static WCTableViewCellManager *NativeSwitchCell(SEL action,id target,id title,BOOL on){
    WCTableViewCellManager *cell=[WCTableViewCellManager new];cell.action=action;cell.target=target;cell.title=title;cell.on=on;cell.cellConfig=[TestCellConfig new];cell.cellConfig.clickAction=action;cell.cellConfig.leftConfig=[TestLeftConfig new];cell.cellConfig.leftConfig.title=title;return cell;
}
@implementation WCTableViewCellManager
+ (id)switchCellForSel:(SEL)sel target:(id)target title:(id)title on:(BOOL)on{if(unsupportedSimpleUnmentioned && [title isEqual:@"免 @ 回复"])return nil;return NativeSwitchCell(sel,target,title,on);}
+ (id)switchCellForSel:(SEL)sel target:(id)target leftImage:(id)image title:(id)title desc:(id)detail on:(BOOL)on{(void)image;WCTableViewCellManager *cell=NativeSwitchCell(sel,target,title,on);cell.detail=detail;return cell;}
+ (id)normalCellForSel:(SEL)sel target:(id)target title:(id)title rightValue:(id)value{(void)value;return [self switchCellForSel:sel target:target title:title on:NO];}
@end
@interface WCTableViewSectionManager : NSObject
@property NSMutableArray *cells;
@property NSString *headerTitle;
@property NSString *footerTitle;
+ (id)sectionWithHeader:(NSString *)title;
- (void)addCell:(id)cell;
- (NSArray *)getAllCells;
- (void)removeCellAt:(NSUInteger)index;
@end
@implementation WCTableViewSectionManager
+ (id)sectionWithHeader:(NSString *)title{WCTableViewSectionManager *section=[self new];section.headerTitle=title;section.cells=[NSMutableArray array];return section;}
- (void)addCell:(id)cell{[self.cells addObject:cell];}
- (NSArray *)getAllCells{return self.cells;}
- (void)removeCellAt:(NSUInteger)index{[self.cells removeObjectAtIndex:index];}
@end
@interface TestTableManager : NSObject
@property NSMutableArray *sections;
@property UITableView *table;
- (NSArray *)getAllSections;
- (void)removeSectionAt:(NSUInteger)index;
- (void)addSection:(id)section;
- (UITableView *)getTableView;
@end
@implementation TestTableManager
- (instancetype)init{if((self=[super init])){_sections=[NSMutableArray arrayWithObject:[NSObject new]];_table=[UITableView new];}return self;}
- (NSArray *)getAllSections{return self.sections;}
- (void)removeSectionAt:(NSUInteger)index{[self.sections removeObjectAtIndex:index];}
- (void)addSection:(id)section{[self.sections addObject:section];}
- (UITableView *)getTableView{return self.table;}
@end
@interface TestDetailPage : NSObject {
@public TestTableManager *m_tableViewInfo;
}
@property TestContact *contact;
@property UIViewController *controller;
- (id)getChatContact;
- (id)getViewController;
- (void)onEditAndSearch;
- (void)onMute;
@end
@implementation TestDetailPage
- (instancetype)init{if((self=[super init])){m_tableViewInfo=[TestTableManager new];_controller=[UIViewController new];_contact=[TestContact new];_contact.m_nsUsrName=@"friend";}return self;}
- (id)getChatContact{return self.contact;}
- (id)getViewController{return self.controller;}
- (void)onEditAndSearch{searchCalls++;}
- (void)onMute{muteCalls++;}
@end
static WCTableViewSectionManager *NativeSection(TestDetailPage *page,NSString *title,SEL action){
    WCTableViewSectionManager *section=[WCTableViewSectionManager sectionWithHeader:nil];
    [section addCell:[WCTableViewCellManager normalCellForSel:action target:page title:title rightValue:nil]];return section;
}
NSNotificationName const CSAIReplyDidChange=@"CSAIReplyDidChange";
static CSAIReplyStore *testStore;
static NSUInteger testEpoch=1;
static BOOL allowed=YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation CSAIReplyManager
+ (instancetype)sharedManager{static id manager;static dispatch_once_t once;dispatch_once(&once,^{manager=[self new];});return manager;}
- (CSAIReplyStore *)store{return testStore;}
- (NSUInteger)epoch{return testEpoch;}
- (BOOL)isCurrentAccount:(NSString *)account epoch:(NSUInteger)epoch{return [account isEqual:testStore.account] && epoch==testEpoch;}
- (BOOL)allowsConversation:(NSString *)conversation{return allowed && conversation.length;}
- (NSString *)presetNameForConversation:(NSString *)conversation{(void)conversation;return @"默认回复";}
- (NSString *)statusForConversation:(NSString *)conversation{(void)conversation;return @"总开关已关闭";}
- (BOOL)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error{(void)conversation;(void)enabled;(void)presetID;(void)error;if(![self isCurrentAccount:account epoch:epoch])return NO;mutations++;return YES;}
- (BOOL)setConversation:(NSString *)conversation allowUnmentioned:(BOOL)allowUnmentioned account:(NSString *)account epoch:(NSUInteger)epoch error:(NSError **)error{(void)error;if(![self isCurrentAccount:account epoch:epoch] || ![self allowsConversation:conversation] || ![conversation hasSuffix:@"@chatroom"])return NO;unmentionedMutations++;unmentionedTarget=conversation;unmentionedValue=allowUnmentioned;return YES;}
- (void)setConversation:(NSString *)conversation enabled:(BOOL)enabled presetID:(NSString *)presetID account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion {NSError *error=nil;BOOL ok=[self setConversation:conversation enabled:enabled presetID:presetID account:account epoch:epoch error:&error];completion(ok,error);}
- (void)setConversation:(NSString *)conversation allowUnmentioned:(BOOL)allowUnmentioned account:(NSString *)account epoch:(NSUInteger)epoch completion:(CSAIReplyStoreCompletion)completion {NSError *error=nil;BOOL ok=[self setConversation:conversation allowUnmentioned:allowUnmentioned account:account epoch:epoch error:&error];completion(ok,error);}

@end
#pragma clang diagnostic pop
void CSAIPresentPresetPicker(UIViewController *controller,NSString *conversation,NSString *account,NSUInteger epoch){(void)controller;(void)conversation;(void)account;(void)epoch;pickerCalls++;}
int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);TestWrap *wrap=[TestWrap new];wrap.m_nsFromUsr=@"friend";wrap.m_nsToUsr=@"alice";wrap.m_nsContent=@"hello";wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=7;wrap.m_n64MesSvrID=55;wrap.m_uiCreateTime=1800000000;
    NSDictionary *event=CSAIEventFromWrap(wrap,@"alice",@"friend");CHECK([event[@"text"] isEqual:@"hello"]);CHECK([event[@"identifiers"] count]==2);CHECK(![event[@"group"] boolValue]);
    CHECK(!CSAIEventFromWrap(wrap,@"bob",@"friend"));CHECK(!CSAIEventFromWrap(wrap,@"alice",@"wrong"));wrap.m_uiMessageType=49;CHECK(!CSAIEventFromWrap(wrap,@"alice",@"friend"));wrap.m_uiMessageType=1;
    wrap.m_uiMessageType=3;wrap.m_nsContent=@"";event=CSAIEventFromWrap(wrap,@"alice",@"friend");
    CHECK([event[@"type"] isEqual:@3] && [event[@"text"] isEqual:@""]);CHECK(event[@"imageSource"]==wrap);
    CHECK([event[@"imageLocalID"] isEqual:@7] && [event[@"imageServerID"] isEqual:@55]);
    CHECK(!CSAIEventFromWrapWithImages(wrap,@"alice",@"friend",NO));
    wrap.m_uiMessageType=1;wrap.m_nsContent=@"hello";
    wrap.m_nsFromUsr=@"group@chatroom";wrap.m_nsRealChatUsr=@"bob";wrap.m_nsContent=@"bob:\n@Alice\u2005你好";wrap.m_nsAtUserList=@"alice2";event=CSAIEventFromWrap(wrap,@"alice",@"group@chatroom");CHECK(event && ![event[@"mentioned"] boolValue]);
    wrap.m_nsAtUserList=@"bob,alice";event=CSAIEventFromWrap(wrap,@"alice",@"group@chatroom");CHECK([event[@"text"] isEqual:@"你好"]);CHECK([event[@"sender"] isEqual:@"bob"]);CHECK([event[@"group"] boolValue] && [event[@"mentioned"] boolValue]);
    wrap.m_nsAtAll=YES;CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));wrap.m_nsAtAll=NO;wrap.m_nsAtUserList=@"alice,notify@all";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));
    wrap.m_nsAtUserList=@"";wrap.m_nsMsgSource=@"<msgsource><atuserlist><![CDATA[alice,bob]]></atuserlist></msgsource>";CHECK(CSAIEventFromWrap(wrap,@"alice",@"")!=nil);
    wrap.m_nsMsgSource=@"<msgsource><atuserlist>alice";event=CSAIEventFromWrap(wrap,@"alice",@"");CHECK(event && ![event[@"mentioned"] boolValue]);wrap.m_nsMsgSource=@"";wrap.m_nsContent=@"bob:\n普通群消息";event=CSAIEventFromWrap(wrap,@"alice",@"");CHECK(event && ![event[@"mentioned"] boolValue]);CHECK([event[@"text"] isEqual:@"普通群消息"]);
    wrap.m_nsMsgSource=@"<msgsource><silent>1</silent></msgsource>";event=CSAIEventFromWrap(wrap,@"alice",@"");CHECK([event[@"text"] isEqual:@"普通群消息"] && ![event[@"mentioned"] boolValue]);
    wrap.m_nsAtUserList=@"alice";wrap.m_nsContent=@"bob:\n@Alice\u2005你好 @Bob\u2005世界";
    for(NSUInteger i=0;i<3;i++){event=CSAIEventFromWrap(wrap,@"alice",@"");CHECK([event[@"text"] isEqual:@"你好 世界"] && [event[@"mentioned"] boolValue]);}
    wrap.m_nsAtUserList=@"alice";wrap.m_nsContent=@"bob:\n@Alice\u2005";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));wrap.m_nsContent=@"hello";wrap.m_nsRealChatUsr=@"alice";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));wrap.m_nsRealChatUsr=@"bob";
    CSAIMarkOwnedSend(wrap);CHECK(CSAIIsOwnedSend(wrap));CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));
    testStore=[[CSAIReplyStore alloc]initWithURL:[NSURL fileURLWithPath:@(argv[1])] account:@"alice"];CHECK([testStore load]);
    TestDetailPage *page=[TestDetailPage new];id native=page->m_tableViewInfo.sections.firstObject;
    CSAIRefreshChatDetail(page);CHECK(page->m_tableViewInfo.sections.count==2);CHECK(page->m_tableViewInfo.sections.firstObject==native);
    WCTableViewSectionManager *section=page->m_tableViewInfo.sections.lastObject;CHECK(section.cells.count==2);WCTableViewCellManager *toggle=section.cells[0];CHECK(!toggle.on);CHECK(([[section.cells valueForKey:@"title"] isEqual:@[@"启用 AI 回复",@"回复预设"]]));
    for(NSUInteger i=0;i<5;i++)CSAIRefreshChatDetail(page);CHECK(page->m_tableViewInfo.sections.count==2);CHECK(page->m_tableViewInfo.sections.firstObject==native);
    UISwitch *control=[UISwitch new];control.on=YES;((void(*)(id,SEL,id))objc_msgSend)(toggle.target,toggle.action,control);CHECK(mutations==1);
    WCTableViewCellManager *preset=section.cells[1];((void(*)(id,SEL))objc_msgSend)(preset.target,preset.action);CHECK(pickerCalls==1);
    testEpoch++;CSAIRefreshChatDetail(page);CHECK(page->m_tableViewInfo.sections.count==1);((void(*)(id,SEL,id))objc_msgSend)(toggle.target,toggle.action,control);CHECK(mutations==1);((void(*)(id,SEL))objc_msgSend)(preset.target,preset.action);CHECK(pickerCalls==1);
    TestDetailPage *next=[TestDetailPage new];next.contact.m_nsUsrName=@"group@chatroom";
    WCTableViewSectionManager *members=NativeSection(next,@"群成员",NULL),*search=NativeSection(next,@"查找聊天内容",@selector(onEditAndSearch)),*mute=NativeSection(next,@"消息免打扰",@selector(onMute)),*exitSection=NativeSection(next,@"退出群聊",NULL);
    next->m_tableViewInfo.sections=[@[members,search,mute,exitSection] mutableCopy];NSArray *nativeSections=[next->m_tableViewInfo.sections copy];id searchCell=search.cells[0],muteCell=mute.cells[0];
    CSAIRefreshChatDetail(next);
    CHECK([next->m_tableViewInfo.sections isEqual:nativeSections]);CHECK(search.cells.count==4);CHECK(search.cells[0]==searchCell);CHECK(!search.headerTitle && !search.footerTitle);
    toggle=search.cells[1];WCTableViewCellManager *unmentioned=search.cells[2];preset=search.cells[3];CHECK([toggle.title isEqual:@"启用 AI 回复"]);CHECK(!toggle.on && !toggle.detail);CHECK([unmentioned.title isEqual:@"免 @ 回复"] && !unmentioned.on);CHECK([preset.title isEqual:@"回复预设"]);
    CHECK(next->m_tableViewInfo.sections[2]==mute && mute.cells[0]==muteCell);CHECK(next->m_tableViewInfo.sections.lastObject==exitSection);
    ((void(*)(id,SEL))objc_msgSend)([searchCell target],[searchCell action]);((void(*)(id,SEL))objc_msgSend)([muteCell target],[muteCell action]);CHECK(searchCalls==1 && muteCalls==1);
    ((void(*)(id,SEL,id))objc_msgSend)(toggle.target,toggle.action,control);CHECK(mutations==2);
    ((void(*)(id,SEL,id))objc_msgSend)(unmentioned.target,unmentioned.action,control);CHECK(unmentionedMutations==1 && [unmentionedTarget isEqual:@"group@chatroom"] && unmentionedValue);
    ((void(*)(id,SEL,id))objc_msgSend)(unmentioned.target,unmentioned.action,[NSObject new]);CHECK(unmentionedMutations==1);
    ((void(*)(id,SEL))objc_msgSend)(preset.target,preset.action);CHECK(pickerCalls==2);
    for(NSUInteger i=0;i<5;i++)[NSNotificationCenter.defaultCenter postNotificationName:CSAIReplyDidChange object:nil];
    CHECK(search.cells.count==4);CHECK([next->m_tableViewInfo.sections isEqual:nativeSections]);CHECK(search.cells[0]==searchCell && mute.cells[0]==muteCell);
    NSMutableDictionary *configuration=[testStore.configuration mutableCopy];configuration[@"conversations"]=@{@"group@chatroom":@{@"enabled":@YES,@"presetID":@""}};CHECK([testStore saveConfiguration:configuration error:NULL]);
    CSAIRefreshChatDetail(next);toggle=search.cells[1];CHECK(toggle.on);CHECK([toggle.detail isEqual:@"总开关已关闭"]);CHECK(!search.headerTitle && !search.footerTitle);
    unmentioned=search.cells[2];CHECK(!unmentioned.on);
    configuration=[testStore.configuration mutableCopy];configuration[@"conversations"]=@{@"group@chatroom":@{@"enabled":@YES,@"presetID":@"",@"allowUnmentioned":@YES}};CHECK([testStore saveConfiguration:configuration error:NULL]);CSAIRefreshChatDetail(next);unmentioned=search.cells[2];CHECK(unmentioned.on);
    control.on=NO;((void(*)(id,SEL,id))objc_msgSend)(unmentioned.target,unmentioned.action,control);CHECK(unmentionedMutations==2 && !unmentionedValue);control.on=YES;
    // Native rebuilds may move the search section. Resolve its action again;
    // native section and row indices must stay exactly as rebuilt by WeChat.
    WCTableViewSectionManager *localized=NativeSection(next,@"Search Chat History",@selector(onEditAndSearch));
    next->m_tableViewInfo.sections=[@[members,mute,localized,exitSection] mutableCopy];nativeSections=[next->m_tableViewInfo.sections copy];CSAIRefreshChatDetail(next);
    CHECK([next->m_tableViewInfo.sections isEqual:nativeSections]);CHECK(localized.cells.count==4);CHECK(mute.cells[0]==muteCell);
    allowed=NO;[NSNotificationCenter.defaultCenter postNotificationName:CSAIReplyDidChange object:nil];CHECK(localized.cells.count==1);CHECK([next->m_tableViewInfo.sections isEqual:nativeSections]);((void(*)(id,SEL,id))objc_msgSend)(unmentioned.target,unmentioned.action,control);CHECK(unmentionedMutations==2);allowed=YES;
    CSAIRefreshChatDetail(next);CHECK(localized.cells.count==4);toggle=localized.cells[1];unmentioned=localized.cells[2];preset=localized.cells[3];testEpoch++;
    CSAIRefreshChatDetail(next);CHECK(localized.cells.count==1);CHECK([next->m_tableViewInfo.sections isEqual:nativeSections]);
    ((void(*)(id,SEL,id))objc_msgSend)(toggle.target,toggle.action,control);((void(*)(id,SEL,id))objc_msgSend)(unmentioned.target,unmentioned.action,control);((void(*)(id,SEL))objc_msgSend)(preset.target,preset.action);CHECK(mutations==2 && unmentionedMutations==2 && pickerCalls==2);
    // Exact visible-title fallback supports native versions with another action.
    TestDetailPage *fallback=[TestDetailPage new];fallback.contact.m_nsUsrName=@"fallback@chatroom";
    WCTableViewSectionManager *titleOnly=NativeSection(fallback,@"查找聊天内容",@selector(onMute));fallback->m_tableViewInfo.sections=[@[titleOnly,exitSection] mutableCopy];unsupportedSimpleUnmentioned=YES;CSAIRefreshChatDetail(fallback);unsupportedSimpleUnmentioned=NO;CHECK(titleOnly.cells.count==4);CHECK(fallback->m_tableViewInfo.sections.count==2);CHECK([((WCTableViewCellManager *)titleOnly.cells[2]).title isEqual:@"免 @ 回复"]);
    // An absent/ambiguous/non-terminal anchor never creates a bottom fallback
    // or shifts any pre-existing native row to an incorrect cached index path.
    TestDetailPage *unsupported=[TestDetailPage new];unsupported.contact.m_nsUsrName=@"unsupported@chatroom";
    unsupported->m_tableViewInfo.sections=[@[members,mute,exitSection] mutableCopy];nativeSections=[unsupported->m_tableViewInfo.sections copy];CSAIRefreshChatDetail(unsupported);CHECK([unsupported->m_tableViewInfo.sections isEqual:nativeSections]);
    WCTableViewSectionManager *firstSearch=NativeSection(unsupported,@"查找聊天内容",@selector(onEditAndSearch)),*secondSearch=NativeSection(unsupported,@"Search",@selector(onEditAndSearch));
    unsupported->m_tableViewInfo.sections=[@[firstSearch,secondSearch,exitSection] mutableCopy];CSAIRefreshChatDetail(unsupported);CHECK(firstSearch.cells.count==1 && secondSearch.cells.count==1);CHECK(unsupported->m_tableViewInfo.sections.count==3);
    [firstSearch addCell:muteCell];unsupported->m_tableViewInfo.sections=[@[firstSearch,exitSection] mutableCopy];CSAIRefreshChatDetail(unsupported);CHECK(firstSearch.cells.count==2 && firstSearch.cells[1]==muteCell);CHECK(unsupported->m_tableViewInfo.sections.count==2);
    printf("AI native adapters: %lu checks passed\n",(unsigned long)checks);return 0;
}}
