#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSScheduledTaskManager.h"
%ctor {
    CSBackupWhenReady(^{ dispatch_async(dispatch_get_main_queue(),^{ [CSScheduledTaskManager.sharedManager start]; }); });
}
