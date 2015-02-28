ringtone_PATH := $(TARGET_OUT)/media/audio/ringtones

LOCAL_PATH := $(call my-dir)

define build-ridon-ringtones
include $$(CLEAR_VARS)
LOCAL_MODULE := ridon-ringtones-$(1)
LOCAL_MODULE_STEM := $(1)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(ringtone_PATH)
LOCAL_SRC_FILES := $(1) 
include $$(BUILD_PREBUILT)
endef

define all-ringtone-files
$(patsubst ./%,%, \
	$(shell cd $(LOCAL_PATH); \
		find . -type f -name '*.ogg') \
	)
endef

ringtones := $(all-ringtone-files)
$(foreach ringtone,$(ringtones),$(eval $(call build-ridon-ringtones,$(ringtone))))
ringtones_target := $(addprefix $(ringtone_PATH)/,$(foreach ringtone,$(ringtones),$(ringtone)))
$(info [$(ringtones_target)])
.PHONY: ringtones_target
ridon_ringtones: $(ringtones_target)

ALL_MODULES.ridon_ringtones.INSTALLED := $(ringtones_target)
