#import "CSCloseFriendMuteAdapter.h"
#import "CSCloseFriendBridge.h"
#import "CSServiceCenter.h"
#import <objc/message.h>
@interface CSCloseFriendMuteAdapter ()
@property(nonatomic) BOOL running;
@end
@implementation CSCloseFriendMuteAdapter
- (BOOL)persist:(NSMutableDictionary *)records account:(NSString *)account epoch:(NSUInteger)epoch {
    return self.current(account,epoch) && self.save(records,account,epoch) && self.current(account,epoch);
}
- (void)externalMutation:(NSString *)name account:(NSString *)account epoch:(NSUInteger)epoch {
    if(!name.length || !self.current(account,epoch))return;
    NSMutableDictionary *records=[self.load() mutableCopy]; NSMutableDictionary *r=[records[name] mutableCopy];
    if(!r || [r[@"phase"] isEqual:@"revoked"])return;
    r[@"phase"]=@"revoked"; r[@"owned"]=@NO; records[name]=r; [self persist:records account:account epoch:epoch];
}
- (void)reconcile:(CSCloseFriendSnapshot *)p epoch:(NSUInteger)epoch {
    if(self.running || p.blocked || !self.current(p.accountID,epoch))return;
    self.running=YES;
    @try {
        NSMutableDictionary *records=[self.load() mutableCopy]?:[NSMutableDictionary dictionary];
        NSSet *wanted=p.enabled && [p.options[@"autoMute"] boolValue]?p.protectedUserNames:[NSSet set];
        NSMutableSet *names=[NSMutableSet setWithArray:records.allKeys]; [names unionSet:wanted];
        for(NSString *name in names) {
            if(!self.current(p.accountID,epoch))break;
            NSNumber *open=self.readOpen(name); if(!open)continue;
            NSMutableDictionary *r=[records[name] mutableCopy]; BOOL wants=[wanted containsObject:name];
            if(!wants) {
                // Only a completed, read-back-confirmed write owns restoration. A crash
                // between native write and commit deliberately forfeits ownership.
                if([r[@"phase"] isEqual:@"applied"] && [r[@"owned"] boolValue] && [r[@"original"] boolValue] && !open.boolValue) {
                    r[@"phase"]=@"restoring"; r[@"owned"]=@NO; records[name]=r;
                    if(![self persist:records account:p.accountID epoch:epoch])break;
                    if(!self.current(p.accountID,epoch))break;
                    self.writeOpen(name,YES);
                    open=self.readOpen(name);
                    if(!self.current(p.accountID,epoch))break;
                    if(!open || !open.boolValue) { r[@"phase"]=@"revoked"; records[name]=r; [self persist:records account:p.accountID epoch:epoch]; continue; }
                }
                if(r) { [records removeObjectForKey:name]; if(![self persist:records account:p.accountID epoch:epoch])break; }
                continue;
            }
            if(r && ![r[@"phase"] isEqual:@"prepared"]) {
                if([r[@"phase"] isEqual:@"applied"] && open.boolValue) { r[@"phase"]=@"revoked"; r[@"owned"]=@NO; records[name]=r; if(![self persist:records account:p.accountID epoch:epoch])break; }
                continue;
            }
            if(r && (!open.boolValue || [r[@"attempts"] unsignedIntegerValue]>=2)) {
                r[@"phase"]=@"revoked"; r[@"owned"]=@NO; records[name]=r; if(![self persist:records account:p.accountID epoch:epoch])break; continue;
            }
            if(!r) {
                r=[@{@"original":open,@"owned":@NO,@"phase":open.boolValue?@"prepared":@"preserved",@"attempts":@0} mutableCopy];
                records[name]=r;
                if(![self persist:records account:p.accountID epoch:epoch])break;
                if(!open.boolValue)continue;
            }
            r[@"attempts"]=@([r[@"attempts"] unsignedIntegerValue]+1); records[name]=r;
            if(![self persist:records account:p.accountID epoch:epoch])break;
            // Re-read immediately before writing; an external edit is not ours to undo.
            if(![self.readOpen(name) isEqual:@YES] || !self.current(p.accountID,epoch))continue;
            BOOL wrote=self.writeOpen(name,NO); NSNumber *after=self.readOpen(name);
            if(!self.current(p.accountID,epoch))break;
            if(wrote && after && !after.boolValue) { r[@"phase"]=@"applied"; r[@"owned"]=@YES; }
            else if(after && !after.boolValue) { r[@"phase"]=@"revoked"; r[@"owned"]=@NO; }
            records[name]=r; if(![self persist:records account:p.accountID epoch:epoch])break;
        }
    } @finally { self.running=NO; }
}
static NSString *const WriteScope=@"CSCloseFriendMuteWrite";
static CSCloseFriendMuteAdapter *Native;
static id Contact(NSString *name) {
    id mgr=CSGetService(NSClassFromString(@"CContactMgr")); SEL sel=NSSelectorFromString(@"getContactByName:");
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([mgr class],sel),"@@:@"))return nil;
    return ((id(*)(id,SEL,id))objc_msgSend)(mgr,sel,name);
}
static void Reconcile(void) {
    if(!NSThread.isMainThread)return;
    [Native reconcile:CSCloseFriendCurrentSnapshot() epoch:CSCloseFriendAccountEpoch()];
}
static void External(id contact) {
    if([NSThread.currentThread.threadDictionary[WriteScope] boolValue])return;
    NSString *name=CSCloseFriendUserName(contact); CSCloseFriendSnapshot *p=CSCloseFriendCurrentSnapshot(); NSUInteger epoch=CSCloseFriendAccountEpoch();
    // Mark ownership before allowing the setter. Synchronous main delivery also
    // orders remote changes ahead of a pending restoration.
    void (^mark)(void)=^{ [Native externalMutation:name account:p.accountID epoch:epoch]; };
    if(NSThread.isMainThread)mark();else dispatch_sync(dispatch_get_main_queue(),mark);
}
+ (void)start {
    if(Native)return;
    // The BOOL meaning was disassembled for this native version only.
    BOOL version=[NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"] isEqual:@"8.0.78"];
    BOOL signatures=CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(@"CContact"),NSSelectorFromString(@"isChatStatusNotifyOpen")),"B@:") && CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(@"CContactMgr"),NSSelectorFromString(@"ChangeNotifyStatus:withStatus:sync:")),"B@:@BB");
    CSCloseFriendRecordCapability(@"nativeMute.verifiedSemantics",version && signatures);
    if(!version || !signatures)return;
    Native=[self new];
    Native.load=^NSDictionary *{return CSCloseFriendMuteRecords();};
    Native.save=^BOOL(NSDictionary *r,NSString *account,NSUInteger epoch){return CSCloseFriendSaveMuteRecords(r,account,epoch,NULL);};
    Native.current=^BOOL(NSString *account,NSUInteger epoch){CSCloseFriendSnapshot *p=CSCloseFriendCurrentSnapshot();return !p.blocked && epoch==CSCloseFriendAccountEpoch() && [account isEqual:p.accountID];};
    Native.readOpen=^NSNumber *(NSString *name){id c=Contact(name); SEL s=NSSelectorFromString(@"isChatStatusNotifyOpen"); if(!CSCloseFriendMethodMatches(class_getInstanceMethod([c class],s),"B@:"))return nil; return @(((BOOL(*)(id,SEL))objc_msgSend)(c,s));};
    Native.writeOpen=^BOOL(NSString *name,BOOL open){id c=Contact(name),mgr=CSGetService(NSClassFromString(@"CContactMgr")); if(!c)return NO; NSThread.currentThread.threadDictionary[WriteScope]=@YES; @try{return ((BOOL(*)(id,SEL,id,BOOL,BOOL))objc_msgSend)(mgr,NSSelectorFromString(@"ChangeNotifyStatus:withStatus:sync:"),c,open,YES);} @finally {[NSThread.currentThread.threadDictionary removeObjectForKey:WriteScope];}};
    for(NSString *name in @[@"ChangeNotifyStatus:withStatus:sync:",@"ChangeNotifyStatusForChatRoom:withStatus:sync:",@"setContact:notifyOpen:sync:"]) {
        __block IMP orig=NULL; SEL sel=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^BOOL(id mgr,id c,BOOL open,BOOL sync){External(c); return ((BOOL(*)(id,SEL,id,BOOL,BOOL))orig)(mgr,sel,c,open,sync);});
        if(!CSCloseFriendInstallHook(@"CContactMgr",name,replacement,&orig,"B@:@BB"))imp_removeBlock(replacement);
    }
    __block IMP orig=NULL;
    IMP replacement=imp_implementationWithBlock(^(id c,BOOL open){External(c);((void(*)(id,SEL,BOOL))orig)(c,NSSelectorFromString(@"setChatStatusNotifyOpen:"),open);});
    if(!CSCloseFriendInstallHook(@"CContact",@"setChatStatusNotifyOpen:",replacement,&orig,"v@:B"))imp_removeBlock(replacement);
    [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *n){Reconcile();}];
    Reconcile();
}
@end
