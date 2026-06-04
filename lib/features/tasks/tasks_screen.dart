import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geronimmo_planner/core/l10n/app_localizations.dart';
import 'package:geronimmo_planner/core/providers/providers.dart';
import 'package:geronimmo_planner/models/task_model.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final allTasks = ref.watch(tasksProvider);
    final query = ref.watch(searchQueryProvider);
    final filtered = allTasks.where((t) {
      if (query.isEmpty) return true;
      return t.title.toLowerCase().contains(query.toLowerCase()) ||
             (t.notes?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tasks),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () => _showTaskForm(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: loc.searchPlaceholder,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(child: Text(loc.noTasks))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final task = filtered[index];
                      return _buildTaskTile(context, ref, task, loc);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskTile(BuildContext context, WidgetRef ref, TaskModel task, AppLocalizations loc) {
    final isDone = task.isCompleted;
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: isDone,
          onChanged: (_) => ref.read(tasksProvider.notifier).toggleComplete(task),
        ),
        title: Text(
          task.title,
          style: TextStyle(decoration: isDone ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text('${loc.priority}: ${loc.category(task.category.name)} • ${task.status.name}'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _showTaskForm(context, existing: task),
        ),
        onTap: () => _showTaskForm(context, existing: task),
      ),
    );
  }

  void _showTaskForm(BuildContext context, {TaskModel? existing}) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final titleCtrl = TextEditingController(text: existing?.title ?? '');
    final notesCtrl = TextEditingController(text: existing?.notes ?? '');
    Priority selectedPriority = existing?.priority ?? Priority.medium;
    Category selectedCategory = existing?.category ?? Category.personal;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(existing == null ? loc.add : loc.edit, style: Theme.of(ctx).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: titleCtrl,
                decoration: InputDecoration(labelText: loc.title),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: InputDecoration(labelText: loc.notesHint),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<Priority>(
                      value: selectedPriority,
                      items: Priority.values.map((p) => DropdownMenuItem(value: p, child: Text(loc.category(p.name)))).toList(),
                      onChanged: (v) => selectedPriority = v!,
                      decoration: const InputDecoration(labelText: 'Priority'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<Category>(
                      value: selectedCategory,
                      items: Category.values.map((c) => DropdownMenuItem(value: c, child: Text(loc.category(c.name)))).toList(),
                      onChanged: (v) => selectedCategory = v!,
                      decoration: const InputDecoration(labelText: 'Category'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(loc.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        final newTask = (existing ?? TaskModel(title: '')).copyWith(
                          title: titleCtrl.text.trim(),
                          notes: notesCtrl.text.trim().isEmpty ? null : notesCtrl.text.trim(),
                          priority: selectedPriority,
                          category: selectedCategory,
                        );
                        ref.read(tasksProvider.notifier).addOrUpdate(newTask);
                        Navigator.pop(context);
                      },
                      child: Text(loc.save),
                    ),
                  ),
                ],
              ),
            ),
            if (existing != null)
              TextButton(
                onPressed: () {
                  ref.read(tasksProvider.notifier).delete(existing.id);
                  Navigator.pop(context);
                },
                child: Text(loc.delete, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
