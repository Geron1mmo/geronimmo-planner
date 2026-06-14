# Changelog

All notable changes to Geronimmo Planner are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Cross-platform Flutter setup (Windows, Android, iOS)
- Task, event, recurrence, and note data models
- SQLite database with desktop FFI support
- Task management: CRUD, priorities, categories, subtasks
- Calendar module with table_calendar
- Smart dashboard with overdue tasks and productivity widgets
- i18n: English, Ukrainian, Russian, Czech
- Local notifications infrastructure
- JSON backup / import
- Material 3 UI with dark and light themes
- Windows and Android release builds

### Changed
- Upgraded Android Gradle toolchain for JDK 21
- Improved error handling and empty states
- English default seed data for first-run demo

## [1.0.0] - 2026-06-16

### Added
- First stable cross-platform release

[Unreleased]: https://github.com/Geron1mmo/geronimmo-planner/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/Geron1mmo/geronimmo-planner/releases/tag/v1.0.0