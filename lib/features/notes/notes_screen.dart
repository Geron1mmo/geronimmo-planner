import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geronimmo_planner/core/db/database_service.dart';
import 'package:geronimmo_planner/core/l10n/app_localizations.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  List<Map<String, dynamic>> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    final notes = await DatabaseService.getAllNotes();
    setState(() {
      _notes = notes;
      _isLoading = false;
    });
  }

  Future<void> _addNote() async {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(loc.quickNote),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(hintText: loc.notesHint),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(loc.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(loc.save),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      await DatabaseService.insertOrUpdateNote({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'content': result,
        'isPinned': 0,
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      });
      await _loadNotes();
    }
  }

  Future<void> _deleteNote(String id) async {
    await DatabaseService.deleteNote(id);
    await _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.notes),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNote,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.note_alt_outlined, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(loc.empty_state_general),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _addNote,
                        child: Text(loc.quickNote),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(note['content'] ?? ''),
                        subtitle: Text(
                          DateTime.parse(note['createdAt']).toLocal().toString().substring(0, 16),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteNote(note['id']),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
