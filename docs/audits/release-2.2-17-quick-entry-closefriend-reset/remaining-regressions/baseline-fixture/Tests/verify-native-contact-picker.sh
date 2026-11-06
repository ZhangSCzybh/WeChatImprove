#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-native-picker.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import os, re, sys
repo,out=map(Path,sys.argv[1:])
source=Path(os.environ.get('CS_TEST_SCHEDULED_SETTINGS_SOURCE',repo/'Controllers/CSScheduledTaskSettingsViewController.m')).read_text()
methods=[]
for name in ['canPresentTargetPicker','finishTargetSheet:','chooseTarget','presentTargetPicker:']:
    match=re.search(r'^- \([^)]+\)'+re.escape(name)+r'(?=[ :(])',source,re.M)
    if not match:
        assert name in ['canPresentTargetPicker','finishTargetSheet:'],name
        continue # Allows the regression to execute unchanged pre-fix code.
    start=match.start();opening=source.index('{',start);depth=1;end=opening+1
    while depth:
        depth+=(source[end]=='{')-(source[end]=='}');end+=1
    methods.append(source[start:end])
(out/'ScheduledTaskPickerUnderTest.h').write_text('\n'.join(methods))
source=Path(os.environ.get('CS_TEST_GROUP_SETTINGS_SOURCE',repo/'Controllers/CSChatGroupSettingsViewController.m')).read_text()
methods=[]
for name in ['copyAccountPreferences','canEditAccount:','customTabWithID:', 'contactSelectionPolicyChanged:', 'contactSelectionValidatorForTab:', 'contactName:','showContactSelectForTab:','showTagSelectForTab:','presentContactSelectWithType:']:
    match=re.search(r'^- \([^\n]+?\)'+re.escape(name)+r'(?=[ :(])',source,re.M)
    if not match:
        assert name in ['contactSelectionPolicyChanged:', 'contactSelectionValidatorForTab:', 'contactName:'],name
        continue
    start=match.start();opening=source.index('{',start);depth=1;end=opening+1
    while depth:
        depth+=(source[end]=='{')-(source[end]=='}');end+=1
    methods.append(source[start:end])
(out/'GroupPickerUnderTest.h').write_text('\n'.join(methods))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -I"$test_dir" -I"$project_dir/Tests/NativePickerUIKit" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" "$project_dir/Controllers/CSNativeContactPicker.m" \
  "$project_dir/Controllers/CSGroupPreferences.m" "$project_dir/Controllers/WESessionTabItem.m" \
  "$project_dir/Tests/NativeContactPickerTests.m" -o "$test_dir/tests"
"$test_dir/tests"
