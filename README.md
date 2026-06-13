# Geronimmo Planner

**Красивий, простий і швидкий планувальник** для життя, роботи, задач, зустрічей, нагадувань і нотаток.

Створено: **Geronimmo & Oleg**

**Версія:** 1.0.0 · **Оновлено:** червень 2026

---

## Швидкий запуск

### Windows

Подвійний клік на один із файлів:

- `RUN_GERONIMMO.bat` — запускає готову програму
- `executables\windows\Geronimmo_Planner\geronimmo_planner.exe` — портативна копія (можна на флешку)

> Не видаляй `flutter_windows.dll` і папку `data` поруч з exe.

### Android

1. Скопіюй `executables\android\Geronimmo_Planner.apk` на телефон
2. Увімкни встановлення з невідомих джерел (якщо потрібно)
3. Відкрий APK і встанови

---

## Що вже працює

- Повна підтримка **української, російської, чеської та англійської** мов (перемикач у Налаштуваннях)
- **Задачі** — пріоритети, категорії, підзадачі, нотатки
- **Календар** — місяць і список подій на день
- **Події / зустрічі** — з кольорами та типами
- **Смарт-дашборд** — прострочені задачі, «Що робити зараз?», ранковий план
- **Нотатки** — швидке додавання і збереження
- **Локальна база даних** — усі дані зберігаються на пристрої
- **Експорт / імпорт** у JSON (резервна копія)
- **Темна / світла тема** (системна)
- Початкові демо-дані при першому запуску

---

## Збірка з вихідного коду

У проєкті вже є вбудований Flutter: `flutter\bin\flutter.bat`

```powershell
cd D:\Geronimmo_Planner

# Підготовка
flutter pub get

# Windows
flutter build windows --release
# Результат: build\windows\x64\runner\Release\geronimmo_planner.exe

# Android (потрібен Android SDK + JDK з Android Studio)
set JAVA_HOME=C:\Program Files\Android\Android Studio\jbr
flutter build apk --release
# Результат: build\app\outputs\flutter-apk\app-release.apk
```

### Вимоги для збірки

| Платформа | Що потрібно |
|-----------|-------------|
| Windows   | Visual Studio 2022 з «Desktop development with C++» |
| Android   | Android SDK, JDK 17+ (Android Studio) |

Перевірка середовища:

```powershell
flutter doctor
```

---

## Структура проєкту

```
lib/                  — код додатку (екрани, БД, локалізація)
assets/               — іконки, зображення
executables/windows/  — готова Windows-версія
executables/android/  — готовий APK
android/ ios/ windows/ — платформні файли Flutter
```

---

## Технології

- **Flutter** 3.22 · **Dart** 3.4
- **Riverpod** — стан додатку
- **SQLite** (sqflite + FFI) — локальна база
- **go_router** — навігація
- **table_calendar** — календар

---

## GitHub

Репозиторій: [github.com/Geron1mmo/geronimmo-planner](https://github.com/Geron1mmo/geronimmo-planner)

Історія комітів показує поетапну розробку: задачі → календар → дашборд → локалізація → збірка під Windows/Android.

---

## Плани на майбутнє

- Повноцінні форми для подій і повторень
- Push-сповіщення при створенні нагадувань
- Таймлайн і покращений вигляд календаря
- Drag & drop подій

---

**Насолоджуйся плануванням!**

— Geronimmo & Oleg