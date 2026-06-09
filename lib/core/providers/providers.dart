import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geronimmo_planner/core/db/database_service.dart';
import 'package:geronimmo_planner/models/task_model.dart';
import 'package:geronimmo_planner/models/event_model.dart';

// Tasks
final tasksProvider = StateNotifierProvider<TasksNotifier, List<TaskModel>>((ref) {
  return TasksNotifier();
});

class TasksNotifier extends StateNotifier<List<TaskModel>> {
  TasksNotifier() : super([]) {
    reload();
  }

  Future<void> reload() async {
    var tasks = await DatabaseService.getAllTasks();

    if (tasks.isEmpty) {
      // Seed initial data
      final seedTasks = [
        // Seed data added during early development to demonstrate core functionality
        // This helps new users immediately see how the planner works
        TaskModel(
          title: 'Підготувати звіт для роботи',
          notes: 'Потрібно додати графіки',
          priority: Priority.high,
          category: Category.work,
          dueDate: DateTime.now().add(const Duration(hours: 4)),
        ),
        TaskModel(
          title: 'Купити продукти',
          priority: Priority.medium,
          category: Category.personal,
          dueDate: DateTime.now().add(const Duration(days: 1)),
        ),
      ];
      for (final t in seedTasks) {
        await DatabaseService.insertOrUpdateTask(t);
      }
      tasks = await DatabaseService.getAllTasks();
    }

    state = tasks;
  }

  Future<void> addOrUpdate(TaskModel task) async {
    await DatabaseService.insertOrUpdateTask(task);
    await reload();
  }

  Future<void> delete(String id) async {
    await DatabaseService.deleteTask(id);
    await reload();
  }

  Future<void> toggleComplete(TaskModel task) async {
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    await addOrUpdate(updated);
  }
}

// Events
final eventsProvider = StateNotifierProvider<EventsNotifier, List<EventModel>>((ref) {
  return EventsNotifier();
});

class EventsNotifier extends StateNotifier<List<EventModel>> {
  EventsNotifier() : super([]) {
    reload();
  }

  Future<void> reload() async {
    var events = await DatabaseService.getAllEvents();

    if (events.isEmpty) {
      final now = DateTime.now();
      final seedEvents = [
        EventModel(
          title: 'Зустріч з командою',
          start: DateTime(now.year, now.month, now.day, 10, 0),
          end: DateTime(now.year, now.month, now.day, 11, 0),
          location: 'Офіс / Zoom',
          meetingType: MeetingType.work,
          colorHex: '#3B82F6',
        ),
        EventModel(
          title: 'Тренування в залі',
          start: DateTime(now.year, now.month, now.day, 18, 30),
          end: DateTime(now.year, now.month, now.day, 19, 30),
          meetingType: MeetingType.personal,
          colorHex: '#10B981',
        ),
      ];
      for (final e in seedEvents) {
        await DatabaseService.insertOrUpdateEvent(e);
      }
      events = await DatabaseService.getAllEvents();
    }

    state = events;
  }

  Future<void> addOrUpdate(EventModel event) async {
    await DatabaseService.insertOrUpdateEvent(event);
    await reload();
  }

  Future<void> delete(String id) async {
    await DatabaseService.deleteEvent(id);
    await reload();
  }
}

// Simple search/filter provider
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedFiltersProvider = StateProvider<Map<String, dynamic>>((ref) => {});
