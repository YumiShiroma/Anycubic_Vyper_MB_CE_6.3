#!/usr/bin/env bash
#
# Build one or all VYPER_BUILD_* variants and copy the binaries to dist/.
#
#   scripts/build_all.sh                 # all 14 variants
#   scripts/build_all.sh LA_JD_IS        # one variant
#   PIO=/path/to/pio scripts/build_all.sh CJ LA_JD_IS
#
set -euo pipefail

cd "$(dirname "$0")/.."

PIO="${PIO:-pio}"
ENV_NAME="${PIO_ENV:-STM32F103RET6_ac_tri_f1}"
OUT_DIR="${OUT_DIR:-dist}"
MAX_FLASH="${MAX_FLASH:-491520}" # 512 KiB minus the 32 KiB bootloader

CONFIG="Marlin/Configuration.h"
BACKUP="$(mktemp)"
cp "$CONFIG" "$BACKUP"
restore() {
  cp "$BACKUP" "$CONFIG"
  rm -f "$BACKUP"
}
trap restore EXIT

ALL_VARIANTS=(
  CJ CJ_IS LA_JD LA_CJ LA_JD_IS LA_CJ_IS
  LA_JD_T LA_CJ_T LA_JD_IS_T LA_CJ_IS_T
  LA_JD_TE LA_CJ_TE LA_JD_IS_TE LA_CJ_IS_TE
)

if [ "$#" -gt 0 ]; then
  VARIANTS=("$@")
else
  VARIANTS=("${ALL_VARIANTS[@]}")
fi

mkdir -p "$OUT_DIR"

for variant in "${VARIANTS[@]}"; do
  echo "=== Building $variant ==="
  python3 scripts/set_variant.py "$variant"
  "$PIO" run -e "$ENV_NAME"

  bin="$(ls -t ".pio/build/$ENV_NAME"/main_board_*.bin | head -n 1)"
  size="$(stat -c%s "$bin")"
  if [ "$size" -gt "$MAX_FLASH" ]; then
    echo "ERROR: $variant is $size bytes, over the $MAX_FLASH byte limit" >&2
    exit 1
  fi

  cp "$bin" "$OUT_DIR/main_board_${variant}.bin"
  printf 'OK  %-14s %7d bytes  (%d%% of %d)\n' \
    "$variant" "$size" "$((size * 100 / MAX_FLASH))" "$MAX_FLASH"
done

echo
echo "Binaries written to $OUT_DIR/"
