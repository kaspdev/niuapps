@echo off
where gradle >nul 2>nul
if errorlevel 1 (
  echo Gradle не найден. Откройте проект в Android Studio либо установите Gradle.
  exit /b 2
)
gradle :app:assembleDebug
