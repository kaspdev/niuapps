# NIU Mobility Studio v3.0.0 — восстановленный исходный выпуск

## Что реально входит
- Android-приложение на Jetpack Compose, версия `3.0.0` / `versionCode 30`.
- Адаптивная навигация: нижняя на телефоне, боковая на широких экранах; последний раздел сохраняется.
- Существующие экраны управления, профиля, связи, BLE/GATT Explorer, NFC Inspector, диагностики, дисплея, музыки, звуков, AI diagnostic handoff и Code Workspace.
- BLE ATT queue, read/notify-инструменты и защитные ограничения для неподтверждённых proprietary NIU команд.
- Локальное AES-GCM хранилище секретов с ключом в Android Keystore.
- Code Workspace: открытие/сохранение внешнего документа через SAF, локальная приватная папка проекта, создание и переключение файловых вкладок, редактирование и сохранение локальных файлов.
- Экспорт диагностического отчёта; MAC-адреса и секретоподобные значения маскируются.

## Ограничения, которые не маскируются под готовность
- Встроенный AI provider runtime/streaming отсутствует. Ключи OpenAI/Gemini/Anthropic можно зашифрованно хранить, но сетевой чат не подключён.
- Полноценные Git operations, системный терминал, signed plugin sandbox/runtime, Android SDK/Gradle on-device builder и release-signing workflow не реализованы.
- Code Workspace пока не является полноценной IDE: нет Kotlin/Java language server, syntax highlighting, refactoring, diagnostics, nested project import/export или полноценной файловой системы с каталогами в UI.
- Logcat/Device Manager не имеют привилегированного системного доступа; доступны только функции приложения и Android API в рамках разрешений.
- BLE proprietary control payloads не включены без подтверждённой спецификации и авторизации. UUID сам по себе не доказывает формат команды.
- Передача пользовательских обоев/звуков в приборную панель не включена без подтверждённого протокола.

## Проверки
- ZIP целостность проверена после упаковки.
- Android manifest XML разобран XML-парсером.
- Исходный код и Gradle-конфигурация проверены статически.
- `gradle :app:compileDebugKotlin`, unit tests и `assembleDebug` не выполнены: в среде подготовки отсутствуют Gradle и Android SDK. APK не включён, сборка не объявляется успешной.

## Сборка
Требуется JDK 17, Android SDK Platform 35 и Gradle 8.9 с Android Gradle Plugin 8.7.3. Откройте каталог проекта в Android Studio и выполните:

```bash
gradle :app:compileDebugKotlin :app:testDebugUnitTest :niu-sdk:testDebugUnitTest :app:assembleDebug
```

Debug APK при успешной сборке появится в `app/build/outputs/apk/debug/`. Для распространения создайте отдельный release build и подпишите его собственным ключом. Не храните ключ подписи в репозитории.
