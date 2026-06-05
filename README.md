# Geronimmo Planner — Готова програма

**Красивий, простий та швидкий планувальник** для життя, роботи, задач, зустрічей, звичок і продуктивності.

Створено: **Geronimmo & Oleg**

## 📍 Готова програма

У тебе є дві речі:
1. **Папка з повним кодом**: `C:\Users\admin\Projects\Geronimmo_Planner`
2. **ZIP-архів** (готовий до копіювання): `C:\Users\admin\Downloads\Geronimmo_Planner_Ready.zip`

## Як запустити (покроково)

### Крок 1: Встанови Flutter (якщо ще немає)

1. Завантаж Flutter з офіційного сайту: https://docs.flutter.dev/get-started/install/windows
2. Додай `flutter\bin` у PATH (інструкція є на сайті).
3. Перевір у командному рядку:
   ```powershell
   flutter --version
   ```

### Крок 2: Підготуй проект

```powershell
cd C:\Users\admin\Projects\Geronimmo_Planner

# Якщо папки android/ios/windows відсутні — згенеруй їх
flutter create . --platforms=android,ios,windows

flutter pub get
```

### Крок 3: Запусти програму

**На Windows (найпростіше):**
```powershell
flutter run -d windows
```

**На Android:**
```powershell
flutter run -d android
```

**На iPhone (потрібен Mac):**
```bash
flutter run -d ios
```

## Збірка готових файлів

- **Android APK** (для встановлення на телефон):
  ```powershell
  flutter build apk --release
  ```
  Файл буде тут: `build\app\outputs\flutter-apk\app-release.apk`

- **Windows .exe**:
  ```powershell
  flutter build windows --release
  ```
  Програма: `build\windows\x64\runner\Release\Geronimmo Planner.exe`

## Що вже працює в програмі

- ✅ Повністю українською, російською, чеською та англійською (перемикач у Налаштуваннях)
- ✅ Задачі з пріоритетами, категоріями, підзадачами, нотатками
- ✅ Календар (місяць + список подій на день)
- ✅ Події / Зустрічі з кольорами
- ✅ Смарт дашборд (прострочені, "Що робити зараз?", ранковий план)
- ✅ Локальна база даних (всі дані зберігаються)
- ✅ Експорт / Імпорт у JSON (резервна копія)
- ✅ Скидання програми
- ✅ Початкові дані (seed) при першому запуску
- ✅ Нотатки (можна додавати)
- ✅ Базові нагадування (інфраструктура готова)

## Наступні кроки (легко додати)

- Повноцінні форми для подій + повторення
- Реальні push-сповіщення при створенні подій
- Таймлайн і тижневий вигляд календаря
- Drag & drop подій
- Кращі іконки (поклади PNG в assets/icons/app_icon.png і запусти генератори)

## Підтримка

Якщо щось не запуститься — напиши мені точну помилку з консолі.

**Насолоджуйся плануванням!** 🚀

## Development Timeline (for portfolio visibility)

This project was developed iteratively with proper version control:

- Project initialization and core architecture
- Feature-by-feature implementation (Tasks, Calendar, Dashboard, etc.)
- Cross-platform build scripts and multilingual support
- Database, backup, and reminder systems
- UI polishing, testing, and documentation

See commit history for detailed progress.

— Geronimmo & Oleg

---

**Version:** 1.0.0
**Last updated:** June 2026
