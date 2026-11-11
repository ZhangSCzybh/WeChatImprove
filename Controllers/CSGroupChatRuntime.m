#import "CSGroupChatRuntime.h"
#import "CSGroupChatManager.h"
#import "CSGroupChatNativeAdapter.h"
#import "CSGroupChatEventPolicy.h"
#import "CSMessageNativeActionAdapter.h"
#import "CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <substrate.h>
#include <stdatomic.h>
// The low bit enables ingress. Every lifecycle/config transition advances the
// remaining bits, so queued native callbacks cannot cross a session boundary.
static atomic_ulong Ingress=0;
static _Thread_local unsigned MemberResponseDepth=0;
// If a removal callback applies a full response synchronously, publish it only
// after the manager has seen the successful removal IDs for that same callback.
static _Thread_local __unsafe_unretained NSMutableArray<dispatch_block_t> *RemovalFollowups;
void CSGroupChatSetRuntimeEnabled(BOOL enabled){
    unsigned long old=atomic_load_explicit(&Ingress,memory_order_relaxed),next;
    do{next=((old+2)&~1UL)|(enabled?1UL:0UL);}while(!atomic_compare_exchange_weak_explicit(&Ingress,&old,next,memory_order_release,memory_order_relaxed));
}
static unsigned long Token(void){return atomic_load_explicit(&Ingress,memory_order_acquire);}
static BOOL Active(void){return (Token()&1UL) && CSBackupIsReady() && !CSBackupAccountIsSuspended();}
static BOOL HookABI(Class cls,NSString *name) {
    Method method=class_getInstanceMethod(cls,NSSelectorFromString(name));if(!method || method_getNumberOfArguments(method)!=3)return NO;
    char result[16]={0},argument[16]={0};method_getReturnType(method,result,sizeof(result));method_getArgumentType(method,2,argument,sizeof(argument));return result[0]=='v' && argument[0]=='@';
}
static NSString *String(id object,NSString *selector){id value=CSMessageActionNativeObject(object,selector);return [value isKindOfClass:NSString.class]?[value copy]:nil;}
static NSString *PBString(id value){return [value isKindOfClass:NSString.class]?[value copy]:String(value,@"string");}
static NSString *NameField(id value) {
    if(![value isKindOfClass:NSString.class] || [value length]>2048)return nil;
    NSString *trimmed=[value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if(!trimmed.length || [trimmed caseInsensitiveCompare:@"null"]==NSOrderedSame || [trimmed caseInsensitiveCompare:@"(null)"]==NSOrderedSame)return nil;
    return [value copy];
}
static NSDictionary *CaptureMemberFields(id response,NSString *room,NSSet *members) {
    // The full detail may contain profile rows for a subset of the full list.
    // They supply names only; the allMemberUserNameList still defines membership.
    id data=CSMessageActionNativeObject(response,@"newChatroomData");
    NSString *dataRoom=PBString(CSMessageActionNativeObject(data,@"chatRoomUserName"));
    if(dataRoom.length && ![dataRoom isEqual:room])return @{};
    id rows=CSMessageActionNativeObject(data,@"chatRoomMember");
    if(![rows isKindOfClass:NSArray.class] || [rows count]>10000)return @{};
    NSMutableDictionary *fields=[NSMutableDictionary dictionary];
    for(id row in rows){
        NSString *member=String(row,@"userName");if(!member || ![members containsObject:member])continue;
        if(fields[member])return @{};
        fields[member]=@{ @"nickname":NameField(String(row,@"nickName"))?:@"", @"remark":NameField(String(row,@"displayName"))?:@"" };
    }
    return [fields copy];
}
static NSDictionary *CaptureResponse(id wrapper) {
    @try {
        id response=CSMessageActionNativeObject(wrapper,@"m_pbResponse"),request=CSMessageActionNativeObject(wrapper,@"m_pbRequest");
        NSString *room=String(request,@"chatroomUserName");if(![room hasSuffix:@"@chatroom"] || ![room isEqual:String(response,@"chatroomUserName")])return nil;
        id base=CSMessageActionNativeObject(response,@"baseResponse");
        if(!CSMessageNativeSupports(base,@"ret",@"i",@[]) || [CSMessageNativeInvoke(base,@"ret",@[]) intValue]!=0 || !CSMessageNativeSupports(response,@"allMemberCount",@"I",@[]) || !CSMessageNativeSupports(response,@"serverVersion",@"I",@[]))return nil;
        NSUInteger count=(NSUInteger)CSMessageNativeUnsigned(response,@"allMemberCount");
        id raw=CSMessageActionNativeObject(response,@"allMemberUserNameList");if(![raw isKindOfClass:NSArray.class] || [raw count]!=count || !count || count>10000)return nil;
        NSMutableArray *members=[NSMutableArray arrayWithCapacity:count];
        for(id value in raw){NSString *member=PBString(value);if(!CSGroupChatValidMemberID(member))return nil;[members addObject:member];}
        NSSet *identities=CSGroupChatValidatedMembers(members,count);if(!identities)return nil;
        return @{@"roomID":room,@"members":[members copy],@"version":@(CSMessageNativeUnsigned(response,@"serverVersion")),@"observedAt":NSDate.date,@"profileFields":CaptureMemberFields(response,room,identities)};
    }@catch(__unused NSException *exception){return nil;}
}
static void Publish(NSDictionary *packet,NSUInteger epoch,unsigned long token) {
    if(!packet || !Active() || Token()!=token || CSBackupAccountEpoch()!=epoch)return;
    NSString *room=packet[@"roomID"];id contact=CSGroupChatRoomContact(room),data=CSMessageActionNativeObject(contact,@"m_ChatRoomData");
    if(!contact || !CSMessageNativeSupports(data,@"chatRoomVersion",@"I",@[]) || CSMessageNativeUnsigned(data,@"chatRoomVersion")!=[packet[@"version"] unsignedLongLongValue])return;
    NSSet *identities=[NSSet setWithArray:packet[@"members"]],*native=CSGroupChatMemberIDs(room);if(!native || ![identities isEqual:native])return;
    NSMutableDictionary *names=[NSMutableDictionary dictionary],*remarks=[NSMutableDictionary dictionary],*times=[NSMutableDictionary dictionary];
    BOOL hasJoin=CSMessageNativeSupports(data,@"hasJoinInfoForUsername:",@"B",@[@"@"]) && CSMessageNativeSupports(data,@"getJoinTimeForUsername:",@"I",@[@"@"]);
    BOOL hasRemark=CSMessageNativeSupports(data,@"getDislayNameForUserName:",@"@",@[@"@"]);
    for(NSString *member in packet[@"members"]){
        NSDictionary *fields=packet[@"profileFields"][member];
        NSString *nickname=NameField(fields[@"nickname"]),*remark=NameField(fields[@"remark"]);
        if(!nickname)nickname=NameField(CSGroupChatMemberName(room,member));
        if(!remark && hasRemark)remark=NameField(CSMessageNativeInvoke(data,@"getDislayNameForUserName:",@[member]));
        names[member]=nickname?:remark?:member;if(remark)remarks[member]=remark;
        if(hasJoin && [CSMessageNativeInvoke(data,@"hasJoinInfoForUsername:",@[member]) boolValue]){NSNumber *time=CSMessageNativeInvoke(data,@"getJoinTimeForUsername:",@[member]);if(time)times[member]=time;}}
    if(!Active() || Token()!=token || CSBackupAccountEpoch()!=epoch || CSMessageNativeUnsigned(data,@"chatRoomVersion")!=[packet[@"version"] unsignedLongLongValue] || ![CSGroupChatMemberIDs(room) isEqual:identities])return;
    NSMutableDictionary *snapshot=[packet mutableCopy];[snapshot removeObjectForKey:@"profileFields"];
    snapshot[@"roomName"]=CSGroupChatRoomName(room);snapshot[@"names"]=[names copy];snapshot[@"remarks"]=[remarks copy];snapshot[@"joinTimes"]=[times copy];
    snapshot[@"active"]=@YES;snapshot[@"unavailable"]=@(CSGroupChatRoomUnavailable(room));
    [CSGroupChatManager.sharedManager receiveMemberSnapshot:[snapshot copy] epoch:epoch];
}
static void InstallResponseHook(void) {
    Class cls=NSClassFromString(@"CGroupMgr");NSString *name=@"OnGetChatRoomMemberDetail:";
    if(!HookABI(cls,name))return;SEL selector=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id service,id wrapper){NSUInteger epoch=CSBackupAccountEpoch();unsigned long token=Token();NSDictionary *packet=(token&1UL) && Active()?CaptureResponse(wrapper):nil;
        MemberResponseDepth++;
        @try{((void(*)(id,SEL,id))original)(service,selector,wrapper);}@finally{MemberResponseDepth--;}
        if(packet && Active() && Token()==token && CSBackupAccountEpoch()==epoch){
            dispatch_block_t publish=^{@try{Publish(packet,epoch,token);}@catch(__unused NSException *exception){}};
            if(RemovalFollowups)[RemovalFollowups addObject:publish];else dispatch_async(dispatch_get_main_queue(),publish);
        }
    });MSHookMessageEx(cls,selector,replacement,&original);
}
static NSSet *RemovalMemberIDs(id payload) {
    if(!CSMessageNativeSupports(payload,@"memberCount",@"I",@[]))return nil;
    NSUInteger count=(NSUInteger)CSMessageNativeUnsigned(payload,@"memberCount");
    id raw=CSMessageActionNativeObject(payload,@"memberList");
    if(![raw isKindOfClass:NSArray.class] || !count || count>10000 || [raw count]!=count)return nil;
    NSMutableArray *members=[NSMutableArray arrayWithCapacity:count];
    for(id row in raw){
        NSString *member=PBString(CSMessageActionNativeObject(row,@"memberName"));
        if(!CSGroupChatValidMemberID(member))return nil;[members addObject:member];
    }
    return CSGroupChatValidatedMembers(members,count);
}
static NSDictionary *CaptureRemovalResponse(id wrapper) {
    @try {
        id request=CSMessageActionNativeObject(wrapper,@"m_pbRequest"),response=CSMessageActionNativeObject(wrapper,@"m_pbResponse");
        NSString *room=String(request,@"chatRoomName");if(![room hasSuffix:@"@chatroom"])return nil;
        id base=CSMessageActionNativeObject(response,@"baseResponse");
        if(!CSMessageNativeSupports(base,@"ret",@"i",@[]) || [CSMessageNativeInvoke(base,@"ret",@[]) intValue]!=0)return nil;
        NSSet *requested=RemovalMemberIDs(request);if(!requested)return nil;
        NSMutableSet *confirmed=[RemovalMemberIDs(response) mutableCopy];[confirmed intersectSet:requested];
        // A successful operation without per-member evidence still justifies a
        // refresh. Only matching confirmed IDs can label the eventual delta.
        return @{@"roomID":room,@"members":confirmed.allObjects?:@[]};
    }@catch(__unused NSException *exception){return nil;}
}
static void InstallRemovalResponseHook(void) {
    Class cls=NSClassFromString(@"CGroupMgr");NSString *name=@"OnDeleteChatRoomMemberResponse:";
    if(!HookABI(cls,name))return;SEL selector=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id service,id wrapper){
        NSUInteger epoch=CSBackupAccountEpoch();unsigned long token=Token();
        NSDictionary *packet=!MemberResponseDepth && Active()?CaptureRemovalResponse(wrapper):nil;
        if(!packet){((void(*)(id,SEL,id))original)(service,selector,wrapper);return;}
        NSMutableArray<dispatch_block_t> *followups=[NSMutableArray array];RemovalFollowups=followups;MemberResponseDepth++;
        @try{((void(*)(id,SEL,id))original)(service,selector,wrapper);}
        @finally{MemberResponseDepth--;RemovalFollowups=nil;}
        if(!Active() || Token()!=token || CSBackupAccountEpoch()!=epoch)return;
        dispatch_async(dispatch_get_main_queue(),^{
            @try{if(Active() && Token()==token && CSBackupAccountEpoch()==epoch)
                [CSGroupChatManager.sharedManager nativeMemberRemovals:packet[@"members"] inRoom:packet[@"roomID"] epoch:epoch];}
            @catch(__unused NSException *exception){}
            for(dispatch_block_t publish in followups)publish();
        });
    });MSHookMessageEx(cls,selector,replacement,&original);
}
static void InstallContactHook(NSString *className,NSString *name) {
    Class cls=NSClassFromString(className);if(!HookABI(cls,name))return;SEL selector=NSSelectorFromString(name);__block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id service,id contact){NSUInteger epoch=CSBackupAccountEpoch();unsigned long token=Token();NSString *room=!MemberResponseDepth && (token&1UL) && Active()?String(contact,@"m_nsUsrName"):nil;
        ((void(*)(id,SEL,id))original)(service,selector,contact);
        if([room hasSuffix:@"@chatroom"] && Active() && Token()==token && CSBackupAccountEpoch()==epoch)dispatch_async(dispatch_get_main_queue(),^{@try{if(Token()==token && Active())[CSGroupChatManager.sharedManager nativeContactChanged:room epoch:epoch];}@catch(__unused NSException *exception){}});
    });MSHookMessageEx(cls,selector,replacement,&original);
}
static NSString *SystemMessageRoom(id room,id wrap) {
    if(![room isKindOfClass:NSString.class] || ![room hasSuffix:@"@chatroom"])return nil;
    unsigned long long type=CSMessageNativeUnsigned(wrap,@"m_uiMessageType");
    if((type!=10000 && type!=10002) || !CSMessageNativeUnsigned(wrap,@"m_n64MesSvrID"))return nil;
    NSString *from=String(wrap,@"m_nsFromUsr"),*to=String(wrap,@"m_nsToUsr");
    return [room isEqual:from] || [room isEqual:to]?[room copy]:nil;
}
static void InstallSystemMessageHook(void) {
    Class cls=NSClassFromString(@"CMessageMgr");SEL selector=NSSelectorFromString(@"AsyncOnAddMsg:MsgWrap:");
    Method method=class_getInstanceMethod(cls,selector);if(!method || method_getNumberOfArguments(method)!=4)return;
    char result[16]={0},first[16]={0},second[16]={0};method_getReturnType(method,result,sizeof(result));method_getArgumentType(method,2,first,sizeof(first));method_getArgumentType(method,3,second,sizeof(second));
    if(result[0]!='v' || first[0]!='@' || second[0]!='@')return;
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id service,id room,id wrap){
        NSUInteger epoch=CSBackupAccountEpoch();unsigned long token=Token();NSString *hint=!MemberResponseDepth && (token&1UL) && Active()?SystemMessageRoom(room,wrap):nil;
        ((void(*)(id,SEL,id,id))original)(service,selector,room,wrap);
        if(hint && Token()==token && Active() && CSBackupAccountEpoch()==epoch)dispatch_async(dispatch_get_main_queue(),^{
            @try{if(Token()==token && Active() && CSBackupAccountEpoch()==epoch)[CSGroupChatManager.sharedManager nativeSystemMessageInRoom:hint epoch:epoch];}@catch(__unused NSException *exception){}
        });
    });MSHookMessageEx(cls,selector,replacement,&original);
}
void CSGroupChatInstallRuntimeHooks(void) {
    static dispatch_once_t once;dispatch_once(&once,^{InstallResponseHook();InstallContactHook(@"CGroupMgr",@"onModifyContact:");InstallContactHook(@"CContactMgr",@"callOnModifyExt:");InstallSystemMessageHook();InstallRemovalResponseHook();});
}
