enum RepeatFrequency { daily, weekly, monthly, yearly, custom }

class Recurrence {
  final RepeatFrequency frequency;
  final int interval; // every N days/weeks etc.
  final DateTime? endDate; // null = never ends
  final List<int>? weekdays; // for weekly: 1=Monday ... 7=Sunday
  final List<int>? monthDays; // for monthly custom

  Recurrence({
    required this.frequency,
    this.interval = 1,
    this.endDate,
    this.weekdays,
    this.monthDays,
  });

  bool get isRecurring => true;

  /// Generate next occurrences starting from baseDate (the original start)
  List<DateTime> generateOccurrences(DateTime baseDate, DateTime from, DateTime to, {int max = 100}) {
    final List<DateTime> occurrences = [];
    DateTime current = baseDate;

    while (occurrences.length < max) {
      if (current.isAfter(to)) break;
      if (!current.isBefore(from)) {
        occurrences.add(current);
      }

      switch (frequency) {
        case RepeatFrequency.daily:
          current = current.add(Duration(days: interval));
          break;
        case RepeatFrequency.weekly:
          current = current.add(Duration(days: 7 * interval));
          break;
        case RepeatFrequency.monthly:
          current = DateTime(current.year, current.month + interval, current.day);
          break;
        case RepeatFrequency.yearly:
          current = DateTime(current.year + interval, current.month, current.day);
          break;
        case RepeatFrequency.custom:
          // Fallback simple daily
          current = current.add(Duration(days: interval));
          break;
      }

      if (endDate != null && current.isAfter(endDate!)) break;
    }
    return occurrences;
  }

  @override
  String toString() {
    return 'Recurrence(${frequency.name},interval:$interval,end:${endDate?.toIso8601String()})';
  }

  static Recurrence? fromString(String? str) {
    if (str == null || str.isEmpty) return null;
    // Very simple parser for stored string
    try {
      if (str.contains('daily')) return Recurrence(frequency: RepeatFrequency.daily);
      if (str.contains('weekly')) return Recurrence(frequency: RepeatFrequency.weekly);
      if (str.contains('monthly')) return Recurrence(frequency: RepeatFrequency.monthly);
      if (str.contains('yearly')) return Recurrence(frequency: RepeatFrequency.yearly);
      return Recurrence(frequency: RepeatFrequency.custom);
    } catch (_) {
      return null;
    }
  }
}
