#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/../../.."
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-group-background-demand.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import sys
script = Path('Tests/verify-background-run.sh').read_text()
generate = script.split("<<'PY'\n", 1)[1].split('\nPY\n', 1)[0]
sys.argv = [sys.argv[0], '.', sys.argv[1]]
exec(compile(generate, 'Tests/verify-background-run.sh', 'exec'))
PY
cat > "$test_dir/demand.m" <<'OBJC'
#define main ExistingBackgroundHybridTests
#import "BackgroundRunHybridTests.m"
#undef main

int main(void) { @autoreleasepool {
    NSString *suite=[@"background-demand-" stringByAppendingString:NSUUID.UUID.UUIDString];
    defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Create(NO,30); Enable(NO);
    NSMutableArray<NSArray<NSNumber *> *> *events=[NSMutableArray array];
    id token=[NSNotificationCenter.defaultCenter addObserverForName:CSBackgroundRunStateChangedNotification object:manager queue:nil usingBlock:^(NSNotification *note) {
        CSBackgroundRunManager *source=note.object;
        [events addObject:@[@(source.canAttemptBackgroundWork),@(source.canAttemptGroupChatBackgroundWork)]];
    }];
    [manager setGroupChatBackgroundRequested:YES]; NoResources();
    CHECK(!manager.enabled && !manager.canAttemptGroupChatBackgroundWork);
    Background(); CHECK(manager.canAttemptGroupChatBackgroundWork && !manager.canAttemptBackgroundWork);
    CHECK(runtime.beginAttempts==1 && runtime.liveTaskCount==1 && runtime.pendingCheckCount==1);
    NSArray *groupOnly=@[@NO,@YES],*both=@[@YES,@YES],*globalOnly=@[@YES,@NO],*neither=@[@NO,@NO];
    CHECK([events.lastObject isEqual:groupOnly]);
    Enable(YES); CHECK([events.lastObject isEqual:both]);
    [manager setGroupChatBackgroundRequested:NO]; CHECK([events.lastObject isEqual:globalOnly]);
    CHECK(runtime.beginAttempts==1 && runtime.liveTaskCount==1 && runtime.pendingCheckCount==1);
    [manager setGroupChatBackgroundRequested:YES]; Enable(NO);
    CHECK([events.lastObject isEqual:groupOnly] && runtime.beginAttempts==1);
    [runtime.tasks.firstObject expire]; NoResources(); CHECK([events.lastObject isEqual:neither]);
    Enable(YES); CHECK(runtime.beginAttempts==1 && !manager.canAttemptGroupChatBackgroundWork);
    Enable(NO); Foreground(); Background();
    CHECK(manager.canAttemptGroupChatBackgroundWork && !manager.canAttemptBackgroundWork && runtime.beginAttempts==2);
    [manager setGroupChatBackgroundRequested:NO]; NoResources(); CHECK([events.lastObject isEqual:neither]);
    [NSNotificationCenter.defaultCenter removeObserver:token];
    [defaults removePersistentDomainForName:suite];
    printf("Shared background demand: %lu checks passed; one lease, independent capabilities, expiry and final release\n",(unsigned long)checks);
} return 0; }
OBJC
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -Wno-nullability-completeness -framework Foundation \
    -DAVAudioSession=CSTestAudioSession -DAVAudioPlayer=CSTestAudioPlayer \
    -ITests/BackgroundRunNative -IControllers -ITests -I"$test_dir" \
    Tests/BackgroundRunNative/BackgroundRunNative.m Controllers/CSBackgroundRunAudio.m \
    Controllers/CSBackgroundRunManager.m Controllers/CSBackgroundRunRuntime.m Tests/BackgroundRunFakeRuntime.m \
    "$test_dir/demand.m" -o "$test_dir/demand"
"$test_dir/demand"
