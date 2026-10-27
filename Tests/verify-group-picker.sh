#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
CS_TEST_GROUP_PICKER=1 bash "$project_dir/Tests/verify-native-contact-picker.sh"
