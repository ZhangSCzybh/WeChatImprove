#!/bin/bash
# Requirement regressions: run the same real-body host probe with additional
# identified-active-user invariants. Measurement-only runner remains separate.
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
export PROBE_REQUIRE_ACTIVE_IDENTITY=1
exec bash "$project_dir/Tests/probe-group-return-banner.sh" "$@"
