include vendor/materium/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/materium/config/BoardConfigQcom.mk
endif

include vendor/materium/config/BoardConfigSoong.mk
