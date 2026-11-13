#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-background-run.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import re,sys
root,out=map(Path,sys.argv[1:])
source=(root/'Hooks/BackgroundRun.xm').read_text().split('%hook AVAudioSession',1)[1].split('%end',1)[0]
originals=[
 '[self setCategory:category withOptions:0 error:error]',
 '[self setCategory:category mode:self.mode options:options error:error]',
 '[self setCategory:category mode:mode routeSharingPolicy:0 options:options error:error]',
 '[self nativeCategory:category mode:mode policy:policy options:options error:error]',
 '[self nativeMode:mode error:error]',
 '[self setActive:active withOptions:0 error:error]',
 '[self nativeActive:active error:error]',
]
assert source.count('%orig')==len(originals)
for original in originals: source=source.replace('%orig',original,1)
(out/'BackgroundAudioHooksUnderTest.h').write_text(source)
manager=(root/'Controllers/CSBackgroundRunManager.m').read_text()
runtime=(root/'Controllers/CSBackgroundRunRuntime.m').read_text()
audio=(root/'Controllers/CSBackgroundRunAudio.m').read_text()
production=manager+runtime+audio+(root/'Hooks/BackgroundRun.xm').read_text()
for forbidden in ('dispatch_source_create','dispatch_after','%hook AppDelegate','%hook SpringBoard','CSBackgroundRunSilentAudioData','initWithData:','numberOfLoops'):
 assert forbidden not in production, forbidden
assert 'URLForResource:@"blank" withExtension:@"caf"' in audio
assert 'NSTimer' not in manager and 'beginBackgroundTask' not in manager
assert 'repeats:NO' in runtime and 'endBackgroundTask:' in runtime
assert 'canAttemptBackgroundWork' in manager
print('Background run: one-shot runtime boundary, finite task cleanup, public lifecycle and host blank.caf contracts')
PY
compile_background_test() {
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -Wno-nullability-completeness -framework Foundation \
    -DAVAudioSession=CSTestAudioSession -DAVAudioPlayer=CSTestAudioPlayer \
    -I"$project_dir/Tests/BackgroundRunNative" -I"$project_dir/Controllers" -I"$project_dir/Tests" -I"$test_dir" \
    "$project_dir/Tests/BackgroundRunNative/BackgroundRunNative.m" \
    "$project_dir/Controllers/CSBackgroundRunAudio.m" "$project_dir/Controllers/CSBackgroundRunManager.m" \
    "$project_dir/Controllers/CSBackgroundRunRuntime.m" "$project_dir/Tests/BackgroundRunFakeRuntime.m" \
    "$project_dir/Tests/$1.m" -o "$test_dir/$2"
}
compile_background_test BackgroundRunRecordTests background-records
"$test_dir/background-records"
compile_background_test BackgroundRunHybridTests background-hybrid
"$test_dir/background-hybrid"
compile_background_test BackgroundRunTests background-run
"$test_dir/background-run"
