#!/bin/sh
# Merge the Redbull production configuration on top of redbull_defconfig.
# Intended for CI/production builds; the source defconfig is left untouched.
set -eu

ARCH=${ARCH:-arm64}
CONFIG_DIR="arch/${ARCH}/configs"
BASE="${CONFIG_DIR}/redbull_defconfig"
FRAGMENT="${CONFIG_DIR}/redbull_production.fragment"
OUT=${OUT:-out}

[ -f "$BASE" ] || { echo "Missing $BASE" >&2; exit 1; }
[ -f "$FRAGMENT" ] || { echo "Missing $FRAGMENT" >&2; exit 1; }

mkdir -p "$OUT"
cp "$BASE" "$OUT/.config"

# Kernel 4.19's merge_config.sh handles fragments and preserves dependency
# resolution through the normal olddefconfig pass.
scripts/kconfig/merge_config.sh -m -O "$OUT" "$OUT/.config" "$FRAGMENT"
make O="$OUT" ARCH="$ARCH" olddefconfig

echo "Production configuration merged: $OUT/.config"
