TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard

THEOS_DEVICE_IP = 192.168.0.52

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RemoteControl

RemoteControl_FILES = Tweak.xm TouchSimulator.xm WebSocketClient.xm Position.xm
RemoteControl_CFLAGS = -fobjc-arc
RemoteControl_PRIVATE_FRAMEWORKS = IOKit
RemoteControl_CODESIGN_FLAGS = -Sent.xml

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	ldid -Sent.xml $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/RemoteControl.dylib

clean::
	rm -rf .theos
	rm -rf packages

clean_build:
	make clean
	make

clean_build_package:
	make clean
	make package

clean_build_install:
	make clean
	make package install
