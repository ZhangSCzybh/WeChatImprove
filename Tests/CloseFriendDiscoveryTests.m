#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendSocialProjection.h"
#import "CSCloseFriendContactProjection.h"
#import "CSCloseFriendSignatures.h"

static CSCloseFriendSnapshot *Snapshot;
static NSUInteger Epoch=1;
static char EpochKey;
static NSMapTable *Refreshes;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return Snapshot; }
static BOOL CSCFPageIsCurrent(id page) {
    NSNumber *old=objc_getAssociatedObject(page,&EpochKey);
    if(!old) { old=@(Epoch); objc_setAssociatedObject(page,&EpochKey,old,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
    return old.unsignedIntegerValue==Epoch;
}
static id CSCloseFriendRead(id object,NSString *key) {
    SEL selector=NSSelectorFromString(key);
    if(CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"@@:")) return ((id(*)(id,SEL))objc_msgSend)(object,selector);
    Ivar ivar=class_getInstanceVariable([object class],key.UTF8String);
    return ivar && ivar_getTypeEncoding(ivar)[0]=='@' ? object_getIvar(object,ivar) : nil;
}
static id CSCFTimelineFacade(__unused id page) { return nil; }
static BOOL CSCloseFriendInstallHook(NSString *cls,NSString *name,IMP replacement,IMP *original,const char *type) {
    Method method=class_getInstanceMethod(NSClassFromString(cls),NSSelectorFromString(name));
    if(!CSCloseFriendMethodMatches(method,type)) return NO;
    *original=method_getImplementation(method);
    class_replaceMethod(NSClassFromString(cls),NSSelectorFromString(name),replacement,method_getTypeEncoding(method)); return YES;
}
static BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([object class],selector),"v@:")) return NO;
    ((void(*)(id,SEL))objc_msgSend)(object,selector); return YES;
}
static void CSCFSocialTrack(id owner,void(^refresh)(id)) {
    if(!Refreshes) Refreshes=[NSMapTable weakToStrongObjectsMapTable];
    [Refreshes setObject:[refresh copy] forKey:owner];
}
static void CSCFSocialHook0(NSString *cls,NSString *name,void(^body)(id,void(^)(void))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner){body(owner,^{((void(*)(id,SEL))original)(owner,selector);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:")) imp_removeBlock(replacement);
}
static void CSCFSocialHook1(NSString *cls,NSString *name,void(^body)(id,id,void(^)(id))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id owner,id arg){body(owner,arg,^(id value){((void(*)(id,SEL,id))original)(owner,selector,value);});});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
}
static CSCloseFriendSocialProjection *CSCFSocialProject(NSArray *source,CSCloseFriendSurface surface) {
    return [[CSCloseFriendSocialProjection alloc] initWithSource:source snapshot:Snapshot surface:surface read:^id(id item,NSString *key){return CSCloseFriendRead(item,key);}];
}
static BOOL CSCFSocialHidden(id object,CSCloseFriendSurface surface) {
    return CSCloseFriendSocialObjectHidden(object,Snapshot,surface,^id(id item,NSString *key){return CSCloseFriendRead(item,key);});
}
@interface UIView : NSObject
@property(nonatomic) BOOL hidden,accessibilityElementsHidden,userInteractionEnabled,isAccessibilityElement;
@end
@implementation UIView @end
@interface DiscoveryComment : NSObject
@property(nonatomic,copy) NSString *username;
@property(nonatomic) int type,commentFlag;
@end
@implementation DiscoveryComment @end
@interface DiscoveryMessage : NSObject
@property(nonatomic,strong) DiscoveryComment *comment,*refComment;
@property(nonatomic) BOOL related,hasRead;
@end
@implementation DiscoveryMessage @end
@interface WCFacade : NSObject
@property(nonatomic,copy) NSArray<DiscoveryMessage *> *source;
@end
@implementation WCFacade
- (id)getUnReadMessages { return self.source; }
- (id)getUnReadMessagesLimit:(int)limit { return [self.source subarrayWithRange:NSMakeRange(0,MIN((NSUInteger)MAX(limit,0),self.source.count))]; }
- (id)getLastUnReadMessage { return self.source.lastObject; }
- (unsigned int)getUnReadMessageCount { return (unsigned int)self.source.count; }
- (unsigned int)getUnReadMessageCountReleatedToMe {
    unsigned int count=0; for(DiscoveryMessage *message in self.source) if(message.related) count++; return count;
}
- (unsigned int)getUnReadMessageCountForMutualFriends {
    unsigned int count=0; for(DiscoveryMessage *message in self.source) if(!message.related) count++; return count;
}
@end
@interface FindFriendEntryViewController : NSObject
@property(nonatomic,strong) WCFacade *facade;
@property(nonatomic,strong) UIView *m_timelineHeadView,*m_timelineRedDotView;
@property(nonatomic) BOOL mutualReminder,pluginInstalled;
@property(nonatomic) NSInteger displayedCount,tabCount;
@property(nonatomic) NSUInteger refreshCount,appearCount;
@end
@implementation FindFriendEntryViewController
- (NSInteger)getSnsMessageCount { return self.mutualReminder ? [self.facade getUnReadMessageCount] : [self.facade getUnReadMessageCountReleatedToMe]; }
- (NSInteger)numberOfUnreadAtMomentCell { return self.pluginInstalled ? (self.mutualReminder ? [self.facade getUnReadMessageCount] : [self.facade getUnReadMessageCountReleatedToMe]) : 0; }
- (BOOL)badgeAtMomentCell { return YES; }
- (void)onMessageUnReadCountChanged { self.refreshCount++; self.displayedCount=[self getSnsMessageCount]; self.tabCount=3+[self numberOfUnreadAtMomentCell]; }
- (void)reloadData { [self onMessageUnReadCountChanged]; }
- (void)updateWCTimeLineView:(__unused id)cell {}
- (void)viewWillAppear:(__unused BOOL)animated { self.appearCount++; }
@end
#include "DiscoveryBodies.h"
#define Check(x) do { if(!(x)) {fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#x); return 1;} } while(0)
static void Policy(BOOL revealed,BOOL hideInteractions) {
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy]; options[@"hideInteractions"]=@(hideInteractions);
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":options} revealed:revealed revision:Epoch blocked:NO];
}
static DiscoveryMessage *Message(NSString *username,BOOL related,int type,int flags,NSString *referrer) {
    DiscoveryMessage *message=[DiscoveryMessage new]; message.related=related;
    message.comment=[DiscoveryComment new]; message.comment.username=username; message.comment.type=type; message.comment.commentFlag=flags;
    if(referrer) { message.refComment=[DiscoveryComment new]; message.refComment.username=referrer; }
    return message;
}
int main(void) { @autoreleasepool {
    Policy(NO,YES); InstallUnread(); InstallDiscovery();
    WCFacade *facade=[WCFacade new];
    DiscoveryMessage *secretOwn=Message(@"secret",YES,1,1<<17,nil), *secretMention=Message(@"secret",YES,4,0,nil), *secretReply=Message(@"secret",YES,2,0,@"self");
    DiscoveryMessage *ordinaryOwn=Message(@"alice",YES,1,1<<17,nil), *ordinaryMutual=Message(@"bob",NO,2,0,nil), *secretMutual=Message(@"secret",NO,2,0,nil);
    facade.source=@[secretOwn,ordinaryOwn,secretMention,ordinaryMutual,secretReply,secretMutual]; NSArray *source=facade.source;
    FindFriendEntryViewController *page=[FindFriendEntryViewController new]; page.facade=facade; page.pluginInstalled=YES; page.mutualReminder=YES;
    Check([page getSnsMessageCount]==2 && [page numberOfUnreadAtMomentCell]==2);
    Check([facade getUnReadMessageCount]==6 && [facade getUnReadMessageCountReleatedToMe]==4 && [facade getUnReadMessageCountForMutualFriends]==2);
    Check([facade getUnReadMessages]==source && !UnreadDisplay && !DiscoveryCountingOwner);
    page.mutualReminder=NO;
    Check([page getSnsMessageCount]==1 && [page numberOfUnreadAtMomentCell]==1);
    page.pluginInstalled=NO; Check([page numberOfUnreadAtMomentCell]==0); page.pluginInstalled=YES;
    [page viewWillAppear:YES]; Check(page.appearCount==1 && page.refreshCount==1 && page.displayedCount==1 && page.tabCount==4);
    Policy(YES,YES); void(^refresh)(id)=[Refreshes objectForKey:page]; Check(refresh!=nil); refresh(page);
    Check(page.displayedCount==4 && page.tabCount==7 && [facade getUnReadMessages]==source);
    Policy(NO,YES); refresh(page); Check(page.displayedCount==1 && page.tabCount==4);
    facade.source=@[secretOwn,secretMention]; [page onMessageUnReadCountChanged];
    Check(page.displayedCount==0 && page.tabCount==3 && [facade getUnReadMessageCount]==2);
    Check(!secretOwn.hasRead && !secretMention.hasRead);
    Policy(NO,NO); refresh(page); Check(page.displayedCount==2 && page.tabCount==5);
    Policy(NO,YES); facade.source=@[ordinaryOwn,ordinaryMutual]; page.mutualReminder=YES;
    [page onMessageUnReadCountChanged]; Check(page.displayedCount==2 && page.tabCount==5);
    Epoch++; Check([page getSnsMessageCount]==0 && [page numberOfUnreadAtMomentCell]==0);
    Check(!UnreadDisplay && !DiscoveryCountingOwner && !ordinaryOwn.hasRead && !ordinaryMutual.hasRead);
    puts("Discovery: native row accessor, related/mutual partitions, ordinary reminders, policy/appearance refresh, unchanged unread records and stale owner guards passed");
    return 0;
} }
