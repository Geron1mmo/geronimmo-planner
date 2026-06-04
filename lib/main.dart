import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geronimmo_planner/app.dart';
import 'package:geronimmo_planner/core/db/database_service.dart';
import 'package:geronimmo_planner/core/utils/notification_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Desktop FFI setup (critical for Windows desktop)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Pre-warm database
  await DatabaseService.database;

  // Initialize local notifications
  await NotificationService.init();

  runApp(
    const ProviderScope(
      child: GeronimmoPlannerApp(),
    ),
  );
}
