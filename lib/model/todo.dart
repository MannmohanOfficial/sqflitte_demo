import 'dart:convert';

ToDo toDoFromMap(String str) => ToDo.fromMap(json.decode(str));

String toDoToMap(ToDo data) => json.encode(data.toMap());

class ToDo {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final int? isCompleted;
  final int priority;

  ToDo({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.isCompleted,
    required this.priority,
  });

  factory ToDo.fromMap(Map<String, dynamic> json) => ToDo(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"] ?? null,
    priority: json["priority"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "title": title,
    "description": description,
    "isCompleted":isCompleted,
    "priority": priority,
  };
}
