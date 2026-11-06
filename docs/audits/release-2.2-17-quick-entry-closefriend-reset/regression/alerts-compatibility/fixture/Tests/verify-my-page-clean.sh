#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-my-page-clean.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
# Exercise the production filtering and lifecycle code against a small native-list double.
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, output = map(Path, sys.argv[1:])
source = (root / 'Hooks/HideMomentsHooks.xm').read_text()
source = source.split('%ctor {')[0]
# The lifecycle gate is independently exercised by verify-backup-bootstrap.sh.
source = source.replace('#import "../Controllers/CSBackupBootstrap.h"', '')
source = source.replace('#import <UIKit/UIKit.h>', '#import <Foundation/Foundation.h>')
source = source.replace('@interface MoreViewController : NSObject', '@interface MoreViewController : NativeMoreViewController')
source = source.replace('%hook MoreViewController', '@implementation MoreViewController').replace('%end', '@end')
for replacement in ('[super viewDidLoad];', '[super viewWillAppear:arg1];', '[super reloadMoreView];'):
    source = source.replace('%orig;', replacement, 1)
assert '%orig' not in source
(output / 'MyPageHookUnderTest.h').write_text(source)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -Wno-unused-parameter -Wno-unused-function -Wno-undeclared-selector \
  -framework Foundation -I"$test_dir" \
  "$project_dir/Tests/MyPageCleanTests.m" -o "$test_dir/my-page-tests"
"$test_dir/my-page-tests"
