# NIU Mobility Studio 1.2.7 — Offline Command Test

- versionName: 1.2.7
- versionCode: 127
- Сохранены OAuth POST/GET и универсальные профили моделей.
- Добавлен `NiuCommandTestSimulator`: проверяет реестр, семейство и preflight safety gates.
- На странице «Проверка команд» добавлена кнопка «ПРОГНАТЬ ТЕСТ КОМАНД (OFFLINE)».
- Результаты записываются в журнал приложения с `mode=OFFLINE` и `transmitted=false`.
- Никакие реальные команды управления, BLE payload, cloud write endpoints или неизвестные протоколы не отправляются.
- Добавлены unit-тесты.
- Это тестовый стенд защитной логики, а не реализация физического управления скутером.


## Исправление исходника (без изменения версии)
- Исправлен пакет импорта Google Code Scanner: `GmsBarcodeScanning` находится в `com.google.android.gms.code.scanner`, а не в `com.google.mlkit.vision.codescanner`.
- Версия приложения остаётся 1.2.7 / versionCode 127; авторизация, интерфейс и логика команд не менялись.
