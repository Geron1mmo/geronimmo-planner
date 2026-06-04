import 'package:flutter_test/flutter_test.dart';
import 'package:geronimmo_planner/models/recurrence.dart';

void main() {
  group('Recurrence Engine', () {
    test('Daily recurrence generates correct dates', () {
      final base = DateTime(2026, 6, 15);
      final rec = Recurrence(frequency: RepeatFrequency.daily, interval: 1);
      final occurrences = rec.generateOccurrences(base, base, base.add(const Duration(days: 5)), max: 10);

      expect(occurrences.length, 6); // base + 5 days
      expect(occurrences.last.day, 20);
    });

    test('Weekly recurrence', () {
      final base = DateTime(2026, 6, 15);
      final rec = Recurrence(frequency: RepeatFrequency.weekly);
      final occurrences = rec.generateOccurrences(base, base, base.add(const Duration(days: 20)));
      expect(occurrences.length, 4);
    });
  });
}
