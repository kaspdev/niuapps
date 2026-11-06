#!/usr/bin/env bash
set -euo pipefail
if ! command -v gradle >/dev/null 2>&1; then
  echo "Gradle не найден. Откройте проект в Android Studio либо установите Gradle." >&2
  exit 2
fi
gradle :app:assembleDebug
