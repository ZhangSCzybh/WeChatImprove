#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror \
  -framework Foundation -IControllers \
  Controllers/CSCloseFriendCallDiagnostics.m Tests/CloseFriendCallDiagnosticsTests.m -o "$work/diagnostics"
"$work/diagnostics"
