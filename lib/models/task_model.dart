import 'package:uuid/uuid.dart';

enum Priority { low, medium, high, urgent }
enum TaskStatus { planned, inProgress, done, cancelled }
enum Category { work, personal, study, meetings, health, finance, other }

class Subtask {
  final String id;
  final String title;
  bool isDone;

  Subtask({required this.id, required this.title, this.isDone = false});

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'isDone': isDone ? 1 : 0,
      };

  factory Subtask.fromMap(Map<String, dynamic> map) => Subtask(
        id: map['id'],
        title: map['title'],
        isDone: map['isDone'] == 1,
      );
}

class TaskModel {
  final String id;
  String title;
  String? notes;
  Priority priority;
  TaskStatus status;
  Category category;
  DateTime? dueDate;
  List<Subtask> subtasks;
  List<String> links; // simple attachments as URLs or notes
  bool isCompleted;
  DateTime createdAt;
  DateTime updatedAt;

  TaskModel({
    String? id,
    required this.title,
    this.notes,
    this.priority = Priority.medium,
    this.status = TaskStatus.planned,
    this.category = Category.personal,
    this.dueDate,
    List<Subtask>? subtasks,
    List<String>? links,
    this.isCompleted = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        subtasks = subtasks ?? [],
        links = links ?? [],
        createdAt = createdAt ?? DateTime.now().toUtc(),
        updatedAt = updatedAt ?? DateTime.now().toUtc();

  bool get isOverdue =>
      dueDate != null &&
      dueDate!.isBefore(DateTime.now()) &&
      !isCompleted;

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'notes': notes,
        'priority': priority.index,
        'status': status.index,
        'category': category.index,
        'dueDate': dueDate?.toIso8601String(),
        'subtasks': subtasks.map((s) => s.toMap()).toList(),
        'links': links,
        'isCompleted': isCompleted ? 1 : 0,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      notes: map['notes'],
      priority: Priority.values[map['priority']],
      status: TaskStatus.values[map['status']],
      category: Category.values[map['category']],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']).toLocal() : null,
      subtasks: (map['subtasks'] as List<dynamic>?)
              ?.map((e) => Subtask.fromMap(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      links: List<String>.from(map['links'] ?? []),
      isCompleted: map['isCompleted'] == 1,
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
    );
  }

  TaskModel copyWith({
    String? title,
    String? notes,
    Priority? priority,
    TaskStatus? status,
    Category? category,
    DateTime? dueDate,
    List<Subtask>? subtasks,
    List<String>? links,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      subtasks: subtasks ?? this.subtasks,
      links: links ?? this.links,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
