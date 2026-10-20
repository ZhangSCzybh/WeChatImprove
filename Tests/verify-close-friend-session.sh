#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-close-friend-session.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
source=(Path(sys.argv[1])/'Controllers/CSGroupListAdapter.m').read_text()
def extract(marker):
 start=source.index(marker); brace=source.index('{',start); depth=0
 for end in range(brace,len(source)):
  if source[end]=='{':depth+=1
  elif source[end]=='}':
   depth-=1
   if not depth:return source[start:end+1]
markers=['- (CSGroupProjection *)projectionForSections:', '- (BOOL)accountMatches', '- (NSIndexPath *)currentPathForRow:', '- (NSIndexPath *)nativePath:', '- (NSArray *)nativePaths:', '- (NSIndexPath *)displayPath:', '- (BOOL)navigatePrivateSessionsForward:', '- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {', '- (void)forwardInvocation:(NSInvocation *)inv target:(id)target {']
(Path(sys.argv[2])/'SessionBodies.h').write_text('\n'.join(extract(m) for m in markers))
(Path(sys.argv[2])/'PrivacyActive.h').write_text(extract('static BOOL CSGroupPrivacyActive('))
source=(Path(sys.argv[1])/'Hooks/SessionGroupHooks.xm').read_text()
(Path(sys.argv[2])/'SessionNavigationHooks.h').write_text('\n'.join(extract('- (void)'+name+' {').replace('%orig','[self originalNativeTraversal]') for name in ['onNextUnreadChat','onNextChat','onLastChat']))
presentation=(Path(sys.argv[1])/'Controllers/CSCloseFriendSessionPresentation.m').read_text()
(Path(sys.argv[2])/'SessionPresentationBody.h').write_text('\n'.join(line for line in presentation.splitlines() if not line.startswith('#import')))
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-undeclared-selector \
 -framework Foundation -I"$test_dir" -I"$project_dir/Controllers" \
 "$project_dir/Controllers/CSGroupProjection.m" "$project_dir/Controllers/WESessionTabItem.m" \
 "$project_dir/Controllers/CSGroupInvocationMapper.m" "$project_dir/Controllers/CSGroupNativeBridge.m" "$project_dir/Controllers/CSGroupIndexScope.m" \
 "$project_dir/Controllers/CSCloseFriendPolicy.m" "$project_dir/Controllers/CSCloseFriendSignatures.m" \
 "$project_dir/Tests/CloseFriendSessionTests.m" -o "$test_dir/session-tests"
"$test_dir/session-tests"
if [[ "${1:-}" != "--navigation-ios" ]]; then
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -framework Foundation -framework CoreGraphics \
 -I"$test_dir" -I"$project_dir/Controllers" "$project_dir/Controllers/CSGroupProjection.m" \
 "$project_dir/Controllers/WESessionTabItem.m" "$project_dir/Controllers/CSCloseFriendPolicy.m" \
 "$project_dir/Tests/CloseFriendSessionPresentationTests.m" -o "$test_dir/presentation-tests"
"$test_dir/presentation-tests"
fi
if [[ "${1:-}" == "--ios" || "${1:-}" == "--navigation-ios" ]]; then
  theos_dir=${THEOS:-/Users/zhangshichao/theos}
  sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
  perl "$theos_dir/vendor/logos/bin/logos.pl" "$project_dir/Hooks/SessionGroupHooks.xm" > "$test_dir/SessionGroupHooks.mm"
  for arch in arm64 arm64e; do
    flags=(-target "$arch-apple-ios15.0" -isysroot "$sdk_dir" -fobjc-arc -fblocks -Wno-deprecated-declarations -Wno-unused-parameter -I"$project_dir/Controllers" -I"$project_dir/Headers" -I"$project_dir/Hooks" -I"$theos_dir/vendor/include" -F"$theos_dir/vendor/lib")
    if [[ "${1:-}" == "--ios" ]]; then
    for source in CSGroupProjection CSGroupNativeBridge CSGroupListAdapter CSCloseFriendSessionPresentation; do
      xcrun --sdk iphoneos clang "${flags[@]}" -Wall -Wextra -Werror -c "$project_dir/Controllers/$source.m" -o "$test_dir/$source.$arch.o"
    done
    fi
    xcrun --sdk iphoneos clang++ "${flags[@]}" -std=c++17 -Werror -c "$test_dir/SessionGroupHooks.mm" -o "$test_dir/session-hooks.$arch.o"
  done
  if [[ "${1:-}" == "--navigation-ios" ]]; then
    printf 'Close-friend navigation iOS: arm64 + arm64e hook objects compiled\n'
  else
    printf 'Close-friend session iOS: arm64 + arm64e source objects compiled\n'
  fi
fi
