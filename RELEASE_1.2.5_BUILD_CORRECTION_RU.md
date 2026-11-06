# NIU Mobility Studio 1.2.5 — исправление сборки

Это корректирующий архив той же версии 1.2.5. Номер версии и versionCode не менялись.

## Исправления
- Убран `runCatching` вокруг `BluetoothLeScanner.stopScan()` в обработчике BLE Scan error 1. Вместо него используется явно типизированный `BluetoothLeScanner?` и обычный `try/catch`, чтобы избежать ошибок Kotlin `Cannot infer type for type parameter R` и `recursive problem`.
- `android:versionName` и `tools:replace` перенесены на корневой элемент `<manifest>`, где расположен этот атрибут. Некорректное размещение `tools:replace` на `<application>` удалено. Значение оставлено `1.2.5`.

## Проверка
ZIP проверен на целостность. Android Gradle build не запускался в этой среде; успешная компиляция не заявляется.
