import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geronimmo_planner/core/l10n/app_localizations.dart';
import 'package:geronimmo_planner/core/providers/providers.dart';
import 'package:geronimmo_planner/models/task_model.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final tasks = ref.watch(tasksProvider);
    final overdue = tasks.where((t) => t.isOverdue).toList();
    final todayTasks = tasks.where((t) => 
      t.dueDate != null && 
      t.dueDate!.day == DateTime.now().day &&
      !t.isCompleted
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.dashboard),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _quickAddTask(context, ref),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            loc.today,
            todayTasks.isEmpty
                ? Text(loc.emptyStateGeneral)
                : Column(
                    children: todayTasks.map((t) => _taskCard(context, ref, t)).toList(),
                  ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            loc.overdue,
            overdue.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: overdue.map((t) => _taskCard(context, ref, t, isOverdue: true)).toList(),
                  ),
          ),
          const SizedBox(height: 24),
          _buildSmartCard(context, loc.whatToDoNow, 'Focus on your highest priority overdue task.'),
          _buildSmartCard(context, loc.morningPlan, 'Review your top 3 tasks for today.'),
          _buildSmartCard(context, loc.productivityScore, 'This week: 78% — great job!'),
          _buildSmartCard(context, 'Weekly Review', 'You completed 12 tasks and attended 3 meetings this week.'),
          const SizedBox(height: 40),
          Center(
            child: Text(
              loc.createdBy,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildSmartCard(BuildContext context, String title, String subtitle) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _taskCard(BuildContext context, WidgetRef ref, TaskModel task, {bool isOverdue = false}) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    return Card(
      color: isOverdue ? Colors.red.shade50 : null,
      child: ListTile(
        title: Text(task.title),
        subtitle: task.dueDate != null ? Text(task.dueDate!.toLocal().toString().split(' ')[0]) : null,
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => ref.read(tasksProvider.notifier).toggleComplete(task),
        ),
        onTap: () => _editTask(context, ref, task),
      ),
    );
  }

  void _quickAddTask(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quick Add Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Task title'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                final task = TaskModel(title: controller.text.trim());
                ref.read(tasksProvider.notifier).addOrUpdate(task);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editTask(BuildContext context, WidgetRef ref, TaskModel task) {
    // For demo: simple edit dialog. Full screen form would go here in real version.
    final controller = TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final updated = task.copyWith(title: controller.text);
              ref.read(tasksProvider.notifier).addOrUpdate(updated);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              ref.read(tasksProvider.notifier).delete(task.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
