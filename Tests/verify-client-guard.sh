#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-client-guard.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
sources=(
  "$project_dir/Controllers/CSCloseFriendSignatures.m" "$project_dir/Controllers/CSClientGuard.m"
  "$project_dir/Controllers/CSClientGuardQueryHooks.m" "$project_dir/Controllers/CSClientGuardNativeHooks.m"
  "$project_dir/Controllers/CSClientGuardJiDeNativeHooks.m" "$project_dir/Controllers/CSClientGuardJiDeQueryHooks.m"
)
flags=(-fobjc-arc -fblocks -DCS_CLIENT_GUARD_TESTING=1 -Wall -Wextra -Werror -framework Foundation -I"$project_dir/Controllers")
xcrun --sdk macosx clang "${flags[@]}" "${sources[@]}" \
  "$project_dir/Tests/ClientGuardRuntimeTests.m" "$project_dir/Tests/ClientGuardQueryTests.m" -o "$test_dir/tests"
"$test_dir/tests"
"$test_dir/tests" --char
for fixture in ClientGuardJiDeNativeTests ClientGuardJiDeQueryTests; do
  xcrun --sdk macosx clang "${flags[@]}" "${sources[@]}" "$project_dir/Tests/$fixture.m" -o "$test_dir/$fixture"
  if [[ "$fixture" == ClientGuardJiDeQueryTests ]]; then
    for opcode in i I q Q; do
      "$test_dir/$fixture" "--opcode=$opcode"
      "$test_dir/$fixture" --char "--opcode=$opcode"
    done
  else
    "$test_dir/$fixture"
    "$test_dir/$fixture" --char
  fi
done
xcrun --sdk macosx clang "${flags[@]}" "${sources[@]}" \
  "$project_dir/Tests/ClientGuard8080Tests.m" -o "$test_dir/ClientGuard8080Tests"
"$test_dir/ClientGuard8080Tests"
"$test_dir/ClientGuard8080Tests" --unsupported
