# NIU Mobility Studio 1.0.4 — Cloud & Multi-Vehicle

- Добавлены отдельные сохраняемые карточки скутеров NIU: SN, имя, семейство, модель, VIN, BLE MAC и выбранное устройство.
- Добавлено считывание QR через Google Code Scanner с извлечением SN и ручным резервным вводом.
- Добавлено сохранение BLE-адреса найденного устройства и повторное GATT-подключение из карточки.
- Добавлен отдельный запрос стандартного Android BLE bonding по явной кнопке PAIR.
- Добавлен NIU Cloud compatibility login (GLOBAL/CHINA), импорт списка уже привязанных к аккаунту устройств.
- NIU session token хранится в зашифрованном виде через Android Keystore; пароль не сохраняется.
- Документированы ограничения reverse-engineered API и разница между локальной карточкой, cloud binding, BLE connection и Android Bluetooth bond.

Полная сборка APK и live NIU login не подтверждены. См. `NIU_CLOUD_AND_VEHICLES_RU.md`.
