#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSAdPurification.h"

%ctor {
    CSBackupWhenReady(^{ CSAdPurificationStart(); });
}
