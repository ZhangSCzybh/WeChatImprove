#import "../Controllers/CSCloseFriendCallAdapter.h"
#import "../Controllers/CSCloseFriendBridge.h"
static void Guard0(NSString *cls,NSString *name,BOOL invitation) {
    __block IMP orig=NULL;SEL sel=NSSelectorFromString(name);
    IMP imp=imp_implementationWithBlock(^(id object){if(!(invitation?CSCFInvitationOutputSuppressed(object):CSCFCallOutputSuppressed()))((void(*)(id,SEL))orig)(object,sel);});
    if(!CSCloseFriendInstallHook(cls,name,imp,&orig,"v@:"))imp_removeBlock(imp);
}
%ctor {dispatch_async(dispatch_get_main_queue(),^{
    CSCloseFriendRecordCapability(@"calls.systemFirstFrame.verified",NO);
    CSCloseFriendRecordCapability(@"calls.ilinkMain.rejection",NO);
    __block IMP invite=NULL;
    IMP imp=imp_implementationWithBlock(^BOOL(id service,id info,unsigned long long talking,unsigned long long key){
        if(CSCFHandleInvitation(service,info,talking))return YES;
        return ((BOOL(*)(id,SEL,id,unsigned long long,unsigned long long))invite)(service,NSSelectorFromString(@"handleInvitationInfo:withTalkingRoomID:talkingRoomKey:"),info,talking,key);
    });
    if(!CSCloseFriendInstallHook(@"VoIPInvitationService",@"handleInvitationInfo:withTalkingRoomID:talkingRoomKey:",imp,&invite,"B@:@QQ"))imp_removeBlock(imp);
    __block IMP multi=NULL;
    imp=imp_implementationWithBlock(^(id manager,id message){CSCFHandleMultiTalk(manager,message,^{((void(*)(id,SEL,id))multi)(manager,NSSelectorFromString(@"_onMonoServiceMsgStartWithMsg:"),message);});});
    if(!CSCloseFriendInstallHook(@"MultiTalkMgr",@"_onMonoServiceMsgStartWithMsg:",imp,&multi,"v@:@"))imp_removeBlock(imp);
    for(NSString *name in @[@"showInWindow",@"scrollIn",@"enterFloatWindowDirectly",@"vibrateClassicIfNeed"])Guard0(@"VoIPInvitationViewController",name,YES);
    Guard0(@"MultiTalkWindow",@"makeKeyAndVisible",NO);
    __block IMP hidden=NULL;
    imp=imp_implementationWithBlock(^(id window,BOOL hide){if(!hide && CSCFCallOutputSuppressed())return;((void(*)(id,SEL,BOOL))hidden)(window,@selector(setHidden:),hide);});
    if(!CSCloseFriendInstallHook(@"MultiTalkWindow",@"setHidden:",imp,&hidden,"v@:B"))imp_removeBlock(imp);
    __block IMP ring=NULL;
    imp=imp_implementationWithBlock(^(id manager,BOOL vibrate,BOOL caller){if(!caller && CSCFCallOutputSuppressed())return;((void(*)(id,SEL,BOOL,BOOL))ring)(manager,NSSelectorFromString(@"playRingSoundWithVibration:isCaller:"),vibrate,caller);});
    if(!CSCloseFriendInstallHook(@"MultiTalkMgr",@"playRingSoundWithVibration:isCaller:",imp,&ring,"v@:BB"))imp_removeBlock(imp);
    // Older versions expose this explicit incoming floating-banner boundary.
    __block IMP banner=NULL;
    imp=imp_implementationWithBlock(^(id manager,BOOL show,id group,unsigned long long room,unsigned long long key){
        if(show && CSCFCallBannerSuppressed(group,room))return;
        ((void(*)(id,SEL,BOOL,id,unsigned long long,unsigned long long))banner)(manager,NSSelectorFromString(@"showMultiTalkBanner:group:roomId:roomKey:"),show,group,room,key);
    });
    if(!CSCloseFriendInstallHook(@"MultiTalkMgr",@"showMultiTalkBanner:group:roomId:roomKey:",imp,&banner,"v@:B@QQ"))imp_removeBlock(imp);
});}
