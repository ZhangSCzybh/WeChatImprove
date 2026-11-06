#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-revoke.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -Wall -Wextra -Werror -Wno-unused-parameter -framework Foundation \
 -I"$project_dir/Controllers" "$project_dir/Controllers/CSRevokeReference.m" "$project_dir/Tests/RevokeReferenceTests.m" -o "$test_dir/revoke-tests"
"$test_dir/revoke-tests"
