# NIU Mobility Studio 1.2.5 — дополнительная коррекция сборки

Номер версии и versionCode не менялись (1.2.5 / 125).

## Исправление
- Объявлению BLE callback добавлен явный тип `ScanCallback`: `private val scanCallback: ScanCallback = object : ScanCallback() { ... }`.
- Это устраняет рекурсивный вывод типа Kotlin, возникавший при обращении к `scanCallback` из BLE callback и вызове `BluetoothLeScanner.stopScan()`.
- Предупреждение targetSdk 35 об edge-to-edge не является ошибкой компиляции; оно оставлено без изменения, чтобы не вносить непроверенную правку интерфейса.

Android Gradle build в этой среде не запускался. ZIP проверяется отдельно; успешная компиляция не заявляется.
