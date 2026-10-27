#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "CSAIMessageAdapter.h"
#import "CSAIChatDetailAdapter.h"
#import "CSAIReplyManager.h"
#import "CSAIReplySettingsViewController.h"
#import "AINativeDispatchUnderTest.m"
static NSUInteger checks,mutations,pickerCalls;
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
@interface WCTableViewCellManager : NSObject
@property SEL action;
@property id target;
@property NSString *title;
@property BOOL on;
+ (id)switchCellForSel:(SEL)sel target:(id)target title:(id)title on:(BOOL)on;
+ (id)normalCellForSel:(SEL)sel target:(id)target title:(id)title rightValue:(id)value;
@end
@implementation WCTableViewCellManager
+ (id)switchCellForSel:(SEL)sel target:(id)target title:(id)title on:(BOOL)on{WCTableViewCellManager *cell=[self new];cell.action=sel;cell.target=target;cell.title=title;cell.on=on;return cell;}
+ (id)normalCellForSel:(SEL)sel target:(id)target title:(id)title rightValue:(id)value{(void)value;return [self switchCellForSel:sel target:target title:title on:NO];}
@end
@interface WCTableViewSectionManager : NSObject
@property NSMutableArray *cells;
@property NSString *footerTitle;
+ (id)sectionWithHeader:(NSString *)title;
- (void)addCell:(id)cell;
@end
@implementation WCTableViewSectionManager
+ (id)sectionWithHeader:(NSString *)title{(void)title;WCTableViewSectionManager *section=[self new];section.cells=[NSMutableArray array];return section;}
- (void)addCell:(id)cell{[self.cells addObject:cell];}
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
@end
@implementation TestDetailPage
- (instancetype)init{if((self=[super init])){m_tableViewInfo=[TestTableManager new];_controller=[UIViewController new];_contact=[TestContact new];_contact.m_nsUsrName=@"friend";}return self;}
- (id)getChatContact{return self.contact;}
- (id)getViewController{return self.controller;}
@end
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
@end
#pragma clang diagnostic pop
void CSAIPresentPresetPicker(UIViewController *controller,NSString *conversation,NSString *account,NSUInteger epoch){(void)controller;(void)conversation;(void)account;(void)epoch;pickerCalls++;}
int main(int argc,const char **argv){@autoreleasepool{
    CHECK(argc==2);TestWrap *wrap=[TestWrap new];wrap.m_nsFromUsr=@"friend";wrap.m_nsToUsr=@"alice";wrap.m_nsContent=@"hello";wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=7;wrap.m_n64MesSvrID=55;wrap.m_uiCreateTime=1800000000;
    NSDictionary *event=CSAIEventFromWrap(wrap,@"alice",@"friend");CHECK([event[@"text"] isEqual:@"hello"]);CHECK([event[@"identifiers"] count]==2);CHECK(![event[@"group"] boolValue]);
    CHECK(!CSAIEventFromWrap(wrap,@"bob",@"friend"));CHECK(!CSAIEventFromWrap(wrap,@"alice",@"wrong"));wrap.m_uiMessageType=49;CHECK(!CSAIEventFromWrap(wrap,@"alice",@"friend"));wrap.m_uiMessageType=1;
    wrap.m_nsFromUsr=@"group@chatroom";wrap.m_nsRealChatUsr=@"bob";wrap.m_nsContent=@"bob:\n@Alice\u2005你好";wrap.m_nsAtUserList=@"alice2";CHECK(!CSAIEventFromWrap(wrap,@"alice",@"group@chatroom"));
    wrap.m_nsAtUserList=@"bob,alice";event=CSAIEventFromWrap(wrap,@"alice",@"group@chatroom");CHECK([event[@"text"] isEqual:@"你好"]);CHECK([event[@"sender"] isEqual:@"bob"]);CHECK([event[@"group"] boolValue] && [event[@"mentioned"] boolValue]);
    wrap.m_nsAtAll=YES;CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));wrap.m_nsAtAll=NO;wrap.m_nsAtUserList=@"alice,notify@all";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));
    wrap.m_nsAtUserList=@"";wrap.m_nsMsgSource=@"<msgsource><atuserlist><![CDATA[alice,bob]]></atuserlist></msgsource>";CHECK(CSAIEventFromWrap(wrap,@"alice",@"")!=nil);
    wrap.m_nsMsgSource=@"<msgsource><atuserlist>alice";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));wrap.m_nsMsgSource=@"";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));
    wrap.m_nsAtUserList=@"alice";wrap.m_nsContent=@"bob:\n@Alice\u2005";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));wrap.m_nsContent=@"hello";wrap.m_nsRealChatUsr=@"alice";CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));wrap.m_nsRealChatUsr=@"bob";
    CSAIMarkOwnedSend(wrap);CHECK(CSAIIsOwnedSend(wrap));CHECK(!CSAIEventFromWrap(wrap,@"alice",@""));
    testStore=[[CSAIReplyStore alloc]initWithURL:[NSURL fileURLWithPath:@(argv[1])] account:@"alice"];CHECK([testStore load]);
    TestDetailPage *page=[TestDetailPage new];id native=page->m_tableViewInfo.sections.firstObject;
    CSAIRefreshChatDetail(page);CHECK(page->m_tableViewInfo.sections.count==2);CHECK(page->m_tableViewInfo.sections.firstObject==native);
    WCTableViewSectionManager *section=page->m_tableViewInfo.sections.lastObject;CHECK(section.cells.count==2);WCTableViewCellManager *toggle=section.cells[0];CHECK(!toggle.on);
    for(NSUInteger i=0;i<5;i++)CSAIRefreshChatDetail(page);CHECK(page->m_tableViewInfo.sections.count==2);CHECK(page->m_tableViewInfo.sections.firstObject==native);
    UISwitch *control=[UISwitch new];control.on=YES;((void(*)(id,SEL,id))objc_msgSend)(toggle.target,toggle.action,control);CHECK(mutations==1);
    WCTableViewCellManager *preset=section.cells[1];((void(*)(id,SEL))objc_msgSend)(preset.target,preset.action);CHECK(pickerCalls==1);
    testEpoch++;CSAIRefreshChatDetail(page);CHECK(page->m_tableViewInfo.sections.count==1);((void(*)(id,SEL,id))objc_msgSend)(toggle.target,toggle.action,control);CHECK(mutations==1);((void(*)(id,SEL))objc_msgSend)(preset.target,preset.action);CHECK(pickerCalls==1);
    TestDetailPage *next=[TestDetailPage new];next.contact.m_nsUsrName=@"group@chatroom";CSAIRefreshChatDetail(next);CHECK(next->m_tableViewInfo.sections.count==2);section=next->m_tableViewInfo.sections.lastObject;CHECK([section.footerTitle containsString:@"@ 所有人不触发"]);
    allowed=NO;[NSNotificationCenter.defaultCenter postNotificationName:CSAIReplyDidChange object:nil];CHECK(next->m_tableViewInfo.sections.count==1);
    printf("AI native adapters: %lu checks passed\n",(unsigned long)checks);return 0;
}}
