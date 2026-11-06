# NIU Mobility Studio 1.0.0 — release notes

**Продуктовая версия:** 1.0.0  
**Android versionCode:** 100  
**Application ID:** `com.niu.fxstudio`  
**minSdk / targetSdk / compileSdk:** 26 / 35 / 35

## Состав выпуска

- Адаптивная Android Compose оболочка с восстановлением последнего раздела.
- NIU FX workspace: BLE scanner, GATT explorer, последовательная очередь ATT, журнал диагностики.
- NFC Inspector без обхода защищённых секторов и извлечения ключей.
- Локальные инструменты персонализации дисплея и аудио; отправка неподтверждённых команд на скутер не имитируется.
- Code Workspace: локальный multi-file проект, вкладки, создание и редактирование текстовых файлов.
- Импорт исходного ZIP с защитой от Zip Slip, ограничением 5 000 файлов и 80 MiB распакованных данных.
- Экспорт всего локального workspace в ZIP.
- Хранение API credentials через AES-GCM с ключом в Android Keystore.
- AI Code Agent для OpenAI, Gemini и Anthropic: безопасное предложение редакции открытого файла с подтверждением перед применением.
- GitHub Build Center: публикация workspace в GitHub, запуск Actions, проверка статуса, загрузка Debug APK и системная установка после подтверждения.

## Редактирование и сборка приложения

Пользователь может импортировать ZIP с исходниками в Code Workspace, редактировать файлы и экспортировать проект. Это редактирование копии исходников в sandbox приложения. Android не позволяет приложению незаметно заменить собственный установленный APK или безопасно запускать произвольный Gradle build без JDK, Android SDK, build tools и управляемой среды выполнения.

Встроенный GitHub Build Center публикует workspace snapshot в заранее созданный репозиторий (Git Trees API), создаёт commit и запускает `.github/workflows/android-build.yml`. Workflow выполняет Kotlin compile, unit tests и `assembleDebug`; APK публикуется как Actions artifact. Приложение проверяет статус и скачивает APK. Для интеграции используется OAuth Device Flow; нужен Client ID зарегистрированного OAuth App с включённым Device Flow. Подробная настройка — `GITHUB_INTEGRATION_RU.md`. Подписание Release APK/AAB включается при наличии GitHub Actions Secrets: `NIU_RELEASE_KEYSTORE_BASE64`, `NIU_RELEASE_KEYSTORE_PASSWORD`, `NIU_RELEASE_KEY_ALIAS`, `NIU_RELEASE_KEY_PASSWORD`. Без этих секретов Release job пропускается. Keystore и пароли не входят в исходники.

AI Code Agent поддерживает запросы к OpenAI, Gemini и Anthropic через HTTPS. Он получает только путь, текст открытого файла и задачу пользователя. Он возвращает полную предложенную редакцию; запись происходит лишь после нажатия «Применить». Агент не запускает shell/Gradle, не имеет доступа к другим файлам и не может самостоятельно установить обновлённый APK.

## Ограничения 1.0.0

- Встроенный on-device Gradle/JDK/SDK не поставляется.
- Полный Git UI (diff/branch/merge), системный shell и signed plugin runtime не реализованы.
- AI Agent пока не умеет автономно планировать multi-file изменения, индексировать проект, исправлять ошибки сборки по логам или запускать команды.
- Подписанный sandbox plugin runtime не реализован.
- APK сборка/компиляция не подтверждены в среде подготовки архива; GitHub workflow и GitHub API интеграция добавлены, но требуют Client ID зарегистрированного OAuth App, собственного репозитория и успешного удалённого запуска.
- Подписанный release зависит от конфигурации четырёх пользовательских GitHub Secrets; без них создаётся только Debug APK.

## Проверка

Локально проверяются ZIP integrity, XML manifest parse, version metadata, workflow presence and source structure. Для Android compile/test/build запустите workflow или команды из `BUILD_STATUS_RU.md` на машине с JDK 17, Gradle 8.9 и Android SDK 35.
