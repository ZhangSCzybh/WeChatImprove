#import <Foundation/Foundation.h>
#import "../Controllers/CSBackupBootstrap.h"

@interface MMContextManager : NSObject @end

// This minimal boundary remains installed while all configuration consumers are held.
// Do not call message, group, or payment coordinators from these hooks.
%hook MMContextManager
- (void)logout:(id)context {
    CSBackupAccountWillChangeAtNativeBoundary();
    %orig;
}
- (void)loginByContext:(id)context {
    // Invalidate before native service replacement, including login without a preceding logout.
    CSBackupAccountWillChangeAtNativeBoundary();
    %orig;
    CSBackupAccountDidChangeAtNativeBoundary();
}
%end

%ctor { %init; }
