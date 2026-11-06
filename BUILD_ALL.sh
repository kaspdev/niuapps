#!/usr/bin/env bash
set -euo pipefail

if ! command -v gradle >/dev/null 2>&1; then
  echo "ERROR: Gradle 8.9+ is required. Install Gradle or run .github/workflows/android-build.yml in GitHub Actions." >&2
  exit 2
fi

# Build both distributions and run all available JVM unit tests.
gradle --no-daemon -PNIU_ADMIN_PUBLIC_KEY="${NIU_ADMIN_PUBLIC_KEY:-}" \
  :app:testFullDebugUnitTest \
  :app:testUserDebugUnitTest \
  :niu-sdk:testDebugUnitTest \
  :app:assembleFullDebug \
  :app:assembleUserDebug

FULL_APK="app/build/outputs/apk/full/debug/app-full-debug.apk"
USER_APK="app/build/outputs/apk/user/debug/app-user-debug.apk"
for artifact in "$FULL_APK" "$USER_APK"; do
  if [[ ! -s "$artifact" ]]; then
    echo "ERROR: Expected APK was not produced: $artifact" >&2
    exit 3
  fi
done

echo "Build complete:"
echo "  Full: $FULL_APK"
echo "  User: $USER_APK"
echo "  Admin console: встроена в Full APK"
