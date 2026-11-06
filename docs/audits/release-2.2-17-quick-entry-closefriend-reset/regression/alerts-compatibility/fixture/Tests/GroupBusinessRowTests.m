#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSGroupNativeBridge.h"
#import "CSGroupIndexScope.h"
#import "WESessionTabItem.h"
static BOOL CSCloseFriendShouldHideUserName(id name, NSUInteger surface) { (void)name; (void)surface; return NO; }
static const NSUInteger CSCloseFriendSurfaceSession=0;
static void CSCloseFriendUpdateSessionCover(id cell, id row) { (void)cell; (void)row; }
static char CellRowKey;
static NSString *account=@"test-account";
static NSUInteger CSCloseFriendAccountEpoch(void) { return 1; }
id CSGetService(Class cls) { (void)cls; return nil; }
@interface MMContext : NSObject
+ (NSString *)currentUserName;
@end
@implementation MMContext
+ (NSString *)currentUserName { return account; }
@end
@interface Label : NSObject
@property(nonatomic,copy) NSString *text;
@end
@implementation Label @end
static NSInteger UITableViewCellStyleDefault=0,UITableViewCellSelectionStyleNone=0;
@interface UITableViewCell : NSObject
@property(nonatomic,strong) Label *textLabel;
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic) NSInteger selectionStyle;
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier;
@end
@implementation UITableViewCell
- (instancetype)initWithStyle:(NSInteger)style reuseIdentifier:(NSString *)identifier {
    (void)style;(void)identifier;
    if ((self=[super init])) { self.textLabel=[Label new];self.userInteractionEnabled=YES; }
    return self;
}
@end
@interface Session : NSObject
@property(nonatomic,copy) NSString *m_nsUserName;
@property(nonatomic) unsigned int m_uUnReadCount;
@property(nonatomic) BOOL m_bIsTop,m_bShowUnReadAsRedDot,isInBrandServiceBox;
- (BOOL)isSingleChatSession;
@end
@implementation Session
- (BOOL)isSingleChatSession { return YES; }
@end
@interface CellData : NSObject
@property(nonatomic,strong) Session *m_sessionInfo;
@property(nonatomic,strong) id userName;
@end
@implementation CellData @end
@interface Logic : NSObject
@property(nonatomic,strong) NSMutableDictionary *sessions,*data;
@property(nonatomic) BOOL throwGetter;
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path;
- (id)getCellDataAtIndexPath:(NSIndexPath *)path;
- (NSIndexPath *)indexPathOfSessionUserName:(NSString *)name;
@end
@implementation Logic
- (id)getSessionInfoAtIndexPath:(NSIndexPath *)path {
    if (self.throwGetter) [NSException raise:@"fixture" format:@"unavailable native model"];
    return self.sessions[path];
}
- (id)getCellDataAtIndexPath:(NSIndexPath *)path { return self.data[path]; }
- (NSIndexPath *)indexPathOfSessionUserName:(NSString *)name {
    for (NSIndexPath *path in self.sessions) if ([[self.sessions[path] m_nsUserName] isEqual:name]) return path;
    return nil;
}
@end
@interface Host : NSObject
@property(nonatomic,strong) id m_tableView,m_mainFrameLogicController;
@property(nonatomic,strong) NSArray<NSNumber *> *counts;
@property(nonatomic,strong) UITableViewCell *banner;
@property(nonatomic) NSUInteger cellCalls;
@property(nonatomic) BOOL deliveredInNativeScope;
- (NSInteger)numberOfSectionsInTableView:(id)table;
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation Host
- (NSInteger)numberOfSectionsInTableView:(id)table { (void)table;return (NSInteger)self.counts.count; }
- (NSInteger)tableView:(id)table numberOfRowsInSection:(NSInteger)section { (void)table;return self.counts[(NSUInteger)section].integerValue; }
- (UITableViewCell *)tableView:(id)table cellForRowAtIndexPath:(NSIndexPath *)path {
    (void)path;self.cellCalls++;self.deliveredInNativeScope=CSGroupUsesNativeIndices(table);return self.banner;
}
@end
#include "GroupBusinessHelper.h"
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) Host *controller;
@property(nonatomic,strong) id table;
@property(nonatomic,strong) CSGroupProjection *projection;
@property(nonatomic,strong) NSDictionary *identityDisplayPaths;
@property(nonatomic) BOOL dirty;
@property(nonatomic) NSUInteger refreshRequests;
@property(nonatomic) NSUInteger modelRevision;
- (BOOL)isActive;
- (void)requestRefresh;
- (void)requestRecovery;
@end
@implementation CSGroupListAdapter
- (void)requestRecovery { [self requestRefresh]; }
#include "GroupBusinessBodies.h"
- (BOOL)isActive { return YES; }
- (void)requestRefresh { self.dirty=YES;self.refreshRequests++; }
@end
static NSUInteger checks,failures;
static void Check(BOOL ok,NSString *description) { checks++;if(!ok){failures++;fprintf(stderr,"FAIL: %s\n",description.UTF8String);} }
static NSIndexPath *Path(NSUInteger section,NSUInteger row) { NSUInteger i[]={section,row};return [NSIndexPath indexPathWithIndexes:i length:2]; }
static CSGroupRow *Row(NSIndexPath *path,NSString *name,CSGroupRowKind kind) {
    return [[CSGroupRow alloc] initWithNativePath:path userName:name kind:kind category:CSGroupRowCategoryUnknown top:YES unreadCount:0 redDot:NO];
}
int main(void) { @autoreleasepool {
    Host *host=[Host new];host.m_tableView=[NSObject new];host.counts=@[@1,@1];
    Logic *logic=[Logic new];logic.sessions=[NSMutableDictionary dictionary];logic.data=[NSMutableDictionary dictionary];host.m_mainFrameLogicController=logic;
    Session *chat=[Session new];chat.m_nsUserName=@"friend";logic.sessions[Path(1,0)]=chat;
    host.banner=[[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];host.banner.textLabel.text=@"置顶笔记";
    WESessionTabItem *tab=[WESessionTabItem tabWithType:WETabTypePrivate];
    NSArray *sections=CSGroupBuildNativeSections(host,host.m_tableView,host);
    CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:sections tabs:@[tab] selectedTabID:tab.tabId filterDuplicates:NO accountID:account];
    Check(projection.isValid && projection.sections.count==2,@"native banner and chat build a valid filtered projection");
    CSGroupRow *banner=[projection rowAtDisplayPath:Path(0,0)];
    Check(banner.kind==CSGroupRowKindBusiness && !banner.userName.length,@"native non-session banner retains business kind without a fabricated username");
    CSGroupListAdapter *a=[CSGroupListAdapter new];a.controller=host;a.table=host.m_tableView;a.projection=projection;a.identityDisplayPaths=@{@"friend":Path(1,0)};
    for (NSNumber *dirty in @[@NO,@YES]) {
        a.dirty=dirty.boolValue;
        Check([[a currentPathForRow:banner] isEqual:Path(0,0)],@"banner remains resolvable during deferred updates");
        Check([[a displayPath:Path(0,0)] isEqual:Path(0,0)],@"native banner queries map back to the displayed slot even while dirty");
        Check([a cellForDisplayPath:Path(0,0) target:host]==host.banner,@"scrolling a banner back on screen delivers its original cell instead of a placeholder");
    }
    Check(host.deliveredInNativeScope && !CSGroupUsesNativeIndices(host.m_tableView),@"native cell delivery enters and exits the proper index scope");
    Check(a.refreshRequests==0,@"valid banner delivery does not trigger a placeholder refresh loop");
    a.dirty=YES;
    Check([[a currentPathForRow:[projection rowAtDisplayPath:Path(1,0)]] isEqual:Path(1,0)],@"named chat validation remains available while dirty");
    Check([[a displayPath:Path(1,0)] isEqual:Path(1,0)],@"named chat reverse lookup remains unchanged");
    host.counts=@[@0,@1];
    Check(![a currentPathForRow:banner] && ![a displayPath:Path(0,0)],@"removed banner is rejected in both directions");host.counts=@[@1,@1];
    logic.sessions[Path(0,0)]=chat;
    Check(![a currentPathForRow:banner],@"banner slot reused by a real chat is rejected");
    NSUInteger calls=host.cellCalls;UITableViewCell *placeholder=[a cellForDisplayPath:Path(0,0) target:host];
    Check(placeholder!=host.banner && !placeholder.userInteractionEnabled && host.cellCalls==calls,@"invalid row never calls the host using a replacement chat's index");
    [logic.sessions removeObjectForKey:Path(0,0)];
    CellData *data=[CellData new];data.m_sessionInfo=chat;logic.data[Path(0,0)]=data;
    Check(![a currentPathForRow:banner],@"real session exposed only through CellData is also rejected");data.m_sessionInfo=nil;data.userName=@"fake-name";
    Check(![a currentPathForRow:banner] && ![a displayPath:Path(0,0)],@"banner slot reused by a named fake row is rejected in both directions");
    data.userName=@123;Check(![a currentPathForRow:banner],@"malformed username does not prove anonymous content");
    data.userName=@"";Check([[a currentPathForRow:banner] isEqual:Path(0,0)],@"empty-name business CellData can still render");
    logic.throwGetter=YES;Check(![a currentPathForRow:banner],@"throwing native getter fails closed");logic.throwGetter=NO;
    host.m_mainFrameLogicController=[NSObject new];Check(![a currentPathForRow:banner],@"missing native accessors cannot authorize dirty anonymous mapping");host.m_mainFrameLogicController=logic;
    account=@"other-account";Check(![a currentPathForRow:banner] && ![a displayPath:Path(0,0)],@"anonymous rendering remains isolated by account");account=@"test-account";
    for (NSIndexPath *path in @[Path(9,0),Path(0,9),[NSIndexPath indexPathWithIndex:0]])
        Check(!CSGroupResolveNativeRowPath(host,Row(path,nil,CSGroupRowKindBusiness),YES),@"out-of-bounds and malformed paths stay invalid");
    Check(!CSGroupResolveNativeRowPath(host,Row(Path(0,0),nil,CSGroupRowKindSession),YES),@"a session cannot bypass identity checks using a missing username");
    Check(!CSGroupResolveNativeRowPath(host,Row(Path(0,0),nil,CSGroupRowKindFake),YES),@"an unnamed fake row cannot use business rendering fallback");
    // Full native validation is retained; immutable allocation is proportional to changed rows.
    host.counts=@[@200,@200,@200];[logic.sessions removeAllObjects];[logic.data removeAllObjects];
    for (NSUInteger s=0;s<3;s++) for (NSUInteger r=0;r<200;r++) {
        Session *session=[Session new];session.m_nsUserName=[NSString stringWithFormat:@"s%lu-r%lu",(unsigned long)s,(unsigned long)r];
        logic.sessions[Path(s,r)]=session;
    }
    NSArray *base=CSGroupBuildNativeSections(host,host.m_tableView,host);
    NSArray *unchanged=CSGroupBuildNativeSectionsReusing(host,host.m_tableView,host,base);
    Check(base==unchanged,@"600 unchanged rows reuse the entire immutable snapshot");
    ((Session *)logic.sessions[Path(1,50)]).m_uUnReadCount=7;
    NSArray *updated=CSGroupBuildNativeSectionsReusing(host,host.m_tableView,host,base);
    NSUInteger replaced=0;
    for (NSUInteger s=0;s<3;s++) for (NSUInteger r=0;r<200;r++) if (updated[s][r]!=base[s][r]) replaced++;
    Check(replaced==1 && updated[0]==base[0] && updated[2]==base[2],@"one unread change replaces one row and shares unaffected sections");
    Check([updated[1][50] unreadCount]==7 && [base[1][50] unreadCount]==0,@"old snapshot remains immutable");
    id moved=logic.sessions[Path(1,50)];logic.sessions[Path(1,50)]=logic.sessions[Path(1,51)];logic.sessions[Path(1,51)]=moved;
    NSArray *reordered=CSGroupBuildNativeSectionsReusing(host,host.m_tableView,host,updated);
    Check([reordered[1][51] unreadCount]==7 && [[reordered[1][51] nativePath] isEqual:Path(1,51)],@"equal-count reordering revalidates identities and coordinates");
    Session *changedSession=logic.sessions[Path(1,51)];changedSession.m_bIsTop=YES;changedSession.isInBrandServiceBox=YES;changedSession.m_bShowUnReadAsRedDot=YES;
    NSArray *reclassified=CSGroupBuildNativeSectionsReusing(host,host.m_tableView,host,reordered);
    Check([reclassified[1][51] top] && [reclassified[1][51] redDot] && [reclassified[1][51] category]==CSGroupRowCategoryService,@"in-place top/category/red-dot changes cannot hide behind cached identity");
    NSArray *cold=CSGroupBuildNativeSections(host,host.m_tableView,host);
    for (NSUInteger s=0;s<3;s++) for (NSUInteger r=0;r<200;r++) {
        CSGroupRow *a=reclassified[s][r],*b=cold[s][r];
        Check([a.userName isEqual:b.userName] && [a.nativePath isEqual:b.nativePath] && a.kind==b.kind && a.category==b.category && a.top==b.top && a.unreadCount==b.unreadCount && a.redDot==b.redDot,@"shared snapshot agrees with cold reconstruction");
    }
    host.counts=@[@200,@199];
    NSArray *removed=CSGroupBuildNativeSectionsReusing(host,host.m_tableView,host,reclassified);
    Check(removed.count==2 && [removed[1] count]==199,@"row and section removals do not retain stale cached records");
    printf("Group business rows: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;
} }
