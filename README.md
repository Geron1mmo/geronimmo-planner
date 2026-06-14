# Geronimmo Planner

A clean, fast cross-platform planner built with **Flutter & Dart** — tasks, calendar, events, notes, and smart productivity tools.

**Authors:** Geronimmo & Oleg · **Version:** 1.0.0 · **Updated:** June 2026

[![Flutter](https://img.shields.io/badge/Flutter-3.22-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.4-0175C2?logo=dart)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Android-512BD4)]()

---

## Quick Start

### Windows

Double-click either file:

- `RUN_GERONIMMO.bat` — launches the app
- `executables\windows\Geronimmo_Planner\geronimmo_planner.exe` — portable build (USB-friendly)

> Keep `flutter_windows.dll` and the `data` folder next to the exe.

### Android

1. Copy `executables\android\Geronimmo_Planner.apk` to your phone
2. Enable install from unknown sources if prompted
3. Open the APK and install

---

## Features

- **4 languages** — English, Ukrainian, Russian, Czech (switch in Settings)
- **Tasks** — priorities, categories, subtasks, notes
- **Calendar** — month view and daily event list
- **Events** — color-coded meetings and reminders
- **Smart dashboard** — overdue tasks, focus suggestions, morning plan
- **Notes** — quick capture with local persistence
- **SQLite database** — all data stays on device
- **JSON backup** — export and import your data
- **Dark / light theme** — follows system preference
- Demo seed data on first launch

---

## Build from Source

Embedded Flutter SDK: `flutter\bin\flutter.bat`

```powershell
cd D:\Geronimmo_Planner
flutter pub get

# Windows
flutter build windows --release

# Android
set JAVA_HOME=C:\Program Files\Android\Android Studio\jbr
flutter build apk --release
```

| Platform | Requirements |
|----------|--------------|
| Windows  | Visual Studio 2022 + Desktop development with C++ |
| Android  | Android SDK + JDK 17+ (Android Studio) |

```powershell
flutter doctor
```

---

## Project Structure

```
lib/                  App code (screens, DB, i18n, theme)
assets/               Icons and images
executables/          Ready-to-run Windows & Android builds
android/ ios/ windows/ Platform runners
```

---

## Tech Stack

- **Flutter 3.22** · **Dart 3.4**
- **Riverpod** — state management
- **SQLite** (sqflite + FFI) — local storage
- **go_router** — navigation
- **table_calendar** — calendar UI

---

## Repository

[github.com/Geron1mmo/geronimmo-planner](https://github.com/Geron1mmo/geronimmo-planner)

Commit history reflects iterative development: core architecture → features → i18n → cross-platform builds.

---

## Roadmap

- Full event forms with recurrence
- Push notifications for reminders
- Timeline calendar view
- Drag & drop scheduling

---

Built with focus. Shipped with care.

— Geronimmo & Oleg