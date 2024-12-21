import 'package:uuid/uuid.dart';

class TimeEntry {
  final String id;
  final String projectId;
  final String taskId;
  final double timeSpent;
  final DateTime date;
  final String notes;

  TimeEntry({
    String? id,
    required this.projectId,
    required this.taskId,
    required this.timeSpent,
    required this.date,
    required this.notes,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'taskId': taskId,
      'timeSpent': timeSpent,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      timeSpent: json['timeSpent'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }
}