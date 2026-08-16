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

# Always start from the actual redbull_defconfig target. This avoids treating
# the defconfig text as an already-resolved .config and lets Kconfig establish
# the correct dependency baseline before the production fragment is merged.
make O="$OUT" ARCH="$ARCH" redbull_defconfig

# Kernel 4.19's merge_config.sh handles fragments and then olddefconfig
# resolves dependencies introduced by the production settings.
scripts/kconfig/merge_config.sh -m -O "$OUT" "$OUT/.config" "$FRAGMENT"
make O="$OUT" ARCH="$ARCH" olddefconfig

echo "Production configuration merged: $OUT/.config"
