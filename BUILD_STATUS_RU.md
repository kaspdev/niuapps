# Build status — 1.2.5

- Source archive derived from 1.2.4_NAV_MANIFEST_FIX.
- Version: 1.2.5 / versionCode 125.
- ZIP integrity: checked with `unzip -t` after packaging.
- Android Gradle build: not run; Gradle wrapper is absent and Gradle is not installed in the build environment.
- Device validation: not run.
- NIU Cloud login: still blocked by server response `status=400`, `App version is too outdated`; no successful login is claimed.

## Дополнение 1.2.5 — mdpaste.ru
- В журнал событий добавлена подготовка Markdown-отчёта (последние 500 событий) и ручная передача через буфер обмена на `https://mdpaste.ru/`.
- Перед копированием запрашивается подтверждение; чувствительные значения повторно маскируются.
- Автоматический HTTP upload не реализован: документированный API mdpaste.ru не подтверждён. Публикацию пользователь выполняет вручную на сайте.
- Добавлены unit-тесты для redaction. Полная Android-сборка для этого дополнения не запускалась: Gradle и Android SDK в среде отсутствуют.
