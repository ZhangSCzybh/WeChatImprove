#!/bin/bash
# Offline release fixture; no edits to Tests/, WeChat data or network access.
set -euo pipefail
cd "$(dirname "$0")/../../.."
audit_dir="$PWD/docs/audits/2.4-7"
fixture_tmp="$(mktemp -d "${TMPDIR:-/tmp}/wechat-247-live-background.XXXXXX")"
trap 'rm -rf "$fixture_tmp"' EXIT
python3 - "$fixture_tmp" <<'PY'
from pathlib import Path
import re
import sys

out = Path(sys.argv[1])
# Reuse the existing fake UIKit and AVFoundation. Translate only Logos's
# implicit original calls, as Tests/verify-background-run.sh does.
audio = Path('Hooks/BackgroundRun.xm').read_text().split('%hook AVAudioSession', 1)[1].split('%end', 1)[0]
originals = iter([
    '[self setCategory:category withOptions:0 error:error]',
    '[self setCategory:category mode:self.mode options:options error:error]',
    '[self setCategory:category mode:mode routeSharingPolicy:0 options:options error:error]',
    '[self nativeCategory:category mode:mode policy:policy options:options error:error]',
    '[self nativeMode:mode error:error]',
    '[self setActive:active withOptions:0 error:error]',
    '[self nativeActive:active error:error]',
])
audio, count = re.subn('%orig', lambda _: next(originals), audio)
assert count == 7
(out/'BackgroundAudioHooksUnderTest.h').write_text(audio)

# Keep production constructor wiring; replace its host startup envelope only.
hook = Path('Hooks/GroupChatHooks.xm').read_text()
start = hook.index('        CSGroupChatInstallRuntimeHooks();')
end = hook.index('        [group start];', start) + len('        [group start];')
(out/'GroupChatHookUnderTest.h').write_text(hook[start:end]+'\n')

# Keep the production local insertion path. Click handling is an unrelated
# UIKit UI surface and is covered by the existing notice tests.
notice = Path('Controllers/CSGroupChatLocalNotice.m').read_text().split('static id CSNoticeModel(', 1)[0]
notice = notice.replace('static char CSGroupNoticeOwnedKey,CSGroupNoticeTapKey,CSGroupNoticeLastTapKey;',
                        'static char CSGroupNoticeOwnedKey;')
(out/'GroupChatLocalInsertUnderTest.m').write_text(notice)

# Redirect only the group file path. Both stores otherwise use the real disk
# code, with the same synthetic account rooted inside this invocation's tmpdir.
(out/'GroupChatStoreUnderTest.m').write_text(
    '#define CSGroupChatFileURL CSAuditUnredirectedGroupChatFileURL\n'
    f'#include "{Path("Controllers/CSGroupChatStore.m").resolve()}"\n')
(out/'substrate.h').write_text(
    '#import <objc/runtime.h>\n'
    'void MSHookMessageEx(Class cls, SEL selector, IMP replacement, IMP *original);\n')
(out/'UIKitExtras.h').write_text('''
#import <UIKit/UIKit.h>
@class UITableView;
extern NSNotificationName const UIApplicationSignificantTimeChangeNotification;
@interface UINavigationController : NSObject
- (void)pushViewController:(id)controller animated:(BOOL)animated;
@end
@interface UIViewController : NSObject
@property(nonatomic) BOOL hidesBottomBarWhenPushed;
@property(nonatomic, strong) UINavigationController *navigationController;
@end
''')
PY

xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -Wno-nullability-completeness -Wno-incomplete-implementation -framework Foundation \
    -DAVAudioSession=CSTestAudioSession -DAVAudioPlayer=CSTestAudioPlayer \
    -include "$fixture_tmp/UIKitExtras.h" -ITests/BackgroundRunNative -IControllers -ITests -I"$fixture_tmp" \
    Tests/BackgroundRunNative/BackgroundRunNative.m Tests/BackgroundRunFakeRuntime.m \
    Controllers/CSBackgroundRunAudio.m Controllers/CSBackgroundRunManager.m Controllers/CSBackgroundRunRuntime.m \
    Controllers/CSGroupChatManager.m Controllers/CSGroupChatRuntime.m Controllers/CSGroupChatNativeAdapter.m \
    Controllers/CSGroupChatEventPolicy.m Controllers/CSGroupChatTemplate.m Controllers/CSGroupChatNoticeReference.m \
    Controllers/CSMessageActionContext.m Controllers/CSMessageNativeActionAdapter.m Controllers/CSMessageSendAdapter.m \
    Controllers/CSScheduledTaskManager.m Controllers/CSScheduledTaskStore.m Controllers/CSBackupMutation.m \
    "$fixture_tmp/GroupChatStoreUnderTest.m" "$fixture_tmp/GroupChatLocalInsertUnderTest.m" \
    "$audit_dir/LiveBackgroundFixture.m" -o "$fixture_tmp/fixture"

if [[ $# -eq 0 ]]; then
    set -- A B B-queued C D
fi
for scenario in "$@"; do
    mkdir "$fixture_tmp/$scenario"
    "$fixture_tmp/fixture" "$scenario" "$fixture_tmp/$scenario"
done
