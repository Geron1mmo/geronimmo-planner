import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geronimmo_planner/app.dart';
import 'package:geronimmo_planner/core/db/database_service.dart';
import 'package:geronimmo_planner/core/utils/notification_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Desktop FFI setup (critical for Windows desktop support)
  // This ensures the SQLite database works reliably on desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Pre-initialize the local database to avoid first-run delays
  // All user data (tasks, events, notes) is stored here persistently
  await DatabaseService.database;

  // Set up local notifications for reminders
  // Supports multiple reminder times and recurring items
  await NotificationService.init();

  // Launch the main app with Riverpod state management
  runApp(
    const ProviderScope(
      child: GeronimmoPlannerApp(),
    ),
  );
}
