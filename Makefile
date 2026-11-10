export DEBUG=0
export FINALPACKAGE=1
export THEOS=/Users/zhangshichao/theos

# 项目名称
TWEAK_NAME = WeChatImprove

# 根据 SCHEME 变量的值设置 Theos 包的方案和安装路径。
ifeq ($(SCHEME),roothide)
    export THEOS_PACKAGE_SCHEME = roothide
else ifeq ($(SCHEME),rootless)
    export THEOS_PACKAGE_SCHEME = rootless
else ifeq ($(SCHEME),rootful)
    # Rootful is Theos' default scheme (there is no "rootful" module).
    export THEOS_PACKAGE_SCHEME =
endif

# 目标设备最低版本
export ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

# 源文件
WeChatImprove_FILES = Controllers/CSPluginStorageStartup.m \
                     $(wildcard Hooks/*.xm) \
                     $(filter-out Controllers/CSPluginStorageStartup.m,$(wildcard Controllers/*.m)) \

# 编译标志
WeChatImprove_CFLAGS = -fobjc-arc \
                       -I$(THEOS_PROJECT_DIR)/Headers \
                       -I$(THEOS_PROJECT_DIR)/Hooks \
                       -I$(THEOS_PROJECT_DIR)/Controllers \
                       -Wno-error \

# 框架依赖
WeChatImprove_FRAMEWORKS = UIKit Foundation AVFoundation QuartzCore LocalAuthentication Security ImageIO CoreGraphics UniformTypeIdentifiers UserNotifications CoreMotion PhotosUI

# 包含 Theos make 系统
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

clean::
	@echo -e "\033[31m==>\033[0m 正在清理......"
	@rm -rf .theos packages

after-package::
	@echo -e "\033[32m==>\033[0m 编译完成！安装包目录：$(THEOS_PACKAGE_DIR)"
	@echo -e "\033[32m==>\033[0m 请使用设备当前注入环境对应的包管理器安装"
