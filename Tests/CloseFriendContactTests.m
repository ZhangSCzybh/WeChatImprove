#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCloseFriendContactProjection.h"
static void Check(BOOL condition,NSString *message) { if(!condition) {fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1);} }
@interface Contact : NSObject
@property(nonatomic,copy) NSString *username, *m_nsNickName, *remark;
@property(nonatomic) BOOL isFriend;
@end
@implementation Contact @end
static Contact *Person(NSString *name) {Contact *c=[Contact new]; c.username=name; c.isFriend=YES; return c;}
static CSCloseFriendSnapshot *Policy(BOOL revealed,NSUInteger revision) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"account-A" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[@"private@chatroom"],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:revision blocked:NO];
}
static CSCloseFriendSnapshot *Current;
static NSUInteger Epoch=1;
NSUInteger CSCloseFriendAccountEpoch(void) { return Epoch; }
CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Current;}
BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) {return [Current hidesUserName:name surface:surface];}
id CSCloseFriendRead(id object,NSString *key) {return [object valueForKey:key];}
NSString *CSCloseFriendUserName(id object) {return [object isKindOfClass:Contact.class] ? [object username] : nil;}
BOOL CSCFIsClass(id object,NSString *name) {return [object isKindOfClass:NSClassFromString(name)];}
#import "GroupTitle.h"
// The production profile state predicate, compiled verbatim by the focused runner.
@interface CSCFProfileState : NSObject
@property(nonatomic) NSUInteger epoch;
@property(nonatomic,copy) NSString *userName;
@end
@implementation CSCFProfileState @end
#import "ProfilePredicate.h"
static CSCFProfileState *ProfileState;
BOOL CSCFProfileBlocksAction(id object) { (void)object; return Masked(ProfileState); }
BOOL CSCloseFriendInstallHook(NSString *className,NSString *name,IMP replacement,IMP *original,const char *encoding) {
    (void)encoding; Class cls=NSClassFromString(className); SEL selector=NSSelectorFromString(name); Method method=class_getInstanceMethod(cls,selector);
    if(!method) return NO; *original=method_getImplementation(method); method_setImplementation(method,replacement); return YES;
}
// Compile the production action wrappers, rather than a test-only imitation of their control flow.
#import "ProfileGuards.h"
@interface NativeAssist : NSObject
@property(nonatomic) NSUInteger sent;
- (void)doAddContact;
- (void)onNewMessage:(id)sender;
@end
@implementation NativeAssist
- (void)doAddContact {self.sent++;}
- (void)onNewMessage:(id)sender {(void)sender; self.sent++;}
@end
int main(void) {@autoreleasepool {
    CSCloseFriendIdentity identity=^NSString *(id item){return [item isKindOfClass:NSString.class] ? item : [item username];};
    Contact *visible=Person(@"ordinary"), *hidden=Person(@"secret"), *group=Person(@"private@chatroom");
    NSMutableArray *a=[NSMutableArray arrayWithArray:@[hidden,visible]], *b=[NSMutableArray arrayWithObject:group];
    NSDictionary *source=@{@"A":a,@"B":b}; Current=Policy(NO,1);
    CSCloseFriendContactProjection *p=[[CSCloseFriendContactProjection alloc] initWithKeys:@[@"A",@"B"] sections:source snapshot:Current surface:CSCloseFriendSurfaceContact identity:identity];
    Check(p.count==1 && [p.keys isEqual:@[@"A"]] && p.sections[@"A"][0]==visible,@"count, section index, and selected object share one projection");
    Check(a.count==2 && b.count==1 && hidden.isFriend,@"source arrays and relationship untouched");
    [a removeObject:visible]; Check([p.sections[@"A"] count]==1,@"source updates do not mutate a published projection");
    CSCloseFriendContactProjection *next=[[CSCloseFriendContactProjection alloc] initWithKeys:@[@"A",@"B"] sections:source snapshot:Current surface:CSCloseFriendSurfaceContact identity:identity];
    Check(next.count==0 && next.keys.count==0,@"fresh snapshot reflects removals and empty sections");
    Check(CSCloseFriendVisibleContacts(a,Policy(YES,2),CSCloseFriendSurfaceContact,identity).count==1,@"reveal derives from intact latest source");
    NSArray *members=@[@"secret",@"ordinary"];
    Check(CSCloseFriendVisibleContacts(members,Current,CSCloseFriendSurfaceTag,identity).count==1 && members.count==2,@"tag presentation preserves full membership");
    Current=Policy(YES,2); CSCloseFriendSelectionTicket *ticket=[[CSCloseFriendSelectionTicket alloc] initWithSnapshot:Current epoch:Epoch];
    Check([ticket allowsRecipients:@[visible,hidden] snapshot:Current epoch:Epoch identity:identity],@"revealed native recipients accepted intact");
    Check(![ticket allowsRecipients:@[visible,hidden] snapshot:Policy(NO,3) epoch:Epoch identity:identity],@"locking rejects entire stale recipient selection");
    Check(![ticket allowsRecipients:@[visible] snapshot:Current epoch:2 identity:identity],@"account boundary invalidates even ordinary recipients");
    CSCloseFriendSelectionTicket *locked=[[CSCloseFriendSelectionTicket alloc] initWithSnapshot:Policy(NO,3) epoch:Epoch];
    Check(![locked allowsRecipients:@[visible,hidden] snapshot:Policy(NO,3) epoch:Epoch identity:identity],@"current concealed recipient blocks entire submit");
    group.m_nsNickName=@"公开群名"; group.remark=@"密友匹配摘要";
    Check([GroupDisplayTitle(group) isEqual:@"公开群名"],@"group row cover exposes public group title, never member-match summary");
    hidden.m_nsNickName=@"公开昵称"; hidden.remark=@"私密备注";
    Check([PublicNickname(hidden,hidden.username) isEqual:@"公开昵称"],@"stranger presentation uses public nickname, never saved remark");
    ProfileState=[CSCFProfileState new]; ProfileState.userName=@"secret"; ProfileState.epoch=Epoch;
    Guard0(@"NativeAssist",@"doAddContact"); Guard1(@"NativeAssist",@"onNewMessage:"); NativeAssist *assist=[NativeAssist new];
    Current=Policy(NO,3); [assist doAddContact]; [assist onNewMessage:nil];
    Check(assist.sent==0 && hidden.isFriend,@"masked profile guards never invoke native add/message or change friendship");
    Current=Policy(YES,4); [assist onNewMessage:nil]; Check(assist.sent==1,@"reveal permits native action again");
    Epoch++; [assist doAddContact]; Check(assist.sent==1,@"stale assist stays blocked across accounts");
    printf("Close-friend contacts: projection/source/tag preservation, stale forwarding, profile action guards passed\n");
} return 0;}
