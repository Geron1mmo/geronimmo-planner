import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geronimmo_planner/core/l10n/app_localizations.dart';
import 'package:geronimmo_planner/core/providers/providers.dart';
import 'package:geronimmo_planner/core/db/database_service.dart';
import 'package:geronimmo_planner/app.dart';
import 'package:path_provider/path_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(loc.language),
            subtitle: Text(currentLocale.languageCode.toUpperCase()),
            onTap: () => _showLanguagePicker(context, ref),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.palette),
            title: Text(loc.theme),
            subtitle: const Text('System (Light / Dark)'),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(loc.accentColor),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.backup),
            title: Text(loc.backupExport),
            onTap: () => _exportData(context),
          ),
          ListTile(
            leading: const Icon(Icons.file_download),
            title: Text(loc.import),
            onTap: () => _importData(context, ref),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(loc.resetApp, style: const TextStyle(color: Colors.red)),
            subtitle: const Text('Removes all local data. Use with caution.'),
            onTap: () => _resetApp(context, ref),
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Text(loc.appName, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(loc.createdBy, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final languages = {
      'en': 'English',
      'uk': 'Українська',
      'ru': 'Русский',
      'cs': 'Čeština',
    };

    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: languages.entries.map((entry) {
          return ListTile(
            title: Text(entry.value),
            onTap: () {
              ref.read(localeProvider.notifier).state = Locale(entry.key);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    try {
      final data = await DatabaseService.exportAllData();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/geronimmo_backup_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(jsonEncode(data));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup saved to ${file.path}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    // For demo: we simulate import from a known location or show instruction.
    // In real app use file_picker.
    try {
      final dir = await getApplicationDocumentsDirectory();
      final files = dir.listSync().where((f) => f.path.endsWith('.json')).toList();
      if (files.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No backup files found in Documents folder. Place a backup JSON there.')),
          );
        }
        return;
      }
      final latest = files.last as File;
      final content = await latest.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;
      await DatabaseService.importData(data);
      // Refresh providers
      await ref.read(tasksProvider.notifier).reload();
      await ref.read(eventsProvider.notifier).reload();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Import successful!')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Import error: $e')));
      }
    }
  }

  Future<void> _resetApp(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reset App?'),
        content: const Text('This will delete ALL data. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('RESET', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirmed == true) {
      await DatabaseService.clearAllData();
      await ref.read(tasksProvider.notifier).reload();
      await ref.read(eventsProvider.notifier).reload();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('App has been reset.')));
      }
    }
  }
}
