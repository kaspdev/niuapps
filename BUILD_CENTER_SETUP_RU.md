# NIU Mobility Studio 1.0.2 — GitHub Build Center и AI handoff

## 1. Подготовка репозитория

1. Создайте GitHub repository и начальную ветку `main` (например, включите README при создании).
2. В Code Workspace импортируйте архив исходников NIU Mobility Studio. Импортёр распознаёт оболочку `NIU_Mobility_Studio/` и переносит файлы проекта в корень workspace.
3. Убедитесь, что в корне workspace присутствуют `settings.gradle.kts`, `app/`, `niu-sdk/` и `.github/workflows/android-build.yml`.

## 2. Авторизация GitHub прямо в приложении

NIU использует OAuth Device Authorization Flow: пользователь подтверждает доступ на официальной странице GitHub, а приложение получает токен без ручного ввода Personal Access Token.

Однократная настройка OAuth App:

1. GitHub → Settings → Developer settings → OAuth Apps → New OAuth App.
2. Название: `NIU Mobility Studio`; Homepage URL — публичная страница проекта.
3. В настройках зарегистрированного OAuth App включите **Enable Device Flow**.
4. Скопируйте **Client ID** (не Client Secret) в поле `GitHub OAuth App · Client ID` в NIU Mobility Studio.
5. Нажмите `Войти через GitHub`, откройте `github.com/login/device`, введите показанный одноразовый код и подтвердите доступ.

NIU запрашивает scopes `repo`, `workflow`, `read:user`. `repo` позволяет работать с доступными пользователю репозиториями, в том числе private; `workflow` нужен для отправки workflow-файлов и запуска Actions. Выдавайте эти права только приложению, которому доверяете. Токен хранится в Android Keystore. Client ID не является секретом; Client Secret в APK не добавляется.

После входа доступны:

- список репозиториев пользователя;
- создание private-репозитория;
- список и выбор веток;
- `PULL · ЗАГРУЗИТЬ` — загрузка выбранной ветки в активный Workspace;
- `PUSH · ОТПРАВИТЬ + СОБРАТЬ` — один commit снимка Workspace и запуск workflow;
- проверка Actions, загрузка APK и передача Android Installer.

**Внимание:** Pull может перезаписать локальные файлы с теми же путями. Перед Pull сохраните изменения или экспортируйте ZIP. Push формирует commit-манифест и удаляет tracked-файлы, которые отсутствуют в локальном Workspace.

Подробности OAuth, scopes и ограничения описаны в `GITHUB_INTEGRATION_RU.md`.

## 3. Подписание Release APK/AAB

В GitHub repository → Settings → Secrets and variables → Actions добавьте:

- `NIU_RELEASE_KEYSTORE_BASE64` — содержимое keystore в Base64.
- `NIU_RELEASE_KEYSTORE_PASSWORD`.
- `NIU_RELEASE_KEY_ALIAS`.
- `NIU_RELEASE_KEY_PASSWORD`.

При наличии всех четырёх секретов workflow дополнительно собирает Release APK и AAB и загружает artifact `NIU-Mobility-Studio-1.0.7-release`. Без них собирается только Debug APK. Не помещайте keystore в workspace.

## 4. Вход в ChatGPT и передача материалов

В версии 1.0.2 кнопка `Войти в ChatGPT` открывает официальный экран входа. Пользователь авторизуется у провайдера. Это не передаёт сессию ChatGPT приложению: у OpenAI нет публичного универсального OAuth grant для использования подписки ChatGPT как API третьим Android-приложением.

Кнопки `Передать открытый файл в AI` и `Передать доказательства в AI` вызывают системный Android chooser. Пользователь сам выбирает ChatGPT или другой AI-клиент и подтверждает передачу. Перед отправкой проверьте исходник на токены, пароли, ключи подписи и персональные данные.

Для встроенного AI без API-ключа нужен собственный HTTPS backend с OAuth-сессией пользователя, rate limiting, журналированием без секретов и серверным API-доступом к модели. Backend в проекте не развёрнут, поэтому приложение не показывает ложный статус «AI подключён».

## 5. Ограничения и безопасность

- Для входа нужен зарегистрированный OAuth App Client ID с включённым Device Flow; приложение не содержит общего Client Secret.
- CI собирает проект на GitHub-hosted runner, не локально на Android устройстве.
- GitHub REST Git Database API используется для commit/push/pull; это не полноценный локальный Git CLI и не поддерживает rebase/cherry-pick/stash/merge-conflict UI.
- Перед отправкой проверяйте diff/изменения и не добавляйте в workspace реальные ключи, пароли, сертификаты и пользовательские данные.
- AI-код может содержать ошибки. Успешная генерация не означает успешную компиляцию; ориентируйтесь на реальный статус workflow.
- APK с другим signing certificate не сможет обновить уже установленное приложение с прежней подписью.
