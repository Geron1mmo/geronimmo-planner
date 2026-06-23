import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:geronimmo_planner/models/task_model.dart';
import 'package:geronimmo_planner/models/event_model.dart';

class DatabaseService {
  static Database? _db;
  static const String _dbName = 'geronimmo_planner.db';
  static const int _version = 1;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final Directory docsDir = await getApplicationDocumentsDirectory();
    final String path = p.join(docsDir.path, _dbName);

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: _version,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        notes TEXT,
        priority INTEGER NOT NULL,
        status INTEGER NOT NULL,
        category INTEGER NOT NULL,
        dueDate TEXT,
        subtasks TEXT,
        links TEXT,
        isCompleted INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE events (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        start TEXT NOT NULL,
        end TEXT NOT NULL,
        location TEXT,
        description TEXT,
        participants TEXT,
        reminderMinutes INTEGER,
        recurrence TEXT,
        colorHex TEXT NOT NULL,
        meetingType INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // Simple notes table
    await db.execute('''
      CREATE TABLE notes (
        id TEXT PRIMARY KEY,
        content TEXT NOT NULL,
        linkedTaskId TEXT,
        linkedEventId TEXT,
        isPinned INTEGER DEFAULT 0,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add migrations here when schema changes
  }

  // ==================== TASKS ====================
  static Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks', orderBy: 'dueDate ASC, updatedAt DESC');
    return maps.map((map) => TaskModel.fromMap(map)).toList();
  }

  static Future<void> insertOrUpdateTask(TaskModel task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== EVENTS ====================
  static Future<List<EventModel>> getAllEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events', orderBy: 'start ASC');
    return maps.map((map) => EventModel.fromMap(map)).toList();
  }

  static Future<void> insertOrUpdateEvent(EventModel event) async {
    final db = await database;
    await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteEvent(String id) async {
    final db = await database;
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== NOTES (simple) ====================
  static Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await database;
    return await db.query('notes', orderBy: 'isPinned DESC, updatedAt DESC');
  }

  static Future<void> insertOrUpdateNote(Map<String, dynamic> note) async {
    final db = await database;
    await db.insert('notes', note, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteNote(String id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== BACKUP / EXPORT ====================
  static Future<Map<String, dynamic>> exportAllData() async {
    final tasks = await getAllTasks();
    final events = await getAllEvents();
    final notes = await getAllNotes();

    return {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'tasks': tasks.map((t) => t.toMap()).toList(),
      'events': events.map((e) => e.toMap()).toList(),
      'notes': notes,
    };
  }

  static Future<void> importData(Map<String, dynamic> data) async {
    final db = await database;

    // Clear and re-insert (simple safe import for v1)
    await db.delete('tasks');
    await db.delete('events');
    await db.delete('notes');

    if (data['tasks'] != null) {
      for (final t in data['tasks']) {
        await db.insert('tasks', Map<String, dynamic>.from(t), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
    if (data['events'] != null) {
      for (final e in data['events']) {
        await db.insert('events', Map<String, dynamic>.from(e), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
    if (data['notes'] != null) {
      for (final n in data['notes']) {
        await db.insert('notes', Map<String, dynamic>.from(n), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  static Future<void> clearAllData() async {
    final db = await database;
    await db.delete('tasks');
    await db.delete('events');
    await db.delete('notes');
  }
}
