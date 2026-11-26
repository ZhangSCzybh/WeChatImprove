#!/bin/bash
set -e
cd /Users/zhangshichao/Documents/Workspace/WeChatImprove
make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootful _THEOS_LOCAL_DATA_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-2.9-11-beta04-n6j0_8g1/build-rootful _THEOS_SWIFT_AUXILIARY_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-2.9-11-beta04-n6j0_8g1/swift-rootful THEOS_PACKAGE_DIR=/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/2.9-11-beta04 PACKAGE_VERSION=2.9-11-beta04 PACKAGE_BUILDNAME= DEBUG=0 FINALPACKAGE=1 KEEP_LOGOS_INTERMEDIATES=1 > /Users/zhangshichao/Documents/Workspace/WeChatImprove/audits/2.9-11-beta04/logs/build-rootful.log 2>&1
