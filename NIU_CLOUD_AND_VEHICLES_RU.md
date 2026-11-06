# NIU Mobility Studio 1.0.4 — NIU Cloud и сохранённые устройства

## Мультиустройственный профиль

Приложение хранит отдельные карточки NIU в приватном хранилище Android (`niu_saved_vehicles`). Поля: SN, локальное имя, семейство/модель, VIN, BLE MAC-адрес и признак импорта из NIU Cloud. Выбранный скутер сохраняется отдельно. Название можно менять без изменения SN.

Добавление:
1. «Скутер» → «Добавить».
2. Считать QR камерой телефона или ввести SN вручную.
3. Указать локальное имя и сохранить.
4. Запустить BLE scan, выбрать обнаруженный NIU Link/устройство и привязать найденный BLE-адрес к активной карточке.
5. Нажать «Выбрать / BLE» для подключения к сохранённому адресу.

QR обрабатывается локально: приложение пытается извлечь SN из `SN:...`, JSON-поля `sn` или длинного буквенно-цифрового сегмента. QR может содержать иные данные; если SN не извлечён, пользователь вводит его вручную.

### Android Bluetooth bond

Сохранённая карточка и BLE MAC — это внутренняя запись NIU Mobility Studio. BLE MAC может быть приватным/ротационным адресом; если повторное соединение не удалось, выполните новый scan и обновите BLE-привязку. Это не тождественно Android Bluetooth bond. Кнопка `PAIR` запрашивает стандартное BLE-сопряжение Android через `createBond()` после явного нажатия пользователя. Не каждый NIU ECU предоставляет bonding; NIU app может использовать собственный BLE handshake без записи в системный список сопряжённых устройств. Успешное GATT-подключение не означает, что устройство обязано появиться в системном списке Bluetooth.

## NIU Cloud compatibility login (1.1.9)

Вход по email/логину и паролю переведён с устаревшего `appv2/login` на NIU OAuth v3:
- `GET {accountBase}/v3/api/oauth2/token`;
- query-поля: `account`, `app_id=niu_8xt1afu6`, `grant_type=password`, `password=MD5(UTF-8 password)`, `scope=base`;
- `POST {appApiBase}/motoinfo/list` с `token` header и `masterOnly=0`.

FK endpoints (`account-fk.niu.com` и `app-api-fk.niu.com`) подтверждаются публичной реализацией NIU в evcc. Ответ OAuth разбирается как `data.token.access_token`; поддержаны также строковый token и несколько совместимых вариантов структуры ответа. Логин и загрузка списка транспорта диагностируются раздельно: если OAuth вернул токен, но список не загрузился, сессия остаётся сохранённой, а UI сообщает об ошибке именно загрузки.

Регионы:
- GLOBAL: `account.niu.com` и `app-api.niu.com` (тот же OAuth-путь; требуется проверка на живом аккаунте этого региона);
- CHINA / FK: `account-fk.niu.com` и `app-api-fk.niu.com`.

**Ограничения и безопасность:**
- Это reverse-engineered совместимость, не официальный NIU SDK. NIU может менять API, обязательные параметры, региональную маршрутизацию, CAPTCHA/2FA и антибот-защиту.
- Пароль не сохраняется и не передаётся открытым текстом: UTF-8 MD5 вычисляется на устройстве, временный byte array очищается; запрос выполняется только по HTTPS. Session token сохраняется через AES-GCM / Android Keystore.
- `countryCode` не используется в OAuth v3; поле убрано из формы. Email, логин или телефон передаются как `account`.
- OAuth-токен и список транспорта — разные этапы. Успешная авторизация не гарантирует, что NIU разрешит список транспорта этому клиенту.
- Logout удаляет локальный токен; отдельная серверная ревокация не реализована.
- Импортируются только транспортные средства, уже привязанные к NIU account. Локальное добавление SN/QR не меняет серверное владение.
- Реальный вход на аккаунте пользователя из среды разработки проверить невозможно. Версия 1.1.9 обновляет протокол по опубликованной реализации, но успешный вход на конкретном аккаунте должен быть подтверждён запуском на устройстве.

## Источники

- NIU official support: QR code contains scooter SN; scan QR in app, then name the scooter; alternatively enter SN manually: https://niumobility.freshdesk.com/en/support/solutions/articles/43000527389-how-can-i-connect-my-niu-scooter-with-the-niu-app-
- NIU official support: KQi devices bind through Bluetooth flow: https://niumobility.freshdesk.com/en/support/solutions/articles/43000705989-how-do-i-bind-my-kick-scooter-in-the-app-
- BlueAndi NIU Cloud Connector API docs: https://github.com/BlueAndi/niu-cloud-connector/blob/master/doc/API.md
- Bonnee historical NIU App API: https://github.com/Bonnee/niu-app-api/blob/master/api.json

## Verification status

Static checks: manifest XML, Kotlin parser smoke-check, Gradle dependency declarations, JSON and ZIP integrity. No full Android build (Gradle/SDK unavailable), no live NIU login, no QR camera session, no scooter BLE connection and no Android bond test were performed in this environment.
