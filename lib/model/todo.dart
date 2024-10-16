import 'dart:convert';

ToDo toDoFromMap(String str) => ToDo.fromMap(json.decode(str));

String toDoToMap(ToDo data) => json.encode(data.toMap());

class ToDo {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final int isCompleted;

  ToDo({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory ToDo.fromMap(Map<String, dynamic> json) => ToDo(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    isCompleted: json["isCompleted"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "title": title,
    "description": description,
    "isCompleted": isCompleted,
  };
}
