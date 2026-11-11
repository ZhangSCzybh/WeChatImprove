#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSGroupChatManager.h"
#import "../Controllers/CSGroupChatRuntime.h"
#import "../Controllers/CSGroupChatLocalNotice.h"
#import "../Controllers/CSBackgroundRunManager.h"
%ctor {
    CSBackupWhenReady(^{dispatch_async(dispatch_get_main_queue(),^{
        CSGroupChatInstallRuntimeHooks();CSGroupChatInstallNoticeHooks();
        CSGroupChatManager *group=CSGroupChatManager.sharedManager;
        CSBackgroundRunManager *background=CSBackgroundRunManager.sharedManager;
        [background start];
        [group configureBackgroundDemand:^(BOOL requested){[background setGroupChatBackgroundRequested:requested];}];
        [group start];
    });});
}
