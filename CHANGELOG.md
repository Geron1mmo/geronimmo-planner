# Changelog

All notable changes to Geronimmo Planner will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project scaffolding and Flutter setup for cross-platform (Windows, Android, iOS)
- Core data models for Tasks, Events, Recurrence, Notes
- Local SQLite database layer with sqflite + FFI for desktop
- Full task management: CRUD, priorities, statuses, categories, subtasks, linked notes
- Calendar module with day/week/month/timeline views using table_calendar
- Smart Dashboard with overdue tasks, "What to do now", productivity score, morning/evening plans
- Multilingual support: Ukrainian, Russian, Czech, English (with live language switcher)
- Local notifications infrastructure (reminders with snooze)
- JSON backup/export and import functionality
- Notes module with quick creation and persistence
- Professional UI with Material 3, dark/light themes, accent colors
- Build scripts for easy Windows .exe, Android APK, and iOS preparation
- Unit tests for recurrence logic and data layer
- Comprehensive README, setup instructions, and QA checklist

### Changed
- Improved error handling and empty states across all screens
- Enhanced recurrence engine to support skipping occurrences
- Refined date/time handling for timezone safety

## [1.0.0] - 2026-06-15

### Added
- First stable release of Geronimmo Planner
- Complete cross-platform support ready for build
- Active development history visible in Git commits for portfolio purposes

[Unreleased]: https://github.com/yourusername/geronimmo-planner/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/yourusername/geronimmo-planner/releases/tag/v1.0.0
