#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendContactProjection.h"
#import "CSCloseFriendSignatures.h"

static void Check(BOOL condition,NSString *message) {
    if(!condition) {fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1);}
}
static CSCloseFriendSnapshot *Current;
static id ContactService;
static NSUInteger ServiceRequests;
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Current;}
id CSGetService(Class serviceClass) {ServiceRequests++; return serviceClass ? ContactService : nil;}
#import "ContactReadBodies.h"
#import "TagSummaryBodies.h"

@interface TagContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName,*m_nsRemark,*m_nsNickName,*nativeDisplayName;
- (NSString *)getContactDisplayName;
@end
@implementation TagContact
- (NSString *)getContactDisplayName {return self.nativeDisplayName;}
@end
@interface CContactMgr : NSObject
@property(nonatomic,copy) NSDictionary *contacts;
@property(nonatomic) NSUInteger lookups;
- (id)getContactByName:(NSString *)name;
@end
@implementation CContactMgr
- (id)getContactByName:(NSString *)name {self.lookups++; return self.contacts[name];}
@end
@interface WrongContactMgr : NSObject
- (NSInteger)getContactByName:(NSString *)name;
@end
@implementation WrongContactMgr
- (NSInteger)getContactByName:(__unused NSString *)name {@throw [NSException exceptionWithName:@"UnexpectedCall" reason:nil userInfo:nil];}
@end
@interface TagData : NSObject
@property(nonatomic,strong) NSArray *m_arrContactNameList;
@end
@implementation TagData @end
@interface TagCell : NSObject
@property(nonatomic,copy) NSString *memberCountText,*memberListText,*renderedText;
@property(nonatomic,copy) NSAttributedString *memberListAttributedText;
@property(nonatomic,weak) TagData *tagData;
@property(nonatomic) BOOL showMemberList;
@property(nonatomic) NSUInteger renders;
- (void)updateView;
@end
@implementation TagCell
- (void)updateView {self.renderedText=self.memberListAttributedText.string ?: self.memberListText; self.renders++;}
@end
static TagContact *Person(NSString *username,NSString *remark,NSString *nickname,NSString *display) {
    TagContact *contact=[TagContact new]; contact.m_nsUsrName=username; contact.m_nsRemark=remark;
    contact.m_nsNickName=nickname; contact.nativeDisplayName=display; return contact;
}
static CSCloseFriendSnapshot *Policy(BOOL revealed,BOOL hideTags) {
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy]; options[@"hideTags"]=@(hideTags);
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"account-A" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":options} revealed:revealed revision:revealed?2:1 blocked:NO];
}
static void NativeConfigure(TagCell *cell,TagData *tag) {
    cell.tagData=tag; cell.showMemberList=YES;
    cell.memberCountText=[NSString stringWithFormat:@"(%lu)",(unsigned long)tag.m_arrContactNameList.count];
    cell.memberListText=[CSCFContactNames(tag.m_arrContactNameList) componentsJoinedByString:@", "];
    cell.memberListAttributedText=[[NSAttributedString alloc] initWithString:cell.memberListText];
    [cell updateView];
}
int main(void) {@autoreleasepool {
    TagContact *ordinary=Person(@"ordinary",@"普通备注",@"普通昵称",@"普通显示名");
    TagContact *secret=Person(@"secret",@"密友备注",@"密友昵称",@"密友显示名");
    TagContact *comma=Person(@"comma",nil,@"王, 小明",nil);
    TagContact *remark=Person(@"remark",@"备注优先",@"备用昵称",nil);
    TagContact *fallback=Person(@"fallback",nil,nil,nil);
    CContactMgr *manager=[CContactMgr new];
    manager.contacts=@{@"ordinary":ordinary,@"secret":secret,@"comma":comma,@"remark":remark,@"fallback":fallback};
    ContactService=manager; Current=Policy(NO,YES);
    NSArray *names=CSCFContactNames(@[@"ordinary",remark,@"comma",@"fallback",@"missing"]);
    Check([names isEqual:@[@"普通显示名",@"备注优先",@"王, 小明",@"fallback",@"missing"]],@"display names prefer native display/remark/nickname, preserving order and username fallbacks");
    Check(ServiceRequests==1 && manager.lookups==4,@"one service lookup per projection and only username entries require contact lookup");
    Check(!CSCFContactNames((id)@"invalid").count && !CSCFContactNames(nil).count,@"malformed or absent arrays produce no display names");
    ContactService=[WrongContactMgr new];
    Check([CSCFContactNames(@[@"ordinary"]) isEqual:@[@"ordinary"]],@"incompatible contact lookup signatures safely retain username fallback");
    ContactService=manager;

    NSMutableArray *members=[@[@"ordinary",@"secret",@"comma"] mutableCopy];
    TagData *tag=[TagData new];tag.m_arrContactNameList=members;
    TagCell *cell=[TagCell new];NativeConfigure(cell,tag);CSCFUpdateTagSummary(cell,tag);
    Check([cell.memberListText isEqual:@"普通显示名, 王, 小明"] && [cell.renderedText isEqual:cell.memberListText],@"mixed tag retains ordinary names, including commas inside a nickname, and clears the original attributed leak");
    Check([cell.memberCountText isEqual:@"(2)"] && cell.showMemberList,@"visible count retains native parentheses and the ordinary member list remains enabled");
    Check(cell.tagData==tag && tag.m_arrContactNameList==members && [members isEqual:@[@"ordinary",@"secret",@"comma"]],@"native tag ownership and complete membership are untouched");
    Check([secret.nativeDisplayName isEqual:@"密友显示名"] && [ordinary.nativeDisplayName isEqual:@"普通显示名"],@"contact display models remain intact");
    cell.memberCountText=@"（3）";CSCFUpdateTagSummary(cell,tag);
    Check([cell.memberCountText isEqual:@"（2）"],@"full-width native count punctuation is preserved");
    cell.memberCountText=nil;CSCFUpdateTagSummary(cell,tag);
    Check([cell.memberCountText isEqual:@"(2)"],@"missing native count falls back to parenthesized formatting");

    TagData *allSecret=[TagData new];allSecret.m_arrContactNameList=@[@"secret"];
    NativeConfigure(cell,allSecret);CSCFUpdateTagSummary(cell,allSecret);
    Check([cell.memberListText isEqual:@""] && [cell.renderedText isEqual:@""] && [cell.memberCountText isEqual:@"(0)"],@"tag containing only concealed members exposes no names or stale attributed text");
    TagData *allOrdinary=[TagData new];allOrdinary.m_arrContactNameList=@[@"ordinary",@"comma"];
    NativeConfigure(cell,allOrdinary);NSUInteger renders=cell.renders;NSAttributedString *nativeText=cell.memberListAttributedText;
    CSCFUpdateTagSummary(cell,allOrdinary);
    Check(cell.renders==renders && cell.memberListAttributedText==nativeText && [cell.memberListText isEqual:@"普通显示名, 王, 小明"],@"tags with no hidden members retain native rendering and attributed formatting");

    Current=Policy(YES,YES);NativeConfigure(cell,tag);CSCFUpdateTagSummary(cell,tag);
    Check([cell.memberListText isEqual:@"普通显示名, 密友显示名, 王, 小明"] && [cell.memberCountText isEqual:@"(3)"],@"reveal restores full names by rebuilding from preserved native data");
    Current=Policy(NO,NO);NativeConfigure(cell,tag);CSCFUpdateTagSummary(cell,tag);
    Check([cell.memberListText isEqual:@"普通显示名, 密友显示名, 王, 小明"],@"turning off tag hiding keeps all native names");
    Current=Policy(NO,YES);NativeConfigure(cell,tag);CSCFUpdateTagSummary(cell,tag);
    Check([cell.memberListText isEqual:@"普通显示名, 王, 小明"] && members.count==3,@"relocking filters again without losing tag members");
    TagData *models=[TagData new];models.m_arrContactNameList=@[ordinary,secret,comma];
    NativeConfigure(cell,models);CSCFUpdateTagSummary(cell,models);
    Check([cell.memberListText isEqual:@"普通显示名, 王, 小明"] && models.m_arrContactNameList.count==3,@"contact-object member arrays use the same identity filter and summary");
    printf("Close-friend tag summaries: mixed/all-hidden tags, display-name compatibility, punctuation, reveal and source preservation passed\n");
} return 0;}
