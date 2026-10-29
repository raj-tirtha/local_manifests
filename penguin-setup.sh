#!/bin/bash
# Run from the Penguin OS source root after syncing, before building cheetah.
set -e
mkdir -p vendor/aospa/products/cheetah
cat > vendor/aospa/products/cheetah/beans.xml <<'XML'
<?xml version='1.0' encoding='utf-8'?>
<!-- Dependencies are provided by .repo/local_manifests/cheetah.xml -->
<manifest>
</manifest>
XML
# Hide Qualcomm-only repos from Soong (cheetah is Tensor)
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
