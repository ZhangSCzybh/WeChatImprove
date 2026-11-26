#!/bin/sh
set -eu
cd /Users/zhangshichao/Documents/Workspace/WeChatImprove
make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootful _THEOS_LOCAL_DATA_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-3.0-1-h5ifj62u/build-rootful _THEOS_SWIFT_AUXILIARY_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-3.0-1-h5ifj62u/swift-rootful THEOS_PACKAGE_DIR=/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/3.0-1 PACKAGE_VERSION=3.0-1 PACKAGE_BUILDNAME= DEBUG=0 FINALPACKAGE=1 KEEP_LOGOS_INTERMEDIATES=1
