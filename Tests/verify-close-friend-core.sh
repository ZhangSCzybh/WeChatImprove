#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
  -IControllers -framework Foundation -framework Security \
  Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendCrypto.m Controllers/CSCloseFriendStore.m \
  Tests/CloseFriendCoreTests.m -o "$work/tests"
"$work/tests"
