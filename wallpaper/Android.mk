ifeq ($(TARGET_SCREEN_WIDTH),)
    $(warning TARGET_SCREEN_WIDTH is not set, using default value: 1080)
    TARGET_SCREEN_WIDTH := 1080
endif
ifeq ($(TARGET_SCREEN_HEIGHT),)
    $(warning TARGET_SCREEN_HEIGHT is not set, using default value: 1920)
    TARGET_SCREEN_HEIGHT := 1920
endif

ifeq ($(shell command -v mogrify),)
	$(info **********************************************)
	$(info The boot animation could not be generated as)
	$(info ImageMagick is not installed in your system.)
	$(info $(space))
	$(info Please install ImageMagick from this website:)
	$(info https://imagemagick.org/script/binary-releases.php)
	$(info **********************************************)
	$(error stop)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := wallpaper-generator

WALLPAPER := $(shell vendor/asylum/wallpaper/generate-wallpaper.sh $(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT))
