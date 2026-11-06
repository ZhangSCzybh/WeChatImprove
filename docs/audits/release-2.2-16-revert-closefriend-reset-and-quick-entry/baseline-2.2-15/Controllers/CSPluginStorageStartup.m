#import "CSPluginStorage.h"
#import "CSBackupAudit.h"
#import <UIKit/UIKit.h>

static void MigratePluginStorage(NSString *trigger) {
    for(NSString *leaf in @[@"BackupV2",@"CloseFriends"]){
        CSPluginDirectoryMigration *migration=CSPluginStorageMigration(leaf);
        BOOL hadLegacy=[migration.readRoots containsObject:migration.legacyRoot];
        NSError *error=nil;BOOL ok=[migration migrate:&error];
        if(hadLegacy||!ok||[trigger isEqual:@"load"])
            [CSBackupDefaultAudit() record:ok?@"storage-ready":@"storage-migration-pending"
                details:@{@"directory":leaf,@"trigger":trigger,@"legacyPresent":@(hadLegacy),
                          @"destination":migration.destinationRoot.path,@"error":error.localizedDescription?:@""} stack:NO];
    }
}

// Raw filesystem work only, before normal hook constructors. Do not instantiate
// managers, access accounts/Keychain, or install hooks from this constructor.
// Makefile places this object first: Mach-O does not globally sort ctor priorities.
__attribute__((constructor(101))) static void CSPluginStorageLoad(void) {
    @autoreleasepool {
        MigratePluginStorage(@"load");
        for(NSString *name in @[UIApplicationProtectedDataDidBecomeAvailable,UIApplicationDidBecomeActiveNotification])
            [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:nil
                usingBlock:^(__unused NSNotification *note){
                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY,0),^{MigratePluginStorage(@"lifecycle");});
                }];
    }
}
