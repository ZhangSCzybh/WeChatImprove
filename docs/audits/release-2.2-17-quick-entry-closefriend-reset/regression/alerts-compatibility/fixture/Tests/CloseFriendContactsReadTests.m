#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCloseFriendContactProjection.h"
#import "CSCloseFriendSignatures.h"
static NSUInteger Checks,Epoch=1;
static CSCloseFriendSnapshot *Current;
static void Check(BOOL ok,NSString *message) {Checks++; if(!ok) {fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1);}}
static CSCloseFriendSnapshot *Policy(BOOL revealed,NSUInteger revision,NSString *account) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:account profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:revision blocked:NO];
}
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Current;}
static NSUInteger CSCloseFriendAccountEpoch(void) {return Epoch;}
static id CSCloseFriendRead(id object,NSString *name) {@try {return [object valueForKey:name];} @catch(__unused NSException *exception) {return nil;}}
static NSString *CSCloseFriendUserName(id object) {return [object isKindOfClass:NSString.class] ? object : nil;}
static BOOL CSCFIsClass(id object,NSString *name) {return [object isKindOfClass:NSClassFromString(name)];}
static void CSCFTrackSurface(__unused id owner,__unused NSString *selector) {}
#include "ContactsSurface.h"
static BOOL CSCloseFriendInstallHook(NSString *name,NSString *methodName,IMP replacement,IMP *original,const char *type) {
    Class cls=NSClassFromString(name);SEL selector=NSSelectorFromString(methodName);Method method=class_getInstanceMethod(cls,selector);
    if(!CSCloseFriendMethodMatches(method,type)) return NO;
    *original=method_getImplementation(method);class_replaceMethod(cls,selector,replacement,method_getTypeEncoding(method));return YES;
}
@interface ContactsDataLogic : NSObject
@property(nonatomic,weak) id m_delegate;
@property(nonatomic,strong) NSMutableArray *sourceKeys;
@property(nonatomic,strong) NSMutableDictionary *sourceSections;
@property(nonatomic,copy) void (^onRows)(void);
@property(nonatomic) NSUInteger keyCalls,rowCalls;
- (id)getKeysArray;
- (id)getContactsArrayWith:(id)key;
@end
@implementation ContactsDataLogic
- (id)getKeysArray {self.keyCalls++; return self.sourceKeys;}
- (id)getContactsArrayWith:(id)key {self.rowCalls++; if(self.onRows) self.onRows();return self.sourceSections[key];}
@end
@interface ContactsViewController : NSObject
@property(nonatomic,strong) id m_tableView;
@property(nonatomic,strong) ContactsDataLogic *m_contactsDataLogic;
@property(nonatomic,copy) void (^betweenReads)(void);
@property(nonatomic) BOOL throwAfterRead;
- (id)mmsectionIndexTitlesForTableView:(id)table;
@end
@implementation ContactsViewController
- (id)mmsectionIndexTitlesForTableView:(__unused id)table {
    // Native 8.0.78 contract: two keys reads; only append to this local array in between.
    NSMutableArray *titles=[NSMutableArray array];
    if([[self.m_contactsDataLogic getKeysArray] count]) [titles addObject:@"#"];
    if(self.betweenReads) self.betweenReads();
    if(self.throwAfterRead) @throw [NSException exceptionWithName:@"fixture" reason:nil userInfo:nil];
    [titles addObjectsFromArray:[self.m_contactsDataLogic getKeysArray]];return titles;
}
@end
#include "ContactsReadBodies.h"
int main(void) {@autoreleasepool {
    Current=Policy(NO,1,@"account");
    Check(CSCloseFriendInstallHook(@"ContactsDataLogic",@"getContactsArrayWith:",(IMP)Rows,(IMP *)&OriginalRows,"@@:@") &&
          CSCloseFriendInstallHook(@"ContactsDataLogic",@"getKeysArray",(IMP)Keys,(IMP *)&OriginalKeys,"@@:"),@"coupled native getter ABI verified");
    InstallContactIndexRead();
    ContactsDataLogic *logic=[ContactsDataLogic new];logic.sourceKeys=[@[@"A",@"B"] mutableCopy];
    NSMutableArray *a=[@[@"secret",@"ordinary"] mutableCopy],*b=[@[@"secret"] mutableCopy];
    logic.sourceSections=[@{@"A":a,@"B":b} mutableCopy];
    ContactsViewController *page=[ContactsViewController new];page.m_tableView=[NSObject new];page.m_contactsDataLogic=logic;logic.m_delegate=page;
    Check([[page mmsectionIndexTitlesForTableView:page.m_tableView] isEqual:@[@"#",@"A"]],@"index titles use the same filtered projection");
    Check(logic.keyCalls==1 && logic.rowCalls==2,@"two synchronous native keys reads perform one complete two-section verification");
    logic.keyCalls=logic.rowCalls=0;[logic getKeysArray];[logic getKeysArray];
    Check(logic.keyCalls==2 && logic.rowCalls==4,@"ordinary reads still verify every section on every call");
    a[1]=@"secret";Check([[page mmsectionIndexTitlesForTableView:page.m_tableView] count]==0,@"next native transaction sees same-pointer same-length source mutation");
    a[1]=@"ordinary";Check([[logic getKeysArray] isEqual:@[@"A"]],@"source changes outside a transaction are never hidden behind scoped cache");
    logic.keyCalls=logic.rowCalls=0;[page mmsectionIndexTitlesForTableView:[NSObject new]];
    Check(logic.keyCalls==2 && logic.rowCalls==4,@"unrelated tables do not enter the verified scope");
    logic.keyCalls=logic.rowCalls=0;page.betweenReads=^{Current=Policy(NO,2,@"account");};
    [page mmsectionIndexTitlesForTableView:page.m_tableView];page.betweenReads=nil;
    Check(logic.keyCalls==2 && logic.rowCalls==4,@"privacy revision changes defeat scoped reuse");
    logic.keyCalls=logic.rowCalls=0;page.betweenReads=^{Epoch++;};
    [page mmsectionIndexTitlesForTableView:page.m_tableView];page.betweenReads=nil;
    Check(logic.keyCalls==2 && logic.rowCalls==4,@"account epoch changes defeat scoped reuse");
    logic.keyCalls=logic.rowCalls=0;page.betweenReads=^{Current=Policy(NO,2,@"other-account");};
    [page mmsectionIndexTitlesForTableView:page.m_tableView];page.betweenReads=nil;
    Check(logic.keyCalls==2 && logic.rowCalls==4,@"account identity changes defeat scoped reuse even with equal revision");
    page.throwAfterRead=YES;@try {[page mmsectionIndexTitlesForTableView:page.m_tableView];} @catch(__unused NSException *exception) {}
    page.throwAfterRead=NO;logic.keyCalls=logic.rowCalls=0;[logic getKeysArray];[logic getKeysArray];
    Check(!ContactsIndexRead && logic.keyCalls==2 && logic.rowCalls==4,@"exception leaves no scope for later ordinary reads");
    __block BOOL nested=NO;__weak ContactsViewController *weakPage=page;
    page.betweenReads=^{if(!nested) {nested=YES;ContactsViewController *owner=weakPage;[owner mmsectionIndexTitlesForTableView:owner.m_tableView];}};
    logic.keyCalls=logic.rowCalls=0;[page mmsectionIndexTitlesForTableView:page.m_tableView];page.betweenReads=nil;
    Check(!ContactsIndexRead && logic.keyCalls==3 && logic.rowCalls==6,@"unexpected nested native reads restore scope and force outer reverification");
    __block BOOL changed=NO;logic.onRows=^{if(!changed) {changed=YES;Epoch++;}};
    Check([[logic getKeysArray] count]==0,@"account transition during full source verification does not publish old-account rows");logic.onRows=nil;
    Check([[logic getKeysArray] isEqual:@[@"A"]],@"fresh verification recovers after account transition");
    Check(logic.sourceSections[@"A"]==a && a.count==2 && b.count==1 && logic.sourceKeys.count==2,@"projection never mutates native sections or keys");
    Current=Policy(YES,3,@"other-account");Check([[page mmsectionIndexTitlesForTableView:page.m_tableView] isEqual:@[@"#",@"A",@"B"]],@"temporary reveal preserves native index titles");
    fprintf(stdout,"Close-friend contacts read scope: %lu checks passed (native double keys, scoped verification, live mutable source, privacy/account, reentry/exception).\n",(unsigned long)Checks);
}return 0;}
