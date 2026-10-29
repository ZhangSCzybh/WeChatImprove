#import "../Controllers/CSAIReplyManager.h"
#import "../Controllers/CSAIChatDetailAdapter.h"
#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
#import <substrate.h>

// Install only checked concrete ABIs. Calls retain the original chain and preserve
// original arguments; reception is never delayed by networking or file IO.
static void CSAIInstallMessageHook(void){
    NSString *name=@"AsyncOnAddMsg:MsgWrap:";
    Class cls=NSClassFromString(@"CMessageMgr");SEL selector=NSSelectorFromString(name);
    Method method=class_getInstanceMethod(cls,selector);if(!method)return;
    char result[16]={0},arg[16]={0};method_getReturnType(method,result,sizeof(result));
    if(result[0]!='v' || method_getNumberOfArguments(method)!=4)return;
    for(unsigned int index=2;index<4;index++){method_getArgumentType(method,index,arg,sizeof(arg));if(arg[0]!='@')return;}
    __block IMP original=NULL;
    IMP replacement=imp_implementationWithBlock(^(id object,id session,id wrap){
        NSUInteger epoch=CSBackupAccountEpoch();
        ((void(*)(id,SEL,id,id))original)(object,selector,session,wrap);
        if(!CSAIReplyMessageIngressEnabled())return;
        dispatch_async(dispatch_get_main_queue(),^{
            [CSAIReplyManager.sharedManager receiveNativeSession:session wrap:wrap epoch:epoch];
        });
    });
    MSHookMessageEx(cls,selector,replacement,&original);
}
static void CSAIInstallDetailHook(NSString *className,NSString *name,BOOL animated){
    Class cls=NSClassFromString(className);SEL selector=NSSelectorFromString(name);Method method=class_getInstanceMethod(cls,selector);
    if(!method || method_getNumberOfArguments(method)!=(animated?3:2))return;
    char type[16]={0};method_getReturnType(method,type,sizeof(type));if(type[0]!='v')return;
    if(animated){method_getArgumentType(method,2,type,sizeof(type));if(type[0]!='B' && type[0]!='c')return;}
    __block IMP original=NULL;IMP replacement;
    if(animated)replacement=imp_implementationWithBlock(^(id page,BOOL flag){((void(*)(id,SEL,BOOL))original)(page,selector,flag);CSAIRefreshChatDetail(page);});
    else replacement=imp_implementationWithBlock(^(id page){((void(*)(id,SEL))original)(page,selector);CSAIRefreshChatDetail(page);});
    MSHookMessageEx(cls,selector,replacement,&original);
}
%ctor {
    CSBackupWhenReady(^{dispatch_async(dispatch_get_main_queue(),^{
        [CSAIReplyManager.sharedManager start];
        CSAIInstallMessageHook();
        for(NSString *name in @[@"AddContactToChatRoomViewController",@"ChatRoomInfoViewController"]){
            CSAIInstallDetailHook(name,@"reloadTableData",NO);
            CSAIInstallDetailHook(name,@"reloadProfileTableData",NO);
            CSAIInstallDetailHook(name,@"viewWillAppear:",YES);
        }
    });});
}
