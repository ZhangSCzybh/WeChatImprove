#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/wechat-authorization-prompt.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
python3 - "$test_dir" <<'PY'
from pathlib import Path
import sys

out = Path(sys.argv[1])
def extract(source, signature):
    start = source.index(signature)
    opening = source.index('{', start)
    depth, pos = 1, opening + 1
    while depth:
        depth += (source[pos] == '{') - (source[pos] == '}')
        pos += 1
    return source[start:pos]

manager = Path('Controllers/CSAuthorizationManager.m').read_text()
settings = Path('Controllers/CSCustomViewController.m').read_text()
entry = Path('Hooks/CustomEntryHooks.xm').read_text()
for signature in ('- (void)onCustomEntryClick {', '- (void)onCustomEntryClickInSetting:'):
    method = extract(entry, signature)
    assert 'requestAuthorizationWithPresentingViewController:' in method, 'Entry must use shared native authorization prompt'
    assert 'UIAlertController' not in method, 'Entry must not create a separate authorization prompt'
(out / 'AuthorizationManagerPromptUnderTest.h').write_text(extract(manager, '- (void)requestAuthorizationWithPresentingViewController:'))
(out / 'AuthorizationSettingsUnderTest.h').write_text('\n'.join(extract(settings, signature) for signature in (
    '- (void)returnFromUnauthorizedSettings', '- (void)viewDidAppear:', '- (void)viewDidDisappear:')))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
    -framework Foundation -I"$test_dir" Tests/AuthorizationPromptTests.m -o "$test_dir/tests"
"$test_dir/tests"
