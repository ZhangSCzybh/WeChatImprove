#!/bin/bash
set -euo pipefail
audit_dir="$(cd "$(dirname "$0")" && pwd)"
project_dir="$(cd "$audit_dir/../../.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-payment-audit.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 "$audit_dir/extract-audit.py" "$project_dir" "$test_dir"
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -framework Foundation \
    -I"$test_dir" -I"$project_dir/Controllers" \
    "$audit_dir/PaymentBehaviorAudit.m" "$project_dir/Controllers/CSRedEnvelopParam.m" \
    "$project_dir/Controllers/CSRedEnvelopConfig.m" "$project_dir/Controllers/CSRedEnvelopParamQueue.m" \
    -o "$test_dir/payment-audit"
"$test_dir/payment-audit"
