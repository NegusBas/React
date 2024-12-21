import 'package:uuid/uuid.dart';

class Project {
  final String id;
  final String name;
  final String description;

  Project({
    String? id,
    required this.name,
    required this.description,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
