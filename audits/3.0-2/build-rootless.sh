#!/bin/bash
set -euo pipefail
cd /Users/zhangshichao/Documents/Workspace/WeChatImprove
exec make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootless _THEOS_LOCAL_DATA_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-3.0-2-40vcr2oe/build-rootless _THEOS_SWIFT_AUXILIARY_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-3.0-2-40vcr2oe/swift-rootless THEOS_PACKAGE_DIR=/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/3.0-2 PACKAGE_VERSION=3.0-2 PACKAGE_BUILDNAME= DEBUG=0 FINALPACKAGE=1 KEEP_LOGOS_INTERMEDIATES=1
