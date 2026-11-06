# GitHub Integration — NIU Mobility Studio 1.0.2

## Что умеет интеграция

- OAuth Device Authorization Flow: вход через GitHub в системном браузере без ручного создания Personal Access Token.
- Хранение выданного OAuth access token в Android Keystore через `SecureSecretStore`.
- Определение текущего пользователя и получение списка доступных репозиториев.
- Создание private-репозитория.
- Просмотр/выбор веток.
- Pull: загрузка содержимого выбранной ветки в активный локальный Workspace.
- Push: публикация снимка Workspace одним Git commit через Git Database API; отсутствующие локально tracked-файлы удаляются в коммите.
- Запуск GitHub Actions, получение статуса и скачивание APK-артефакта.
- Установка APK только через штатный Android Package Installer с системным подтверждением.

## Однократная настройка OAuth App

GitHub требует, чтобы владелец приложения зарегистрировал OAuth App и включил Device Flow. В репозитории нельзя безопасно выдумать Client ID: это идентификатор зарегистрированного приложения, а не секрет.

1. Откройте GitHub → Settings → Developer settings → OAuth Apps → New OAuth App.
2. Application name: `NIU Mobility Studio`.
3. Homepage URL: публичная страница проекта/репозитория NIU.
4. Authorization callback URL для Device Flow не используется; задайте публичную страницу проекта, если форма требует значение.
5. Сохраните OAuth App и включите **Enable Device Flow** в настройках приложения.
6. Скопируйте **Client ID** (не Client Secret) в NIU Mobility Studio → Code Workspace → GitHub Build Center.
7. Нажмите «Войти через GitHub»: приложение запросит Device Code и автоматически откроет официальный `github.com/login/device`. Введите показанный одноразовый код и подтвердите запрошенные права.

OAuth App запрашивает scopes `repo`, `workflow`, `read:user`. `repo` даёт доступ на чтение/запись к репозиториям, включая private; `workflow` позволяет обновлять и запускать workflow-файлы. Не подтверждайте запрос, если не доверяете приложению. Токен хранится в Android Keystore и не записывается в проект.

> Для общедоступного коммерческого приложения GitHub рекомендует GitHub App с минимальными granular permissions и короткоживущими user tokens. Device Flow здесь выбран для простой авторизации на устройстве; перед широким публичным релизом следует перевести интеграцию на GitHub App authorization с PKCE и ограничением репозиториев. Не встраивайте Client Secret в APK.

## Публикация и сборка

1. Авторизуйтесь и выберите репозиторий или создайте private-репозиторий.
2. Выберите ветку и нажмите `PUSH · ОТПРАВИТЬ + СОБРАТЬ`.
3. NIU формирует Git blobs/tree/commit и обновляет ссылку выбранной ветки без force push.
4. Приложение запускает `.github/workflows/android-build.yml` через `workflow_dispatch`.
5. Используйте `ПРОВЕРИТЬ СБОРКУ`; после завершения скачайте APK-артефакт.

Перед публикацией применяется фильтр секретов и исключаются `.git`, `.gradle`, `build`, `local.properties`, keystore-файлы, `.env*`, ключи и APK. Проверьте проект перед отправкой: никакой автоматический сканер не гарантирует обнаружение всех секретов.

Pull пишет содержимое выбранной ветки в текущий Workspace и может перезаписать файлы с совпадающими путями. Сохраните локальные изменения или экспортируйте ZIP до Pull.

## Разрешения и ограничения

- OAuth App scope `repo` широк: доступ ограничен правами самого пользователя, но охватывает его доступные репозитории. Для минимальных прав используйте GitHub App.
- Лимиты текущего клиента: до 2 000 файлов, 40 MiB суммарно, 5 MiB на файл при публикации/импорте.
- GitHub REST Git Database API используется для push; это не полноценный локальный Git CLI. Нет интерактивного rebase, cherry-pick, stash и merge-conflict editor.
- Pull пропускает symlinks и submodules.
- Если workflow выключен политиками организации или пользователь не имеет прав Actions, GitHub вернёт ошибку.
- Выход из NIU удаляет локально сохранённый токен. Для полного отзыва доступа удалите NIU Mobility Studio в GitHub → Settings → Applications → Authorized OAuth Apps.


## Важное про вход одной кнопкой

OAuth App Client ID — публичный идентификатор приложения, не пароль, не access token и не Client Secret. Владелец NIU Mobility Studio должен один раз зарегистрировать OAuth App и включить Device Flow; без зарегистрированного Client ID GitHub не может определить, какому приложению выдавать Device Code. После сохранения Client ID пользователь запускает вход кнопкой и подтверждает его на официальной странице GitHub. Access token хранится локально в Android Keystore.
