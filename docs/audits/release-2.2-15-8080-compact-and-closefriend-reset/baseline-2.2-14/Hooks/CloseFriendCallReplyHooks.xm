#import "../Controllers/CSCloseFriendCallReply.h"
#import "../Controllers/CSCloseFriendBridge.h"
%ctor {dispatch_async(dispatch_get_main_queue(),^{
    for(NSString *name in @[@"OnSendMessageSuccess:",@"OnSendMessageFail:"]) {
        __block IMP original=NULL;SEL selector=NSSelectorFromString(name);
        IMP replacement=imp_implementationWithBlock(^(id manager,id message){
            ((void(*)(id,SEL,id))original)(manager,selector,message);
            CSCFCallReplyMessageDidChange(message);
        });
        if(!CSCloseFriendInstallHook(@"CMessageMgr",name,replacement,&original,"v@:@"))imp_removeBlock(replacement);
    }
});}
