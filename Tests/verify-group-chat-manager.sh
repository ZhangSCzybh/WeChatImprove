#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-chat-manager.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
mkdir -p "$test_dir/shim/UIKit"
cat > "$test_dir/shim/UIKit/UIKit.h" <<'SHIM'
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,UIApplicationState){UIApplicationStateActive,UIApplicationStateInactive,UIApplicationStateBackground};
FOUNDATION_EXPORT NSNotificationName const UIApplicationDidBecomeActiveNotification;
FOUNDATION_EXPORT NSNotificationName const UIApplicationDidEnterBackgroundNotification;
@interface UIViewController:NSObject @end
@interface UIApplication:NSObject
+ (instancetype)sharedApplication;
@property(nonatomic) UIApplicationState applicationState;
@end
SHIM
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-incomplete-implementation \
 -include dispatch/dispatch.h -I"$test_dir/shim" -IControllers -framework Foundation \
 Controllers/CSGroupChatManager.m Controllers/CSGroupChatEventPolicy.m Controllers/CSGroupChatTemplate.m \
 Tests/GroupChatManagerTests.m -o "$test_dir/tests"
"$test_dir/tests" "$@"
