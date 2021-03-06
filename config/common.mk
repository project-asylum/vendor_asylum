PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/asylum/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/asylum/prebuilt/common/bin/50-asylum.sh:system/addon.d/50-asylum.sh \
    vendor/asylum/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/asylum/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/asylum/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/asylum/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# asylum-specific init file
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/etc/init.local.rc:root/init.asylum.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/asylum/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Fix Dialer
#PRODUCT_COPY_FILES +=  \
#    vendor/asylum/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# asylum-specific startup services
PRODUCT_COPY_FILES += \
    vendor/asylum/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/asylum/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/asylum/prebuilt/common/bin/sysinit:system/bin/sysinit

# Disable boot jars check
SKIP_BOOT_JARS_CHECK := true

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    su

# Asylum packages
PRODUCT_PACKAGES += \
    SystemUIAsylum \
    AsylumSettingsProvider

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    BluetoothExt \
    Launcher3Dark


# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g


PRODUCT_PACKAGES += \
    charger_res_images

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGES += \
    AndroidDarkThemeOverlay \
    SettingsDarkThemeOverlay

PRODUCT_PACKAGE_OVERLAYS += vendor/asylum/overlay/common

# Boot animation include
PRODUCT_PACKAGES += bootanimation.zip wallpaper-generator

# Versioning System
# asylum first version.
PRODUCT_VERSION_MAJOR = 9
PRODUCT_VERSION_MINOR = Alpha
PRODUCT_VERSION_MAINTENANCE = 1.0
ASYLUM_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
ifdef ASYLUM_BUILD_EXTRA
    ASYLUM_POSTFIX := -$(ASYLUM_BUILD_EXTRA)
endif

ifndef ASYLUM_BUILD_TYPE
    ASYLUM_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
ASYLUM_VERSION := Asylum-$(ASYLUM_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(ASYLUM_BUILD_TYPE)$(ASYLUM_POSTFIX)
ASYLUM_MOD_VERSION := Asylum-$(ASYLUM_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(ASYLUM_BUILD_TYPE)$(ASYLUM_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    asylum.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.asylum.version=$(ASYLUM_VERSION) \
    ro.modversion=$(ASYLUM_MOD_VERSION) \
    ro.asylum.buildtype=$(ASYLUM_BUILD_TYPE)

# Google sounds
include vendor/asylum/google/GoogleAudio.mk

EXTENDED_POST_PROCESS_PROPS := vendor/asylum/tools/asylum_process_props.py
