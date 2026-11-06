# NIU Mobility Studio 1.2.1 — OAuth server diagnostics

## Изменения
- Сохранён текущий OAuth v3 GET-контракт (account, app_id, grant_type, MD5 password, scope).
- При серверном отказе `outdated` теперь логируются безопасные диагностические поля: `status`, `desc`, `trace`, имена полей `data`.
- Секреты, пароль, digest, токены и полное тело ответа не записываются.

## Почему это ещё не гарантированное исправление
Официальный NIU APK 5.12.2 содержит `clientIdentifier`, `encodedPassword` и заголовки `x-jg-sign`, `x-jg-timestamp`, `x-jg-version`. Наличие имён не раскрывает алгоритм и значения. Неизвестные подписи и идентификаторы намеренно не подставляются наугад.

Эта версия предназначена для получения точного server-side diagnostic (`desc` + `trace`) и не подтверждена реальным входом или Android-сборкой.
