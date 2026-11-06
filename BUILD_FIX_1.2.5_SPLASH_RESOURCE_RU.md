# Исправление сборки 1.2.5 — splash resource

- Исправлен `app/src/main/res/drawable/niu_splash_background.xml`: цвет фона больше не передаётся как literal в `android:drawable`.
- Добавлен ресурс `niu_splash_background` со значением `#0C0C0C` в `res/values/colors.xml`.
- `versionName` остаётся `1.2.5`, `versionCode` остаётся `125`, `targetSdk` не менялся.
- Предупреждение Edge-to-Edge для targetSdk 35 не является причиной ошибки `failed linking file resources`; оно оставлено без изменения.
