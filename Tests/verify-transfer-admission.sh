#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
# Admission now shares the payment parser and lifecycle; keep this entry point.
exec bash "$project_dir/Tests/verify-payment-core.sh"
