#!/bin/sh
# Build the production coordinator with fake host services; no WeChat is opened.
set -eu
project_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
test_dir=$(mktemp -d "${TMPDIR:-/tmp}/cs-group-quit-tests.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT HUP INT TERM
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root, temporary = map(Path, sys.argv[1:])
source = (root / "Controllers/CSGroupChatQuitCoordinator.m").read_text()
# Only imports are replaced. The state machine is the checked-in implementation.
(temporary / "CSGroupChatQuitCoordinator-under-test.inc").write_text(
    "\n".join(line for line in source.splitlines() if not line.startswith("#import"))
)
PY
xcrun clang -fobjc-arc -fblocks -framework Foundation -Werror \
    -Wno-unused-parameter -I "$test_dir" \
    "$project_dir/Tests/GroupChatQuitCoordinatorTests.m" -o "$test_dir/tests"
"$test_dir/tests"
