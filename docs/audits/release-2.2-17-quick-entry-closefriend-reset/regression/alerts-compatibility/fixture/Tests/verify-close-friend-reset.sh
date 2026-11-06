#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
reset_work=$(mktemp -d)
trap 'rm -rf "$reset_work"' EXIT
# Temporary encrypted stores/preferences and injected credentials only. Never use device data or Keychain.
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -IControllers -framework Foundation -framework Security \
 Controllers/CSCloseFriendPolicy.m Controllers/CSCloseFriendCrypto.m Controllers/CSCloseFriendStore.m Controllers/CSPluginStorage.m \
 Controllers/CSCloseFriendRuntime.m Controllers/CSCloseFriendEntryState.m Controllers/CSCloseFriendReset.m \
 Tests/CloseFriendResetTests.m -o "$reset_work/reset"
"$reset_work/reset"
