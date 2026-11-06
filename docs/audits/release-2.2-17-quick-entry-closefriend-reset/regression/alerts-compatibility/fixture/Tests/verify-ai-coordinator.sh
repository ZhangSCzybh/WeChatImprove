#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations -IControllers -framework Foundation Controllers/CSAIReplyStore.m Controllers/CSAIReplyCoordinator.m Tests/AIReplyCoordinatorTests.m -o "$work/coordinator-tests"
"$work/coordinator-tests"
