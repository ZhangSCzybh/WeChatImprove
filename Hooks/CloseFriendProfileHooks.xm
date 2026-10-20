#import "../Controllers/CSCloseFriendProfileAdapter.h"
static void Refresh0(NSString *cls,NSString *name) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object){
        CSCFProfileBind(object); ((void(*)(id,SEL))original)(object,selector); CSCFProfileRefresh(object);
    });
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:")) imp_removeBlock(replacement);
}
static void Guard0(NSString *cls,NSString *name) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object){if(!CSCFProfileBlocksAction(object)) ((void(*)(id,SEL))original)(object,selector);});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:")) imp_removeBlock(replacement);
}
static void Guard1(NSString *cls,NSString *name) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object,id argument){if(!CSCFProfileBlocksAction(object)) ((void(*)(id,SEL,id))original)(object,selector,argument);});
    if(!CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:@")) imp_removeBlock(replacement);
}
%ctor { dispatch_async(dispatch_get_main_queue(),^{
    for(NSString *name in @[@"viewDidLoad",@"viewDidLayoutSubviews",@"reloadView",@"reloadContactAssist",@"onTableViewReload"]) Refresh0(@"ContactInfoViewController",name);
    for(NSString *name in @[@"viewWillAppear:",@"viewDidAppear:"]) {
        __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id object,BOOL animated){CSCFProfileBind(object); ((void(*)(id,SEL,BOOL))original)(object,selector,animated); CSCFProfileRefresh(object);});
        if(!CSCloseFriendInstallHook(@"ContactInfoViewController",name,replacement,&original,"v@:B")) imp_removeBlock(replacement);
    }
    for(NSString *cls in @[@"CBaseContactInfoAssist",@"WeixinContactInfoAssist"]) {
        for(NSString *name in @[@"onAddToContacts",@"doAddContact",@"doSendVerifyOrAddContact",@"onVerifyContactOk",@"doVerifyContactOk",@"onOpenIMVerifyContactOk",@"onClickSendVerifyMsg",@"onSayHelloToContact",@"onOpenVoipView",@"onOpenVoiceVoipView",@"doDeleteContact",@"opEditRemarkName",@"opEditSetPermission",@"onSocialInfoHandle",@"showAlbumList",@"opShareMyFriend"]) Guard0(cls,name);
        for(NSString *name in @[@"onNewMessage:",@"onOpenVoipActionSheet:",@"onStartChat:",@"startForAddVerifyMsg:",@"onDoVerifyByAlertView:",@"opEditRemarkNameInViewController:"]) Guard1(cls,name);
    }
    for(NSString *name in @[@"onAddToContact",@"onSendVerifyMsg",@"onVerifyOK",@"onSayHello",@"onRemoveContact",@"onShareMyFriend",@"onTapAtTextStateHeadButton",@"onTextStateJumpSource",@"onFollowTextState"]) Guard0(@"ContactInfoViewController",name);
    for(NSString *name in @[@"onNewMessage:",@"onNewMessageWithPushOnTop:",@"onTalk:",@"jumpToContentViewController:",@"onVerifyOKWithContact:",@"onDeleteContact:",@"onTapAtTextStateDetailButtonWithHandler:"]) Guard1(@"ContactInfoViewController",name);
    __block IMP message=NULL;
    IMP replacement=imp_implementationWithBlock(^(id object,id argument,id info){if(!CSCFProfileBlocksAction(object)) ((void(*)(id,SEL,id,id))message)(object,NSSelectorFromString(@"onNewMessage:requestInfo:"),argument,info);});
    if(!CSCloseFriendInstallHook(@"ContactInfoViewController",@"onNewMessage:requestInfo:",replacement,&message,"v@:@@")) imp_removeBlock(replacement);
    // No isMyContact / isMMContact hook. Native relationship flags remain true and intact.
}); }
