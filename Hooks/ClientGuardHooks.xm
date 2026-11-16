#import "../Controllers/CSBackupBootstrap.h"
#import "../Controllers/CSClientGuard.h"

%ctor {
    CSBackupWhenReady(^{ CSClientGuardStart(); });
}
