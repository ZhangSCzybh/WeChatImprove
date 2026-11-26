#!/bin/bash
set -e
cd /Users/zhangshichao/Documents/Workspace/WeChatImprove
make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootless _THEOS_LOCAL_DATA_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-2.9-11-beta03-r0upi346/build-rootless _THEOS_SWIFT_AUXILIARY_DIR=/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-2.9-11-beta03-r0upi346/swift-rootless THEOS_PACKAGE_DIR=/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/2.9-11-beta03 PACKAGE_VERSION=2.9-11-beta03 PACKAGE_BUILDNAME= DEBUG=0 FINALPACKAGE=1 KEEP_LOGOS_INTERMEDIATES=1 > /Users/zhangshichao/Documents/Workspace/WeChatImprove/audits/2.9-11-beta03/logs/build-rootless.log 2>&1
