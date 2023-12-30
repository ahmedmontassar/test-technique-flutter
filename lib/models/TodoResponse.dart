import 'package:test_tech/models/Todo.dart';


class TodoResponse{
  final List<Todo> todoList;
  TodoResponse({required this.todoList});

  factory TodoResponse.fromJson(List<dynamic> json){
  return TodoResponse(
    todoList: json.map((i)=>Todo.fromJson(i)).toList()
  );
}
}