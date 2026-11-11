#import "CSGroupChatNativeAdapter.h"
#import "CSMessageNativeActionAdapter.h"
#import "CSGroupNativeBridge.h"
#import "CSBackupBootstrap.h"
#import "CSAuthorizationManager.h"

static CSMessageNativeEnvironment *CSGCEnvironment(void) {
    static CSMessageNativeEnvironment *environment; static dispatch_once_t once;
    dispatch_once(&once,^{ environment=[CSMessageNativeEnvironment new]; }); return environment;
}
static NSString *CSGCString(id value) { return [value isKindOfClass:NSString.class] ? value : nil; }
static BOOL CSGCAccountValid(NSString *account, NSUInteger epoch) {
    if (!NSThread.isMainThread || !account.length || !CSBackupIsReady() || CSBackupAccountIsSuspended() || epoch!=CSBackupAccountEpoch()) return NO;
    NSString *actual=[CSGCEnvironment() currentAccountID];
    return [actual isEqual:account] && epoch==CSBackupAccountEpoch() && !CSBackupAccountIsSuspended() && CSBackupIsReady();
}
static BOOL CSGCCanAct(NSString *account, NSUInteger epoch) {
    return CSGCAccountValid(account,epoch) && CSAuthorizationManager.sharedManager.isAuthorized;
}
static NSError *CSGCError(NSInteger code, NSString *message) {
    return [NSError errorWithDomain:@"CSGroupChatNative" code:code userInfo:@{NSLocalizedDescriptionKey:message}];
}
static id CSGCContact(NSString *userName) {
    if (!NSThread.isMainThread || ![userName isKindOfClass:NSString.class] || !userName.length || !CSBackupIsReady() || CSBackupAccountIsSuspended()) return nil;
    id manager=[CSGCEnvironment() serviceNamed:@"CContactMgr"], contact=nil;
    Class contactClass=NSClassFromString(@"CContact");
    if (!contactClass) return nil;
    @try {
        for (NSString *selector in @[@"getContactByName:",@"getContactByNameFromDB:"]) {
            if (!CSMessageNativeSupports(manager,selector,@"@",@[@"@"])) continue;
            contact=CSMessageNativeInvoke(manager,selector,@[userName]);
            if (contact) break;
        }
        if (![contact isKindOfClass:contactClass] || ![CSGCString(CSGroupReadObject(contact,@"m_nsUsrName")) isEqual:userName]) return nil;
    } @catch (__unused NSException *exception) { return nil; }
    return contact;
}
id CSGroupChatRoomContact(NSString *roomID) {
    @try {
        id contact=CSGCContact(roomID); Class cls=NSClassFromString(@"CContact");
        // IsChatRoomContact: receives CContact, then calls its isChatroom.
        if (!contact || !CSMessageNativeSupports(cls,@"IsChatRoomContact:",@"B",@[@"@"]) || ![CSMessageNativeInvoke(cls,@"IsChatRoomContact:",@[contact]) boolValue]) return nil;
        return contact;
    } @catch (__unused NSException *exception) { return nil; }
}
NSString *CSGroupChatRoomName(NSString *roomID) {
    id contact=CSGroupChatRoomContact(roomID);
    @try {
        for (NSString *selector in @[@"getContactDisplayName",@"m_nsNickName"]) {
            if (!CSMessageNativeSupports(contact,selector,@"@",@[])) continue;
            NSString *name=CSGCString(CSMessageNativeInvoke(contact,selector,@[])); if (name.length) return [name copy];
        }
    } @catch (__unused NSException *exception) {}
    return CSGCString(roomID) ?: @"";
}
NSSet<NSString *> *CSGroupChatMemberIDs(NSString *roomID) {
    id contact=CSGroupChatRoomContact(roomID); if (!contact) return nil;
    id manager=[CSGCEnvironment() serviceNamed:@"CGroupMgr"];
    if (!contact || !CSMessageNativeSupports(manager,@"GetGroupMemberUserListByContact:",@"@",@[@"@"])) return nil;
    @try {
        // 8.0.80 parses the native contact's semicolon-separated member list.
        // This is a local snapshot; only a validated full-member response may
        // promote it to the monitoring baseline.
        id members=CSMessageNativeInvoke(manager,@"GetGroupMemberUserListByContact:",@[contact]);
        if (![members isKindOfClass:NSArray.class]) return nil;
        NSMutableSet *names=[NSMutableSet set];
        for (id member in members) { if (![member isKindOfClass:NSString.class]) return nil; if ([member length]) [names addObject:[member copy]]; }
        if (![CSGCString(CSGroupReadObject(contact,@"m_nsUsrName")) isEqual:roomID]) return nil;
        return names.count ? [names copy] : nil;
    } @catch (__unused NSException *exception) { return nil; }
}
BOOL CSGroupChatIsMember(NSString *roomID, NSString *accountID) {
    NSUInteger epoch=CSBackupAccountEpoch();
    if (!CSGCAccountValid(accountID,epoch) || !CSGroupChatRoomContact(roomID)) return NO;
    @try {
        id manager=[CSGCEnvironment() serviceNamed:@"CGroupMgr"];
        if (!CSMessageNativeSupports(manager,@"IsUsrInChatRoom:Usr:",@"B",@[@"@",@"@"])) return NO;
        BOOL member=[CSMessageNativeInvoke(manager,@"IsUsrInChatRoom:Usr:",@[roomID,accountID]) boolValue];
        return member && CSGCAccountValid(accountID,epoch);
    } @catch (__unused NSException *exception) { return NO; }
}
BOOL CSGroupChatRoomUnavailable(NSString *roomID) {
    id contact=CSGroupChatRoomContact(roomID);
    @try {
        for (NSString *selector in @[@"isChatRoomDismissed",@"isChatRoomBlocked"]) {
            if (!CSMessageNativeSupports(contact,selector,@"B",@[]) || [CSMessageNativeInvoke(contact,selector,@[]) boolValue]) return YES;
        }
        return ![CSGCString(CSGroupReadObject(contact,@"m_nsUsrName")) isEqual:roomID];
    } @catch (__unused NSException *exception) { return YES; }
}
NSString *CSGroupChatMemberName(NSString *roomID, NSString *memberID) {
    (void)roomID;
    if (![memberID isKindOfClass:NSString.class]) return @"";
    // getContactDisplayName and getChatRoomMemberDisplayName: can prefer a
    // remark. Read the nickname field itself so the template values stay distinct.
    return [CSGCString(CSMessageActionNativeObject(CSGCContact(memberID),@"m_nsNickName")) copy] ?: @"";
}
NSArray<NSString *> *CSGroupChatKnownRoomIDs(void) {
    // getAllContactUserName/getAllUserName: exist in 8.0.80, but the audited
    // path does not prove that the server's entire room set has synchronized.
    // Returning a partial cache here would turn an absent room into a false
    // "new join" at startup. The manager instead requires join-time or an
    // explicitly observed membership transition before automatic saving.
    return nil;
}
BOOL CSGroupChatRequestMembers(NSString *roomID) {
    if (!NSThread.isMainThread) return NO;
    NSUInteger epoch=CSBackupAccountEpoch(); NSString *account=[CSGCEnvironment() currentAccountID];
    if (!CSGCCanAct(account,epoch) || CSGroupChatRoomUnavailable(roomID) || !CSGroupChatIsMember(roomID,account)) return NO;
    id contact=CSGroupChatRoomContact(roomID), manager=[CSGCEnvironment() serviceNamed:@"CGroupMgr"];
    if (!contact || ![roomID hasSuffix:@"@chatroom"] || !CSMessageNativeSupports(manager,@"GetEntireChatRoomMemberDetail:",@"B",@[@"@"])) return NO;
    __block BOOL submitted=NO;
    @try {
        CSBackupPerformAtAccountEpoch(epoch,^{
            if (CSGCCanAct(account,epoch) && [CSGCString(CSGroupReadObject(contact,@"m_nsUsrName")) isEqual:roomID])
                submitted=[CSMessageNativeInvoke(manager,@"GetEntireChatRoomMemberDetail:",@[contact]) boolValue];
        });
    } @catch (__unused NSException *exception) { return NO; }
    return submitted && CSGCAccountValid(account,epoch);
}
BOOL CSGroupChatSaveToContacts(NSString *roomID, NSString *accountID, NSError **error) {
    NSUInteger epoch=CSBackupAccountEpoch();
    if (!CSGCCanAct(accountID,epoch)) { if(error)*error=CSGCError(1,@"账号、授权或数据恢复状态已改变，未保存群聊。"); return NO; }
    if (![roomID hasSuffix:@"@chatroom"]) { if(error)*error=CSGCError(2,@"此类群聊的保存流程尚未验证，请在微信群资料页保存。"); return NO; }
    id room=CSGroupChatRoomContact(roomID), manager=[CSGCEnvironment() serviceNamed:@"CGroupMgr"], sync=[CSGCEnvironment() serviceNamed:@"NewSyncService"];
    if (!room || CSGroupChatRoomUnavailable(roomID) || !CSGroupChatIsMember(roomID,accountID)) { if(error)*error=CSGCError(3,@"群聊不可用或当前账号已不在群中，未保存。"); return NO; }
    if (!CSMessageNativeSupports(room,@"isMMContact",@"B",@[]) || !CSMessageNativeSupports(manager,@"ShowInContactBook:sync:",@"B",@[@"@",@"B"]) || !CSMessageNativeSupports(sync,@"NeedToSyncOplog",@"v",@[])) {
        if(error)*error=CSGCError(4,@"当前微信缺少已验证的原生保存或同步接口，请在群资料页保存。"); return NO;
    }
    @try {
        if ([CSMessageNativeInvoke(room,@"isMMContact",@[]) boolValue]) return CSGCCanAct(accountID,epoch);
        __block BOOL saved=NO;
        CSBackupPerformAtAccountEpoch(epoch,^{
            if (!CSGCCanAct(accountID,epoch) || !CSGroupChatIsMember(roomID,accountID) || CSGroupChatRoomUnavailable(roomID)) return;
            // Native ShowInContactBook records listType=1/opLog=YES; its sync
            // parameter is unused in this build. Commit the native oplog too.
            saved=[CSMessageNativeInvoke(manager,@"ShowInContactBook:sync:",@[roomID,@YES]) boolValue];
            if (saved && CSGCCanAct(accountID,epoch)) CSMessageNativeInvoke(sync,@"NeedToSyncOplog",@[]);
        });
        id updated=CSGroupChatRoomContact(roomID);
        if (saved && CSGCCanAct(accountID,epoch) && CSMessageNativeSupports(updated,@"isMMContact",@"B",@[]) && [CSMessageNativeInvoke(updated,@"isMMContact",@[]) boolValue]) return YES;
        if(error)*error=CSGCError(5,@"微信未确认本地保存状态；不会重复提交，请在群资料页检查。");
    } @catch (__unused NSException *exception) { if(error)*error=CSGCError(6,@"原生保存结果未确认；请在群资料页检查。"); }
    return NO;
}
NSString *CSGroupChatQuitPreflight(NSString *roomID, NSString *accountID) {
    NSUInteger epoch=CSBackupAccountEpoch();
    if (!CSGCCanAct(accountID,epoch)) return @"账号、授权或数据恢复状态已改变，未提交退出。";
    if (![roomID isKindOfClass:NSString.class] || ![roomID hasSuffix:@"@chatroom"]) return @"此类群聊尚未验证批量退出，请点击进入微信群资料页处理。";
    id contact=CSGroupChatRoomContact(roomID);
    if (!contact) return @"无法读取原生群资料，请在微信群资料页确认。";
    if (CSGroupChatRoomUnavailable(roomID)) return @"群聊已解散、受限或状态无法确认，请在微信群资料页处理。";
    id groups=[CSGCEnvironment() serviceNamed:@"CGroupMgr"], messages=[CSGCEnvironment() serviceNamed:@"CMessageMgr"]; Class biz=NSClassFromString(@"WCBizUtil");
    if (!CSMessageNativeSupports(groups,@"IsUsrInChatRoom:Usr:",@"B",@[@"@",@"@"])) return @"当前微信缺少已验证的成员身份接口，未提交退出。";
    if (!CSMessageNativeSupports(messages,@"GetValidNewBizMsgCountByChatName:bizType:",@"I",@[@"@",@"q"]) || !CSMessageNativeSupports(biz,@"calcValidNewTransferCountWithUsername:",@"I",@[@"@"])) return @"当前微信无法完成原生资金待办检查，请在群资料页退出。";
    @try {
        if (![CSMessageNativeInvoke(groups,@"IsUsrInChatRoom:Usr:",@[roomID,accountID]) boolValue]) return @"当前账号已不在群中，未提交退出。";
        unsigned int fund=[CSMessageNativeInvoke(messages,@"GetValidNewBizMsgCountByChatName:bizType:",@[roomID,@2]) unsignedIntValue];
        unsigned int transfer=[CSMessageNativeInvoke(biz,@"calcValidNewTransferCountWithUsername:",@[roomID]) unsignedIntValue];
        if (fund || transfer) return @"存在群收款或待收款转账，请点击进入微信群资料页处理后退出。";
        if (!CSGCCanAct(accountID,epoch) || ![CSGCString(CSGroupReadObject(contact,@"m_nsUsrName")) isEqual:roomID]) return @"账号或群聊状态已改变，未提交退出。";
        return nil;
    } @catch (__unused NSException *exception) { return @"原生退出前检查未完成，请在微信群资料页处理。"; }
}
BOOL CSGroupChatOpenMemberProfile(NSString *roomID, NSString *memberID, UIViewController *source) {
    if (!NSThread.isMainThread) return NO;
    NSUInteger epoch=CSBackupAccountEpoch(); NSString *account=[CSGCEnvironment() currentAccountID];
    if (!CSGCCanAct(account,epoch) || ![source isKindOfClass:UIViewController.class] || !source.navigationController) return NO;
    id room=CSGroupChatRoomContact(roomID), member=CSGCContact(memberID); Class utility=NSClassFromString(@"ChatRoomUtils");
    NSString *selector=@"openContactProfile:ofChatRoomContact:inViewController:delegate:searchScene:";
    if (!room || !member || !CSMessageNativeSupports(utility,selector,@"v",@[@"@",@"@",@"@",@"@",@"Q"])) return NO;
    @try {
        __block BOOL opened=NO;
        CSBackupPerformAtAccountEpoch(epoch,^{
            if (!CSGCCanAct(account,epoch)) return;
            // The same route used by ChatRoomInfoViewController.openContactInfo:.
            CSMessageNativeInvoke(utility,selector,@[member,room,source,NSNull.null,@0]); opened=YES;
        });
        return opened;
    } @catch (__unused NSException *exception) { return NO; }
}
BOOL CSGroupChatOpenRoomProfile(NSString *roomID, UIViewController *source) {
    if (!NSThread.isMainThread) return NO;
    NSUInteger epoch=CSBackupAccountEpoch(); NSString *account=[CSGCEnvironment() currentAccountID];
    if (!CSGCCanAct(account,epoch) || ![source isKindOfClass:UIViewController.class] || !source.navigationController) return NO;
    id room=CSGroupChatRoomContact(roomID); Class cls=NSClassFromString(@"ChatRoomInfoViewController");
    if (!room || !cls || ![cls isSubclassOfClass:UIViewController.class]) return NO;
    @try {
        id allocated=[cls alloc]; if (!CSMessageNativeSupports(allocated,@"init",@"@",@[])) return NO;
        UIViewController *page=CSMessageNativeInvoke(allocated,@"init",@[]);
        if (![page isKindOfClass:cls] || !CSMessageNativeSupports(page,@"setM_chatRoomContact:",@"v",@[@"@"])) return NO;
        CSMessageNativeInvoke(page,@"setM_chatRoomContact:",@[room]);
        if (![CSGCString(CSGroupReadObject(CSGroupReadObject(page,@"m_chatRoomContact"),@"m_nsUsrName")) isEqual:roomID]) return NO;
        __block BOOL opened=NO;
        CSBackupPerformAtAccountEpoch(epoch,^{
            if (!CSGCCanAct(account,epoch)) return;
            page.hidesBottomBarWhenPushed=YES; [source.navigationController pushViewController:page animated:YES]; opened=YES;
        });
        return opened;
    } @catch (__unused NSException *exception) { return NO; }
}
