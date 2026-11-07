#!/bin/bash
# Run from the Infinity X source root after repo sync.
set -e
cd "$(dirname "$0")/../.."
P=$(ls "$PWD"/.repo/local_manifests/patches/0001-*.patch)
if git -C build/make log --oneline -20 | grep -q "Skip GMS mainline release config"; then
  echo "build/make: GMS patch already applied"
else
  git -C build/make am "$P" && echo "build/make: GMS patch applied"
fi
