import 'package:uuid/uuid.dart';
import 'package:geronimmo_planner/models/recurrence.dart';

enum MeetingType { personal, work, call, online, travel, other }

class EventModel {
  final String id;
  String title;
  DateTime start;
  DateTime end;
  String? location;
  String? description;
  List<String> participants;
  int? reminderMinutes; // null = no reminder, or 5,15,30,60,1440 etc.
  Recurrence? recurrence;
  String colorHex; // e.g. "#3B82F6"
  MeetingType meetingType;
  DateTime createdAt;
  DateTime updatedAt;

  EventModel({
    String? id,
    required this.title,
    required this.start,
    required this.end,
    this.location,
    this.description,
    List<String>? participants,
    this.reminderMinutes,
    this.recurrence,
    this.colorHex = '#3B82F6',
    this.meetingType = MeetingType.personal,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        participants = participants ?? [],
        createdAt = createdAt ?? DateTime.now().toUtc(),
        updatedAt = updatedAt ?? DateTime.now().toUtc();

  Duration get duration => end.difference(start);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'start': start.toUtc().toIso8601String(),
        'end': end.toUtc().toIso8601String(),
        'location': location,
        'description': description,
        'participants': participants.join(';;'),
        'reminderMinutes': reminderMinutes,
        'recurrence': recurrence?.toString(),
        'colorHex': colorHex,
        'meetingType': meetingType.index,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      title: map['title'],
      start: DateTime.parse(map['start']).toLocal(),
      end: DateTime.parse(map['end']).toLocal(),
      location: map['location'],
      description: map['description'],
      participants: (map['participants'] as String? ?? '').split(';;').where((e) => e.isNotEmpty).toList(),
      reminderMinutes: map['reminderMinutes'],
      recurrence: map['recurrence'] != null ? Recurrence.fromString(map['recurrence']) : null,
      colorHex: map['colorHex'] ?? '#3B82F6',
      meetingType: MeetingType.values[map['meetingType'] ?? 0],
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
    );
  }

  EventModel copyWith({
    String? title,
    DateTime? start,
    DateTime? end,
    String? location,
    String? description,
    List<String>? participants,
    int? reminderMinutes,
    Recurrence? recurrence,
    String? colorHex,
    MeetingType? meetingType,
  }) {
    return EventModel(
      id: id,
      title: title ?? this.title,
      start: start ?? this.start,
      end: end ?? this.end,
      location: location ?? this.location,
      description: description ?? this.description,
      participants: participants ?? this.participants,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      recurrence: recurrence ?? this.recurrence,
      colorHex: colorHex ?? this.colorHex,
      meetingType: meetingType ?? this.meetingType,
      createdAt: createdAt,
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
