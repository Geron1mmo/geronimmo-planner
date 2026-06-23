import 'dart:ui';

/// Professional localization for Geronimmo Planner.
/// Supports Ukrainian, Russian, Czech, English (fallback).
/// All user-facing strings live here. No hardcoded text in UI.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(Locale locale) => AppLocalizations(locale);

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('uk'),
    Locale('ru'),
    Locale('cs'),
  ];

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Geronimmo Planner',
      'created_by': 'Created by Geronimmo & Oleg',
      'today': 'Today',
      'calendar': 'Calendar',
      'tasks': 'Tasks',
      'events': 'Events',
      'notes': 'Notes',
      'settings': 'Settings',
      'dashboard': 'Dashboard',
      'search': 'Search',
      'add': 'Add',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'edit': 'Edit',
      'done': 'Done',
      'priority': 'Priority',
      'priority_low': 'Low',
      'priority_medium': 'Medium',
      'priority_high': 'High',
      'priority_urgent': 'Urgent',
      'status_planned': 'Planned',
      'status_in_progress': 'In Progress',
      'status_done': 'Done',
      'status_cancelled': 'Cancelled',
      'category_work': 'Work',
      'category_personal': 'Personal',
      'category_study': 'Study',
      'category_meetings': 'Meetings',
      'category_health': 'Health',
      'category_finance': 'Finance',
      'category_other': 'Other',
      'reminder_5min': '5 minutes before',
      'reminder_15min': '15 minutes before',
      'reminder_30min': '30 minutes before',
      'reminder_1h': '1 hour before',
      'reminder_1d': '1 day before',
      'reminder_custom': 'Custom',
      'repeat_daily': 'Daily',
      'repeat_weekly': 'Weekly',
      'repeat_monthly': 'Monthly',
      'repeat_yearly': 'Yearly',
      'repeat_custom': 'Custom',
      'no_tasks': 'No tasks yet. Create your first one!',
      'no_events': 'No events on this day.',
      'overdue': 'Overdue',
      'what_to_do_now': 'What should I do now?',
      'morning_plan': 'Morning Plan',
      'evening_review': 'Evening Review',
      'productivity_score': 'Productivity Score',
      'free_time_finder': 'Free Time Finder',
      'focus_mode': 'Focus Mode',
      'backup_export': 'Backup & Export',
      'import': 'Import',
      'language': 'Language',
      'theme': 'Theme',
      'accent_color': 'Accent Color',
      'week_starts_on': 'Week starts on',
      'time_format': 'Time format',
      'notifications': 'Notifications',
      'reset_app': 'Reset App',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'monday': 'Monday',
      'sunday': 'Sunday',
      '24h': '24-hour',
      '12h': '12-hour',
      'success': 'Success',
      'error': 'Error',
      'loading': 'Loading...',
      'confirm_delete': 'Delete this item?',
      'yes': 'Yes',
      'no': 'No',
      'title': 'Title',
      'description': 'Description',
      'date': 'Date',
      'time': 'Time',
      'duration': 'Duration',
      'location': 'Location',
      'participants': 'Participants',
      'reminder': 'Reminder',
      'repeat': 'Repeat',
      'color': 'Color',
      'notes_hint': 'Add notes...',
      'subtasks': 'Subtasks',
      'add_subtask': 'Add subtask',
      'quick_note': 'Quick Note',
      'search_placeholder': 'Search tasks, events, notes...',
      'filters': 'Filters',
      'clear_filters': 'Clear filters',
      'snooze': 'Snooze',
      'complete': 'Complete',
      'skip_occurrence': 'Skip this occurrence',
      'view_day': 'Day',
      'view_week': 'Week',
      'view_month': 'Month',
      'view_timeline': 'Timeline',
      'quick_add': 'Quick Add',
      'event': 'Event',
      'task': 'Task',
      'meeting_type_personal': 'Personal',
      'meeting_type_work': 'Work',
      'meeting_type_call': 'Call',
      'meeting_type_online': 'Online',
      'meeting_type_travel': 'Travel',
      'meeting_type_other': 'Other',
      'empty_state_general': 'Nothing here yet.',
      'onboarding_welcome': 'Welcome to Geronimmo Planner',
      'onboarding_subtitle': 'Plan your life beautifully.',
    },
    'uk': {
      'app_name': 'Geronimmo Planner',
      'created_by': 'Створено Geronimmo & Олег',
      'today': 'Сьогодні',
      'calendar': 'Календар',
      'tasks': 'Задачі',
      'events': 'Події',
      'notes': 'Нотатки',
      'settings': 'Налаштування',
      'dashboard': 'Головна',
      'search': 'Пошук',
      'add': 'Додати',
      'save': 'Зберегти',
      'cancel': 'Скасувати',
      'delete': 'Видалити',
      'edit': 'Редагувати',
      'done': 'Готово',
      'priority': 'Пріоритет',
      'priority_low': 'Низький',
      'priority_medium': 'Середній',
      'priority_high': 'Високий',
      'priority_urgent': 'Терміновий',
      'status_planned': 'Заплановано',
      'status_in_progress': 'В процесі',
      'status_done': 'Виконано',
      'status_cancelled': 'Скасовано',
      'category_work': 'Робота',
      'category_personal': 'Особисте',
      'category_study': 'Навчання',
      'category_meetings': 'Зустрічі',
      'category_health': 'Здоров\'я',
      'category_finance': 'Фінанси',
      'category_other': 'Інше',
      'reminder_5min': 'За 5 хвилин',
      'reminder_15min': 'За 15 хвилин',
      'reminder_30min': 'За 30 хвилин',
      'reminder_1h': 'За 1 годину',
      'reminder_1d': 'За 1 день',
      'reminder_custom': 'Власний',
      'repeat_daily': 'Щодня',
      'repeat_weekly': 'Щотижня',
      'repeat_monthly': 'Щомісяця',
      'repeat_yearly': 'Щороку',
      'repeat_custom': 'Власний',
      'no_tasks': 'Поки що немає задач. Створіть першу!',
      'no_events': 'На цей день немає подій.',
      'overdue': 'Прострочені',
      'what_to_do_now': 'Що робити зараз?',
      'morning_plan': 'Ранковий план',
      'evening_review': 'Вечірній огляд',
      'productivity_score': 'Показник продуктивності',
      'free_time_finder': 'Пошук вільного часу',
      'focus_mode': 'Режим фокусу',
      'backup_export': 'Резервна копія та експорт',
      'import': 'Імпорт',
      'language': 'Мова',
      'theme': 'Тема',
      'accent_color': 'Акцентний колір',
      'week_starts_on': 'Тиждень починається з',
      'time_format': 'Формат часу',
      'notifications': 'Сповіщення',
      'reset_app': 'Скинути додаток',
      'light': 'Світла',
      'dark': 'Темна',
      'system': 'Система',
      'monday': 'Понеділок',
      'sunday': 'Неділя',
      '24h': '24-годинний',
      '12h': '12-годинний',
      'success': 'Успішно',
      'error': 'Помилка',
      'loading': 'Завантаження...',
      'confirm_delete': 'Видалити цей елемент?',
      'yes': 'Так',
      'no': 'Ні',
      'title': 'Назва',
      'description': 'Опис',
      'date': 'Дата',
      'time': 'Час',
      'duration': 'Тривалість',
      'location': 'Місце',
      'participants': 'Учасники',
      'reminder': 'Нагадування',
      'repeat': 'Повтор',
      'color': 'Колір',
      'notes_hint': 'Додайте нотатку...',
      'subtasks': 'Підзадачі',
      'add_subtask': 'Додати підзадачу',
      'quick_note': 'Швидка нотатка',
      'search_placeholder': 'Шукати задачі, події, нотатки...',
      'filters': 'Фільтри',
      'clear_filters': 'Очистити фільтри',
      'snooze': 'Відкласти',
      'complete': 'Виконати',
      'skip_occurrence': 'Пропустити це повторення',
      'view_day': 'День',
      'view_week': 'Тиждень',
      'view_month': 'Місяць',
      'view_timeline': 'Таймлайн',
      'quick_add': 'Швидке додавання',
      'event': 'Подія',
      'task': 'Задача',
      'meeting_type_personal': 'Особисте',
      'meeting_type_work': 'Робота',
      'meeting_type_call': 'Дзвінок',
      'meeting_type_online': 'Онлайн',
      'meeting_type_travel': 'Подорож',
      'meeting_type_other': 'Інше',
      'empty_state_general': 'Поки що нічого немає.',
      'onboarding_welcome': 'Ласкаво просимо до Geronimmo Planner',
      'onboarding_subtitle': 'Плануйте своє життя красиво.',
    },
    'ru': {
      'app_name': 'Geronimmo Planner',
      'created_by': 'Создано Geronimmo & Олег',
      'today': 'Сегодня',
      'calendar': 'Календарь',
      'tasks': 'Задачи',
      'events': 'События',
      'notes': 'Заметки',
      'settings': 'Настройки',
      'dashboard': 'Главная',
      'search': 'Поиск',
      'add': 'Добавить',
      'save': 'Сохранить',
      'cancel': 'Отмена',
      'delete': 'Удалить',
      'edit': 'Редактировать',
      'done': 'Готово',
      'priority': 'Приоритет',
      'priority_low': 'Низкий',
      'priority_medium': 'Средний',
      'priority_high': 'Высокий',
      'priority_urgent': 'Срочный',
      'status_planned': 'Запланировано',
      'status_in_progress': 'В процессе',
      'status_done': 'Выполнено',
      'status_cancelled': 'Отменено',
      'category_work': 'Работа',
      'category_personal': 'Личное',
      'category_study': 'Учёба',
      'category_meetings': 'Встречи',
      'category_health': 'Здоровье',
      'category_finance': 'Финансы',
      'category_other': 'Другое',
      'reminder_5min': 'За 5 минут',
      'reminder_15min': 'За 15 минут',
      'reminder_30min': 'За 30 минут',
      'reminder_1h': 'За 1 час',
      'reminder_1d': 'За 1 день',
      'reminder_custom': 'Свой',
      'repeat_daily': 'Ежедневно',
      'repeat_weekly': 'Еженедельно',
      'repeat_monthly': 'Ежемесячно',
      'repeat_yearly': 'Ежегодно',
      'repeat_custom': 'Свой',
      'no_tasks': 'Пока нет задач. Создайте первую!',
      'no_events': 'Нет событий на этот день.',
      'overdue': 'Просроченные',
      'what_to_do_now': 'Что делать сейчас?',
      'morning_plan': 'Утренний план',
      'evening_review': 'Вечерний обзор',
      'productivity_score': 'Показатель продуктивности',
      'free_time_finder': 'Поиск свободного времени',
      'focus_mode': 'Режим фокуса',
      'backup_export': 'Резервная копия и экспорт',
      'import': 'Импорт',
      'language': 'Язык',
      'theme': 'Тема',
      'accent_color': 'Акцентный цвет',
      'week_starts_on': 'Неделя начинается с',
      'time_format': 'Формат времени',
      'notifications': 'Уведомления',
      'reset_app': 'Сбросить приложение',
      'light': 'Светлая',
      'dark': 'Тёмная',
      'system': 'Система',
      'monday': 'Понедельник',
      'sunday': 'Воскресенье',
      '24h': '24-часовой',
      '12h': '12-часовой',
      'success': 'Успешно',
      'error': 'Ошибка',
      'loading': 'Загрузка...',
      'confirm_delete': 'Удалить этот элемент?',
      'yes': 'Да',
      'no': 'Нет',
      'title': 'Название',
      'description': 'Описание',
      'date': 'Дата',
      'time': 'Время',
      'duration': 'Длительность',
      'location': 'Место',
      'participants': 'Участники',
      'reminder': 'Напоминание',
      'repeat': 'Повтор',
      'color': 'Цвет',
      'notes_hint': 'Добавьте заметку...',
      'subtasks': 'Подзадачи',
      'add_subtask': 'Добавить подзадачу',
      'quick_note': 'Быстрая заметка',
      'search_placeholder': 'Искать задачи, события, заметки...',
      'filters': 'Фильтры',
      'clear_filters': 'Очистить фильтры',
      'snooze': 'Отложить',
      'complete': 'Выполнить',
      'skip_occurrence': 'Пропустить это повторение',
      'view_day': 'День',
      'view_week': 'Неделя',
      'view_month': 'Месяц',
      'view_timeline': 'Таймлайн',
      'quick_add': 'Быстрое добавление',
      'event': 'Событие',
      'task': 'Задача',
      'meeting_type_personal': 'Личное',
      'meeting_type_work': 'Работа',
      'meeting_type_call': 'Звонок',
      'meeting_type_online': 'Онлайн',
      'meeting_type_travel': 'Поездка',
      'meeting_type_other': 'Другое',
      'empty_state_general': 'Пока ничего нет.',
      'onboarding_welcome': 'Добро пожаловать в Geronimmo Planner',
      'onboarding_subtitle': 'Планируйте свою жизнь красиво.',
    },
    'cs': {
      'app_name': 'Geronimmo Planner',
      'created_by': 'Vytvořeno Geronimmo & Oleg',
      'today': 'Dnes',
      'calendar': 'Kalendář',
      'tasks': 'Úkoly',
      'events': 'Události',
      'notes': 'Poznámky',
      'settings': 'Nastavení',
      'dashboard': 'Přehled',
      'search': 'Hledat',
      'add': 'Přidat',
      'save': 'Uložit',
      'cancel': 'Zrušit',
      'delete': 'Smazat',
      'edit': 'Upravit',
      'done': 'Hotovo',
      'priority': 'Priorita',
      'priority_low': 'Nízká',
      'priority_medium': 'Střední',
      'priority_high': 'Vysoká',
      'priority_urgent': 'Naléhavá',
      'status_planned': 'Plánováno',
      'status_in_progress': 'Probíhá',
      'status_done': 'Hotovo',
      'status_cancelled': 'Zrušeno',
      'category_work': 'Práce',
      'category_personal': 'Osobní',
      'category_study': 'Studium',
      'category_meetings': 'Schůzky',
      'category_health': 'Zdraví',
      'category_finance': 'Finance',
      'category_other': 'Ostatní',
      'reminder_5min': '5 minut předem',
      'reminder_15min': '15 minut předem',
      'reminder_30min': '30 minut předem',
      'reminder_1h': '1 hodinu předem',
      'reminder_1d': '1 den předem',
      'reminder_custom': 'Vlastní',
      'repeat_daily': 'Denně',
      'repeat_weekly': 'Týdně',
      'repeat_monthly': 'Měsíčně',
      'repeat_yearly': 'Ročně',
      'repeat_custom': 'Vlastní',
      'no_tasks': 'Zatím žádné úkoly. Vytvořte první!',
      'no_events': 'Žádné události na tento den.',
      'overdue': 'Po termínu',
      'what_to_do_now': 'Co mám dělat teď?',
      'morning_plan': 'Ranní plán',
      'evening_review': 'Večerní shrnutí',
      'productivity_score': 'Skóre produktivity',
      'free_time_finder': 'Hledání volného času',
      'focus_mode': 'Režim soustředění',
      'backup_export': 'Záloha a export',
      'import': 'Import',
      'language': 'Jazyk',
      'theme': 'Motiv',
      'accent_color': 'Barva zvýraznění',
      'week_starts_on': 'Týden začíná v',
      'time_format': 'Formát času',
      'notifications': 'Oznámení',
      'reset_app': 'Resetovat aplikaci',
      'light': 'Světlý',
      'dark': 'Tmavý',
      'system': 'Systém',
      'monday': 'Pondělí',
      'sunday': 'Neděle',
      '24h': '24hodinový',
      '12h': '12hodinový',
      'success': 'Úspěch',
      'error': 'Chyba',
      'loading': 'Načítání...',
      'confirm_delete': 'Smazat tuto položku?',
      'yes': 'Ano',
      'no': 'Ne',
      'title': 'Název',
      'description': 'Popis',
      'date': 'Datum',
      'time': 'Čas',
      'duration': 'Trvání',
      'location': 'Místo',
      'participants': 'Účastníci',
      'reminder': 'Připomínka',
      'repeat': 'Opakování',
      'color': 'Barva',
      'notes_hint': 'Přidat poznámku...',
      'subtasks': 'Dílčí úkoly',
      'add_subtask': 'Přidat dílčí úkol',
      'quick_note': 'Rychlá poznámka',
      'search_placeholder': 'Hledat úkoly, události, poznámky...',
      'filters': 'Filtry',
      'clear_filters': 'Vymazat filtry',
      'snooze': 'Odložit',
      'complete': 'Dokončit',
      'skip_occurrence': 'Přeskočit tento výskyt',
      'view_day': 'Den',
      'view_week': 'Týden',
      'view_month': 'Měsíc',
      'view_timeline': 'Časová osa',
      'quick_add': 'Rychlé přidání',
      'event': 'Událost',
      'task': 'Úkol',
      'meeting_type_personal': 'Osobní',
      'meeting_type_work': 'Práce',
      'meeting_type_call': 'Hovor',
      'meeting_type_online': 'Online',
      'meeting_type_travel': 'Cesta',
      'meeting_type_other': 'Jiné',
      'empty_state_general': 'Zatím zde nic není.',
      'onboarding_welcome': 'Vítejte v Geronimmo Planner',
      'onboarding_subtitle': 'Plánujte svůj život krásně.',
    },
  };

  String get appName => _get('app_name');
  String get createdBy => _get('created_by');
  String get today => _get('today');
  String get calendar => _get('calendar');
  String get tasks => _get('tasks');
  String get events => _get('events');
  String get notes => _get('notes');
  String get settings => _get('settings');
  String get dashboard => _get('dashboard');
  String get search => _get('search');
  String get add => _get('add');
  String get save => _get('save');
  String get cancel => _get('cancel');
  String get delete => _get('delete');
  String get edit => _get('edit');
  String get done => _get('done');
  String get priority => _get('priority');
  String get emptyStateGeneral => _get('empty_state_general');
  String get priorityLow => _get('priority_low');
  String get priorityMedium => _get('priority_medium');
  String get priorityHigh => _get('priority_high');
  String get priorityUrgent => _get('priority_urgent');
  String get statusPlanned => _get('status_planned');
  String get statusInProgress => _get('status_in_progress');
  String get statusDone => _get('status_done');
  String get statusCancelled => _get('status_cancelled');
  String category(String key) => _get('category_$key');
  String get noTasks => _get('no_tasks');
  String get noEvents => _get('no_events');
  String get overdue => _get('overdue');
  String get whatToDoNow => _get('what_to_do_now');
  String get morningPlan => _get('morning_plan');
  String get eveningReview => _get('evening_review');
  String get productivityScore => _get('productivity_score');
  String get freeTimeFinder => _get('free_time_finder');
  String get focusMode => _get('focus_mode');
  String get backupExport => _get('backup_export');
  String get import => _get('import');
  String get language => _get('language');
  String get theme => _get('theme');
  String get accentColor => _get('accent_color');
  String get weekStartsOn => _get('week_starts_on');
  String get timeFormat => _get('time_format');
  String get notifications => _get('notifications');
  String get resetApp => _get('reset_app');
  String get light => _get('light');
  String get dark => _get('dark');
  String get system => _get('system');
  String get monday => _get('monday');
  String get sunday => _get('sunday');
  String get format24h => _get('24h');
  String get format12h => _get('12h');
  String get success => _get('success');
  String get error => _get('error');
  String get loading => _get('loading');
  String get confirmDelete => _get('confirm_delete');
  String get yes => _get('yes');
  String get no => _get('no');
  String get title => _get('title');
  String get description => _get('description');
  String get date => _get('date');
  String get time => _get('time');
  String get duration => _get('duration');
  String get location => _get('location');
  String get participants => _get('participants');
  String get reminder => _get('reminder');
  String get repeat => _get('repeat');
  String get color => _get('color');
  String get notesHint => _get('notes_hint');
  String get subtasks => _get('subtasks');
  String get addSubtask => _get('add_subtask');
  String get quickNote => _get('quick_note');
  String get searchPlaceholder => _get('search_placeholder');
  String get filters => _get('filters');
  String get clearFilters => _get('clear_filters');
  String get snooze => _get('snooze');
  String get complete => _get('complete');
  String get skipOccurrence => _get('skip_occurrence');
  String get viewDay => _get('view_day');
  String get viewWeek => _get('view_week');
  String get viewMonth => _get('view_month');
  String get viewTimeline => _get('view_timeline');
  String get quickAdd => _get('quick_add');
  String get event => _get('event');
  String get task => _get('task');
  String meetingType(String key) => _get('meeting_type_$key');

  String _get(String key) {
    final lang = locale.languageCode;
    return _localizedValues[lang]?[key] ?? 
           _localizedValues['en']?[key] ?? 
           key;
  }
}
