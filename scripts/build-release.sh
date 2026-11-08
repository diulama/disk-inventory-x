#!/usr/bin/env bash
# Builds a universal (arm64 + x86_64) Release app and packages it as a zip.
#
# Usage: scripts/build-release.sh [output-dir]
#
# The app is ad-hoc signed ("Sign to Run Locally"). Set CODE_SIGN_IDENTITY and
# DEVELOPMENT_TEAM in the environment to sign with a Developer ID instead.
set -euo pipefail

cd "$(dirname "$0")/.."

PROJECT="Disk Inventory X.xcodeproj"
SCHEME="Disk Inventory X"
APP_NAME="Disk Inventory X.app"
OUT_DIR="${1:-build/release}"
DERIVED_DATA="build/DerivedData"

signing_args=()
if [[ -n "${CODE_SIGN_IDENTITY:-}" ]]; then
  signing_args+=("CODE_SIGN_IDENTITY=${CODE_SIGN_IDENTITY}")
fi
if [[ -n "${DEVELOPMENT_TEAM:-}" ]]; then
  signing_args+=("DEVELOPMENT_TEAM=${DEVELOPMENT_TEAM}")
fi

xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination "generic/platform=macOS" \
  -derivedDataPath "$DERIVED_DATA" \
  ONLY_ACTIVE_ARCH=NO \
  ${signing_args[@]+"${signing_args[@]}"} \
  build

APP_PATH="$DERIVED_DATA/Build/Products/Release/$APP_NAME"
VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "$APP_PATH/Contents/Info.plist")

mkdir -p "$OUT_DIR"
ZIP_PATH="$OUT_DIR/Disk-Inventory-X-${VERSION}.zip"
rm -f "$ZIP_PATH"
ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$ZIP_PATH"

echo "Architectures: $(lipo -archs "$APP_PATH/Contents/MacOS/Disk Inventory X")"
echo "Packaged: $ZIP_PATH"
