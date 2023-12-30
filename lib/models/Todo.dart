import 'package:flutter/material.dart';

class Todo {
 int userId = 0; // Provide appropriate default values if needed
  int id = 0;
  String title = '';
  bool completed = false;

  Todo({
    required this.userId,
    required this.id, // Initialize the id field in the constructor
    required this.title,
    required this.completed,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] as int;
    id = json['id'] as int;
    title = json['title'] as String;
    completed = json['completed'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }


}