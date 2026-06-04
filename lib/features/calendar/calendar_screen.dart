import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:geronimmo_planner/core/l10n/app_localizations.dart';
import 'package:geronimmo_planner/core/providers/providers.dart';
import 'package:geronimmo_planner/core/utils/notification_service.dart';
import 'package:geronimmo_planner/models/event_model.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final events = ref.watch(eventsProvider);

    final selectedDay = _selectedDay ?? _focusedDay;
    final dayEvents = events.where((e) =>
      e.start.year == selectedDay.year &&
      e.start.month == selectedDay.month &&
      e.start.day == selectedDay.day
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.calendar),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showEventForm(context, selectedDay),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar<EventModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            onFormatChanged: (format) => setState(() => _calendarFormat = format),
            eventLoader: (day) => events.where((e) =>
              e.start.year == day.year && e.start.month == day.month && e.start.day == day.day).toList(),
            calendarStyle: const CalendarStyle(
              markersMaxCount: 3,
              markerDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: dayEvents.isEmpty
                ? Center(child: Text(loc.noEvents))
                : ListView.builder(
                    itemCount: dayEvents.length,
                    itemBuilder: (ctx, i) {
                      final ev = dayEvents[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: ListTile(
                          leading: Container(
                            width: 12, 
                            color: Color(int.parse(ev.colorHex.replaceAll('#', '0xff'))),
                          ),
                          title: Text(ev.title),
                          subtitle: Text(
                            '${ev.start.hour.toString().padLeft(2, '0')}:${ev.start.minute.toString().padLeft(2, '0')} - '
                            '${ev.end.hour.toString().padLeft(2, '0')}:${ev.end.minute.toString().padLeft(2, '0')}'
                          ),
                          onTap: () => _showEventForm(context, selectedDay, existing: ev),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEventForm(BuildContext context, DateTime day, {EventModel? existing}) {
    final loc = AppLocalizations.of(Localizations.localeOf(context));
    final titleCtrl = TextEditingController(text: existing?.title ?? 'Нова зустріч');
    TimeOfDay startTime = TimeOfDay.fromDateTime(existing?.start ?? DateTime.now());
    int durationMinutes = existing != null 
        ? existing.end.difference(existing.start).inMinutes 
        : 60;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(existing == null ? loc.add + ' ' + loc.event : loc.edit),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(labelText: loc.title),
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: Text('Початок'),
                  subtitle: Text(startTime.format(context)),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );
                    if (picked != null) {
                      setState(() => startTime = picked);
                    }
                  },
                ),
                const SizedBox(height: 8),
                Text('Тривалість: $durationMinutes хв'),
                Slider(
                  value: durationMinutes.toDouble(),
                  min: 15,
                  max: 240,
                  divisions: 15,
                  label: '$durationMinutes хв',
                  onChanged: (v) => setState(() => durationMinutes = v.round()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(loc.cancel)),
            FilledButton(
              onPressed: () async {
                final start = DateTime(
                  day.year, day.month, day.day, 
                  startTime.hour, startTime.minute,
                );
                final end = start.add(Duration(minutes: durationMinutes));

                final event = (existing ?? EventModel(
                  title: '', 
                  start: start, 
                  end: end,
                )).copyWith(
                  title: titleCtrl.text.trim(),
                  start: start,
                  end: end,
                );

                await ref.read(eventsProvider.notifier).addOrUpdate(event);

                // Schedule reminder if needed (example: 15 min before)
                if (event.reminderMinutes != null) {
                  await NotificationService.scheduleReminder(
                    id: event.id.hashCode,
                    title: 'Нагадування: ${event.title}',
                    body: 'Подія починається о ${event.start.hour}:${event.start.minute.toString().padLeft(2,'0')}',
                    scheduledDate: event.start.subtract(Duration(minutes: event.reminderMinutes!)),
                  );
                }

                if (mounted) Navigator.pop(context);
              },
              child: Text(loc.save),
            ),
          ],
        ),
      ),
    );
  }
}
