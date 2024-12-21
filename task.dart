import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String projectId;
  final String name;
  final String description;

  Task({
    String? id,
    required this.projectId,
    required this.name,
    required this.description,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'name': name,
      'description': description,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      projectId: json['projectId'],
      name: json['name'],
      description: json['description'],
    );
  }
}
