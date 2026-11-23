#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-quick-panel-router.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import re
import sys

project, output = map(Path, sys.argv[1:])
source = (project / 'Controllers/CSQuickPanelActionRouter.m').read_text()
spans = [
    ('static NSString * const CSQuickFavoriteSuite', '@protocol CSQuickQRCodeConstructor'),
    ('@protocol CSQuickQRCodeConstructor', 'static BOOL CSQuickMatches('),
    ('static BOOL CSQuickMatches(', 'static BOOL CSQuickCanNavigate('),
    ('static UIViewController *CSQuickCreatePage(', '// Inspect only'),
    ('static NSArray<id> *CSQuickOwners(', '@interface CSQuickRouteRequest'),
    ('@interface CSQuickRouteRequest', 'static BOOL CSQuickOpenClass('),
    ('static BOOL CSQuickOpenClass(', 'static void CSQuickAfterPrivacyAuthentication('),
    ('static BOOL CSQuickOpenCreateNote(', 'static BOOL CSQuickOpenPlugin('),
    ('static id CSQuickCurrentService(', '@implementation CSQuickPanelActionRouter'),
]
(output / 'QuickPanelRouterProduction.h').write_text('\n'.join(source[source.index(start):source.index(end)] for start, end in spans))
(output / 'QuickPanelRouterPublicProduction.h').write_text(source[source.index('@implementation CSQuickPanelActionRouter'):])
preferences = (project / 'Controllers/CSQuickPanelPreferences.m').read_text()
identifiers = preferences[preferences.index('+ (NSArray<NSString *> *)allActionIdentifiers'):]
expression = re.search(r'return\s+(@\[.*?\]);', identifiers, re.S)
if not expression:
    raise SystemExit('Could not extract production quick-panel action identifiers')
(output / 'QuickPanelPreferenceIDs.h').write_text('static NSArray *QuickPreferenceIDs(void) { return ' + expression.group(1) + '; }\n')
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -I"$project_dir/Controllers" -I"$test_dir" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$project_dir/Tests/QuickPanelRouterTests.m" -o "$test_dir/tests"
"$test_dir/tests"
