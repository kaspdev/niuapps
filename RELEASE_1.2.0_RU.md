# NIU Mobility Studio 1.2.0 — NIU Cloud OAuth diagnostics

## Изменения
- Сохранён OAuth v3 GET-контракт, подтверждённый независимой реализацией evcc для FK:
  `account`, `app_id`, `grant_type=password`, `password` (MD5), `scope=base`.
- Расширен разбор вариантов ответа OAuth: `data.token.access_token`, `data.token.accessToken`,
  `data.token`, `data.access_token` и верхнеуровневые варианты.
- Логирование HTTP теперь показывает имена query/form-параметров, но никогда их значения.
- Обновлены версия приложения и User-Agent до 1.2.0.

## Ограничения проверки
Это диагностическая совместимая сборка, а не подтверждённое исправление серверного отказа.
Официальный APK содержит дополнительные сетевые маркеры (`x-jg-sign`, `x-jg-timestamp`,
`x-jg-token`, `x-jg-version`) и поля модели LoginParam (`clientIdentifier`, `countryCode`,
`encodedPassword`). По одному наличию этих имён нельзя достоверно восстановить значения,
алгоритм подписи или правила сериализации. Они намеренно не подставлены наугад.
Реальный вход и Android-сборка в этой среде не проверены.
