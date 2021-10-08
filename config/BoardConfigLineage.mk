include vendor/kasumi/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/kasumi/config/BoardConfigQcom.mk
endif

include vendor/kasumi/config/BoardConfigSoong.mk
