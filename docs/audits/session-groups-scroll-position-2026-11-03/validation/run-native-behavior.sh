#!/bin/bash
set -euo pipefail
validation_dir="$(cd "$(dirname "$0")" && pwd)"
project_dir="${WECHAT_VALIDATION_SOURCE_ROOT:-$(cd "$validation_dir/../../../.." && pwd)}"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-native-groups-validation.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$validation_dir/extract-production-bodies.py" "$project_dir" "$test_dir"
bridge_source="$project_dir/Controllers/CSGroupNativeBridge.m"
if [[ "${WECHAT_VALIDATION_IGNORE_STRUCTURE_PROOF:-0}" == 1 ]]; then
  python3 - "$bridge_source" "$test_dir/BridgeNegativeControl.m" <<'PY'
from pathlib import Path
import sys
source=Path(sys.argv[1]).read_text()
needle='BOOL strictStructure=namedChanges && (changes&CSGroupChangeStructure);'
assert source.count(needle)==1
Path(sys.argv[2]).write_text(source.replace(needle,'BOOL strictStructure=NO;'))
PY
  bridge_source="$test_dir/BridgeNegativeControl.m"
fi
cpu_apis="$(python3 -c 'import pathlib,sys; print(int("modelByUpdatingResult:" in pathlib.Path(sys.argv[1]).read_text()))' "$project_dir/Controllers/CSGroupNativeModel.h")"
selection_apis="$(python3 -c 'import pathlib,sys; print(int("modelBySelectingTabID:" in pathlib.Path(sys.argv[1]).read_text()))' "$project_dir/Controllers/CSGroupNativeModel.h")"
xcrun --sdk macosx clang -DCS_SELECTION_APIS="$selection_apis" -DCS_CPU_APIS="$cpu_apis" -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-undeclared-selector -Wno-incomplete-implementation \
  -framework Foundation -framework CoreGraphics -I"$test_dir" -I"$validation_dir" -I"$project_dir/Controllers" \
  "$project_dir/Controllers/CSGroupNativeModel.m" \
  "$project_dir/Controllers/CSGroupNativeSessionCoordinator.m" \
  "$bridge_source" \
  "$project_dir/Controllers/CSGroupProjection.m" \
  "$project_dir/Controllers/CSGroupInvocationMapper.m" \
  "$project_dir/Controllers/CSGroupIndexScope.m" \
  "$project_dir/Controllers/CSGroupPreferences.m" \
  "$project_dir/Controllers/WESessionTabItem.m" \
  "$project_dir/Controllers/CSCloseFriendPolicy.m" \
  "$project_dir/Controllers/CSCloseFriendSignatures.m" \
  "$validation_dir/NativeGroupBehaviorTests.m" -o "$test_dir/native-behavior"
"$test_dir/native-behavior"
