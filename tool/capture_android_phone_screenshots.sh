#!/usr/bin/env bash
# Play Store phone screenshots from a connected Android phone (USB debugging).
# Does NOT use iOS simulator. Does NOT auto-start an emulator.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RAW_DIR="$ROOT/build/android_phone_screenshots"
OUT_DIR="$ROOT/assets/store_screenshots/phone"

export ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

mkdir -p "$RAW_DIR" "$OUT_DIR"

serial="$(adb devices | awk 'NR>1 && $2=="device" && $1 !~ /^emulator-/{print $1; exit}')"
if [[ -z "$serial" ]]; then
  echo "Physical Android phone not detected."
  echo ""
  echo "Please:"
  echo "  1. Connect your Android phone with USB cable"
  echo "  2. On phone: Settings > Developer options > USB debugging ON"
  echo "  3. Accept the 'Allow USB debugging' prompt on phone"
  echo "  4. Run: adb devices   (should show your phone as 'device')"
  echo "  5. Run this script again"
  exit 1
fi

echo "Using Android device: $serial"

cd "$ROOT"
flutter pub get
flutter test integration_test/store_screenshots_test.dart -d "$serial"

python3 "$ROOT/tool/process_android_screenshots.py" \
  "$ROOT/build/integration_test_screenshots" \
  "$OUT_DIR"

echo ""
echo "Android phone screenshots saved:"
ls -la "$OUT_DIR"
