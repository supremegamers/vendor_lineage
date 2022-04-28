# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
# Copyright (C) 2021,2022 Beru Shinsetsu (On behalf of Project Kasumi)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# Lineage OTA update package

LINEAGE_TARGET_PACKAGE := $(PRODUCT_OUT)/Kasumi-$(LINEAGE_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: bandori
ifeq ($(LINEAGE_BUILDTYPE),OFFICIAL)
# This build is marked as official and requires signing.
# TODO: Unify the process inside a separate makefile/shell script and call it instead.
bandori: $(INTERNAL_OTA_PACKAGE_TARGET) otatools target-files-package
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(LINEAGE_TARGET_PACKAGE)
	$(hide) mv $(LINEAGE_TARGET_PACKAGE) $(LINEAGE_TARGET_PACKAGE).unsigned
	$(hide) $(HOST_OUT)/bin/sign_target_files_apks -o -d vendor/priv $(PRODUCT_OUT)/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $(PRODUCT_OUT)/signed-target_files.zip >&2
	$(hide) $(HOST_OUT)/bin/ota_from_target_files -k vendor/priv/releasekey --block --backup=true $(PRODUCT_OUT)/signed-target_files.zip $(LINEAGE_TARGET_PACKAGE) >&2
	$(hide) $(MD5) $(LINEAGE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_PACKAGE).md5sum
	$(hide) $(SHA256) $(LINEAGE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_PACKAGE).sha256sum
	@echo "//          Project Kasumi          //" >&2
	@echo "// PoPiPa, PiPoPa, PoPiPaPaPiPoPa~! //" >&2
	@echo "" >&2
	@echo "Package Complete: $(LINEAGE_TARGET_PACKAGE)" >&2
	@echo "" >&2
	@echo "To get started, get your custom recovery up and slap this ROM in!" >&2
	@echo "Based on Project Materium, brought to you by Yuki (@AITEx64) and Beru Shinsetsu (@WindowZ414)." >&2
else
# Builds that aren't marked as official aren't required to be signed.
bandori: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(LINEAGE_TARGET_PACKAGE)
	$(hide) $(MD5) $(LINEAGE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_PACKAGE).md5sum
	$(hide) $(SHA256) $(LINEAGE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_PACKAGE).sha256sum
	@echo "//          Project Kasumi          //" >&2
	@echo "// PoPiPa, PiPoPa, PoPiPaPaPiPoPa~! //" >&2
	@echo "" >&2
	@echo "Package Complete: $(LINEAGE_TARGET_PACKAGE)" >&2
	@echo "" >&2
	@echo "To get started, get your custom recovery up and slap this ROM in!" >&2
	@echo "Based on Project Materium, brought to you by Yuki (@AITEx64) and Beru Shinsetsu (@WindowZ414)." >&2
endif
