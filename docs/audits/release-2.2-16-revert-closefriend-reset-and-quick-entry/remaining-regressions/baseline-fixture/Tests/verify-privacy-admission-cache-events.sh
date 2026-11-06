#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
source_dir="${1:-$project_dir}"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-privacy-admission-events.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$source_dir" "$test_dir" "${ADMISSION_PROVENANCE_PATH:-}" <<'PY'
from pathlib import Path
import sys
project,source,output=map(Path,sys.argv[1:4]);provenance=sys.argv[4]
generator=(project/'Tests/verify-privacy-admission-cache.sh').read_text().split("<<'PY'\n",1)[1].split('\nPY\n',1)[0]
sys.argv=['extract-admission',str(source),str(output),provenance]
exec(compile(generator,str(project/'Tests/verify-privacy-admission-cache.sh'),'exec'),{'__name__':'admission_event_extractor'})
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-deprecated-declarations \
 -framework Foundation -framework Security -I"$test_dir" -I"$source_dir/Controllers" -I"$project_dir/Tests" \
 "$source_dir/Controllers/CSGroupProjection.m" "$source_dir/Controllers/WESessionTabItem.m" \
 "$source_dir/Controllers/CSGroupNativeBridge.m" "$source_dir/Controllers/CSGroupIndexScope.m" \
 "$source_dir/Controllers/CSCloseFriendPolicy.m" "$source_dir/Controllers/CSCloseFriendRuntime.m" \
 "$source_dir/Controllers/CSCloseFriendStore.m" "$source_dir/Controllers/CSCloseFriendCrypto.m" \
 "$source_dir/Controllers/CSPluginStorage.m" "$project_dir/Tests/PrivacyAdmissionCacheAdditionalTests.m" \
 -o "$test_dir/admission-event-tests"
"$test_dir/admission-event-tests"
