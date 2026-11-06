# 1.3.2 — единая сборка пользовательского APK

- Административная консоль встроена в Full-вариант единого Android application module; отдельного Admin application/module нет.
- Из административной консоли запускается GitHub Actions workflow с `build_target=user`, чтобы собирать пользовательский APK из того же исходного проекта.
- Ручной workflow по умолчанию и push в main/master сохраняют проверку/сборку Full + User.
- Для User APK CI требует `NIU_ADMIN_PUBLIC_KEY`; закрытый ключ разрешений остаётся в Android Keystore административной установки.
- Исправлена JSON-сериализация запроса workflow dispatch; версия приложения обновлена до 1.3.2 / versionCode 132.

# 1.3.1

- APK export moved to password-protected tools hub.
- Event log now supports temporary vs persistent storage and controllable auto-scroll.
- Scooter list changed to a compact selector with details/actions for selected scooter only.
- Removed cloud log upload in the recovery pass per product decision; local diagnostics remain on-device.
- Added `full` and `user` Android distribution flavors; protected tools are disabled in `user`, while source code remains in the app project and local event logging stays available.
- CI assembles both debug distributions.

## 1.3.0 — Secure Tools password management

- Добавлено изменение пароля защищённых инструментов из меню Secure Tools.
- Для смены требуется действующий пароль, новый пароль и подтверждение.
- Новый пароль сохраняется как PBKDF2-HMAC-SHA256 hash с новой случайной солью.
- Проверка текущего пароля использует сохранённые salt/hash, а не только встроенный bootstrap-хеш.
- Сохранены функции APK export, NIU Cloud, BLE/ECU, PIN и биометрическая защита.
- `versionName=1.3.0`, `versionCode=130`.

Сборка Android в этой среде не запускалась.

## 1.3.1 ADMIN PROTECTED — дополнительная реализация
- Добавлен PIN-контроль операций подписи/отзыва в Admin с PBKDF2-HMAC-SHA256.
- Добавлен подписанный офлайн-список отзыва разрешений и его импорт в User.
- Добавлен доступ к управлению admin-разрешением из хаба защищённых инструментов.
- Build Center разделяет Full/User/Admin APK артефакты и позволяет выбрать тип скачиваемого APK.
- Уточнена документация ограничений офлайн-отзыва, Installation ID и требований CI.
