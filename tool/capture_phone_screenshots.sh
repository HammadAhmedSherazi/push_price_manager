#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEVICE="${SCREENSHOT_DEVICE:-emulator-5554}"
OUT_DIR="$ROOT/assets/store_screenshots/phone"
RAW_DIR="$ROOT/build/integration_test_screenshots"

cd "$ROOT"
flutter pub get

flutter test integration_test/store_screenshots_test.dart -d "$DEVICE" "$@"

mkdir -p "$OUT_DIR"
python3 "$ROOT/tool/process_phone_screenshots.py" "$RAW_DIR" "$OUT_DIR"

echo "Phone screenshots saved to: $OUT_DIR"
ls -la "$OUT_DIR"
