#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
flags=(-fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers -framework Foundation -framework Security)
xcrun --sdk macosx clang "${flags[@]}" Controllers/CSAIReplyStore.m Tests/AIReplyStoreTests.m -o "$work/store-tests"
"$work/store-tests"
xcrun --sdk macosx clang "${flags[@]}" Controllers/CSAIReplyStore.m Controllers/CSAIClient.m Controllers/CSAICredentialStore.m Tests/AIClientTests.m -o "$work/client-tests"
"$work/client-tests"
