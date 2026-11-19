#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSMomentsLayoutPreferences.h"
#import "../Controllers/CSMomentsLayoutRuntime.h"

%ctor {
    CSBackupWhenReady(^{
        CSMomentsLayoutStart();
        CSMomentsLayoutRuntimeStart();
    });
}
