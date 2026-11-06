# Open-source foundations

NIU Mobility Studio 1.0.0 использует архитектурные идеи и публичные интерфейсы следующих проектов. В этой сборке их исходные файлы не копировались и не перепаковывались: интеграция крупных IDE-модулей требует проверки совместимости, Android toolchain и лицензирования.

| Проект | Что используем как архитектурный ориентир | Лицензия/статус |
|---|---|---|
| CodeAssist — https://github.com/tyron12233/CodeAssist | Project model, build task graph, Java/Kotlin language intelligence, Android XML assist, on-device build pipeline | GPL-3.0-or-later; активный upstream по состоянию на проверку |
| AndroidIDE — https://github.com/AndroidIDEOfficial/AndroidIDE | Android Gradle/JDK environment, terminal, Git, language servers, Logcat and SDK tooling | GPL-3.0-or-later; upstream архивирован в 2024 году |
| Code on the Go — https://github.com/appdevforall/CodeOnTheGo | Offline-first development on Android and successor direction to AndroidIDE | Проверяйте актуальную лицензию и NOTICE upstream перед переносом файлов |
| AppAuth for Android — https://github.com/openid/AppAuth-Android | Рассматривается как стандартная библиотека для native OAuth Authorization Code + PKCE | Apache-2.0; не включена в текущую сборку |

## Почему исходники GPL IDE пока не скопированы

CodeAssist и AndroidIDE распространяются под GPL-3.0-or-later. Перенос их исходных модулей в NIU может повлечь обязанность распространять производную работу под GPL-3.0-or-later и предоставлять соответствующий исходный код/уведомления. Это не просто техническая зависимость. До явного выбора лицензии NIU интегрируются совместимые архитектурные решения, а не копируются GPL-файлы.

## Следующий инженерный шаг

Для настоящей on-device IDE нужно интегрировать изолированные модули по очереди: редактор (Sora/CodeEditor), VFS и project model, Java/Kotlin language servers, Gradle/JDK runtime и Android SDK tools, затем incremental build engine (aapt2, ECJ/kotlinc, D8/R8, apksig). Каждый модуль должен иметь upstream URL, точный commit/tag, лицензию, NOTICE, Android ABI/API compatibility и собственные тесты. Нельзя заявлять on-device APK build до прохождения полного build/install test на реальном устройстве.
