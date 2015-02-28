ALARM_PATH := $(TARGET_OUT)/media/audio/alarms

LOCAL_PATH := $(call my-dir)

define build-ridon-alarms
include $$(CLEAR_VARS)
LOCAL_MODULE := ridon-alarms-$(1)
LOCAL_MODULE_STEM := $(1)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(ALARM_PATH)
LOCAL_SRC_FILES := $(1) 
include $$(BUILD_PREBUILT)
endef

define all-alarm-files
$(patsubst ./%,%, \
	$(shell cd $(LOCAL_PATH); \
		find . -type f -name '*.ogg') \
	)
endef

alarms := $(all-alarm-files)
$(foreach alarm,$(alarms),$(eval $(call build-ridon-alarms,$(alarm))))
alarms_target := $(addprefix $(ALARM_PATH)/,$(foreach alarm,$(alarms),$(alarm)))
$(info [$(alarms_target)])
.PHONY: alarms_target
ridon_alarms: $(alarms_target)

ALL_MODULES.ridon_alarms.INSTALLED := $(alarms_target)
