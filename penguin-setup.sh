#!/bin/bash
# Run from the Penguin OS source root after syncing, before building cheetah or panther.
set -e
for dev in cheetah panther; do
  mkdir -p vendor/aospa/products/$dev
  cat > vendor/aospa/products/$dev/beans.xml <<'XML'
<?xml version='1.0' encoding='utf-8'?>
<!-- Dependencies are provided by .repo/local_manifests/cheetah.xml -->
<manifest>
</manifest>
XML
done
# Hide Qualcomm-only repos from Soong (Pixel 7/7 Pro are Tensor)
for d in vendor/qcom/common \
         vendor/qcom/opensource/data-ipa-cfg-mgr \
         vendor/qcom/opensource/data-ipa-cfg-mgr-legacy \
         vendor/qcom/opensource/dataservices \
         vendor/qcom/opensource/recovery-ext \
         vendor/qcom/opensource/thermal-hal \
         hardware/qcom/bootctrl \
         hardware/google/pixel/touch; do
  [ -d "$d" ] && touch "$d/.find-ignore"
done
rm -rf out/.module_paths
echo "Penguin OS cheetah setup done."
