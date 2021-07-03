# Inherit full common Lineage stuff
$(call inherit-product, vendor/materium/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/materium/overlay/dictionaries

$(call inherit-product, vendor/materium/config/telephony.mk)
