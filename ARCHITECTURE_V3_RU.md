# NIU Mobility Studio v3 — архитектурный статус

## Принцип
Local-first инженерная среда. Исходники пользователя остаются файлами в выбранном каталоге; Room предназначен для метаданных, индексов и истории, а не для хранения копий проекта. NIU SDK не зависит от Compose/UI.

## Реализовано в 0.15.0
- Code Workspace открывает и сохраняет один выбранный документ через Storage Access Framework; ZIP export содержит только текущий открытый документ и manifest note.
- `SecureSecretStore` использует AES/GCM/NoPadding и Android Keystore; API-ключи не записываются в открытом виде.
- Версия 0.15.0 / versionCode 17.
- Два Gradle-модуля сохранены: `:app` и `:niu-sdk`.
- Добавлены стабильные идентификаторы маршрутов в `navigation/AppDestination.kt`.
- Добавлена модель метаданных сессии Workspace (`WorkspaceSession`).
- Последний открытый раздел сохраняется в SharedPreferences и восстанавливается после перезапуска.
- Основная навигация адаптируется: bottom navigation до 600 dp, боковая навигация от 600 dp; на ширине от 1200 dp боковая панель получает подписи.
- GATT callback старой сессии игнорируются; ATT очередь продвигается только callback, соответствующим активному UUID.
- Используются новые callback Android 13+ с передачей снимка `byte[]`, сохранены legacy callback.
- Ручная запись в proprietary NIU command/auth candidate UUID заблокирована.

## Текущая архитектура и ограничения
`MainActivity.kt` пока остаётся крупным legacy composition root. Экраны ещё не вынесены все в самостоятельные `feature/*` пакеты, ViewModel/Repository слой не завершён. Это сознательный первый этап: не менять BLE/NFC бизнес-логику массовым переносом до успешной сборки и регрессионного тестирования.

## Следующие этапы v3
1. Разделить `MainActivity` на Activity, navigation host и отдельные feature screens.
2. Ввести ViewModel + StateFlow для Workspace, BLE, NFC и диагностики.
3. Расширить однофайловый SAF-редактор до Project Explorer с деревом каталогов, несколькими вкладками и persistable URI permissions.
4. Подключить AI Provider Manager к HTTPS API с streaming, лимитами разрешений и redaction; локальное хранение credentials через Android Keystore уже заложено.
5. Добавить ограниченный Terminal/Git runtime после проверки лицензий, размеров и sandboxing.
6. Build & Release: сначала диагностика локальных JDK/Gradle/SDK; сборка APK только при наличии полноценного локального Android toolchain.
7. Security: audit log, backup/restore с проверкой архива, декларативные плагины с проверкой подписи и allowlist API.
8. Device Laboratory: Logcat только в пределах доступных Android прав, Device Manager, crash import/analyzer.

## Безопасность NIU
- UUID/property не доказывают смысл команды.
- `8ec94e32`, `8ec94e33` и `99ea30e2` остаются proprietary candidate каналами; произвольная ручная запись в них блокируется.
- `UnknownPacketCodec` остаётся не реализованным до подтверждения framing/length/command/checksum/auth.
- Ни одна команда ECU/FOC/замок/сигнализация/OTA не должна быть активирована без проверки на заводском FX.
